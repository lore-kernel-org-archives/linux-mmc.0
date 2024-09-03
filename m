Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88271B12E9
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362299; cv=fail; b=kxh5RcZGXu+b+KqYuuIQ9pnFoDcyZoXhJ2J7i+0wMij/f/CO9NHWt2ZYYHEaKwxNpS3bWgKf1lOTo0lDf/+cFAW2CbN+km3hLGHF4dRzMuQ7qkBGrRTPjngEhlGZQUWXN0rYk9g7cGEF4ZNMSuSYPvx/XKAByutcUCKYImtXEtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362299; c=relaxed/simple;
	bh=xTYJVIGB2INxhoMImY6aFW46akzgW30y+MH8Y75mKl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KsLacFeci16AXcBb5QmhEDU4J9HuvUl5bsr2UIfSwIp5sKteeAUlByzOVndNuq3wQxJmO9Ba3RY7/ONCzy36PkGniJbBwCaosr+t6Dxa8bRgGSxZdM6P4FTyNp72rQ8YRKgpKZ4StrBjkVQ1RGfEQeLtDY+auRKYFkQiOXLQc3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AVlx6FFu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TQAsKMw0; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AVlx6FFu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TQAsKMw0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725362298; x=1756898298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xTYJVIGB2INxhoMImY6aFW46akzgW30y+MH8Y75mKl0=;
  b=AVlx6FFug/f3ewSMoWiM3lrV4Ov/Ndqx+UfXIB/4wuYWAqGiKUMuIlSP
   T3jQBx0LhUX5tq/PhKmGn9ayS604Fpo1cnodZyLGnVAVl+5GUpDznD51g
   5Xfj1QuwMSNjnM7U/ksfz6uuFYF+EMCWNnT8WdE0JzywVbGdrHdx229rA
   uzO9LC2gtMJwMWjaBG2+qs3UDp021GMxp7eghYNyIg5VyJMYr+JsmvcJJ
   Z5Bj9XAz8dQ9TPHFJrNGXa2lHaF3QwEUz2egxVrEOPrEocfarj0CJebXk
   gD0bB6lxXPW3dA8dZWb0bItRP3Jy3nfa6qV6hcMK/x6ttTzcvCXoXWSdq
   w==;
X-CSE-ConnectionGUID: lsVawOWRR/GTWmBfWdpE5w==
X-CSE-MsgGUID: SpPTFyF8Qh23/CPCFPvqmA==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="25183719"
Received: from mail-westusazlp17010005.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.5])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2024 19:18:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udkHQunBU/yk0GLwCahA+EE5Tf1IO1FzdcS/XEnoCCftX+rc6CqQZEs4y6m4zUWFgQeywCFuvfh2iIO1r5tbbJrES5Teq1KsYAnicx+cL3Ez5giHNw9Teubhz0+9CU1tmuDUHaqYZczXQu3nf6f51GoCpIf9Org5clujS892HVWBjPRswJTFS5VuRJKTOeYQ770bt7E9hzTz2v+afguA62FBuZv9gVEaTBTvckI86BjFhZ5Oa5LRrENfHUiIYxLGMrbVP+X+quwM+5Hqfur5hRNMZAEDZDldpLsamJx5QPQDE8qROjGnAEuzCBp2NOjhobnZPVNaHnP2OjNlAsP0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTYJVIGB2INxhoMImY6aFW46akzgW30y+MH8Y75mKl0=;
 b=u2l17PtgQXfOYd47jEOK4vJ82zIO/dN2pcaudxniGOx5/IQSZ97sJO8FDtCwmDanRMvMBiJBbUNIO7ZkZAiMsAmx+HLr0ijoAM3fgA5/nl94aSUweXqq2UfXhRoqIH9X3V7d1NAx+XBjU/3tmXOIyygcPWFITeTz1sDNQXy2JqYFkvPMONHSuHN9tWBuEQYwgsKU0vELOAGp/FHupQ5vA0bTMIi183JL2Yf0dCgvY5CRrs9aRENqfE2LldaJ/IimDzHjAAJn04sRllQdZfej6BFilFk4lWULbAQbLOMrpdsdRoAf1KBU5BK1fPDLbgzGrY87JbgV8f+9aFZs4PJ/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTYJVIGB2INxhoMImY6aFW46akzgW30y+MH8Y75mKl0=;
 b=TQAsKMw0IJnUkKw+KmviRigQwoFiUAh1r9dk5xiPMoRYi4WoLGbTglKPYeFZzKCcdjPp55yowgJEKvh2knGmbogXtvR3JOMLSK5MkJv2hhVZ5vnIyS4Yc2jipO9mew257Trvht5CYnsBIWDgmAqpKG1I1Xu+IRZ03rMgjYbO2As=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY1PR04MB8680.namprd04.prod.outlook.com (2603:10b6:a03:524::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 11:18:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 11:18:08 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCH] Documentation: mmc: Add mmc-test doc
