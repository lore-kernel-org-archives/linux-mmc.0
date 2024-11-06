Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524D1D63DF
	for <linux-mmc@vger.kernel.org>; Wed,  6 Nov 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903061; cv=fail; b=Hg5MWMxyJ6VEBbDns3yGBoSxyDlm5zhB3kV/A4XiyorfYAjdQNu8wP8MDumQg7pM81zyyu7RV0SuQGR3MMG+l0blg1duQppI7PR9i3wr9FY73hpWmcAATCrf/NofgpSdH9TG0ZtqY6EXss0uFIH20+gv0ey3B79ID5HTG8Nnbaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903061; c=relaxed/simple;
	bh=e7YUHHoy4XswVo2rR90V/WFoDtu1tKkaYHkV/ucwk1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CuuMhgMIYC0F7CQj3UDTFdgBFMHJboHcxhs/RpUM96B/hsAXKppxS9dnBQdFdaBUemzPl1WL2AiaAe9J+Y6L8QqTCSPz+qQ92349Kd9baXZjphMFXPdoNJwjhRmVS44ous5HU1+8xA4geOREAZwRt2pGEUMSSbMHOZTocfRsghw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mt3Lb9cX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eMeEffTc; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mt3Lb9cX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eMeEffTc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730903059; x=1762439059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7YUHHoy4XswVo2rR90V/WFoDtu1tKkaYHkV/ucwk1Q=;
  b=mt3Lb9cX4kayYGIiuHrFxCG1+bnE3TPhGalXA9L5PS7BxICEw/Shf1+c
   zSKF2dIhHCgKwl2fSdqw7PyE4gthboMHSawFkL4o01pavEw/5pydQQn1B
   V2nL6HweC+MaCJEFxcDH0UU3w/YreYtguP4jVWJ3/mzmBbRDokA87xQDu
   PdyMqTvdo1YFfG+TjTKu3B+vxBrz3mxDR/alSpxJ97qL3sSh4TTtLYHd4
   sX60gWyYvu2+/5/rNzBjh+N3qOR4tZdcyVU5Pd1QITfVCtBLmq2CMgm8Y
   Dw8C3mOfQ/LXxvveeDlx4Qlcu9PolMjIWj+FOt4zZhDds74cjpfby3RFL
   g==;
X-CSE-ConnectionGUID: 1jbMHVMDQw+oIoelcOF5UA==
X-CSE-MsgGUID: 8d/FqQCARAC059N4cVqCmg==
X-IronPort-AV: E=Sophos;i="6.11,263,1725292800"; 
   d="scan'208";a="30186724"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2024 22:24:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpkrkGDpWBhrEypm4+DIdcOb5/EsXbu1pTXj4UQwIAqCDuEsIJ116paeGaEw+zPeRFBvtROsiCXurD7r1osH9UYJrxw9aY/PGlf7Or6IolU3+Wtw1O0yyBmBRLFUghx+IcaFuOiUxLhm/b3ftoFk8j6WpfZTZxXgOjlo52zj3X1/j3AI5uIWYN2WkAseeTChRweR2iquTyx3v9StrlOX4IoGmExgwGvUObyAmM79i3YXQlP46R0e3ZO4qj2z7ekeZj4/TYOM4nSNtGJUDbinv9hmgwLAluwTUp/Z0MPN5ZYKmsRhl2Ycpq7uvQZfkrZEu7s6yTevuCtoaRtUvGPcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7YUHHoy4XswVo2rR90V/WFoDtu1tKkaYHkV/ucwk1Q=;
 b=w6G2fHSid/lhesJJbymJfLare9wHcpRuTx3Jjqfg2jCn+zCCUXOOmPx/MV7FrHkSYCuYmnwhnJrlA4auVXZFJELvlSErlXcMO1HUmj75cDIkEqPtnq7HmQ/zOv/+CzGCi6i/sAFqwG+py/D0IsKn3XaSlGIMQctv+tDHI8q/JhN5YVMqh2QZ93fVkC9Zx+iWT2RU0V/eXUUAXhUX9dU/onQmP1M417yJkcsC0H5wWJTA1D6nD41hCu+KKhPpHr2MJ46iFoNBMk1f2lkSWhlDFQTc6qqFzTajOd+HOuLz5Q+5INM+YltgNmapEjmS3Fsttu6O4nrt/tpomfLsm3aUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7YUHHoy4XswVo2rR90V/WFoDtu1tKkaYHkV/ucwk1Q=;
 b=eMeEffTcWGCdiOR47IE3pwu1mNpVGbZHG68nebwuSfoaQQFTsTG2AlgXF/Ma/ojY6eDGfEZVhYqD4Dd/GapIc//+JXEtVgDjqUIGsU+KL5zflMHxyw3sB3VhC2Fj9bSsCqrS37UO5bpZYtD1gYvx0d6ND4DJQs2tI0W6NxrrOZI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6721.namprd04.prod.outlook.com (2603:10b6:a03:22a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 14:24:10 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:24:10 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: clang-format fixes - part 1
