(define (problem depotprob5656) (:domain Depot)
(:objects
	depot0 depot1 depot2 depot3 depot4 depot5 depot6 depot7 depot8 depot9 - Depot
	distributor0 distributor1 distributor2 distributor3 distributor4 distributor5 distributor6 distributor7 distributor8 distributor9 - Distributor
	truck0 truck1 truck2 truck3 truck4 truck5 - Truck
	pallet0 pallet1 pallet2 pallet3 pallet4 pallet5 pallet6 pallet7 pallet8 pallet9 pallet10 pallet11 pallet12 pallet13 pallet14 pallet15 pallet16 pallet17 pallet18 pallet19 pallet20 pallet21 pallet22 pallet23 pallet24 pallet25 pallet26 pallet27 pallet28 pallet29 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 crate10 crate11 crate12 crate13 crate14 crate15 crate16 crate17 crate18 crate19 crate20 crate21 crate22 crate23 crate24 crate25 crate26 crate27 crate28 crate29 crate30 crate31 crate32 crate33 crate34 crate35 crate36 crate37 crate38 crate39 crate40 crate41 crate42 crate43 crate44 crate45 crate46 crate47 crate48 crate49 crate50 crate51 crate52 crate53 crate54 crate55 crate56 crate57 crate58 crate59 crate60 crate61 crate62 crate63 crate64 crate65 crate66 crate67 crate68 crate69 crate70 crate71 crate72 crate73 crate74 crate75 crate76 crate77 crate78 crate79 crate80 crate81 crate82 crate83 crate84 crate85 crate86 crate87 crate88 crate89 crate90 crate91 crate92 crate93 crate94 crate95 crate96 crate97 crate98 crate99 crate100 crate101 crate102 crate103 crate104 crate105 crate106 crate107 crate108 crate109 crate110 crate111 crate112 crate113 crate114 crate115 crate116 crate117 crate118 crate119 crate120 crate121 crate122 crate123 crate124 crate125 crate126 crate127 crate128 crate129 crate130 crate131 crate132 crate133 crate134 crate135 crate136 crate137 crate138 crate139 crate140 crate141 crate142 crate143 crate144 crate145 crate146 crate147 crate148 crate149 - Crate
	hoist0 hoist1 hoist2 hoist3 hoist4 hoist5 hoist6 hoist7 hoist8 hoist9 hoist10 hoist11 hoist12 hoist13 hoist14 hoist15 hoist16 hoist17 hoist18 hoist19 hoist20 hoist21 hoist22 hoist23 hoist24 hoist25 hoist26 hoist27 hoist28 hoist29 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate96)
	(at pallet1 depot1)
	(clear crate118)
	(at pallet2 depot2)
	(clear crate100)
	(at pallet3 depot3)
	(clear crate148)
	(at pallet4 depot4)
	(clear crate146)
	(at pallet5 depot5)
	(clear crate137)
	(at pallet6 depot6)
	(clear crate127)
	(at pallet7 depot7)
	(clear crate123)
	(at pallet8 depot8)
	(clear crate115)
	(at pallet9 depot9)
	(clear crate139)
	(at pallet10 distributor0)
	(clear crate95)
	(at pallet11 distributor1)
	(clear crate108)
	(at pallet12 distributor2)
	(clear crate90)
	(at pallet13 distributor3)
	(clear crate134)
	(at pallet14 distributor4)
	(clear crate133)
	(at pallet15 distributor5)
	(clear crate126)
	(at pallet16 distributor6)
	(clear crate40)
	(at pallet17 distributor7)
	(clear crate136)
	(at pallet18 distributor8)
	(clear crate84)
	(at pallet19 distributor9)
	(clear crate135)
	(at pallet20 depot4)
	(clear crate149)
	(at pallet21 depot7)
	(clear crate147)
	(at pallet22 depot3)
	(clear crate132)
	(at pallet23 distributor4)
	(clear crate138)
	(at pallet24 depot9)
	(clear crate119)
	(at pallet25 depot0)
	(clear crate141)
	(at pallet26 depot0)
	(clear crate51)
	(at pallet27 distributor2)
	(clear crate65)
	(at pallet28 depot5)
	(clear crate143)
	(at pallet29 depot7)
	(clear crate124)
	(at truck0 distributor2)
	(at truck1 distributor1)
	(at truck2 distributor9)
	(at truck3 distributor0)
	(at truck4 distributor4)
	(at truck5 distributor4)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 depot1)
	(available hoist1)
	(at hoist2 depot2)
	(available hoist2)
	(at hoist3 depot3)
	(available hoist3)
	(at hoist4 depot4)
	(available hoist4)
	(at hoist5 depot5)
	(available hoist5)
	(at hoist6 depot6)
	(available hoist6)
	(at hoist7 depot7)
	(available hoist7)
	(at hoist8 depot8)
	(available hoist8)
	(at hoist9 depot9)
	(available hoist9)
	(at hoist10 distributor0)
	(available hoist10)
	(at hoist11 distributor1)
	(available hoist11)
	(at hoist12 distributor2)
	(available hoist12)
	(at hoist13 distributor3)
	(available hoist13)
	(at hoist14 distributor4)
	(available hoist14)
	(at hoist15 distributor5)
	(available hoist15)
	(at hoist16 distributor6)
	(available hoist16)
	(at hoist17 distributor7)
	(available hoist17)
	(at hoist18 distributor8)
	(available hoist18)
	(at hoist19 distributor9)
	(available hoist19)
	(at hoist20 depot2)
	(available hoist20)
	(at hoist21 distributor4)
	(available hoist21)
	(at hoist22 depot1)
	(available hoist22)
	(at hoist23 depot6)
	(available hoist23)
	(at hoist24 depot4)
	(available hoist24)
	(at hoist25 distributor5)
	(available hoist25)
	(at hoist26 distributor0)
	(available hoist26)
	(at hoist27 distributor6)
	(available hoist27)
	(at hoist28 depot3)
	(available hoist28)
	(at hoist29 depot6)
	(available hoist29)
	(at crate0 depot0)
	(on crate0 pallet25)
	(at crate1 depot4)
	(on crate1 pallet4)
	(at crate2 distributor0)
	(on crate2 pallet10)
	(at crate3 depot4)
	(on crate3 crate1)
	(at crate4 distributor7)
	(on crate4 pallet17)
	(at crate5 depot3)
	(on crate5 pallet22)
	(at crate6 distributor6)
	(on crate6 pallet16)
	(at crate7 distributor5)
	(on crate7 pallet15)
	(at crate8 distributor8)
	(on crate8 pallet18)
	(at crate9 depot0)
	(on crate9 pallet26)
	(at crate10 distributor2)
	(on crate10 pallet27)
	(at crate11 depot7)
	(on crate11 pallet7)
	(at crate12 distributor4)
	(on crate12 pallet23)
	(at crate13 depot4)
	(on crate13 pallet20)
	(at crate14 distributor6)
	(on crate14 crate6)
	(at crate15 depot0)
	(on crate15 pallet0)
	(at crate16 depot5)
	(on crate16 pallet28)
	(at crate17 distributor2)
	(on crate17 crate10)
	(at crate18 depot3)
	(on crate18 crate5)
	(at crate19 depot3)
	(on crate19 pallet3)
	(at crate20 depot0)
	(on crate20 crate15)
	(at crate21 depot0)
	(on crate21 crate20)
	(at crate22 depot7)
	(on crate22 crate11)
	(at crate23 depot0)
	(on crate23 crate0)
	(at crate24 depot6)
	(on crate24 pallet6)
	(at crate25 distributor2)
	(on crate25 crate17)
	(at crate26 depot0)
	(on crate26 crate21)
	(at crate27 distributor4)
	(on crate27 crate12)
	(at crate28 distributor3)
	(on crate28 pallet13)
	(at crate29 depot6)
	(on crate29 crate24)
	(at crate30 distributor5)
	(on crate30 crate7)
	(at crate31 distributor1)
	(on crate31 pallet11)
	(at crate32 distributor1)
	(on crate32 crate31)
	(at crate33 depot9)
	(on crate33 pallet24)
	(at crate34 distributor1)
	(on crate34 crate32)
	(at crate35 distributor4)
	(on crate35 pallet14)
	(at crate36 depot3)
	(on crate36 crate18)
	(at crate37 depot7)
	(on crate37 pallet29)
	(at crate38 depot0)
	(on crate38 crate26)
	(at crate39 depot0)
	(on crate39 crate23)
	(at crate40 distributor6)
	(on crate40 crate14)
	(at crate41 distributor0)
	(on crate41 crate2)
	(at crate42 depot7)
	(on crate42 crate37)
	(at crate43 distributor1)
	(on crate43 crate34)
	(at crate44 distributor7)
	(on crate44 crate4)
	(at crate45 distributor2)
	(on crate45 pallet12)
	(at crate46 distributor4)
	(on crate46 crate27)
	(at crate47 distributor7)
	(on crate47 crate44)
	(at crate48 depot2)
	(on crate48 pallet2)
	(at crate49 depot9)
	(on crate49 pallet9)
	(at crate50 depot9)
	(on crate50 crate49)
	(at crate51 depot0)
	(on crate51 crate9)
	(at crate52 depot8)
	(on crate52 pallet8)
	(at crate53 depot2)
	(on crate53 crate48)
	(at crate54 depot7)
	(on crate54 pallet21)
	(at crate55 distributor5)
	(on crate55 crate30)
	(at crate56 depot3)
	(on crate56 crate36)
	(at crate57 depot0)
	(on crate57 crate39)
	(at crate58 depot5)
	(on crate58 crate16)
	(at crate59 depot4)
	(on crate59 crate3)
	(at crate60 distributor4)
	(on crate60 crate46)
	(at crate61 distributor8)
	(on crate61 crate8)
	(at crate62 distributor0)
	(on crate62 crate41)
	(at crate63 depot3)
	(on crate63 crate56)
	(at crate64 distributor8)
	(on crate64 crate61)
	(at crate65 distributor2)
	(on crate65 crate25)
	(at crate66 depot0)
	(on crate66 crate57)
	(at crate67 depot7)
	(on crate67 crate42)
	(at crate68 depot4)
	(on crate68 crate13)
	(at crate69 distributor1)
	(on crate69 crate43)
	(at crate70 depot7)
	(on crate70 crate67)
	(at crate71 distributor8)
	(on crate71 crate64)
	(at crate72 depot3)
	(on crate72 crate63)
	(at crate73 distributor3)
	(on crate73 crate28)
	(at crate74 depot4)
	(on crate74 crate68)
	(at crate75 depot6)
	(on crate75 crate29)
	(at crate76 depot5)
	(on crate76 pallet5)
	(at crate77 depot0)
	(on crate77 crate38)
	(at crate78 depot2)
	(on crate78 crate53)
	(at crate79 depot7)
	(on crate79 crate70)
	(at crate80 depot9)
	(on crate80 crate33)
	(at crate81 distributor7)
	(on crate81 crate47)
	(at crate82 depot4)
	(on crate82 crate74)
	(at crate83 depot3)
	(on crate83 crate72)
	(at crate84 distributor8)
	(on crate84 crate71)
	(at crate85 depot7)
	(on crate85 crate54)
	(at crate86 depot1)
	(on crate86 pallet1)
	(at crate87 distributor0)
	(on crate87 crate62)
	(at crate88 depot9)
	(on crate88 crate80)
	(at crate89 distributor5)
	(on crate89 crate55)
	(at crate90 distributor2)
	(on crate90 crate45)
	(at crate91 depot5)
	(on crate91 crate58)
	(at crate92 distributor7)
	(on crate92 crate81)
	(at crate93 depot4)
	(on crate93 crate59)
	(at crate94 depot7)
	(on crate94 crate85)
	(at crate95 distributor0)
	(on crate95 crate87)
	(at crate96 depot0)
	(on crate96 crate77)
	(at crate97 depot4)
	(on crate97 crate93)
	(at crate98 distributor4)
	(on crate98 crate35)
	(at crate99 depot1)
	(on crate99 crate86)
	(at crate100 depot2)
	(on crate100 crate78)
	(at crate101 depot4)
	(on crate101 crate82)
	(at crate102 depot4)
	(on crate102 crate97)
	(at crate103 depot5)
	(on crate103 crate91)
	(at crate104 depot0)
	(on crate104 crate66)
	(at crate105 distributor4)
	(on crate105 crate98)
	(at crate106 depot6)
	(on crate106 crate75)
	(at crate107 depot0)
	(on crate107 crate104)
	(at crate108 distributor1)
	(on crate108 crate69)
	(at crate109 distributor3)
	(on crate109 crate73)
	(at crate110 depot3)
	(on crate110 crate19)
	(at crate111 distributor7)
	(on crate111 crate92)
	(at crate112 depot7)
	(on crate112 crate94)
	(at crate113 depot0)
	(on crate113 crate107)
	(at crate114 distributor9)
	(on crate114 pallet19)
	(at crate115 depot8)
	(on crate115 crate52)
	(at crate116 depot4)
	(on crate116 crate101)
	(at crate117 depot0)
	(on crate117 crate113)
	(at crate118 depot1)
	(on crate118 crate99)
	(at crate119 depot9)
	(on crate119 crate88)
	(at crate120 depot7)
	(on crate120 crate22)
	(at crate121 depot4)
	(on crate121 crate102)
	(at crate122 depot4)
	(on crate122 crate116)
	(at crate123 depot7)
	(on crate123 crate120)
	(at crate124 depot7)
	(on crate124 crate79)
	(at crate125 depot3)
	(on crate125 crate110)
	(at crate126 distributor5)
	(on crate126 crate89)
	(at crate127 depot6)
	(on crate127 crate106)
	(at crate128 distributor3)
	(on crate128 crate109)
	(at crate129 distributor3)
	(on crate129 crate128)
	(at crate130 depot5)
	(on crate130 crate103)
	(at crate131 distributor4)
	(on crate131 crate60)
	(at crate132 depot3)
	(on crate132 crate83)
	(at crate133 distributor4)
	(on crate133 crate105)
	(at crate134 distributor3)
	(on crate134 crate129)
	(at crate135 distributor9)
	(on crate135 crate114)
	(at crate136 distributor7)
	(on crate136 crate111)
	(at crate137 depot5)
	(on crate137 crate76)
	(at crate138 distributor4)
	(on crate138 crate131)
	(at crate139 depot9)
	(on crate139 crate50)
	(at crate140 depot4)
	(on crate140 crate121)
	(at crate141 depot0)
	(on crate141 crate117)
	(at crate142 depot4)
	(on crate142 crate140)
	(at crate143 depot5)
	(on crate143 crate130)
	(at crate144 depot4)
	(on crate144 crate142)
	(at crate145 depot4)
	(on crate145 crate122)
	(at crate146 depot4)
	(on crate146 crate144)
	(at crate147 depot7)
	(on crate147 crate112)
	(at crate148 depot3)
	(on crate148 crate125)
	(at crate149 depot4)
	(on crate149 crate145)
)

