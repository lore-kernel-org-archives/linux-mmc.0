Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632C2AF1D;
	Wed,  9 Oct 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452962; cv=fail; b=bFmrQj443ecFIlScYwlPtebkqVGqXyWIjhlITb2MoKgkXARmW/QAh2l6i2yEcuuuD2m6iAusZ/Pd+j0JS6LpgNkcAt8l24u2XYwzs9Gdlc7b2G6ziZEkaQ89fR0PoyO8B3HbkAOCrA2HYqlDwK8wOGtlaup7Zz/xjTaYok30eiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452962; c=relaxed/simple;
	bh=Yj5bdaGwBFD2hFLZ+WNyKw3cwoUum1W/QYr11A9enT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k61qkQYbSmLx/T75Vlzr1yP/faxRstD+ZH6wszFEjatE1csunYBaB+8Ayjt4jE5vjL77hf+PNhwuLwX02epKY2NIRKu1FUL2160VGsYOJX5qoaBDBkO2a/uUtrX5eT0g4hLBLam2UfZv2qusbC3ZEV9opUzu02bPyDbBt9r+cP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oV3EG2XS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=koweAyCW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oV3EG2XS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="koweAyCW"
X-UUID: 36311550860211ef88ecadb115cee93b-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Yj5bdaGwBFD2hFLZ+WNyKw3cwoUum1W/QYr11A9enT8=;
	b=oV3EG2XSND5Axqj6vBRM11pBLaJXrcrIkXH7Sqo4AtPbCTSFr9Sj3DIoWpCKDuoVBgsdEsLY7tE40AQ9EqzPBKsoIR4sxqNDUXGG0tEQpv6NZYKxI8qdvwbyFteu8BKqhVRyG3hSH1XIXnVBK6LR955XbIHvtNkHGOt6wCJqb/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8ca72cbe-1f91-4664-a19c-c96913a01dfd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:d617f964-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 36311550860211ef88ecadb115cee93b-20241009
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 411466175; Wed, 09 Oct 2024 13:49:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 13:49:09 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 13:49:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBGDS5Op9S8KMIhggcDzuFmfT317W/wiIhrnJbN1QsoHydg/tnB5FlDRInkzJ6nerMAGAM09Z/mJQmfNEPpaBddGK1By/mxOrM0ELAVD30etnlhHY2ED1vPNx9uw5BNIRSZD3THxfLpTm6HzvFBQxqDyRv9Xsod/zQEPe6bxVn6+3lYHmGnKdqbtsT+v4r46ZFcFvZ/8TyLNYY5w0cR+LAeRultwpNhufEQSxytdYtQTVp4vR18YGXkOS42zG9vBX/dkkaHiBNXpAhnIuzvCWvuw+Uzf54aCyisx1tZcLKwEqfoyXGMvHVmWPau+3TBtgR6ESoDv7sgcRAnDOd3zrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj5bdaGwBFD2hFLZ+WNyKw3cwoUum1W/QYr11A9enT8=;
 b=rxJ1ard3/ekd2eS+5ABXuqVfM4n2WzK405726/cpyLk/O9hqN5K8d2UY6yCUXldm8PsggSAstJT7RKgjwJdBha1nhrUYW09/19THHTCCwC+ioGy51xJU5CNtSc9mfJbQNgVPMgOa4IEh5tzOtGtI2HaTJTd64Uss3RLG3DQl9egnOdtcYdDQRPtNP/mr06VLDv8iTvIEuP1roVOZhMfMVsb+AdcK0yTbWyhrsVVjoRbLkdjytOk49DvBv4NvfPrC77ozwsgmGpRGL8zV4H4NQr+bOBczt2kaKPvcdDTMNpfFpNPGYm/z+bcL11C5OM4Ijikzb5tDqnI9WcuQ6Dts+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj5bdaGwBFD2hFLZ+WNyKw3cwoUum1W/QYr11A9enT8=;
 b=koweAyCWQLNsdw3CPs/45Naw3I92yXTYEfjZS7m+IAK8aMhpcMK7a1Xv92tECbcgO0qv+mYmpSfIn0EhxudnUgDjL//CGGcP7aeMHJ55mbhCSHgFDQ4Hvd0KlYLW41N53diTb70/zG+s2EeG8TlrVHhl0ya1XkG46gHnrVpySx0=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by KL1PR03MB8474.apcprd03.prod.outlook.com (2603:1096:820:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 05:49:06 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 05:49:05 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Thread-Topic: [PATCH v2 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Thread-Index: AQHbEkPAlvAK6xN4I0eadS4mf9LXO7JvKzSAgA7OKQA=
