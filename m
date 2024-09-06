Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389B1494AC
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610265; cv=fail; b=YlwUQW8Jlp5RBZOBUAXt6q/anzNh2rN7FPzlZ56cfftLYwSI0U8qHAo84lWdzh8kb8G/B/EFuS+RNysfo+23WOVs0bLoLwF1sZRvckk2AXjDpUg08WWfjyTfN/hSkPEe2ym36pT3CJpwBmvOwaTSmDDvopKjp4A6SYDTlC3XlrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610265; c=relaxed/simple;
	bh=7cblejYQWpClR58EhkmoxUzTrko2eHhGb160CfBOwIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sR0FYsO/Wd0GU5xHKPX++KaRzI77o6dANoPfK50ZoG6LItuDUHGo5kH7wPgG7HTvlSLSDC54GtOXGJ6sIegYIEKQzx1TQ+g4ayDgbjX1xvk2aB0KFpWyDScdvbB1UmHA1XhAxFzWZtpw3E7E62tK+87X+a3SKZ2GuvtIaUp0UaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GZyKxUSa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=X94Bnd+N; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GZyKxUSa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X94Bnd+N"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725610263; x=1757146263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7cblejYQWpClR58EhkmoxUzTrko2eHhGb160CfBOwIc=;
  b=GZyKxUSaYMe3XZDcCbIMLqiNs9qQ9shpkMAM57meEtAlebvc4v2pkMLF
   61yQlzf/CsF15PGSzoj4s3y0dd5hU3OuXYciAuh1uyHQZhxa2Mcbm8N8i
   eFwcWQnfI5lRx32PN+cp3bswrxATgyFCCQTo6GyNnfEZIW9to8KCCgtWC
   mKvpnaoqw9/soaUtejba5Kc+oF3JkhvDtFLFNw71NzM+yrNs8mZ/mkkBw
   CGgLEDq2ARqKGEWlJXBiLsHKIWZLYVHmLKrgamXkoJRMG9CFwOJ2Z2YRs
   mhakJlSxnxrdwTCwiOEGHawOz1VQpD2nHYLEWyKqa3LNIuflcIVlVkuiN
   g==;
X-CSE-ConnectionGUID: b4dewXnFT7GErWM9mKSTqA==
X-CSE-MsgGUID: +vpCSMYbR9my3Ou5vbWXfg==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="27093206"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 16:11:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOYzEjOXC+YsoaNF79L0HPIoWw/XlleEwYbYh/LezqRGMrHqkxrmJ4yUT+0O2ArPaIsdWo1CyDKoVSL61R3HAaPwYqOmUWUmaROKEppEkkRbBPZo5Crac7d4YDCaK01wmcpNntReo+LD56/FBSLTiA18Bu1pAV9iCmipLWEDI0mliFMLfVbxJXq9dvVJI9sFsiIZL+DULMuDEsJP2hgpabi8tK8LS61WJoldU5OQZrUGwcSUD5Jf0zj+Y3TSCUJPYP0fT3RHyShH4Em1kRoziQJ25nzYpRJvkhJ1kakNxD2ZlT2JMD1jcmkiHwff+qQdAxRgJvmYpfqfQ526ijpilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cblejYQWpClR58EhkmoxUzTrko2eHhGb160CfBOwIc=;
 b=XnfigmPM5cO5dUF/2ee/akVS03nPxOMY9vqtlJJ4Zb2tktwlmN/zEhRS+zAW98YcEuNfR1zki6qze036ROrPPot50buEpAH1M3fv3YCAdYU9C716MaxTtoWwn7+plhD75JcIN0zUh/4ozWkJXnoGplCkzQjBy0SPf1rwk7EEP+55oQ/EGnANMDipNkQc4/P0xo7J3c6UFmWVe6xtZlMIkX02J4z3TM5DqW2Ji599hTX6MHWVJaFQm5NcoaV3TdbD8PFec6qfN+J5lFkXgSOMwfDoUiLRQXpwFb5J4UIXgkyYi9fn3jOv/xmkrnWvyQcGaoL40n7WBAIoG7TEhFnpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cblejYQWpClR58EhkmoxUzTrko2eHhGb160CfBOwIc=;
 b=X94Bnd+NDiYsKeRIHl+sPMvANh2Vs5XJDc2ybbHobRGghS4jLrjiEDdnKajvWufxzMe9a1rHffxq66cXlegYVQ58BWWY3SdXbDtxhb5i+IXZnzsf5WAcX3Vdh7MWWwFwC/Gk3kqG/alDIiF0oDiEvVJ5FSJ7jZPY8guFlSmc6tw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN6PR04MB9432.namprd04.prod.outlook.com (2603:10b6:208:500::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 08:10:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 08:10:58 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 1/9] mmc: sd: SDUC Support Recognition
