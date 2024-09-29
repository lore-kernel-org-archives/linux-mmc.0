Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209D18641;
	Sun, 29 Sep 2024 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727589054; cv=fail; b=ek8augUYywMSaRTu8eGbipnGJjIOUjLDvUNOqCKf575qHxXkdYW/3b7jgqXD2SY/SlTfyGDDcQk2mg66G55HFbSd87gAg3qyzJMX3EUn7j9o5+uqhutHg779dqwGr9QBt/+MnalqNKsjCqDVQzE4/wQPqfV6/B+CEXTlJoHMhbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727589054; c=relaxed/simple;
	bh=qubiNuZ+u5RBjLTYRvpf+g84nn9vTEaBmTB0+w2WweU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJToXRiRat1DwwKOCKLFa9MqXaarJ+n+LZKTg/GAS00qh6PXbaDI+yt3N0KDjPH2EVibZAFRW6pRACpI+Odf47HLX2HWg3T19cpWxH3s/fDtJTBKR4qO3pAL0kCZlayX4GPmK+Pc/jrQyZcrbm/N2ez0h1NuCE+jJolGdn4p2ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ev4kehh/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JnbsZFm5; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ev4kehh/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JnbsZFm5"
X-UUID: c4cd7f307e2611ef8b96093e013ec31c-20240929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qubiNuZ+u5RBjLTYRvpf+g84nn9vTEaBmTB0+w2WweU=;
	b=Ev4kehh/7b+rhl1nziDoqZJ5V3K/1XA4gsnzb5Eamgez6IxMw/DUQ1jn1LduDQkVED1wESWW8ObQTHihihLF9Kiu0JQM+mY1spg3yfllqowi2BaEIDaYueE5TrjSGlDZ/jJpYM8G48w33BupfMqCbbzjsRGoTYfjJ9n8+TBTe5k=;
