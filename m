Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C3155CA5
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516737; cv=fail; b=lMp8X4cnaARb3sRcYu3K7P20lm/mH7zXHzpbgNpLoYWDX55PFGI9w7zQZKKRY9pIoBpLbPCuJ7QLPCaZ4d2NrrDU7wSkj/hjSq4ua6bKcZwDNx6c1zO7lWFEs/JOqEFXvaeroNPOou5i6k8woNJgAGEuS1JZV4NtIh2/95kffcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516737; c=relaxed/simple;
	bh=6XmIRepps9YIHCTutiEzBDFmXsPC9vtPhYbsl4ggKUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7R0KjyRNUlfHBnSS364VnfFbClHK6MZ2Pimg8xHnBfcGlFvUyubb+qjbrLF7yK54X125Zt+fGS2mKgPmq6CZ99trRB2WUMkfB7DB3MiTD5Un54ZJ+FeYpSKTg6BS138ZBXvaDxJzzNTFjMhgeNNVaDHVHh4ijcRgl3PVjVLrIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XgFGJiOC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S2gEVwX8; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XgFGJiOC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S2gEVwX8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725516735; x=1757052735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6XmIRepps9YIHCTutiEzBDFmXsPC9vtPhYbsl4ggKUg=;
  b=XgFGJiOCy7qcVilXQqsyK0fF0qrSnHU2NxUVqIoo/HGFXzySmyeN1Irx
   370hegmuYMedHwmR3+40yX6KroclxUED0qG/Ju5p/IwATVHrd0stgbBnw
   wruENfHyOEwz6ZEUKo6XrjC+c5HNpL0sbYKn+egXYSrOXM6bH7UI6NdQh
   DMNpSDclZwzWNbMFRVZmaXTW0YMpbfXWqXMndQWae37qXxdL2BAY9DTWo
   NFGf1oCcCbZDVy6MrnVCWxZL3hY4v4jGICU33zg5y7CwxptzTTjPbImpJ
   5trFwuXraSoaMHd5oE6Nsc+j7M2EhE+uc6/4ngiBWIh4+pXfWxlMLO6Fl
   Q==;
X-CSE-ConnectionGUID: YvSIY/kSTJKlrHko3H/IAw==
X-CSE-MsgGUID: OKk6/mF3Rae73/DA0WLupA==
X-IronPort-AV: E=Sophos;i="6.10,203,1719849600"; 
   d="scan'208";a="26000839"
