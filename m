Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9581157E88;
	Thu, 16 Jan 2025 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010890; cv=fail; b=XNkNtI2vKw6c0emqGX3+Lf9KbWz5gAKNSI5qEhlWcdY3IMTkwEPHbljRZiZ9t7sU6bDSMx4KbLsR0J8smFiqMF76Aed+BXJrBKHuz8VhruiMkQz7CSKpDJhm2i/5cgRv/rf/9t+zsR/kCYMgOW3v3CzHryBgjV85lBuYA8gXYmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010890; c=relaxed/simple;
	bh=YMxz5eNccZHJw5zYqBLfFY6o7q2TwnyyU2PTb14WKII=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oa1tZR/N+JYc/PG+5QY/BT0Br9GUoU9QYBBiMJNTspM8mEOxSugVnjQBVASuFJiKOVKYz1OOvINugFuympFCwixfAkFuw1LWa1FmdhWLfwJbn7OghtBiRyHZbzYSZCPjZmSEljAJpAJALto2oI/WF9BUjcf46jSHyj5UK9/xAkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BSMxO+ZY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=l1gp9ikf; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BSMxO+ZY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="l1gp9ikf"
X-UUID: af5ab0dad3d711ef99858b75a2457dd9-20250116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=YMxz5eNccZHJw5zYqBLfFY6o7q2TwnyyU2PTb14WKII=;
	b=BSMxO+ZYvF2oiPqyGTXpD9xdyaD+tlgtSbiJEh9wizF+QhNGCKEsxhK0uduyaS6Yw1lLjtwc1gCNbaxxyt4tY0gqGacPl/Fg/yCQIzho7/AQ1WlELms8UmAq+r6hWq1cVAPVVxiVwctDlhN632WAW2V+7kabquZWYruZp2L1hr8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:60d15f3e-751b-4527-b98a-796cb6512196,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:e204fb0e-078a-483b-8929-714244d25c49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: af5ab0dad3d711ef99858b75a2457dd9-20250116
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1336575044; Thu, 16 Jan 2025 15:01:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 Jan 2025 15:01:17 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 16 Jan 2025 15:01:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD4ZnE0SFQd5LFU50TcThB9lyEI7WlRJOLVx/+EzuwBoqtEapsYmU7L0tDjx/PxCGwozU3ZCaRtLOmqdJRsJpoWI5pOCqgnyPv+/A7E0gRCJI6wKCmy4kT6KZMGR1f2TnODUB/S2BEY1dfAt5qHNQ8kkbCgZmFMPD+g3tW47OAXN4VzNQqJUCusOLNfRumSNHTYJcl2o2hsHJDP1E/0grtpTfpsDo6UOMaGC/THRtaOWjPc2WzSBkoj1PqNTWVydeP6JBGvOr0BbqNwmantRoxU/riuv0xHTS9uaceOLWNdr7AXZ6/M1CEkU3o8CidElCFWZFpNUJk5rQFIpSyl9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMxz5eNccZHJw5zYqBLfFY6o7q2TwnyyU2PTb14WKII=;
 b=hg2qXSbhzR2cWq03iScBLzAk97Khj8NudE5ry+aX1hZlA7N5+phHw4rxyJVBtwN36YNpP0hrzVLezI63S4DE34q7eaaaIZolJBhzYx/+6WpdgiJ+I7aUfPaolLc6GXJ09z+sSqnQ9tQj9RtPdB1VrlXpcUd3aoGqlo75ozeui/D0694pgkfrZCuObf0RNbIbCzVrbMeQJHqcxkLvUzYBA8krr8p6XOjjsLirGsGvAUqZ6MAuYfYSTPjTISriIUkcEQcraNRsAc2ADfo7kQ0Qxtuo+Mg6GKJkTOMoGMG6eLXzfrgkczywmZy7SO8ylEnvEy7eMmzrUFEl+C7ylma2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMxz5eNccZHJw5zYqBLfFY6o7q2TwnyyU2PTb14WKII=;
 b=l1gp9ikfZqeMLZeGf/Yl+GWoieBURc4n0CHPRlXSGnGiQRY6MHA+gvi7AUM8zBujFBHfXJJrOwx+tTu9Mo7ZJ2GadnrcWO3JGqMpR7EHhANNNHkch149TiexkHgnZFWO5KELsspNu2j+L1yWq5+qVm3QuQ5hx1jyYzKfGMojXtI=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by SEZPR03MB8780.apcprd03.prod.outlook.com (2603:1096:101:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 16 Jan
 2025 07:01:14 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 07:01:13 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Thread-Topic: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Thread-Index: AQHbZ8RDxfMK8AnxDEeTry1MKcHJqLMY+U8A
Date: Thu, 16 Jan 2025 07:01:13 +0000
Message-ID: <9e022bf13354f544962491cf8061ff3edb878c30.camel@mediatek.com>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
	 <20250115073026.31552-2-ansuelsmth@gmail.com>
In-Reply-To: <20250115073026.31552-2-ansuelsmth@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|SEZPR03MB8780:EE_
x-ms-office365-filtering-correlation-id: 5a3e6a01-c422-4f01-e0d7-08dd35fb9062
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SVk0K2ZTamRQQ2pENmhRZjh4ZStxTExnaXc1eVVnL0krM1pOam9QOXNFOGlC?=
 =?utf-8?B?THBSZkt5VFJZRkR4dGpLS0p4eWREWGkySVAxamtnSEdTaGJQOHJFV3A0QTVM?=
 =?utf-8?B?Z0FQMmdjR0Nabml6aXN6YWtYTlJScElrWGpBckk1ZmNvQ04rbWJMUHNVQkt1?=
 =?utf-8?B?QVpmRERiZWN4S2hESm90YkFRaUJtem1VbjUyanFTVWJzeng4UjRlbjViYklV?=
 =?utf-8?B?RDNpZHhVd1lIQkNtT2FBMlVxbWRMR3JLcUVxbEVvQ3ZFRTFsaGV5cTN5UFZB?=
 =?utf-8?B?SWYwb2V2UUFzMnhNUXJaOTJXSVl5K1lhQWR0TGZxQ1pUNmlnZkJCbDVJek5O?=
 =?utf-8?B?cXhrdFd6cnJ0TjVuQitaYS9kbHJjTzYwbVFwVHFsdHBxUjhxNkllbDFWZnlT?=
 =?utf-8?B?Z3E4WGNiSGFUbzdueEJMNHdObFRIL3dXQmlHNUNtZUw4MDdYNFdjb1V0Y0Fn?=
 =?utf-8?B?eHNkb1k5MlZLUjhBSVpSMmc3RmcwaHUxMnBDb1hIMEM0U1kyRzhReUNxY3Mx?=
 =?utf-8?B?dUV4Wmp2NkFycFJjRERHY2JjM1IvVk5GWi93b1M5anJGNjZIVVdRcytieHRa?=
 =?utf-8?B?SEgzdTR6UzBFSUg4emhOK0xINjArV2t1dGw1Z1ZKOXlMK1VpaTJYbGtjVHIx?=
 =?utf-8?B?MzEzU1EwMFFoaXBPUGtFa0ZQUE9wMmQvbXJzVVN0ZXNJSG44WElNNUluclRO?=
 =?utf-8?B?T1RPbjF6ZFVVSXJ1WlV1NHJiZ2pqWVY1c3VhOTR5TndZRWE2VEllc0wraGVx?=
 =?utf-8?B?SFkwMk5BckdidWFZWVFFZkErNStiRVV5cGhodVJuZVA1Y2dtc1pmSTBlSTQv?=
 =?utf-8?B?djFvZmVKSDFodmRFNmppVXc0YUdEUnlWNmNFNTc4S2U0dEJ0eGRjNUFHUjZl?=
 =?utf-8?B?SE1DeVEwZzdXZDVNQUlORk5QWmZiTytTVW8yMkM2cS9lVkJmYUsyaHVadnZr?=
 =?utf-8?B?bXovWCt1RldKa1FFd0JoZ1FnaWtiSzJucCtUREYya3dqSXJhWnZpSUhxdlhS?=
 =?utf-8?B?WjhYcFA0YXpKWnRvbnd6dlo4enAzN0JzbC9vTUlvdURBSFhSNjJNL0NHejFT?=
 =?utf-8?B?VGc4T1RMOExpcnlDejNTbkYvcFVpOEE0Z0dIcFRGT05TK3hjQkZhT3J1Tmxj?=
 =?utf-8?B?TWd6djR0akgxSjFnNVMrai82NXBXQXJIS0ViQ0tQYXVyOVhBN00zSjd0WFFi?=
 =?utf-8?B?TXd0czl5SmRJbHZrVmZybEhRZDJlUG4wUVFvYXVZM3M1NXNUaEdlV3dISkUr?=
 =?utf-8?B?THVOSEtNdHZwOERNUjFOL21CM3d5em4ra3cwdGpQaE9vTUIvVzQ5UCtXQkVn?=
 =?utf-8?B?WUxUVkxjczVGbTBIUXlWYWpGUjk2R2xleUNoaDA4ZHBxOWh1TmNVSkhtU0FM?=
 =?utf-8?B?dCswL2tFakQwdVpCd1Q4QUdqMEMzREhkcFgzeU9XZDBQS3ZoeDc0bUNuZUU0?=
 =?utf-8?B?Sk8yanMzbml0T3U3V3pBTVpnUXJxQ3NNVHdRYzJwNTJiMHRzdlQ2NkR4RVpZ?=
 =?utf-8?B?YzY4VXhPL2FCc2FXQkpWOEdWdGZYemgxa3FTalZ4NWNNRmsrMlN2M0hUYmRN?=
 =?utf-8?B?SHZ0SlAySTBTWGRBM2o5UjdIUW5oM256aTI2TGRoMG1ETTdaUzRzcUtmd2o0?=
 =?utf-8?B?K0ZzOUU3WGMyRnJLSk81TFNKVThMQWN0WGV4RmdjcTJHUDgwZzFscElGeVI1?=
 =?utf-8?B?LzBmdWZmWEJiOGdPS3Rjcmc2ejA4aTVwajBkaWl6TGFyYjExY204UGtwV0xo?=
 =?utf-8?B?d0hJaWlRUEo5MXJrdmUzbjNnR2wydGRYalE2OWdDNW5ZeHBRKzB3NVBOQU1v?=
 =?utf-8?B?Wm51UGtSaVdRMmJQSEFOTmRGVDYzaEk2RmR4N0hXMHF3Q3l3ZnFNNG4vUXBz?=
 =?utf-8?B?Z2FwcGVpMjF2bUhCVEJCZXJWZy9hZEVLeWRiRXJFanNCTkpsUWdQbmRZcEFj?=
 =?utf-8?B?WFVKSm41VFBkUjFsQllGUkwxN2FoYkRXRTdxVjZHdEQyd0dIMHVwWnhrMTl2?=
 =?utf-8?B?Umh6MENScnVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlJUOXZlcHRsVDFJeUNyNFFVaWNWdVNGanAvZkhibmdETElVbEM0VmViZnRS?=
 =?utf-8?B?bzlqUEw1UU9aUm1CWndzdGhsR0MwN3o2UThiMzhrMGx6dkhkWVhnNk1YR0hm?=
 =?utf-8?B?N0lOOFk2KzF5M0pNNHFnMURHZFEyYkhsTytOUVRLQTZDMFpLZ3ppRVFISW9L?=
 =?utf-8?B?UVArOGxMbm5aWER6dWxNaldxQWtwOXdsK1RkUzVBWTRWNCtHUmNqYlZ5VHlz?=
 =?utf-8?B?N3hUSnVoWXRzblJmWWVHWjI3MDV2Zkw1RDQ1UGE3cVZnMWU2UkRaQmQ2NVgr?=
 =?utf-8?B?Mmx4VkREdFhHL2NSdGF5MUdJRis1dFI5dUt5QUx0Q2NvUWtxM2dRZUdRZ0NM?=
 =?utf-8?B?TU5pM21rbHNudzVNYVRyUU5EVStJZVAyY2VhblptMnZUVmRVN3Q0cVNmK291?=
 =?utf-8?B?OEErcDlyVW04Y0x6ZlBnUkpqMTVFWENYdEp1cWxBQnZhOHlvdTJWU1dmeUxh?=
 =?utf-8?B?N3RyU1RxZHR2SENjSm4yV3I2R1cyS29rbGlJZWJwTlNNVVppdFJrWkRDUlR3?=
 =?utf-8?B?eUM3N2N1d3RCSFEwSGdoRHFsWnltelBLdnhKYm1FbXpOeWVlUFkxOFNWa1Rz?=
 =?utf-8?B?M2JyUENiRHhsemxVOGRPdVE1MXYzYjFCWkx3bmU2ZFRLT0dJQ0k3WllieGE1?=
 =?utf-8?B?Yjk3TXpGdzVTRmdjSnkwbGljdlJKNVNwNk5Sc3VqcnpVQjBFYXZKcS9jbzJ6?=
 =?utf-8?B?ZWMzZ2gzNFluR3hPUElTRWNHeHN4SEdaV0VzVCt5UWgxSUlEdlNHaDZQMnBp?=
 =?utf-8?B?NWd6ODNSTm5ENU41dlE0U2tJNnVKRkVFMW5KQWxEN0xyOGJFWG1lSUNyaXRQ?=
 =?utf-8?B?VjBGbXRubHY5L2RIdVVKR3htbS9mOHJTbFl4b1hKdU9mZk9BdFJpVjUwcEtr?=
 =?utf-8?B?MDBVSmsrTmZ4YlJrWk1yZjVlMEdOMVRXZE1zVSsvWVIxWVcrTlhwOFN5SDYr?=
 =?utf-8?B?eFkvQ3hJYXZVa1lZelZpN3Q1QTM4VVNPRFJZN0RGRnFZdUJtR0dWbjVtMnJI?=
 =?utf-8?B?MDllSGNHSmpjbmlFK2hhN3RsZiszMlcwQUVzRmNOVFhEd0RRQzVtR29CZHhW?=
 =?utf-8?B?c0xuQmFnN3hVOURtS1ZkcjhuUVdsSHFyMnluQnBjbkxjZGYwVEtOb0ZUVFIv?=
 =?utf-8?B?U3VnYmJPNEFiRE5VMDdQUDQ5Z2FlQjNyV0xSQmQ3MEFLOEdYNDdOTyt3bldW?=
 =?utf-8?B?QXNvSElGeHBvTU43NWd0U251dTR2RVFOelJTK1U5eTQ0QnhQYUpyYyswTDZG?=
 =?utf-8?B?aUJ0eTNwbE5Gc3ZySzk0QzRTNmNJMDRYa3dGYzVoWjk3NkQ1Uy9ubjJnVE5S?=
 =?utf-8?B?VSt1cVBlSTNMMnF3L252S1hnVTcvVnR4OGZTaTc5cUQrejF3OXNPKzhNdmZM?=
 =?utf-8?B?Q0w2c0R1QmY4bEJUWGtaQ0Ftb0NRaUh2Si92b3JFWlRPam9kQVpNdHlZM0J0?=
 =?utf-8?B?WXgvMmtGK3EzTkNHWjVUM2M1R0Erdm5mRG5ZamRUMmFad29yaEVrZFduVmVr?=
 =?utf-8?B?dTRyZlJXejZROXBCOVQ3YlZCcjlUSWlucUR1KytCRkttd3Z6R084dzAzcURH?=
 =?utf-8?B?Y3Mwdll2NE1mMnlkL1dCV1RvdytCcW4relZPTVpHdVMxeEI2T0hKNFB3aGY2?=
 =?utf-8?B?R3dQRExHNzJRaFU1aXJDdGJSM1pNekxHVXVFK3RaU1J2VkFFUE4xQUFDU3NO?=
 =?utf-8?B?c1Z0WnprazNhRU5XVTdTU0hoVTdGSEZpVG1WWjJLalBNRXZ2U0tQSTN2aXBN?=
 =?utf-8?B?WTF0WVFDc1JLTHFjSUt3R2swVjZOWEhTT3poSTJDMW12U0cyWWF6eXExQWpk?=
 =?utf-8?B?QTJRaGRhSFlnWjZjNUxyWkFLMWhMWFpaYkg1YisyeFY4QTViUXpIWGFkMjBw?=
 =?utf-8?B?MWxqdnBPNWZ4d2l5UHFCTzVzQk9ZNnBhcnYxMitwODBZM0VaeUs5VUZENGdU?=
 =?utf-8?B?SHVGVUYwelFpY25MdHpOeHJjTkJRdkYzQ1hwS1pkaDFmZUhkSWNKUEs4c0ND?=
 =?utf-8?B?N0VHMDR2RG85bm8zR25WNEFIdXYrMC9YaWZ0N01WWjNpSkJpbHREeDc0dHY3?=
 =?utf-8?B?TUZnMWFTUThRcEJRUTJnNnFJWngxL2o0U2FRSGtHb2wzTUJ4bzl4TWlJNWhw?=
 =?utf-8?B?Y2xBU2YzZnZ5UnE0YjYyOXBUaG5vRDllbzc1V2k0cEppZ2l4MllFYjFvWnNT?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A53A838A0F09A49AF4B75C5E20779BD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3e6a01-c422-4f01-e0d7-08dd35fb9062
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 07:01:13.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uk/t/kaNSkh+UWYUr91/bqVYwHoo2N73MIAHpHknIOhtwARusof/wp4/BK2wOjVslAU0CabokhwSQi099XkLOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8780

T24gV2VkLCAyMDI1LTAxLTE1IGF0IDA4OjI5ICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gQWRkIHN1cHBvcnQgZm9yIEFONzU4MSBNTUMgSG9zdC4gVGhlIE1NQyBIb3N0IGNvbnRy
b2xsZXIgaXMgYmFzZWQgb24NCj4gbXQ3NjIyIHdpdGggdGhlIGRpZmZlcmVuY2Ugb2Ygbm90IGhh
dmluZyByZWd1bGF0b3Igc3VwcGx5IGFuZA0KPiBzdGF0ZV91aHMNCj4gcGlucyBhbmQgaGNsayBj
bG9jay4NCj4gDQo+IFNvbWUgbWlub3IgZml4ZXMgYXJlIGFwcGxpZWQgdG8gY2hlY2sgaWYgdGhl
IHN0YXRlX3VocyBwaW5zIGFyZQ0KPiBkZWZpbmVkDQo+IGFuZCBtYWtlIGhjbGsgb3B0aW9uYWwg
Zm9yIHRoZSBuZXcgYWlyb2hhIGNvbXBhdGlibGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gTWFyYW5naSA8YW5zdWVsc210aEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9t
bWMvaG9zdC9tdGstc2QuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2
ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+IGluZGV4IGVmYjBkMmQ1NzE2Yi4uOWQ2ODY4ODgzYzkx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ICsrKyBiL2RyaXZl
cnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gQEAgLTY2Niw2ICs2NjYsMjAgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfbW1jX2NvbXBhdGlibGUNCj4gbXQ4MTk2X2NvbXBhdCA9IHsNCj4gIAkuc3Vw
cG9ydF9uZXdfcnggPSB0cnVlLA0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfbW1jX2NvbXBhdGlibGUgYW43NTgxX2NvbXBhdCA9IHsNCj4gKwkuY2xrX2Rpdl9iaXRzID0g
MTIsDQo+ICsJLnJlY2hlY2tfc2Rpb19pcnEgPSB0cnVlLA0KPiArCS5oczQwMF90dW5lID0gZmFs
c2UsDQo+ICsJLnBhZF90dW5lX3JlZyA9IE1TRENfUEFEX1RVTkUwLA0KPiArCS5hc3luY19maWZv
ID0gdHJ1ZSwNCj4gKwkuZGF0YV90dW5lID0gdHJ1ZSwNCj4gKwkuYnVzeV9jaGVjayA9IHRydWUs
DQo+ICsJLnN0b3BfY2xrX2ZpeCA9IHRydWUsDQo+ICsJLnN0b3BfZGx5X3NlbCA9IDMsDQo+ICsJ
LmVuaGFuY2VfcnggPSB0cnVlLA0KPiArCS5zdXBwb3J0XzY0ZyA9IGZhbHNlLA0KPiArfTsNCj4g
Kw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXNkY19vZl9pZHNbXSA9IHsN
Cj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1tbWMiLCAuZGF0YSA9ICZtdDI3
MDFfY29tcGF0fSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi1tbWMiLCAu
ZGF0YSA9ICZtdDI3MTJfY29tcGF0fSwNCj4gQEAgLTY4MCw3ICs2OTQsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBtc2RjX29mX2lkc1tdID0NCj4gew0KPiAgCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLW1tYyIsIC5kYXRhID0gJm10ODE4M19jb21wYXR9LA0K
PiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk2LW1tYyIsIC5kYXRhID0gJm10ODE5
Nl9jb21wYXR9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4NTE2LW1tYyIsIC5k
YXRhID0gJm10ODUxNl9jb21wYXR9LA0KPiAtDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhaXJvaGEs
YW43NTgxLW1tYyIsIC5kYXRhID0gJmFuNzU4MV9jb21wYXR9LA0KPiAgCXt9DQo+ICB9Ow0KPiAg
TU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXNkY19vZl9pZHMpOw0KPiBAQCAtMTYwMCw2ICsxNjE0
LDEwIEBAIHN0YXRpYyBpbnQgbXNkY19vcHNfc3dpdGNoX3ZvbHQoc3RydWN0DQo+IG1tY19ob3N0
ICptbWMsIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+ICAJc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9
IG1tY19wcml2KG1tYyk7DQo+ICAJaW50IHJldDsNCj4gIA0KPiArCS8qIFNraXAgc2V0dGluZyBz
dXBwbHkgaWYgbm90IHN1cHBvcnRlZCAqLw0KPiArCWlmICghbW1jLT5zdXBwbHkudnFtbWMpDQo+
ICsJCXJldHVybiAwOw0KPiArDQpIaSBDaHJpc3RpYW4sDQoNCkkgdGhpbmsgaGVyZSBpcyBubyBu
ZWVkLiBJZiB5b3UgaGF2ZSBub3QgJ3ZxbW1jJyBpbiB0aGUNCmR0cywgSVNfRVJSKG1tYy0+c3Vw
cGx5LnZxbW1jKSB3b3VsZCBiZSAtRU5PREVWIGFuZCB0aGUgY29ycmVzcG9uZGluZw0KZmxvdyB3
b3VsZCBub3QgYmUgZXhlY3V0ZWQuDQoNCkFuZCBhbm90aGVyIHF1ZXN0aW9uLCBob3N0LT5waW5z
X2RlZmF1bHQgaXMganVzdCBzZWxlY3RlZCBoZXJlLCB0aGF0DQp3b3VsZCBiZSBsb3N0Lg0KIA0K
PiAgCWlmICghSVNfRVJSKG1tYy0+c3VwcGx5LnZxbW1jKSkgew0KPiAgCQlpZiAoaW9zLT5zaWdu
YWxfdm9sdGFnZSAhPSBNTUNfU0lHTkFMX1ZPTFRBR0VfMzMwICYmDQo+ICAJCSAgICBpb3MtPnNp
Z25hbF92b2x0YWdlICE9IE1NQ19TSUdOQUxfVk9MVEFHRV8xODApIHsNCj4gQEAgLTE2OTksNyAr
MTcxNyw5IEBAIHN0YXRpYyB2b2lkIG1zZGNfZW5hYmxlX3NkaW9faXJxKHN0cnVjdA0KPiBtbWNf
aG9zdCAqbW1jLCBpbnQgZW5iKQ0KPiAgCQkJCWRldl9kYmcoaG9zdC0+ZGV2LCAiU0RJTyBlaW50
IGlycToNCj4gJWQhXG4iLCBob3N0LT5laW50X2lycSk7DQo+ICAJCQl9DQo+ICANCj4gLQkJCXBp
bmN0cmxfc2VsZWN0X3N0YXRlKGhvc3QtPnBpbmN0cmwsIGhvc3QtDQo+ID5waW5zX3Vocyk7DQo+
ICsJCQkvKiBTa2lwIHNldHRpbmcgdWhzIHBpbnMgaWYgbm90IHN1cHBvcnRlZCAqLw0KPiArCQkJ
aWYgKGhvc3QtPnBpbnNfdWhzKQ0KPiArCQkJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGhvc3QtPnBp
bmN0cmwsDQo+IGhvc3QtPnBpbnNfdWhzKTsNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCWRldl9wbV9j
bGVhcl93YWtlX2lycShob3N0LT5kZXYpOw0KPiAgCQl9DQo+IEBAIC0yMDM2LDYgKzIwNTYsMTAg
QEAgc3RhdGljIHZvaWQgbXNkY19vcHNfc2V0X2lvcyhzdHJ1Y3QgbW1jX2hvc3QNCj4gKm1tYywg
c3RydWN0IG1tY19pb3MgKmlvcykNCj4gIA0KPiAgCW1zZGNfc2V0X2J1c3dpZHRoKGhvc3QsIGlv
cy0+YnVzX3dpZHRoKTsNCj4gIA0KPiArCS8qIFNraXAgcmVndWxhdG9yIGlmIG5vdCBzdXBwb3J0
ZWQgKi8NCj4gKwlpZiAoIW1tYy0+c3VwcGx5LnZtbWMpDQo+ICsJCWdvdG8gc2tpcF9yZWd1bGF0
b3I7DQo+ICsNCk5vIG5lZWQgdG9vLg0KDQo+ICAJLyogU3VzcGVuZC9SZXN1bWUgd2lsbCBkbyBw
b3dlciBvZmYvb24gKi8NCj4gIAlzd2l0Y2ggKGlvcy0+cG93ZXJfbW9kZSkgew0KPiAgCWNhc2Ug
TU1DX1BPV0VSX1VQOg0KPiBAQCAtMjA3MSw2ICsyMDk1LDcgQEAgc3RhdGljIHZvaWQgbXNkY19v
cHNfc2V0X2lvcyhzdHJ1Y3QgbW1jX2hvc3QNCj4gKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykN
Cj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICtza2lwX3JlZ3VsYXRvcjoNCj4gIAlpZiAoaG9z
dC0+bWNsayAhPSBpb3MtPmNsb2NrIHx8IGhvc3QtPnRpbWluZyAhPSBpb3MtPnRpbWluZykNCj4g
IAkJbXNkY19zZXRfbWNsayhob3N0LCBpb3MtPnRpbWluZywgaW9zLT5jbG9jayk7DQo+ICB9DQo+
IEBAIC0yODE2LDkgKzI4NDEsMTIgQEAgc3RhdGljIGludCBtc2RjX29mX2Nsb2NrX3BhcnNlKHN0
cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ICAJaWYgKElTX0VSUihob3N0LT5zcmNf
Y2xrKSkNCj4gIAkJcmV0dXJuIFBUUl9FUlIoaG9zdC0+c3JjX2Nsayk7DQo+ICANCj4gLQlob3N0
LT5oX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiaGNsayIpOw0KPiAtCWlmIChJU19F
UlIoaG9zdC0+aF9jbGspKQ0KPiAtCQlyZXR1cm4gUFRSX0VSUihob3N0LT5oX2Nsayk7DQo+ICsJ
LyogQU43NTgxIFNvQyBkb2Vzbid0IGhhdmUgaGNsayAqLw0KPiArCWlmICghZGV2aWNlX2lzX2Nv
bXBhdGlibGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1jIikpIHsNCj4gKwkJaG9zdC0+
aF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImhjbGsiKTsNCj4gKwkJaWYgKElTX0VS
Uihob3N0LT5oX2NsaykpDQo+ICsJCQlyZXR1cm4gUFRSX0VSUihob3N0LT5oX2Nsayk7DQo+ICsJ
fQ0KZGV2bV9jbGtfZ2V0X29wdGlvbmFsIGNvdWxkIGJlIHVzZWQgdG8gaW5zdGVhZCBoZXJlLCBu
byBuZWVkIHRvIHVzZQ0KY29tcGF0aWJsZSB0byBkaXN0aW5ndWlzaC4NCg0KPiAgCWhvc3QtPmJ1
c19jbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImJ1c19jbGsiKTsNCj4g
IAlpZiAoSVNfRVJSKGhvc3QtPmJ1c19jbGspKQ0KPiBAQCAtMjkyNiwxMCArMjk1NCwxMyBAQCBz
dGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAJCXJldHVybiBQVFJfRVJSKGhvc3QtPnBpbnNfZGVmYXVsdCk7DQo+ICAJfQ0KPiAgDQo+
IC0JaG9zdC0+cGluc191aHMgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShob3N0LT5waW5jdHJsLA0K
PiAic3RhdGVfdWhzIik7DQo+IC0JaWYgKElTX0VSUihob3N0LT5waW5zX3VocykpIHsNCj4gLQkJ
ZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3RybCB1aHMhXG4iKTsNCj4gLQkJ
cmV0dXJuIFBUUl9FUlIoaG9zdC0+cGluc191aHMpOw0KPiArCS8qIEFONzU4MSBkb2Vzbid0IGhh
dmUgc3RhdGVfdWhzIHBpbnMgKi8NCj4gKwlpZiAoIWRldmljZV9pc19jb21wYXRpYmxlKCZwZGV2
LT5kZXYsICJhaXJvaGEsYW43NTgxLW1tYyIpKSB7DQo+ICsJCWhvc3QtPnBpbnNfdWhzID0gcGlu
Y3RybF9sb29rdXBfc3RhdGUoaG9zdC0+cGluY3RybCwNCj4gInN0YXRlX3VocyIpOw0KPiArCQlp
ZiAoSVNfRVJSKGhvc3QtPnBpbnNfdWhzKSkgew0KPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LCAi
Q2Fubm90IGZpbmQgcGluY3RybA0KPiB1aHMhXG4iKTsNCj4gKwkJCXJldHVybiBQVFJfRVJSKGhv
c3QtPnBpbnNfdWhzKTsNCj4gKwkJfQ0KPiAgCX0NCkNvdWxkIHlvdSBjb25zaWRlciB0byBzZXQg
YSBkdW1teSAnc3RhdGVfdWhzJyBzYW1lIGFzICdzdGF0ZV9kZWZhdWx0Jw0KaW4gdGhlIGR0cywg
dGhhdCB5b3UgY291bGQgbm90IHVzZSBjb21wYXRpYmxlIHRvIGRpc3Rpbmd1aXNoIGhlcmUuDQoN
Cj4gIA0KPiAgCS8qIFN1cHBvcnQgZm9yIFNESU8gZWludCBpcnEgPyAqLw0KPiBAQCAtMzAxMCw2
ICszMDQxLDEyIEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IHVuZ2F0ZSBj
bG9ja3MhXG4iKTsNCj4gIAkJZ290byByZWxlYXNlX2NsazsNCj4gIAl9DQo+ICsNCj4gKwkvKiBB
Tjc1ODEgd2l0aG91dCByZWd1bGF0b3IgcmVxdWlyZSB0dW5lIHRvIE9DUiB2YWx1ZXMgKi8NCj4g
KwlpZiAoZGV2aWNlX2lzX2NvbXBhdGlibGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1j
IikgJiYNCj4gKwkgICAgIW1tYy0+b2NyX2F2YWlsKQ0KPiArCQltbWMtPm9jcl9hdmFpbCA9IE1N
Q19WRERfMzJfMzMgfCBNTUNfVkREXzMzXzM0Ow0KPiArDQpNYXliZSB5b3UgY291bGQgdXNlIHJl
Z3VsYXRvci1maXhlZCBpbiB0aGUgZHRzIGFuZCBjb25maWd1cmUgbWluL21heA0Kdm9sdGFnZSB0
byBnZXQgb2NyX2F2YWlsLCBubyBuZWVkIHRvIHNldCBoYXJkIGNvZGUgaGVyZS4gDQoNCj4gIAlt
c2RjX2luaXRfaHcoaG9zdCk7DQo+ICANCj4gIAlpZiAobW1jLT5jYXBzMiAmIE1NQ19DQVAyX0NR
RSkgew0K
