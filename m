Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64C8472
	for <linux-mmc@vger.kernel.org>; Fri, 16 Aug 2024 05:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786144; cv=fail; b=RJEGZ92drIZ6GhhVCa2FFEgQz2cYROQbHXUPJ+onmhVaqdic8NZx8frYsSaZFGDTyhgIOrygj86cY1B24KM/qNEq3DSKLd2xqxw9ULDmAZ34An5wSvUImm6k0Q15BuWTPGkrhPmHraiY6i+Q1PxqiygV5Ez73+OfNfU2+SSyM+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786144; c=relaxed/simple;
	bh=bhEJXebmQWvwfWbXpCg/lXb09EbE4x0c01/x4TT3MFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euHDz9uopUCfM5d/iI7SKVhKw7BJHSfZO5qjgSGkLIoCD8w5Z/4BkAHO8kngf3ZuvjwFUvNxmF5MEuqXtO4UKJFyW9lDzyrjigsp+0tu1LxHTYVD1iBbff68NXW+kazMbHTgevJJBh/aRLovZgiUehr/e+Bvk2gBY6lQFAGUFSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pGhX7go0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a+6uNyiv; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pGhX7go0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a+6uNyiv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723786142; x=1755322142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bhEJXebmQWvwfWbXpCg/lXb09EbE4x0c01/x4TT3MFQ=;
  b=pGhX7go0zfu1PLi6CKmElQp2+wqLjldGjm44/HZ+Hy5T8QOX0p9/sMal
   R2G+AhLGFEC6HTH2Oe+Y9qLadBWyMy72wgpyVE4whp9KSLKIq0oPlYMna
   Wn6RdmIyKGjEf0lDp0LTJ+r7Ss2MIRYQkQtDcsFj2wckhNsvJbDqodrp+
   OwzTer1RZsmTOXKdm9dCvMh9VyYcdUzNWKmUR/uaWpVVDGHAxMwuG54oq
   SyxrMXoiooenBEXlLVmThnN73+HQaxSfIvpRxMmjCNZ0s0RwcpGRycvAe
   8drysSRyJCIJ5PZ1vhmqN0834Mp/V/CzYaBneBDRls64wxVFwkBTaxGQg
   A==;
X-CSE-ConnectionGUID: 9iASI36ZSPSQRP+WHSW/mA==
X-CSE-MsgGUID: 85EHOn7rSHWmvFWEvmuUww==
X-IronPort-AV: E=Sophos;i="6.10,150,1719849600"; 
   d="scan'208";a="25395939"
