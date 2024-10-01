Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538241BCA07
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766268; cv=fail; b=MNp2PrW0BSfx0iPmNX8ZY0B43sDTteCUAWM5zOh9a3s9kV/wFiWXUpBFXO9atLbXR6AjawyyeR3P21z25ceNi0u8IWcStcka/iFpVrWuBkvrEaZk+Nvm28wvVuaNr5LpA+rDHaJR/lfMDj9SpE/BdpjA3RrbJVjVgdfG5d1337g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766268; c=relaxed/simple;
	bh=N0KQ+XldPNU0Q+TMENkA2A9Vd6zk2FwBIwAY4lRDTLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AelqXwoe2nDDn6PTqo8IKx6OzyuX8D/tX2yEHjQeJoDrJDUVh2fsyyjtxkrPhY2EfWcck/CBQQPewCcDjtJenntUm0uTzf4aLfxZBSNx47fQiBk3tuXThKfXS7eudmoHrV2IwDPn4oioYEF5e5tBXw6BQYSUcSL/VfpY3wn3+mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cb0zToqp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JgE+AVzZ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cb0zToqp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JgE+AVzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727766266; x=1759302266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N0KQ+XldPNU0Q+TMENkA2A9Vd6zk2FwBIwAY4lRDTLc=;
  b=cb0zToqp9SM36UxIGhS/Oxk9BWdKfaa45TNtu8jQw7ftlVHThNc9kndL
   2kGqNMcFyaTtvQHbUvMvuO7cbEDaDOZUYQk00VsrAgv1YB3nKFfpGjm0d
   Gzy2EkfPoKZiSaCDAxchZz8h8tNAGJN94CUiVzU7M3M9gdG/mi82TGYb5
   KFdowOKDs4droWwt3zmK/DQoiN+3ho1Ue75m/IOD8HeKUzSJSGsSASRwf
   XPjHyH1K2wflKhx3eC4ZHuJmLrjiAXxjGcTEsWALsntrV8JZqOkwiw1lt
   d4psgFJ2lJb7c0EUv9lfmEZdBoJclJhUB143Mp5Ac9f7gZS8MNXTpIZHg
   A==;
X-CSE-ConnectionGUID: qWik8gynReSxiixVD63wZg==
X-CSE-MsgGUID: advYQK/ESfiu4z5hxaeyTQ==
X-IronPort-AV: E=Sophos;i="6.11,167,1725292800"; 
   d="scan'208";a="27354720"
