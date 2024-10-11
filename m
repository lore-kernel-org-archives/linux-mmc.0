Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CA2107;
	Fri, 11 Oct 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607917; cv=fail; b=J8rgREyhjInjnSm2+/6yCBITfUA22DU9mQg1vEwygmS5CT+t0nUiAy7YGGN5BRAeWlU3P7HHjT4GsvTmVT0z5+67yLCqB3rG03z3pdQ82j/rrS5zoFbDF5V5e3vWmoW0B98aoaBc1T+WiTVzB7mHIp7ASF70dvvSW+xz6AruY1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607917; c=relaxed/simple;
	bh=Aox3DxN0pRnGV6Z4B7sjLnid1T8Kt8AnXCLUsvZBgrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0vEDizM6HjQFaYMIsYuNmzbix/9vok82n1ypn4kPGb7SC/LxzNuTVypVqKheU3EhjMgunO4Uti+O2ATwQquArZxYFUSeZtdYj+vT4P2BqJOwGLhoaEEQYB0Jl4imx3Ia7ZHd+0gkW/VKGv6zz/qRllYmNwQPAMicRzZPIAFHAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N1PQFBiR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DctO0raV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N1PQFBiR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DctO0raV"
X-UUID: fc4ca718876a11ef88ecadb115cee93b-20241011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Aox3DxN0pRnGV6Z4B7sjLnid1T8Kt8AnXCLUsvZBgrs=;
	b=N1PQFBiRi2y3Tvod+Ti8Zq444c72h85THBl/fb8hDT295IYBtBG6m9nllT+V2cs7CIE5bLOJ0JQtPzXDSLa6ZUMyBJJkR7U4+OEfYRH44Fc/fMXEFch3lMDup876lcyjhWnh9bMB1FWULn4Cg2qW+2lVIrQN0KILuzFbYujwObw=;
