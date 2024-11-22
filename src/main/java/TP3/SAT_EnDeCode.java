package TP3;

import fr.uga.pddl4j.heuristics.state.StateHeuristic;
import fr.uga.pddl4j.parser.DefaultParsedProblem;
import fr.uga.pddl4j.parser.RequireKey;
import fr.uga.pddl4j.plan.Plan;
import fr.uga.pddl4j.plan.SequentialPlan;
import fr.uga.pddl4j.planners.AbstractPlanner;
import fr.uga.pddl4j.planners.Planner;
import fr.uga.pddl4j.planners.PlannerConfiguration;
import fr.uga.pddl4j.planners.statespace.search.Node;
import fr.uga.pddl4j.problem.DefaultProblem;
import fr.uga.pddl4j.problem.Problem;
import fr.uga.pddl4j.problem.State;
import fr.uga.pddl4j.problem.operator.Action;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.sat4j.core.VecInt;
import org.sat4j.minisat.SolverFactory;
import org.sat4j.specs.ContradictionException;
import org.sat4j.specs.IProblem;
import org.sat4j.specs.ISolver;
import org.sat4j.tools.ModelIterator;
import picocli.CommandLine;

import java.util.List;

/**
 * The class is an example. It shows how to create a simple A* search planner able to
 * solve an ADL problem by choosing the heuristic to used and its weight.
 *
 * @author D. Pellier
 * @version 4.0 - 30.11.2021
 */
@CommandLine.Command(name = "MTC",
        version = "MTC 1.0",
        description = "Solves a specified planning problem using Monte-Carlo search strategy.",
        sortOptions = false,
        mixinStandardHelpOptions = true,
        headerHeading = "Usage:%n",
        synopsisHeading = "%n",
        descriptionHeading = "%nDescription:%n%n",
        parameterListHeading = "%nParameters:%n",
        optionListHeading = "%nOptions:%n")

public class SAT_EnDeCode extends AbstractPlanner {


    /**
     * The HEURISTIC property used for planner configuration.
     */
    public static final String HEURISTIC_SETTING = "HEURISTIC";

    /**
     * The default value of the HEURISTIC property used for planner configuration.
     */
    public static final StateHeuristic.Name DEFAULT_HEURISTIC = StateHeuristic.Name.FAST_FORWARD;

    /**
     * The WEIGHT_HEURISTIC property used for planner configuration.
     */
    public static final String WEIGHT_HEURISTIC_SETTING = "WEIGHT_HEURISTIC";

    /**
     * The default value of the WEIGHT_HEURISTIC property used for planner configuration.
     */
    public static final double DEFAULT_WEIGHT_HEURISTIC = 1.0;
    /**
     * The class logger.
     */
    private static final Logger LOGGER = LogManager.getLogger(SAT_EnDeCode.class.getName());
    private double heuristicWeight;
    private StateHeuristic.Name heuristic;
    private List dimacs;
    /*
     * Current number of steps of the SAT encoding
     */
    private int steps;

    /**
     * Creates a new A* search planner with the default configuration.
     */
    public SAT_EnDeCode() {
        this(Planner.getDefaultConfiguration());
    }

    /**
     * Creates a new A* search planner with a specified configuration.
     *
     * @param configuration the configuration of the planner.
     */
    public SAT_EnDeCode(final PlannerConfiguration configuration) {
        super();
        this.setConfiguration(configuration);
    }

    /**
     * The main method of the <code>ASP</code> planner.
     *
     * @param args the arguments of the command line.
     */
    public static void main(String[] args) {
        try {
            final SAT_EnDeCode planner = new SAT_EnDeCode();
            CommandLine cmd = new CommandLine(planner);
            cmd.execute(args);
        } catch (IllegalArgumentException e) {
            LOGGER.fatal(e.getMessage());
        }
    }

    private static int pair(int a, int b) {
        return 0;
    }

    private static int[] unpair(int c) {
        return null;
    }

    /**
     * Instantiates the planning problem from a parsed problem.
     *
     * @param problem the problem to instantiate.
     * @return the instantiated planning problem or null if the problem cannot be instantiated.
     */
    @Override
    public Problem instantiate(DefaultParsedProblem problem) {
        final Problem pb = new DefaultProblem(problem);
        pb.instantiate();
        return pb;
    }