(:goal (and
		(on crate0 crate140)
		(on crate1 crate11)
		(on crate3 pallet2)
		(on crate4 crate101)
		(on crate5 crate1)
		(on crate7 crate60)
		(on crate8 crate133)
		(on crate9 pallet4)
		(on crate11 pallet23)
		(on crate12 crate30)
		(on crate13 crate62)
		(on crate14 pallet0)
		(on crate15 crate132)
		(on crate16 crate121)
		(on crate17 crate116)
		(on crate19 crate51)
		(on crate20 crate43)
		(on crate21 crate148)
		(on crate23 crate110)
		(on crate25 crate67)
		(on crate26 pallet5)
		(on crate27 crate20)
		(on crate28 crate44)
		(on crate30 pallet11)
		(on crate31 crate71)
		(on crate32 pallet29)
		(on crate33 crate42)
		(on crate34 pallet27)
		(on crate36 crate81)
		(on crate37 pallet18)
		(on crate38 crate46)
		(on crate39 pallet16)
		(on crate40 crate33)
		(on crate41 pallet12)
		(on crate42 crate9)
		(on crate43 crate5)
		(on crate44 crate64)
		(on crate45 crate52)
		(on crate46 crate61)
		(on crate47 crate8)
		(on crate48 crate34)
		(on crate49 crate146)
		(on crate50 crate48)
		(on crate51 pallet7)
		(on crate52 crate28)
		(on crate53 crate4)
		(on crate55 crate23)
		(on crate56 crate147)
		(on crate58 crate53)
		(on crate60 crate88)
		(on crate61 pallet13)
		(on crate62 crate32)
		(on crate63 crate84)
		(on crate64 pallet9)
		(on crate66 crate104)
		(on crate67 crate91)
		(on crate70 crate14)
		(on crate71 crate124)
		(on crate72 crate117)
		(on crate75 pallet26)
		(on crate76 crate94)
		(on crate77 crate98)
		(on crate79 crate45)
		(on crate80 pallet21)
		(on crate81 crate108)
		(on crate82 pallet14)
		(on crate83 crate70)
		(on crate84 crate86)
		(on crate86 pallet3)
		(on crate87 pallet15)
		(on crate88 crate87)
		(on crate89 crate63)
		(on crate91 crate118)
		(on crate92 crate82)
		(on crate93 crate128)
		(on crate94 crate79)
		(on crate95 crate92)
		(on crate96 pallet20)
		(on crate97 crate77)
		(on crate98 crate138)
		(on crate99 crate112)
		(on crate100 pallet6)
		(on crate101 pallet28)
		(on crate102 crate27)
		(on crate103 crate41)
		(on crate104 crate97)
		(on crate106 pallet8)
		(on crate107 crate16)
		(on crate108 crate129)
		(on crate109 crate17)
		(on crate110 crate39)
		(on crate111 crate75)
		(on crate112 pallet1)
		(on crate114 crate137)
		(on crate115 crate40)
		(on crate116 crate80)
		(on crate117 crate106)
		(on crate118 crate49)
		(on crate120 crate38)
		(on crate121 crate37)
		(on crate123 crate99)
		(on crate124 crate149)
		(on crate127 crate66)
		(on crate128 crate31)
		(on crate129 pallet24)
		(on crate130 crate50)
		(on crate131 crate76)
		(on crate132 crate141)
		(on crate133 pallet10)
		(on crate134 crate96)
		(on crate135 crate100)
		(on crate136 crate19)
		(on crate137 pallet19)
		(on crate138 pallet25)
		(on crate139 crate114)
		(on crate140 pallet17)
		(on crate141 crate26)
		(on crate142 crate139)
		(on crate143 crate130)
		(on crate145 crate107)
		(on crate146 crate3)
		(on crate147 crate127)
		(on crate148 crate15)
		(on crate149 crate135)
	)
))