Received: from mail-northcentralusazlp17010002.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.2])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2024 14:12:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGQ+kMOtYZxDWZA1IBXMYA4yF2SXAFolR8BRKy+moFx5K2XKzQsRfLDIA/cucCIEY3GSvErALaGnyTZJbqjQ/AopouRnXCop9IS6yAgyETWoD2L3ZRaZmQCIkYpt2UwnpJC6Fc32Q03oRJVW55+DUHqmKO296qfvnGVnjdjGLyQAqkHXo4hebmajuCH+B4fcFst1Lp6KjUNfQvac047XPWimtLaTb95/fLWWMCdwk1rP93v8i67Og0uNYVb7vtYMVRGs3PilJFQGQc0FTyUETzhZ6wjIXQjxkEYoyZaiJ7CmECWr19x2PmySvD8P4LlVYgHWKbU7/Ev3Y5WXdTWhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XmIRepps9YIHCTutiEzBDFmXsPC9vtPhYbsl4ggKUg=;
 b=evELMVl/vcNPYz0eZqeSYmPERE0cJCYlto+Wx8In8xdPY4sxejzPjyeRtKxttVGjuj4ZJDmN28LZEVl113E73RXRyIHcMDUqBeKYx+kKEU/myRhTc/WTJ9hvMUxUSL9zz23P4sr4mURrk6dhv7cSaPw1ocCrdK7g5hum8y0gcqtwW/co23SIhFO0nl9KH3J9s7LxjnIB6wsA00pl8sBQpi6u4ravrhbRAVu+jS9DJ1uLio6xjjmMd98/BXFTexAC+aKgeDsdBz+2RGkIYN+zp5tgiyQVsmmHUkPUeLpDbte/GwiOAIKNtbcNNxXrhwYaUOcH2keDwEhaJGn8cbmTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XmIRepps9YIHCTutiEzBDFmXsPC9vtPhYbsl4ggKUg=;
 b=S2gEVwX8rr4HpOwKkx5/qrh70lHY/nj434COr9+8+7mXzuhF3FH/w/z3ZgPQGbSuSeBrjUruubqg4pbVKMz1WZqjurJlB8/9ohAo3IgKqZQ14nC2K/hOWyNrLcpFctNeBE9pB6EK7gWYa0QxqYmZ9ct4LMZjDnwJfqnYzJ8k1IA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8995.namprd04.prod.outlook.com (2603:10b6:610:195::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 06:12:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:12:06 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Christian Loehle <christian.loehle@arm.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Topic: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
Thread-Index: AQHa/tpuqzDYrSc/4UWqwA3ouia0pLJIMa6AgACDBQA=
Date: Thu, 5 Sep 2024 06:12:06 +0000
Message-ID:
 <DM6PR04MB65750F714B37FC40466063C5FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <1cfe2dc9-5525-43df-9d79-98472df1d3d5@arm.com>
In-Reply-To: <1cfe2dc9-5525-43df-9d79-98472df1d3d5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8995:EE_
x-ms-office365-filtering-correlation-id: 30689ed9-e6b3-4e6f-61ec-08dccd71aad8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUNTcTRpdUloMXVzVmUrWklOVWdiUEVkMXV1b1JDWFhSRWlUMWMzaGNJTFBV?=
 =?utf-8?B?WjI5enB4VzVhNFJSV2ZHVWdmOWVGTVdtNHpsUnQrMmE0aFlsdnVKT3hvRnhO?=
 =?utf-8?B?K3NNRldiZkNXeVp6SFEwRlRuWmJ3bk1NZVY2WE1nWDU3TkdaeENyYnZ6djB6?=
 =?utf-8?B?K0t6N1M4NmY0c29uN1hSNGM1ZEk2MTRLYmljY2dJc1VRK3RoR1Q3enoybVdW?=
 =?utf-8?B?b2pvZUtHV050QzVHcmxkNCtkZVJwSjd4em41amExNnJYT2Z4RTNjR2daZytQ?=
 =?utf-8?B?Y1lPcHJFQjdyTHpveEgzT0JlSERlNXQvK1Fvbnd0bElJUUFJSmc0ZUhGeHNW?=
 =?utf-8?B?eFo2NlE5UlVIcHBKd3ZwekdGZEEwNER0SE4wcVM3eGdVeUpOZ2taam54a1Ax?=
 =?utf-8?B?dlBwRDRYWlNMQjRTTzdxdGVISWQweHZkT2RYWmFKbThvZFVhbHpJd0NrVDlN?=
 =?utf-8?B?QWdKNm9oUWp0cjZnQ2REd2hXM2xxQmNTQ0dEdyswdVRzM2Y1eVpGaTVGak5y?=
 =?utf-8?B?NTVsakREOTVtQkQ3NlFUd29YN3l2dGJHbzhKS1k1cEFzY1FhcXh0dnZ6T0sv?=
 =?utf-8?B?K2R3YzdsdWRHS0dQZXFJVGY3YXJmb29SOU9kSWwwSW9FdnhwSXExTjF5UE5X?=
 =?utf-8?B?Uy9VQmtMQUFOZVhoMG5LRGNJcW9neVZ1aW9hazB5SGphS3lCSU84TERicFVY?=
 =?utf-8?B?cTlldWR0RWkreDZqaS9UNVhkMmtsTU1SNUpmNXNsUnVRMGpYc1NoMW1Kdm9x?=
 =?utf-8?B?NWVxZnp6N1d2OSsySGZTbVQyWmUrTXYrZk5SelMrWXBFLzZJckU3TkM4Qzg3?=
 =?utf-8?B?WEI3MWM1RkNWbGE5U2NnRW5qclVkY0JYWW5SV2x2aGRrOEwxU25xU1Vha1kr?=
 =?utf-8?B?RDY1Q3ZLRkdsQldWamVRVFVReWJ4aDBWQzdBTlpxRnNVOVhtUE83WVc5M0Jp?=
 =?utf-8?B?QWJlQjBPNTg0RWw3SzdQV2NMY3ZLanNwZVRQZzgxbHJSVGJWL2lOanRmWDVi?=
 =?utf-8?B?ZVp3d25uSzE5cm5saXFNYm5YT2ZDbm1pR2I1V1l6Tm5OdTZjbi9tdHJrWFdl?=
 =?utf-8?B?Y202MmdWWkhBMitianRBQmd4a0lPRXVtdzkxRC92TG5nbkxLeDQwZVJhWGVy?=
 =?utf-8?B?clREOVV0Skh5YVQwQ2VBYlVDZmlqWWpYUzMvNCtKeEtsT1h5dGcybjhHSTI0?=
 =?utf-8?B?cm9Kd0REakNPV3hsOTUrMG16ZUxFZGo5eDNOWE9GSGF1Wm1PNzlzWTNnK2tv?=
 =?utf-8?B?MU9EaGxVc25UaGt5K0Z6RUNVZVp5cXdDaSsraG95WEdFY0VHWFpuWCtlSyt6?=
 =?utf-8?B?Z3B1am1ESFlab2kvVDZwdVlUNEp6anhvdjRpZ3pTaU5EaklGVW5kOG1YZnY0?=
 =?utf-8?B?UnJ2cUp6M0JNUC81blBzbHJ3MEIzV09SdHNPTTRYeGFTMTJTakk3RnFDUFFn?=
 =?utf-8?B?V1ljbUlGZXBTaXQ4NVVEalB2WGVLbGZSbmdjSm9pcXNRT2xpUjlnd0x3dkxq?=
 =?utf-8?B?eW81eG05SEw1SjBGTnppNXFUdFdubE5xeDVMbS9YR3dFekZ5Q2RlcXNuWVls?=
 =?utf-8?B?MzJPTURrK1JDU1dLbjhsS3NXaHpmdkl2cmRNcHBIczRhQm9MYnpiNFAxQ3hn?=
 =?utf-8?B?dmlpckx2OGlSNGliSWRhT2ZEN29wb2xnNFhtVzRYVEdXUkcwazU5QnoyWUI1?=
 =?utf-8?B?MHZKSS9HVmcvMkFqMnlWM1duS2RhS3BHV21sYzd6WjhickEwREcyZk5uS3hu?=
 =?utf-8?B?TGdZQkluS1FGRFJaWHhKTkYwV3VRVlpCclBwZG5VcG5HMXptVkRXenJaZ2xG?=
 =?utf-8?B?MElqODlsNmV5TkltZFBFTnlGcVNrRW5JNFhxOUdNYzJXZGtMMkJrS2FUN0Jp?=
 =?utf-8?B?aDVOWnRiWTRxV1pFdnZncFp6QWhtVkZhTVp1ZXBwRjNOemc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXBDbFY0YWJacFNJODh6UlE4amYrUVFMaHV0bUxXNEJtc3BEeEJDNGMzaU9n?=
 =?utf-8?B?NTQ2WE1GekZWTlZOd2hBeUxzUzdER2Z6Yy9OS0xPQ2E5NDRwbTkrMmp5ekI4?=
 =?utf-8?B?TG1aSjFXNER1OEF4V1RNK1o2RE1CbGFBR2dDbFA5RXhsZzc4YnVRTUFaMHc4?=
 =?utf-8?B?S0VsNmQybVBNaFBtbGY4VGNMRHlqbWFvQ2l2Z0xJemN1SFlRdlFLeGF0Wjda?=
 =?utf-8?B?bW5OOGRoRWVRbEdXNEc0Z21hN2dBbnJjRXNmMnNpYThnMVY4SjhXMkNKTGxl?=
 =?utf-8?B?SXBuSWVqR2tIQ3kzR2tHRTBHcmszS1lJTnByY0k4dWtkcEowRGpTODV2MVpv?=
 =?utf-8?B?NUNOOVd2ZGc3K0dxKzB0dHY3bHBHNVdWZHBtVkQyMnJpbkFHT3Q5TDBNU3cz?=
 =?utf-8?B?L2xlSXorSzFJYVQwU1MwSTcyTFpFaWFKL2RCcmJVSFVMOFNFdG9kdGtBb21v?=
 =?utf-8?B?anljVVVuYXA3a2xtbU5SUGUxZDVRTFVpbTFzRXFOSGJ1T1l3bHk5aWc0Z1lW?=
 =?utf-8?B?VmtNeUYvYm1CbVNHY0ZmMXNzWmdIL0d0T2NJeTNXMDlQbU5HbEFtaC9lNUs1?=
 =?utf-8?B?VmV1L2hvSnE2bHNidFdQdWEyamhRV0ViSEJ6azZINTRsU3FtbDNpWlhZd1dP?=
 =?utf-8?B?T1ZGb21MbG5TbFZ5SXNUYjFjODNha0pQSW52LzJveEJCN3RDZkFFL0dxVGlD?=
 =?utf-8?B?d0txTzNYVzRWUUFneTEvSVl3akEzTHNESXNpZndBL1dMbVNUSjdKWmpHSy9Q?=
 =?utf-8?B?c2RCSXhPUlhxRGp2WjdTUlZBNjM3cUVKNDZTSkZTSmdMZXpQQ0xTanViZFRJ?=
 =?utf-8?B?ekQ1Mm9zdk9WWmkva3hhQnNCOFRocEswY3JQT0c3bGdERERQWlpJWEVGbXJv?=
 =?utf-8?B?dXF6YW9iVHRSUDJXV2NjVXE1QnFzS2NpTlltdmtQY0c1QktFZ1Z2aUJ3ZEZl?=
 =?utf-8?B?VjZCRms2REVCYWFqdzRmbi9zTmVTaVpQZzdRdTUrbVozL21VdlFneXUvL0dY?=
 =?utf-8?B?YmxmOW5obWV2bjdxZ2N6NVAvRjcwSU8wYSt3M0R0YURGUGJlN0hiTHFtNUI4?=
 =?utf-8?B?VWRnblZZUnByUVIyS1lHLzVZMTFURnR6R3JCY2VhL29YaWgzZjFnbGYzOWJQ?=
 =?utf-8?B?Zk5IanhYQTl4czYzWGFWWTh4TTF1bTJma3d3K0lXVDVqelRGN3JNQWR5Y3BB?=
 =?utf-8?B?T3cwVWVHc0hGQkFlZ011cmNISm1kbDVOWHNnWnlCbUFvU0szVTdReERJODBm?=
 =?utf-8?B?V1JZTmt6VFZDSVUxL1BlUzZ3SFFIMk44Ky80WHUycmlsbjBkZnRoMHNpQ09a?=
 =?utf-8?B?RlRYWk9kYUVPNDNzU2plZEx1MWlpV1FVQnowUERNdzFnRkpKbm9XN2poL0My?=
 =?utf-8?B?U1pGcHJOcXI2eGNEdGtwMU1PaGZUU01QQ0g0VXY1VU5XODJPWTVRZjNaQVZC?=
 =?utf-8?B?dDdhcVVqZEU4QUtnN3N6b2EvQTU0QkJEMDlIMklrNk9xeDRsNHgrYjU2WE1B?=
 =?utf-8?B?WDE4L3VhMXpmYkpzamdsUzFkYjZMQTRlTis0MnRGcGJFQkJYUG9mK1doUTJE?=
 =?utf-8?B?Zjh6SGpkNlRqUVlxdWw3S0ZHcTJFZWtmRTZKSUdlbmFMSXFNc01XeHpVUnNC?=
 =?utf-8?B?Z1NVWEUyS1RFZ1FUeERsS1loQmIxQlZEUTdGV0Z0THpJQkgwY2JpUitBMklr?=
 =?utf-8?B?THJXVXJTS1g3cUlNWmtxa2FnOFphZ2tSUWxFTGFIOHQ5aDQ0NTd6T0ZrMFlL?=
 =?utf-8?B?Y0dhM0tJeGdrTGJURWoxNG05TVF5NnhCczlpOHZCUytnMlRzSnRtanhPaGNi?=
 =?utf-8?B?ZEE2VTRYNW5wTk9Hb2E1Q0l0K0dpRTNTMzFpVGxHSFlJK3A3T3ZoUUJVUG5q?=
 =?utf-8?B?ZTMvRW5aTmMxTEdzQk8vREVlOTkwZGtvekhKdm9hWDAzSk1BaDZjdmxsN0la?=
 =?utf-8?B?cnRSSXNPeFgrMG13azBlSnhmVS9KaHI3R0xsYlNHSUVyZlh2aDF3dW1YS2lz?=
 =?utf-8?B?RTVlUWRKcTQrb0YvYVZCTTVmNVd1WEtsdTNmNjZ3UDFXZmNlSUExalZrOFdX?=
 =?utf-8?B?TWJPTmUvRWNFNTRQTEo0V3g0RGs5dzhBN1plMmRzbFEyTlgveVZpUzh6WkFz?=
 =?utf-8?Q?by3TP7v6kJDi/Sy2wj/LVQIcF?=
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
	F7X0V0EXCWTNHK72w634vCrp6S8X7D+D7sP0BO7kzWduPheviUJGK2EY3l9tjKVnurJGefQ60EImjNUjx68n6U/03UGMWLLXiSTl4JoC16FfPA+JIpTNFVdk0yiBLPcmS2HQP92iCklF3gNHfk80ClXaDsrOSWs/fLHmUz1qqOi0KBzwiXp8csAxax4ojTEdWN9KVKZ9MKLNlEOC65GgYF4xgdUf8JXMAryIGviJj2R4+Xxtal0GJGV33TkjZ6MyWvdp+bA2kD5deu7god33nyA1nHN+E5Zxx+rgSH4Rf+zrherH2oaER3ysD1VDdCCCCMkCK72YKef+CcSsua4/hOGd9sX21QzBtq6x0w3O435nQT9cV8Cdt/POAvz8Kzi0y4DiqDm2z00bgpBS0c2vRd02WsZsjJsi6SNh5KaWUf5/InRAwaTUYUu4fITP11/nh5BRumxPFQRdR1dv9NQK9vhV+rBQA3xkEuyVGDeSYno2/ka50d6FAKyGfKN06jFD3FMZV5nwMYzUODIxfP11ohQxPu2o1UN9ISiCDl+N1XsGkJvvs7YRcjifVO6B1BeS0Y3lJhSNODrsWd6j/yHneJdWoqupIyQL1tl6S2Mhuk/nD31tKcouOxdLnNUsGdnF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30689ed9-e6b3-4e6f-61ec-08dccd71aad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 06:12:06.0889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOGjt/htQ7rZODRC9Tp9XAy7wCqcHh+dQZTnX1r/MT6XRdPLrOzOx0XsraswXa48WlcE2P7zCyQhsjN7nZw2Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8995

VGhhbmtzIGZvciBoYXZpbmcgYSBsb29rLg0KDQo+ID4NCj4gPiArICAgICBpZiAobXJxLT5jbWQg
JiYgbXJxLT5jbWQtPmhhc19leHRfYWRkcikNCj4gPiArICAgICAgICAgICAgIG1tY19zZW5kX2V4
dF9hZGRyKGhvc3QsIG1ycS0+Y21kLT5leHRfYWRkcik7DQo+IA0KPiBXZSBzaG91bGQgY2hlY2sg
dGhhdCB0aGlzIHdhcyBhY3R1YWxseSBzdWNjZXNzZnVsLCByaWdodD8NCkFjdHVhbGx5IG5vLCBh
cyBlcnJvcnMgaW4gQ01EMjIgYXJlIGJlaW5nIGNhcnJpZWQgaW4gdGhlIHN1YnNlcXVlbnQgY29t
bWFuZC4NCg0KPiANCj4gPiArDQo+ID4gICAgICAgaW5pdF9jb21wbGV0aW9uKCZtcnEtPmNtZF9j
b21wbGV0aW9uKTsNCj4gPg0KPiA+ICAgICAgIG1tY19yZXR1bmVfaG9sZChob3N0KTsNCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY29yZS5oIGIvaW5jbHVkZS9saW51eC9tbWMv
Y29yZS5oIGluZGV4DQo+ID4gZjBhYzJlNDY5YjMyLi40MWMyMWMyMTY1ODQgMTAwNjQ0DQo+ID4g
LS0tIGEvaW5jbHVkZS9saW51eC9tbWMvY29yZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9t
bWMvY29yZS5oDQo+ID4gQEAgLTc2LDYgKzc2LDExIEBAIHN0cnVjdCBtbWNfY29tbWFuZCB7DQo+
ID4gICAqLw0KPiA+ICAjZGVmaW5lIG1tY19jbWRfdHlwZShjbWQpICAgICgoY21kKS0+ZmxhZ3Mg
JiBNTUNfQ01EX01BU0spDQo+ID4NCj4gPiArICAgICAvKiBmb3IgU0RVQyAqLw0KPiA+ICsgICAg
IHU4IGhhc19leHRfYWRkcjsNCj4gPiArICAgICB1OCBleHRfYWRkcjsNCj4gPiArICAgICB1MTYg
cmVzZXJ2ZWQ7DQo+IA0KPiBJcyB0aGVyZSBhIHJlYXNvbiBmb3IgaGFzX2V4dF9hZGRyIGJlaW5n
IHU4Pw0KVGhlb3JldGljYWxseSBhIHNpbmdsZSBiaXQgc3VmZmljZXMsIGFuZCBzaW5jZSBleHRf
YWRkciB1c2VzIG9ubHkgNiBiaXRzLCBJIGhhZCB0aGF0IGJpdCB0byBzcGFyZSBpbiBleHRfYWRk
ciwNCmJ1dCBJIHNlZSBubyByZWFzb24gdG8gYmUgY2hlYXAgaGVyZSAtIHNlZSB0aGUgcmVzZXJ2
ZWQgdTE2Lg0KDQo+IFdoYXQncyB0aGUgcmVzZXJ2ZWQgZm9yPw0KTm90IHRvIGJyZWFrIHRoZSBw
YWNrZWQgNGJ5dGVzIGFsaWdubWVudCBvZiBtbWNfY29tbWFuZC4NCg0KVGhhbmtzLA0KQXZyaQ0K
PiANCj4gPiArDQo+ID4gICAgICAgdW5zaWduZWQgaW50ICAgICAgICAgICAgcmV0cmllczsgICAg
ICAgIC8qIG1heCBudW1iZXIgb2YgcmV0cmllcyAqLw0KPiA+ICAgICAgIGludCAgICAgICAgICAg
ICAgICAgICAgIGVycm9yOyAgICAgICAgICAvKiBjb21tYW5kIGVycm9yICovDQo+ID4NCg0K
