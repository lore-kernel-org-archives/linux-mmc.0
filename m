Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60B2E401
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973960; cv=fail; b=CCFM+8NL4j1f2pAth19QfaoJ6mMBvMy82TZmfaBVQTs8dto3CgpveyfbcxyKyO31J1GVZ5c4z707WU5GCuK4ccqoICEBHg6TBEFTBgtZWxKbcWOp2K+NgkPBMBfE2bc/F85fGH+mrV9k17h9m5JXaTYIXG+cNi9KeZylj/dZ89Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973960; c=relaxed/simple;
	bh=/AMt8LjzbyTJMMzkEh0/vLJqz+3vCyZf8nqFNx1Jhx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmVQjivMBz2YWcz2jKqGAedrnLxK8+CpqKmpNMqczXz3npL6RrTZiXFYBZbfMD2tmvQRRh3Of5VeVErPqwaRp/tcVCMLlx0BM+O4BI82zIZThAaRdcM8mjj4dri48GaoM0JKTCZzK3dlbw0chub5w9O/68B0O9jCfB6FnnhXITg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XBdZBrPN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SZ+arBPY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XBdZBrPN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SZ+arBPY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727973958; x=1759509958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/AMt8LjzbyTJMMzkEh0/vLJqz+3vCyZf8nqFNx1Jhx4=;
  b=XBdZBrPN0xHJsL5kzOBFT324nhmccUsSs86Q0ubVWhB+hfgXwBludqbY
   AswMPbzC9zPb3TmOylWAjvZ0arU0KEyBpRz6dmKAY4VC3BxdYweaTuRvj
   doYmqAZFqWS5stbCjtO9m3Btc1w3adNbquIFnZFD3lDFCuIJ+E9khXJxw
   iGsAIJGEovc8ym4E09riAWGTZu5feUGntgwWUevuHDxDQS/Io1UVAj7GG
   ChCBYF9p/iCU+D+gkDTccKELGflY1/Cr9QOe+dJmC+qwqaAVYMbPnJtgJ
   jeVBKoHOxYTwOJSk7r00WhcunB5xw014IT4Tf+tDyAjC3DMUdtA8vA9py
   w==;