Date: Wed, 9 Oct 2024 05:49:05 +0000
Message-ID: <fbf8987f6b9428637342e73454ceb57ef0151b09.camel@mediatek.com>
References: <20240929074558.2076-1-andy-ld.lu@mediatek.com>
	 <20240929074558.2076-3-andy-ld.lu@mediatek.com>
	 <wuhrl54ojj4sjbk3qbm5jjgeupznbs4uhfedogmucjhvnbjbeh@vwvpeuiwgwli>
In-Reply-To: <wuhrl54ojj4sjbk3qbm5jjgeupznbs4uhfedogmucjhvnbjbeh@vwvpeuiwgwli>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|KL1PR03MB8474:EE_
x-ms-office365-filtering-correlation-id: 5dc2bcd2-af8e-4786-6550-08dce826163c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V28zNURNRVBnamFKTXVPNm9zVjFOZkFLcFVaYWhpU0lSM3g1aWhCWXNmekNB?=
 =?utf-8?B?WS9oUXJ3WmYrRDYrejUySWRXZi9kWi9uWFkyL1A0c2lQcWpFYTNsby82WTNN?=
 =?utf-8?B?M0VBait4QzVCb3diSktsWmRSSkh6Z2QyeTFMbE5qSEVzeWdXcmFlQjlCVjc5?=
 =?utf-8?B?WXEyYlpET2owbDk0OElSTi90andORm53MHk0MUtIVWJRREhtT2tLYlc1Qm14?=
 =?utf-8?B?NjltbU5wSXBwK1h4Q1hmNWtOQURrNFl1R0FIRXpLMys5R3VsaXB0aVRlTkYy?=
 =?utf-8?B?a0RWa1BNNjIzalpyRTJNeWt6U0xyWlhmMWxaMHc3ZzBuL2VwS0dZR0JnQy9X?=
 =?utf-8?B?anZKUUdjbXI4QXhNWUZwR0x4QnNnQlQrVmt3d3gxZHJDcEpEWHlRaU1haURz?=
 =?utf-8?B?c1JubUlqTnE3eStrY3ZlZUs1dzUremg2WHlqQVZrV21aeU9RcGNoV2VRemlx?=
 =?utf-8?B?cU9XSHlzK2dwb090Zko3TU91SldGQWtNdmt3OTFnUWdHSEZPdk9vMkt5Sndh?=
 =?utf-8?B?SWNNQ24zazc1dmJRTUpBeTFwU0NvT1pYUy9CdWpvdFpCbXBtOE1ITUh1Q3R2?=
 =?utf-8?B?b2NoUXptV3NwbjNsWFBiN0N6cDVYT250SEgxNzUvWlFXWWpxN3Zjc0daMi9W?=
 =?utf-8?B?VCs3NVo0NFlOQldGc1ZBTDFrZmRjNDN0M3VRWEtBZHV6VHRqN21rKzR0UXhq?=
 =?utf-8?B?NHZPME1qN29senB5U2pBMkpwVVFnWDdNSkZ2UjBTMUZKZEdjNWtYTklmYWtV?=
 =?utf-8?B?aHNjVUQ0Y3VrUHBhK0ltNG5ZSVNCcTBsWTlKQzBURmVtQ096cjlZdjJtTkRS?=
 =?utf-8?B?S3VFbTMrS3JtcytGeldYaU9UR3JqRU1vMUJ2NGMvOWw3K1RqMjh0a1IwSWxR?=
 =?utf-8?B?OHBzaC93ZGpCa21Td09XQ0xaQ0tyRDE1STZUVk9uY1dtYy8xKzJRMWJ6UkJk?=
 =?utf-8?B?dmdVdW5FZk0yUXpBVEQ1d2cwWUxCcXdjQndnVXJLcmFTWUFJSmlhTEx3THJr?=
 =?utf-8?B?NW9kS1hRbWpzUmpzR2ZPUmVKMDBoMzhxNE8yNGtrQkhnTTVpVWJpaDNHZEh5?=
 =?utf-8?B?MTEya1U0Q2doQzBsSFU0K2JYOVBIQWFXNnB5TjFaRmpDcVFMRm1pWU8xMFJ0?=
 =?utf-8?B?OVgxcVJyOVZNb3pGa1E3cmR3TjllOVRudUNSbExXVEtlQW8vTnFiSm0zZlha?=
 =?utf-8?B?SGFkbUY2LzJibk4wdmJZMnpZZGhrNGxJR3JrMHBub3BXZVhTd2FLT2UwOEkr?=
 =?utf-8?B?QjlEY0xWR0tndklwckQ2bGRpVEsxbmluZ0paTXVyVnJNbmwzZjlYL1U3KzdE?=
 =?utf-8?B?cWZncU1ibU1PWlU1SE5ETGdEV0ZRQ1JJRnVFSE1YMjd5b3E4UnM5S05GRG5t?=
 =?utf-8?B?T1RxSmw2b2tTN2dIeXFqMkJRY0NhZm1jdk50SnhJQ0ROUWZ1TGR0ZUFweGpO?=
 =?utf-8?B?dGsxQUh3MWEvcVhTSmY2MUZrTXZWeTNyaWJ1WnpFVDkvZndnaFVQR0tHNjZk?=
 =?utf-8?B?RkxvbGI1UUpxc0Y0eTVLVG9wYXBpN3ZwZ3pwdlBITVhXdHBTQmNoWkZhU0Qv?=
 =?utf-8?B?YkRNV3MwZDJmSXdVQ0ZPWVRJKytlRTdvN0JKaEFFcGlIZ2FwK2UvRW1TZzRS?=
 =?utf-8?B?ZHhxaWtBTFcwRndmTDlwMEwxMVpCM05sTm42RGdGc3BxZ1F6cCt1NlQ1T25j?=
 =?utf-8?B?SUVrOVlpUnU5ZERRdTBTSm0zZ1hHSW5FdW5ob0dBYXdxdllKazk3RzlUeUxM?=
 =?utf-8?Q?EigOgB1xMsypwjHECv8qckQZfm7QIysTNGE0WrH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTA0cnk0bkFJRnd1T3RKSFpKWFN6ckM4V1JRREVqZEdmbG85Nk1wS3A2WWI4?=
 =?utf-8?B?OFU2MzY1TlhJNFFVeG42bjF5SGFBR3dnRTllajR0MWJ6bU9Ld1FvRWQ4Mk53?=
 =?utf-8?B?eE9EbmdzNDNzY1E5UldUTUwwMUNDaFRIZjJtTFBLV053eFJtOFliTE5pNkVE?=
 =?utf-8?B?VTVYRVhJWjZ6SDgrNEs4VEpGZzA1bjBvRHlKeWxaUzZHQmhwakFQaGI0cG1y?=
 =?utf-8?B?aE5oOWRSalNvZTZjbGU2TFNHZWZUSE1IRzgreWhnZVFLNHBtMGVhS0Q1SExE?=
 =?utf-8?B?MEJaNk1sYkZHWG9IMkRIdUlwRWFOSXQxNE9LWWI5Y0ZaN3NXamU4cmVSRTdv?=
 =?utf-8?B?THRyOUN1Q24zbEg2TWFjRWZ0WjdKMmR3TVk2QTBUa2lhM0xWZWx6SWlEaTlI?=
 =?utf-8?B?ZXVYbVpUNkc3Q2Z5SE9HWjdkOU51VHhNeDQ4c1FsTzJ6b1JKOENyU0lpOSs1?=
 =?utf-8?B?UlR1TzZFK01JZjNxejNJSzB1RFBVMUk5VE40Qk40MER1WUp1M296bWRqdkJS?=
 =?utf-8?B?MDA4ZW8wWlovdVhJNEI3VVhwajlSUjhCRE4ydjczZFVJdGk1ZDBqL1dwMGRk?=
 =?utf-8?B?YXRuS1YxZmU0cWo1RHRIeXNpb3FTTVRZTG01Zy9uSGRxWEhBeEdHd2ovYjVj?=
 =?utf-8?B?aTJqT25WQmVacmhFeHFUU0pvbExFdVlKb0lrWUZhWlVIYmZCUWVsR2R6RzY2?=
 =?utf-8?B?QjhzRFQxQjFpTmdUemNPNTFVUHdYbDB3R3VGSW9rOWo3bVdpdzFBWmxIWWZE?=
 =?utf-8?B?NTk5Zm84S0ErTDl5anpzTEVwdy9VT2lTaVhGRlJaOEV4Nlc0dUE3R0VKUThi?=
 =?utf-8?B?TFllQ1hjbGtQM2h0L1RTZDdHNW9Wcm1IejV1ODM4aGpKbkdTVnUvbHJ3ejRX?=
 =?utf-8?B?SlEwT2FMSTA1S3B4L2dJV2xucUtTNVVCRVhlbzJ0VnpFekdiUDNCOHhaQkJn?=
 =?utf-8?B?Qjk1a0VWR1gyRGZLazlrUzF5SHNOcyswMWVGZVhDamx2eVlPK3A3ci9GYTY4?=
 =?utf-8?B?MWNEMHlOeVFMSHVpdDloSzVyT25ZZnR1eGJLUTNiS0thc0ZwRjFJZTliRmNJ?=
 =?utf-8?B?Vzd4VVRiT244NGR5OXBlMEtDSWFyRm1LeDZwaHR2UVZGLzRGaVV0MUtUQVI0?=
 =?utf-8?B?Q0t4YWF4cjFWamVpVEhtcWFPL0Q2bTBYUDBaNjRXUVBzY2dUcjJyRHlUMWtB?=
 =?utf-8?B?ckVZSUdBRHdBbEtiOVhNaWVLb1dPdFQ1OVpYSlBzMVRJNjBpMHQ3L2ZDeTVG?=
 =?utf-8?B?OUg0bnpHaXRpWUg1T2liZmwyZlhDOFlXUnFyT0RHc3NOK04rRDZCN2dJUTA4?=
 =?utf-8?B?Q0hHZWVrSGF2bnNUQ2NiMXdJc0ZRa2lIV053UHlVV2hRdVpNUVpZSHpWYlEx?=
 =?utf-8?B?QzQydzdWU1BjdFFRbjFVcXZoTW9IdFYxMVQ2YktNYVIzWUJWNGdxdlRtVEFE?=
 =?utf-8?B?dkNnN2ZCdUJuNnpxMHNrYXRBWFFZeFdnNFg0SUZnVUVQN05xdTNnWlZTODNt?=
 =?utf-8?B?LzVGamtXMnNyV2tHQ2VIbkwrMU96K082VFRiYlNuMXVrcnVEc0xwZ2N5Nm95?=
 =?utf-8?B?YWE0U1ArVDBNWlowQUhpNUtreDlQUFo5ejdDOTZ3WGQ5azFhWXRDS3U3MFQ0?=
 =?utf-8?B?TW5wbk9hNTJJQm1lak1RU1l3QUhGcGFuMTJmQnVTRG5GY2xCYmkyUVN0bHJ2?=
 =?utf-8?B?cUxENWxvTWs2Q29yMU5OTmF1bm1iTEs4TVpFc1FOampybHRJWldvWW9kbzJU?=
 =?utf-8?B?T2k4VUhiUVhjOGJ5N3ZibVdiejdKVzczVUFVSUJLdUJKMkdxYUgyaUpQdFlY?=
 =?utf-8?B?T3A3aGNJc3hCd0xkVzA0OGtMc0p5K2htcU1VR0RUcFU2aS85cWFzaFI4c2s3?=
 =?utf-8?B?WGZGOFVIWjRDLzlmanQwUDMzYVRLR0tDeFJ4ZXAvdm16Y285L1RlREg3SFkz?=
 =?utf-8?B?QTREQnBhenpydzgwL0pVWGpmd0dzRE5pdzBFQmtLLzVzQStMSHh5ZUhpLzJm?=
 =?utf-8?B?LzFmLzBuUFJwU3c0ekJFRWhvOUlqZlhPZTI2OEgvMEVVc0ZlUjNVdCtFYytB?=
 =?utf-8?B?cCtYUTBzWjAwZ2o1MjlkQ2JrODdOclNiU2k0blhJRzg1UVM4UHkwM1hPMnVr?=
 =?utf-8?Q?OfXKNig0XCtQ8+Pnz9J3ETw8A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF5B9FBC024CB846A51910D0C03579F8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc2bcd2-af8e-4786-6550-08dce826163c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 05:49:05.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKAAfX6yHzl7O3+BxFwG3joLgu+CqJnmehzp/7UM3FeITO+PD+oB1FiZi6Kx5Ni7V0SLyd+OB37g0EUdYIMgCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8474
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.489600-8.000000
X-TMASE-MatchedRID: TDQWNTPftUDUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2toxWB033D5MJ1IdjjHRSNCdqCxkzSpW/XxQ6
	3oxCOYOBY1mnSrfjG8HXdOQc5s1eBaomuA4GYbqrAJnGRMfFxyX0tCKdnhB58pTwPRvSoXL0ir3
	kOMJmHTJqmHXeu6cAa0C1sQRfQzEHEQdG7H66TyH4gKq42LRYkGGvQ1te8lKAMwfRcRPo2lpwrA
	USCU2ym24KLkwo97xp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.489600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	98168596EFB5AFAB8738FA7F245E6DA483A72648C47BE4D122EDEAE82C0F13132000:8