    /**
     * Search a solution plan to a specified domain and problem Monte Carlo.
     *
     * @param problem the problem to solve.
     * @return the plan found or null if no plan was found.
     */
    @Override
    public Plan solve(final Problem problem) {
        // Creates the A* search strategy
        LOGGER.info("* Starting SAT Planner \n");
        // Search a solution
        final long begin = System.currentTimeMillis();
        Plan plan = SATEncoderDecoder(problem);
        final long end = System.currentTimeMillis();
        // If a plan is found update the statistics of the planner and log search information
        if (plan != null) {
            LOGGER.info("* SAT Planner succeeded\n");
            this.getStatistics().setTimeToSearch(end - begin);
            long total = this.getStatistics().getTimeToParse() + this.getStatistics().getTimeToSearch() + this.getStatistics().getTimeToEncode();
            System.out.print("|" + total + "|");
            System.out.println(plan.actions().size() + "|");
        } else {
            LOGGER.info("* SAT Planner search failed\n");
        }
        // Return the plan found or null if the search fails.
        return plan;
    }

    /**
     * Returns if a specified problem is supported by the planner. Just ADL problem can be solved by this planner.
     *
     * @param problem the problem to test.
     * @return <code>true</code> if the problem is supported <code>false</code> otherwise.
     */
    @Override
    public boolean isSupported(Problem problem) {
        return !problem.getRequirements().contains(RequireKey.ACTION_COSTS)
                && !problem.getRequirements().contains(RequireKey.CONSTRAINTS)
                && !problem.getRequirements().contains(RequireKey.CONTINOUS_EFFECTS)
                && !problem.getRequirements().contains(RequireKey.DERIVED_PREDICATES)
                && !problem.getRequirements().contains(RequireKey.DURATIVE_ACTIONS)
                && !problem.getRequirements().contains(RequireKey.DURATION_INEQUALITIES)
                && !problem.getRequirements().contains(RequireKey.FLUENTS)
                && !problem.getRequirements().contains(RequireKey.GOAL_UTILITIES)
                && !problem.getRequirements().contains(RequireKey.METHOD_CONSTRAINTS)
                && !problem.getRequirements().contains(RequireKey.NUMERIC_FLUENTS)
                && !problem.getRequirements().contains(RequireKey.OBJECT_FLUENTS)
                && !problem.getRequirements().contains(RequireKey.PREFERENCES)
                && !problem.getRequirements().contains(RequireKey.TIMED_INITIAL_LITERALS)
                && !problem.getRequirements().contains(RequireKey.HIERARCHY);
    }

    /**
     * Returns the name of the heuristic used by the planner to solve a planning problem.
     *
     * @return the name of the heuristic used by the planner to solve a planning problem.
     */
    public final StateHeuristic.Name getHeuristic() {
        return this.heuristic;
    }

    /**
     * Set the name of heuristic used by the planner to the solve a planning problem.
     *
     * @param heuristic the name of the heuristic.
     */
    @CommandLine.Option(names = {"-e", "--heuristic"}, defaultValue = "FAST_FORWARD",
            description = "Set the heuristic : AJUSTED_SUM, AJUSTED_SUM2, AJUSTED_SUM2M, COMBO, "
                    + "MAX, FAST_FORWARD SET_LEVEL, SUM, SUM_MUTEX (preset: FAST_FORWARD)")
    public void setHeuristic(StateHeuristic.Name heuristic) {
        this.heuristic = heuristic;
    }

    /**
     * Returns the weight of the heuristic.
     *
     * @return the weight of the heuristic.
     */
    public final double getHeuristicWeight() {
        return this.heuristicWeight;
    }

    /**
     * Sets the weight of the heuristic.
     *
     * @param weight the weight of the heuristic. The weight must be greater than 0.
     * @throws IllegalArgumentException if the weight is strictly less than 0.
     */
    @CommandLine.Option(names = {"-w", "--weight"}, defaultValue = "1.0",
            paramLabel = "<weight>", description = "Set the weight of the heuristic (preset 1.0).")
    public void setHeuristicWeight(final double weight) {
        if (weight <= 0) {
            throw new IllegalArgumentException("Weight <= 0");
        }
        this.heuristicWeight = weight;
    }

    /**
     * Returns the configuration of the planner.
     *
     * @return the configuration of the planner.
     */
    @Override
    public PlannerConfiguration getConfiguration() {
        final PlannerConfiguration config = super.getConfiguration();
        config.setProperty(SAT_EnDeCode.HEURISTIC_SETTING, this.getHeuristic().toString());
        config.setProperty(SAT_EnDeCode.WEIGHT_HEURISTIC_SETTING, Double.toString(this.getHeuristicWeight()));
        return config;
    }

