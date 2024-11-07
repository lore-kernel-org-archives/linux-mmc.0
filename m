Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3B1EF08E;
	Thu,  7 Nov 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979345; cv=fail; b=YlWRfmNIz+tzDd6P5vQvDYAMCtH21JZPAOAysjpJ0s8SB/UY5thV+ryb5FInVqy+6rdnN2TBawDpmVgYyy+LJQJ9QdiPep9hiUpwnuZqO1Ii2KzYH6jbgFuRPnxE3KngydGdDGh8TwKoU2pERrBii/8s008kcyD6oA22NJg2miA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979345; c=relaxed/simple;
	bh=Aw5G6d7FnUpsSnldq/gUhLrDmmZimJpPLoA0NKNSSq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ng8ydGiTJhEs/HTUc7oHNZ5/1WgyE86TcuF9Ow/+RqTaRmpWgCn27I4aYKbojnXlbN7WEieh/uYmeCr0Og0V7FBGA5TVdSs1mV6RIpGcbpYOgckd6wu8Cdco3C3+6l7qHilPFYQIaZc/N5EfAl36AE7ErnEHNDeqIB+ejI9Efvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oZc72Edt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jW6vEw69; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oZc72Edt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jW6vEw69"
X-UUID: 687c74c69cfc11efbd192953cf12861f-20241107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Aw5G6d7FnUpsSnldq/gUhLrDmmZimJpPLoA0NKNSSq0=;
	b=oZc72Edt8xnEsU17gsJ6q35H6tg+Q8nINIQ31/z4vtTeFTEk3zwe3FnVk7aUpCKtddla2FubFeJw5f9GWe0LpKHD7hs9/XYcD29jwDqE2/NhZDTXGrK5ZhaXhLPTCB/LZCCi5RlJsupI6r00lmVrlt02cBRrAz7QnaoxndfY+ig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:e0bba61c-5140-4945-9426-4cb6079948b7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:85c3b506-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 687c74c69cfc11efbd192953cf12861f-20241107
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2082094388; Thu, 07 Nov 2024 19:35:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Nov 2024 19:35:34 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Nov 2024 19:35:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9zNR9U6fpj8G1mhvS73lnlyW8KHtx8qjK+4KC0JbAjEEKtSN1Qej/vjjX42seyPC8Pl3DXyFPNG69G/gTEWdKHPzjdx90bkZThqbnwEZ9fFFbCXxuubYHAMvxN5vZTnryLNX6uZ8FZ3uO9SQh19E4hFGV5PooTj+BekCxiDauULVp5gDZ8sS4yvqwYJSpbSgRh1Irsn9BeuGiedWSC+vYu4jzPDSbN2FRuy8z6diBZsZIpgYv0zc7ki0qS9PxkA7bkXPSuc0/YO5w7lUWsGdgtQintHdrkVBbiTrn5+EVXIFsvvBczwldLXkjOzKvkMQoI9y4FTduRYhBC9hTL7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw5G6d7FnUpsSnldq/gUhLrDmmZimJpPLoA0NKNSSq0=;
 b=OjMvAxZrRJXOUsomPYAcisW25J1THg3EVrjARjqgIrN/6ei0UWSHVgjb2WosrvW2f/eLrP6sXU79ELuMfcGtP8kliy3TJVY52gN/tg7KFR/Y/qbw5bNQIkssDyxI6OF6TTvTDjIcyY3V8rnTBqQ/iOOgQrtx9t8UcYgEEtK41KQKBGx7ANI/wGDmU77MmF8gqHuRLg8/mcgbkA+R9fm5Ha2Uf9dvRUVUPVy6soQKZrnnVo0DPCmHzYTiT9wV5WcDe+ido6fu9B3Fg8syLVK1/olUOoP1Fh5hwiAmALolfWjA+VqyOlNwV8HOaOqFmobyze9NY/tFf804yeYJyiHdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw5G6d7FnUpsSnldq/gUhLrDmmZimJpPLoA0NKNSSq0=;
 b=jW6vEw69iyH7m6kx+V/uY9zLR3aN1yUb1x8d6Ufs5/s3ipO5HphduUAMBzJmcOPsBO4KOhrpPhb0T+D+01qEsL3nJohZ6s1xzhDuNLUz3ww6bn0Ewj6Bp0Xtmzs1GfF5R3g/eVbHXLQqffc9bPgSFmXG6l3mT6JgGodim3XTvCo=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by TYSPR03MB7651.apcprd03.prod.outlook.com (2603:1096:400:411::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 11:35:29 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 11:35:29 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mmc: mtk-sd: Fix error handle of probe function
Thread-Topic: [PATCH] mmc: mtk-sd: Fix error handle of probe function
Thread-Index: AQHbMLb+ODDQwXkbZEySAqTFUX7M/rKrp6oAgAAJMQA=
Date: Thu, 7 Nov 2024 11:35:28 +0000
Message-ID: <8063798fe4c7ef03194c73fe4e0ff3e7384d7f5b.camel@mediatek.com>
References: <20241107014714.24981-1-andy-ld.lu@mediatek.com>
	 <900eb529-9868-4455-8f13-3e6ce6c99983@collabora.com>
In-Reply-To: <900eb529-9868-4455-8f13-3e6ce6c99983@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|TYSPR03MB7651:EE_
x-ms-office365-filtering-correlation-id: 2715d47d-0724-4a9f-ca12-08dcff2047e6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YVIrSWZ6YUVoMDdRVUZrcDc4RFRWa3pXVXdJb3NVNHVKSG5ndU5QZWhleml4?=
 =?utf-8?B?aVUzM1hxeEZEb1BPQ255cVA3SUZuSStvMElKYjRqaCszbXJxOGdwQ2F3VUQ3?=
 =?utf-8?B?WkYzdHdMQXMzR1RIV3FEUitXT3lPSlZ3QWQwSWNjaXFpRndIdzhURWZXeHRo?=
 =?utf-8?B?YURYZTB5bVM0UkZvL2xaK3NabHVtazJNRmhubWRROUJScEIzbi93dnNRSDNX?=
 =?utf-8?B?M0ZWZHE3TDZNWEVCSHc4NGkxaFZTbkxNTzUzMmJHbkxpak1acVFIQ2hqcml3?=
 =?utf-8?B?UWwyR2hzSXZaWDFjaUREUy9RN2dEdU5uT2J5Vzkrc0J0YnhxamNwQmg1Rkx4?=
 =?utf-8?B?SHBna2dDS2h2c3J4YVdVOWhaYmtGMlNNd1UzeEhxYzF2U1FDd1dLV0J3emhE?=
 =?utf-8?B?NVFRY0hRT3QyNnVQZm82ODZaaDlkOW1aWnZ6bmt3cTgvR3l1M2JENU1YQVVG?=
 =?utf-8?B?eWJRaVFRTENBdmRncHVsYjVCL2RvN3FHRlMwUmpma2c4NkJiQlJJbUdzcTdD?=
 =?utf-8?B?dkRMRVFRL2xFcXRHdEtpdDh2a00ydGFKM2Nra1JJNDdWTnhTb21KUXp1RDM5?=
 =?utf-8?B?dkNuaFd6eEhQZElaaU52bmJLd2tjeXUwaktkTzQzbHVtZmJTcU94TXNZRHhO?=
 =?utf-8?B?dDRuaEVTS2ZrbmRSSWVWRlcwUlQ0SVNBNVpBVTl1Q21nWnR6a1lQd01MWCtz?=
 =?utf-8?B?MXI5blBMU1BrNXFEYUJZQ1VOaWlnMVorenp0dkVFQ3JiWTk4SkJrWldjRVNv?=
 =?utf-8?B?UnlSaHZlejMyWVRzQ2tJSGlnQmpPK090dTJ0Z3o4UVlvbGJhUE5WbGRnYWNO?=
 =?utf-8?B?dU8zTXNOQlExVEk3REdHTXc4UGREOUNEdHdFaG5ITEdRck1TcTdtelAvWWFn?=
 =?utf-8?B?K3ZxZWIrYyt3cTQ3bjkza0xDT29ZeFVGZjVod29Zb3NOTGtMNENKUXJPSG5M?=
 =?utf-8?B?QkErVHVlcm53d253WU1MY1lQTUkvYVpVYVpta08xbFRHZDFEMVRmK0UyK1VI?=
 =?utf-8?B?bzNkcGdZZlNaV1dVYXRsVGxUZ1FJTUdUcXZ2NVpYc2JQVWxlT1NSR2tHQXR3?=
 =?utf-8?B?YlBkY1k2UElQVzlWUjF6aDJSL0dRUXI1QkN6dStmbnBxZHFlMk8zUHIvQVNM?=
 =?utf-8?B?ZEl0WkpwbEU0Zy9tNWNvYUI5NWd6OHBWZ1pTanhjOXhHZU9aWnUxbFJWa0xL?=
 =?utf-8?B?TkM4KzFUM2prUmZtV1ZFRTNrOWZyZGFXS29EbEtHOVZzQzRQNzRvazM4NHhO?=
 =?utf-8?B?Q0o2c0RLcGtaanRXY1U5TkFrcWloMndLejNpTlU2dFlKM2YySTN0ekRaT1ha?=
 =?utf-8?B?bWhsSWdqanJJSUgyY0pZbWsraXI0OEZkWlR5VU9LcUFweHMvamFTU2twRmJT?=
 =?utf-8?B?ZVNsMnVubEhUcndwWG5UOVhzSitKRjh1SjZ0ckJaVStjSmJrM2hpNml5cE9x?=
 =?utf-8?B?L0F1VFpkNTMrSytHWitmL1JaTmFZMVBoN2t6NXhSeUtMalBNL1lNQTJURFFk?=
 =?utf-8?B?UmMreWlxc3ZBMVRkT1lEdFVMcE9ndmREdWQ1ZHA1S1Rldko5VlN2blFocm9M?=
 =?utf-8?B?VVY2YUZIY3ZBc2VNNE9PQ2UyaDljcXc1azRMUlNMTXRCbVJMODRMREt6akp3?=
 =?utf-8?B?SGN6UGIwV25hOEpuYjhHYUFoWktjekxwRmNFelJjcUlpSzNsTlMyUWJFVGZn?=
 =?utf-8?B?Z3VPRXpGekQzb2xrS2lEWndKRVZpeGIrYUFpQlpqOHV1aWdudnl0VFpDMkpI?=
 =?utf-8?B?V0FFWEJSSnV4b0FpbVhoVkd4YTF3dmRXZVNkckdCVDEycGxLUUh4T0JxK25P?=
 =?utf-8?Q?CMNFOTY/sCJKlrz+KMXLbcl9EYhfLeVoG64CE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzFZeW92MW1ZRzF3SmE5QXMyTUJxQXBFRGtrSmN1cEMwaGZaK1RoNzFtdzBy?=
 =?utf-8?B?ekRuOWd5TW9TbjVVT29QdjBDVVR1Q3dvUVZMOWdwUmM1NDd0UWtYSy9Da0hZ?=
 =?utf-8?B?bjVSa1dHMXYvaTkwKzVQR3NZTnBTaDd2TVd2OTM4S0xTeStUSFNRalVMSlcw?=
 =?utf-8?B?M0o4WEtFVDBCY3h1QTFhZU8rbnllWkM0N203b0lISVZqWjJ3MndlVlRlSW9p?=
 =?utf-8?B?OERCTDFBTjJ2WFVxRTZJR0xHMEdiMlc0QTR4UGNERXA1bmMyanUrNElBUDJF?=
 =?utf-8?B?eDA3U2c1eGdJSkJZVTlyWmpBVmVQaDk3TW51NHBJTTNIZWZhcmJoMU9TcnRF?=
 =?utf-8?B?YXFDb08vRk82TkVwSkJFUi9hQkVKZWo0TGZ3SlpKSmtjQlNWYmozWWZvS2Zs?=
 =?utf-8?B?Um5FSWVmR3hNd0pTT1ovV0RRNWlmcDA0WVRnNEpaa2Ird1BHSDF2UGJDc21n?=
 =?utf-8?B?SEg2ZFVEeEV1QXExWkoyOGhTTEVyMzVDVk5semowOUVKcWxGa0VBd3dkQWRz?=
 =?utf-8?B?Qzk2czhkOFV4WmdmS01mdXdGdGVucmFqK2dRdXBUemNqTk8xK2NqVEd4V1E3?=
 =?utf-8?B?VnlHOEhkZnJmZElFdTNJRy9VeVNFbzNBVXpDY0MrSU5sWi9rcFZGVGkwc25S?=
 =?utf-8?B?T29GSXBjeWx4aGlIK0RYNWdEd2wzTWlyekoxU1BaY1F4Y1lHU3E5UWdOenBG?=
 =?utf-8?B?Yy9xaklsZlZITm82KzQ4YXpuODUxRnVLNzRTSGZGaWpjQWcwZW53c2NjZ0Ix?=
 =?utf-8?B?NXUxK3pUMTRLL29vT2E0Ym5xbzhBMk9zcXl0OGFJMXZManI0Uk5pN0FKcWxs?=
 =?utf-8?B?NzNUNVhwbk1Oa01GNUdrd3ZhQWxkMXUyWTJ2L2w0aE9UNUpUcXRobGltd2lt?=
 =?utf-8?B?aVNQdVVrcm5VaEh4NXN4QzVDNWMvNVZsT3MrK1BsU3ZTdEE2cGJHb0pJbm5K?=
 =?utf-8?B?YW1rYXpQaU5DelUxNkdIUVhjN1NYRFJ2NHlGTy84akZwN2Q3dnI4UEZsMFZz?=
 =?utf-8?B?OXJxQmtFNGZFNVJBSDBXMGRBN3pCdGJsbDlNellvcDdPdWs4dktPdklGNW02?=
 =?utf-8?B?d0dBallQZkVPZU1jaEVMUDJIdE9hSS9BdEo5elViN1gra0ZXYTduQUpRY2N3?=
 =?utf-8?B?SEIwU1daL0h2WHptQVBwNXlzS21iZGxnUVBqVElvN0lvZHBXeG5SSFZjYnc4?=
 =?utf-8?B?L21LemhsUzNrNDJxL0g4M2VMSTBpdkN6VG8welNIZFN6UHVqRkp5K0JtVHIv?=
 =?utf-8?B?UDJ3RklMMWErMGhyTFNFcXl2M1VKcDdQVWN6YzJJZ000TGE1bUdESTFuL1Yw?=
 =?utf-8?B?VW1hVHZmNUdZaHdxM3BVajVMN09NdzVFQWVwdjNxdWtJSDl2VEZrZ09nQ3Vl?=
 =?utf-8?B?bGtkWEFKYlhLTWhTZlVHZlF5RlVhZmpBUXhTSkQxZERHNEJzeWcvRGZaQXNO?=
 =?utf-8?B?dGZaWGliNzR4azBUQXFHYksxSThIcTZWdlRhenZOWElVUGxnZE1GNG12TXM5?=
 =?utf-8?B?dGFaWFVmMjZDM3lHK2lWQzk4cE1DRS9OYzVYTGtPK1J3czUxK0dBN3NVcWdJ?=
 =?utf-8?B?WnBHOWJmMnVubmEwY3ptdUNCMUpoTW1ycFRmVUcvOUkxUE52QXg2NWtTc2xh?=
 =?utf-8?B?Tm1JeERtOWJrc1hUL2FXOHpUZ2hJWVI1RnFVS014b1ZaM0FIcHRiMElDN1hF?=
 =?utf-8?B?akJlVXlKeGdVaVlTc1ZNcVpOczlpTWxWc0JBanNML1NhalY1UTVFQktrM0tz?=
 =?utf-8?B?bVpFMVB0TFYxMlhNblVSbXhOaXpXbVZaSmRoVUNSUCtWb2I0RjZCbmhkTktj?=
 =?utf-8?B?UlVvYmJNYUx4NzBFMXgrUWc4TDdkd1R0ZjMrbWJCOWRmRHhXZFo4MVBHYkk4?=
 =?utf-8?B?NEJNK2pRbUdhQzVya3NZbTVucXJ6K0hOV2NYYmt6T0J3cWhlNHE1TmRxNTZJ?=
 =?utf-8?B?OEhLdzg4dURYUHFDQXQrMEM5bC93STFhNWhGTTAvazU2dVBmVVNvbmxRbU1Z?=
 =?utf-8?B?YUdaZlQzTmwreE1FTTJkaDNseDI3Zng3VFdKbm9Jd1RNczcvc3pVa0oxZTZ0?=
 =?utf-8?B?QjNhSUhhMGtGR1NIR25pNGRSdXU4T1psNWQyM2h3WVJhTEtvS1RHMUZKazZx?=
 =?utf-8?B?and3MEhDeUFFNytOUEdsSW1MeDBCcjU3YnRGSkx0dlREeGR6dU1vUlNnMzFq?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B440B62B132C194AB8A38F43345AC8DE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2715d47d-0724-4a9f-ca12-08dcff2047e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 11:35:28.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpTt8+8NbtYPQ8Fnnq0gskBg1CYJYphmLAdW2BNmrSAUGV9NX3wxy4IcqSvflmsRpd0bflLJGdhujfRfJwqATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7651
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.606000-8.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2x6hrpRSrYit+Mk6ACsw4JgZbeEWcL03V8tM
	WbtVzWkj2ZGM4F+F3sfGxLQyk54v7h/AoH7/yPHA0JY9d6s3vaZh/evhkKmjqbcPp/oilssjtVh
	6hcCsj0SjRji+Vdlqtv9wUoZUc6lWmo5yuB6yqD1z+axQLnAVBwx0jRRxcQfOGToisPp3j9f0ub
	/xgdoFfAfSGzL9zI3UR4ezsIKMER4jQo/Iw2s1SwCZxkTHxccl9LQinZ4QefKU8D0b0qFy9mTDw
	p0zM3zoqtq5d3cxkNT3zSp73HMHc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.606000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6DB34B7C8DF262F7D66A81A6EA50AA0348DEB17FEA1033CE7B9D2379CB2B3A042000:8

T24gVGh1LCAyMDI0LTExLTA3IGF0IDEyOjAyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwNy8xMS8yNCAwMjo0NywgQW5keS1sZCBM
dSBoYSBzY3JpdHRvOg0KPiA+IEluIHRoZSBwcm9iZSBmdW5jdGlvbiwgaXQgZ29lcyB0byAncmVs
ZWFzZV9tZW0nIGxhYmVsIGFuZCByZXR1cm5zDQo+ID4gYWZ0ZXINCj4gPiBzb21lIHByb2NlZHVy
ZSBmYWlsdXJlLiBCdXQgaWYgdGhlIGNsb2NrcyAocGFydGlhbCBvciBhbGwpIGhhdmUNCj4gPiBi
ZWVuDQo+ID4gZW5hYmxlZCBwcmV2aW91c2x5LCB0aGV5IHdvdWxkIG5vdCBiZSBkaXNhYmxlZCBp
bg0KPiA+IG1zZGNfcnVudGltZV9zdXNwZW5kLA0KPiA+IHNpbmNlIHJ1bnRpbWUgUE0gaXMgbm90
IHlldCBlbmFibGVkIGZvciB0aGlzIGNhc2UuDQo+ID4gDQo+ID4gVGhhdCBjYXVzZSBtbWMgcmVs
YXRlZCBjbG9ja3MgYWx3YXlzIG9uIGR1cmluZyBzeXN0ZW0gc3VzcGVuZCBhbmQNCj4gPiBibG9j
aw0KPiA+IHN1c3BlbmQgZmxvdy4gQmVsb3cgbG9nIGlzIGZyb20gYSBTRENhcmQgaXNzdWUgb2Yg
TVQ4MTk2DQo+ID4gY2hyb21lYm9vaywgaXQNCj4gPiByZXR1cm5zIC1FVElNRU9VVCB3aGlsZSBw
b2xsaW5nIGNsb2NrIHN0YWJsZSBpbiB0aGUNCj4gPiBtc2RjX3VuZ2F0ZV9jbG9jaygpDQo+ID4g
YW5kIHByb2JlIGZhaWxlZCwgYnV0IHRoZSBlbmFibGVkIGNsb2NrcyBjb3VsZCBub3QgYmUgZGlz
YWJsZWQNCj4gPiBhbnl3YXkuDQo+ID4gDQo+ID4gWyAgMTI5LjA1OTI1M10gY2xrX2Noa19kZXZf
cG1fc3VzcGVuZCgpDQo+ID4gWyAgMTI5LjM1MDExOV0gc3VzcGVuZCB3YXJuaW5nOiBtc2RjcGxs
IGlzIG9uDQo+ID4gWyAgMTI5LjM1NDQ5NF0gW2NrX21zZGMzMF8xX3NlbCA6IGVuYWJsZWQsIDEs
IDEsDQo+ID4gMTkxOTk5OTM5LCAgIGNrX21zZGNwbGxfZDJdDQo+ID4gWyAgMTI5LjM2Mjc4N10g
W2NrX21zZGNwbGxfZDIgICA6IGVuYWJsZWQsIDEsIDEsDQo+ID4gMTkxOTk5OTM5LCAgICAgICAg
IG1zZGNwbGxdDQo+ID4gWyAgMTI5LjM3MTA0MV0gW2NrX21zZGMzMF8xX2NrICA6IGVuYWJsZWQs
IDEsIDEsIDE5MTk5OTkzOSwNCj4gPiBja19tc2RjMzBfMV9zZWxdDQo+ID4gWyAgMTI5LjM3OTI5
NV0gW21zZGNwbGwgICAgICAgICA6IGVuYWJsZWQsIDEsIDEsDQo+ID4gMzgzOTk5ODc4LCAgICAg
ICAgICBjbGsyNm1dDQo+ID4gDQo+ID4gQWRkIGEgbmV3ICdyZWxlYXNlX2NsaycgbGFiZWwgYW5k
IHJlb3JkZXIgdGhlIGVycm9yIGhhbmRsZQ0KPiA+IGZ1bmN0aW9ucyB0bw0KPiA+IG1ha2Ugc3Vy
ZSB0aGUgY2xvY2tzIGJlIGRpc2FibGVkIGFmdGVyIHByb2JlIGZhaWx1cmUuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogQW5keS1sZCBMdSA8YW5keS1sZC5sdUBtZWRpYXRlay5jb20+DQo+IA0K
PiBQbGVhc2UgYWRkIHRoZSByZWxldmFudCBGaXhlcyB0YWcsIGFzIHRoaXMgaXMgYSBmaXggYW5k
IHNob3VsZCBiZQ0KPiBiYWNrcG9ydGVkLg0KPiANCj4gQWZ0ZXIgd2hpY2gsIEknbGwgZ2l2ZSB5
b3UgbXkgUi1iLg0KPiANCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldywgSSB3aWxsIGFkZCBpdCBpbiBuZXh0IGNoYW5nZS4NCg0KQmVzdCByZWdhcmRzDQpBbmR5
LWxkIEx1DQo+IA0KDQo=