Thread-Topic: [PATCH v6 1/9] mmc: sd: SDUC Support Recognition
Thread-Index: AQHa/tphKmd5E8enBkG3TO9aWg4bBbJKUWkAgAAXXkA=
Date: Fri, 6 Sep 2024 08:10:58 +0000
Message-ID:
 <DM6PR04MB65751D8939A43D458B97DE3CFC9E2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-2-avri.altman@wdc.com>
 <d43f5407-fb88-437b-9f43-661de0245363@intel.com>
In-Reply-To: <d43f5407-fb88-437b-9f43-661de0245363@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN6PR04MB9432:EE_
x-ms-office365-filtering-correlation-id: 9ca7dddb-23a1-4f65-6405-08dcce4b7069
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkQzcHZ0SGZ6RTlyQmJyWVRtY3pOK1grdTNweGFvZk0wVlI4eFYvZVhiREp3?=
 =?utf-8?B?dUwwZEVJMlkwRmpucXE3amRyWWdEMjhDVU1EYmVKWEd1VWFZMDlpYVNYY2xx?=
 =?utf-8?B?SkIwYjRvOUFLNnNiK1g0K3N0UVZVeklpTXJUTms4SlBRUzcwUlVQbkVrZStJ?=
 =?utf-8?B?ZitLc0lqUldRUlM5MEhMZEExdHBtY1JVWkRrdE1EcWl2blNpczRsRDNna1Q2?=
 =?utf-8?B?ZTdxcm13S3Q1ekRBc24xVWdXN3l2VWZUbk5QUlV1UW5jQkwvT2lKc0NRN3ZE?=
 =?utf-8?B?ZzRiSEs0NE5CMVBUcjdmSDR6YlZVVDBQMlhUU2NvOThQVlFiT1llUzBGV1F2?=
 =?utf-8?B?Z1JhNjlLbDFJSWF6TDIzb05JUzJTWnhvcEMxZ1lQMTUyWStlVG1XWXExR2NP?=
 =?utf-8?B?WVgzcElUT2hkNUxHTHErclkyK1FmRDRvdkNwaW9lcHNUVUE2ZUhIaVdrUDBa?=
 =?utf-8?B?KzM3b1M4SHRvNTJQQTFiWHE2eDJvWkN3dHNPcjVHRG83SEdZc1luVCtTYVV4?=
 =?utf-8?B?UEdHMWRxVW5zV1BCN3FndW1iNFpsY2FLU1FwZ2xPcDVucTh1L0FWSWlIaFpy?=
 =?utf-8?B?NElzd01PUWJ6L3Y0aFhROHdpakdydEUwRjMvTFZVUVNBTk5vOHVGQWlLRWps?=
 =?utf-8?B?ZGFoaHJKNmp2OXVGREw4eHJGdjZtb0RUMzl4d2ZnTzBPTmVwdTh6cE1GZkFz?=
 =?utf-8?B?d1lSaTBsN25aajhKZitYYTUzcUFIYVQ0VU9sT0xXZmpGZ2NLaTBaSk5Yb2hz?=
 =?utf-8?B?eXplTzl3NVVCMVR3bk1WWDF3VyttSk9kTWZmaHBRR1VRcEpFalBmYmZBOUp0?=
 =?utf-8?B?aXJYVVlLOGJodlpZdzJvaTFTNVFsaFFUVEZPWHY2SFhuTCtrejJBdEd2K2Rl?=
 =?utf-8?B?K3B5RWJmMlpKSExhL1JsOFRRSEhUTWc3d2c4RFVmb0gxd1JMZGkvSEttc3Vu?=
 =?utf-8?B?aWlydjBCSnRhZmMxaEVkME8zTEZpZ1ozY1VZQyswWjcyV25ReTNkS2ZETnd0?=
 =?utf-8?B?ZUZRNVNqQ1FRNysydkRqcU5rUzNGUGJZdndOYTBkUFJHQmFWQnl4d01Rdmpq?=
 =?utf-8?B?UUluTU12YWgzMENPdzNUYXRaT01jN0dqYW0vRXVDdnZWUTNxaGs4VFBZeHpC?=
 =?utf-8?B?ZjlObUdiK2kzaDFXM1NHb3ZJYXBJUTMwNFBHSjhkTEp3akJFUzRmeUwxNzVi?=
 =?utf-8?B?d28wOUQrMGM3WkpBVFRpSDZBdzVCb2JxZHAvZzRWbWRoS3ZMQzlMcGNPSTNM?=
 =?utf-8?B?M0hPRmRzNU1MdjQvYzY0aFdNdmMvR2lGYzRNcW1YSDBkS0tjekN4Z0tHUzRD?=
 =?utf-8?B?dWtVa0xETEY1WURMRW5ML2c3M1lWK0Z5WVVTa0JwNnkrSS9mc1AwQStTUEFM?=
 =?utf-8?B?VlZyd2JwcHQ5ejI0dDF2aWs4VUwzNU5NTzIrS0tJMjl4L08xRmpIMFZBUTF5?=
 =?utf-8?B?WWp3OXpRbkRYQnFMYzlQbHZKTUViTG1EUHM0N1NXL1Z5OU1oZk93SFFlSi9C?=
 =?utf-8?B?TkYvSlhCTmtMbmljVUVmNndxYmxHODZBSkhWWHJFWk8wTUtiekt5aUlabEVl?=
 =?utf-8?B?U3JzQkVmT2svWEVuZlh1dWk1NTJXWnVsdzlTRVdkYXJ0SEgrUVRwSkFHeHd2?=
 =?utf-8?B?Y0lJRktSalFiUjNNcDNyc1BUMEFmT1NMdDNwQ1dHY2ZOVjFKZ1J1bWxJWkd2?=
 =?utf-8?B?RzFUMUE3bjN6dHZHZVpWY3pQbituRythN3MvQWRaeGdKbGZ6Tk01VWt2VC9W?=
 =?utf-8?B?QnBuNzZNREZSY29tTGdPUUV2NVpsdTRzczhucFd5QlJTem1TMXAzSkVweE1p?=
 =?utf-8?B?ZkJDTEpCRTQ3Qjk1ekh5NFBVc0p3Q21nSVltNklnanIwWjZncmNGTXEzMTdt?=
 =?utf-8?B?N3JFRUoxbzc2WnJRVGszbklzVEF3L1VsSmhxZzdsTUNEcXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW1xUjRFcFk5anpwQjlvbFZaVU9LM0pBeStlNVRObWkzYW9tQzZhTWhjWG9C?=
 =?utf-8?B?d21JRWNXN25xQ2IzZWt3TSt4aTh0b3BTbWdXeDFHM3Bvd0gzL3daUmZIV21h?=
 =?utf-8?B?UVZqSEhkQk5CWUxJSWtuY3ovclRudFVkL052NEFraE5LRXFLMEpkMUorSmYz?=
 =?utf-8?B?R2ZETUNHUy9MUlBtZCt4WUkydnFaRXpLTDQ4UlhncngxRmhXN0pRR3EweFd6?=
 =?utf-8?B?NnZyc3krMDFaUVdZUG5FOW53YkdlQ1AxUERjSzNCUHNmZmtqaVFyc2dsaFB3?=
 =?utf-8?B?ckJMeTBkc0dzRFZVbjdHNWg4Y2UxbTdzZmtFTEdtekxQOE5ySExsdDcxejUx?=
 =?utf-8?B?dDMzOWE4RDVVR00vVmt4QXMzUUs0R0RPdFlla2VocDVaVEx1dGJwL2FnTFFI?=
 =?utf-8?B?Z0RHYUoyWEtHMTFwdktKdmZoQkUxYU9UL1lra3VIVUpuOVFYMEZ0WVNlZ2Za?=
 =?utf-8?B?ajV1MUlSSlV3ZnZTb0xtS1ZET280MlFqeGNOUTNxdEZIeTY4Qkw2UWNYYzlx?=
 =?utf-8?B?QXZXb3RSWjNQTkRkMkNzMUlWOWoyQnF5OE53M2VDclQ3eStETkFSTE1hMStj?=
 =?utf-8?B?eGFaTFFHWVFoYlRXRUFJdmdnWXIwc1drRHVkQzIzaG5sOG5mU1VGajEra294?=
 =?utf-8?B?ZHgwZnhtRDAxbU9uakhNQ2ZrRCtZdlZ0bHZHQjhrTUsyT1BjWmtGYXlGSlBN?=
 =?utf-8?B?ZkF0UEhON1BvU1F5dUR0K2ZrRENJVHlzY3pzSWliWHgzaTZndUxvQkx4eFRt?=
 =?utf-8?B?RmlpRlFaM1kxall4V0JpSFo1dDhmeWpxb0p5RUxiY1dDSUxOb0hoMStVZHo5?=
 =?utf-8?B?dXcrM01hVTRlRTU4cUUvQ09jcE5qVDNtSmkwUW03UkM3WnpXKzdjM1FNNHV4?=
 =?utf-8?B?R3BqYk95UGhFYVBzemhYUFlScDVtaGxDUVZwLzBPREVRSG5kOUhIUEtmTWRo?=
 =?utf-8?B?M0FPV1JFWjAzaTZRVTd5RkZaVGVZbUhnWTB4WEZtTW94bVFrVi9ONFhJa2FS?=
 =?utf-8?B?UEJSN2ptMGlaRmJ4VFBVOTZIb2RlU3hnaGV5NHJNd2ZjeFJ4NGtqUDZHb2V1?=
 =?utf-8?B?cmdZV3lxcEgrZmJCQkFYbGpTUXZ1c0xOM0MxK0RHaFhyLzhJcW5PdTdLRytO?=
 =?utf-8?B?QW9qcVo3STJwTnFaSFlvWFRtRkJ5WHZWUzYxbzJoL2YxWFY3SjAyNFpSVHBH?=
 =?utf-8?B?WkRJaFZmSmVRZnJBYVBTNDQ3NzFid1NBak9POEF3RUV2b010dlc2TGZvTHJn?=
 =?utf-8?B?ekFZRS9xRmM5L3kzSGF6WmVwUGpJRjZPek9GNEdZVlcyemcrMXZiNU9iblA5?=
 =?utf-8?B?RmNLWUYyVEgzekllbXE3My9sNERnMktieFJtQktCb0lsd1Jld291WTRZb00r?=
 =?utf-8?B?bU5UVlh2eTAvMHhRR2Y2RitxRThiS0dzamVxUU5RNnAvd0xCK1FYUzFpS284?=
 =?utf-8?B?MGZqa1BrNG5wajlOcjBjeDVMYlQwYXVtVllmeHVpSE5icmY3Syt0UzRNRzlY?=
 =?utf-8?B?SFJ4SUJRTHEva21sRXNMd3ZMMHZCekpEdlRESkZQK0JuQmZIMUxRaDUwUXdp?=
 =?utf-8?B?NTk4d0VLdmJINmNXaC9peEs1bTk1aU5JdG9ZTTlPUXJPWG9ud2xacEV4UFRz?=
 =?utf-8?B?MVJXaDVxRWtGaW5MbDlwdXJYL0pSMUJpeEhHZW1xYUtHTGNVR3FGMEo0ZVpJ?=
 =?utf-8?B?VnR0RnJOYVV0Wm50NGdreFFGUlBTSVJ6K3pMZlpRMEd4OGk4bHQzS0srSzFi?=
 =?utf-8?B?U1VEN1BLTTB2QTl1eVhadWhPcm0zeUxJaUFkTXNQODhjL0xNNWRnTTJRdXhB?=
 =?utf-8?B?UHRMQ1VUS3RJTE5IYTRRVE5ZSGYwY3VFME1jTEs3cFUwRFpwZUxDcXdXK1F3?=
 =?utf-8?B?QmhjWGVWT3FWbXlFRzg5VHI2dXoxRzY4Mk1xaW1mbW5TYWVrMFNoV1c2NU51?=
 =?utf-8?B?eTR3WWZJMENQWGkxZS9ZU3JhUS9XZ1dheDNHOXFYWWlOTll0TzhyWThtVWNk?=
 =?utf-8?B?OGJMaDczOXNuaFNoNU9uVW1QSUs2bUpEbk1haXNpZlhlMzFMcW9idUJYQnJz?=
 =?utf-8?B?STdyblVaTmlreDh3V0paa3RVS01FakRpUWNiTG1PZUJ3aEVmUWJ2N3hMZy92?=
 =?utf-8?B?dmpRUHlUY1ZpaVJqTTRyYzlmTDVWZDhoTlY4UFQ0em1lc2xWQ3B4N08rK0Fa?=
 =?utf-8?Q?SSY8K08nWgSJgT8D6kG9dQroW952yTwS9Lko6Ndx+bfk?=
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
	CKrfV32/G2KgqshnHF0q5/tCDDiemZEiJxed7X18GWFlIAfViYPkzS2NWTRw2oJDnEBFc0BRJOeCvrKRBEyCoacfYGcX0XHLp+UELW6HwW0oBhjtzsSIlG0KZcjISEYY6BQH08ky7x43FKW+mTD7DZ/AT+WI/IYzvNSXvkRRs2JGt2ju03BaKu7H/1NrbLgRCEKhIELoHgXQsGX9P1P2o4RKkfjXhF2BDe3+l8ain8bK30eHm+TeNiJbsAdjC3W46tOThpr2wt8dZrahFmAoOnDRM+RhxSgNenG0M8Ezb2k0FXnv+k6U7nCAyEhER1vfmrW4zWZWiOA9H5PLYj6BcVvvTFJ/+HI2F9VvPxD/s6AaRegQLKRiWpXgeewfngBEEy0HemkyKmNCwFfCTJvhgng0TY0hOwRbkfBicRCVOEufuiXe8tg7Ldu/Ove6PEr/eABTBTlZn79mfRyzrITJOUv79VhBrMUhyPkH9QEp37e0pXzRFUOTTCEu7dKLDEfCtdGuXdcJvxLuGntOZhS6VpDDap/2budzwfkbR83HAxx9oyf5218Wu97px+hTpg+8k+VPA5WdeaLwg9XQPq4/HngVO/VTFnMA4DByvXi+3ZHcoc61tVazuljOunzy20Xy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7dddb-23a1-4f65-6405-08dcce4b7069
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:10:58.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Mykozjcine6WI9JAiAvLwNGPw6AUvHf1/wCe9T0YYGYHJZpQZhuszUqw8F9mhr7+AlHURT9fusjoaFdu6l+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9432

