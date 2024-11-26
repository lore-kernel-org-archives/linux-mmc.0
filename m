Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD204C8E;
	Tue, 26 Nov 2024 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583313; cv=fail; b=XlaJu8+ad0gduicSDd+JVnnM65VfBdW1gZ2Ae/U2ywHdexFa0U2BK4if2ae7ynYRMdWKHxSV/d2WfyamuoEB69b4gsq2luujuq9i9KZhQRDeMzaiyXbKw+rQjRDbr+Zr3ZgBvN44svAjhZ6701ZZhDC2e1dMxW4zt4jXYO+P4hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583313; c=relaxed/simple;
	bh=N92CmiCxCTAyU+QZYfOqjJiAiyGcGz6Uy7ZqTCD896w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xq9LChnx03Tuu2mBDtaD3iOFc0DjQFybMTSfgzB1ZpjmAqyd50+0407UtUZNQ9SWZpxR75r2qQO0Nac1BsWKUDmzcDuspXD8f+0+0SScxuhnpNqd+9n4XTfK2FUouG+/BTR0VaU6rGr/xzVJdBLBtF5dX9aUXblDw1fkN0jm1ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=elYykju6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MCp530Xq; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="elYykju6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MCp530Xq"
X-UUID: f05ae4f0ab9211ef99858b75a2457dd9-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N92CmiCxCTAyU+QZYfOqjJiAiyGcGz6Uy7ZqTCD896w=;
	b=elYykju6CdLq7yktzzixMTzxOJ8nEp5ys7cGZB/7Pow9Ph6cpieQn1n+6U6e/kpFZY/Mqjf5vCUWNqupDK9YSJZILQBaMdLF1uDIBHxUwgX2juxoAZgWtfHHh8CagnBhzenguxXz9bYEt+NxU4DO8aJizT8h9CP38uL3buB2PC8=;
X-CID-CACHE: Type:Local,Time:202411260908+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:ce9592df-1179-47f6-9205-71c7d14740a6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:86e243e0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f05ae4f0ab9211ef99858b75a2457dd9-20241126
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1755123955; Tue, 26 Nov 2024 09:08:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 09:08:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 09:08:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLUBDrTVXAX8G/gJz2CaRMRWooM3dtjJMuer3YcTpVnIOp1aQyJEO1kB52hG9uoLf1QFAVwTKbWn3NYnsEY42/ylyrFSlkEMMFNphbNkTrgV+pQTDBb2unS7nl3gCe2mDeJUifUPZnp39jS4/KCijueZMxmeVbAYx0/lpoO60Ktg/vevpfMwvhUjyh/uorzVbc9cgKnWXraHbqvIO5cdMHbrU7p2xISBhLQvtGd1Yh5d0SWI8yl/jMJ5NFLaTt/GMy7FV/MvOjOf24lflwsLsO15n6wNi9wfHdFNq5Dt2pWCFWtJfRIUEGycffOS8Z8oPn/HyQ40D192hfJbNqhiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N92CmiCxCTAyU+QZYfOqjJiAiyGcGz6Uy7ZqTCD896w=;
 b=ExyeTo3La4aF+KCaCSsdeO8MkS3hKWE5oi+ZuG8f9Wg1tX35ovmDGWNaoJqmOmrdrO42Se1SZNxtu2SkAu2QUeIjYMSx4ZhSm9ro0vVYka7/ZThK70BFQmePfeoXHc7VECMQDwUCl6DQ85rrU2/G/2pJhdVr/yumJ4d5YZKtKMlzwFfpTOkBkAFtrmcV/D5f4GmTBbM8pfqZOU9KTOrA/Lgke57wcZfQd934v8RCBU/Dc/gwJ2FyRfGvUVmd/g9F/rgVpo3qb6Lf9A0yGhzlql+ySgirn1+bcMCYal4HpGV7iSFVJiAPGeUH0RHMEOyrYUA/2y+eu54ocxR5EgMUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N92CmiCxCTAyU+QZYfOqjJiAiyGcGz6Uy7ZqTCD896w=;
 b=MCp530XqvUVdrL0Y/mEZcn6aNHb9PcMO2+XNF0WC7cEyPqa1Wjf9ALOHtax5UD1wCAJoJkj6VWwlDGgVq9foMN4W2X1R0nCSLkxmeIcOnzJ8mgFWPRamIPc+Kp/Phj3y+VNrzZ+gUkDx9whcYVkmjjXXTPB3LGQAlI/kGwtua38=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by TYSPR03MB8630.apcprd03.prod.outlook.com (2603:1096:405:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 01:08:21 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%6]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 01:08:21 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: mtk-sd: Add support for ignoring cmd response CRC
