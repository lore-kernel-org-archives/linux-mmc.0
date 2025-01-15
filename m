Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809224168F;
	Wed, 15 Jan 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933631; cv=fail; b=K57T7cNX/sya+MOPnLjJgcFJ4Zh5vYeOMvPTYgoiqXqOpQG3syPeKaL7JSpWVci0dckHViYwWVRCciVa9YpB5S09ZOk1BUIn5yV8VKtGydtDUTOLqM0nl5X4C1/1Rqlu7VCtNBOoQ4axKOWG+r9775UZ7x+sIodq4jAKFaDPKSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933631; c=relaxed/simple;
	bh=J/7Y4P7jGgTjLMTWo8jEYfj509zFGCXAt0P1DQvvRps=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3CgouMZM20UdiarJ88vnuHOvbsmSpBaZza7AArthPwmPtzvzq5kgG/C6Su89dO4Bmslyxzb9Na6c8i+PkglO4TPPyYxL5NHOd22+HorwDGq67aWWA/OyF3ujVgyQg2NjiPTo26XWBpwLOIyiUoC/pQDhJUjKRoPDfyhVjtdilY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IeMGXH3j; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kMRjufDB; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IeMGXH3j";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kMRjufDB"
X-UUID: cdfc1a56d32311efbd192953cf12861f-20250115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=J/7Y4P7jGgTjLMTWo8jEYfj509zFGCXAt0P1DQvvRps=;
	b=IeMGXH3jPSayoQ5V/X1K0skpp9rjztQNFgBYX2gz6TKqmdwI3w7e9rom6XLSOoVuxdFg8R4O/tzn7TeM1EOM9QcibzfUpANeCdS5qU/VmV3HSp/gm2yjZjpBGYQkoTwjhl/+XNxesiKFQGcfzXYwdlFjjp8380YuQFR27iRUZRE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:9938b98d-077d-4b83-9272-097e5e650fe2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:a9641285-0f10-4f52-bb41-91703793d3e4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cdfc1a56d32311efbd192953cf12861f-20250115
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <wenbin.mei@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1474343911; Wed, 15 Jan 2025 17:33:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 Jan 2025 17:33:39 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 15 Jan 2025 17:33:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7TtC9mKsRwZEGdhmQGzoKs5/41B7kNUMVjiZdI9MXlnVz3KjXutN1yaP0s1aWrF3qGx9F5YDDOw9hdP9UI+udLgH4xWAcOeaNpvd+9Jd/lntFnrxwIpdOvVsKRUDKRKefAG4Z5pyIcK9/5VwD7D/zFACIX+iPRcsWr6/z21EhhGxTGTKUQTa2soYZa2INITBzX8CeTOFRDpeKDI61Sw6rM9l1W9v12lTwTQd3/9BBfBA6HiT3ac/7sXrfmr/9+17rGMkuBm5WGLWB1ZpG6iG5eVFDMycKbk1G43phLTTbyyuMId3M6HsGl/J3G7RD71VjPqo0cC41DQgUGbdr7TxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/7Y4P7jGgTjLMTWo8jEYfj509zFGCXAt0P1DQvvRps=;
 b=RULIGCY8FM7RV3drWg4VH6nY7XInA593UJIkJGXjsH9ptcdlzp+JIUU1vaydnWsEG/686fVtQuEdLkMsxXvKFs4CQh6ymmZIa5Rkx5/qvXXeq4mf97zi/v259lLABvaxWw6GiC5O8Ch5e0nOvmzm3Mgf4x/loWL/3KGhaASiOM/rAIFq9wKOF+7LyufN5uL+vsI2zQW8/JwbY31hJ1ruSiajF80ecV83sy1+GzonkAXfD54BwDwbt3UjjyoocqQCKI721i+YG+yDa+jL5wDAaB19QsxkYG4lCm1at6FCsVh7799ZpP4dhwNXEykY7mnaQdyIqfqzGiXiAJ3lvEAQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/7Y4P7jGgTjLMTWo8jEYfj509zFGCXAt0P1DQvvRps=;
 b=kMRjufDBPw1tUYUNzfcB8VQ+wVR9n8xoszlNgqQyHPbIZStqKVnJkEtFQU1LGWDPURSo+BLmWozx+hcl1xNOotorf3p3JzsTulbY7TsA8rONxrTg2DJs9SMcB3dlPoLXiOKH6YG7S75iOP4gF72s/mojP9Y+8dBLsXVJVeIgNDs=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by KL1PR03MB7580.apcprd03.prod.outlook.com (2603:1096:820:ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 09:33:35 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::cc6a:9ce3:356f:665b]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::cc6a:9ce3:356f:665b%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 09:33:35 +0000