X-CID-CACHE: Type:Local,Time:202410110851+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c7043a66-f0bf-47ff-b608-d615d7089c53,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:95fe9a26-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fc4ca718876a11ef88ecadb115cee93b-20241011
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1931616347; Fri, 11 Oct 2024 08:51:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Oct 2024 08:51:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 11 Oct 2024 08:51:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbamZpSJHKcETcQvecjNayra8ChP2xFj5509rSm391zAS66GG4YMHYUDDsDOM90W5LQBQXga+duZoyx5xM/5OmWD4qzi2sf0hbml0BLauohMpjMnqrGQXlWQv1VvfNtej0v7SVO1SyKJAAGq+D+jq3bL/CuCOf9xev4qWPuFRO9rjj9nHe3JREfEXEcTHrP911znPM6bFcLYdqnOp9POdEnRQnz6CUF4blmZ0HS+zD++jJO/FWlQm0Oj8wfCvn0le1dtodEo37FY/xj+o+/59qvdTVatgf7qongizQLqt2jDNZwrBKx5HdypG/cKF4aSh2ia+9P72T7XUEsz471+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aox3DxN0pRnGV6Z4B7sjLnid1T8Kt8AnXCLUsvZBgrs=;
 b=FUQ6wq/TOnlwDSJOUszjwlcqiD7NQmMuAZsemEHknMrGA5/xe38/Wmg5iDUt0AeVa8hNou456yT6TkxTIMy2PHvc/fLXUpe9wEbJjj6s8UD9DbmfmV1oUoFKHChNHZr1n0iqyVX1KT/vhsYhZpORBi2baPj0kpeCCHKU8rEKhinLPaNtlus4D/LIAeJrw4srW+bgJnL228WBfas54aUr1JhWnrTZ0uQsLBJ0lZC1iqhHgp9pcMYyNVl3I2cPoUqnbPKAjYGauMdPbIK4HGdrAD2tkR5Td4c/AqtmJjM3aGYkzD7tN47E9pzEhJT1EXorvkO4XqzBbCw6F0kT1BVKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aox3DxN0pRnGV6Z4B7sjLnid1T8Kt8AnXCLUsvZBgrs=;
 b=DctO0raV53VVO70cGTAtRqBJuArG32n8i28LQC/RzdjIHXqfXn1inE/VnnC6r5YXT/bjWugWqN+EB3WZpv7akBYK95GNqK68Gx4oXVtbJaTjabxC7HUETL8Jj8L67ijgmwQa2VX4P16qT9pMY8C/eBBMQU6FTG/1GwceNSuI8cs=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by SEYPR03MB7071.apcprd03.prod.outlook.com (2603:1096:101:d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 00:51:38 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 00:51:38 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mmc: mtk-sd: Add two settings in platdata
Thread-Topic: [PATCH v3 2/3] mmc: mtk-sd: Add two settings in platdata
Thread-Index: AQHbGkNJiXXh1HAGskmGzQa5NAg1fbJ/6IEAgADSaYA=
Date: Fri, 11 Oct 2024 00:51:38 +0000
Message-ID: <3b5bc767907e7643589e1971b4a0114ddaf777db.camel@mediatek.com>
References: <20241009120203.14913-1-andy-ld.lu@mediatek.com>
	 <20241009120203.14913-3-andy-ld.lu@mediatek.com>
	 <c18f8d23-ac54-4660-adce-0e8f7ab53fba@collabora.com>
In-Reply-To: <c18f8d23-ac54-4660-adce-0e8f7ab53fba@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|SEYPR03MB7071:EE_
x-ms-office365-filtering-correlation-id: 0d418268-c80d-49f2-f663-08dce98edce4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1Y1d1NxaTFqZlQ0NnlORk94QmJLWjhibG9JT3o0ZCtLMXNVOVFMYW44N1hz?=
 =?utf-8?B?RlFjbFhhZElKS0pOajdyclRiTlR4VlErZ3Y5TThkb1hjdWdLczErTE1wYW9Z?=
 =?utf-8?B?WnRCZkdmMjlVSEw4ZnRLZ1FnRWd4SzZqMGRnQW9JcjltTTZISFp3amdhdHZK?=
 =?utf-8?B?SllVSmJBak5DM2lBUGZlbVJCTVlmd21ZdFdIL3A5YjNScGdaZlNJNFpOODJY?=
 =?utf-8?B?bkRsWFBuZzNsOUM3RS9PVVBlN1pLUlVpcUVPaHpXeVNOR0NQd2N3T2I4eUJr?=
 =?utf-8?B?TjVlZUdIL3Bxb0syVlNVRGNaYTg2ei93L3FXWUp0ZmEvREpVYWFtZXZpNmEv?=
 =?utf-8?B?YnJYNzZxcWRPRnBxZXFkVG5vaVhLc0YrSU1KNTZKa0VxYW1zVnZUSlZ1UDdG?=
 =?utf-8?B?VWNCb1Z1V1NBamJkUWpWMEtXTFNRS2h6MVRwblVPdEUyblFBN0N6QXExc0px?=
 =?utf-8?B?RGt6ZldDM25oblk1REVBNnBrVW85SHVOVG1KQUhJdE4ySWI4YXR5T1Y1K3ly?=
 =?utf-8?B?MWhvS1M2ZWxEemhVM0RWT2daT0piczc2cFFYSmNCM2djWVNoY0I3TnVPU1FR?=
 =?utf-8?B?b05JSWRsNWxZNEUyMWNpRndKcllTYmNhVHZRZ0NrZlZIdUZ1SzFIV1FHeFdS?=
 =?utf-8?B?S2x4ZlFvTWhpVG01RUQwMk1LV2VIbUJVeHg2MW9STmVYQ2M1U2JCR08wYWhG?=
 =?utf-8?B?TVVyV0IwMHd4WnpNZHFQTGo1dkphYXY0dnFVK1dHalJEb0l4dFZhdlFvRlVp?=
 =?utf-8?B?YTd4cERYM3owUjVjb2Rscm9XYzdLckZJSHFibHBsYkZvVkFUVVRLOUhyU2xT?=
 =?utf-8?B?LzBuT0w1Q1kwSU9EbHZPeklpOG80UGhocnQzQjFsTjRHK0VOTzBvUHdGVmNT?=
 =?utf-8?B?SW02NXhkNXozODJna01GOTdxZjJSNitYVmlnMFVBZWRlYk9GZ1pzdUVVM3Uw?=
 =?utf-8?B?dHJZK2w0ODRkVEZuVElickpWT0hROTZvV1piZk12WjhEUm1XKzd0TkZBK1d4?=
 =?utf-8?B?N3RTR0piNVUrSHhEWWYzUnNUZWQ5VVBRMlJKQW5jMmZJVUlKUFRKWHY3eVJD?=
 =?utf-8?B?Mm8vcG5XVHJ5YU94YW0yVmp2ZnQzc1VMd09kb3lHQkRXSzhSNWM1SHQxdm9r?=
 =?utf-8?B?M0Ivcks0NVFvSGdlL0xHUWhFb3VQRlBCa2NlUVFzT3hJSS90a0VrS1RHdXNI?=
 =?utf-8?B?aVZ5UlozUk13bkxrK0NCejlZZmxPaXhwZ2E0cmlTQk1NRXB6ZHpSZk9DSVdx?=
 =?utf-8?B?QjgzbkZ6YzhURkdUTW1HbVJYc0N6LzhFS2h6eHhZTlFZVWZYS1ZHTWZvM0N2?=
 =?utf-8?B?VDdkcUdxUDhPQ2dhRDZwQUtxUzNhMnVadXQ4djdlN01jY3lBdXRVcGF2dkJw?=
 =?utf-8?B?K004Qmx6WWhtcnRCa21kalVvbWoyd0phb2FCL1pySUtlRUZ6NU5oZHhlbExq?=
 =?utf-8?B?cXkrVlRpS2xlcU5lTjUzM1ZYcGlLSkJRQStGV3lJNjJjdUNEcEN0N25nbXRF?=
 =?utf-8?B?alBBNExKNG5IQTNBSHVTTVl2NWFMWEJYMGVIRExjQmo2WEI4cEVsTEVQVVF4?=
 =?utf-8?B?MzNTMmw0UGRTQ0NMZDF1UytrM3ZkRHFsKzdja1Y1a0tCVHVoRGFobXMzb0ps?=
 =?utf-8?B?UUdsRWF4Z213ZDhySDJRTFpOVHZYcHEvTGtRTWlJeElIeHUzWUhIM3RQRS91?=
 =?utf-8?B?K3NnM1BjcG5SYmFIZi83aytreTFadGxnZVE0UW9GV0hicU5NYld6enUvdUxM?=
 =?utf-8?B?U2ZVRG9qaUFvb3JGNWZhdTgyanBGcHEvZHRNTWYvelRFbytrRVp5Z3ZBTzdh?=
 =?utf-8?B?N2lZSzczdFE2eUhQdWFjUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG82VEMxRlZrTmpNS3ZZcDBMRVk0c1VVZGxWL0t5dVNYZ0IxTEwybzZzT081?=
 =?utf-8?B?Z1I4ZVhLOVRscURaUWNEalFNZkswNWlDdld1VzJSbk4xZUdKYzQ2akRpZ0Jp?=
 =?utf-8?B?VnQzcEN1bzhGbVRHcXl4NE9Ncm9tMHJON2ZzbllwK01PbUJtQ0I3d2ZxZVdZ?=
 =?utf-8?B?OVVaclJNMTEwV3o2TGxyRXc4TGFBQ0E0Q253UHUrNG90eTlGekpJUFJKQ0cy?=
 =?utf-8?B?R2VvVVdqVG5tcW14Y2kwU1dSR1dCSkM2WDc1eVc4cEV2Ni82SW5HL0g2WDlz?=
 =?utf-8?B?akZvZ0xucU83eUZsblNpRlNFLy9mUUpRSkxWOE1RYW53TXJPUkw3TEFLblJ4?=
 =?utf-8?B?TFppYml0b1hZMFhaS3poN3FSWlFhMkUxeW53UDBSRytkYnJnTU9vVnNOQ25u?=
 =?utf-8?B?U1NIcjQwWS9BeUNxRE8yMHhPRURYNXBOZDVsL0lyRlo4RTByRmFIT2pxcFY5?=
 =?utf-8?B?TEtzVzk3WHMxcFFqYTRINzJ4bTJCZEh4bnNvUjZnNG8wT21wZVdidXhGb0tF?=
 =?utf-8?B?RkxNcjVZWmJzazV1Wm8zWjVJZUFGaFFod240MGJ5WEhMMk1LT1VLd1lMODNk?=
 =?utf-8?B?M3RET1kzcmE5YzBOeGhHQWNGcjIrcHZiU1poY1VOVjdOSHhiV3IxcThPN29L?=
 =?utf-8?B?TWZPcGVHMVJtQUUxQlRQUUVndDFFSU9uaEN1NVM5bHB5WjVqVkRvWkUyZm5S?=
 =?utf-8?B?TnRMYkJDTG5YeHNjbUduYW9PWDFJeHhYZDU2YmpjYUkwbjFxSE9vTmd5MC9P?=
 =?utf-8?B?SkJIYW92R1VqVjkrMzN5QkxQQWpiNTBRek0zeWN5VkFPOWJ1Q0NnTnVmWGE1?=
 =?utf-8?B?QVBvTlJGeEJRemJzUVN1QUtGaW1tYnlkRVVJckIwazVxZm9jUXNVaFZNem0w?=
 =?utf-8?B?QjgwR0YyeGFYTXlkVnhzVDhhT0JJTUZndGZEMlNyS0xTcXd1dkYzdGUzNnlN?=
 =?utf-8?B?ano4RFVIeFFCaWJYSFd0L1QrRENMTGVITDdjVnFaNWh1T0QyU3I1QmVOS0hM?=
 =?utf-8?B?c1FqcDUrcllXODYrUUFFUGZNVXpYc3dwTk91dDRZcGZQcWVEY0hQRUhaVWF3?=
 =?utf-8?B?N0I2bEdPZmNYMVlwUEt5SGdCU0hiZjdySnFlUFl1L3dnWStiZXRteENLT3Bs?=
 =?utf-8?B?b00zcjlSUVpvR2FENVpKNDJ5anNzZmVFalFJeTY0UkZvMW5OOFhkSzVHQWFD?=
 =?utf-8?B?aFMwekhkVlBpMEp6emoxbjF0Z3RoRHl1eldkbzRqUGtRR1p0b3c3RFc2UVFY?=
 =?utf-8?B?QlN5MUE3US9zTkJQVU5GOVI1SzlRTk93VEpOMFhzbGpmY1l4U29QQXBhbVZV?=
 =?utf-8?B?bjZCTkJsNFZSTkdwemtDQmhzLy9qNDJCeDFyNTJoeWhJYzZYYksvT3Z2RHVr?=
 =?utf-8?B?TEVFR3NYbGpET3FPNVdKclBUZDhsWStRSFNZdEVNT0FGR3p3c2N3Y2ppT1k0?=
 =?utf-8?B?SVpWaDVJcnFPMGk1NHM1ZlZrdlhnTTkxZ0xsM2pidVdXZG1VUDh1WXR1akky?=
 =?utf-8?B?QmNjbjBQZXVFUDlqdXdQME9nUEhJd3pEYXdDZWlEYWFBR2ptY241c0Uvekcy?=
 =?utf-8?B?K1Ira0tTUHF2bmJmalpabTVzdkU3ZlZpanUxKzk5TElMUUlHK2FJdHVmSG04?=
 =?utf-8?B?Y1Fjdy9OeEgwNkRXcndoM0xyVjl1M0U0TnZNRkxiSWRxVFZEMTBRR2p0UDNG?=
 =?utf-8?B?c0pVSUJLSk5EWHl1c1pxRUp6enFVTHJmalBrbVE3Mk1EZEZoVjFnUHRJMU9j?=
 =?utf-8?B?VXA4V0hxbGhFYWtRcGFqTWc3M1dWZEZzcFRhMGkrMUhYc3pDSnpqMDQxWU4y?=
 =?utf-8?B?MUoxbEs4UWZvNER0dmc4M0ZFOWRaRFRiMXNlRVdPUUljL3ZITzROU0MzSWpJ?=
 =?utf-8?B?dXlUVWJBZTdWeHRhZ0FScVRGUEoxbUNSVXRLVGtUZGdEWGRSdkhFOFIzNDBC?=
 =?utf-8?B?cVYwUVJCK1l6ZjQ1YWN0eGZNNFh3Qzd0d2tzY3dpcS9RZDg3dHhyS1VsdmVH?=
 =?utf-8?B?R0phQUlZdTVPZXptcjgwckNCQk0va0s5RHhDUEVBRUxZZWJMUjM1cmVvSnJF?=
 =?utf-8?B?OEx6ZGI2ZXkxcnJkU1VkMmlxYnhIb2hERGlTeUdpTTNVNlFuWGtlT0V1OWtQ?=
 =?utf-8?B?OUpoQW1Jbkp4Q3ZiSXJoRmx1dW1naU5tdlF4d1M1MlhMNVh1QmlmbTNWZm5N?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <888A5B449510024FB7E730DBABA4CE4C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d418268-c80d-49f2-f663-08dce98edce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 00:51:38.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVnBcN7RhljLU9P2dIFnYBTm95nNYAkgrXtfz3GhvJd96gdBMqRVRU0Pag4oFC4Bt7Bkc+448RvZkUIRlZmmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7071
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.913900-8.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXYhX3gJCDg5mSvzFC1MVtlYdGXFpRz8pNhNZCDXJ6NLvbDHSNFHFxB8+soDDE6CvPdk7l
	Rk5XUYpj6ickQRB2XRvYjGNjm9fWhQRHl12CcQN55TJVlfiK+uyEdaywSZvzOV9eB8vnmKe/3a1
	M/dirxUFTPGzyxkQRkt72M8lYD5n8OSXKAkmvShsAmcZEx8XHJfS0Ip2eEHnylPA9G9KhcvbLn+
	0Vm71Lcq7rFUcuGp/EgBwKKRHe+r0sVJXD5DUck7S5ZGPWPXEOzPPAGxdbrMIfeU04tz6nuGC/p
	vM0XTGQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.913900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9863257E0EC2627683B95A00734AD1E87F1C03DD8ACDA279169135EE24EBD3D72000:8

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDE0OjE4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDkvMTAvMjQgMTQ6MDEsIEFuZHktbGQgTHUgaGEgc2NyaXR0bzoN
Cj4gPiBUaGVyZSBhcmUgbW9kaWZpZWQgcmVnaXN0ZXIgc2V0dGluZ3MgZm9yIFNUT1BfRExZX1NF
TCBhbmQNCj4gPiBQT1BfRU5fQ05ULA0KPiA+IHdpdGggdHdvIG5ldyBmaWVsZHMgYWRkZWQgdG8g
dGhlIGNvbXBhdGliaWxpdHkgc3RydWN0dXJlIHRvIHJlZmxlY3QNCj4gPiB0aGUgbW9kaWZpY2F0
aW9ucy4NCj4gPiANCj4gPiBGb3IgbGVnYWN5IFNvQ3MsIGFsc28gYWRkIHRoZSBvcmlnaW5hbCB2
YWx1ZSBvZiAnc3RvcF9kbHlfc2VsJyB0bw0KPiA+IHRoZQ0KPiA+IHBsYXRkYXRhLCBmb3IgdW5p
ZmllZCBjb2RlIHNldHRpbmcuDQo+ID4gDQo+IA0KPiBtbWM6IG10ay1zZDogQWRkIHN0b3BfZGx5
X3NlbCBhbmQgcG9wX2VuX2NudCB0byBwbGF0Zm9ybSBkYXRhDQo+IA0KPiB0aGF0J3MgYSBiZXR0
ZXIgdGl0bGU7IHRoZW4sIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24sIHlvdSBzaG91bGQNCj4g
ZGVzY3JpYmUNCj4gd2h5IHN0b3BfZGx5X3NlbC9wb3BfZW5fY250IGlzIG92ZXJyaWRkZW4gKHNv
LCB3aHkgc29tZSBTb0NzIG5lZWQgYQ0KPiBkaWZmZXJlbnQNCj4gdmFsdWUgZm9yIHRob3NlIHJl
Z2lzdGVycykuDQo+IA0KPiBBbHNvLCB0aGlzIGNvbW1pdCBzaG91bGQgY29tZSAqYmVmb3JlKiBh
ZGRpbmcgc3VwcG9ydCBmb3IgTVQ4MTk2OiB5b3UNCj4gZmlyc3QNCj4gYWRkIHRoZSB0d28gc2V0
dGluZ3MgaW4gcGxhdGRhdGEgZXhwbGFpbmluZyB0aGF0IHRoaXMgaXMgYWxzbyBkb25lIGluDQo+
IHByZXBhcmF0aW9uIGZvciBhZGRpbmcgc3VwcG9ydCBmb3IgdGhlIFNEL01NQyBjb250cm9sbGVy
IGZvdW5kIGluDQo+IE1UODE5NiwNCj4gdGhlbiB5b3UgYWRkIHRoZSBhY3V0YWwgTVQ4MTk2IHN1
cHBvcnQuDQo+IA0KPiBGb3IgdGhpcyBjb21taXQsIGFueXdheSwgdGhlIGNvZGUgaXRzZWxmIGxv
b2tzIGdvb2QuDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KDQpUaGFua3MgZm9yIHlvdXIgc3Vn
Z2VzdGlvbiwgSSB3aWxsIGZvbGxvdyB5b3VyIGNvbW1lbnQgaW4gbmV4dCBjaGFuZ2UuDQo+IA0K
PiANCg==
