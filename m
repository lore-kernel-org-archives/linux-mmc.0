Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F7200DE;
	Sat, 28 Sep 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529268; cv=fail; b=N7jAo9Uwtnw6dfMW1ayqGSWwTuKx2booJUm4zO28GbMTU2AVkooZ7u+nwYd+ym9+N3EhZQu7HI1wpvVubiDrsKiII8fGrtW3Oh3wjNGvQsd9XAGTFQ8CuH7pHqropE2KcRUP1Hwp1tIM/i9rYaYZJVvxlXlmEKPZNAnFb/yOVsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529268; c=relaxed/simple;
	bh=sJcILQj9LI3NWGy82Dvte48ce410bR666CEq9BAFSEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVXivO7h/1L9gOZfky2GzNhMpbN6lRarLLdR1RztR/6beQPORcQPnCqQ6FluF/1hDI2dYUQ7d9ITAevH8tOHrOZZUPO0ijD2+82xKJgySqal05QJcU1OuSFjQi+AswoUrUTX+DFWFSGUHBcI4IEajwiX4jkxnL4LnWYL5emNX98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MFQ0PvuA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NqwMRAFt; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MFQ0PvuA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NqwMRAFt"
X-UUID: 8cde23b27d9b11ef8b96093e013ec31c-20240928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sJcILQj9LI3NWGy82Dvte48ce410bR666CEq9BAFSEI=;
	b=MFQ0PvuAakTO5sOWNE4thrJgO9bdYL0UHgyW463zYN7rkIG7veHYbdBXTtAFYTrHMwacYoLqlZ5/MaPg8oh4kWpWeD3PYuu1ouNb7MhC6RNelzISNsvZqqKFVBW6UZfxDgNhRx6E+KgNOeEMFCdaDksvXg8UH8m0U/MTwIJ+fUg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:aeec6f7b-a0b0-4095-b4e9-8b470c99f4c5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:40dd6418-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 8cde23b27d9b11ef8b96093e013ec31c-20240928
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1366149505; Sat, 28 Sep 2024 21:14:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 28 Sep 2024 21:14:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 28 Sep 2024 21:14:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNP1qCjCW5okadc9SR64Wy7SsFxuUc0lGJ5qW1/+ppTIBD2TictjWRuU0edPLTK/NVDld7cdz15zubUH2GxzLhJpHVWAUTMDDekSCOpb6f8OfKtGT20cBJm1UUWt3h+EoQ4kdXH7OwISXzxt0Fv0bWPZ0cpNHGQPeaPng12ODekfiiSs/ArkUQSCe9j8CjQdaoi+vJo4/OXjDMISfg9emGu02BxqHVJ8oUkddJzoKyrWxbFQbFaze3wV11aCNISqQWYtjpaHmpiwvwW2qdTHUE6b55KBf1CuwTStILkO0QdfZt490QYN5ruwFCYuJbllWN4FxRZrZlHM1EkjH/D7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJcILQj9LI3NWGy82Dvte48ce410bR666CEq9BAFSEI=;
 b=g9ukBjh9dG93i3ye6YU8n2fHMpd39qa7W4dS2DyDKWX33DYK1N0WUUhUpvqN2PAXWokLSnE3BVPjdwVdK5EXxjFNOQJGGHLYvzHePzVSDixW6mEfkXI+F2boQkyH3ZpvB/s39Hgpp1I16IqHlNtfPspJK2dlGG9oiEWLVTRGWqM0+BFPy3glVkDu3Oy8DcmPIFztUDkhiJLapGaM3JJzGniT75eK3YeWXvELH9Qk6tyL/XdgMW93hbG62KLFfYvi4+vUrA7q9FGh3s9vlp/SweqIy69oxee3JaEnQkS86jXyQ44CpcJeUTkUTxVfBioUHH0GFpMBJNSQ5trKGG6VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJcILQj9LI3NWGy82Dvte48ce410bR666CEq9BAFSEI=;
 b=NqwMRAFteLHnWdvjkro5nbi1daWtpr8vbexeXSB35c5WrOAwmjeBDNepiLipBvhLVs3sQNRj7McqPlzGjwfbYEkMi17u6h+x6wk1MAPEqhM2GigVKWNxfcSMss9PyQslU+nEktN5i2GrwNQwEcM3iKiYfe5keq3lMTYsK69zifg=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by SEZPR03MB7753.apcprd03.prod.outlook.com (2603:1096:101:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 28 Sep
 2024 13:14:04 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.7939.017; Sat, 28 Sep 2024
 13:14:04 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
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
Thread-Index: AQHbD+Jq80TZI8etl0C24ZUXGSUna7JqWmeAgALWY4A=
Date: Sat, 28 Sep 2024 13:14:03 +0000
Message-ID: <10ce6e9af6daa69735f46b45028ec1b2d25ee66a.camel@mediatek.com>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
	 <20240926070405.20212-3-andy-ld.lu@mediatek.com>
	 <20240926175409.GA2644361-robh@kernel.org>
In-Reply-To: <20240926175409.GA2644361-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|SEZPR03MB7753:EE_
x-ms-office365-filtering-correlation-id: 83adeff7-83b5-4fa2-6549-08dcdfbf6cfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VGRlZGlTNGF1b1FJeDlxYitORWZ4RHFhY0dkeWZKWVl3aGFnelhUZ1dzeW1o?=
 =?utf-8?B?K3VnMlBtakp6Z3dJN2dieUxvTzJuSTZLWU5SNFFBb3k1SUlXbjIwdkpqQldK?=
 =?utf-8?B?SjJuc01QT09vc2NjVWM5NDYxTS9RVXZnMFBiQmRKdnA3cmc1QUFmMGZjNnFL?=
 =?utf-8?B?VFFuT3lqaWw1ZVJlU2pvZWFsRFhlNHdRWXI3anB5bVEyMmlWTXhWRDNmc0xD?=
 =?utf-8?B?bVhhMVZiQlMxbVpncHZXOG11czVqUWMwYVVpRk0rRko0bGY5cHA1ZGxCNm9Z?=
 =?utf-8?B?R0pSYzB6eVowNnY0R3NoTWtueWRzM1RJZW5NUHE5SjFkWjRVS0ZiRWF2UVRk?=
 =?utf-8?B?UUtIWEhzSXZLZGU3MHhKZ0s3aGF0MWdEb3loTmdYQXFIaGVKcW41WTRONms1?=
 =?utf-8?B?YzdYMUJWTzF3WWV4aXZBamhaTTl3WHlvcnArNmdZdVRxUUM0K0VJczF1ZmZ0?=
 =?utf-8?B?YUdSemllb0RrdzZYMk05MkpFblIrMG52Q2ZQRlVlc2pGOFcwcWNEamhUNXVq?=
 =?utf-8?B?SHY4WU5oL0lZWU0ydW9ITVdyaGp1eGJDczgycnBwcUNpRFd3WVhkclppQjVz?=
 =?utf-8?B?bmJTRjhBeDYwbGZGVUxyRnBoQ3krbzFLR0s1VmR2UWVIcU4zOW04OTAzUGJP?=
 =?utf-8?B?c2UwTmxqcjRGOFF5b1IyOExOalVqcy9vakl3TU1YdEdXc1RjbFFJektlQ0tR?=
 =?utf-8?B?c05vTkFFcThCc0xOZE9TY0UveHVnaWN0R0kxQ2dqMWtNRmYrbVNjYnBaaWU5?=
 =?utf-8?B?Q0dYbGZrMlRibUYzQmFsZVU5cHE0UFplUWRrNWxNeGJLK29QeTZIakhoQTY0?=
 =?utf-8?B?VlZ2Zk05dUZUR294by9xTmdBdXhPTko1eSt5ZkZGOHNPbENPMHovdW1BaExu?=
 =?utf-8?B?bGJVRXdLOVFZZUdBNlhmb0FQOXUveFF6WUt3TzdUWldvaG85VGJ4R1dmUzRj?=
 =?utf-8?B?UUF4NmtWQldYdHpLdTlpSUxkZEdscmk3SUZDdVZGaGpadjNDY2xqQ2lMUVRt?=
 =?utf-8?B?Z1lrOVdPckVCOHRJNTJuOHRuNS92R2NEelFSaUQya1YwOC9oaVhjS1N6Q21t?=
 =?utf-8?B?bWloaWlaWXg5KzMrOU5GS2FQbEVwS3VGT25nVkJLMTUxLzRHMWd0MFFnbWRI?=
 =?utf-8?B?VXIzNHlNNlNVZ0dCNFJNRmNPcUJiSng3d2tqSzMrbzRyV3d0TjRCN0xVdUFi?=
 =?utf-8?B?YmY4TzlVeFduUDdydlgwb0hOc2ROTFpnMWkzUjYzeUFZejVqL1A4TkxKYWg3?=
 =?utf-8?B?NzZkTGp4aldBT3FFcEl1Y1ZlN1dJbi9rcjRWK1FLNlJOZlE0TWJKNGJ5M1pF?=
 =?utf-8?B?a0hiTHNkRm56K3FwZitHKzduMVRrb1hXK1kwTWM0Ny9jREVVOU9tNkJTUHpW?=
 =?utf-8?B?S1BjOTRuS3V0WXR0QjQ5ZlZXNFN2OVBnUlkwaWlreThQV3RBN3pXVURaakwx?=
 =?utf-8?B?UkF3b0gxeEUzeFBtOFpCSkZRdnJtcURuc3MvSEREZHlLbW0yeTJGK2xPOGVX?=
 =?utf-8?B?b0x1QTJyYlQ4MGVKSmEyMThtZzBMTVQ2MGNYcDMrMVJRT2EyZ1BaNy9JNGt2?=
 =?utf-8?B?b0pybkVvQzRpd2ZDTGNaY1hRWGZjV1dtZGtsOGFnR3kySkF5c012MnQ3RHlp?=
 =?utf-8?B?Vi9HUGJ2TjBDeHdFVTlaNlloUXVYcmlWeGt6WUM4MlFtUXZqR3JlVmdKM2V1?=
 =?utf-8?B?ejkrNWhYeGxrRnc0eHo0dGtLdnR4TWpoaVBzZTlVb3pyVzg4dytIaCthVDF3?=
 =?utf-8?B?c2RKZ2YxazBNNk1qVmt3S2UzNkpORXRGUTc3TnlNcWNVelF4R1EwcUtvaWk4?=
 =?utf-8?B?WjhwcUFUalMyOHorK2pwZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzFsN2V0K3d6SEVodmhlWnJpaU16MjBESEVrVEQrdlhCcktGWHNnTlJPaUd2?=
 =?utf-8?B?OEFVOVkzTnBuNkdSTmJKeXI4U0RnR2VzdWtWWHo3U0o3QmRKcllEbjJTVFRI?=
 =?utf-8?B?dERjcDVwZ2dZMUMvdWNuZWhabjBxOXNJZjk1dTBsYit6QmlSWUp4MVREaWJ2?=
 =?utf-8?B?Vk8rYTFiSjBhM3drcWp5cG5yY0FDVzVhUlRLUVRoWVhPVHQ0MjlLU1RMVy9Y?=
 =?utf-8?B?VWxXOXExVGRIQ3IwTndiQ0djbHNETFJOY2x4NE45RzNmRXJaU254c1VWdDNN?=
 =?utf-8?B?SGhONTZnbkN4VWM0SHY4QzhISUtmZnZ5cEpicjhabzQ3M0lUWklZblRNMnBD?=
 =?utf-8?B?Qjd3eW94cjJWeW45emtLNVZYdEllMHkyUVl6aHZNMlFhazRNL082YmNialdp?=
 =?utf-8?B?ZVNKME5lMGVLWE9qNG11ejFGWTJVeDVRQlV4YVhocG1YSzZtYU1pYjZHUkZF?=
 =?utf-8?B?VzYxQzZwYUdWYnc0UmlFNVVQcldpSVdvVFBoMHlwMjRGU2twZ20wRzRpY2Ex?=
 =?utf-8?B?dnpldk91cGtOSG1CS09qSnJOTy9JdzJUOVUvTjdjelh2Y29wY08rQ0U2d0RJ?=
 =?utf-8?B?bVRObTNpZEgyaUZraWVmMWlnRzZMY2xsRTF4UDYwVksxVDM4MmQxNjlocm9P?=
 =?utf-8?B?RmdBSUpnR2VVdTU5QnZWMVVWdW9xd3BxMEQvZDdUWDZXbDNIM1dGVzQvQWlJ?=
 =?utf-8?B?ZVRUM1ByYnloYk5HQ1RSR0FENERaMjlpeTFXZXN2dTY1NlJaVUgvd3dKbUQ5?=
 =?utf-8?B?VENrQ2JFeTFOa2dPdmVRWEZKUEtURmF0SUtpelAxa0h1SWZUVDFhTzkyU0h5?=
 =?utf-8?B?ZmlNQjdiS1N0a0NZcFcyM2tuVnl6bVNMOGYybjdEaGt2b3J4OVoxQThWcDkv?=
 =?utf-8?B?ZUkrODNmSEZobVhHc3Q0Ui9sK2hVVy95SVpDVmg3RzllNHF5L1dKdWRma3NB?=
 =?utf-8?B?UjJLeHN6NENab3l2VVlZMExBTUIzQ05teUpDdkhZZmdWbEF0Vkw1UHRZQ3dK?=
 =?utf-8?B?eWIxWHhWTDVrZE5kdDNOQXBsc21wQXo1SzdaOXZIZEptZ0M5anhBaVhyYVRu?=
 =?utf-8?B?VDR5ODZ3cDViL0FVbTkvL3lPcDdWZUh6aUJzcm5PVDEvc3QzNDZ0UFRPdjFV?=
 =?utf-8?B?cjg4UnlEaU0wUkptNlJIcUVCeWloUWtmTHdpdVFJdm05SDRNVDBLaFR2clE2?=
 =?utf-8?B?VU9Ec25mVUxlVzhCNXg0QThGV2c1YkdlYUh4QVhma3d4VzN4SWhPeHJUTWtW?=
 =?utf-8?B?NlBOWmprT01GdTBPYUdaNysxTWlTRDhtUTVlUVJTOFBtQVVMMXl1OEN4SUdu?=
 =?utf-8?B?RHhUeFZmUXdvRzVOa3JoRS9KcWZERFpDcEZwQ1c5Q0NLTTNxWmJ3UUJXdGF2?=
 =?utf-8?B?VnhQR2ZFMGpmbU1vVWJWdEF3SmpQaWNZbHF0elpxNnQ5dWJFcWVjaWdKbGtn?=
 =?utf-8?B?ZzlONzBKSVUzSzFVL0ZadUp1cmRaNEdNVmluNkd0NTdKNkJJUlJaUUJkZkFN?=
 =?utf-8?B?cmp6cnJ4Rm1xaElxN2JQM2J2NExxTzdqOVY3cU9XWDR0SjRZYW1uMzlaTzcr?=
 =?utf-8?B?NmJJRktFYXUwSXdpL1QweVUyZkUyaWc2TnZTb0ZIWHVOTzJFcHJVUnJxMEl5?=
 =?utf-8?B?L3l0Zlo0dDZPMTRTRDhMSmI4MVl2NDIrbFRnUnNNb1pvVi93NHlPUkF1YSt2?=
 =?utf-8?B?djU2RjBmbVYvQThQbjRTYXF4ckg4Q0ZpRytNeXpqd0E1eDJ4UWRJN2h0Z0tK?=
 =?utf-8?B?Y2pKNjF0YmlEbTJsdjlscXdJZEpaMXNvVkQ4ckdFV1JSV3pBMFVoZTV4b2Jn?=
 =?utf-8?B?SVYremw0NGNsa0l5VE4zSmlvbzVxd08wQk00SnV4ekFSOU5GYW91Q0JQZklw?=
 =?utf-8?B?WkdKaGRHQkJqTmJtdUk4V1pWTnh5eXRrc1cvT0xLOW1NZ1BpNHErSTBtTmdT?=
 =?utf-8?B?dENKQUZQNmVMSGFBdjdmMWZPVTFvWjNMMU12WGpKY2RsdlJkcTBEOUlhczM2?=
 =?utf-8?B?dWUxTHZHRHA2R0ZaNVJWdTNZT3NJUHhPdjZHU015ejl3ZS9BTGJtR1ZRaURU?=
 =?utf-8?B?UkR5VHVGZ3RNUVh5K0pBY0tPREgzZDN3d3RsbEloNUtVRExLaDRETHFaVHlh?=
 =?utf-8?B?bEUycGtSTkRsN1pXWjBkWStIRm9Gb1pjSmJmeGpFa1k4YTExRVd1VEhaNE9C?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDA429E19DFE174C824F63A9109B0854@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83adeff7-83b5-4fa2-6549-08dcdfbf6cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2024 13:14:03.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlxjIK4+4ObeTknvPQ1Hl+AZuRrmjbuRv4NvlPY34EgOpawD16nE/8qYl7G0lS+WplG9B5sJgObr4sPW+sBFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7753

T24gVGh1LCAyMDI0LTA5LTI2IGF0IDEyOjU0IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUaHUsIFNlcCAyNiwgMjAyNCBhdCAwMzowMzoxOFBNICswODAwLCBB
bmR5LWxkIEx1IHdyb3RlOg0KPiA+IEV4dGVuZCB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyB0byBp
bmNsdWRlIHRoZSBNVDgxOTYgbW1jIGNvbnRyb2xsZXINCj4gPiBieSBhZGRpbmcgdGhlIGNvbXBh
dGlibGUgc3RyaW5nICdtZWRpYXRlayxtc2RjLXYyJywgd2hpY2ggY291bGQgYmUNCj4gPiBhbHNv
IHVzZWQgZm9yIGZ1dHVyZSBjb21wYXRpYmxlIFNvQ3MgdGhhdCBzdXBwb3J0IG5ldyB0eC9yeC4N
Cj4gDQo+IEdlbmVyYWxseSwgZXZlcnkgU29DIGVuZHMgdXAgY2hhbmdpbmcgYXQgbGVhc3Qgc2xp
Z2h0bHkuIFNvIHdlIGRvbid0DQo+IGRvIA0KPiB2ZXJzaW9uIG51bWJlcnMgZXhjZXB0IHdoZW4g
dGhlcmUncyBhIHdlbGwgZGVmaW5lZCB2ZXJzaW9uaW5nIHNjaGVtZQ0KPiBvZiANCj4gdGhlIGgv
dyAoZS5nLiBGUEdBIElQIGJsb2NrcykuIFNvLCB1c2UgU29DIGZvciBjb21wYXRpYmxlIHN0cmlu
Zy4NClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNClRoZSBuZXcgdHgvcnggcmVwcmVzZW50cyBh
IHNpZ25pZmljYW50IHVwZGF0ZSBmb3IgbW1jIGNvbnRyb2xsZXIgb2YNCm1lZGlhdGVrIGZyb20g
dGhlIE1UODE5NiBjaGlwc2V0LCBhbmQgdGhlIGRlcGVuZGVudCBzZXR0aW5ncyByZW1haW4NCmNv
bnNpc3RlbnQgZm9yIE1UODE5NiBhbmQgc3Vic2VxdWVudCBTb0NzLiBUaGVyZWZvcmUsIEl0IGlz
IHByb3Bvc2VkIHRvDQp1c2UgYSB1bmlmaWVkIGNvbXBhdGlibGUgc3RyaW5nIGZvciB0aGVzZSBT
b0NzIHRoYXQgc3VwcG9ydCBuZXcgdHgvcngsDQphbmQgbmFtZSBpdCBhcyAnSVAobXNkYykgdmVy
c2lvbiB0d28nLg0KPiANCj4gPiANCj4gPiBBZGQgdGhyZWUgcHJvcGVydGllcyBmb3IgTVQ4MTk2
IHNldHRpbmdzOg0KPiA+IC0gJ21lZGlhdGVrLHByb2hpYml0LWdhdGUtY2cnLCBpbmRpY2F0ZSBp
ZiB0aGUgc291cmNlIGNsb2NrIENHDQo+IGNvdWxkDQo+ID4gICBiZSBkaXNhYmxlZCB3aGVuIENQ
VSBhY2Nlc3MgSVAgcmVnaXN0ZXJzLg0KPiA+IA0KPiA+IC0gJ21lZGlhdGVrLHN0b3AtZGx5LXNl
bCcsIGNvbmZpZ3VyZSByZWFkIGRhdGEgY2xvY2sgc3RvcHMgYXQgYmxvY2sNCj4gZ2FwLg0KPiA+
IA0KPiA+IC0gJ21lZGlhdGVrLHBvcC1lbi1jbnQnLCBjb25maWd1cmUgdGhlIG1hcmdpbnMgb2Yg
d3JpdGUgYW5kIHJlYWQNCj4gPiAgIHBvaW50ZXJzIHdoaWxlIGJlZ2luIHRvIHBvcCBkYXRhIHRy
YW5zZmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHktbGQgTHUgPGFuZHktbGQubHVA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMv
bXRrLXNkLnlhbWwgICAgICAgfCAyNg0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gaW5kZXggYzUz
MmVjOTJkMmQ5Li44MmQxYTlmYWM2N2MgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPiBAQCAtMjUsNiArMjUs
NyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxNzMtbW1jDQo+
ID4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1tbWMNCj4gPiAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4NTE2LW1tYw0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtc2RjLXYyDQo+ID4g
ICAgICAgIC0gaXRlbXM6DQo+ID4gICAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDc2MjMt
bW1jDQo+ID4gICAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDI3MDEtbW1jDQo+ID4gQEAg
LTE1NCw2ICsxNTUsMzAgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIGVudW06IFszMiwgNjRdDQo+
ID4gICAgICBkZWZhdWx0OiAzMg0KPiA+ICANCj4gPiArICBtZWRpYXRlayxzdG9wLWRseS1zZWw6
DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIN
Cj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTb21lIFNvQ3MgbmVlZCB0byBzZXQg
YXBwcm9wcmlhdGUgc3RvcC1kbHktc2VsIHRvIGNvbmZpZ3VyZQ0KPiByZWFkIGRhdGEgY2xvY2sN
Cj4gPiArICAgICAgc3RvcHMgYXQgYmxvY2sgZ2FwLiBUaGUgdmFsaWQgcmFuZ2UgaXMgZnJvbSAw
IHRvIDB4Zi4NCj4gDQo+IFNvQyBkZXBlbmRlbnQgb3IgYm9hcmQgZGVwZW5kZW50PyBJbXBseSBm
cm9tIHRoZSBjb21wYXRpYmxlIGZvciB0aGUgDQo+IGZvcm1lci4gQSBwcm9wZXJ0eSBpcyBmaW5l
IGZvciB0aGUgbGF0dGVyIGNhc2UuDQpZZXMsIGl0IGlzIFNvQyBkZXBlbmRlbnQgaW4gcHJpbmNp
cGxlLCBidXQgd2Ugd291bGQgbGlrZSB0byB1c2UgYQ0KdW5pZmllZCBjb21wYXRpYmxlIHN0cmlu
ZyBmb3IgTVQ4MTk2IGFuZCBzdWJzZXF1ZW50IFNvQ3MgYXMgbWVudGlvbmVkDQphYm92ZSwgYW5k
IHRoaXMgcmVnaXN0ZXIgc2V0dGluZyhub3QgcmVsYXZhbnQgd2l0aCBuZXcgdHgvcngpIG1heSBi
ZQ0KdmFyaWFudC4gVGhlcmVmb3JlLCB3YW50IHRvIHVzZSB0aGUgcHJvcGVydHkgb2YgZGV2aWNl
IHRyZWUgdG8gc2V0DQppbmRpdmlkdWFsbHkuDQo+IA0KPiA+ICsgICAgbWluaW11bTogMA0KPiA+
ICsgICAgbWF4aW11bTogMHhmDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLHBvcC1lbi1jbnQ6DQo+
ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTb21lIFNvQ3MgbmVlZCB0byBzZXQgYXBw
cm9wcmlhdGUgcG9wLWVuLWNudCB0byBjb25maWd1cmUNCj4gdGhlIG1hcmdpbnMgb2Ygd3JpdGUN
Cj4gPiArICAgICAgYW5kIHJlYWQgcG9pbnRlcnMgd2hpbGUgYmVnaW4gdG8gcG9wIGRhdGEgdHJh
bnNmZXIuIFRoZQ0KPiB2YWxpZCByYW5nZSBpcyBmcm9tIDANCj4gPiArICAgICAgdG8gMHhmLg0K
PiA+ICsgICAgbWluaW11bTogMA0KPiA+ICsgICAgbWF4aW11bTogMHhmDQo+IA0KPiBTYW1lIHF1
ZXN0aW9uLg0KU2FtZSBhcyB0aGUgcmVwbHkgYWJvdmUuDQo+IA0KPiA+ICsNCj4gPiArICBtZWRp
YXRlayxwcm9oaWJpdC1nYXRlLWNnOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIERl
Y2lkZSBpZiBzb3VyY2UgY2xvY2sgQ0cgY291bGQgYmUgZGlzYWJsZWQgd2hlbiBDUFUgYWNjZXNz
DQo+IElQIHJlZ2lzdGVycy4NCj4gPiArICAgICAgSWYgcHJlc2VudCwgc291cmNlIGNsb2NrIENH
IGNvdWxkIG5vdCBiZSBkaXNhYmxlZC4NCj4gPiArICAgICAgSWYgbm90IHByZXNlbnQsIHNvdXJj
ZSBjbG9jayBDRyBjb3VsZCBiZSBkaXNhYmxlZC4NCj4gDQo+IA0KPiBTb3VuZHMgbGlrZSB5b3Ug
bmVlZCB0byBkZXNjcmliZSB0aGUgY2xvY2sgaW4gImNsb2NrcyIuDQpJdCBpcyBub3Qgd2l0aCBj
bG9jayBpdHNlbGYsIGJ1dCByYXRoZXIgd2l0aCB0aGUgYnVzIGRlc2lnbiB0aGF0IHdvdWxkDQpj
aGVjayB0aGUgJ3NvdXJjZV9jZycgc3RhdHVzIGJpdCB0byBkZWNpZGUgd2hldGhlciB0byBwcmV2
ZW50IHRoZSBDUFUNCmZyb20gYWNjZXNzaW5nIHRoZSBJUCByZWdpc3RlcnMuIEFuZCB0aGVyZSBo
YXZlIGJlZW4gbm8gY2hhbmdlcyB0byB0aGUNCidzb3VyY2VfY2cnKGFscmVhZHkgYmVlbiBkZXNj
aXJiZWQgYmVmb3JlKSBmb3IgTVQ4MTk2Lg0KPiANCj4gPiArDQo+ID4gICAgcmVzZXRzOg0KPiA+
ICAgICAgbWF4SXRlbXM6IDENCj4gPiAgDQo+ID4gQEAgLTE5MSw2ICsyMTYsNyBAQCBhbGxPZjoN
Cj4gPiAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtbW1jDQo+ID4gICAgICAgICAgICAg
IC0gbWVkaWF0ZWssbXQ4MTk1LW1tYw0KPiA+ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODUx
Ni1tbWMNCj4gPiArICAgICAgICAgICAgLSBtZWRpYXRlayxtc2RjLXYyDQo+ID4gICAgICB0aGVu
Og0KPiA+ICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgIGNsb2NrczoNCj4gPiAtLSAN
Cj4gPiAyLjQ2LjANCj4gPiANCg==