From: =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Thread-Index: AQHbZx90lmVodLQ8zE+brdaSwOmMC7MXkteA
Date: Wed, 15 Jan 2025 09:33:35 +0000
Message-ID: <a00c76b9752410ea86d6cac0f774d5d1ea45891d.camel@mediatek.com>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
	 <20250115073026.31552-2-ansuelsmth@gmail.com>
In-Reply-To: <20250115073026.31552-2-ansuelsmth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|KL1PR03MB7580:EE_
x-ms-office365-filtering-correlation-id: 6dec23e5-fd1a-4009-27ca-08dd3547af46
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eURGOUVHT2o3dlVJajUxcjFMQjhKcEVzeVdyODdQY3pUVktHNEJpQmEwRENK?=
 =?utf-8?B?d1pZeHh0RGFvVGhUNDVBY2gwK2htZ1UvZHQ0QjVqM1JkZ2g3dGJleGRNNmt3?=
 =?utf-8?B?ZmxMQzFxTTl5amF2YTlOYWExbHp2aXVZY1RFaW9Lc3kxRnBOZWwzdjV5OUZq?=
 =?utf-8?B?cWxZWTNpekZxMWJyWlpMQ0VIYW9pdDVtNHdxZ2JKTEQwbmNWeUdZMGpHM2w3?=
 =?utf-8?B?d2FQYzdVYTNVclEwbWFNUnNQcmdBRHQ1YjBXRmlwOWVqWVZpT3FwdER3MFNS?=
 =?utf-8?B?UFNlcmdRdGxXdFRqdTdYNjNoR0I2SFExQTJrOFB1RU1raWRVU29vNDM0MEpR?=
 =?utf-8?B?aVRWbzk3NzJkYW5wM0VlNkY5VUFkM29wc05XcmxIaklWaXhvb3pFbU9sZHdx?=
 =?utf-8?B?WUNTd3M4RStmWkFSUzFacC9TV0RlZmZmWi8xS1lySzdIeHlJT0hjVUN4czh0?=
 =?utf-8?B?NnVGcmdWdG5STTZjRHBrb0VYU0hJLzRaZ1ZMSk13Y0FuQk9iR2dKZ1Q1Smo0?=
 =?utf-8?B?YUdQOU96MmYwRXdHdlpwWHNTN0hPRjJ6cEdSdjFWb0RIbGRqaUdadlQyZDF6?=
 =?utf-8?B?K1lhVkZSSnJWOGl1V01oNVYvQXpmRHhWZUxJR1VNOXIvZURXakJlUXM5eFM3?=
 =?utf-8?B?SUNMeEhYbEdKcm9FWDJady9JVnFjM1lxRTdsM3J0VXRaaTlEcnZIcm5LVWZI?=
 =?utf-8?B?Q3ptV3Ezc3VNdFJURHVLZmRmS096S2s1Qnd2bFN2TjNac1dacXo4QzFZZy9r?=
 =?utf-8?B?WDlOTThvNFZobTF6QjNvYWlraTFlaWxjWW5mSVpJYjhHWnNtSC9FSGlDUTh4?=
 =?utf-8?B?UnFyejZ5Qm54elVzYTF3Y1gyKytRTGcvbnM0b1BNdHFvdlRBMFo0QzZabld6?=
 =?utf-8?B?YlI0dlpBcC9McXVnQUFaaTRBem1PeDE3TTduRWwrT1FMdG1tQUtmcUMrWTl1?=
 =?utf-8?B?aFJhUjZMTXNIZXBPZ05VWFhvOEtLNkw0WWJvd1NObzlwc2V0dWw3cU9ZallY?=
 =?utf-8?B?dkhVTGxQNldwRXZPWGVickZRN0pOVlN0WjVma1c4MW1LYURJQUUzeklxYk5S?=
 =?utf-8?B?QXFZQmVKK3hlU1hIdUJXZXRoQTNIMUNBdXpPUVlFb0VWQUlOTGE2TnhvQTJV?=
 =?utf-8?B?U0FCcWxrQXowUWhpTWtyTVM1UjBuQ2FOMDd4UjkwTkxjUVZjcUtMbUZuUG5V?=
 =?utf-8?B?NDJ2d21jSFpmeXZaL2NHNTVvTUVFVE1ZTHoxeGxwY292clZ0SWx2cVRIOGlM?=
 =?utf-8?B?M3QyWnB3STk3WVBxOGh3YVo0MDk4ZXFSZXNYZEtWd0xKcDliQ0YycXdVVHcv?=
 =?utf-8?B?cXdLQWlXbFNEL2VqbmJQUVRoTlJrUEJ4aTJFRlEzUSt0VUZwNEF1ZXRXaVZT?=
 =?utf-8?B?SjRkSFkxZWVtZE5ab0pmdVRMT2cwcVZWUHRTSWJzRElWbEY2TGI5MnZzeThu?=
 =?utf-8?B?NE40bE9qK2pTSmhJQ2w5Qjg1cWo0Ti9uOWEyWlErQm1ZZXhqMy9JcTk3OE8w?=
 =?utf-8?B?YnBIdVE4d3RFekxsQ0R4QW8zS1dSUmF1aUlvVHhzL0dpTGpkbXpHbEt2VXht?=
 =?utf-8?B?OG8rdWxsbi9CNXJtQ2dpcW91NVJucGRua2wvdnpuZll4VjBKM2FNMnA3UXU5?=
 =?utf-8?B?YWVyMHZ6d1BZL0RNMWxUeG1iZSt5QllQdCtDVXBwb1ZnTXNsb01zSEUyS2RP?=
 =?utf-8?B?ckcvK00wc2E5QlJ3ZVNrSUZ2OG5rZ1BGZWhNQTB1L2F3ZEpQUW9zODc3dEo5?=
 =?utf-8?B?OTB2aW9mbUxxTjJ3UVpEOFlacXNBUmRGdFdObFgwQ3p6dXhKV0hjVjVaWVdQ?=
 =?utf-8?B?M0pyRlJ3UjN3eTFDb2EzNnNZT1R6TzF3S2grK2t2YnB3d3dUQXA1M1VaT0tM?=
 =?utf-8?B?emFMV3FxeForNkNJUXE1bUlIRmpoMldMQzlGWDZPNkpOM3BhNnZ0OE50RWZD?=
 =?utf-8?B?azVPck4yaFRhR2Uyek9SSjhKMFovLzFvNENDR2dmVGdCcHRGU2d3RGlIR1M2?=
 =?utf-8?B?cXplQTYzR2FRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTJMVXRSQmR0VnVBSlplUkZxWDNoZHlnVG5XR2k3Sjk1ZW0rSkZjYTZRT29C?=
 =?utf-8?B?L1JKendEdTZLd2UyaEtjTThyRzkrbnYyUDM5bnh6S2dHSFcxb3BYUjA5bVVX?=
 =?utf-8?B?L3NlL3NsYzhtdEh1ZkFnWVZ0UUhNYWJCODcxSGJtNGovKzd3TjQwNEdhaHZL?=
 =?utf-8?B?ZW9IUHB2VFRJZVpXb1d3MHJ3OUtHY2NnVHlLU2IrcExXa1VjUmxZYy9RR1ZR?=
 =?utf-8?B?TFV6U0lOZzNwblFzdGZBWUZKUkQ0eVBjeDNUc2wxTWlEN0lwb1M4L0dWUjlE?=
 =?utf-8?B?Ui9PMkNnZWVTVmdVVGErajBrai9KNHZ1Tk9nZDZWaXBIRnZDWDNVOWZkRnFH?=
 =?utf-8?B?a281eWo3Qis4YkdSZ3JrVDk5YVE2c0VsR29YZ3JqQXp6YWZYOVFhd3BwNEN6?=
 =?utf-8?B?UytYbG5MOW5iZU9PR1lCMi9CK0pXaHFEQ1NMdStsWG5MczQ3c1d6RWdJWkJN?=
 =?utf-8?B?YjBxY1pLd0huMm5OV0poSmJQY2g2QzRscGhyN2IrZndGK3lCSXVqa292NmRr?=
 =?utf-8?B?aFBSTzhaUndjTGZ5OERUZ0QvWTRvM0xEYnFuMnJZWjg3aEtlWE9HZ0JNWHA2?=
 =?utf-8?B?RHBaTUY5dXZGWm0wb3hSaE9GOWloNVhhbGZVNDhJR3pPb3RFeHBidjl2MVZ4?=
 =?utf-8?B?U0VTK0ExTk1BVG45T0lOOVg4WmxuaDFjNWswclMvb3B5OFhzR0FJbHNNbFN6?=
 =?utf-8?B?MzR0a2NxdjNYTFcrdy9UckNyZHFPc2kwVVpzUnJhSytvVEREblRhMlppUE9x?=
 =?utf-8?B?WWgyY0RTdnpFWVA2YzdobEQ2KzVncmNiRnZONW1Jb25IQWs1ZmlRdXlxVW9j?=
 =?utf-8?B?WmM3WTlPaHZGQjVVWlpmajlSNUp2OGc1cit1ZjFRdnEyRWJmQnEydmV6UTBY?=
 =?utf-8?B?UWUrY0FXOERZRUJYbWg5bE8xQjNKNnZPaWtlbklTRVZKb0krRnkxOVpWbkdU?=
 =?utf-8?B?b1V4cWpjMHRzeEdBVWp1N2EydG1YdHhOdVBSR2hKRHNIams1azd0TDZVM0FZ?=
 =?utf-8?B?a1MxSnIyMlFweGR2SUJqREFyaUE3T3JxRElEdmpUNXpkM0lFNmRzMlZWTGsr?=
 =?utf-8?B?TjJYTUdobW10b0RjcmMxazlaeGtGRW81ZFR2bnZHRmhmYzBYM1ZHS2U5aEtP?=
 =?utf-8?B?eU5Ib0JyUEt5LzcrMzJPUTVJcVFFUjJnenBIRFdNenE1cUNqSG5QK1M1N0Jx?=
 =?utf-8?B?M2M0RjBBNlZlV0VaclE5OTNsZlRYZVRwY0REMVBlOUhraVpqYW1UQk1iYmhX?=
 =?utf-8?B?enZvZ3B5ZjZZd1d6ZE5rWmdPT3ZmdkdieGJ5cVFCL1pzNm5QS08yZldWVXZG?=
 =?utf-8?B?MklWZHBjZnFNRlROQm9BeXh0SFRTR1UzdTlFWXUvYk1ua0NiT3FYSVd5NHNv?=
 =?utf-8?B?cjA4ZGdhaTU0NEgxcUt4d0N0QjlvOVhySFJmWG0vMExUaUFTWnhvL01SUThm?=
 =?utf-8?B?Y3NWNGRkdW9XSWREVmFSemk0TEppc1ZjcS80NDJ1QWVrR0Vsd3B6T2psYnVh?=
 =?utf-8?B?MDZzd3d4SEZNQ1VRRG9ZUDJrMnQ1Z25CczlySDkzeTJmUDZSZExkdnlBdGFB?=
 =?utf-8?B?ekxxT1U5VXhvcGZhS2pKVUc4YkdNQWF2b0p1dk9OQWZIMStaTXBWSFBNdE55?=
 =?utf-8?B?T3prenVwSXRicWNOdWtZQmxoNFZjSk9VdXU2YWprYTZNM2pSOWc4RnYrWTZx?=
 =?utf-8?B?VEhMRms0TnFiTXBDb0s3VlBSMnI2b3FzbGxsNVZIbWtWYzgveHNReEwvYnFx?=
 =?utf-8?B?a2RWWkJIWG5MMUpTVmpZcnExaUtQd25NTTFFVnl2blkxMUdWYkxNQkVQakJQ?=
 =?utf-8?B?M3FuSTdPSTg3aC9CK2ZxdFdtd2xpMDJSZWxuK0Fmb2lybDhDbzhNekJOcjVM?=
 =?utf-8?B?WGhmKzEzSnRrY3JHODRJTVpWYjVoc0JQbHZKaEpzMW1SUmx2SEU0WGI1bWNz?=
 =?utf-8?B?QWNYdWlZT3h2YTlVYnpIVUJDYkNtT294WTJBQWRyclRtcEpjKyt2eE9zUFZr?=
 =?utf-8?B?TklVSjYzU0V6cGQwTzBxWXIrOHEwUzdyUnZUdEZqblh2Ukx6UEZhVHVncUJy?=
 =?utf-8?B?cmpPNzNYcHV6VUFQVWVVK1J1S2V1b2gzWHdhU1ZvU3JDZmQxMk1UUEpPQnJ0?=
 =?utf-8?B?QW1NSTMxa3NTYzlZRCtuanY4NXA2ZlhlKyt2cXJISlc4K2NpekZZZExLQVJo?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B059F8A5CE88E7408AA9C70E75FC5E04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dec23e5-fd1a-4009-27ca-08dd3547af46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 09:33:35.5633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yw9sRSDRiDdMcEpC9W/nh72sIMsLLRJIn0gQUzUkRKVahAGa0kY8ZouVlwC33uYl69vpbPBmsenmJv17+H3Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7580