    /**
     * Sets the configuration of the planner. If a planner setting is not defined in
     * the specified configuration, the setting is initialized with its default value.
     *
     * @param configuration the configuration to set.
     */
    @Override
    public void setConfiguration(final PlannerConfiguration configuration) {
        super.setConfiguration(configuration);
        if (configuration.getProperty(SAT_EnDeCode.WEIGHT_HEURISTIC_SETTING) == null) {
            this.setHeuristicWeight(SAT_EnDeCode.DEFAULT_WEIGHT_HEURISTIC);
        } else {
            this.setHeuristicWeight(Double.parseDouble(configuration.getProperty(
                    SAT_EnDeCode.WEIGHT_HEURISTIC_SETTING)));
        }
        if (configuration.getProperty(SAT_EnDeCode.HEURISTIC_SETTING) == null) {
            this.setHeuristic(SAT_EnDeCode.DEFAULT_HEURISTIC);
        } else {
            this.setHeuristic(StateHeuristic.Name.valueOf(configuration.getProperty(
                    SAT_EnDeCode.HEURISTIC_SETTING)));
        }
    }

    /**
     * Checks the planner configuration and returns if the configuration is valid.
     * A configuration is valid if (1) the domain and the problem files exist and
     * can be read, (2) the timeout is greater than 0, (3) the weight of the
     * heuristic is greater than 0 and (4) the heuristic is a not null.
     *
     * @return <code>true</code> if the configuration is valid <code>false</code> otherwise.
     */
    public boolean hasValidConfiguration() {
        return super.hasValidConfiguration()
                && this.getHeuristicWeight() > 0.0
                && this.getHeuristic() != null;
    }

    /**
     * Extracts a search from a specified node.
     *
     * @param problem the problem.
     * @return the search extracted from the specified node.
     */
    private Plan SATEncoderDecoder(Problem problem) {
        // The solution plan is sequential
        final Plan plan = new SequentialPlan();
        // We get the initial state from the planning problem
        final State init = new State(problem.getInitialState());
        // We get the goal from the planning problem
        final State goal = new State(problem.getGoal());
        // Nothing to do, goal is already satisfied by the initial state
        if (init.satisfy(problem.getGoal())) {
            return plan;
        }
        // Otherwise, we start the search
        else {
            // SAT solver max number of var
            final int MAXVAR = 1000000;
            // SAT solver max number of clauses
            final int NBCLAUSES = 500000;

            ISolver solver = SolverFactory.newDefault();
            int timeout = 3600;
            solver.setTimeout(timeout);
            ModelIterator mi = new ModelIterator(solver);

            // Prepare the solver to accept MAXVAR variables. MANDATORY for MAXSAT solving
            solver.newVar(MAXVAR);
            solver.setExpectedNumberOfClauses(NBCLAUSES);

            // SAT Encoding starts here!
            //final int steps = (int) arguments.get("steps");

            // Feed the solver using Dimacs format, using arrays of int
            for (int i = 0; i < NBCLAUSES; i++) {
                // the clause should not contain a 0, only integer (positive or negative)
                // with absolute values less or equal to MAXVAR
                // e.g. int [] clause = {1, -3, 7}; is fine
                // while int [] clause = {1, -3, 7, 0}; is not fine
                int[] clause = encode(problem, i);
                try {
                    solver.addClause(new VecInt(clause)); // adapt Array to IVecInt
                } catch (ContradictionException e) {
                    System.out.println("SAT encoding failure!");
                    System.exit(0);
                }
            }

            // We are done. Working now on the IProblem interface
            IProblem ip = solver;
            // Finally, we return the solution plan or null otherwise
            return plan;
        }
    }


    private int[] encode(Problem problem, int clause) {
        // We get the operators of the problem
        Action a = problem.getActions().get(clause);
        return new int[]{
                Integer.parseInt(String.valueOf(a.getPrecondition().getPositiveFluents())),
                Integer.parseInt(String.valueOf(a.getUnconditionalEffect().getPositiveFluents())),
                Integer.parseInt(String.valueOf(a.getUnconditionalEffect().getNegativeFluents()))
        };
    }

    private Plan decode(Problem problem) {
        return new SequentialPlan();
    }

    // Extraire le plan final
    private Plan extractPlan(final Node node, final Problem problem) {
        Node n = node;
        final Plan plan = new SequentialPlan();
        while (n.getAction() != -1) {
            final Action a = problem.getActions().get(n.getAction());
            plan.add(0, a);
            n = n.getParent();
        }
        return plan;
    }

    /*
     * SAT encoding for next step
     */
    public List next() {
        return null;
    }
}