T24gU3VuLCAyMDI0LTA5LTI5IGF0IDIxOjQzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIFN1biwgU2VwIDI5LCAyMDI0IGF0IDAzOjQ0OjA2UE0g
KzA4MDAsIEFuZHktbGQgTHUgd3JvdGU6DQo+ID4gRXh0ZW5kIHRoZSBkZXZpY2V0cmVlIGJpbmRp
bmdzIHRvIGluY2x1ZGUgdGhlIE1UODE5NiBtbWMgY29udHJvbGxlcg0KPiA+IGJ5IGFkZGluZyB0
aGUgY29tcGF0aWJsZSBzdHJpbmcgJ21lZGlhdGVrLG10ODE5Ni1tbWMnLg0KPiANCj4gWW91ciBl
bnRpcmUgdHdvLWxpbmUgc2VudGVuY2UsIHNheXMgdGhlIHNhbWUgYXMgY29tbWl0IG1zZyBhbmQg
aXMNCj4gcHJldHR5DQo+IG9idmlvdXMgZnJvbSB0aGUgZGlmZi4gU2F5IHNvbWV0aGluZyB1c2Vm
dWwgaW5zdGVhZCwgbGlrZSBkZXNjcmliZQ0KPiB0aGUNCj4gaGFyZHdhcmUgZGlmZmVyZW5jZXMu
DQo+IA0KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24sIEkgd291bGQgdXBkYXRlIGluIG5leHQgY2hhbmdlLg0KPiANCg==