Received: from mail-bn7nam10lp2048.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.48])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2024 15:03:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUczgTHGxIB2HCyXGpitgHpAbzMBIrG5IIRbHBVj99wFWEOC6ucFJWNxIcJjyghQgENPtywqepo/YPNs/U/hOb1jOd93etfEWMCFIzUemoC9qqP18vJoCnMBDX6PvQDHRh5ToYbtLNGcGsLCniPGpHAtYnaAcmlUCcANtVv5j4V/ZKnsxihpgmaY8hVyfjxBnG1Bb3DYc4JLkaaDhGVkgE7Bx0utpNF74O94hzLwJF9Lx6VLiTmmn5vCB3xpdtkSxxAxuZhUy0efLMCIW6fPuYXy9JnCJr0xmuakKEeAXJj3VOd3D8TjgoyUt0l6SMV5GJ29hJYz7UHhMdKSGJIN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0KQ+XldPNU0Q+TMENkA2A9Vd6zk2FwBIwAY4lRDTLc=;
 b=JCEjMho1fZh+uLCZpt+OTxI/0/K2oKZe1wnJlYw1Fba4wQJ5SzKLuygo8bWIAEe2UlNcoFh71qK6bmKnEGIxGiF9dKUTtqod+OjEhEHNRNIR4sBVL7ZD5gqCeOiqHHACo5X2DqpvrxhBgo3Q66ffVbC5P/JOqTP3s7eMd/bWtuShxWXmV9kSoc5S15g8PxU2eMvJE1mhRsGu+17Cy1VxT5sVL/O5CyU/0VutfD4okL1/4PHHHwUXO1MZY6p0AchAO+hRhzIMrP4xRc+FjcAQW4k7bOc96cxJhrFkAYF8MSo0hLMJbDIoUjQHzlJGre/MyHRsW0xdTaWpi7ekXc9DsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0KQ+XldPNU0Q+TMENkA2A9Vd6zk2FwBIwAY4lRDTLc=;
 b=JgE+AVzZcgft7ghWdt8aPWrjPKb9wEFRIX4TeIOwdrcwGXy9fuvHitLHV/XiO+FQpMKuY/U7cqTHRQikcgM6fmPTm0ZZL3CSarz8LBQJulbjVomSejXwRWkY54HJCx2HVnj1SsAv7spYuwcp6VaqZs/fr98FCvC7xWhgO6kbNd4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8030.namprd04.prod.outlook.com (2603:10b6:408:159::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 07:03:15 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 07:03:15 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>,
	Michael Wu <michael@allwinnertech.com>, Wenchao Chen
	<wenchao.chen@unisoc.com>
Subject: RE: [PATCH v7 00/10] Add SDUC Support
Thread-Topic: [PATCH v7 00/10] Add SDUC Support
Thread-Index: AQHbAdj4vMM0vFxPGUqJsXBRXsqJYLJPRK+AgAGWXdCAABuVAIAWXc8wgApHrmA=
Date: Tue, 1 Oct 2024 07:03:15 +0000
Message-ID:
 <DM6PR04MB6575428FD40ED3CF919AB302FC772@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
 <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqJaAob7xceSkNe3aNogT55OoY5WRdPsFs450Sy3GhM2g@mail.gmail.com>
 <DM6PR04MB6575AE090B4E4F14DAE2A209FC682@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB6575AE090B4E4F14DAE2A209FC682@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB8030:EE_
x-ms-office365-filtering-correlation-id: d4e5ce94-ac2c-42ac-1e8c-08dce1e71f12
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajAwSXJDSHc4R2cxYTJpdUxGK29jMlhiakorTVhjdkxOMjdYN2NIYm9GTFRI?=
 =?utf-8?B?a25XbFhxdEJxcW5XaUNteXIzTkxNeFVhZ3RzUjhxR2h1a1hCUVJBU24xaWp3?=
 =?utf-8?B?dDN1bkY2VVV6bkRHODEzVUxuTEZuT0dWaUJFSlUxYjAzOGlFeTQ1VE9sOUFC?=
 =?utf-8?B?VU5DZVNiaWx2ampvQTdtMWZKMEdBMlJoMWFTSkJhNHpSbW1rS1R1bHRsVnNw?=
 =?utf-8?B?a0x0TGVrNE1pTmhYWkpydkE1eW1EL0pBcTFCOCtBdjRBSFI0RVhsQ0hRRnRQ?=
 =?utf-8?B?TDhFQmhZSzU4eXAzK0JicUs1NndtM25IRjRHK2lqTExjcG5SZkNRV2h3Snhs?=
 =?utf-8?B?dGFsSy9vdFJKM0VtMUExdTFIeEVWQ2ZDNXpIbytFWm1vQzE0M2hzdCtrdWNp?=
 =?utf-8?B?NGJlODlMYlVvUVNqOUpodnoyR1V4WDJvUHp2QjBtYzVLYzg1YW9VTk4vV1Rm?=
 =?utf-8?B?eUh6dS82UW1oT1FqM21WdkZZT0N5R3BBVUlhcTlRWHpWdTN4a21sZndCUjJ1?=
 =?utf-8?B?N0dFQkY0Q3E0ak81V0N3RFhQL0J1TTFIOHgrUWtkMFdGSzd6T3N1cDk5dzlV?=
 =?utf-8?B?Z2IvUjhQL2hBV3hHc0xQYlhTN3BuNUVMelI2R0R6aTJRL0FxOWxhYnpKbFNM?=
 =?utf-8?B?dlFpR0RRdm9iUnJTeE40QThUaExIUDF3cXJrckpJMklPdmJKWjlNV1RuVGdW?=
 =?utf-8?B?Uk0wa05xVjhITXNFR0R5N2Z1TExNRU9QdXVRUS83WGdXenBzcmxicjJSdmVO?=
 =?utf-8?B?aEd4LzdyQVNmQ0NqWDVKUnV3TU5hdjJubVQ1OVM4M2Nab1JoL0hndmp2L0FX?=
 =?utf-8?B?dkpUSTRYbVRzS2R4ejllWHZTMWlrczhjeXpzb25tTFRJSE1qd2pYbEorOHcr?=
 =?utf-8?B?SkFzZUw4bG4rMnVtUlpUYVpJOHVSTHJRVE9VZmNNdkVZRFIxM3BlaXNKcHZr?=
 =?utf-8?B?QWFHdHR3OVo2UlprQ2s4dE9CTTVUckErS2g0UXZFK1lzMVZJNUpWVVN1UVo2?=
 =?utf-8?B?N0N5Yy9XMnl0NjdCQUg5d2UybVRNdjE0UUw4MldaUHVWNHk3VVJMNHFvbEFX?=
 =?utf-8?B?TEtaR01BYXJ4K0cwS1VaWlpMd3NYMTJEMG5mNWEyMnJOV2xqRUhGMTVVdnpD?=
 =?utf-8?B?dWdKanU5QW8wejRlbjhPV05Sb1BFSGJsdTRieVdjUmxzQnZYc08wOGVSS1Za?=
 =?utf-8?B?YUpWZHJlQVM2N3VBNUZBcHZTd2pxeTdEVlFGR2ZCeE9NTTkyOUFvb01XYXIr?=
 =?utf-8?B?cDZSUjRWQ0NxaW03MmlPTDlEeFE5N1lqcklNUXM5emhaNmdGM1pZWXlkQStq?=
 =?utf-8?B?OWVuaS9hTkNrWEdFWU9JTkljQitTaXEvUktWbUJtRmNETk5YMy93YXZKemVj?=
 =?utf-8?B?SkFDd0RCTzVmS3hTZzhDSGNkZlllYzdGd1dybmtLb2lJd084ODQybkdnNmZt?=
 =?utf-8?B?N01ZVUpiVndRcTdOMkxHMHFTbjNXUTB0aXNyQlNFRU01NkJUT0dYN0dUS3Bm?=
 =?utf-8?B?by8vaG9xUExHZDd3cTZFQ1dWK3RFdmdwb3kxUUF5SVpxUTNBNnZuRjhhSFBx?=
 =?utf-8?B?dks3VDBHcmtaZysxMmJXanc5WFh4RGd0UkNPRWkxVDRwOW8zOXltaS9aVmN3?=
 =?utf-8?B?L3huSHovakJlakxFeDJWRFpTZ3gwMXZxWW1UWlRienRSQTBQcndhRTNxSXRl?=
 =?utf-8?B?UU1jdXNHSFpPYWFhOTZWRjkwQ3hpVWo5U3ZKRUZVYVRWcjBONU5iOUgxeVpH?=
 =?utf-8?B?SlpxWG9QaXRTZGV5RUEzMTNzSXhqM2l4b0NYVElkc0J4dnpHanhzM2RzaGd4?=
 =?utf-8?B?SnlwQnM2cjR3Q0lndnAyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azRSWWJVeTliOXJZaDYvbXRHSVNwL2I5TkcyaVR4aEtiRDJXOTJRdFB2M1NZ?=
 =?utf-8?B?UEVodE1BWTdyRlpoQXNYVGdzK3F4b2cxWXZnQ0N4YXhFNkpsU2wwaStxUmtX?=
 =?utf-8?B?TnQ0alovOThuMDc5KzVqeGtmNzJRZjJpWmM1RCt2WEFNNDArSlNudDBHbVRr?=
 =?utf-8?B?YjZ4NWphV2J0VDIwK0VXaFNraFUwSUJxMUIzOFFscWdrZFhPTloyM2xCTWhJ?=
 =?utf-8?B?bncxUHBOY3BDYjV3aEpXcVdDNityTXZnRFVWbHpnTmQ0REZKazZGTWhySENL?=
 =?utf-8?B?WVEzU2phamFBZzFXSW02cUZuUmZSNHhSSnM1T1Rjb3dSeFNQbFZ2azV4UlNm?=
 =?utf-8?B?YnlHcUhMNlFVTWU0MEFzckU1WGdicFROU1dFN294ODdnZDZOWWxDSko1SUNz?=
 =?utf-8?B?cFpsU0QzcHBCU3FlRnpPSmxMenJGN0gwQTkvbFRtR1BFSUo0c0cySU1NWlZQ?=
 =?utf-8?B?WDU0NjJzQXBPRncrSXpWSER6Qy9DMGFibHQzZzgvRFBYakdYU3hLb3ppUnQw?=
 =?utf-8?B?RU4xUHNvbWJhTkNwTlhSOTBUeHNDZDBQWm1HYXN1OEhEQ2JucEc4T0JnRENp?=
 =?utf-8?B?aUtSd0pOOXZtdG51RUtlcElPVFBqQ0l1YUlRclBGUVhudk5VRTZFNjlWdFht?=
 =?utf-8?B?dFRIeFZXNFl6Tnh5cUJjbUtDOVdEWjR6RHpBL3NTZ01tc3Y5b05hcS9JWEVn?=
 =?utf-8?B?NUtFVkdiOVNkdElUd3pIV0d6OWxGMnpBNVo0S2hwSGZhNitpRWR3VWdkWnNw?=
 =?utf-8?B?L1ZPM1RjK2NZQTVZQkhsNTRYN25KMDBxVVJXSzZJYnE2eTJ6WGZoZkRTUnRO?=
 =?utf-8?B?YW14aUlBQkxpOWU1T1RBdzlZeDl5UmtrR2xOTG9Zb2pYZFdjTEtxWUVZMzJ1?=
 =?utf-8?B?VWtsYVAzNnJxQjREVXBuZEZ3dktIZlpzUVlsWDJ4WHFRczdrb21wYmw3YkJ3?=
 =?utf-8?B?azdHZWFUQ3JDWXpwVTJXeHJjczZycE9oKzEyZ1hyT3dMaWlqY3VWMXM3M3JG?=
 =?utf-8?B?NDZkNVJkVTRwSGhYT0lReG5vRVhWMDhwUFNldHEyL2ZkUGNEdnA5OEVNRzNr?=
 =?utf-8?B?dVMxbklhZ2xQOVVibTg1QTZ5cW04M3VPS3c1U3VmTEx6eUk4WFZVM2ZsRDQz?=
 =?utf-8?B?YWM0TFRSMkZmRjR1bTJFaURqWldDYnlqRW1ZcXA4NDV5NVpQanZrQkdrMFAv?=
 =?utf-8?B?cmRsL3JTaDQ2dUJ5QmNpSnNPS2lIV3RCZ1YxZ3JIaTdSZG12NTRiU2tnWEZO?=
 =?utf-8?B?cFV4TUg0cTl0ZVdjT0V3WTVFQ3JnL2JWc09XUjBDcXUzaVhYMk9PQXI4c01a?=
 =?utf-8?B?OW51a2FrRkR5SFM4SHcvSXdhbXR1WHh0R1F6Sm00V1VmRjQza0E5SElmMi84?=
 =?utf-8?B?eWhIenZvV21BYkZSQjZCNSt0Q0puMzVQTHN5T21OUHZSQ3p0ZDQxaGo4enow?=
 =?utf-8?B?VVBsb2ZMZlJOYjhSQ1NYNXFVVWRLVHhDWDNWRlAxMncvZUFOeVNzT0VhZUt4?=
 =?utf-8?B?bEF4L09uZ2tmUTJMdkc2dTBSaGQ5andvQlRzSmZhM3p5cGg5YUFDRFY3dEJl?=
 =?utf-8?B?MlBxUVVBU1RrYlNCd0VLK3NmMjRIZGo3ZnRTcVg5bko3S1FCYms1UitHRENj?=
 =?utf-8?B?dWFpSTRhLzFoY2JSRkZBLzVpVng2OWJwb096NFF0Zm9XcGVXUTFJU3VQalFY?=
 =?utf-8?B?MHBGOVMzczl3aUoxanJlY2RuenFYOTJ1TjVjSWQvTHdleUMzWlN1REV5UDBj?=
 =?utf-8?B?SUVsaDE4NzVhMng3Y3lwNittV3NYS1N6MFRHcUc5OUFSM094eGw3TXFCTm9M?=
 =?utf-8?B?dDIrcjZPeGtkRzA5VUNGeXNNR1FFakpDVlh2SWtlakJoSnIxaW1YV2M1RGVL?=
 =?utf-8?B?Rm4rQlMwakxhVkxpVG5HZlhLL0lsTHlrcHFkanpMUHVtWE5qODJvTHA5SGla?=
 =?utf-8?B?cjhoVXhlU0RPam10Q3BzKzFUdllHZ3RicUowM3dDRkMxVUdtczBkSjFFeVZR?=
 =?utf-8?B?WmEwWGIvVkUvbjFaeGNrQmF5NlJsRndmUUMvZDJBZS9Qck5iSWRaUVgwWGFU?=
 =?utf-8?B?SDd0NUZHUjNYdXRnNnhrbVJNWHFicDIwZkN0Qnd3cW1vUHg4d2RSeHdXK1g1?=
 =?utf-8?Q?+8bEeRJFh38ENgRhgdMRdSz0B?=
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
	l2usToeR8D+Gar601tk7slwtQJhJOJJpzKdvxuP8tN6T813jelXiv2z7T7wX0G7kf8VXvuoSSGrwP+YjuX4OvJnq381KiBFwrX6xzZhiERfU9OOfvDtGJsdnTesWC5fTEKI403M6Y5cOqfzQ4sLeccSZzuPV36NW+YUZrLSxiPbAScur8tag5yWZ47YNmC6x5Tr1B9ai+tbKGsmjQlzTp5TC+4+G5VqhU83IvfqIvrZzTvbZ7Ll6xCBqJZpd/ZVNMCZKiXgKBgghPBCT2uJmBqGe8EV6CgxZkaxv+5QvD3EDW/gE39KP44szqwzKVbr4iA9NMhpp/K5sZO8cxKo9EuISWxQaMtW3cSav7pIO55kpyOP3ELWwSEHI36m7sWJmoWv3+zPUkswXpXCyqp1+ijDw1ohdjnV8vhC2mmG8BSl6C5qFzZHuOMjX3J2Mg0cigDeFCaa8So045Ot7QQKsWivu7fpZTGVi88Fyt035Sqv33SWxJBW/Z7Rga1lVCBV7CTME3It20Umc6iF2/AJEG9g9i/CkoadAXgAnMl/MF0g3Ouv17Ab1uzfMqK/zDIGJ3+coGIruxhY3UJM3LymCQ9tMHTkJvYdHVMEbZ8sfooSXgcVBbXNgMOD8ddVGAqBJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5ce94-ac2c-42ac-1e8c-08dce1e71f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 07:03:15.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF1UmMxUoSi9Te5Zi0gvNRyeiOaevREn7RXztEg/AU+wO+tSCcOtbF/Fad/9XcTXLBLAIcUwTYxhEIDiJHuEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8030

PiA+ID4gVWxmLA0KPiA+ID4gQW0gSSBleHBlY3RlZCB0byBkbyBzb21ldGhpbmcgbW9yZT8NCj4g
Pg0KPiA+IE5vLCBJIGp1c3QgbmVlZCBzb21lIG1vcmUgdGltZSB0byByZXZpZXcgdGhpcywgc29y
cnkuDQo+ID4NCj4gPiBJIGFtIGFsc28gaGVhZGluZyB0byBMUEMgbmV4dCB3ZWVrLCBzbyBob3Bl
ZnVsbHkgSSB3aWxsIGdldCB0byByZXZpZXcNCj4gPiB0aGUgc2VyaWVzIGJlZm9yZSB0aGF0Li4u
DQo+IEEgZ2VudGxlIHBpbmcuDQpBbm90aGVyIG9uZS4NCg0KVGhhbmtzLA0KQXZyaQ0K