Thread-Topic: [PATCH] Documentation: mmc: Add mmc-test doc
Thread-Index: AQHa/e+F1dYsooCLtUSpQrxlxSGAx7JF6SYAgAAAkXA=
Date: Tue, 3 Sep 2024 11:18:08 +0000
Message-ID:
 <DM6PR04MB65759FE25D621CCC17BA466BFC932@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240903105151.3581457-1-avri.altman@wdc.com>
 <19d4ce44-3550-49ef-8233-e7a01d0c6fd1@arm.com>
In-Reply-To: <19d4ce44-3550-49ef-8233-e7a01d0c6fd1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY1PR04MB8680:EE_
x-ms-office365-filtering-correlation-id: f0bcc2e9-212c-476f-65cd-08dccc0a16ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajNWQ2JpVjY0em9VMmE5em9sTTN5UTBjN3FZM29SVENaa2RvUENQcDlWcmZG?=
 =?utf-8?B?QjdLeTRnYmwyVnRWRTk4QVA2NW1ubmY5eWJzaFp1Y2tUSmVVZ1VnSmxSUU4x?=
 =?utf-8?B?bFN6c3hsWWh4NnNrdWVqNHV3bnNjSndtTmtqVHVZbjlCa1hydGtmTUlDNllV?=
 =?utf-8?B?SXZlb295azBabnlCU0FKUFNiOGdBSkdHNlpWSlRLK1JvQW9nbndPcWJWNU8w?=
 =?utf-8?B?R0F3WVpNd1FzMXIvRHhpbEFJOUpPTFVoR0lFN2xWR1NEdk8yc0xTMFY3cnhC?=
 =?utf-8?B?Lzc3SFBETVdyV0NVS2Q5eWdyVXZxY0pBYlprcTVnaVhaTW1NSy9BWFdpUnRl?=
 =?utf-8?B?OVFKVWV2VzFGcXZHQS9YVDhUOVRXUlZYVnkycExUUitXRlN6LzNDVHN0bkkr?=
 =?utf-8?B?ZkRrbFEyUzByZnhaTjFubVJ6ZG9GVWtLeXdUZWVrejV2S05MdFNaUmJaRDNq?=
 =?utf-8?B?eFdGMXdwb1RoL0tlMXR5STVpY2Erb2U2YXNtd1BNZ2dCY2dVZHZmSGhublJG?=
 =?utf-8?B?MnpUanFOSXdwUDJlKzBDb2t4T0gxSGd4NVdrZmdmREVPK0p5UWs3NmM0R0dj?=
 =?utf-8?B?dCszSHREeEY4ZHdlZ296c0l0WnNvN1lnYlJma3RBOVZCblh2ZGc2Zzl5M09r?=
 =?utf-8?B?TXZsY2dkMmJ1V0lBeUJFMWpMM2J2UWJxZEZVdHpnN0RlY1lJWGk0bUM3L3d6?=
 =?utf-8?B?RzN2aTRBZWcwak5LNFlkcm1TQVZFcU5ydXAxRytkWjZxVUllbmY1RzFPREVG?=
 =?utf-8?B?TnJuUHkzVmVBcTlNSDQ4V2FXYzFGOTdSaEZzOHVuSDlnaHJzOFIrdzhyd1B5?=
 =?utf-8?B?MzJLTnZMVjlTdFhIRTVDRmxURm5vTVBXYmNyaUVnWnpwQkhQejFiTXpWOGEr?=
 =?utf-8?B?Q2FqTUFOd3pJMjl4c0tMVDQvZENwZGN3NzdUbGRoL1pmdit0ZFQvY2RuRzhp?=
 =?utf-8?B?cERrd0UySmIzdTQ1cFN1a1RQZHRZeno0bE5kMGNNQzVZWDNIRGxEQXkrYTlD?=
 =?utf-8?B?RmxKZy9FbllNRmZla2VEdDFHU1pFUFM0MmhpSks2di8yRTdNbklwS1BYYmhW?=
 =?utf-8?B?b2p2dGNOMHpzTDYxbDByaU1mYlVsUDR5Wm0rSVhVcXJWbUdaVERIRGdRd09V?=
 =?utf-8?B?VTJIMk1EbkcxZTFEbVR3V0V5MFoxWTIvUFZTeUtxUklIdGhpK2NiMVphWmZz?=
 =?utf-8?B?eVBVaGs1bmlLV3l5amFZVHk5amp1TXhPZ0V4SSs1U284VjJFQ3lTT3RLbUlJ?=
 =?utf-8?B?dHpuSlNTMVBsbUQ5bnF3MHg0bUJhQ01id0ZLa3FjWU5uOHlzMGFYVHdYZ09s?=
 =?utf-8?B?cmdndEZuM21yTUtsT1ltQkRuVVBxU0ZoN1Y2OFpsc29nems5YVdtMWF6VUdL?=
 =?utf-8?B?amFhNGZJV2l5TmtiOFZCVEZra1ppSXo0Zm55cDlHWmJaOVkySTczbExhQzdU?=
 =?utf-8?B?eGQvbGtCSnhocTV2K2hLTm8wUjR6NTFYUFhBVFV0d0YxZVJwWHA1U1JFVit4?=
 =?utf-8?B?V2MvRGkwVENuSnptVG5SK28zOXBldzhzb3BhOEY2ZHJPd1JzcHNtalVkSGJP?=
 =?utf-8?B?VlBuR0RWcVpHOFlkRVZIdGRaMExTbDIvR2JXS3NLZWJxZGxSWnA5WkZEQ1dl?=
 =?utf-8?B?ZGdjYVNBRzZ0U0wxZWE5cVdoTFZtdVEwS0JtcDN4S0NZenNlSWRyRFpMQUhQ?=
 =?utf-8?B?RGZucXhEUFY0V3NYTis1eENYMzJZTmtGdWFaSTJnMWlkU0k5V0l0SzZiWWk3?=
 =?utf-8?B?ckV3RjJOTUZUTlBZcWFhcGRCaTZtdXVjNTJ5NjhiMldRbXVKRmxvZjZtNGFS?=
 =?utf-8?B?eitoTnFZQmNLZTUxM3pLaVgvanVReTVpbEtEaVRPckN4em1XL0doWU5EbVgv?=
 =?utf-8?B?MHZoSGxlQ1Nuemhxc2JDOVV6RjBaTC8yNTAzQmpibm43Snc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THMwQTZoUzF0cUx4OEdBRG5IOStsbzgxL011N08ra0Z6VkRDV215RTgrcmhj?=
 =?utf-8?B?S3p1NUNFMUw1dmdrWlN0VnZpYW5FSnNkRk1mbkRZeTlhQ2NVNkJadWNjUXhF?=
 =?utf-8?B?RlhJQnVjZENyeFhHbmdoblJtdzhlYlBOemRQSzMyQ3VhY2d2cDJRTDdiOERK?=
 =?utf-8?B?STNGb1AyQ2lZMHduWE1kSEIxQXFHanpUbG1FYVlwaUVJSFdKT1ZWSi90WXpO?=
 =?utf-8?B?MW5kamxkUisyNkpYMU5qQXNsYlpleVpIUUUxcm15bzZYWGFJU0ptRVB1SWI0?=
 =?utf-8?B?eHUwcHVtcTJVZUsrbFc5dkxWYjV2QlE2L1hqVFM4NVpSd1RMNUs5RGcyU2pU?=
 =?utf-8?B?MEozY2dRdVd2dDRzVEErajByMHNvZTEwZktuVGJha0hTSGN4S3BjNXRsbzZ4?=
 =?utf-8?B?NkwxMEh1U0liaTFDSzZOZkFudC84UC8ybTRYMEZzMGRvcUZoeVVERHlNK05w?=
 =?utf-8?B?TG1qUHdubzE3ZG9jcVM3bHdwdHdmSUJRZ29lNWo1S0JiTlFQSW9FNFBGSzV2?=
 =?utf-8?B?NXlGTFlHK051QTgrU0kwMnFTSTgyYWFJeVkyOFQ2ejlRMWtJNEExMklhZW9T?=
 =?utf-8?B?aWYwOXNIK21CRktObU51MndiSlp3MmF1THFvU2dFZEkrUERRcXdCQnNpdWdj?=
 =?utf-8?B?TDZHT3Y4VTFwOTBpTS84d05ackFFbkd5Z1NyWHptc2xvTnpxU3dwSmtOMk15?=
 =?utf-8?B?S2tidS8rUXZVd1djbkhHcnA5bzNJWGZjSHczSDhzSEFQQThoME91UkNQRXNj?=
 =?utf-8?B?Y0tDdVUrQThOcldzVjdFeVMrSVZzaWZLZWFyeURoK3JPTjBSY2JpQnIycDZh?=
 =?utf-8?B?YVREdlEwaE5LNUoxb3l6Zm5CYmUwYVFzbW5wUVFoWXFyUk93YzU5bjBweEQ0?=
 =?utf-8?B?QUF5V3lONFprQk95VnlVdlk5SDBkVHMvVHk5a0Yybm01U1pvRkZyeFh5LzBt?=
 =?utf-8?B?M2JsR2VCakpkQ3ZITDVTRjR5SEx0T3JrUHU1U09seWZDb1lhaW4xUTJPNnVB?=
 =?utf-8?B?Y0pUOUFSTnlWQ1pqbUJqWFFTTUttRmp5NDZJdzUwWG4rOWxmUVBKWkpaREEr?=
 =?utf-8?B?cHk5cVZnN1BZd29QWmRsVDVJa3VGQ2k0OUlJMXQvYzVDV3hob0k1R0JqSVVt?=
 =?utf-8?B?S1FFaVBpZWR4QkJ6S0s4enMwM1I5WFZ4R1EyNmpEdkhlSHlQeHU3NVRwMUQ1?=
 =?utf-8?B?N09KSVJlbEI3RWJSNVVwNzZla1gzODlZN0E4WmxaYTVKdlZEVjZqUkJNbTlL?=
 =?utf-8?B?R1dmRnpya2VBVWtDR2NHbHdNaWxIQnpyN3VRbXc2S3JsT2F6OTRBQjRTWXdo?=
 =?utf-8?B?cEF1VE42TmdlWGJ4UFpJZm9aWjhpL3N3STZ0N21pNkFrbWRjYzJLcXRLVEds?=
 =?utf-8?B?S1dYVWJOV3BDdHZGSWxjNGlaVW5QZS9CcHlBYmxnRzE3SzlHUzNIZDROeGdP?=
 =?utf-8?B?Y2lXZzdNZG5QOHlRdXZhRVdRd2RuK3B0NW1pS3hQRzdiZldvb3N0S0lkeHFL?=
 =?utf-8?B?SFBkeUFDcmlxNnh5MzY5SmE4a3cxQXBPZnhHUGZySkpQd1FEZXRxZ1g4amhu?=
 =?utf-8?B?ZXVIRmF1bStWUmRETFV6dW9XcG5TQ0lkd3JyZ2d6S0tVeFFFNVNneDR6eWFH?=
 =?utf-8?B?ZEw1TXBQNFM5MU1jYldzQnljUHNjSVhORWVrcmVXYXgzbjc2SkVqZDdGUlUw?=
 =?utf-8?B?SDk1K3k1R3VzNzdMNjFtZlFnRmM2NVB2TGpjblNIK0s5R0QwaHZTVnBrcjMr?=
 =?utf-8?B?MXhsUWdxSnhROU9rZmNvZzN0cW1lSnF2QncycStUR29HTVlFdmpFaCtpS0Z5?=
 =?utf-8?B?VHovWGhTdTlNbC9Vai9iZTF1S2dieExTS1Zvb2JJcVRwSUxXd0VVTStYVXNi?=
 =?utf-8?B?TDkxVmtYRzYyRXlVUUhUbkhKcXZQbmsrQ1pCdTh0M0RDeEE1aE9XbkloeVpR?=
 =?utf-8?B?Umh4S0gwTEtiWG42dlh2dWZjUERnbFlXWi9SK01YSVZHcWVMaXhnV1FuT1NV?=
 =?utf-8?B?cjAyMDluYTdRS2djUllDYjBsSjBGM1VhZHJWMUhTTTJWWGJkTzVRZTVPaHUy?=
 =?utf-8?B?R1kvR21LM1VoaUtFOVhWVEJvWGZHU3dMak1NVlN4N0lzUEFuanY0ZlV6Nnd3?=
 =?utf-8?Q?/L9yqqqdpbXld1Q27M7fKsJlf?=
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
	ODZTcJMXevAMFw6CdK7q3+Dhg1zFjIan3KYEU+yhw/cYckOYCt72J1hZDTjdWvCtRIyhT1jmdmHFLqtj7JVvYF7npbPcfZLrlej7XUExHuXXwnCBV+yGnLOERn1zjZDzlL/x7ezMoWXbL4B7wSQU4uokUniXmLN2FPELqQA2LgtHyTCCCLIS8Bb8jwYn0s+kdZUf9EvZ9pYY6R2pfEdoOhDHfHbx7pqV9FUyGUMJcAkO7xq1XbfGFIIMZBBU1owAryDX26RolVMUPst5qvL3dTPXr3tCgTu/XEPUzpTZSA/qORAr7O7ngoE4NmNgWd9s0KHMxbLMnYJ8sjYO4++gbnA1mOxEeZgSLzmCpMGQoX41s56Yer05X7UCQuFZNukUpwFXKI3NXxxj3V0JWiBy+x5NnPTljT9YcB0j/NHHBiVvx4FwXxCChvBDhAUGRzyn/YMUAk/uCwgkXRpDjPXAvLSn9EKqW/QiARIk/tIVTie+e6mUkx6xXhrq2P2oq4o+i+VOoTasI/3s3+v/xcHAltztTchMf9hqUV9/jeZVFvINRdQwZFiKNz3GAy8IZv+/6Hw8c8npVXUWPQugBK7hWr3NHxUw/y2DDZAOvrkwiaVbSV42FCo85xTlPfqR3wfA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bcc2e9-212c-476f-65cd-08dccc0a16ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 11:18:08.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmYmQ7D4zCnLqGdnY+fUsKGsxogxIdh/pIQhCYvbnURDHmena7qOm6ibaGlYlq7wTxe3AX/tVhAXYDT9SCVQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8680