T24gV2VkLCAyMDI1LTAxLTE1IGF0IDA4OjI5ICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3IgQU43NTgxIE1NQyBIb3N0LiBUaGUg
TU1DIEhvc3QgY29udHJvbGxlciBpcyBiYXNlZCBvbg0KPiBtdDc2MjIgd2l0aCB0aGUgZGlmZmVy
ZW5jZSBvZiBub3QgaGF2aW5nIHJlZ3VsYXRvciBzdXBwbHkgYW5kDQo+IHN0YXRlX3Vocw0KPiBw
aW5zIGFuZCBoY2xrIGNsb2NrLg0KPiANCj4gU29tZSBtaW5vciBmaXhlcyBhcmUgYXBwbGllZCB0
byBjaGVjayBpZiB0aGUgc3RhdGVfdWhzIHBpbnMgYXJlDQo+IGRlZmluZWQNCj4gYW5kIG1ha2Ug
aGNsayBvcHRpb25hbCBmb3IgdGhlIG5ldyBhaXJvaGEgY29tcGF0aWJsZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBNYXJhbmdpIDxhbnN1ZWxzbXRoQGdtYWlsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNTUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9t
dGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gaW5kZXggZWZiMGQyZDU3MTZi
Li45ZDY4Njg4ODNjOTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMN
Cj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiBAQCAtNjY2LDYgKzY2NiwyMCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29tcGF0aWJsZQ0KPiBtdDgxOTZfY29tcGF0
ID0gew0KPiAgICAgICAgIC5zdXBwb3J0X25ld19yeCA9IHRydWUsDQo+ICB9Ow0KPiANCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX21tY19jb21wYXRpYmxlIGFuNzU4MV9jb21wYXQgPSB7DQo+
ICsgICAgICAgLmNsa19kaXZfYml0cyA9IDEyLA0KPiArICAgICAgIC5yZWNoZWNrX3NkaW9faXJx
ID0gdHJ1ZSwNCj4gKyAgICAgICAuaHM0MDBfdHVuZSA9IGZhbHNlLA0KPiArICAgICAgIC5wYWRf
dHVuZV9yZWcgPSBNU0RDX1BBRF9UVU5FMCwNCj4gKyAgICAgICAuYXN5bmNfZmlmbyA9IHRydWUs
DQo+ICsgICAgICAgLmRhdGFfdHVuZSA9IHRydWUsDQo+ICsgICAgICAgLmJ1c3lfY2hlY2sgPSB0
cnVlLA0KPiArICAgICAgIC5zdG9wX2Nsa19maXggPSB0cnVlLA0KPiArICAgICAgIC5zdG9wX2Rs
eV9zZWwgPSAzLA0KPiArICAgICAgIC5lbmhhbmNlX3J4ID0gdHJ1ZSwNCj4gKyAgICAgICAuc3Vw
cG9ydF82NGcgPSBmYWxzZSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG1zZGNfb2ZfaWRzW10gPSB7DQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDI3MDEtbW1jIiwgLmRhdGEgPQ0KPiAmbXQyNzAxX2NvbXBhdH0sDQo+ICAgICAg
ICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItbW1jIiwgLmRhdGEgPQ0KPiAmbXQy
NzEyX2NvbXBhdH0sDQo+IEBAIC02ODAsNyArNjk0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbXNkY19vZl9pZHNbXSA9DQo+IHsNCj4gICAgICAgICB7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4My1tbWMiLCAuZGF0YSA9DQo+ICZtdDgxODNfY29tcGF0fSwNCj4g
ICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni1tbWMiLCAuZGF0YSA9DQo+
ICZtdDgxOTZfY29tcGF0fSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODUxNi1tbWMiLCAuZGF0YSA9DQo+ICZtdDg1MTZfY29tcGF0fSwNCj4gLQ0KPiArICAgICAgIHsg
LmNvbXBhdGlibGUgPSAiYWlyb2hhLGFuNzU4MS1tbWMiLCAuZGF0YSA9ICZhbjc1ODFfY29tcGF0
fSwNCj4gICAgICAgICB7fQ0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1zZGNf
b2ZfaWRzKTsNCj4gQEAgLTE2MDAsNiArMTYxNCwxMCBAQCBzdGF0aWMgaW50IG1zZGNfb3BzX3N3
aXRjaF92b2x0KHN0cnVjdA0KPiBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3QgbW1jX2lvcyAqaW9zKQ0K
PiAgICAgICAgIHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KPiAgICAg
ICAgIGludCByZXQ7DQo+IA0KPiArICAgICAgIC8qIFNraXAgc2V0dGluZyBzdXBwbHkgaWYgbm90
IHN1cHBvcnRlZCAqLw0KPiArICAgICAgIGlmICghbW1jLT5zdXBwbHkudnFtbWMpDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICAgIGlmICghSVNfRVJSKG1tYy0+c3Vw
cGx5LnZxbW1jKSkgew0KPiAgICAgICAgICAgICAgICAgaWYgKGlvcy0+c2lnbmFsX3ZvbHRhZ2Ug
IT0gTU1DX1NJR05BTF9WT0xUQUdFXzMzMCAmJg0KPiAgICAgICAgICAgICAgICAgICAgIGlvcy0+
c2lnbmFsX3ZvbHRhZ2UgIT0gTU1DX1NJR05BTF9WT0xUQUdFXzE4MCkgew0KPiBAQCAtMTY5OSw3
ICsxNzE3LDkgQEAgc3RhdGljIHZvaWQgbXNkY19lbmFibGVfc2Rpb19pcnEoc3RydWN0DQo+IG1t
Y19ob3N0ICptbWMsIGludCBlbmIpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2RiZyhob3N0LT5kZXYsICJTRElPIGVpbnQgaXJxOg0KPiAlZCFcbiIsIGhvc3QtPmVpbnRf
aXJxKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiANCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgcGluY3RybF9zZWxlY3Rfc3RhdGUoaG9zdC0+cGluY3RybCwgaG9zdC0NCj4gPnBp
bnNfdWhzKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogU2tpcCBzZXR0aW5nIHVocyBw
aW5zIGlmIG5vdCBzdXBwb3J0ZWQgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGhv
c3QtPnBpbnNfdWhzKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmxf
c2VsZWN0X3N0YXRlKGhvc3QtPnBpbmN0cmwsDQo+IGhvc3QtPnBpbnNfdWhzKTsNCj4gICAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9wbV9jbGVh
cl93YWtlX2lycShob3N0LT5kZXYpOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiBAQCAtMjAzNiw2
ICsyMDU2LDEwIEBAIHN0YXRpYyB2b2lkIG1zZGNfb3BzX3NldF9pb3Moc3RydWN0IG1tY19ob3N0
DQo+ICptbWMsIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+IA0KPiAgICAgICAgIG1zZGNfc2V0X2J1
c3dpZHRoKGhvc3QsIGlvcy0+YnVzX3dpZHRoKTsNCj4gDQo+ICsgICAgICAgLyogU2tpcCByZWd1
bGF0b3IgaWYgbm90IHN1cHBvcnRlZCAqLw0KPiArICAgICAgIGlmICghbW1jLT5zdXBwbHkudm1t
YykNCj4gKyAgICAgICAgICAgICAgIGdvdG8gc2tpcF9yZWd1bGF0b3I7DQo+ICsNCklmIHBvd2Vy
X21vZGUgaXMgTU1DX1BPV0VSX1VQLCB3ZSBuZWVkIHRvIGV4ZWN1dGUgdGhlIHJlbGF0ZWQgZmxv
dy4NCk5vdyBpdCB3aWxsIHNraXAgbW1jX2luaXRfaHcoaG9zdCksIHdoaWNoIHdpbGwgY2F1c2Ug
cHJvYmxlbXMuDQpCVFcsIGNhbiB0aGlzIGJlIGltcGxlbWVudGVkIHVzaW5nIGEgZml4IHJlZ3Vs
YXRvcj8gaWYgb2ssIG5vIG5lZWQNCnRvIG1vZGlmeSBoZXJlLg0KPiAgICAgICAgIC8qIFN1c3Bl
bmQvUmVzdW1lIHdpbGwgZG8gcG93ZXIgb2ZmL29uICovDQo+ICAgICAgICAgc3dpdGNoIChpb3Mt
PnBvd2VyX21vZGUpIHsNCj4gICAgICAgICBjYXNlIE1NQ19QT1dFUl9VUDoNCj4gQEAgLTIwNzEs
NiArMjA5NSw3IEBAIHN0YXRpYyB2b2lkIG1zZGNfb3BzX3NldF9pb3Moc3RydWN0IG1tY19ob3N0
DQo+ICptbWMsIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+ICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gICAgICAgICB9DQo+IA0KPiArc2tpcF9yZWd1bGF0b3I6DQo+ICAgICAgICAgaWYgKGhvc3Qt
Pm1jbGsgIT0gaW9zLT5jbG9jayB8fCBob3N0LT50aW1pbmcgIT0gaW9zLT50aW1pbmcpDQo+ICAg
ICAgICAgICAgICAgICBtc2RjX3NldF9tY2xrKGhvc3QsIGlvcy0+dGltaW5nLCBpb3MtPmNsb2Nr
KTsNCj4gIH0NCj4gQEAgLTI4MTYsOSArMjg0MSwxMiBAQCBzdGF0aWMgaW50IG1zZGNfb2ZfY2xv
Y2tfcGFyc2Uoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gICAgICAgICBpZiAo
SVNfRVJSKGhvc3QtPnNyY19jbGspKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
aG9zdC0+c3JjX2Nsayk7DQo+IA0KPiAtICAgICAgIGhvc3QtPmhfY2xrID0gZGV2bV9jbGtfZ2V0
KCZwZGV2LT5kZXYsICJoY2xrIik7DQo+IC0gICAgICAgaWYgKElTX0VSUihob3N0LT5oX2Nsaykp
DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihob3N0LT5oX2Nsayk7DQo+ICsgICAg
ICAgLyogQU43NTgxIFNvQyBkb2Vzbid0IGhhdmUgaGNsayAqLw0KPiArICAgICAgIGlmICghZGV2
aWNlX2lzX2NvbXBhdGlibGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1jIikpIHsNCj4g
KyAgICAgICAgICAgICAgIGhvc3QtPmhfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJo
Y2xrIik7DQo+ICsgICAgICAgICAgICAgICBpZiAoSVNfRVJSKGhvc3QtPmhfY2xrKSkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaG9zdC0+aF9jbGspOw0KPiArICAg
ICAgIH0NCj4gDQo+ICAgICAgICAgaG9zdC0+YnVzX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25h
bCgmcGRldi0+ZGV2LCAiYnVzX2NsayIpOw0KPiAgICAgICAgIGlmIChJU19FUlIoaG9zdC0+YnVz
X2NsaykpDQo+IEBAIC0yOTI2LDEwICsyOTU0LDEzIEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBQVFJfRVJSKGhvc3QtPnBpbnNfZGVmYXVsdCk7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAg
ICAgICBob3N0LT5waW5zX3VocyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGhvc3QtPnBpbmN0cmws
DQo+ICJzdGF0ZV91aHMiKTsNCj4gLSAgICAgICBpZiAoSVNfRVJSKGhvc3QtPnBpbnNfdWhzKSkg
ew0KPiAtICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGlu
Y3RybCB1aHMhXG4iKTsNCj4gLSAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGhvc3QtPnBp
bnNfdWhzKTsNCj4gKyAgICAgICAvKiBBTjc1ODEgZG9lc24ndCBoYXZlIHN0YXRlX3VocyBwaW5z
ICovDQo+ICsgICAgICAgaWYgKCFkZXZpY2VfaXNfY29tcGF0aWJsZSgmcGRldi0+ZGV2LCAiYWly
b2hhLGFuNzU4MS1tbWMiKSkgew0KPiArICAgICAgICAgICAgICAgaG9zdC0+cGluc191aHMgPSBw
aW5jdHJsX2xvb2t1cF9zdGF0ZShob3N0LT5waW5jdHJsLA0KPiAic3RhdGVfdWhzIik7DQo+ICsg
ICAgICAgICAgICAgICBpZiAoSVNfRVJSKGhvc3QtPnBpbnNfdWhzKSkgew0KPiArICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsDQo+
IHVocyFcbiIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihob3N0
LT5waW5zX3Vocyk7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiANCj4gICAg
ICAgICAvKiBTdXBwb3J0IGZvciBTRElPIGVpbnQgaXJxID8gKi8NCj4gQEAgLTMwMTAsNiArMzA0
MSwxMiBAQCBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJDYW5ub3Qg
dW5nYXRlIGNsb2NrcyFcbiIpOw0KPiAgICAgICAgICAgICAgICAgZ290byByZWxlYXNlX2NsazsN
Cj4gICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAvKiBBTjc1ODEgd2l0aG91dCByZWd1bGF0b3Ig
cmVxdWlyZSB0dW5lIHRvIE9DUiB2YWx1ZXMgKi8NCj4gKyAgICAgICBpZiAoZGV2aWNlX2lzX2Nv
bXBhdGlibGUoJnBkZXYtPmRldiwgImFpcm9oYSxhbjc1ODEtbW1jIikgJiYNCj4gKyAgICAgICAg
ICAgIW1tYy0+b2NyX2F2YWlsKQ0KPiArICAgICAgICAgICAgICAgbW1jLT5vY3JfYXZhaWwgPSBN
TUNfVkREXzMyXzMzIHwgTU1DX1ZERF8zM18zNDsNCj4gKw0KPiAgICAgICAgIG1zZGNfaW5pdF9o
dyhob3N0KTsNCj4gDQo+ICAgICAgICAgaWYgKG1tYy0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUpIHsN
Cj4gLS0NCj4gMi40NS4yDQo+IA0K