Thread-Topic: [PATCH] mmc: mtk-sd: Add support for ignoring cmd response CRC
Thread-Index: AQHbPXbTHhGxg9XHhEOF7o1c+OgRLrLH+04AgADJIQA=
Date: Tue, 26 Nov 2024 01:08:21 +0000
Message-ID: <7d68576d620770e190925b6b4d8fe7a3c0d801c7.camel@mediatek.com>
References: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
	 <CAPDyKFpr9KZxx4_-jW8ovqcr4BCfDcm4teHEVOgZ69GrUddJ2g@mail.gmail.com>
In-Reply-To: <CAPDyKFpr9KZxx4_-jW8ovqcr4BCfDcm4teHEVOgZ69GrUddJ2g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|TYSPR03MB8630:EE_
x-ms-office365-filtering-correlation-id: 19bbb039-4932-4ad2-4940-08dd0db6d1d4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZDVrSVJKdjY1N0hZTWRJbkVvYkpTd0ozemZRcW9DS1ZnekdHYkd6VXIvbERs?=
 =?utf-8?B?ZitqV1VZOHdMQ2tJV2V0bXM5QXRLQTU3S1ZnSFBtSDRtUGMrOGxvMkdIWDE3?=
 =?utf-8?B?a0hBd2gwbnluczAxOXEwNW1JWTJFTG9UbTJOa1h5WHBPVzllTVZyQW5zNTA3?=
 =?utf-8?B?eXRXOFpNYTVqc3VadlVaY3RzR0dNSzBsSWRrVjJ1Z1B5cUJ6LzNWWWRuOVk0?=
 =?utf-8?B?ckI1MjZiUGxZK1BUeSs5cERZYzR2WklPZUJCV09VLzdTMjM0V3FIVDRGcDBo?=
 =?utf-8?B?UE5POHkxb28xM3JCSmh4N20wZDB5a3BHUW1VVjdlTFIwdUxQVXV2OE5CTXE1?=
 =?utf-8?B?dWw1OUJtVWlyTjVoMjBiVG9vUkdndVh1dHhDNW1rM1p6TldKSUVLczRmbEpP?=
 =?utf-8?B?VENJUTR1TTI1Z2kzeHNCeHNNemtBelVFc1BRRGRXRU93YnVPQkpJVzVzRWVB?=
 =?utf-8?B?NzBzbjlYM1ZySEhtYUd3SDVYekt5RGZHRlZwS1ZLQkxJVktjdnpOaWJ2T0F4?=
 =?utf-8?B?a2w2Q3c1eThkSm5oWkJCdDhBVFR6Y2NnWlI4YnlHeFp4TW5sUGs2NGZTYlVH?=
 =?utf-8?B?cmVXZzdKYmVBQjZ5dHZLM2lRTFlBOEM3dGZCNStrdDBnbStGRDM4QnhocENa?=
 =?utf-8?B?MEhoaURCUWNmY3lFQlFlMDlhR1ZaZ2FWVVRObS9jZ2pFcGg4aGdtK0hCRWxz?=
 =?utf-8?B?dU1uT1ZPSU5OQzJwVGFaRFpiVUpMUmJnTVlmR3R5WFl2TEpkZE9lTWJpMnY4?=
 =?utf-8?B?aEpUemZ4RDRJWDBLOTZOOVQyMEFhTklRbDhjRldiMmlrQ1dQNXFPUVdub3F6?=
 =?utf-8?B?U2hORUR5b3VBakdsamhlZ0JpZWZFeDBGajdZN2NiZ0QxZUJjUXI0bndSd3Ay?=
 =?utf-8?B?UitYLzJNUDcvNkIwSTFrTjJiVEpPVHJzVzhTVy9HT0hZRTJtT1RqWWR6eHZS?=
 =?utf-8?B?dHk2NExOSFM5N21talFpemNzZ3kyd29RZzY5clhDaWl4dFlTZGJFWWt2L1RT?=
 =?utf-8?B?cG5yOHpIa2ZyY29OSnVDaWpzU1RmUmlBeDBvR0o0N0F3L3g0QmlWQ01oYXY4?=
 =?utf-8?B?YVNEbFZLMEs0NjNpMDkxVzdHZVBwWTYwNk5mYUdmbjFuUmNxTjRlZ1c3NW1W?=
 =?utf-8?B?aDNrZG5xbjVMRThHdXBkclYveXBSUkRmaERScUFQMEdUMDd1eUtNdVdJaVg0?=
 =?utf-8?B?WS85VGIwT3ZtbUZhRFkwakxWSDNuR01jellTbHpPeWdaNXJQbWh4RmxmcGU1?=
 =?utf-8?B?blQvT2V1RXRUeFE1U2xEVjh6cjZYM0tYYUFvUmVhUWdkemx1eFlGUnM2K0dG?=
 =?utf-8?B?T0JqdlVlOWJYZEw5b2pacHVHZlNDM1VoVk1EMGYxL0NHYlVJWnVaQ2g5TS9R?=
 =?utf-8?B?bG1MejFXenZXaFg2UFNYaTBxaGtVMzZ3aTQzYnMyUmVTVU11SjlTYjZzUkRG?=
 =?utf-8?B?RVBwemFQNWpxVVVTak5ta2VHUWQzeHBiWUhUZmJDMEtlcU9vbUpWdENxdkV0?=
 =?utf-8?B?NnphTGVWK0wySXVEZCtOQll3Uis5M3g2K1NFMTFIc2pydFFIL0pXZzREdkI2?=
 =?utf-8?B?Y2lnUk9nKyszVXhHMHdQek9oTWM5N3NFUGJ0R1VPVW9mVVdMaTdtUUo0aHgx?=
 =?utf-8?B?elBFd2MwdVdFYzZIL3N0b0hxcEZySHJzd3FUeGx4V09KRnRzY3p6c0pGUnll?=
 =?utf-8?B?Zi9sYWNXaktJazhWeXZEazFQYmJsbXhqTHlFNklVVzUzQUplRXpaWGRQckRh?=
 =?utf-8?B?Q3ExTWJjV2JFRWVFelRacUFrNUhUamZjYjBwenZiNkFvdm82ZnE4eGhGRlVU?=
 =?utf-8?B?RXBuRGs1dDArTE5YRDhycHJaQUtEcldpNmRLNFZ2TVovYjR5ZUhNQk9SbzBY?=
 =?utf-8?B?Um1KZEV1V2t3SjZ3WitLR0tHU3ZPYjNQWEplTUpTb1RCZUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZoNnNrRlFzS29SWS9kZ3REbjNOSVdCSW9XKzdJbFpYMzc0K0JYS3BsZW1W?=
 =?utf-8?B?bkRqeVBpNnZtckRRUHdjOUhjdk55cnl4ZzRjNUpYRi9ob0phbW42eXhvU3N4?=
 =?utf-8?B?L1kwNUdqVWg0S0pBYnEyU2N1RlhkVmxMN2ZqL1d4Vyt2bW1DZ0lLR1dsVkpS?=
 =?utf-8?B?ekMxM2RiTFppT0xZQUJBQ2pJdktFeXllODFFL3YybXF4bnlpVk56dGVjZDZz?=
 =?utf-8?B?eFVtT09EQVhMbzEwdk9TNERUc3hSa3J1Mm1xSXNaWnlSMnhIK0JzY0xiL25s?=
 =?utf-8?B?NGNYaHo4WDJXQVpJR1B3UTRjQTJ5TGhpdDJHM1pvWm45aFpKOWJhMUNUOWdR?=
 =?utf-8?B?cm82d2JTeG1aUUNuWnlvSjYwTXVQcVVMeFhXTU94VVRmeTBudkNIbWpOa1lM?=
 =?utf-8?B?L1NUWEk1UkFSY2wzWG1zOVBkSnUwQ015QndyOHdURzNnOUtQUE84NW1YVnNt?=
 =?utf-8?B?MnRrckFSclJyU1RZOTVDM01IdWs3QVg2VzRmTllTTW9EalN2ZGE3MEwxRktw?=
 =?utf-8?B?SzJjNHdJUUg2YVNwK1hFM05MckhYTUpsTlY1akpVMmsxN3lSNTlkNUlhVDRT?=
 =?utf-8?B?Qk1tZm4wakgyaUZ1d25RSzREQ00zemhaam1OeGhsSU05Yld3WFl1eHZ2cjZZ?=
 =?utf-8?B?SFA4YnFFbzNEa3lPRGk4amROdFVBMWdjYmNncXpna1NjWlZtcG1DU3Y3VnBV?=
 =?utf-8?B?MS9jU2dOZE1ONGh3cWlLK0tHbnJKeEdLRTdYUldtQ0h4NDlaQUUyV2FKdTNX?=
 =?utf-8?B?Y1kvc011OFlJRG1haGlzV09RNGFNS3FNVmo4ZndNbytMSEluTmZSaS9nYTdE?=
 =?utf-8?B?UWk5K2pJMEI5cUpFQk50YnNJaWlyYmY0VHVRd1kzSzh6U1lGcjh4T1E1czVL?=
 =?utf-8?B?OTBVVyttMUN1UWdXN0hJa3pHby95OGFZbWlDNHoydmtsS2R2Rk82dGlZRGZB?=
 =?utf-8?B?SldZTlhJZEZyR214b01RanlDMWRtOGxGNG1ka05HbjhaS0N4SjZQY3JRZGM3?=
 =?utf-8?B?dHNHMGtBb2lHeW5PRWlHbHJJK0doNUEvOFprb2ZRU3pJaFY2UkU0dUsvSHFE?=
 =?utf-8?B?MnFNaHlpV01wY2FjZWJJZjNHa21vb1QrTHJRSW5CQUd4cFh0aU91dXlEVEs2?=
 =?utf-8?B?WG5LZDB3QVVLaWx4V2ZlbFllbkxqZGxYekhoYWhNRkc3bEVFZ1J3YU9nS2cx?=
 =?utf-8?B?U2tmR1RRSWtTekJUYUhsSnlZQjFuanlrRG1ZWnYyVndCVHNtb0wrNlVPNy9v?=
 =?utf-8?B?Z3JjZS9qN3RsRGF2anlDZFcyR3ltRlNBWjM0T29qMldLMXF5YmNWU0xJRXZV?=
 =?utf-8?B?L2p3UTFIbnpCR2ZYMmE4bTRyL2NOOXhkZDZqSTVYSGwzY1lmR0tsN0hKSkNJ?=
 =?utf-8?B?aG5ETWFJWmw5VWpaUm9QUjhncVRXOXFJQUlUa2FQeEV1bk5kUWNSK2VCYUVP?=
 =?utf-8?B?bDAwcFh6ZU0xUWFkbXQxajdsNzJYWXhvclZvVzJLbXVTL3ZNRkpYNXRxdng2?=
 =?utf-8?B?aFd2UTVYK2pXdWU4bGlFdnM4UllGZlErbjhyNWlOZU9PdEtKb3ZhMHBVM0tH?=
 =?utf-8?B?bURpdFNvRTlGb2p5b056VVNTQUN0YUFqT2N5MUFvRTNETWgrNCtwQ1AzOWgw?=
 =?utf-8?B?QzZIS3FQVnVOSU10Y2tuTGFCQm1sK0VzeFpmZUtvT2FGSkpBaWwxaG9PUUs2?=
 =?utf-8?B?WUJuUjdKNW50VTBIRktTZm43eXJjTXZ4LzJoNkY4K1pvZlhCUTRSSWxROXJa?=
 =?utf-8?B?SVpFcDZCTCswYUFpNlJnMFp2MC9sODRUY3ZqdkQ5Q0VKOFRxSElxejJYM0ZD?=
 =?utf-8?B?YXdSbXFTZ0Y1UFV5RkJjN3FWM0g5V3pxUVd2cVdqVjVEMlZKaEVYV29Pb2pS?=
 =?utf-8?B?QlJON2VzRjRJNkNiMy9GTi96c0J2WGNaaUxBcGVuOHBVQUtOSllaUlpMSUJP?=
 =?utf-8?B?ZnQ3THMrYm5LT2hQVmtJRitwODNkaGFCRzdqTlVIOFVSUGZVTW5WeWRSOVNU?=
 =?utf-8?B?NWRIOHJVV29Tb3dMdEZ2NFZCbVFkblhNcllzZkNMdXhEUHlvZExNbUg4MFZm?=
 =?utf-8?B?ZnlqQ29FSmN3UWlqa1ZSQW1wMlpjVDJkTXRESnI2K3dWaC9mY2JnL28vTDBO?=
 =?utf-8?B?V1lPYjRyZmRCNkI1d016aUEzOHRIYTF0ejJNWCt5UFRxeXArY1BWQURsc1JJ?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C2254D7159EF4EA9361864FBC5D146@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bbb039-4932-4ad2-4940-08dd0db6d1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 01:08:21.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixB0+gOp+66yZCeG+k3OPSJNlNkCIItJsm3jLijXwBHESzxp1zs2BcB/5qmMgK8+acmAXWQHDBf6JU/u7AxUPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8630
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.896300-8.000000
X-TMASE-MatchedRID: xIhOSkOSohXUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2GPjYszIlSDx+Mk6ACsw4Jhy/A9iZcrIfzW3
	gAExP4KbyLNfRm+vJsxoxXu9n6gyNPlG5Tkt1yt64jAucHcCqnRkqnRJng/51V9eB8vnmKe84vA
	oYH6KpD5a85NC5T9WZ7ZzK4U4L8LTyha4uErRN/ce31VQ+6yRGIaLR+2xKRDL4JyR+b5tvoKgF8
	LHYfOYGcO0bH7mJ7CPLxQyM43yjm83AmdtMjGJVA9lly13c/gHt/okBLaEo+C8zQZ2rR/Op0FiD
	qDlQgH4kM2V3jz3nR57H2F0ailJuRf0zRYpo0rie0367q1uQ1H0tCKdnhB58pTwPRvSoXL2ZMPC
	nTMzfOiq2rl3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.896300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B491A326D6E832BEC40882525264E9054D673A850B95B824639389289B04A1262000:8