PiANCj4gT24gOS8zLzI0IDExOjUxLCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBBZGQgbWlzc2lu
ZyBkb2N1bWVudGF0aW9uIGZvciBtbWMtdGVzdC4NCj4gDQo+IFNob3VsZCBiZSBtbWNfdGVzdCwg
cmlnaHQ/DQpEb25lLg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4g
PGF2cmkuYWx0bWFuQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZHJpdmVy
LWFwaS9tbWMvaW5kZXgucnN0ICAgIHwgICAxICsNCj4gPiAgRG9jdW1lbnRhdGlvbi9kcml2ZXIt
YXBpL21tYy9tbWMtdGVzdC5yc3QgfCAyODcNCj4gPiArKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjg4IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9tbWMvbW1jLXRlc3QucnN0DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL21tYy9pbmRleC5yc3QNCj4g
PiBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9tbWMvaW5kZXgucnN0DQo+ID4gaW5kZXggNzMz
OTczNmFjNzc0Li44MTg4ODYzZTU5NTkgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
cml2ZXItYXBpL21tYy9pbmRleC5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1h
cGkvbW1jL2luZGV4LnJzdA0KPiA+IEBAIC0xMCw0ICsxMCw1IEBAIE1NQy9TRC9TRElPIGNhcmQg
c3VwcG9ydA0KPiA+ICAgICBtbWMtZGV2LWF0dHJzDQo+ID4gICAgIG1tYy1kZXYtcGFydHMNCj4g
PiAgICAgbW1jLWFzeW5jLXJlcQ0KPiA+ICsgICBtbWMtdGVzdA0KPiA+ICAgICBtbWMtdG9vbHMN
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL21tYy9tbWMtdGVzdC5y
c3QNCj4gPiBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9tbWMvbW1jLXRlc3QucnN0DQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjkyNGY4N2FiY2I3
Nw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkv
bW1jL21tYy10ZXN0LnJzdA0KPiA+IEBAIC0wLDAgKzEsMjg3IEBADQo+ID4gKy4uIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKw0KPiA+ICs9PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiArTU1DIFRlc3QgRnJhbWV3b3JrDQo+ID4gKz09PT09PT09PT09PT09PT09PT09
PT09PQ0KPiA+ICsNCj4gPiArT3ZlcnZpZXcNCj4gPiArPT09PT09PT0NCj4gPiArDQo+ID4gK1Ro
ZSBNTUMgVGVzdCBGcmFtZXdvcmsgKGBtbWNfdGVzdGApIGlzIGRlc2lnbmVkIHRvIGZhY2lsaXRh
dGUgdGVzdGluZyBvZg0KPiBNTUMgKE11bHRpTWVkaWFDYXJkKSBkZXZpY2VzLiBJdCBwcm92aWRl
cyBhIHNldCBvZiB0ZXN0cyBhbmQgdXRpbGl0aWVzIHRvIHZlcmlmeQ0KPiB0aGUgZnVuY3Rpb25h
bGl0eSBhbmQgcGVyZm9ybWFuY2Ugb2YgTU1DIGRldmljZXMuDQo+ID4gKw0KPiANCj4gVGhlIGdv
YWwgb2YgbW1jX3Rlc3QgaXMgcHJvYmFibHkgbW9yZSB0byB0ZXN0IGhvc3QgY29udHJvbGxlciBk
cml2ZXJzIGFuZA0KPiBzaG91bGRuJ3QgYmUgbGltaXRlZCB0byBhY3R1YWwgTU1DIGRldmljZXMg
aXRzZWxmLCBidXQgcmF0aGVyIGFsbCBkZXZpY2VzIGhhbmRsZWQNCj4gYnkgdGhlIG1tYyBzdWJz
eXN0ZW0sIGF0IGxlYXN0IGZvciBTRCB0aGF0IGlzIGN1cnJlbnRseSB0cnVlIGZvciB0aGUgdGVz
dHMsIHRvby4NCj4gQXBhcnQgZnJvbSB0aGF0IGxvb2tzIGxpa2UgYSBnb29kIHN0YXJ0Lg0KVGhh
bmtzLiBXaWxsIGZpeC4NCg0KVGhhbmtzLA0KQXZyaQ0K