PiA+IEBAIC04NDEsOCArODQ3LDExIEBAIGludCBtbWNfc2RfZ2V0X2NpZChzdHJ1Y3QgbW1jX2hv
c3QgKmhvc3QsIHUzMiBvY3IsDQo+IHUzMiAqY2lkLCB1MzIgKnJvY3IpDQo+ID4gICAgICAgICog
YmxvY2stYWRkcmVzc2VkIFNESEMgY2FyZHMuDQo+ID4gICAgICAgICovDQo+ID4gICAgICAgZXJy
ID0gbW1jX3NlbmRfaWZfY29uZChob3N0LCBvY3IpOw0KPiA+IC0gICAgIGlmICghZXJyKQ0KPiA+
ICsgICAgIGlmICghZXJyKSB7DQo+ID4gICAgICAgICAgICAgICBvY3IgfD0gU0RfT0NSX0NDUzsN
Cj4gPiArICAgICAgICAgICAgIC8qIFNldCBITzJUIGFzIHdlbGwgLSBTRFVDIGNhcmQgd29uJ3Qg
cmVzcG9uZCBvdGhlcndpc2UgKi8NCj4gPiArICAgICAgICAgICAgIG9jciB8PSBTRF9PQ1JfMlQ7
DQo+IA0KPiBXb3VsZG4ndCB0aGF0IGJlIGJldHRlciB0byBsZWF2ZSBmb3IgdGhlIGxhc3QgcGF0
Y2guDQpEb25lLg0KDQo+IA0KPiA+ICsgICAgIH0NCj4gPg0KPiA+ICAgICAgIC8qDQo+ID4gICAg
ICAgICogSWYgdGhlIGhvc3Qgc3VwcG9ydHMgb25lIG9mIFVIUy1JIG1vZGVzLCByZXF1ZXN0IHRo
ZSBjYXJkIEBADQo+ID4gLTg4Nyw3ICs4OTYsNyBAQCBpbnQgbW1jX3NkX2dldF9jaWQoc3RydWN0
IG1tY19ob3N0ICpob3N0LCB1MzIgb2NyLCB1MzINCj4gKmNpZCwgdTMyICpyb2NyKQ0KPiA+ICAg
ICAgIHJldHVybiBlcnI7DQo+ID4gIH0NCj4gPg0KPiA+IC1pbnQgbW1jX3NkX2dldF9jc2Qoc3Ry
dWN0IG1tY19jYXJkICpjYXJkKQ0KPiA+ICtpbnQgbW1jX3NkX2dldF9jc2Qoc3RydWN0IG1tY19j
YXJkICpjYXJkLCBib29sIGlzX3NkdWMpDQo+ID4gIHsNCj4gPiAgICAgICBpbnQgZXJyOw0KPiA+
DQo+ID4gQEAgLTg5OCw3ICs5MDcsNyBAQCBpbnQgbW1jX3NkX2dldF9jc2Qoc3RydWN0IG1tY19j
YXJkICpjYXJkKQ0KPiA+ICAgICAgIGlmIChlcnIpDQo+ID4gICAgICAgICAgICAgICByZXR1cm4g
ZXJyOw0KPiA+DQo+ID4gLSAgICAgZXJyID0gbW1jX2RlY29kZV9jc2QoY2FyZCk7DQo+ID4gKyAg
ICAgZXJyID0gbW1jX2RlY29kZV9jc2QoY2FyZCwgaXNfc2R1Yyk7DQo+ID4gICAgICAgaWYgKGVy
cikNCj4gPiAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4NCj4gPiBAQCAtMTQ1Myw3ICsx
NDYyLDcgQEAgc3RhdGljIGludCBtbWNfc2RfaW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9z
dCwNCj4gdTMyIG9jciwNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICBpZiAoIW9sZGNhcmQp
IHsNCj4gPiAtICAgICAgICAgICAgIGVyciA9IG1tY19zZF9nZXRfY3NkKGNhcmQpOw0KPiA+ICsg
ICAgICAgICAgICAgZXJyID0gbW1jX3NkX2dldF9jc2QoY2FyZCwgZmFsc2UpOw0KPiA+ICAgICAg
ICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX2Nh
cmQ7DQo+ID4NCj4gDQo+IEFsc28gbmVlZCB0byBwcmV2ZW50IEhvc3QgU29mdHdhcmUgUXVldWUg
ZnJvbSBlbmFibGluZyBmb3IgU0RVQy4gIFNvbWV0aGluZw0KPiBsaWtlOg0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2QuYyBiL2RyaXZlcnMvbW1jL2NvcmUvc2QuYyBpbmRl
eA0KPiA4ZDc3YTQ5MzU3YWEuLjc2OWNkOGI5ZjQ5YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
bWMvY29yZS9zZC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2QuYw0KPiBAQCAtMTU3OCw3
ICsxNTc4LDcgQEAgc3RhdGljIGludCBtbWNfc2RfaW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdCAq
aG9zdCwNCj4gdTMyIG9jciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX2Nh
cmQ7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAgICAgICBpZiAoaG9zdC0+Y3FlX29wcyAmJiAhaG9z
dC0+Y3FlX2VuYWJsZWQpIHsNCj4gKyAgICAgICBpZiAoIW1tY19jYXJkX3VsdF9jYXBhY2l0eShj
YXJkKSAmJiBob3N0LT5jcWVfb3BzICYmDQo+ICsgIWhvc3QtPmNxZV9lbmFibGVkKSB7DQo+ICAg
ICAgICAgICAgICAgICBlcnIgPSBob3N0LT5jcWVfb3BzLT5jcWVfZW5hYmxlKGhvc3QsIGNhcmQp
Ow0KPiAgICAgICAgICAgICAgICAgaWYgKCFlcnIpIHsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgaG9zdC0+Y3FlX2VuYWJsZWQgPSB0cnVlOw0KWWVhaC4gSSB3YXMganVzdCB0aGlua2luZyBh
Ym91dCBpdCB0aGUgb3RoZXIgZGF5LA0KQW5kIHdvdWxkbid0IGJlIGFibGUgdG8gZmluZCB3aGVy
ZSB3ZSByZWFkIHRoZSBQRVJGT1JNQU5DRV9FTkhBTkNFIFNEX1NUQVRVUyBiWzMzNTozMzFdLg0K
V2lsbCBhZGQgaXQuICBUaGFua3MuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gSWRlYWxseSB0
cnkgdG8gZ2V0IHRlc3RpbmcgLyBmZWVkYmFjayBmcm9tIEhTUSB1c2VycyB0aG91Z2guDQo+IA0K
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZC5oIGIvZHJpdmVycy9tbWMv
Y29yZS9zZC5oIGluZGV4DQo+ID4gZmU2ZGQ0NjkyN2E0Li43ZThiZWZhY2UyY2EgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9zZC5oDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9zZC5oDQo+ID4gQEAgLTEwLDcgKzEwLDcgQEAgc3RydWN0IG1tY19ob3N0Ow0KPiA+ICBzdHJ1
Y3QgbW1jX2NhcmQ7DQo+ID4NCj4gPiAgaW50IG1tY19zZF9nZXRfY2lkKHN0cnVjdCBtbWNfaG9z
dCAqaG9zdCwgdTMyIG9jciwgdTMyICpjaWQsIHUzMg0KPiA+ICpyb2NyKTsgLWludCBtbWNfc2Rf
Z2V0X2NzZChzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpOw0KPiA+ICtpbnQgbW1jX3NkX2dldF9jc2Qo
c3RydWN0IG1tY19jYXJkICpjYXJkLCBib29sIGlzX3NkdWMpOw0KPiA+ICB2b2lkIG1tY19kZWNv
ZGVfY2lkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCk7ICBpbnQNCj4gPiBtbWNfc2Rfc2V0dXBfY2Fy
ZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwNCj4gPiAgICAg
ICBib29sIHJlaW5pdCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5j
IGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgaW5kZXgNCj4gPiA0ZmIyNDdmZGU1YzAuLjk1NjY4
MzdjOTg0OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gQEAgLTc2OSw3ICs3NjksNyBAQCBzdGF0
aWMgaW50IG1tY19zZGlvX2luaXRfY2FyZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsDQo+IHUzMiBv
Y3IsDQo+ID4gICAgICAgICogUmVhZCBDU0QsIGJlZm9yZSBzZWxlY3RpbmcgdGhlIGNhcmQNCj4g
PiAgICAgICAgKi8NCj4gPiAgICAgICBpZiAoIW9sZGNhcmQgJiYgbW1jX2NhcmRfc2RfY29tYm8o
Y2FyZCkpIHsNCj4gPiAtICAgICAgICAgICAgIGVyciA9IG1tY19zZF9nZXRfY3NkKGNhcmQpOw0K
PiA+ICsgICAgICAgICAgICAgZXJyID0gbW1jX3NkX2dldF9jc2QoY2FyZCwgZmFsc2UpOw0KPiA+
ICAgICAgICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBy
ZW1vdmU7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGIv
aW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGluZGV4DQo+ID4gZjM0NDA3Y2MyNzg4Li5mMzliY2Uz
MjIzNjUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gKysr
IGIvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gQEAgLTM1LDcgKzM1LDcgQEAgc3RydWN0
IG1tY19jc2Qgew0KPiA+ICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIHdwX2dycF9zaXpl
Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIHJlYWRfYmxrYml0czsNCj4gPiAg
ICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICB3cml0ZV9ibGtiaXRzOw0KPiA+IC0gICAgIHVu
c2lnbmVkIGludCAgICAgICAgICAgIGNhcGFjaXR5Ow0KPiA+ICsgICAgIHNlY3Rvcl90ICAgICAg
ICAgICAgICAgIGNhcGFjaXR5Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIHJl
YWRfcGFydGlhbDoxLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbWlz
YWxpZ246MSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3cml0ZV9wYXJ0aWFs
OjEsIGRpZmYgLS1naXQNCj4gPiBhL2luY2x1ZGUvbGludXgvbW1jL3NkLmggYi9pbmNsdWRlL2xp
bnV4L21tYy9zZC5oIGluZGV4DQo+ID4gNjcyNzU3NmE4NzU1Li44NjVjYzBjYTg1NDMgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvc2QuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvbW1jL3NkLmgNCj4gPiBAQCAtMzYsNiArMzYsNyBAQA0KPiA+ICAvKiBPQ1IgYml0IGRlZmlu
aXRpb25zICovDQo+ID4gICNkZWZpbmUgU0RfT0NSX1MxOFIgICAgICAgICAgKDEgPDwgMjQpICAg
IC8qIDEuOFYgc3dpdGNoaW5nIHJlcXVlc3QgKi8NCj4gPiAgI2RlZmluZSBTRF9ST0NSX1MxOEEg
ICAgICAgICBTRF9PQ1JfUzE4UiAgLyogMS44ViBzd2l0Y2hpbmcgYWNjZXB0ZWQgYnkNCj4gY2Fy
ZCAqLw0KPiA+ICsjZGVmaW5lIFNEX09DUl8yVCAgICAgICAgICAgICgxIDw8IDI3KSAgICAvKiBI
TzJUL0NPMlQgLSBTRFVDIHN1cHBvcnQgKi8NCj4gPiAgI2RlZmluZSBTRF9PQ1JfWFBDICAgICAg
ICAgICAoMSA8PCAyOCkgICAgLyogU0RYQyBwb3dlciBjb250cm9sICovDQo+ID4gICNkZWZpbmUg
U0RfT0NSX0NDUyAgICAgICAgICAgKDEgPDwgMzApICAgIC8qIENhcmQgQ2FwYWNpdHkgU3RhdHVz
ICovDQo+ID4NCg0K
