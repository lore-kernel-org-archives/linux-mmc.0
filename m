Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4171A9B4E;
	Tue, 21 Jan 2025 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737440770; cv=fail; b=qPPfzu9fwbna2MijH6mnVDERXRLnZQD9hrf0Cye4X7f06NhFtZmkL+3vNexLS2QgLgbZSoKD74B1mwtZdyu2SGW4EUrPDV8cMxOBr4nFGBPqGgDFiYAGBWMVOWSgpQ3cT70pMi/RLOJCYNbz3PErIPnyI8Kj/TVjfmOBhTaR4HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737440770; c=relaxed/simple;
	bh=CkZgM6xa60hnEiqkwSOexXojOxyiQrX4G+FN5XGPzSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVy9piQtqc9jenN8wR+lvMTG1cNvfbScJfmcR1eJNs31EmdQ7rDoSH56eOU+Ylek+rHAETbvFoALqZZLuqdp4HJRYO+H7neFKHz12f51YisHGZHMPUgVmIaqOqejUOVXuqRIhK88U4YTdb+wrzh9hSbsYWdHuq3Wu7VyGZYqFm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Fviz4iDY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TmNaBW4m; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Fviz4iDY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TmNaBW4m"
X-UUID: 9166ded6d7c011ef99858b75a2457dd9-20250121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CkZgM6xa60hnEiqkwSOexXojOxyiQrX4G+FN5XGPzSM=;
	b=Fviz4iDY6rxiy2qPG5lXPYWsFEt3dikwZS0TAWFjuv8z4HhD+c0x5BlN4CDtO07jUDHibkFMmbjLmqCdlmD4getZt9xBI49inuVXgaz4uOjn06Wd5/AYplqiIpu0CdMCiESGXoOlu0Q2LtY/pP6yGPp5uSoF6SMmEkN0KVptHqc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:8fc64321-b754-42bd-bd01-19fa0a23c122,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:60aa074,CLOUDID:10623638-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9166ded6d7c011ef99858b75a2457dd9-20250121
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1015639618; Tue, 21 Jan 2025 14:25:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 21 Jan 2025 14:25:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 21 Jan 2025 14:25:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCsn8N9QqGiuLC54TkyhhpLwqyKzWNK/VuLMp69v8M1wxB8pVwwIyW2WiK4RDHaBEkoeiGuM7xowG+aEEv19ecnkhCrf6M1NTpRCFsng4gOH8pc9imwPDVAl8knHtd3ziOlKoV1qi44gj7byx6xPaD1pyJtkq8wlJYsot9i2j/4x9EOUL9ZmB1lVfvgX9zARrqQqwfjOnJKFjqGET8h0JFShYoaHTHGEA+DXvxRxIxkpZdXlwfi9HafOzSxnu1A6ra2Ptnc3rCfnfgXBcAkiTAu0zAEQGt8jiRQas1J2Ht71Em8FAVUgKXK5S22An/VdZqkjnljmLEs7Bour8iHWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkZgM6xa60hnEiqkwSOexXojOxyiQrX4G+FN5XGPzSM=;
 b=OmhdjfOLlHJHqUs+sQ1f2SktSbFJY7BxZ+WCofLh7d3Wx0X5Tuv6K4LwfH0/OI6CMBkBmjePdHZdTQIgasQxnFAGoBvYhjvwM/CS+9ypsvWW6VKn+i3BaD2BmazO456QPB6DBJ8zwwml2oKg6QUH1fF+nKwiobVCfj5H7Yyj5dYhchh7YwXaw6Z/oG45fJ8lFfXUGWsHDUEm39PmcRjHOA5/42RttiCDu3ZySNkKtYB+0IHaWTs1Nx0EpM0hJ6wdKj7WF6s7W2HKyc4vTgxGS4ZX/OjmSjelitPeslv9oFKJKoW3RVrHMVhwlgehk08PkIgyDSrpNGDmSrVH0PZ1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkZgM6xa60hnEiqkwSOexXojOxyiQrX4G+FN5XGPzSM=;
 b=TmNaBW4mDLuauH13ce0Ir9KyZlbjOGCDIHaiSKu9z7RqDjR5epg33OST3EeWMbmal8Sy+z6xuGggNUxNIQq19fPk0p37Da75idfkC3PVGeLfYFq/szRP4wNtyB9wVErCEAAFsPksuq5MhixcezrrVQX1C3gF5hvIunSLs87Fu/I=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by KL1PR03MB7453.apcprd03.prod.outlook.com (2603:1096:820:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 06:25:50 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 06:25:49 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, upstream <upstream@airoha.com>
Subject: Re: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Thread-Topic: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Thread-Index: AQHbZ8RDxfMK8AnxDEeTry1MKcHJqLMY+U8AgAb4/gCAANjHgA==
Date: Tue, 21 Jan 2025 06:25:48 +0000
Message-ID: <eb064f0873fd47e7cbd07f8e403f11dd6060ff34.camel@mediatek.com>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
	 <20250115073026.31552-2-ansuelsmth@gmail.com>
	 <9e022bf13354f544962491cf8061ff3edb878c30.camel@mediatek.com>
	 <678e8816.050a0220.b6bb9.f588@mx.google.com>
In-Reply-To: <678e8816.050a0220.b6bb9.f588@mx.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|KL1PR03MB7453:EE_
x-ms-office365-filtering-correlation-id: 8acabb4e-2df2-4234-7975-08dd39e47256
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHBnSFd4T1J6d1NyOVpNYUROLzRZRzZWRHppMDlGQzFDbjU2ajdHS1ZHdThs?=
 =?utf-8?B?Rm5aaEdVZjU3YzdtTFlzdE5kUlhJcHc2OXVlWnhPRXlXMTliSVd3NVhxWnVZ?=
 =?utf-8?B?dUJUTHNpSTZmN3RZY1JKaWE4UUpjVlU1cWgxaERmNDd1WVFPZWZrYWFEalZx?=
 =?utf-8?B?a0NPanR2a1JjM1U2TjZjNmcxemdNNFcxNUIxQTdFb09KeGlpb0ZMQVBJWFVy?=
 =?utf-8?B?eHJsOUtCTzFPOUl0czNURW5VdnFvM0JvTDFUOVdmeHF6WVdYQk5UamV0UU0x?=
 =?utf-8?B?NVJCM1FxbVlCd0ZVN09PcDZaZW5pWkVkdUw4cERLL2k2dElqQkJMb3ZEbWND?=
 =?utf-8?B?U1F3Nm5wQU55S2h6eDhNdytRNlRyQTJPNXg1dm41dGZhdHdWMnBMa3RQcVJl?=
 =?utf-8?B?NkNhT0cxb2ZxSDNtMk9RcUhXeGZHMElCWFdkNTdEOUdtcTZKZVFaWHZ4YUpY?=
 =?utf-8?B?a01xVVEvS3NadTVwNzVxMS9ic1ZWVDc0VERNanNHUmlTbnR4U094STB3aXFm?=
 =?utf-8?B?K2cyUC9qMThXamVZL20yZ09GbHdmYThUY0ZiNHhRbzB1dzJkVm1DOTJJZmJo?=
 =?utf-8?B?S3RaS29JeW9mZ0ZOKzZkdGgxM2dtOVlRWWZxTGVkTDNkTXh3c2JmdjRaNlho?=
 =?utf-8?B?aE1hZ1pqMUxXTVN4dGFCNlRGU01tUGhHcURFV3VWdFl6cVNtVVVJaW9hNFYx?=
 =?utf-8?B?OXZ0U3FPVXZ0dmZYQnhHYmx0U2xnQWZOYmFGdmZXZ1RTVUNIWlNvdThTRVJm?=
 =?utf-8?B?b2o5MXdyaU84SEpvYU9RenV6bGdUb1Q5Vjllc2dIRkg3K0U0OGtOWWpBcEpS?=
 =?utf-8?B?MFBRVVM0VFo4dXNpRjVnU1hEZEc5L1hTNGQwaFE5eEt5TjNtWnlQdzJ1a1Zt?=
 =?utf-8?B?b2w4UEdLZUtKZVhrb3pMc2FyOXk5bDJaREFwYnB2bDNWc1pnd1RiOVUyNTlN?=
 =?utf-8?B?UGx0R01iVDFLaWNHMmowT2pYbFNqWWNwTFd3SkpBMXJJWkozalc2ZEJReG5M?=
 =?utf-8?B?RlM3RzRuTGN3MnI4QkRmeWNyL0J5aGhPanFUbkgyUGhURlZnWlhwOEUwcCsv?=
 =?utf-8?B?Vkh6M1BOWlB4blA1L2V0Nk9xc0RjVXNqcC9sZ0xENmZjZWpKUDZQa2IxOXRO?=
 =?utf-8?B?L0RqYnFOS2VDd0RRSHpTUVc5ajBEbEhqSGxOZkF6MlZRQnltbVU4VG1lNDJy?=
 =?utf-8?B?RDB1Mkl4dUJHTGFvSk5sbWVBcFdZYUJCS1pxT3ZNWDdLdC9lYjdUSEVxYUJV?=
 =?utf-8?B?SytXeUdVaVQ5anhNekdQM0pLWGR4cTc3UnZTMEhYM1MvYmJPWU1UcU1TYTdO?=
 =?utf-8?B?RytGZStXVkM5NzRUSjhjOVpvb0NEQ2NMUE5haEhsMEhDcVBWVDd5M1JUUGxO?=
 =?utf-8?B?WUpzQUpFR0gxYXV6NCtWV1JmWnN1cVpXRmhObkhnNFBTVEhlNXRQSStXUmJN?=
 =?utf-8?B?MnZ4emx3V3l5YTRWQXZINllZV0RIZjk2SHFOaUdQNHNNdFpNeHNENjFLelNp?=
 =?utf-8?B?aFN3aTlMVGxEY3UrZDJJTytxVUVPdlZVc09qcVRZcXNMb0ZMN0tOQld4bmdY?=
 =?utf-8?B?OHV0QVZoczBqRm9PQzFHRXhkUmxWL0hmSmd1eGNjeTdsUGhMTmI0RjRZa0Nz?=
 =?utf-8?B?MGFld2p1SzVqekVRSjkrQ291ZXhMV0RjcHQ5TyttMmFBaFB3cjFHTG1tcnJi?=
 =?utf-8?B?N3FtQnlmdmJvODBxa0NqNitQQ2dpMnQ5NlpzNU1Xd3lMblNQL0xCbk5LNVVF?=
 =?utf-8?B?Y1VreHJwK2x3amtFL29BUkovMnpmWnViMXp0d2c5VXB6dUxOdllFS1llYXVq?=
 =?utf-8?B?VFZvU1gyTGhhSzllZEdVSm1qeXQwd3pPWTVneVRZcG9LUEYwMVhvVGxwbHFw?=
 =?utf-8?B?dnVEVWVLTGVsVjZCeWZzVGNFa2s3YzRIODNHK2FnYlpvenphSkczcmlKakhu?=
 =?utf-8?Q?s7h2Ml8NIoM4OVBO0EUCwhLVM027OA3C?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVpHTU5DU25nTVVBUyttTWZxVUdEZ2ZDdURIN29Kbk9LT2JFYTZuV1BjQlVF?=
 =?utf-8?B?SlVSMTY4eFloWkRwWDNLVkdzOFl1V1lVZEtRaUxaOWpYTENNQjdWY1cxU1lF?=
 =?utf-8?B?UkFnUDA4MmJMU0lyZXZGUFVCQkhXMkR0Y3FPekwxbGgyTkh5NHlJNjgvUzRv?=
 =?utf-8?B?aVBpdk5CZ3dDZlFYbjVKZEE4MG93WkJ2aVVaZzNPWHdwUkNZcEpzb0xtOFRY?=
 =?utf-8?B?MHhLUWM0azV2cVp0MUdyMmNDVWlITHBoeExtNmJpQS96MWF0Ti9aY25vcWM0?=
 =?utf-8?B?UHVVeW9VbUZ1WXpldkxoa0tmbnoxRWdvMTI3UkhYRDNpcEVyQUdWc3BsQmNm?=
 =?utf-8?B?OHNxaFN2YzdiVWJkcWxZQmxYZnhlQnN1dTJYV2JINHlUMGpKWkJFekI2L0FT?=
 =?utf-8?B?RG0yMUlMS0NYMWY5eUlseTYwUXllU1FhMzhseTNXSlRlNllPNkVDTkZMT21R?=
 =?utf-8?B?bXR0ejRmTUVtSGgxN3NtR3JFQW9YdVM3TG9YSnBTMXpSUjZqUkE1WUo2ZzVr?=
 =?utf-8?B?bzhOS1kwa1pkWHBPVk5salllWTI1QVJUMS9XRXhZYUI5cWZVaHNiNktzMVda?=
 =?utf-8?B?YlBHakl6OUgyTnZiOFhEWGVZUmJ3MFBrcmtTRW9EU1FnY08zcUFPcWtGL3R2?=
 =?utf-8?B?YnhneUllUDNlZjJ0UHB6YWZ4empBSWNpZFVadTlFTjRieUN2UzVxSWVndFY0?=
 =?utf-8?B?djBHajh1RWZLUDkwMEJnUFhvVFVveHZUWnhaalA4UmxHTlVsM0lvRk4yd205?=
 =?utf-8?B?eDFrUlVKZWU3bjYvVmtWUWlOdjVxTGxHV0NkK3E2bXpjcERtSDJuMGt2eks5?=
 =?utf-8?B?M25IV3F0REd0TjNoU3luRHpWZzNEaERUTEVPeElteDE4MXIzdjkvdFV1M1Zw?=
 =?utf-8?B?UUppOUNWMDFMOE5mRkJyV0xFN3htRHB3K01YUzAxcHNFS2l0UUFMVi9WeE5i?=
 =?utf-8?B?b1ZhdWxVYUY3WHc4dGVkZm16a0Fhd1BwVjJlcVdJTlJkcmVESFJOeTQvSExD?=
 =?utf-8?B?djVydENzcDQ5OGpsYXZyYjBiSENObnpiMTlKNk5JS3hqRm5hTzY4anM1aU0z?=
 =?utf-8?B?ajByaWpMY0tQa0RjVkQwSG14bHphMHkzZWd6YlFISzUzeVQvbjNxWmdyejRt?=
 =?utf-8?B?UENXSk9tWk95N1ZaNlZ0Tjk2UVVwKy9HUzJ3Q21SRjZhNGR3Z3FqUVFvVTM2?=
 =?utf-8?B?Q2o3YUh3Zy9INnpmaHNORVNUeGxtWlJZQ1lwTTRHMGtPWEJqQzFUQlNxUCs0?=
 =?utf-8?B?alNiZy9LeWRNa3d6RGZuV0pSY3VXMDhXanM3bTlVTTFUMmE4WlBLZWYwbFFv?=
 =?utf-8?B?ek1MckNQUllMaFBLVlNKU0N5eEE1Q3NKRGU0VUdzSmYvS3VjVW1XSFhKZGlI?=
 =?utf-8?B?N0RVL0k0SVdkTU8rNTI1OEM3RmpQU28zeHRjVlphc0ZucUUvVXhxdFdNRXh1?=
 =?utf-8?B?NklsTnFPUjNYaDdpWHM5cmc3Z2JRT0lNSEN3dVdkT2w0dmhjeFdLY0w0K2J3?=
 =?utf-8?B?YzVKM2JrdHlVdnF2N2JPUFUreDVsQ1l2TzI5OUNsVjZGT0hsZS93OVYrZkJ2?=
 =?utf-8?B?K3pIM2p3TEpLeEIyZUJUMVpvMm05ZXhwNHhjRmlSZWxJN0dsZE8zSS9ZZ29V?=
 =?utf-8?B?OERRNDcrNi81TDJuVXN1T0tZRHp4cE1pRUphTVdiQWZxL0N3OEFUcU1GT1ZJ?=
 =?utf-8?B?NC9Yd2tPVkNHbFVkN3c3SVRZWXUwVVI0TFdFUmxhZ1pXQ0ZEdFdoeStjaWZl?=
 =?utf-8?B?SWwrZjJTR3FCZUkzYkNINGJXWUZuSUgyMWZ0OUVNTG9JdzZmYVYzRThzM1Vk?=
 =?utf-8?B?ODkrQjdwVWZQa2dCaDFDZ2J6Y0xhSGpCVmxTYzVFemF1aXlSVkVSV2xYcTY5?=
 =?utf-8?B?UnBUYXdmVnNzbVRxaWw4M0xybEhQb3IvSDdzUndPeEVyR25Sd0N0b2RGWEw5?=
 =?utf-8?B?b252d3F4TnZpeTAvajF2QkRoZ3dCcjd2STBOS0I0c2xIVVVsZGU5WUdaOXds?=
 =?utf-8?B?cVM3RFdTdHBlYlJMemFJd3pwemtneFVwOGk2K2RZWTYzd0JsQm9IQnd1UU1l?=
 =?utf-8?B?ZWxiWmFSYmlraWZiUnNQa2d5L2k5WEZpY0tTOHZzREdtTVJoWWREK3JoWmJo?=
 =?utf-8?B?d1hRcSswVnJkbUIwMnJBbG1lZ0ZXc0Z6OVVWdzQ4U1hTL1R6Unk0SFNMbWZF?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FFB8440B94BB9459E61CC28D4EE38B8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acabb4e-2df2-4234-7975-08dd39e47256
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 06:25:48.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYN/Kj5kwbdBXCYyx33/adWYmjAKcH9slax5TyEKfptfuQsKXrBJtwkcI86OO4mn5NcnnhsVIKMSnJwzxqDz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7453

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDE4OjI5ICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiBUaHUsIEphbiAxNiwgMjAyNSBhdCAwNzowMToxM0FNICsw
MDAwLCBBbmR5LWxkIEx1ICjljaLkuJwpIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNS0wMS0xNSBh
dCAwODoyOSArMDEwMCwgQ2hyaXN0aWFuIE1hcmFuZ2kgd3JvdGU6DQo+ID4gPiBBZGQgc3VwcG9y
dCBmb3IgQU43NTgxIE1NQyBIb3N0LiBUaGUgTU1DIEhvc3QgY29udHJvbGxlciBpcyBiYXNlZA0K
PiA+ID4gb24NCj4gPiA+IG10NzYyMiB3aXRoIHRoZSBkaWZmZXJlbmNlIG9mIG5vdCBoYXZpbmcg
cmVndWxhdG9yIHN1cHBseSBhbmQNCj4gPiA+IHN0YXRlX3Vocw0KPiA+ID4gcGlucyBhbmQgaGNs
ayBjbG9jay4NCj4gPiA+IA0KPiA+ID4gU29tZSBtaW5vciBmaXhlcyBhcmUgYXBwbGllZCB0byBj
aGVjayBpZiB0aGUgc3RhdGVfdWhzIHBpbnMgYXJlDQo+ID4gPiBkZWZpbmVkDQo+ID4gPiBhbmQg
bWFrZSBoY2xrIG9wdGlvbmFsIGZvciB0aGUgbmV3IGFpcm9oYSBjb21wYXRpYmxlLg0KPiA+ID4g
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTWFyYW5naSA8YW5zdWVsc210aEBnbWFp
bC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNTUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiAtLS0tDQo+ID4gPiAtLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyBiL2Ry
aXZlcnMvbW1jL2hvc3QvbXRrLQ0KPiA+ID4gc2QuYw0KPiA+ID4gaW5kZXggZWZiMGQyZDU3MTZi
Li45ZDY4Njg4ODNjOTEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L210ay1z
ZC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gPiBAQCAtNjY2
LDYgKzY2NiwyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29tcGF0aWJsZQ0KPiA+
ID4gbXQ4MTk2X2NvbXBhdCA9IHsNCj4gPiA+ICAgICAuc3VwcG9ydF9uZXdfcnggPSB0cnVlLA0K
PiA+ID4gIH07DQo+ID4gPiANCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29t
cGF0aWJsZSBhbjc1ODFfY29tcGF0ID0gew0KPiA+ID4gKyAgIC5jbGtfZGl2X2JpdHMgPSAxMiwN
Cj4gPiA+ICsgICAucmVjaGVja19zZGlvX2lycSA9IHRydWUsDQo+ID4gPiArICAgLmhzNDAwX3R1
bmUgPSBmYWxzZSwNCj4gPiA+ICsgICAucGFkX3R1bmVfcmVnID0gTVNEQ19QQURfVFVORTAsDQo+
ID4gPiArICAgLmFzeW5jX2ZpZm8gPSB0cnVlLA0KPiA+ID4gKyAgIC5kYXRhX3R1bmUgPSB0cnVl
LA0KPiA+ID4gKyAgIC5idXN5X2NoZWNrID0gdHJ1ZSwNCj4gPiA+ICsgICAuc3RvcF9jbGtfZml4
ID0gdHJ1ZSwNCj4gPiA+ICsgICAuc3RvcF9kbHlfc2VsID0gMywNCj4gPiA+ICsgICAuZW5oYW5j
ZV9yeCA9IHRydWUsDQo+ID4gPiArICAgLnN1cHBvcnRfNjRnID0gZmFsc2UsDQo+ID4gPiArfTsN
Cj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtc2RjX29m
X2lkc1tdID0gew0KPiA+ID4gICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzAxLW1t
YyIsIC5kYXRhID0NCj4gPiA+ICZtdDI3MDFfY29tcGF0fSwNCj4gPiA+ICAgICB7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10MjcxMi1tbWMiLCAuZGF0YSA9DQo+ID4gPiAmbXQyNzEyX2NvbXBh
dH0sDQo+ID4gPiBAQCAtNjgwLDcgKzY5NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkDQo+ID4gPiBtc2RjX29mX2lkc1tdID0NCj4gPiA+IHsNCj4gPiA+ICAgICB7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1tbWMiLCAuZGF0YSA9DQo+ID4gPiAmbXQ4MTgzX2Nv
bXBhdH0sDQo+ID4gPiAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtbW1jIiwg
LmRhdGEgPQ0KPiA+ID4gJm10ODE5Nl9jb21wYXR9LA0KPiA+ID4gICAgIHsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4NTE2LW1tYyIsIC5kYXRhID0NCj4gPiA+ICZtdDg1MTZfY29tcGF0fSwN
Cj4gPiA+IC0NCj4gPiA+ICsgICB7IC5jb21wYXRpYmxlID0gImFpcm9oYSxhbjc1ODEtbW1jIiwg
LmRhdGEgPSAmYW43NTgxX2NvbXBhdH0sDQo+ID4gPiAgICAge30NCj4gPiA+ICB9Ow0KPiA+ID4g
IE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1zZGNfb2ZfaWRzKTsNCj4gPiA+IEBAIC0xNjAwLDYg
KzE2MTQsMTAgQEAgc3RhdGljIGludCBtc2RjX29wc19zd2l0Y2hfdm9sdChzdHJ1Y3QNCj4gPiA+
IG1tY19ob3N0ICptbWMsIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+ID4gPiAgICAgc3RydWN0IG1z
ZGNfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+ID4gPiAgICAgaW50IHJldDsNCj4gPiA+
IA0KPiA+ID4gKyAgIC8qIFNraXAgc2V0dGluZyBzdXBwbHkgaWYgbm90IHN1cHBvcnRlZCAqLw0K
PiA+ID4gKyAgIGlmICghbW1jLT5zdXBwbHkudnFtbWMpDQo+ID4gPiArICAgICAgICAgICByZXR1
cm4gMDsNCj4gPiA+ICsNCj4gPiANCj4gPiBIaSBDaHJpc3RpYW4sDQo+ID4gDQo+ID4gSSB0aGlu
ayBoZXJlIGlzIG5vIG5lZWQuIElmIHlvdSBoYXZlIG5vdCAndnFtbWMnIGluIHRoZQ0KPiA+IGR0
cywgSVNfRVJSKG1tYy0+c3VwcGx5LnZxbW1jKSB3b3VsZCBiZSAtRU5PREVWIGFuZCB0aGUNCj4g
PiBjb3JyZXNwb25kaW5nDQo+ID4gZmxvdyB3b3VsZCBub3QgYmUgZXhlY3V0ZWQuDQo+ID4gDQo+
ID4gQW5kIGFub3RoZXIgcXVlc3Rpb24sIGhvc3QtPnBpbnNfZGVmYXVsdCBpcyBqdXN0IHNlbGVj
dGVkIGhlcmUsDQo+ID4gdGhhdA0KPiA+IHdvdWxkIGJlIGxvc3QuDQo+ID4gDQo+ID4gPiAgICAg
aWYgKCFJU19FUlIobW1jLT5zdXBwbHkudnFtbWMpKSB7DQo+ID4gPiAgICAgICAgICAgICBpZiAo
aW9zLT5zaWduYWxfdm9sdGFnZSAhPSBNTUNfU0lHTkFMX1ZPTFRBR0VfMzMwICYmDQo+ID4gPiAg
ICAgICAgICAgICAgICAgaW9zLT5zaWduYWxfdm9sdGFnZSAhPSBNTUNfU0lHTkFMX1ZPTFRBR0Vf
MTgwKSB7DQo+ID4gPiBAQCAtMTY5OSw3ICsxNzE3LDkgQEAgc3RhdGljIHZvaWQgbXNkY19lbmFi
bGVfc2Rpb19pcnEoc3RydWN0DQo+ID4gPiBtbWNfaG9zdCAqbW1jLCBpbnQgZW5iKQ0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9kYmcoaG9zdC0+ZGV2LCAiU0RJTyBlaW50
IGlycToNCj4gPiA+ICVkIVxuIiwgaG9zdC0+ZWludF9pcnEpOw0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICB9DQo+ID4gPiANCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgcGluY3RybF9zZWxl
Y3Rfc3RhdGUoaG9zdC0+cGluY3RybCwgaG9zdC0NCj4gPiA+ID4gcGluc191aHMpOw0KPiA+ID4g
DQo+ID4gPiArICAgICAgICAgICAgICAgICAgIC8qIFNraXAgc2V0dGluZyB1aHMgcGlucyBpZiBu
b3Qgc3VwcG9ydGVkICovDQo+ID4gPiArICAgICAgICAgICAgICAgICAgIGlmIChob3N0LT5waW5z
X3VocykNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsX3NlbGVjdF9z
dGF0ZShob3N0LT5waW5jdHJsLA0KPiA+ID4gaG9zdC0+cGluc191aHMpOw0KPiA+ID4gICAgICAg
ICAgICAgfSBlbHNlIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgZGV2X3BtX2NsZWFyX3dh
a2VfaXJxKGhvc3QtPmRldik7DQo+ID4gPiAgICAgICAgICAgICB9DQo+ID4gPiBAQCAtMjAzNiw2
ICsyMDU2LDEwIEBAIHN0YXRpYyB2b2lkIG1zZGNfb3BzX3NldF9pb3Moc3RydWN0DQo+ID4gPiBt
bWNfaG9zdA0KPiA+ID4gKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykNCj4gPiA+IA0KPiA+ID4g
ICAgIG1zZGNfc2V0X2J1c3dpZHRoKGhvc3QsIGlvcy0+YnVzX3dpZHRoKTsNCj4gPiA+IA0KPiA+
ID4gKyAgIC8qIFNraXAgcmVndWxhdG9yIGlmIG5vdCBzdXBwb3J0ZWQgKi8NCj4gPiA+ICsgICBp
ZiAoIW1tYy0+c3VwcGx5LnZtbWMpDQo+ID4gPiArICAgICAgICAgICBnb3RvIHNraXBfcmVndWxh
dG9yOw0KPiA+ID4gKw0KPiA+IA0KPiA+IE5vIG5lZWQgdG9vLg0KPiA+IA0KPiA+ID4gICAgIC8q
IFN1c3BlbmQvUmVzdW1lIHdpbGwgZG8gcG93ZXIgb2ZmL29uICovDQo+ID4gPiAgICAgc3dpdGNo
IChpb3MtPnBvd2VyX21vZGUpIHsNCj4gPiA+ICAgICBjYXNlIE1NQ19QT1dFUl9VUDoNCj4gPiA+
IEBAIC0yMDcxLDYgKzIwOTUsNyBAQCBzdGF0aWMgdm9pZCBtc2RjX29wc19zZXRfaW9zKHN0cnVj
dA0KPiA+ID4gbW1jX2hvc3QNCj4gPiA+ICptbWMsIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+ID4g
PiAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICAgICB9DQo+ID4gPiANCj4gPiA+ICtza2lwX3Jl
Z3VsYXRvcjoNCj4gPiA+ICAgICBpZiAoaG9zdC0+bWNsayAhPSBpb3MtPmNsb2NrIHx8IGhvc3Qt
PnRpbWluZyAhPSBpb3MtPnRpbWluZykNCj4gPiA+ICAgICAgICAgICAgIG1zZGNfc2V0X21jbGso
aG9zdCwgaW9zLT50aW1pbmcsIGlvcy0+Y2xvY2spOw0KPiA+ID4gIH0NCj4gPiA+IEBAIC0yODE2
LDkgKzI4NDEsMTIgQEAgc3RhdGljIGludCBtc2RjX29mX2Nsb2NrX3BhcnNlKHN0cnVjdA0KPiA+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ID4gICAgIGlmIChJU19FUlIoaG9zdC0+c3Jj
X2NsaykpDQo+ID4gPiAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihob3N0LT5zcmNfY2xrKTsN
Cj4gPiA+IA0KPiA+ID4gLSAgIGhvc3QtPmhfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYs
ICJoY2xrIik7DQo+ID4gPiAtICAgaWYgKElTX0VSUihob3N0LT5oX2NsaykpDQo+ID4gPiAtICAg
ICAgICAgICByZXR1cm4gUFRSX0VSUihob3N0LT5oX2Nsayk7DQo+ID4gPiArICAgLyogQU43NTgx
IFNvQyBkb2Vzbid0IGhhdmUgaGNsayAqLw0KPiA+ID4gKyAgIGlmICghZGV2aWNlX2lzX2NvbXBh
dGlibGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1jIikpIHsNCj4gPiA+ICsgICAgICAg
ICAgIGhvc3QtPmhfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJoY2xrIik7DQo+ID4g
PiArICAgICAgICAgICBpZiAoSVNfRVJSKGhvc3QtPmhfY2xrKSkNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaG9zdC0+aF9jbGspOw0KPiA+ID4gKyAgIH0NCj4gPiAN
Cj4gPiBkZXZtX2Nsa19nZXRfb3B0aW9uYWwgY291bGQgYmUgdXNlZCB0byBpbnN0ZWFkIGhlcmUs
IG5vIG5lZWQgdG8gdXNlDQo+ID4gY29tcGF0aWJsZSB0byBkaXN0aW5ndWlzaC4NCj4gPiANCj4g
DQo+IEkgY2FuIG1ha2UgdGhlIGhjbGsgb3B0aW9uYWwgYnV0IEkgdGhpbmsgdGhpcyB3b3VsZCBh
ZmZlY3QgYWxzbyBldmVyeQ0KPiBvdGhlciBjb21wYXRpYmxlIGJ5IGhpZGluZyBicm9rZW4gY2xv
Y2sgY29uZmlndXJhdGlvbi4NCj4gDQo+ID4gPiAgICAgaG9zdC0+YnVzX2NsayA9IGRldm1fY2xr
X2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAiYnVzX2NsayIpOw0KPiA+ID4gICAgIGlmIChJU19F
UlIoaG9zdC0+YnVzX2NsaykpDQo+ID4gPiBAQCAtMjkyNiwxMCArMjk1NCwxMyBAQCBzdGF0aWMg
aW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiA+ID4gICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaG9zdC0+cGluc19kZWZhdWx0KTsNCj4g
PiA+ICAgICB9DQo+ID4gPiANCj4gPiA+IC0gICBob3N0LT5waW5zX3VocyA9IHBpbmN0cmxfbG9v
a3VwX3N0YXRlKGhvc3QtPnBpbmN0cmwsDQo+ID4gPiAic3RhdGVfdWhzIik7DQo+ID4gPiAtICAg
aWYgKElTX0VSUihob3N0LT5waW5zX3VocykpIHsNCj4gPiA+IC0gICAgICAgICAgIGRldl9lcnIo
JnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgdWhzIVxuIik7DQo+ID4gPiAtICAgICAg
ICAgICByZXR1cm4gUFRSX0VSUihob3N0LT5waW5zX3Vocyk7DQo+ID4gPiArICAgLyogQU43NTgx
IGRvZXNuJ3QgaGF2ZSBzdGF0ZV91aHMgcGlucyAqLw0KPiA+ID4gKyAgIGlmICghZGV2aWNlX2lz
X2NvbXBhdGlibGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1jIikpIHsNCj4gPiA+ICsg
ICAgICAgICAgIGhvc3QtPnBpbnNfdWhzID0gcGluY3RybF9sb29rdXBfc3RhdGUoaG9zdC0+cGlu
Y3RybCwNCj4gPiA+ICJzdGF0ZV91aHMiKTsNCj4gPiA+ICsgICAgICAgICAgIGlmIChJU19FUlIo
aG9zdC0+cGluc191aHMpKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBk
ZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwNCj4gPiA+IHVocyFcbiIpOw0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihob3N0LT5waW5zX3Vocyk7DQo+ID4gPiAr
ICAgICAgICAgICB9DQo+ID4gPiAgICAgfQ0KPiA+IA0KPiA+IENvdWxkIHlvdSBjb25zaWRlciB0
byBzZXQgYSBkdW1teSAnc3RhdGVfdWhzJyBzYW1lIGFzDQo+ID4gJ3N0YXRlX2RlZmF1bHQnDQo+
ID4gaW4gdGhlIGR0cywgdGhhdCB5b3UgY291bGQgbm90IHVzZSBjb21wYXRpYmxlIHRvIGRpc3Rp
bmd1aXNoIGhlcmUuDQo+ID4gDQo+IA0KPiBUaGlzIGlzIHByb2JsZW1hdGljLCBjb3JyZWN0IG1l
IGlmIEknbSB3cm9uZywgeW91IGFyZSBzdWdnZXN0aW5nIHRvDQo+IGFzc2lnbiB0aGUgZW1tYyBw
aW5zIHRvIGJvdGggZGVmYXVsdCBhbmQgdWhzPyBUaGlzIGlzIHByb2JsZW1hdGljIGFzDQo+IHRo
ZQ0KPiBwaW5jdHJsIGRyaXZlciB3b3VsZCBjb21wbGFpbiB0aGF0IHN1Y2ggcGlucyBhcmUgYWxy
ZWFkeSBhc3NpZ25lZCB0bw0KPiBzb21ldGhpbmcuIEFsc28gSSBkb24ndCB0aGluayBpdCdzIHBv
c3NpYmxlIHRvIGFzc2lnbiB0aGVzZSBwaW5zIHRvIGENCj4gZHVtbXkgcGluLg0KPiANCk1heWJl
IEkgaGF2ZSBub3QgZXhwcmVzc2VkIGNsZWFybHkuLi5XaGF0IEkgbWVhbiBpcyB0aGF0IHlvdSBj
b3VsZCBzZXQNCmFzIGJlbG93LCBhbmQgdGhlIGNvbnRlbnQgb2YgJm1tY19waW5zX3VocyBpcyBq
dXN0IGNvcGllZCBmcm9tDQombW1jX3BpbnNfZGVmYXVsdC4NCg0KbW1jQDFmYTBlMDAwIHsNCgku
Li4NCglwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic3RhdGVfdWhzIjsNCglwaW5jdHJsLTAg
PSA8Jm1tY19waW5zX2RlZmF1bHQ+Ow0KCXBpbmN0cmwtMSA9IDwmbW1jX3BpbnNfdWhzPjsNCn0N
Cj4gPiA+IA0KPiA+ID4gICAgIC8qIFN1cHBvcnQgZm9yIFNESU8gZWludCBpcnEgPyAqLw0KPiA+
ID4gQEAgLTMwMTAsNiArMzA0MSwxMiBAQCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVj
dA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gICAgICAgICAgICAgZGV2X2Vy
cigmcGRldi0+ZGV2LCAiQ2Fubm90IHVuZ2F0ZSBjbG9ja3MhXG4iKTsNCj4gPiA+ICAgICAgICAg
ICAgIGdvdG8gcmVsZWFzZV9jbGs7DQo+ID4gPiAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgIC8q
IEFONzU4MSB3aXRob3V0IHJlZ3VsYXRvciByZXF1aXJlIHR1bmUgdG8gT0NSIHZhbHVlcyAqLw0K
PiA+ID4gKyAgIGlmIChkZXZpY2VfaXNfY29tcGF0aWJsZSgmcGRldi0+ZGV2LCAiYWlyb2hhLGFu
NzU4MS1tbWMiKSAmJg0KPiA+ID4gKyAgICAgICAhbW1jLT5vY3JfYXZhaWwpDQo+ID4gPiArICAg
ICAgICAgICBtbWMtPm9jcl9hdmFpbCA9IE1NQ19WRERfMzJfMzMgfCBNTUNfVkREXzMzXzM0Ow0K
PiA+ID4gKw0KPiA+IA0KPiA+IE1heWJlIHlvdSBjb3VsZCB1c2UgcmVndWxhdG9yLWZpeGVkIGlu
IHRoZSBkdHMgYW5kIGNvbmZpZ3VyZQ0KPiA+IG1pbi9tYXgNCj4gPiB2b2x0YWdlIHRvIGdldCBv
Y3JfYXZhaWwsIG5vIG5lZWQgdG8gc2V0IGhhcmQgY29kZSBoZXJlLg0KPiA+IA0KPiANCj4gQWxz
byBzdWdnZXN0ZWQgYnkgV2VuYmluIE1laSAo5qKF5paH5b2sKSBhbmQgSSBqdXN0IHRyaWVkIHRo
aXMuDQo+IA0KPiBUaGlzIGNhbid0IGJlIGRvbmUsIGZpeGVkLXJlZ3VsYXRvciBuZWVkcyB0byBo
YXZlIHRoZSBzYW1lIG1pbiBhbmQNCj4gbWF4DQo+IHZvbHRhZ2Ugb3IgdGhleSBmYWlsIHRvIHBy
b2JlIHNvb28gZml4ZWQtcmVndWxhdG9yIHNhZGRseSBjYW4ndCBiZQ0KPiB1c2VkDQo+IDooDQo+
IA0KPiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIG9mIHRoaXMgd2l0aCB0aGUgb3RoZXIgcG9p
bnQgY29ycmVjdGVkIGJ1dA0KPiBJDQo+IHRoaW5rIGEgY29tcGF0aWJsZSBhbmQgdGhlc2UgYWRk
aXRpb25hbCBpZiBpcyBhIG11c3QgOigNCklmIHVzZSB0aGUgZml4ZWQgcmVndWxhdG9yIHN1Y2gg
YXMgYmVsb3csIHlvdSB3aWxsIGdldCB0aGUgc2FtZQ0Kb2NyX2F2YWlsIGFzICdNTUNfVkREXzMy
XzMzIHwgTU1DX1ZERF8zM18zNCcgdGhyb3VnaA0KbW1jX3JlZ3VsYXRvcl9nZXRfb2NybWFzaygp
Lg0KDQp2bW1jXzN2MzogcmVndWxhdG9yLXZtbWMtM3YzIHsNCgljb21wYXRpYmxlID0gInJlZ3Vs
YXRvci1maXhlZCI7DQoJcmVndWxhdG9yLW5hbWUgPSAidm1tYyI7DQoJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8MzMwMDAwMD47DQoJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAw
MD47DQoJcmVndWxhdG9yLWFsd2F5cy1vbjsNCn0NCj4gDQo+ID4gPiAgICAgbXNkY19pbml0X2h3
KGhvc3QpOw0KPiA+ID4gDQo+ID4gPiAgICAgaWYgKG1tYy0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUp
IHsNCj4gDQo+IC0tDQo+ICAgICAgICAgQW5zdWVsDQo=