Thread-Topic: [PATCH] mmc: core: clang-format fixes - part 1
Thread-Index: AQHbMEZWP7S5xGGM10mvFlfsGDkrdbKqQskAgAAJcQA=
Date: Wed, 6 Nov 2024 14:24:10 +0000
Message-ID:
 <DM6PR04MB657587352F665AB88DADA482FC532@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241106121830.739041-1-avri.altman@wdc.com>
 <22a22679-d51a-4455-9955-df522ef7fe84@rock-chips.com>
In-Reply-To: <22a22679-d51a-4455-9955-df522ef7fe84@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6721:EE_
x-ms-office365-filtering-correlation-id: 431d7748-5986-4e3e-6fa9-08dcfe6eae86
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFVTUndvc2pjZFVtV2FEZ205SUJaaGY4QUFtK3ZjODVFOE03OHpVSXVvUE1M?=
 =?utf-8?B?OW9SVFJxTXkyRGVxaGhsOUtCKzJIUmRCYjhnNzcyd0F5OEhPcjlTZWw3VE4y?=
 =?utf-8?B?KzhtUFZhVU81a0NDOXF0MEtsdWFXTHZYZ3NXRS9WZ3pCbzI5ZnJlZWRSTnlq?=
 =?utf-8?B?dUtuVDlNYmJZZ3hFemc0dGM1V1lUdXJiR3J5S2NGV2tqMStiMGhtVTBWanhl?=
 =?utf-8?B?NzNrdDNGZVczLzJNSnJ3dnBPSSt6cUhwQjVPbXl2Y1M3WGpUamQrS1FJaEts?=
 =?utf-8?B?eGRoVHp3UHFQbnhEUys1aXBaeU9MOFNkMzAzUitaV2JkdGU5R3IwaDNOemRx?=
 =?utf-8?B?R0hZRE9ka1kwV1VQS0EwdU5OUFNYbUhrVEo0SUkxUkNYMkZrR0tCc1ZoQUNH?=
 =?utf-8?B?QkdzSitONkRKK0xvWFZKZTIvTUxrV0RpNmwveUlJNlE3VW1rUDVMcWRSWllm?=
 =?utf-8?B?S0FBV2ZQMTVSd2kxajlpRkt2K29acE4yVzNjR3R6d2Y3VDBSc0hKWnZIWHpU?=
 =?utf-8?B?WlBuVW9aRzlKRGZMdEVocTVuQ3JibnlXZ2FHVmthaTVFU0N6OW5oQk1URGVa?=
 =?utf-8?B?RkphNWZYb3J2UWU4cFIwbHJ6aldlZzJwcVRVcWU3OGVpTkQ2Q0VBTXpuTXZJ?=
 =?utf-8?B?d0g4VTVadWF0TkZKVWJZQTJJQzFtdlJUNmZiMXY3ZnZnUC9zV08wZkZVODlB?=
 =?utf-8?B?dExMKy9uaUtUcnBGb0lHV0s2UDRpS3FnZmxZVEVLcGJHb01ZbWdiNUZJdjFw?=
 =?utf-8?B?NVdXR0VScDhnd2JRZFZFd09Gd1QydEF1bWVOdzF5NU16czhEWHJwQWEvWXBF?=
 =?utf-8?B?akJNMHE4WVkrT2s0ZE5vWVAxeXBtMXM0M2JTMWRXenZ5M05hZ0dHdG5qamJ1?=
 =?utf-8?B?ZU5ZNXBHckEzbGZwS2dPQ1J0V2lhT1Q3VDE1YlF0ZWllbnE4ZGVIbFlyK2R0?=
 =?utf-8?B?dlZFM0tSTDNCMlVMVDBzYmoyaUUrUjVCWmlvRDRvSlFSVUYrbFlNandSWlZU?=
 =?utf-8?B?aGZMU3QwNWJ3WHRrb3hRNGFsZXhFN1YxUG1Td1hUWndCM2xJZ2hjazdzSnpz?=
 =?utf-8?B?QnY1RC9HZXMvcFY5QytXRDFmTklBK1MxTzdyOUtvNUE3UHo1RG1JV1hmMG92?=
 =?utf-8?B?cnBsdGVWZXhzMkdONkd0SEJlT2ZQcjFHdlRXRDd1eUVLNnRKaXB2VnpJa0c2?=
 =?utf-8?B?WVMzL1RZYnZiaU5pbmExaU5JcG1HS0pRL1R5dlRzY1lNSy9ueGRvZGc3UWFZ?=
 =?utf-8?B?STA2QVhiMmRpeWtxMW93N2Z5SlByeFd6aU5KZjdKVWVWWmlySitReUpYZmRY?=
 =?utf-8?B?ZmVoc1lqZ1pkU2tCUzFFWUFhS3ovSFU2L1Z0MlVlTEovSE9NSlcxbWk0ZWcr?=
 =?utf-8?B?bUJhTjdpR3drU0ExM1ExUHcrWHFTdzNYK3pCM2twRlJWUTIxMTNubFBKNDhv?=
 =?utf-8?B?TDVjWisrUGNDZGw5OTlKeUpPUXNCVkkwOTE4MnJnK1RRN1ZRekVJMCtmOGp4?=
 =?utf-8?B?R3RUV0hQdFkxRDk5SjJrT09zeXVNYXk3dDRtbEh3QlBuMUdqYUJNRnlhQW02?=
 =?utf-8?B?K2ppQ2ZHWlFDcWpVeGxnNTllQWQ3aERpYVdNdVQxbkxCc3VJcEhGb2dZRnJC?=
 =?utf-8?B?MUZYR2p1dUYzY3VTWlpSSm83SExMbitkSXZrcEhUUStUN1poS0VlMUY3UjFU?=
 =?utf-8?B?TmNEYmhQS0E3cjVCTmJvSVFuQ2NYaW5KVkM2K2ZHajVMQVJOeEJ3SXJpQTZt?=
 =?utf-8?B?RzJBMFNNM28vSHh3ZTZ0K2FyYUNOR3I1WDAvcWVETW80aEdBREpQMjNCOFc5?=
 =?utf-8?Q?wkyy+pSA+78SwZ++06nfWJkAHhNIVFHitk01I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SytHbGhaMmRIRHh4MTlqVm1SbHlneWFkZDZ3VldFT1RUT2JnYW5TUTNzZVQr?=
 =?utf-8?B?NGh0eEQxYmwvYXpjYlA3cERKMTZ0NTVCTTBPWVNCeEw1MXI0RnBPa3BvcDZG?=
 =?utf-8?B?cUJPQnQyclhOQzBHZVBiaXR6SStpSmlCdjkzN2dKRWpuckpWMDR5d3NCRDJD?=
 =?utf-8?B?TVV2RTZvaVlEdTBzcEs5b1FxQzBvVWpBaHNWMUNDaDdxTm0zWlBiM00rRVRG?=
 =?utf-8?B?bEEvTXl5elA0TUlYVDRucS91dHlSdlJiQ3JXb00rc0sydHRVaW9BN0xQSWV3?=
 =?utf-8?B?QUpPZmlMb3J6aWgybmY5T25BRVBnVnZZWTlCTlVmTVoyS1VOZGFKbjdjUE9C?=
 =?utf-8?B?MzFyZjg2TlQxbjM3NTMwMnh3ckJGeVgzNUdPQ1A4VmlWeXA1MzlxcFhodzhi?=
 =?utf-8?B?L2Jpa2hjUk5PdVZKYTN6UGpNblBDZ2Z5U3dVRnRYdytFazhBaEpjZVU5OEs4?=
 =?utf-8?B?R29SOExKRThmM2wrT0s2RkJ2S25zKzNwRkZPYnhoSDF2NGRZN1lMa2JmNTJk?=
 =?utf-8?B?bnpIekxKbEkzWWhMZzZGb1UvTk9aKzhFU2I0Z3ZkZmFMU1lnYmtpZGtHRnRh?=
 =?utf-8?B?bnA2T3NEYXg2aU5SaG83T0FxYzFGQTYwaDAvbzdxNmRVSGVjMk9IY2lYZng5?=
 =?utf-8?B?L0tYYVc2S2JhaDRlazhycGEyUG0xNXRnTVh4U2RaL2ZlTkVDS3Z2RjUvZDk2?=
 =?utf-8?B?Y21TQkw0ZWRkcml3b1VaMVJKbnpoalVQRWh5M0pmWTllMDFmZGsvYXBUZFdr?=
 =?utf-8?B?ZDB0SndsVm05VUgrVmdXVHJnSlpqbDlXbFMvT2NaL3M0UExkd3pLYXhYM3h0?=
 =?utf-8?B?ZVBNR3dQRy8vSitybmtJQTU5bHhjMG5rU3FjTmJrTlJmMU9pM2d4WGl6bmFL?=
 =?utf-8?B?RkpVbWFpQTR5TCtUU0h5L0krbmhDWGhlVXhGMzVkamY5TlJ6YklabUhtb0lY?=
 =?utf-8?B?VWFPcmlYNHoxQXhibDVjaTh6QnhiZXFyOFhIUFYrRzEvajVvTzd1ZWM4Z1FO?=
 =?utf-8?B?aTlyS21XQ21Xd3lkRkV6RG5SWHlNbmNsYWJ6aGE4M2J2NTdtS3RRTEMrdTU3?=
 =?utf-8?B?NmtHWmo2b1RRem5rMnkrTU52MWNRalRMTHd2VDM5Sy8wL2QyRFZhRkg0dDhN?=
 =?utf-8?B?blQ3dWR0VDlIQ0wwNHNnOHNPTlRreHZXZjgwOVl4LzF3SlZVcWZjUTMwajNC?=
 =?utf-8?B?UFgvSDEvejRmcDhONmVUdDg5NGQvU3hzK2wvdkIyZ2lyMGR3R2IzemEydFdl?=
 =?utf-8?B?NXM5U0NZZ1NHUzlRR3ZKS0loa0hSMkc4NnAzOEJ4UW5rWU0yQ2xlNGp2Tm8z?=
 =?utf-8?B?TnlkVHhKUzVIYkVyMVV6ZktxclFjejQ2OGFxRXRSWlZTMnVGVm5XbS83WE41?=
 =?utf-8?B?ZzA1Si94V2ZnNkk3cnBHQkNqR080Z2FVWENiNzhTaEJLMjRLY0d4SG1qVzNC?=
 =?utf-8?B?RCt2elEzcFJiZFZIQ3RWa0JtbXpKMlY2RHI5L3JhMmxTbGhKUVlhSWlqejNC?=
 =?utf-8?B?YzJsS0Z2NXBuN0h6NDR6WHB6bWlnUno5NVZJYUpiV2NBb3EvVGhzK3BTQisr?=
 =?utf-8?B?cVlCWjgwaTdMMkUrQjJtaXlCUmxaZFVMNXNQOWozZ2tBbWs5YXFnY0ZGUzFY?=
 =?utf-8?B?NEg4R3hmWnlPVUZzUExtQm1hNERLdnE3VHNQLzhxc1VmTUhRL2ZiWHV3RUFD?=
 =?utf-8?B?UGhOeUtDL3hrSUtwdnVVdFU4OWpUL1NVeUl5SFJ2YThiUm1ncmxBRk9JNVV5?=
 =?utf-8?B?VWFpRHkrdG9iYy9XMzdIQ2NLZitXUnlrVWN2TEx3KzlybWNnTW8rajczMUs3?=
 =?utf-8?B?WkYycWVDQnB5OTBJTlRlMVNtSVIrc1dWSWhQVWVZd1BuZFJlOGNjcVFqNHp1?=
 =?utf-8?B?b3JYMUw3OWswUzBhU2pLRDlKRlk0TUJwSk9VVlc0dmRPbGhwSkRPYUFrbVZu?=
 =?utf-8?B?OURRMiszVlpBMnhwQThhSTNhRS9VbUdHSGdXb0l1amJCK1c5ZzZlRFVETDlT?=
 =?utf-8?B?aURLbkFoenNKclZ5Ni9GWjhvdWJYR1o2cjZZQTBoOC9VSnh0U0hETXZDd3FK?=
 =?utf-8?B?N3AwbXNrYnpobG5iR2hhKzJhTXFYOElPamtROXhNNHRhbnM3L2x6a3RPcCtN?=
 =?utf-8?Q?5GHGhqnIpeyr7YBrJ5lONq7ws?=
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
	4hIKJCpvH7wmo48G6OjYJaJeFca4hnKkNZHbYIRz6dXBv1e4QxkoaaqH/UHP7O1GZ3eKiC7zaNoADhrQ4RAL36SwMinhIBj0Uw63b3Fw4qMrvYmcNF6VTaYC4gb886XxxFmSh3GwBDJVEJm1ye/goG3bskgOQzlWit+YjPJFPUrvudrnsveme/fFTfGfT9NAtyLmw8z/YPYomt+rICQi1LR9TYvFgouPcauyjyUIq6srrSHOgxjl9GvTnYVnYaXKhFIc5L5mMzv5zEAzeilv6fSB95YFgmy+PXSosjgulc34iTd+TbqVSkhTReUrJmijegv/TCwkJL/EoHQrtpOeHjY8Cc5cH8RUYaNnjwRkkgRE7zzRehmEgL9pCS6CB9ntTEHzna3LXDAnwjsBH1OHmjD0ALouBNtspCtXGwu+omLsYV7r+lVzHF5ROZ0NJbfgqVKk3en3Nc5t1O3qVXY5FeuP3Xcz0lyt0c+w8QV/gbW4gKq6XmxXinBPk+Dq9X0wuaDUMXQsjEA4d812T+D80GKwnwPGK9T/2qNDzZI49BnvC1VO3ts1vjWDWxygGc2K+hgZ96jV1TtFPjGioJusmM64zrV1cOdydlfma+SfowhOVa6adMYcTBlgyHbtZjQN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431d7748-5986-4e3e-6fa9-08dcfe6eae86
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 14:24:10.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqVx7fE3ZBuXw07iOAM7aHZDJFCjFjc8cqYVjDN13t4s+FHP+2fSDKQyXbvN8dOqNijL01n9lrpQEHCq5QzWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6721

