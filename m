Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEB1F95E;
	Sun, 29 Sep 2024 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727588659; cv=fail; b=ffkM+yaAxm0srL9cwMdyPF0HA8Wi+NLOBOzMvUCzFWMDWO0vARq44NNGw0uIg9Kwkflcdm7obHEugbFmitfTchCl+0DKGsWoDzmNdEqEmzAIoNbL/FmjBh2vINgvcrFkKu0G2bgLQv1d3uMH2Mx1GA/BYu69HWP+X8oWYNZoohA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727588659; c=relaxed/simple;
	bh=IYW719ZcZwZJhy2JDUHBQut82AyHq/duLAL/XHu/dkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0Yd+tdhwTRa5ay2MDOIoLB0Dea9qcJg/5oKRSS6GJHl7ak/pMq5PefCwiqNWcNYUOuaL8BQVjB7f21HTQFEuMEce1o9tj9WvppxhuFFwINiuZpyP97JQP2d/cr/4lMQPtAAIRtUhzg/ufPQoHGvdxqSCHRtU5ZYsD425Iy1PhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NK58wOUf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sGYy79ge; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NK58wOUf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sGYy79ge"
X-UUID: d8decfb67e2511ef8b96093e013ec31c-20240929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IYW719ZcZwZJhy2JDUHBQut82AyHq/duLAL/XHu/dkg=;
	b=NK58wOUfzpyLNWA/C2JhImSBvBzPNs7SlUw1K4XGiugYpfaSBPpViXFM6uicnF4++FkrsgKULrhNM24xfkI4YwH7b6MjIVpCr6EDNvD2cCV2ovdr3OQ4yLS0mFeEgIrG2KnzGwWlzx9HmtsDaYbl1k2JIDubYVS/MLsA55j3LLw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1b569ac8-541c-49e0-8302-728a14bdbc03,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:7884b99e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d8decfb67e2511ef8b96093e013ec31c-20240929
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 92339070; Sun, 29 Sep 2024 13:44:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 29 Sep 2024 13:44:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 29 Sep 2024 13:44:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqNZFKmifNJ95IWm2phdbepw1t5CRVDdLqF7Bfm9jjZpwRT6b26D44uAhE5htOYfgn9rVb91KGvfpWsZppb98fVZGTrTp/BEp39gIjZVHz6xz7F3gafkojZpLMKvGSFjWQ2U4pw7Gp2Y9RCTcHXzZsuTGai4nL0lOHrfQKjgc2K6InzTGVH8CBMkvuRHLiuYf9wsxWUYtWk6UpKXKs0ov8/W4/qY2X/Z3X2SUSqVhzhGwS8W/SLe+uJhmGHfB26OjLSp0yx6Ennbeq/N0SjQ3HmbfGVH6N4VWhzTKdD8hqyC0Q3Q++9/n6TYwa3oggnCjdGFj3u4SfpeX+LhoiuIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYW719ZcZwZJhy2JDUHBQut82AyHq/duLAL/XHu/dkg=;
 b=PaJnnEZQUiUnfZjBcjr4aACzvmgJtIsLFFYEEs++fZC3jQ46Zhx91cS7P2uSrRdloU2evVPIHEd1/3zOIs2oGQrw3JYUz3UdlX23n9dkpjzRqbkNPKEAy+4/7hTHvAOaxpip41iQe+5kNK+yMgimxLVEQ3M7in2BPwTknbLW9pCarzGEKalM8vTuAku28k+OdYW2OmU3SQG20iESmHVo+bRfeZ5aADwOd3R2mLNYx7SA7qvqstfLrxXP5pkZFNCnyWAOIhmrxWVP/OrlbeY9JagbYzi6yGVIsGjYONQDwNQeWRMraLO284VqYwNivUCgQ7K2630SEcs/6PVFX2q6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYW719ZcZwZJhy2JDUHBQut82AyHq/duLAL/XHu/dkg=;
 b=sGYy79gedOg5hos+o0NVOoFz/C4FKSj0B5RYSeQarVQ9C72zyo07fxvE1x/cpwe0raae8iv3PCZbK2GhbXdaX7GQKCsa6YM+YEmzeYVPWor9yLZrLrh3GHAke1N6E4XWeKWyCQ3Oe21E9qTOpyk7ezOr91BEXZ4dzdK2Mtqf988=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by TYZPR03MB8840.apcprd03.prod.outlook.com (2603:1096:405:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 05:44:04 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.7939.017; Sun, 29 Sep 2024
 05:44:04 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Thread-Topic: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Thread-Index: AQHbD+Jq80TZI8etl0C24ZUXGSUna7JqPmaAgAQHAIA=
Date: Sun, 29 Sep 2024 05:44:03 +0000
Message-ID: <ebc787cfb5c89588deeb219190e4fbc4f3f90436.camel@mediatek.com>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
	 <20240926070405.20212-3-andy-ld.lu@mediatek.com>
	 <20240926-footprint-faster-4263120d0b83@spud>
In-Reply-To: <20240926-footprint-faster-4263120d0b83@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|TYZPR03MB8840:EE_
x-ms-office365-filtering-correlation-id: d1b9882c-88b0-426f-69c8-08dce049ba1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVQ5TUhPREV2bGRrYVVkZmpyREQrK0NMdHY3RmlwSmFOYjBlWSszWndmdTU5?=
 =?utf-8?B?UGRSM1NETzJPbXg3bnZJalBESUpoejM4MHBJR1hGcmxka2dQSEI1N0MzcGtI?=
 =?utf-8?B?eVZpUDJQVi9URy9odVRwN2IybnlyTlR5b2VMOVpWTjFuUjJiRUhLOExnZDB2?=
 =?utf-8?B?TDVPU1BaWUNlWU42bnBCTTQrNlUvb0p5NDVqbm5PU2NHNHlPSWZZMVZ2MnBm?=
 =?utf-8?B?VWdadGZDSnZoQlo1VEpucmtTS1BSKzJ3WDVOSFpLYVhwaFJITjZGMlBzQW1K?=
 =?utf-8?B?VmtUaXhOeDd4dzJCSE5tQ3cvRkZ2V3BPUjJGS2JFQlVoeGNoVFBac2M4S3ZW?=
 =?utf-8?B?aE50eGdIMGJVWG9ELzdJcm9RL29VdUhQYVlFUFdQbHBFRHBpZ2Z0OTRrU0s4?=
 =?utf-8?B?dGY4K0F5S0Njd0ozMnJQdithREgyN3FPWGdJZHRXSG5HOGwxOEUrYTVoSDVT?=
 =?utf-8?B?SENNM0JseHlxNXhxTUR0SS9aZUZRTThvTExPclNiTm9TVUtWVVNWRmhaVnh5?=
 =?utf-8?B?VFMxY0Ric1o1VHpsVCtaNEpYd1NZL0lxL0lOUTdUNnBOOTgvT0IvOU1UeUpM?=
 =?utf-8?B?d0V3clB3bmw0bkZiRW9EdVhoODBzdE00TUtQU1JXZ1R3U1d6Q29xaWpCaXBi?=
 =?utf-8?B?UU5oUU9tbXg5SmdDbnhDUlJUUFZtbEFJSU42Ym9kbm14MmFLUXgyWmRuV2xO?=
 =?utf-8?B?QkZBL0RTd0VzaitRNzMwMEZUZzVWbmZxNEs3Y256UDlMM3lBdVUxS3VCcEUv?=
 =?utf-8?B?aURoSWpCZmxsVUxMcGZFSWlKK3dYa0FYVis5LzVEVUk2UTJQeS92VVpZSC9v?=
 =?utf-8?B?cldkVU14TzEzVDNCVE1SZ25YZ2lYZFlFNi9yMDNCYUNFd09DaUNHWk9BVnFZ?=
 =?utf-8?B?ZW1lT1BGbks5ZXM3RWIzUUN0Sy96UFZWUFpPN3dRamxXTHlSZVBmSjBKMU4w?=
 =?utf-8?B?ellxNk5iamc5KzErYU53aEc2ZlZoUXphNnlGSFFZWG5SYUc2aDFzbjhRUlVn?=
 =?utf-8?B?Tkh3eEVkaVpkVWluRFVDb0Z1UGs2eWNyc2Q0dkNJTXh1RFFKdDE0RjQ5RmpK?=
 =?utf-8?B?RGY5Q3EzVmUySDZqczV3Z1lKZ2hzWGRlbm04bDhjdnU5MDc0Z1ZkVFEwaFVs?=
 =?utf-8?B?TFIvWnNlN0FYWjltRldKeTk1ZmVGeXBOQWhFSm5vY0o0bWJNMW9reFB5bGYv?=
 =?utf-8?B?MytmUm1qWS9zdkZLRDNNUWZ0Wm5ZZTYrMTg1akJsRk5scjFXYmpFRHM3SzY2?=
 =?utf-8?B?bFhvL0ZYQ29kbGFIVHQ5ODA0MDcyUEF4WDBvQkUySmQ3eUczTEZ6eERrQk9I?=
 =?utf-8?B?d2V5Z2dDQUNyK2UybHprOEZUTm5QcUxnTTI0WVluUyt4RElIR05tYTlETVp4?=
 =?utf-8?B?bm1qVndHbmg1M0JIL0NHczJpcDhpNnBicExYYnNVdVFRVEVPYjVMMUlRY3hL?=
 =?utf-8?B?Sit6dUYzTUJSZzR4RTZZWEZvQi84N0NVekRxWXV6K0dad25DYXV5UnlMQWpE?=
 =?utf-8?B?Q284N01tdCtVMUZDckJVMm1GMWFOT2h0QmpnT0tMS1RTbk9tTUcyUzVoVU9R?=
 =?utf-8?B?N0ZYSDRlMWRPK09lb2xmOXUwK2NVb1FuRXRGMXB2YXY3R09SaUVhMWtqUjBn?=
 =?utf-8?B?Q1VzY01Td2h6K0Jld1U1S0FCdHg1eDNCNFJuNERzaUxFOUdLdHFkVElYVFc4?=
 =?utf-8?B?dEJGR3p1L1M0Nis0aDNFd3M5Z0RHenVocmpmK2pNTTBxcUhiWlY5L1k3ank2?=
 =?utf-8?B?MFc4cC9LVGE3a3FnR0tDclRVQThDNGJuK1lKMGhHVGNDR21lcFZ2dUtvakVR?=
 =?utf-8?B?UTVSRzlkME9DbHQ1R1N4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjhzSDlTeURLT0NLbGRDWTRuS2g2WUlCeDl5VDZnT0hOaEpNL0dKRmhvakZ1?=
 =?utf-8?B?M04wNjZFdzFGMDluWTFRYnpGUnlFb1M5RkFkRnh0OHk3TW5JTFpUaS9rN3g1?=
 =?utf-8?B?MEpYTVBJMU9QMy96Zk5pSVFJaVBxL2Y0bm1iZTNWaitUNmNMaUQwYlo0NVV4?=
 =?utf-8?B?QVNhUDVlV1hWZlpXMHN3Y0U4NDFleFJhVWs3aGJjZGZDN25EWlBLRytQZWpS?=
 =?utf-8?B?bUxzU1lMM2tYSVQyeEI2VHZGeVkrVzNyTWIvL1B2clZjSUlFaTNjMVF4SEhz?=
 =?utf-8?B?S2ZjQVRZS25FUHNHdTV5NGxNZ2dURThIaFBlVFdxSmRzdkh3TFZJaVp1aHZw?=
 =?utf-8?B?VitjQnU5dWxHcnhIVTJla05qSUxkSDgyNkZLamN5QndjQzMwaGZkSUE5S1I4?=
 =?utf-8?B?UEVDTjh4SWVZNHp6aTVDWlFINWY1K2FhOEdZdGRsQ2NFZW83M0xoN05DRWNr?=
 =?utf-8?B?UldQWFRFUVlKTWJiMllVZEpWRG1VUXpzZDB1b0NldlNZWlZjWWlJY0NNRlRl?=
 =?utf-8?B?VldPMTFlSEx4NjRMMmNMNmtnaCtjV29HQWhOQnRKT09GN3Rhc21zNXF2UzVm?=
 =?utf-8?B?K1RhT3BqK2lPS0NFcnhPeTJtcVlxQVE4cmV6eGJ5SkpQOXpsYVNDb296Kzdo?=
 =?utf-8?B?NkpHbTA4UjRNdWhJOEhteXU5ZmhhUDIvRSsvL3lGUU5Jbmh5Wk5jZTdJYnBQ?=
 =?utf-8?B?aEZsOFYybFF6aGZjUEJsMnFiMkFFZ0pCTFNXMUJjWE9xUk5ndVhrb3ArcEM3?=
 =?utf-8?B?OFdKY1BWcGVBRXY3K1I2NDFqVmE3a08xNjZpQVlKNG5EQkpTSGptdWxNL09D?=
 =?utf-8?B?QVQ2ZnNwV09wcVRJVTgvTGdJMG41bXA0U3NZSmJqY3kwbExSdEd0ZnIzbHEr?=
 =?utf-8?B?U0FRR1FHQjVScHFQRTg2azl5UndWM2xzZEs5WE5VcmdrUVZsVnJOSGkySTNs?=
 =?utf-8?B?djZMOUF5SDQySWhjeGVjSk1Ya1Bmdlk2ZTRFaHBsYWpFeEp0MHd0Nk81UGtj?=
 =?utf-8?B?SU1IbGpySzhEQVkvcGRoaGwzdXpCOE1HYUdWVElsRzFCRWpvMFZ5Mnp0angw?=
 =?utf-8?B?elJsc0FvUGxzWmd3cmp1aXJjUklHVDZyVzZON1NUbC9sUzlnR2ZhclR1VDdm?=
 =?utf-8?B?YXdnS29RWkZPL0FQZXF1TUpjbzNHWmh6QkVyVTR0OEFZNnNTOUxTSWc0NWtV?=
 =?utf-8?B?dXNTUUcxMjJmK2x3cmpGRXRMSkhjdDV1QS9sRlRlMVZTTGxqbXdQbVY1SFpR?=
 =?utf-8?B?QktRSFYzYTFaMnVMcGUzRHZsbmk0S0ZwVDNRaTRUVGtVM0tZT05zYW04WlNK?=
 =?utf-8?B?NE4weUVQc2ZrbkMvTTFtSDc5SWVjTGllbkVsRFByV0tLd1dleFl3T0lMWldV?=
 =?utf-8?B?cHE1bjIvUXdCaEJFc2Z3SDhoU0EwYVdodzAxdVVpOE04OFZEMmhtcUFCanBY?=
 =?utf-8?B?cTNWWG9RWitsalp0VEg0WVV0TVgrWE9KMnY5L0pYOTl2RzdOVHJTRC9Nb3lO?=
 =?utf-8?B?dE9SR3JVakNuSWpMQjZHMlAvOFloaTRqcWZvSXlUQnY5QWc1TW9WY3htMCtN?=
 =?utf-8?B?M3k1TkFqWm00dHh6RHBNZ0dlVG02WTlnaFhtcGxRZnA1RFYxK1pqZXZkZ1ZE?=
 =?utf-8?B?MDgzczlaYmZUVFcyNi92anlUQVJHejNrenRNejBWWlpSb0N4Ykw3cnp5bnRk?=
 =?utf-8?B?d0FyVjRySWJvdmVRTGRUcXJrbnV1NjNlTHJ3dS9sME9hNjFNd3hJeVI1MzRX?=
 =?utf-8?B?M1BQbUhNZDBoSEdmM2w5ZmtVVFJHT2FqemlEa1h4TjhFWTRXMGh5TVc4d0R0?=
 =?utf-8?B?d0pBWVRxSmlLbUdVZXprNTIxUlV2WFVtL3IyMnJuZnJ5WVM1UU1NbkFHeDhU?=
 =?utf-8?B?dXdpRzcvUFFGZHpxdFJ4ZEQ5c1ZNSGpuZGUyMnoxOU9STGgvdmV6RzdTTWxr?=
 =?utf-8?B?ckV3MHF6YlYzc1ZRVjNCajBIUXZrQjhZaHdsbnhITmZBcnpiRUVqNTNWMFpn?=
 =?utf-8?B?UlF6YTBTdCsyR2dMSjVOOGg1R3pZOWZGSzRGZHlrdmpocWM5YXFRWWxmVWZo?=
 =?utf-8?B?aVB6MERwVVp0NlRJU3ppUjhYVm85NHl5ZGN3cFNabUxjTnVURENrSzYvS1o4?=
 =?utf-8?B?QUVsK0tIb0MwNTBsa2lwcUVOM2xsRDdPRlF3ZXM3Y3RzSnZZc0N2SVZNcEYr?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59D6B00C6FC15E4C9E88CE83170D7B02@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b9882c-88b0-426f-69c8-08dce049ba1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 05:44:03.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmEndqAsi0p38ojHtVd2ZrhME5xOQCXvSEzXAI5gwf0ZDFJPwzyIiiWpmBwCQLsJsPMgWBHQusSkALhL7YMK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8840
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.020100-8.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml7UL3YCMmnG4ia1MaKuob8Pt3aeg7g/usCe9toQ6h6LE/pP
	TpiJsbHh7T1wAB4BvwkOYgThO+DmXyHdfLUqdAhEXP5rFAucBUE4WsSNiH/UXg2Y8xyy93kWnqu
	PoqaCESfBq99DqBwCVk9eeEgdEQKSs+KpsQUlyYVmvZ4BRIIeO8I4/HWRf1tgRQ0dAChl/lw9lz
	qxd4QA9Y+pAn19BHXOWEhgJ5bFKd6kefSXk/iudTPDkSOzeDWWmoKXVHfiMM8dY1owGR6BJ6gF8
	LHYfOYGcO0bH7mJ7CPiW3HM+P0SfNf6NZodn93nhsE+u3nnCfA6En2bnefhoP0TP/kikeqnIzYa
	oYqzUoCzv1i8yhSSopGTpe1iiCJq0u+wqOGzSV0LbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.020100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CBAAACFB0E7DECE73DEB80B44DDE9401B3692CA6AC1CC5F42EDC87D6AD1E6DD62000:8

T24gVGh1LCAyMDI0LTA5LTI2IGF0IDE3OjEzICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgU2VwIDI2LCAyMDI0IGF0IDAzOjAzOjE4UE0gKzA4MDAsIEFuZHktbGQgTHUgd3Jv
dGU6DQo+ID4gRXh0ZW5kIHRoZSBkZXZpY2V0cmVlIGJpbmRpbmdzIHRvIGluY2x1ZGUgdGhlIE1U
ODE5NiBtbWMgY29udHJvbGxlcg0KPiA+IGJ5IGFkZGluZyB0aGUgY29tcGF0aWJsZSBzdHJpbmcg
J21lZGlhdGVrLG1zZGMtdjInLCB3aGljaCBjb3VsZCBiZQ0KPiA+IGFsc28gdXNlZCBmb3IgZnV0
dXJlIGNvbXBhdGlibGUgU29DcyB0aGF0IHN1cHBvcnQgbmV3IHR4L3J4Lg0KPiA+IA0KPiA+IEFk
ZCB0aHJlZSBwcm9wZXJ0aWVzIGZvciBNVDgxOTYgc2V0dGluZ3M6DQo+ID4gLSAnbWVkaWF0ZWss
cHJvaGliaXQtZ2F0ZS1jZycsIGluZGljYXRlIGlmIHRoZSBzb3VyY2UgY2xvY2sgQ0cNCj4gPiBj
b3VsZA0KPiA+ICAgYmUgZGlzYWJsZWQgd2hlbiBDUFUgYWNjZXNzIElQIHJlZ2lzdGVycy4NCj4g
PiANCj4gPiAtICdtZWRpYXRlayxzdG9wLWRseS1zZWwnLCBjb25maWd1cmUgcmVhZCBkYXRhIGNs
b2NrIHN0b3BzIGF0IGJsb2NrDQo+ID4gZ2FwLg0KPiA+IA0KPiA+IC0gJ21lZGlhdGVrLHBvcC1l
bi1jbnQnLCBjb25maWd1cmUgdGhlIG1hcmdpbnMgb2Ygd3JpdGUgYW5kIHJlYWQNCj4gPiAgIHBv
aW50ZXJzIHdoaWxlIGJlZ2luIHRvIHBvcCBkYXRhIHRyYW5zZmVyLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFuZHktbGQgTHUgPGFuZHktbGQubHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwgICAgICAgfCAyNg0K
PiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+IGluZGV4IGM1MzJlYzkyZDJkOS4uODJkMWE5ZmFj
NjdjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvbXRrLXNkLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL210ay1zZC55YW1sDQo+ID4gQEAgLTI1LDYgKzI1LDcgQEAgcHJvcGVydGllczoNCj4g
PiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTczLW1tYw0KPiA+ICAgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxODMtbW1jDQo+ID4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODUxNi1tbWMNCj4g
PiArICAgICAgICAgIC0gbWVkaWF0ZWssbXNkYy12Mg0KPiA+ICAgICAgICAtIGl0ZW1zOg0KPiA+
ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ3NjIzLW1tYw0KPiA+ICAgICAgICAgICAg
LSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW1tYw0KPiA+IEBAIC0xNTQsNiArMTU1LDMwIEBAIHBy
b3BlcnRpZXM6DQo+ID4gICAgICBlbnVtOiBbMzIsIDY0XQ0KPiA+ICAgICAgZGVmYXVsdDogMzIN
Cj4gPiAgDQo+ID4gKyAgbWVkaWF0ZWssc3RvcC1kbHktc2VsOg0KPiA+ICsgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPiArICAgICAgU29tZSBTb0NzIG5lZWQgdG8gc2V0IGFwcHJvcHJpYXRlIHN0b3AtZGx5
LXNlbCB0byBjb25maWd1cmUNCj4gPiByZWFkIGRhdGEgY2xvY2sNCj4gPiArICAgICAgc3RvcHMg
YXQgYmxvY2sgZ2FwLiBUaGUgdmFsaWQgcmFuZ2UgaXMgZnJvbSAwIHRvIDB4Zi4NCj4gDQo+IElm
IHlvdSB1c2VkIGEgc3BlY2lmaWMgY29tcGF0aWJsZSBmb3IgdGhlc2UgZGV2aWNlcywgd2hpY2gg
eW91DQo+IHNob3VsZCwNCj4geW91IHdvdWxkIG5vdCByZXF1aXJlIGVpdGhlciB0aGlzIG9yICJw
b3AtZW4tY250Ii4NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KSSB3aWxsIGZvbGxvdyB5
b3VyIGNvbW1lbnQgaW4gbmV4dCBjaGFuZ2UuDQoNCj4gDQo+ID4gKyAgICBtaW5pbXVtOiAwDQo+
ID4gKyAgICBtYXhpbXVtOiAweGYNCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWsscG9wLWVuLWNudDoN
Cj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0K
PiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFNvbWUgU29DcyBuZWVkIHRvIHNldCBh
cHByb3ByaWF0ZSBwb3AtZW4tY250IHRvIGNvbmZpZ3VyZQ0KPiA+IHRoZSBtYXJnaW5zIG9mIHdy
aXRlDQo+ID4gKyAgICAgIGFuZCByZWFkIHBvaW50ZXJzIHdoaWxlIGJlZ2luIHRvIHBvcCBkYXRh
IHRyYW5zZmVyLiBUaGUNCj4gPiB2YWxpZCByYW5nZSBpcyBmcm9tIDANCj4gPiArICAgICAgdG8g
MHhmLg0KPiA+ICsgICAgbWluaW11bTogMA0KPiA+ICsgICAgbWF4aW11bTogMHhmDQo+ID4gKw0K
PiA+ICsgIG1lZGlhdGVrLHByb2hpYml0LWdhdGUtY2c6DQo+IA0KPiBUaGlzIGlzIGFsc28gcHJv
YmFibHkgZGV0ZWN0YWJsZSBmcm9tIGEgc3BlY2lmaWMgY29tcGF0aWJsZSwgaWYgeW91DQo+IGhh
ZA0KPiBvbmU/DQo+IFRMO0RSIHNwZWNpZmljIGNvbXBhdGlibGVzIHBsZWFzZSwgbm9uIG9mIHRo
aXMgIm1zZGMtdjIiIHN0dWZmLA0KPiBzb3JyeS4NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQoN
Ckkgd2lsbCBmb2xsb3cgeW91ciBjb21tZW50IGluIG5leHQgY2hhbmdlLg0KDQo+IA0KPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ICsgICAg
ZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIERlY2lkZSBpZiBzb3VyY2UgY2xvY2sgQ0cgY291bGQg
YmUgZGlzYWJsZWQgd2hlbiBDUFUgYWNjZXNzDQo+ID4gSVAgcmVnaXN0ZXJzLg0KPiA+ICsgICAg
ICBJZiBwcmVzZW50LCBzb3VyY2UgY2xvY2sgQ0cgY291bGQgbm90IGJlIGRpc2FibGVkLg0KPiA+
ICsgICAgICBJZiBub3QgcHJlc2VudCwgc291cmNlIGNsb2NrIENHIGNvdWxkIGJlIGRpc2FibGVk
Lg0KPiA+ICsNCj4gPiAgICByZXNldHM6DQo+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+ICANCj4g
PiBAQCAtMTkxLDYgKzIxNiw3IEBAIGFsbE9mOg0KPiA+ICAgICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE4OC1tbWMNCj4gPiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbW1jDQo+ID4g
ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4NTE2LW1tYw0KPiA+ICsgICAgICAgICAgICAtIG1l
ZGlhdGVrLG1zZGMtdjINCj4gPiAgICAgIHRoZW46DQo+ID4gICAgICAgIHByb3BlcnRpZXM6DQo+
ID4gICAgICAgICAgY2xvY2tzOg0KPiA+IC0tIA0KPiA+IDIuNDYuMA0KPiA+IA0KPiA+IA0K