X-CSE-ConnectionGUID: fvdqSghkRX+bY4c3b3ANWA==
X-CSE-MsgGUID: Phv1I0BlRiyz/re2JRyjaQ==
X-IronPort-AV: E=Sophos;i="6.11,175,1725292800"; 
   d="scan'208";a="28595883"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 00:44:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atLZx2E1RB9X0cwXRihtFgFMqgYt0LPoudE/NXevABqS7BV6eIptm4L2xJKMLanEqp9+5Zvxqkp+CkcMCzkFv44bZXG/QarCivo0bjn3dfMLTFndfAS7dFAsFwIdJPr8CBiuJBtnl74FFnIOj7U1PVrbbzkhlxAPTjfWlDC/XKxKd1VDXWcIrPQNqpd6QZX3asjnKgNzOOdgoli/szVUvFtngS1hsx4ngXAqjC3VSQ86r2lS4yjhGLhIqsqCfZneX2IfDIF9f8OZptWPTsAdxVagbwjT9rdCSq//k9AOWDb2d3trQ/B8DTiiF9VahxxU8XUUUOtDWB5/RKlGsw5ZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AMt8LjzbyTJMMzkEh0/vLJqz+3vCyZf8nqFNx1Jhx4=;
 b=k38OQZkY9iU+9iTDoziv0tHJ1036JGifO7Wr7aHteGrnmdy63LtKYsbcSrGUM7Mend83OZ+TiJbDcsjPMPtFmhtVk59+B080AJsEEmIq4eEnAUb8Kn/1xzX9tqRzxRSuXFlfgtWnCV9h85Ao7c5ejbKoW0UQBMuGC/+54cszUB90T5wQKWJgQlO08nQEffqk6oQ9oLtxJfPbCNFmqFeZvk2VbNLRP6+L5Hzmrh3haETmZgZ8y4gBSwUbZPEwG0OEDWB2o4ra/5WL9GzN1k6WIXn663MPgwZs8gG76YpzGqN54hH2ZLSeMwjN6QGxy82uis9MwZOyqlq4vgp6JKEwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AMt8LjzbyTJMMzkEh0/vLJqz+3vCyZf8nqFNx1Jhx4=;
 b=SZ+arBPYRz7hX+rinW3xCOFvbAY4EzqivpiFEAa1K6er7M1G8S67835Q/6npfMHK0TuArGMMCgMMeBT2t+CUIjCeP3wPnV9pXr4fsR7UDXFsUwzWV9SdAxtb95Ak0S4o/jgk0raov9BBKl05QO8SaCS9p6wmdn5Pv9t74ay3Ud4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7875.namprd04.prod.outlook.com (2603:10b6:303:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:44:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 16:44:46 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHbAdkB8EapvzC+fEmeN3z7QvpkNrJ1U10AgAAP6pA=
Date: Thu, 3 Oct 2024 16:44:46 +0000
Message-ID:
 <DM6PR04MB6575049927531335ACA5D611FC712@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-5-avri.altman@wdc.com>
 <CAPDyKFqE2SZ1NcsYGpuL4wYW1r6s5Di_4Vrjbkk8uPP82xpoCw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqE2SZ1NcsYGpuL4wYW1r6s5Di_4Vrjbkk8uPP82xpoCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: 276b2b53-7870-47ca-8a03-08dce3cab0ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?clg4TjlzYTYwYWNNTDhZaHpPelk0a2xHQTFmVFlpem10eFNBNlpkdGVtYXVC?=
 =?utf-8?B?bnljeGM1d3d2T3NXOWRHRENaT2k2WmQvMHdSQmlXOFB3STZCUFVxOHJFb2dQ?=
 =?utf-8?B?cFNmaHBPZmFXelBPd3JyeEtHdmc1TFFrUVZiSERNS3pSVElIczRQczVBZjZL?=
 =?utf-8?B?bU5uY3NuZHU4d0R5b1QydzlnUlcvSHVVcnU2VXpLRHZLejRHRVR6bFoxUHlk?=
 =?utf-8?B?SzNnNlQrSC94Y095cXRiRVFLTE9JTlQrQndsZFozY2w0ajNDZ0ptdW15UEVI?=
 =?utf-8?B?Ung2RnRwTTZndHNYeUhkVHkvMFo0ZERaQ2ZpTEwvSEVJd3lOT3NpbVFSb09S?=
 =?utf-8?B?Qi85RjhRNDZoRDRGREd2Q1NQK2c4RlltbXlwUUtvRlpYRnZWa0RzNWVoMDVF?=
 =?utf-8?B?aTg4UUppdkFPci9mOUlzL0xBNmxwQWtlcXNUcFVVVnBkeFNvM3paMG9mNTRV?=
 =?utf-8?B?emlZUWtRdG5tWTlwWi92T3ZYMTAyVy9VZU91MWZEQmxWU0dCR09OY3ZUWFdU?=
 =?utf-8?B?OXlUcVd3bjB4cTZjRHAxTGlxUHhkL1pOTFYvajZrWUZEY0VvRS9yYlN4OHR3?=
 =?utf-8?B?blRlS1dhdnB1VjRwSnJZRFRiUXNicGo2WENMc0EwZGo5dFZUSS81WVVJNDBn?=
 =?utf-8?B?T3RRUnFnUjFxZnNVaThJNEZ5WUEwS25JY3gzdmVqYlI5RkdUdVUvQUZKMUtX?=
 =?utf-8?B?UG5WMEx1THNXQ2dFaXd1b3J3eFhoeHROV0paZjVRMTNmSE1McEY2OEk3V094?=
 =?utf-8?B?Q1JoVXoyUm5ac2R0NGhlWXJTZ2ZjZnViMHkyb2tKS1FyT01tZHJaQzVzOVBl?=
 =?utf-8?B?WGtnbDdINkU3NzFHUXpqVHNMS2xXR1BlcHlZaDFTYVRLQlR1U09zNG1NcG9p?=
 =?utf-8?B?a2toV2NhbGpnSXBtSFlPYXlKVENpUXAzTWJsZ25PY0RJdWhsNWhsS0UxdUo0?=
 =?utf-8?B?dEFxY0xyb1RCR2JQWkdPMzZ2NENDSmRiaGdWM1d3Q3NOM3BPM1hsWjJheFpu?=
 =?utf-8?B?UXBaN25DWFljK3BUeHVCaVQydWgrZEhRZW93L2ZmNzlVUTBGdS9oY3dMM25F?=
 =?utf-8?B?b2F2ekdoNmdyQTcwSjBFOG0yMTZRUWVZTnlXTlo2L0NreVNWK3pWWjNzL252?=
 =?utf-8?B?bk5xaWU3NExpVnY2dkFOZFBwbGNoWVBsZFhnQW4ycmdDSm84NXp4cWg0allI?=
 =?utf-8?B?d1hkVHc0RTB4eW1HTk1mUW14Wmxudm5icHdHcTJwSmx0Y2RYQVNJUHBBdkJU?=
 =?utf-8?B?Q1FaVHJ6YWNxN21VOUl0c2JEU2gveEs3T1FyNkJUWmQ1Nmk0MEcrNzNTS1FY?=
 =?utf-8?B?SVJIYmRMUnhRZW9GV1ZPSVl5SjQ2UlhQMkdGYURDOGhzLzJkdkNBSVFlT3k3?=
 =?utf-8?B?Z1N6WW8vTi9oajR3TjhCRXVpRm53VnFUTFltRytWMmQ2cTY3V21IT1A4bFVV?=
 =?utf-8?B?UmppbmxGQmxEd2ZUZ2RtSXR1eENtZGh1ckJqbXNheWlxRnhpMGVyWlRuQlhy?=
 =?utf-8?B?dU4vbEpmU1Jha2VnYnE0RXJJUk1YeW0xVTdQWWlPdWp2ZjlVZkRZeG9iQjRW?=
 =?utf-8?B?cEYvUlRRV0tRNkU1bWtTR016Tk5tMjdsYkx2RVptTXBzeXk5cVlydVdkUWIz?=
 =?utf-8?B?QldSVXRHVjc3UTlTanVvN1BjMjVlUmZ5Z2pEcUNnZFlIMXhFV25wQ1RMZjhE?=
 =?utf-8?B?MU1MZDl6ZC9BejVPWGYxeWpXWmEveDl1UzJMSkZFcHJPbmZSSlJVRUJzMEtY?=
 =?utf-8?B?UkNCN0pmTEs1RTFPUmR0bUJVK0haWHdZbW9SZlUxYmdtL2thZGVEaTg5b0pK?=
 =?utf-8?B?ZnhIN0R4aGZpS1laS0Rqdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlV6Y2FJOUo2Yy9NS0tnUDRuTzgzSjc5azJpWU94VDFSVk4zcVV1NXhkRnNJ?=
 =?utf-8?B?NUJTQVR6MzV5VXc1RHJmK0xLMDdmejRtR21xZExXTHAzZXMzaytCSVZEWWlq?=
 =?utf-8?B?R25DbUZiM2JRMEpqOW5EVTd0S2RUMFI0OFZOT1FON2g5cW1Hd2xWTDRFcysw?=
 =?utf-8?B?dWNra1M1eHc3c000V1duNFlmVHFJZ2k0aU5LblhkWTF5TFNWWDIxeXpxalpF?=
 =?utf-8?B?cUlPWjF2TnF3Qi9sL3dMSFhVd3c5clJyeGY2MFF1YlE3RmE2SW1rdmpIL051?=
 =?utf-8?B?ZXQ3UElON0s1djBUSXptMkFTQUVEaTJUbkQxODZxOG5JUnJ3dUI2Z29oc3Ji?=
 =?utf-8?B?K1QxNDhaQTBWQmx1bU9FZzJ4TEMyaFlLQ3UrVUtWamRnRlF1eHBOV21zNmJS?=
 =?utf-8?B?elNpRlVaTGxMam44bmh3UGN5b1BSdGFkcThsUmR3VDk0eWt6WTVjMTNGSXZW?=
 =?utf-8?B?SEJPUFlmYTFEbTdqMnV5T2JRSmcwMUpXNDdyN3RQWTI4OGtYWFRtZWxadWJQ?=
 =?utf-8?B?UTJQS0pUVVUzV3o0TngwdG0zUklxWkJHcXZqeWFDNG51UlM4SEJTVkUrYkQ3?=
 =?utf-8?B?a2g0V2hmT3NDUnh2cU5WZTJhODNEU1RCaE4xU2VFWW5qZzhMZ3BMSW5VcWcr?=
 =?utf-8?B?aDFiRUJwRHZ0dnNZOXlIbTJRRWs1bDNLanRVUThQYUQzek5UOEpIUUpnektj?=
 =?utf-8?B?QnozRi9lTWdrZE0wQ3FXaE9lU21jc3FhUkF0bStsdUhLZzBqTjVOekxUSjhJ?=
 =?utf-8?B?aVhMS2VtWmNUTkZmcXJjV0F3UXgxbnh4MGdlVFc2dE1Fekh1eTk0YXBBQ2dY?=
 =?utf-8?B?a21ITGlsLzN3Y256MEVoYU90QnhVWDlSMGNFc3FNTTg2eHRzUlR4cVlmUFpi?=
 =?utf-8?B?V0lLWUpFU0NNSDMvQ0dlM3FCYldiWUl4ZURnWkhBb3ozWjk1V1QxaGZyWkJU?=
 =?utf-8?B?cVZNMkwvaDRvUmF4NG9XQVI4SFZNY0FFR3pwQlk2bmFFMWR4dVJuRFFISGpS?=
 =?utf-8?B?Wnkyb3RiVEFYOXZoLzVJUXpRaFo3MSs4QUtYZHF4SlBFTXJFUGd1U3lJOXZ4?=
 =?utf-8?B?WnBsZXhtOE90aCtVMTJKeFlINmxWTjhJSlR4MHJnU251Uk01S1d4Q0pnQXo0?=
 =?utf-8?B?b25Cd1FqMVlwTlM3SHFaN1AvdkdqTUUwRXNGTGxhOFEyR1ZyeDV2Q2dLQlV1?=
 =?utf-8?B?dUtkQUdNTmRacTFxcG81dXowckRWTkdBRXphN0ZvZmd1S3JRUVgwWkNJMTZn?=
 =?utf-8?B?aGZGUGZTa3FGdk5EbE5mSXFQK1BaU2wrVE11bEoxendXK0EvUTJBbFpwbzFZ?=
 =?utf-8?B?VU14QlZaMlFuMFV1VGplZXYzOE85d0IveERXbzRNejhMSEF1REU1Wmd0YXZV?=
 =?utf-8?B?OGJnZFJHZEMwemR6MXdiY2Nyc2daZC9EZVJQa3pSb2hwNE5xMS94R2pjZXBH?=
 =?utf-8?B?b0psNitudXZhaGNhdTg2NHRYQjZ5SXJwQVo1UGVQMzJ1MCsvMFkvQlBYampz?=
 =?utf-8?B?L2hvU28rMDB0QjZSWjN6YkZEZXhpZEhmcmJmeFhVWi96MFZyOW82eDUxZHZk?=
 =?utf-8?B?MjhOejZRUHU4S2E2aXRiakpRMDlEd3NOSm1UMzhUdWJQYlA0MFJ3QTR0M3Nn?=
 =?utf-8?B?Tmd2UTF5Z0tURi80QTVKWjNJV21RZy9EQnRxY1o0VHN0VkgzRVFCTThXTWJ5?=
 =?utf-8?B?Y1R1MnBCVTRzcVFmdnlpMFpoUStCWjY1clJhL0ZrazNTSzZCZmpnQWdGMkpj?=
 =?utf-8?B?Q05BWFRxMXVoTEs4cGFFSXhqVlllYTJlNGxHOEtTK3phd3R1MGhjaExtOU9N?=
 =?utf-8?B?NFFsRThQd3BNSzRVR1Y2MlJrOEE4cHArU1dVT21MbmZiSW5JYithUXV5Mm9W?=
 =?utf-8?B?RDNpaGh0R0MveDFIQVRQR0xORGt3L1NTc3l2UFNNZjZYclh5Z0JTNmY4QmRu?=
 =?utf-8?B?dG05Q2UzOXd4WTM0L3JVZ2o4L3pSMElMZ2czdnE0azREbVhKRlRjZGdIOXRY?=
 =?utf-8?B?Vy9xTis4eUROQUdWS0lFR0liakxsOWhjYVZXUzI3Z01DdWxES2UraXp0RUJy?=
 =?utf-8?B?Zit5SVV4cnZCVDhsSkxqNG9Kb1dVM2lDa0NCWTgweU1wcWJyd3FMRkRUTG83?=
 =?utf-8?B?bXJuT2tsZDdHTnBWVUFFaE1tcW1Idi9WRE43enNsSGpUS3NWc1U5UTdrNUEx?=
 =?utf-8?Q?wVmRPAT4BVmPZ/qLVRQJFggztqS6uRVmVahADTpaHyLr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6nhXRid9w07t3WrL11RiG7dVp3KrnZZVOoyGTh+/P+ep0IEazwj/DcCAUUd0KgGAKKvzIb8DedcP9XJDI/i0BuxgF0d2YSs6HnhMkqm/8kmeoOIkUgg9qBU+9QfcVGc4uqlN1ZKbgUdLIkoiw9k6jgG4I86558LD+6d648zvxlD+HuoNkKn+wrQBqAHEIajvWOSvOEnHuHQYWpzQU3MkDPHoHQwnCfmvDclMi7rw5Db0GsjK4VA7j0wm0aBC3bn4H46xXIe5e33iFeU3EKYRvvV5m1kCr4kLG8tUllAioAoQJ28EQYpGwcSX65dUKro666ogeN3LkHaCzxsqrqEpZdUgDLSzefwkG8Me58BQDdY5sWGcQLEpCfVbyNioumhZxUqUFJHCpIQViVF4jf+NCsmRU+IWNbVfrXNXVGc2OV0zEeKT330k0pY2SSwfL2TW1Zpm+7c2Gvv1ml4cfSBVoIbPOvVFRhZg8hLpCW7cmxSsbZHPbVBjateE4zTdrGJI2eH/2mKfVfEYMuYcO47bvCOAkgxIVx1kypAO6df/ZP/melM/t065sD0pqp/1dofylVaxwSzEFirLCIdFbanp2uGrkdTr5klN3fXJZoGNZz5pqlwWgH0snqmfEfkkxWaT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276b2b53-7870-47ca-8a03-08dce3cab0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 16:44:46.7461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZZszFSQMf/JgZSa1OQAf9r0zBmT7uGj2POpjwwko45qhV6nli6ehpayWiuiCLTuK5LcqvO3hfH6shk8WdQtng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7875

PiBPbiBTdW4sIDggU2VwdCAyMDI0IGF0IDEyOjIyLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGb3Igb3Blbi1lbmRlZCByZWFkL3dyaXRlIC0ganVz
dCBzZW5kIENNRDIyIGJlZm9yZSBpc3N1aW5nIHRoZQ0KPiBjb21tYW5kLg0KPiA+DQo+ID4gUmV2
aWV3ZWQtYnk6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgfCA1ICsrKysrDQo+ID4gIGRyaXZlcnMvbW1j
L2NvcmUvY29yZS5jICB8IDMgKysrDQo+ID4gIGluY2x1ZGUvbGludXgvbW1jL2NvcmUuaCB8IDUg
KysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9i
bG9jay5jIGluZGV4DQo+ID4gMDVhNzc0NWMyYTY4Li5iYTJlZDQxM2JlNWMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jDQo+ID4gQEAgLTE3NTksNiArMTc1OSwxMSBAQCBzdGF0aWMgdm9pZCBtbWNfYmxr
X3J3X3JxX3ByZXAoc3RydWN0DQo+IG1tY19xdWV1ZV9yZXEgKm1xcnEsDQo+ID4gICAgICAgICAg
ICAgICAgIGJycS0+c2JjLmZsYWdzID0gTU1DX1JTUF9SMSB8IE1NQ19DTURfQUM7DQo+ID4gICAg
ICAgICAgICAgICAgIGJycS0+bXJxLnNiYyA9ICZicnEtPnNiYzsNCj4gPiAgICAgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgICBpZiAobW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQpKSB7DQo+ID4g
KyAgICAgICAgICAgICAgIGJycS0+Y21kLmV4dF9hZGRyID0gYmxrX3JxX3BvcyhyZXEpID4+IDMy
Ow0KPiA+ICsgICAgICAgICAgICAgICBicnEtPmNtZC5oYXNfZXh0X2FkZHIgPSB0cnVlOw0KPiA+
ICsgICAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiAgI2RlZmluZSBNTUNfTUFYX1JFVFJJRVMgICAg
ICAgICAgICAgICAgNQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYyBi
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jIGluZGV4DQo+ID4gZDZjODE5ZGQ2OGVkLi5hMGIyOTk5
Njg0YjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+IEBAIC0zMzYsNiArMzM2LDkgQEAgaW50IG1t
Y19zdGFydF9yZXF1ZXN0KHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCj4gPiBzdHJ1Y3QgbW1jX3Jl
cXVlc3QgKm1ycSkgIHsNCj4gPiAgICAgICAgIGludCBlcnI7DQo+ID4NCj4gPiArICAgICAgIGlm
IChtcnEtPmNtZCAmJiBtcnEtPmNtZC0+aGFzX2V4dF9hZGRyKQ0KPiA+ICsgICAgICAgICAgICAg
ICBtbWNfc2VuZF9leHRfYWRkcihob3N0LCBtcnEtPmNtZC0+ZXh0X2FkZHIpOw0KPiA+ICsNCj4g
PiAgICAgICAgIGluaXRfY29tcGxldGlvbigmbXJxLT5jbWRfY29tcGxldGlvbik7DQo+ID4NCj4g
PiAgICAgICAgIG1tY19yZXR1bmVfaG9sZChob3N0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9tbWMvY29yZS5oIGIvaW5jbHVkZS9saW51eC9tbWMvY29yZS5oIGluZGV4DQo+ID4g
ZjBhYzJlNDY5YjMyLi5jODZkZjg0NDNhODggMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC9tbWMvY29yZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbWMvY29yZS5oDQo+ID4gQEAg
LTk2LDYgKzk2LDExIEBAIHN0cnVjdCBtbWNfY29tbWFuZCB7DQo+ID4gICAgICAgICB1bnNpZ25l
ZCBpbnQgICAgICAgICAgICBidXN5X3RpbWVvdXQ7ICAgLyogYnVzeSBkZXRlY3QgdGltZW91dCBp
biBtcyAqLw0KPiA+ICAgICAgICAgc3RydWN0IG1tY19kYXRhICAgICAgICAgKmRhdGE7ICAgICAg
ICAgIC8qIGRhdGEgc2VnbWVudCBhc3NvY2lhdGVkIHdpdGgNCj4gY21kICovDQo+ID4gICAgICAg
ICBzdHJ1Y3QgbW1jX3JlcXVlc3QgICAgICAqbXJxOyAgICAgICAgICAgLyogYXNzb2NpYXRlZCBy
ZXF1ZXN0ICovDQo+ID4gKw0KPiA+ICsgICAgICAgLyogZm9yIFNEVUMgKi8NCj4gPiArICAgICAg
IGJvb2wgaGFzX2V4dF9hZGRyOw0KPiA+ICsgICAgICAgdTggZXh0X2FkZHI7DQo+ID4gKyAgICAg
ICB1MTYgcmVzZXJ2ZWQ7DQo+IA0KPiBJIGRvbid0IHNlZSB0aGlzIGJlaW5nIHVzZWQsIGF0IGxl
YXN0IGluIHRoaXMgcGF0Y2guIFBlcmhhcHMgbW92ZSBpdCB0byB0aGUgcGF0Y2gNCj4gdGhhdCBz
dGFydHMgdXNpbmcgaXQ/DQpJbiBtbWNfYmxrX3J3X3JxX3ByZXAoKS4NCg0KVGhhbmtzLA0KQXZy
aQ0KDQo+IA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBtbWNfZGF0YSB7DQo+ID4gLS0NCj4g
PiAyLjI1LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