Received: from mail-northcentralusazlp17010007.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.7])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2024 13:28:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDIWu3TCNJpXThBOpqhgjtSSwAcuv18s3gDlrSqUTaLhsCmLL8IVPqSWy/NqcxASGDBU2GGHP0BSY7cmwBN/IMyMe8wBVwHNjTYz4S8RO8d0eapO7QZFozoHxlrTXUz4/Efj1oQL/rzokMlN7AtYVN9NerNNJyFLjOW7eujienFmLa9QxH+WEXuFUEH54HRToGYX4PCYdqi8i8kNV/l9HklDAqOZIidn7Ofrj3K9qKxQNSt0lgDW7RBnWJwp3k6/ZjtJ5OLreWhujtQel7dA+uCDDM0ReG+4KnugfWD5y+8No0NBETpu9qsUJlOepeidoFp4DXqTuSjqxJ6G7DwXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhEJXebmQWvwfWbXpCg/lXb09EbE4x0c01/x4TT3MFQ=;
 b=cpvcqwbbm+54w97wcwsWFHiEN9LyD288BbGPt39EaFDbXWbK+hzZ0jhbXnU2+nKHfGqcvqZksAgxJ3BfyxdZkNXp0OjDtH+l6HdgSSV/n7yNcHwt04z0ulkwOP5Wq8M9lD0Nl/nX9aCXwxWq7BgUE/uR5NKtWf20LzBTHoo1Psef3VljguZFr8dB1GniTJNDBqtGt4GY+TnQNcrBwFCt06OdaUuPyc2Wyy0u4h7ZuLhlGymwAlrZRnAwSQ0DQ80m7GWVNu+7s7aogpyGQhE20bbHwQdqq5cIJD+vCyfTXaMIprMgUpATx+uhsV3NsW8jPIDpKINR+bxgRSo/yb0uyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhEJXebmQWvwfWbXpCg/lXb09EbE4x0c01/x4TT3MFQ=;
 b=a+6uNyivMgn+ZSf8r6AAlherIApNvFpZFMvczXks7OiFf5S9xrw18/WSZqoZ0qP8IVtEe/Y4eghIhyU2tlzCgOG6EUjaEmKsh/27GXZAIOWLQb4b0UBC8VPME4pQXWSTyO5VDRUg44GigUYdNj3mCJEUGpoxwKILmmi/vzf5I7w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6352.namprd04.prod.outlook.com (2603:10b6:208:1ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 05:28:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 05:28:52 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>
Subject: RE: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
Thread-Topic: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
Thread-Index: AQHa7hwTtEBxsM8fmkqPrLsNwRFwJ7IoNLCAgAAR3nCAAMU1AIAAT5vg
Date: Fri, 16 Aug 2024 05:28:52 +0000
Message-ID:
 <DM6PR04MB657579B14A77CB1155CBF31BFC812@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-11-avri.altman@wdc.com>
 <aa4bd0dc-b349-4ef7-83a7-59af67d61cbf@rock-chips.com>
 <DM6PR04MB65751ADBBDD03386CCF2A7F3FC802@DM6PR04MB6575.namprd04.prod.outlook.com>
 <70a236d5-f58e-4b3e-a0a9-d02d6312811d@rock-chips.com>
In-Reply-To: <70a236d5-f58e-4b3e-a0a9-d02d6312811d@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6352:EE_
x-ms-office365-filtering-correlation-id: 02d7a1d2-d83a-423f-a12c-08dcbdb450aa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXF1RG1JZTdNVjREQndJMGRualBSUVhybFRJQ2ZjL3VNVnBwSHpTbDA0aFBN?=
 =?utf-8?B?Q281TFV6MnAySVIxUzJicWt3Sm8wZ3JOWitrL1hrRVhoOWxIQmRIYURYWTY5?=
 =?utf-8?B?QWxETlErY1BxakJVUHJBMFhYd0ZtdWh6dHlmNWdmaXBUY1orMjkvb0pxaEkv?=
 =?utf-8?B?Kzh4RTQ5VmFuUzhOU1V1SFlMQ1JjaG8vWVV4OWExanJseUpDTVdReVRkNjVn?=
 =?utf-8?B?SGxHckJzMmNsTkdIWmpQL2lkV1AxS1ZWMksrMncwek9JTFRBRE5SSlRaalNF?=
 =?utf-8?B?L1VlN01kRjN5a0hRcHJGNWNVcWpSSFJiMEhwSmdSa25OZ1VXVmlBZHZsT2Ry?=
 =?utf-8?B?VUpmd1VTTHZCa0h1UG9sN1R6WkMrb1lCSWJ6RjNQTDNYSFdZbWZsbFlrL2Rp?=
 =?utf-8?B?dWl1eGJndENDZVN4T3NwRy9rUTRKa1JMNlVoS25lSVZBY3BWVVpicmFqSXU0?=
 =?utf-8?B?R0ttR2FueEN1OVlOaVJHR1BBRHRXdzQ4djJPLzYvRk95a2M4bEttVmxCVkpt?=
 =?utf-8?B?UE05aGlwYldlNWl0Q1g4Z0VLT0swY0J6Q2d5Zmh5RHVLTDQwdkJHQXdBZzVB?=
 =?utf-8?B?Z0YySks2djJyaHl6YVlkcVc1dHdodnkyeDdqdDd6U3d0Q3lHLzJCK3ozUldz?=
 =?utf-8?B?cTIvd1lPNUVtYkxoTWR5N1drVXFndXZnalRvLzhQN3dyekxxc0I3VkZrOWNL?=
 =?utf-8?B?Q1BLNEN6MmE0SDF4bklNYXhmSExvdWV3VlV0UWNiY2tDOE1xYVFXZkNrczZj?=
 =?utf-8?B?NzdtRnUzRVNhenFZdTg5WjM5OWdMNkdmdHhlY3ErV3d1cm9tWnB3MkZXNTVU?=
 =?utf-8?B?R3BiTkpJZmtyYThiZ3hVZEk0WkFjOStRd2EyeWVEY2xtejJhbjVkbGdrdnhX?=
 =?utf-8?B?eXFRL3g1anZRYXhOcXk4SThCSFhtclcyVFQ1Ty82STMzZjhPcjMxUE9Yb2RW?=
 =?utf-8?B?emUwL05zMzRIcjRkckhheUJVWHY3NUpNcU50Uk1hWXRQbVBrbGZTRGg2ZDBp?=
 =?utf-8?B?MWdHRzNnSG5acUM4R1VqdVFOd1JXTEw2VkxLSFUrTHQvQlVSa1ZIWlBxTWZM?=
 =?utf-8?B?NldkcWdxSGF0c1I1VksrYXpwZGMyb256WHpPd1hrSmRKOXk5Mk5EUVc3OWdR?=
 =?utf-8?B?Y3lsdmNPZHk1SXdmdTFjM3Jua0tMQW00L2JuZEF3a1lmUE1scTNUekVlejVD?=
 =?utf-8?B?OFdLOHZLeHpkOHFtd1FLQy9IeWhxL29pSUloMERtaFpQeGhOdEQ4djFGRTVG?=
 =?utf-8?B?V1hyNlB3alJEZEVjMDdIb3FPQjZIZnpmMGN5bWY2SlVEeDBEOXV4cXU2eEtk?=
 =?utf-8?B?WVFJU01FKzVIYWRPRi9jM1k4YjdIbDJQbGcwazE5Ry9QLzdWeTd1YUZicmZr?=
 =?utf-8?B?QlFTUzdXaXdlWWtuVG1kN1BlUnBNYi80TEIrRklaU0w5YTBVRXlNVERNaWdL?=
 =?utf-8?B?UHhTUjhwNlIzRGdtRFRqNlhrbnJhbWZDUTJGUTNxS2ZEcGR4OVlVbk5RRlFz?=
 =?utf-8?B?M0lwaGFWR1lJSzMwUTF4cjNhb3lubVh3TkZQRmVENlRONWxodmVqRExBYm9t?=
 =?utf-8?B?a24yTjFJdTNTcnNyZ2Y2STlwNTBWcGI0ZlRsUmVnOWk0cXlVUGtuc09ObjlJ?=
 =?utf-8?B?ZVB5dGs0djJJcU1PV2kzaFZwK3oxbGtoVnFUWmFua0loZVRLSW1zanhxc056?=
 =?utf-8?B?OFp2Q2srWFI0cW1WQWNYT3JIek5DVGpZdVhGWmJLRElJa24zU0djdFEzQmt4?=
 =?utf-8?B?VDdMdmhUMWRDZG5jY2EvNitmUEpvTE1YZ0xpTDJPZ3VpaHZqMmRDYXI5UWM5?=
 =?utf-8?B?RkpGVkxvUm9tZFdlWllFZUZHY0UrZE5DSEpjUmtRbFZFZG5veWEwd2JsSTls?=
 =?utf-8?B?cmhIRlJKWVUyb1daTHljaVpueE9wcjFyNU9HaUxCL1JSMEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUt2UVNnRTFPN0E2b1NibDVNNFc5clNmOWVydklzVjF6ZHprcnRqK1dxNlZI?=
 =?utf-8?B?c0NQaXNrN0F0ZlkvOUhETHZmN3ViMno0dkFOMERicVhwMTRyZ0c4RTV0U2da?=
 =?utf-8?B?a3RoeERvcFYwWmdnb1YveWhCTXVrOXhaY2lsUXVoSUxtU0xaMzBRbmtuMzBy?=
 =?utf-8?B?MEhaSVJrT2FVeG5tNzE2amV6OG5LK2pucmFnZUNBWU9tQUkzSWVDQlF3SjBS?=
 =?utf-8?B?S1ZleFEwNEp4bnFyZUp1d0M0RzdnNS9nOW9pNjV6UTRyLzlFcDZpdGJGZjA2?=
 =?utf-8?B?MlIvUnFZcnVsMVg0MTVFaUJjdDg1ZWNERHA4LzJXM0FhV2owdTNqdE9zdUFl?=
 =?utf-8?B?ZCtFZTRKR0IxTzM0QzZjNHNSaUZvQzFCUWVHL1MxSW1NLzZWblNleGdjbERK?=
 =?utf-8?B?YXV2c0J2RWphT3VYbFZMT08zRWR5UnBXTnhXOUw2eXhMT0NLaDhTOGNjNWc3?=
 =?utf-8?B?OVQvQkJramQ5bUN2SVZhNDl5YURwWnF4N1ZpNEI2dUNjeXhTUklDRTVMblcx?=
 =?utf-8?B?aG1lL0lkNE8rQXFySzRiOUJ5akljQkNsZFhrR3ZwTHRLZ1k3QUU2WXoyS2x1?=
 =?utf-8?B?YjdoT2IvWkp1cVEyelczN3RwZDhKNFgweWNkKzY4Y2xHdUx5SnhsS0JhMXRT?=
 =?utf-8?B?Q0dYUktCZmFPWWVITGg2RjBWZWphNU9ENGlmaFJEL20wd1BVZUcrcE13ZlpK?=
 =?utf-8?B?L1RRcDlaQWhPMTlabHBYMzMwTjhIVE9aNFJQRTNneXJaM3dselQrU0E1Y3ov?=
 =?utf-8?B?Z0ZOQjM5Tm9BWEJ2ZmptbmtrV1RjdFovT2FHWDNMcjNQL1dGc1puZkZxblRU?=
 =?utf-8?B?SDZZclRpSnhaRklsV1h5MCs4QjRuR1pHUHB5RGZVV0szblVRMmdrWnNSWk9s?=
 =?utf-8?B?c0FnMEppRjFVODEwMjQ3bFVQRFNhaUMvSHoxSnp0UHNoVkpaREY2cjI3S0Ju?=
 =?utf-8?B?bTlhME9KSlBWSW1oL3VnZkVNdmFDVldqSms4aE5jNnVWbEhKdTgvbU9oSWox?=
 =?utf-8?B?V0dNc24rYnlYYmxveXo1RU84ekc2eExENnVlVzRZNWxNYlpaRFgrZmIwK0VX?=
 =?utf-8?B?ME9SWVpyOEhFSlB5eFRna2dDa3FmdjdlN09lSjE3cG1WRlBsRGVoSWZVaUNr?=
 =?utf-8?B?WFJLT1gwRGFLTkRjM0xvcU45YmxFVExDZ3ZET29TazdwVTFZVy9aUHlKWmp6?=
 =?utf-8?B?QWtaT1ZCdEFJa2wvUmQ1bDlUT1h5bGdja2hrZkI0Q3E3NFYwOHhZRGJxcm5t?=
 =?utf-8?B?c0t1SERaTEI1TEVLUElMUFZERzBEckVCS05jVzBOdSttZ3NTWWtCdDVzeGVn?=
 =?utf-8?B?MTAzRGhjaUU3aHVLOFU1SWtqVDlVcE9qYU0xcnJPVFJ3NUxXbFovSTJSL0RR?=
 =?utf-8?B?MVc1VlNrYmJPREJnMUxaekovR3BpZWk4dXAzWjB0dmhQV0t0aHhPVE02RURh?=
 =?utf-8?B?d0FqSm1XaXNMMjYyeE1hdCt6WHdxcVArTFd6QkwzdUNYT0dkaWhzRlhNRjVJ?=
 =?utf-8?B?NXU4Wm0xZDNLM2VydHRHSUlKVDVaZFdaQ2M4VVoyOHY5ZDNTMmc2QmpuNzdI?=
 =?utf-8?B?OEVwVzFQVzRvWmVrMlNhNFloeUthNlFOZUNQaUo1SExIQmFoalFPdXRrc2gx?=
 =?utf-8?B?d21pY3VTY0ZSZWhaRGlxOG5kZHk4OWFPcDdCSWRLZ3l5TW9zamp6bldrRFVF?=
 =?utf-8?B?ZDMxUWJVUW1MRGtKNmIyN05GNEF0SndZQlo0OUd3VjRmQ3ZOaW5mL3BCSGcv?=
 =?utf-8?B?aW1wUXIzdmM0SmpnajVDZ3VOVHNoZGRjbDcxT0cxN2NtZGJXejVGc25acm01?=
 =?utf-8?B?QmNFZ0J0dVF2ajdFb0JBV1I5eE11Vk1GTmh2cU00dzJraFZvam0rQ3RMc3R1?=
 =?utf-8?B?cnc3YTFJK2JUVVhjZU5rTFZwc2ZZRi9Sb3pJcnJzMTJZSEJKVmQxS1NqZ0NG?=
 =?utf-8?B?WERsSitkcVZNZW1rS3JaSStoQVp2dldmZnhXMzVhT0hvcW9LOThKREdoNmVX?=
 =?utf-8?B?RFhCSkxHcnBtRUJ4Um5JT3hHa0ZZa25iNHRUYlMwT3FEbTZYaklZRjB5T25V?=
 =?utf-8?B?OE5hWUZ1VWxGZGVaQWVYRmY3SHpONHBjMUV6bURscjNrYS9MRDN5dytETGZm?=
 =?utf-8?Q?PKSGjNAohiMciBk/OaU45ukxs?=
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
	/U8JXo8KBuWDLWmO5gT9oDQyArZ3tf22QDFESY/izFjG0k4PXOWaY7/lwAu1CSF30RrWnG/hD44/pdJMlF9hygGZV13hEKYeKUgMmrKZXHGq+QeH4Hzso3EsrESzqTO9lmHtbX3D4Go5BiTF+Q8ZZp7dz8AAzaUdLPG1fZ+cT1vl5ik4rk9fc9xf0fseI6BQvb1YCy+j4k4Ikx3oj2DwGlzA5ssaD4uXjwwdAyon6r72RdqVR4VvqJsnC9Lc4GeohX+SKHsIGQo7iL/1kfUWHMel257LII4aL0eMAL0i76T65dC+insgsNVTUJSQRxEb3qfOmR0vPLi3QyU/TfCL1b3ojG7Md9O2gxGr8b4w5crjHivtTA/vy+6u1nZs1yMIZBCx7iBnO7wQYOXriEs/W9EBmFp/ph8QY3Y72+BBuLAJpq0IGMSKKNWyhqtAHB+HJzgudjjUE0xmdKFSdoY0BuOJJ5sMY5IO/i7CTS/fjGEi6lgiracISQKJVOqlWibwJNG6dSt3ZD4eng+aqRROdsNhqtGttX44rh3qzz8DD4q58b9kBIFh2Cm4y4LSUprW1QOPII8PqUMIq9XWkP2hoJ6qP/Us+MqDj5bTBLwIHrQqh9rdOxoYFSqtg7HR3mbm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d7a1d2-d83a-423f-a12c-08dcbdb450aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 05:28:52.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2d3regjfrGATyUcdTo2Ow69kTHw4rAcL49aikC2U8qQe5BblI80mRl2O5nNQhAp2viudf3mY+yvxZWQ5Pt3LJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6352

PiBIaSBBdnJpLA0KPiANCj4g5ZyoIDIwMjQvOC8xNSAyMDo1NywgQXZyaSBBbHRtYW4g5YaZ6YGT
Og0KPiA+IEhpLA0KPiA+IFRoYW5rcyBmb3IgaGF2aW5nIGEgbG9vay4NCj4gPg0KPiA+PiBIaSBB
dnJpLA0KPiA+Pg0KPiA+PiDlnKggMjAyNC84LzE0IDE1OjI5LCBBdnJpIEFsdG1hbiDlhpnpgZM6
DQo+ID4+PiBAQCAtOTQ4LDEzICs5NDksMjAgQEAgIHN0YXRpYyBpbnQgbW1jX3NkX251bV93cl9i
bG9ja3Moc3RydWN0DQo+ID4+PiBtbWNfY2FyZA0KPiA+PiAqY2FyZCwgdTMyICp3cml0dGVuX2Js
b2NrcykNCj4gPj4+ICAgICAgICBpbnQgZXJyOw0KPiA+Pj4gICAgICAgIHUzMiByZXN1bHQ7DQo+
ID4+PiAgICAgICAgX19iZTMyICpibG9ja3M7DQo+ID4+PiAtDQo+ID4+PiArIHU4IHJlc3Bfc3o7
DQo+ID4+PiAgICAgICAgc3RydWN0IG1tY19yZXF1ZXN0IG1ycSA9IHt9Ow0KPiA+Pj4gICAgICAg
IHN0cnVjdCBtbWNfY29tbWFuZCBjbWQgPSB7fTsNCj4gPj4+ICAgICAgICBzdHJ1Y3QgbW1jX2Rh
dGEgZGF0YSA9IHt9Ow0KPiA+Pj4gLQ0KPiA+Pj4gICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBz
ZzsNCj4gPj4+DQo+ID4+PiArIC8qDQo+ID4+PiArICogU0QgY2FyZHMsIHNwZWNpZmljYWxseSBo
aWdoIHZvbHVtZSBjYXJkcywgZXhwZWN0IHRvIGJlIGFsbG93ZWQNCj4gPj4+ICsgd2l0aCB0aGUN
Cj4gPj4+ICsgKiBmdWxsIDUwMG1zZWMgYnVzeSBwZXJpb2QgcG9zdCB3cml0ZS4gT3RoZXJ3aXNl
LCB0aGV5IG1heSBub3QNCj4gPj4+ICsgaW5kaWNhdGUNCj4gPj4+ICsgKiBjb3JyZWN0bHkgdGhl
IG51bWJlciBvZiBieXRlcyB3cml0dGVuLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gKyBpZiAobW1jX2Nh
cmRfaXNfc2R1YyhjYXJkLT5ob3N0KSkNCj4gPj4+ICsgbW1jX2RlbGF5KDUwMCk7DQo+ID4+DQo+
ID4+IENvdWxkIHlvdSBraW5kbHkgcG9pbnQgbWUgdG8gdGhlIHJpZ2h0IHNlY3Rpb24gb2YgU0Qg
c3BlYyB3aGljaA0KPiA+PiBzdGF0ZXMgdGhpcyA1MDBtcyBiZWZvcmUgQUNNRDIyID8gSXMgaXQg
dGhlIHdyaXRlIGJ1c3kgdGltZT8NCj4gPiBZZXMuIEkgZW5jb3VudGVyZWQgaXQgd2hpbGUgdGVz
dGluZyBTRFVDOg0KPiA+IElmIHRoZXJlIGFyZSBzb21lIHBoeSBlcnJvcnMgKHByb2JhYmx5IGNh
dXNlZCBiZWNhdXNlIHRoZSBtaWNyby10by1TRA0KPiA+IGFkYXB0ZXIgSSB3YXMgdXNpbmcpLCBU
aGUgZmlyc3QgZ2V0LXN0YXR1cyByZXNwb25zZSBjb250YWlucyBhbiBlcnJvciBiaXQsIGFuZA0K
PiB0aGUgcmVjb3ZlcnkgZmxvdyBpcyBlbnRlcmVkIGltbWVkaWF0ZWx5Lg0KPiA+IFRodXMsIHZp
b2xhdGluZyB0aGUgbWluIDUwMG1zZWMgYWxsb3R0ZWQgdG8gdGhlIGNhcmQgd3JpdGUuDQo+IA0K
PiBJIHNlZS4NCj4gDQo+ID4NCj4gPj4NCj4gPj4gQW5kIGFzIHlvdSBtZW50aW9uZWQgaGlnaCB2
b2x1bWUgY2FyZHMsIEkgYW0gY3VyaW91cyBpZiAxVEIgc2FuZGlzaw0KPiA+PiBNaXJjb1NEWEMg
bmVlZCA1MDBtcyBkZWxheSBhcyB3ZWxsPw0KPiA+IFRoZW9yZXRpY2FsbHkgc2hvdWxkIGJlIGFw
cGxpZWQgdG8gYWxsIGNhcmRzLg0KPiA+IEJ1dCBzaW5jZSB0aGlzIGNvZGUgaXMgdGhlcmUgc2lu
Y2UgZm9yZXZlciwgYW5kIG5vIGlzc3VlIG9ic2VydmVkIHRodXMNCj4gPiBmYXIgLSBJIHByZWZl
cnJlZCBsaW1pdGluZyB0aGlzIHRvIHVsdHJhIGNhcGFjaXR5IGNhcmRzIG9ubHkuDQo+ID4NCj4g
DQo+IFNvIG15IGJpZ2dlc3QgZ3Vlc3MgaXMgdGhlIGNhcmRzIGlzc3VlIHRoZSBidXN5IGluZGlj
YXRpb24gYWZ0ZXIgdGhlIGZpcnN0IGVycm9yDQo+IGJsb2NrIGFuZCB0aGUgaG9zdCBkcml2ZXJz
IGltcGxlbWVudGVkIGVpdGhlciBTVyBvciBIVyB3YWl0IGJ1c3kNCj4gbWVjaGFuaXNtLCBtYXli
ZSBiZWZvcmUgQUNNRDIyIGlzIGlzc3VlZCwgc28gbm8gaXNzdWUgb2JzZXJ2ZWQ/DQpJIG9ubHkg
b2JzZXJ2ZWQgaXQgd2l0aCBTRFVDLCBhbmQgb24gYSBzZXR1cCB3aXRoIG1pY3JvLXRvLVNEIGFk
YXB0ZXIuDQpPbiBteSBvdGhlciBzZXR1cHMsIHRoZSByZWNvdmVyeSBmbG93IHdhc24ndCB0cmln
Z2VyZWQuDQpXaGF0IHdhcyBoYXBwZW5pbmcgaXM6DQptbWNfYmxrX21xX3JlcV9kb25lDQoJbW1j
X2Jsa19tcV9jb21wbGV0ZV9wcmV2X3JlcQ0KCQltbWNfYmxrX21xX3BvbGxfY29tcGxldGlvbg0K
CQkJQ01EMTM6IDA6IDAwMDgwOTAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwID0gUkVBRFlf
Rk9SX0RBVEEgKyBFUlJPUg0KCQkJbW1jX2Jsa19tcV9yd19yZWNvdmVyeQ0KCQkJCW1tY19zZF9u
dW1fd3JfYmxvY2tzIC0gYnl0ZXNfeGZlcmVkID0gMA0KDQpDb25zdWx0aW5nIHdpdGggb3VyIFNE
IHN5c3RlbSBndXlzLCB0aGUgNTAwbXNlYyBtdXN0LWhhdmUgd3JpdGUgdGltZW91dCBicm91Z2h0
IHVwLA0KQW5kIGZpeGVkIHRoYXQuDQpNYXkgSSBhc2sgd2hhdCBleGFjdGx5IHlvdXIgY29uY2Vy
bnMgYXJlPw0KDQoNClRoYW5rcywNCkF2cmkNCj4gDQo+ID4gVGhhbmtzLA0KPiA+IEF2cmkNCj4g
Pg0K