T24gTW9uLCAyMDI0LTExLTI1IGF0IDE0OjA4ICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBTYXQsIDIzIE5vdiAyMDI0IGF0IDA4OjEwLCBBbmR5LWxkIEx1IDxh
bmR5LWxkLmx1QG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gVGhlIGN1cnJlbnQg
cHJvY2VzcyBmbG93IGRvZXMgbm90IGhhbmRsZSBNTUMgcmVxdWVzdHMgdGhhdCBhcmUNCj4gPiBp
bmRpY2F0ZWQNCj4gPiB0byBpZ25vcmUgdGhlIGNvbW1hbmQgcmVzcG9uc2UgQ1JDLiBGb3IgaW5z
dGFuY2UsIGNtZDEyIGFuZCBjbWQ0OA0KPiA+IGZyb20NCj4gPiBtbWNfY3FlX3JlY292ZXJ5KCkg
YXJlIG1hcmtlZCB0byBpZ25vcmUgQ1JDLCBidXQgdGhleSBhcmUgbm90DQo+ID4gbWF0Y2hlZCB0
bw0KPiA+IHRoZSBhcHByb3ByaWF0ZSByZXNwb25zZSB0eXBlIGluIG1zZGNfY21kX2ZpbmRfcmVz
cCgpLiBBcyBhIHJlc3VsdCwNCj4gPiB0aGV5DQo+ID4gYXJlIGRlZmF1bHRlZCB0byAnTU1DX1JT
UF9OT05FJywgd2hpY2ggbWVhbnMgbm8gcmVzcG9uc2UgaXMNCj4gPiBleHBlY3RlZC4NCj4gPiAN
Cj4gPiBUaGlzIGNvbW1pdCBhZGRzIGEgbmV3IGZsYWcgJ01NQ19SU1BfUjFCX05PX0NSQycgdG8g
d29yayBhbG9uZ3NpZGUNCj4gPiB0aGUNCj4gPiBleGlzdGluZyAnTU1DX1JTUF9SMV9OT19DUkMn
IGZvciB0aGUgZm9sbG93aW5nIHByb2Nlc3MgZmxvdy4gSXQNCj4gPiBmaXhlcyB0aGUNCj4gPiBy
ZXNwb25zZSB0eXBlIHNldHRpbmcgaW4gbXNkY19jbWRfZmluZF9yZXNwKCkgYW5kIGFkZHMgdGhl
IGxvZ2ljIHRvDQo+ID4gaWdub3JlDQo+ID4gQ1JDIGluIG1zZGNfY21kX2RvbmUoKS4NCj4gDQo+
IEluIGZhY3QsIE1NQ19SU1BfUjFfTk9fQ1JDIGlzIG5vdCBiZWluZyB1c2VkIGJ5IHRoZSBNTUMg
Y29yZS4gU28sDQo+IGhvc3QNCj4gZHJpdmVycyB0aGF0IGNoZWNrIHRoaXMgZmxhZyBzaG91bGRu
J3QgbmVlZCB0by4gSW4gb3RoZXIgd29yZHMsIHdlDQo+IHNob3VsZCByZW1vdmUgdGhhdCBmbGFn
IGVudGlyZWx5Lg0KPiANCj4gVGhhdCBzYWlkLCBpbnRyb2R1Y2luZyBNTUNfUlNQX1IxQl9OT19D
UkMgYXMgdGhlICRzdWJqZWN0IHBhdGNoDQo+IHN1Z2dlc3RzLCBtYWtlcyBzZW5zZSB0byBtZS4g
SG93ZXZlciwgSSBwcmVmZXIgaWYgd2UgY2FuIG1ha2UgaXQgdXNlZA0KPiBieSB0aGUgbW1jIGNv
cmUsIHNvIHBsZWFzZSBjaGFuZ2UgbW1jX2NxZV9yZWNvdmVyeSgpIHRvIHVzZSBpdCB0b28uDQo+
IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdp
bGwgZm9sbG93IHlvdXIgY29tbWVudCBpbiBuZXh0IGNoYW5nZS4NCg0KQmVzdCByZWdhcmRzDQpB
bmR5LWxkIEx1DQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHktbGQgTHUgPGFuZHkt
bGQubHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L210ay1z
ZC5jIHwgMTEgKysrKysrKysrLS0NCj4gPiAgaW5jbHVkZS9saW51eC9tbWMvY29yZS5oICB8ICAx
ICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJp
dmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+IGluZGV4IGVmYjBkMmQ1NzE2Yi4uNWQ2NjlmOTg1
YTgyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiArKysg
Yi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gQEAgLTEwOTcsMTEgKzEwOTcsMTMgQEAg
c3RhdGljIGlubGluZSB1MzIgbXNkY19jbWRfZmluZF9yZXNwKHN0cnVjdA0KPiA+IG1zZGNfaG9z
dCAqaG9zdCwNCj4gPiAgICAgICAgIHUzMiByZXNwOw0KPiA+IA0KPiA+ICAgICAgICAgc3dpdGNo
IChtbWNfcmVzcF90eXBlKGNtZCkpIHsNCj4gPiAtICAgICAgICAgICAgICAgLyogQWN0dWFsbHks
IFIxLCBSNSwgUjYsIFI3IGFyZSB0aGUgc2FtZSAqLw0KPiA+ICsgICAgICAgLyogQWN0dWFsbHks
IFIxLCBSNSwgUjYsIFI3IGFyZSB0aGUgc2FtZSAqLw0KPiA+ICAgICAgICAgY2FzZSBNTUNfUlNQ
X1IxOg0KPiA+ICsgICAgICAgY2FzZSBNTUNfUlNQX1IxX05PX0NSQzoNCj4gPiAgICAgICAgICAg
ICAgICAgcmVzcCA9IDB4MTsNCj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAg
ICBjYXNlIE1NQ19SU1BfUjFCOg0KPiA+ICsgICAgICAgY2FzZSBNTUNfUlNQX1IxQl9OT19DUkM6
DQo+ID4gICAgICAgICAgICAgICAgIHJlc3AgPSAweDc7DQo+ID4gICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+ICAgICAgICAgY2FzZSBNTUNfUlNQX1IyOg0KPiA+IEBAIC0xMzA1LDYgKzEzMDcs
NyBAQCBzdGF0aWMgYm9vbCBtc2RjX2NtZF9kb25lKHN0cnVjdCBtc2RjX2hvc3QNCj4gPiAqaG9z
dCwgaW50IGV2ZW50cywNCj4gPiAgew0KPiA+ICAgICAgICAgYm9vbCBkb25lID0gZmFsc2U7DQo+
ID4gICAgICAgICBib29sIHNiY19lcnJvcjsNCj4gPiArICAgICAgIGJvb2wgaWdub3JlX2NyYyA9
IGZhbHNlOw0KPiA+ICAgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAgICAgICAgIHUz
MiAqcnNwOw0KPiA+IA0KPiA+IEBAIC0xMzI5LDYgKzEzMzIsMTAgQEAgc3RhdGljIGJvb2wgbXNk
Y19jbWRfZG9uZShzdHJ1Y3QgbXNkY19ob3N0DQo+ID4gKmhvc3QsIGludCBldmVudHMsDQo+ID4g
ICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICAgICAgICAgcnNwID0gY21kLT5yZXNw
Ow0KPiA+IA0KPiA+ICsgICAgICAgaWYgKG1tY19yZXNwX3R5cGUoY21kKSA9PSBNTUNfUlNQX1Ix
X05PX0NSQyB8fA0KPiA+ICsgICAgICAgICAgIG1tY19yZXNwX3R5cGUoY21kKSA9PSBNTUNfUlNQ
X1IxQl9OT19DUkMpDQo+ID4gKyAgICAgICAgICAgICAgIGlnbm9yZV9jcmMgPSB0cnVlOw0KPiA+
ICsNCj4gPiAgICAgICAgIHNkcl9jbHJfYml0cyhob3N0LT5iYXNlICsgTVNEQ19JTlRFTiwgY21k
X2ludHNfbWFzayk7DQo+ID4gDQo+ID4gICAgICAgICBpZiAoY21kLT5mbGFncyAmIE1NQ19SU1Bf
UFJFU0VOVCkgew0KPiA+IEBAIC0xMzUxLDcgKzEzNTgsNyBAQCBzdGF0aWMgYm9vbCBtc2RjX2Nt
ZF9kb25lKHN0cnVjdCBtc2RjX2hvc3QNCj4gPiAqaG9zdCwgaW50IGV2ZW50cywNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiBDUkMgZXJyb3IuDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICovDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbXNkY19yZXNldF9odyhob3N0
KTsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKGV2ZW50cyAmIE1TRENfSU5UX1JTUENSQ0VSUikg
ew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXZlbnRzICYgTVNEQ19JTlRfUlNQQ1JDRVJSICYm
ICFpZ25vcmVfY3JjKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgY21kLT5lcnJvciA9
IC1FSUxTRVE7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaG9zdC0+ZXJyb3IgfD0gUkVR
X0NNRF9FSU87DQo+ID4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoZXZlbnRzICYgTVNEQ19J
TlRfQ01EVE1PKSB7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaCBi
L2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaA0KPiA+IGluZGV4IDU2OTcyYmQ3ODQ2Mi4uMDc2ZTFj
NzFhMDdlIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaA0KPiA+IEBAIC02Niw2ICs2Niw3IEBAIHN0cnVj
dCBtbWNfY29tbWFuZCB7DQo+ID4gDQo+ID4gIC8qIENhbiBiZSB1c2VkIGJ5IGNvcmUgdG8gcG9s
bCBhZnRlciBzd2l0Y2ggdG8gTU1DIEhTIG1vZGUgKi8NCj4gPiAgI2RlZmluZSBNTUNfUlNQX1Ix
X05PX0NSQyAgICAgIChNTUNfUlNQX1BSRVNFTlR8TU1DX1JTUF9PUENPREUpDQo+ID4gKyNkZWZp
bmUNCj4gPiBNTUNfUlNQX1IxQl9OT19DUkMgICAgIChNTUNfUlNQX1BSRVNFTlR8TU1DX1JTUF9P
UENPREV8TU1DX1JTUF9CVVNZDQo+ID4gKQ0KPiA+IA0KPiA+ICAjZGVmaW5lIG1tY19yZXNwX3R5
cGUoY21kKSAgICAgKChjbWQpLT5mbGFncyAmDQo+ID4gKE1NQ19SU1BfUFJFU0VOVHxNTUNfUlNQ
XzEzNnxNTUNfUlNQX0NSQ3xNTUNfUlNQX0JVU1l8TU1DX1JTUF9PUENPRA0KPiA+IEUpKQ0KPiA+
IA0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4gDQo=