PiBIaSBBdnJpbCwNCkhpLCB0aGFua3MgZm9yIGhhdmluZyBhIGxvb2suDQoNCj4gDQo+IOWcqCAy
MDI0LzExLzYgMjA6MTgsIEF2cmkgQWx0bWFuIOWGmemBkzoNCj4gPiBXaGlsZSBzdHJpY3QgY2hl
Y2twYXRjaCBpcyB1c2VmdWwgZm9yIGlkZW50aWZ5aW5nIGNvbW1vbiBzdHlsZSBpc3N1ZXMNCj4g
PiBhbmQgZW5mb3JjaW5nIGNlcnRhaW4gY29kaW5nIHN0YW5kYXJkcywgY2xhbmctZm9ybWF0IHBy
b3ZpZGVzIHNldmVyYWwNCj4gPiBhZHZhbnRhZ2VzLCBlLmcuIGF1dG9tYXRlZCBmb3JtYXR0aW5n
LCBjdXN0b21pemFibGUgc3R5bGUsIGNvbnNpc3RlbmN5DQo+ID4gYWNyb3NzIHRvb2xzLCBhbmQg
bW9yZS4NCj4gPg0KPiA+IEJ5IGFkb3B0aW5nIGNsYW5nLWZvcm1hdCwgd2UgYWltIHRvIGltcHJv
dmUgY29kZSByZWFkYWJpbGl0eSwNCj4gPiBtYWludGFpbmFiaWxpdHksIGFuZCBvdmVyYWxsIGNv
ZGUgcXVhbGl0eSBpbiB0aGUgdWZzIGNvcmUgZHJpdmVyLg0KPiA+DQo+IA0KPiBJdCBkb2VzIGlt
cHJvdmUgdGhlIGNvZGUgYSBiaXQsIGhvd2V2ZXIsIG15IGNvbmNlcm4gaXMgdGhhdCBpZiB0aGlz
IG1hc3NpdmUNCj4gY2hhbmdlLCBtYXliZSBhbG9uZyB3aXRoIHRoZSBmb2xsb3dpbmcgcGFydCAy
IG9yIHNv77yMd2lsbCBtYWtlcyB0aGUgZ2l0LQ0KPiBibGFtZSBoYXJkIHRvIGZvbGxvdyB0aGUg
aGlzdG9yeT8NCkkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4uDQpJdCdzIHRydWUgdGhhdCBsYXJn
ZS1zY2FsZSBmb3JtYXR0aW5nIGNoYW5nZXMgY2FuIG1ha2UgaXQgaGFyZGVyIHRvIHVzZSBgZ2l0
IGJsYW1lYCB0byB0cmFjZSB0aGUgaGlzdG9yeSBvZiBzcGVjaWZpYyBsaW5lcyBvZiBjb2RlLg0K
VGhpcyBpcyB3aHkgSSBsaW1pdCB0aGlzIGNoYW5nZSB0byBhIHNpbmdsZSBtb2R1bGUuDQpJIGFt
IG5vdCBwbGFubmluZyB0byBmbG9vZCB0aGUgbWFpbGluZyBsaXN0IHdpdGggdGhvc2UgY2hhbmdl
cywNCkJ1dCB0byAqc2xvd2x5KiBjb252ZXJ0IGZvcm1hdHRpbmcgaXNzdWVzIGluIHRoZSBtbWMg
Y29yZSBkcml2ZXIsIGFuZCBvbmx5IHRob3NlIEkgY2FuIHRlc3QuDQpBbHNvLCB0aGlzIGNoYW5n
ZSBpcyBub24tZnVuY3Rpb25hbCBmb3JtYXR0aW5nIG9ubHkgY2hhbmdlIC0gDQpUbyBtYWtlIGl0
IGVhc2llciB0byB1c2UgYGdpdCBibGFtZWAgdG8gdHJhY2UgZnVuY3Rpb25hbCBjaGFuZ2VzIHdp
dGhvdXQgYmVpbmcgYWZmZWN0ZWQgYnkgZm9ybWF0dGluZyBjaGFuZ2VzLg0KSSBhbHNvIHRoaW5r
IHRoYXQgdGhlcmUgYXJlIHNvbWUgZ2l0IGJsYW1lIHN3aXRjaGVzIHRoYXQgaGVscCBpZ25vcmUg
Zm9ybWF0dGluZyBvbmx5IGNoYW5nZXMsDQplLmcuIGdpdCBibGFtZSAtdy4NCg0KVGhhbmtzLA0K
QXZyaQ0K