X-CID-CACHE: Type:Local,Time:202409291344+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5aa68683-1389-4b78-bc27-06aa76d3f579,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:7884b99e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c4cd7f307e2611ef8b96093e013ec31c-20240929
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2100349172; Sun, 29 Sep 2024 13:50:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 28 Sep 2024 22:50:43 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 29 Sep 2024 13:50:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+UWFtarpqual+dIPMbdv5pdWgS2LVfiAMLjvLv4WOMojZ4kkNAg0LOL0OyCoOBxJOgzvL4bOXhla0kK7vYWsYugzozmNw0QN92mKE/otHjMW5u4hKsom6S8As58pY632nXXQLdWNd7PUhHscvyVEoujiLvXA8RdP/D4eFy8BQZ7WLkALgZ29Vi41oevtSOeR9vqisOUl4oxaFeuVoH+pFpWXjA3OhZWfjTgfyIMMBY8giYGaClx+cym0d713TGKLPXidvIpGlh3+XWdqlY/tcEFDa5+7Z6e8Lj8cY4NF5y3oPdr06tvaimDRgHUL+2xQNz4WcE2kBecwgqbuawmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qubiNuZ+u5RBjLTYRvpf+g84nn9vTEaBmTB0+w2WweU=;
 b=CDzqabSMuzueHKvxe2/TOUpKyATqBc5z82uuGJIytID8nLWtz5KvXRRCa1fMOTsuTbDIdlQl0xO5BRAneWwaQgcnJ6l8a0nUncNOn/FRDDY0gbOWsB8L7sRssqgyP2h0KAeL23x2/N/HlCI/rqxTFCYvQ25CDKVG9nEXVWf/l0wQ9ksAsixlzyhGuLBVzuS2/MfI51XDAOcMQ9CEyaqYCW1f5ePSU7rHzb+Jl8nDyIS5sn2YF9s7aTWfp+sQMqxYx/dHpfu89sGPbcLbrvTPDOJb/M+6aYGcNtIf6kKpu17H2HfKNB8EB+eXsI11QIkXrAeY7zEpyXjscrRho691Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qubiNuZ+u5RBjLTYRvpf+g84nn9vTEaBmTB0+w2WweU=;
 b=JnbsZFm5Pz/zfFjJGhkNEtAkYO51mrqXK0P3Y3Hi8lWyhE97e9cKrjjL1jrNa2TRuKP0D3w0o6iqkVt3lc/LKKkGuzBM5mCumZQ81CBeOGtwvW24p9bFRMOC6m7Bfc38EOTnCf786La3840VxJapWMl4Qlinjb95L+JzVhUvS3A=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by TYZPR03MB8840.apcprd03.prod.outlook.com (2603:1096:405:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 05:50:40 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.7939.017; Sun, 29 Sep 2024
 05:50:40 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Thread-Topic: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Thread-Index: AQHbD+Jq80TZI8etl0C24ZUXGSUna7JqWmeAgALWY4CAAAc0AIABDz8A
Date: Sun, 29 Sep 2024 05:50:40 +0000
Message-ID: <0736d8a7584b1c3cf3847e138ebff1c1b4f47dc7.camel@mediatek.com>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
	 <20240926070405.20212-3-andy-ld.lu@mediatek.com>
	 <20240926175409.GA2644361-robh@kernel.org>
	 <10ce6e9af6daa69735f46b45028ec1b2d25ee66a.camel@mediatek.com>
	 <30e4735e-bf50-440c-8ad1-6bcf8b8bd930@kernel.org>
In-Reply-To: <30e4735e-bf50-440c-8ad1-6bcf8b8bd930@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|TYZPR03MB8840:EE_
x-ms-office365-filtering-correlation-id: e7db8a07-73df-42cf-8ccb-08dce04aa699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TEdzVGxnZUlvYjRkclF1ckF3bG95eE5FVGt1cVdSRTFvcHd6U0pJcjJ5MG05?=
 =?utf-8?B?T1IwYVJUSEt5LzNJclpHbis5MkErUlZISjExbng2NGJiTUhKWWJkR1UxVWRy?=
 =?utf-8?B?K2h6OHN6OVRLcVp1RWZEa3Q5bTBxcWVyNXlOOXU3T1VZNndhbHhNTlBNRXdx?=
 =?utf-8?B?Ri9ySTRsM1AvaHdMeGdjclhxQTF2dVg2N2ZhMHdYNVlFTSszMHpsb0VZOXps?=
 =?utf-8?B?OVdGaG1wMWp3anY4ZG9yUXF1UjBFNU9ndmc2WjEyOFNpR005ZnlmbGRncTd1?=
 =?utf-8?B?RkZhUEZrZ3QrSHVPQ1pYS2RVRENwOUl4YnpKYnl0NkF2Q2kxdm1abkVRSFVO?=
 =?utf-8?B?eVdKaXJBZ2wzbjZ1UWREL3Z4ZUdPYmVYT094bGFMZFZ4dCtibHg0M1k3eExj?=
 =?utf-8?B?cGtCTXJZczl6RWd6Y3JVSnBYT1dvQTA4UVRxZnhFR3MyRW12M2xtM2RDc3Nt?=
 =?utf-8?B?VzlWZHBLNnNhbjBCZ1p6TWluMDN0RVdzNDRlYWFaMDdkN0IyQXJlT1hSSnZQ?=
 =?utf-8?B?ZnAxV0ZZL0hjYnR0bjNCNzNzRExWeE5hNkIxUEEvYjNSZXZNRE94YTd0VmdM?=
 =?utf-8?B?eUdlcG9zRmFXM0RTUjRLVlBJRFB0TzgzNEJnbHN6bGxqeGhlVERqQkI3MW9o?=
 =?utf-8?B?eFdpZ0hvbklycEd5bytNK3RDWnArUXRjSTkyeDNMMGlXdU1lcHBXaUpObHVG?=
 =?utf-8?B?Z0tnMkQySkd3aEpmcHJrT2FGa1hzbDZNMVVIUnFvVmxraFMrVWdyZDhlNzVG?=
 =?utf-8?B?NWdkSkFFT0U5U3RhdDFVSy81YlJOTmEvRUE4UERnUW1ielFDU2xZd3V1aENM?=
 =?utf-8?B?c2ZPeEVoZ3FzTmZCV1Z6SVJjMk50UnlGYUFNTVBmOXljaGtMeEp2RE84elhH?=
 =?utf-8?B?QUhleUI2bE16MnVjWjA0cWxYU05za3haZzV3OU1kalo1TXlVSmw3bW1Pd29F?=
 =?utf-8?B?RExJV0pMYVdXS3ErU0lCOHZUS0w0QUlBTENGVHl0NWo0Wm1FUnZNc2pEQTJV?=
 =?utf-8?B?QzBSOEo0L0h3SmIwbUhlTU5OT3RvTDZ2SnJQTlJJTkRvaUlxSk96cG1nNjJo?=
 =?utf-8?B?UGk0U0lBek04Q1pPdU1PbXd1UThrQS9hNVhINDBJQStRSWdRVDQ4cmtmUEVE?=
 =?utf-8?B?d093bHFvR1lhRlBWaXJsMXhFa3BiQ0VkamZsMmtYRlN5dzBUMFVlYndTNU5k?=
 =?utf-8?B?ZkhiYWlEZTF2QVFiS3JLdGpYSDJsRzl4NmtsM1dSU2RMRUgzbHZHdGdTcHhO?=
 =?utf-8?B?WXhmZ01DUTdNU1Z4Wk5PdWlsekJDWUIvSHFjMVhkY1pSK055YkNheXdHRmk5?=
 =?utf-8?B?R1hiVWpUTUxVYXVCb1hIdHpmQmUzTWsxTEhYNGxadzhub1VrS1ZFL0RHdXRS?=
 =?utf-8?B?RTZLV2hXKzBHQ3FUMk9sT3JNdVExdmtXRUVZeU1XVk1aQmYvMmZmK29WdGsy?=
 =?utf-8?B?MzRNV1FnZ1gxcStrRFQ0bWY2WkU3bUlQTjdSZm1SV0tlWVA0bmc5cnI0UFkx?=
 =?utf-8?B?bzZnMURLUFBSSlFDREpPSHMvVXdQNGlOZmoxYXdFYmlrVVd4TEVSWmVhNnJW?=
 =?utf-8?B?d0QxVlZKUnlvOFUyUHo2clVuS2VHcGp2SitoZ1oxajNkRUZaeFB5bUpjRXBy?=
 =?utf-8?B?ZWdSYkJpTGF2M2ZtR2duczNJR2dlNVlRdnc4c0xqSG1ndlhHV0FxclVLKzdR?=
 =?utf-8?B?Z2RHbWJPTTBTNGtYQ3dJUCtpMWVkYVRqYzdvOTY0bDF6eUZPNUR5T2x1cjJV?=
 =?utf-8?B?amV5TlJDVDY0ZlhxNkhhLy9tcjA3SjRoQzc3MHhWWS9LMWx1bDR1OE0rZnI0?=
 =?utf-8?B?OFNyY0tPVy9vUGR3Z3g2QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3huTzdPR3E4MFE2YytpdUY2S0E3ckMwMTl4WkZvdjh4cDl3SGdhSDAxOHQ0?=
 =?utf-8?B?SS9udjhHcnZ0RFVkSTg5OGZRbXc3Z0NTQkNOSzgycEh4YWtrS09YZkExVWdF?=
 =?utf-8?B?K2QyVDl4dE5wK3VycmFwYWxuMWcyNjYvZmFQcDlLdk9WcXpEbGRUcVNIUWZa?=
 =?utf-8?B?QWtKWDgxSVRieGs0VVJ5Y0gxOVRaRVpXcjIwUTVsMUlXbExsTDZ3Z0IwdVdV?=
 =?utf-8?B?NjRUWGt1U1FyNXVER1NWenNmS2lBRmpLcCtTS0dsdkloYUZsUVVGT1VDbEJO?=
 =?utf-8?B?cHhyYzlSMTZLblN2MEJMZHYrd282MlhxS0JRNmRYV1hXU3RGaitwSkc5ck1r?=
 =?utf-8?B?MmZoL1F0YTdQQ0ZsL2ZPMmJlMWthdEpJM3FueXhucVdyRXYyWXZoSUhGcktB?=
 =?utf-8?B?YnRpRXp3ZHJJbzI3anhIL203bTRQTXpMbjhRMWtYcUVRQUVGNjVPSlpEdHFi?=
 =?utf-8?B?UEhSVEwzdVo4eWtEZUNnNG5LUzJnaEYydmN6OEFhYUM5eDFUWHc0OEowK0dx?=
 =?utf-8?B?d09RclBOZFNkVTcrbXhXYzRLOU9WdUUvMTJlemJFTnpqR3ZjSDR1UXB1M01j?=
 =?utf-8?B?Tzd0Um1KemRpQmpZQyswaEcwUlplMm5Td3VoTXJEYTgwRW0rUFF2MWw0NEZW?=
 =?utf-8?B?ck0xcDRIRFlqZ1Nsek1GaVY0aHN1ZkFkdFJNR3JPRFNEaXFLMnlYd0hXTUZO?=
 =?utf-8?B?RXdLTTd4UWI2amRjcm05WVJnS2VpeGhLSTlDQ0tvWEsxYmdwM09selRXWksv?=
 =?utf-8?B?dzBNZXhpcmdpODJCWW9kbW9YRWZQU3U4TDEzeEpSVDIySlc4YkpiSFE4Nmtw?=
 =?utf-8?B?K2V5RTRoV3JTcVhWdW1oMjJSQm5IRzI3eUtpcTdvdWhLMHdMc0lROW5VZ1Fn?=
 =?utf-8?B?U0RFTDgwUVFDZVkyK3hOMjZOREdEVEE0YnlQV1NZWVo2SktVdFRVWHE5MzBU?=
 =?utf-8?B?dkhoRW5TV3EzelA1ZVJSYXpPMTlXM0NGQWVlcWVrbVpHa1Nkd2l4Zmt2Tkgv?=
 =?utf-8?B?cElyTDBBMTkxbG5WcGM0ZVpTM2tkUEl5QTJPei95UTlmTjNqSkMvenFQMHV5?=
 =?utf-8?B?SksxeUNMMDJsS2hNOGV2SXpQQXJtLzVkdG5UeHpvYTlUTEY4N0o1T3BCUEZr?=
 =?utf-8?B?WG5UNUdTdlVVd2hyV0VoMWgrdDlCSk1JNWFPVldEUFdndkRLL2JJQlhFenFn?=
 =?utf-8?B?czY2YlNOdU4waG1QQUVJNEdFYmJ1R0ZYSjlWU1FZYk1RemU1alduV3lka1VW?=
 =?utf-8?B?MjliczljdnRYZ3pJN2tBR2F0T0Y3ejVXVnNwWFRRKzNEVFhSMkVnVXYydzgy?=
 =?utf-8?B?bUZENjFJdTNlK1VncDFYdGJqWjVLSEZkc2RCcjZFVXl2c2xFdVFBV1lDZzF5?=
 =?utf-8?B?R2t5SUJFZlFzS2FRdzNjaG56Sy9ldWVVVnVFV2NGdFRTWitqenlmaHlwTWpy?=
 =?utf-8?B?Q2E1MUdqM0QyTkhZcVhKd0tEMWRnaXRScytSdmRCRkJGM1RXSmJrR1ZXRWdo?=
 =?utf-8?B?M0hpUGowL3R2ZjdWWGE3dHpzMXgxeTNZbDJoWWh6Ym14a3BHRHJDdzFPNzVN?=
 =?utf-8?B?enZJYWFYd29wbWlQMFNlTDduWTVESU95bHBDZnB6MndCVEpZcDd4WHNmd3h3?=
 =?utf-8?B?Tk1kaE9zaHByakhtSEc3aTkzTEk2SUVyM3JKOVJIZHBYcG1vd3Y2R0ZDa3dR?=
 =?utf-8?B?dXN5Z25ZaG5yR0RyOGNJNlFsSnN5UUVERjJ3MkowNVFFd3RmZkxERHY4RU55?=
 =?utf-8?B?SElJRVB2SVJsTjJLaWh4UGZSdUlXZWNwd3FtUkZCNVZ6MHJKSmxmTy9aK3FU?=
 =?utf-8?B?dGpSZXpXbGx3MG44encyVWJETXRWY3RLVTVZMWVvNGord0N0TTNGQVBlSWVq?=
 =?utf-8?B?WXVpam9hSU03akY2R2NiNGNNb0hzd0hZRGVlbVVoREtrT0dMRGNmbDRmZTJQ?=
 =?utf-8?B?RGhnVjNwS29xcVRMU2JSWUtadU5YZWd5SVlLeG1wRTM1VVY1MnpVWS9PQk8w?=
 =?utf-8?B?QnUyeTFBVkFBd2dqUDA1bzF2bUpTRnZtODR5clpmWGNpMEZhQjlPT2dGaDhH?=
 =?utf-8?B?Y0J0SFNNZTlGTW00L0pFcVFwZnUyZ1N4ZTJtdnVERW5hbXpDbk1UK1kySlZQ?=
 =?utf-8?B?VXozaFlOVnczL2tqOUFCNG5Rd1FSOU1GbG9qcEp4ekRSeDZ5MVFvSS9OZHBT?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17A53C5666165E40967AC0693CA715B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7db8a07-73df-42cf-8ccb-08dce04aa699
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 05:50:40.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxPd/ArIt75v/KuFn48i71UjUAbA1xf/dWmQ/rpodnr8U+AAb//y4nRSO04gFKWlVcACAzXz3jsoQzIyClT/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8840

T24gU2F0LCAyMDI0LTA5LTI4IGF0IDE1OjM5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI4LzA5LzIwMjQgMTU6MTQsIEFuZHktbGQgTHUgKOWN
ouS4nCkgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI0LTA5LTI2IGF0IDEyOjU0IC0wNTAwLCBSb2Ig
SGVycmluZyB3cm90ZToNCj4gPj4gICANCj4gPj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gdW50aWwNCj4gPj4geW91IGhh
dmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPj4gIE9uIFRodSwgU2Vw
IDI2LCAyMDI0IGF0IDAzOjAzOjE4UE0gKzA4MDAsIEFuZHktbGQgTHUgd3JvdGU6DQo+ID4+PiBF
eHRlbmQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgdG8gaW5jbHVkZSB0aGUgTVQ4MTk2IG1tYw0K
PiBjb250cm9sbGVyDQo+ID4+PiBieSBhZGRpbmcgdGhlIGNvbXBhdGlibGUgc3RyaW5nICdtZWRp
YXRlayxtc2RjLXYyJywgd2hpY2ggY291bGQNCj4gYmUNCj4gPj4+IGFsc28gdXNlZCBmb3IgZnV0
dXJlIGNvbXBhdGlibGUgU29DcyB0aGF0IHN1cHBvcnQgbmV3IHR4L3J4Lg0KPiA+Pg0KPiA+PiBH
ZW5lcmFsbHksIGV2ZXJ5IFNvQyBlbmRzIHVwIGNoYW5naW5nIGF0IGxlYXN0IHNsaWdodGx5LiBT
byB3ZQ0KPiBkb24ndA0KPiA+PiBkbyANCj4gPj4gdmVyc2lvbiBudW1iZXJzIGV4Y2VwdCB3aGVu
IHRoZXJlJ3MgYSB3ZWxsIGRlZmluZWQgdmVyc2lvbmluZw0KPiBzY2hlbWUNCj4gPj4gb2YgDQo+
ID4+IHRoZSBoL3cgKGUuZy4gRlBHQSBJUCBibG9ja3MpLiBTbywgdXNlIFNvQyBmb3IgY29tcGF0
aWJsZSBzdHJpbmcuDQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPiANCj4gPiBUaGUg
bmV3IHR4L3J4IHJlcHJlc2VudHMgYSBzaWduaWZpY2FudCB1cGRhdGUgZm9yIG1tYyBjb250cm9s
bGVyIG9mDQo+ID4gbWVkaWF0ZWsgZnJvbSB0aGUgTVQ4MTk2IGNoaXBzZXQsIGFuZCB0aGUgZGVw
ZW5kZW50IHNldHRpbmdzIHJlbWFpbg0KPiA+IGNvbnNpc3RlbnQgZm9yIE1UODE5NiBhbmQgc3Vi
c2VxdWVudCBTb0NzLiBUaGVyZWZvcmUsIEl0IGlzDQo+IHByb3Bvc2VkIHRvDQo+ID4gdXNlIGEg
dW5pZmllZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgdGhlc2UgU29DcyB0aGF0IHN1cHBvcnQgbmV3
DQo+IHR4L3J4LA0KPiA+IGFuZCBuYW1lIGl0IGFzICdJUChtc2RjKSB2ZXJzaW9uIHR3bycuDQo+
IA0KPiBTb3JyeSwgbm9wZS4gVGhhdCdzIG5vdCB2YWxpZCByZWFzb25zLg0KDQpUaGFua3MgZm9y
IHlvdXIgcmV2aWV3Lg0KDQpJIHdpbGwgZm9sbG93IHlvdXIgY29tbWVudCBpbiBuZXh0IGNoYW5n
ZS4NCg0KPiANCj4gPj4NCj4gPj4+DQo+ID4+PiBBZGQgdGhyZWUgcHJvcGVydGllcyBmb3IgTVQ4
MTk2IHNldHRpbmdzOg0KPiA+Pj4gLSAnbWVkaWF0ZWsscHJvaGliaXQtZ2F0ZS1jZycsIGluZGlj
YXRlIGlmIHRoZSBzb3VyY2UgY2xvY2sgQ0cNCj4gPj4gY291bGQNCj4gPj4+ICAgYmUgZGlzYWJs
ZWQgd2hlbiBDUFUgYWNjZXNzIElQIHJlZ2lzdGVycy4NCj4gPj4+DQo+ID4+PiAtICdtZWRpYXRl
ayxzdG9wLWRseS1zZWwnLCBjb25maWd1cmUgcmVhZCBkYXRhIGNsb2NrIHN0b3BzIGF0DQo+IGJs
b2NrDQo+ID4+IGdhcC4NCj4gPj4+DQo+ID4+PiAtICdtZWRpYXRlayxwb3AtZW4tY250JywgY29u
ZmlndXJlIHRoZSBtYXJnaW5zIG9mIHdyaXRlIGFuZCByZWFkDQo+ID4+PiAgIHBvaW50ZXJzIHdo
aWxlIGJlZ2luIHRvIHBvcCBkYXRhIHRyYW5zZmVyLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYt
Ynk6IEFuZHktbGQgTHUgPGFuZHktbGQubHVAbWVkaWF0ZWsuY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sICAgICAgIHwgMjYNCj4g
Pj4gKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4+PiBpbmRleCBjNTMyZWM5MmQyZDkuLjgy
ZDFhOWZhYzY3YyAxMDA2NDQNCj4gPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPj4+IEBAIC0yNSw2ICsyNSw3IEBAIHBy
b3BlcnRpZXM6DQo+ID4+PiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTczLW1tYw0KPiA+Pj4g
ICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1tbWMNCj4gPj4+ICAgICAgICAgICAgLSBtZWRp
YXRlayxtdDg1MTYtbW1jDQo+ID4+PiArICAgICAgICAgIC0gbWVkaWF0ZWssbXNkYy12Mg0KPiA+
Pj4gICAgICAgIC0gaXRlbXM6DQo+ID4+PiAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10
NzYyMy1tbWMNCj4gPj4+ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1tYw0K
PiA+Pj4gQEAgLTE1NCw2ICsxNTUsMzAgQEAgcHJvcGVydGllczoNCj4gPj4+ICAgICAgZW51bTog
WzMyLCA2NF0NCj4gPj4+ICAgICAgZGVmYXVsdDogMzINCj4gPj4+ICANCj4gPj4+ICsgIG1lZGlh
dGVrLHN0b3AtZGx5LXNlbDoNCj4gPj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAgICAg
IFNvbWUgU29DcyBuZWVkIHRvIHNldCBhcHByb3ByaWF0ZSBzdG9wLWRseS1zZWwgdG8NCj4gY29u
ZmlndXJlDQo+ID4+IHJlYWQgZGF0YSBjbG9jaw0KPiA+Pj4gKyAgICAgIHN0b3BzIGF0IGJsb2Nr
IGdhcC4gVGhlIHZhbGlkIHJhbmdlIGlzIGZyb20gMCB0byAweGYuDQo+ID4+DQo+ID4+IFNvQyBk
ZXBlbmRlbnQgb3IgYm9hcmQgZGVwZW5kZW50PyBJbXBseSBmcm9tIHRoZSBjb21wYXRpYmxlIGZv
cg0KPiB0aGUgDQo+ID4+IGZvcm1lci4gQSBwcm9wZXJ0eSBpcyBmaW5lIGZvciB0aGUgbGF0dGVy
IGNhc2UuDQo+ID4gWWVzLCBpdCBpcyBTb0MgZGVwZW5kZW50IGluIHByaW5jaXBsZSwgYnV0IHdl
IHdvdWxkIGxpa2UgdG8gdXNlIGENCj4gPiB1bmlmaWVkIGNvbXBhdGlibGUgc3RyaW5nIGZvciBN
VDgxOTYgYW5kIHN1YnNlcXVlbnQgU29DcyBhcw0KPiBtZW50aW9uZWQNCj4gDQo+IEFsc28gbm8g
OiguIFVzZSBTb0Mgc3BlY2lmaWMgY29tcGF0aWJsZS4NCg0KSSB3aWxsIGZvbGxvdyB5b3VyIGNv
bW1lbnQgaW4gbmV4dCBjaGFuZ2UuDQoNCj4gDQo+ID4gYWJvdmUsIGFuZCB0aGlzIHJlZ2lzdGVy
IHNldHRpbmcobm90IHJlbGF2YW50IHdpdGggbmV3IHR4L3J4KSBtYXkNCj4gYmUNCj4gPiB2YXJp
YW50LiBUaGVyZWZvcmUsIHdhbnQgdG8gdXNlIHRoZSBwcm9wZXJ0eSBvZiBkZXZpY2UgdHJlZSB0
byBzZXQNCj4gPiBpbmRpdmlkdWFsbHkuDQo+ID4+DQo+ID4+PiArICAgIG1pbmltdW06IDANCj4g
Pj4+ICsgICAgbWF4aW11bTogMHhmDQo+ID4+PiArDQo+ID4+PiArICBtZWRpYXRlayxwb3AtZW4t
Y250Og0KPiA+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91
aW50MzINCj4gPj4+ICsgICAgZGVzY3JpcHRpb246DQo+ID4+PiArICAgICAgU29tZSBTb0NzIG5l
ZWQgdG8gc2V0IGFwcHJvcHJpYXRlIHBvcC1lbi1jbnQgdG8gY29uZmlndXJlDQo+ID4+IHRoZSBt
YXJnaW5zIG9mIHdyaXRlDQo+ID4+PiArICAgICAgYW5kIHJlYWQgcG9pbnRlcnMgd2hpbGUgYmVn
aW4gdG8gcG9wIGRhdGEgdHJhbnNmZXIuIFRoZQ0KPiA+PiB2YWxpZCByYW5nZSBpcyBmcm9tIDAN
Cj4gPj4+ICsgICAgICB0byAweGYuDQo+ID4+PiArICAgIG1pbmltdW06IDANCj4gPj4+ICsgICAg
bWF4aW11bTogMHhmDQo+ID4+DQo+ID4+IFNhbWUgcXVlc3Rpb24uDQo+ID4gU2FtZSBhcyB0aGUg
cmVwbHkgYWJvdmUuDQo+ID4+DQo+ID4+PiArDQo+ID4+PiArICBtZWRpYXRlayxwcm9oaWJpdC1n
YXRlLWNnOg0KPiA+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9mbGFnDQo+ID4+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAgICAgIERlY2lkZSBpZiBz
b3VyY2UgY2xvY2sgQ0cgY291bGQgYmUgZGlzYWJsZWQgd2hlbiBDUFUNCj4gYWNjZXNzDQo+ID4+
IElQIHJlZ2lzdGVycy4NCj4gPj4+ICsgICAgICBJZiBwcmVzZW50LCBzb3VyY2UgY2xvY2sgQ0cg
Y291bGQgbm90IGJlIGRpc2FibGVkLg0KPiA+Pj4gKyAgICAgIElmIG5vdCBwcmVzZW50LCBzb3Vy
Y2UgY2xvY2sgQ0cgY291bGQgYmUgZGlzYWJsZWQuDQo+ID4+DQo+ID4+DQo+ID4+IFNvdW5kcyBs
aWtlIHlvdSBuZWVkIHRvIGRlc2NyaWJlIHRoZSBjbG9jayBpbiAiY2xvY2tzIi4NCj4gPiBJdCBp
cyBub3Qgd2l0aCBjbG9jayBpdHNlbGYsIGJ1dCByYXRoZXIgd2l0aCB0aGUgYnVzIGRlc2lnbiB0
aGF0DQo+IHdvdWxkDQo+ID4gY2hlY2sgdGhlICdzb3VyY2VfY2cnIHN0YXR1cyBiaXQgdG8gZGVj
aWRlIHdoZXRoZXIgdG8gcHJldmVudCB0aGUNCj4gQ1BVDQo+ID4gZnJvbSBhY2Nlc3NpbmcgdGhl
IElQIHJlZ2lzdGVycy4gQW5kIHRoZXJlIGhhdmUgYmVlbiBubyBjaGFuZ2VzIHRvDQo+IHRoZQ0K
PiA+ICdzb3VyY2VfY2cnKGFscmVhZHkgYmVlbiBkZXNjaXJiZWQgYmVmb3JlKSBmb3IgTVQ4MTk2
Lg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBkbyB5b3UgbmVlZCB0aGlzIHByb3BlcnR5
IGlmIGl0IHdhcyBhbHJlYWR5DQo+IGRlc2NyaWJlZC4gUGxlYXNlIGRvIG5vdCBkZXNjcmliZSB0
aGluZ3MgdHdpY2UuDQoNCkkgd2lsbCBmb2xsb3cgeW91ciBjb21tZW50IGluIG5leHQgY2hhbmdl
Lg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=
