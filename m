Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862481AD412
	for <linux-mmc@vger.kernel.org>; Tue, 24 Sep 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201050; cv=fail; b=Fs/xQ7g6iMRIENMI4zr5+hsC23ang+LfG3WxoqL8/WN4zMhE6YcZu9s/XUDFr9RcPn47sji+xdGX5DqNlLzmVt5dvzQsVz2T6qhGE0iueSo2PcJ4e8Qmr39BhgosXGXq6zlR8ml8ixd3r0NCPDZADWOKilXdvW8GulxdS6WPxME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201050; c=relaxed/simple;
	bh=zYaVrLMj98BmeoSFoqJAYEhEaYjM2ehxoQH/SkrRcqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSHyqIZqyyQTO4W52JyeV3oTP3lCcN+U1gP1RQsE5ryd3wA5limYnn+o+KweDQLOAqWDp9Bo47jgFFhJocXm6r1HYbD1bzWvhiBeZGqG8Nw1FGUa9Ya4CDRoj1Vu4187q5OcDLizZqskYodlbPkvQSmCNLZcFXiVAtYEAhXpaVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IjG+o3kK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aHzzZP6+; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IjG+o3kK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aHzzZP6+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727201048; x=1758737048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zYaVrLMj98BmeoSFoqJAYEhEaYjM2ehxoQH/SkrRcqM=;
  b=IjG+o3kKx5CxhjFyPDgL57dKMoROVGCiseotBHJm8DYvRhQRLcdGNs9V
   f1KUksUQT8IwPtUioreOBDOnyFQPfB7mtps1FK6NCP5ovMhIiCzKvB5ks
   9VfLuPSqVNpFK5WGsJwBXlLhL+RzgiTl9R7cWGXILapm4Ge+0bnXYUB/6
   L3qF+PDhAQAY6xHqs/XS5fW6qNf7T8dr16LTLKjX8UZkIslzgae2iHSKl
   E5p09rWAvuPGmB/5Mdw4M8wUwwuNHYq+curLhmXvtRqG3ziRqlOn2s40P
   KXz/ogNKSPKEOKuw0AZNuXSTYvCjEYpBMtreprtPbQ90x77Rw+CmhVnOs
   A==;
X-CSE-ConnectionGUID: OStsMM+0T5+ehoXfUX0asQ==
X-CSE-MsgGUID: yEV5PCdaRMiHRrJL+UCosQ==
X-IronPort-AV: E=Sophos;i="6.10,255,1719849600"; 
   d="scan'208";a="28505153"
Received: from mail-centralusazlp17010003.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.3])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2024 02:04:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+nj8HhVt8s/4SzjWdpjM4FsUdbnylz1PL1qkpxUB4pSGAoI93I18FZRbaNZ4s6OvKD7dkgGn5Ab9eci99xogwH4UexOB50dMgmURJ3h+APkdcv0VlwIV+AnMfUdlORgVsKZ65WRuyUSXnOHEyjUkBK/FPPeWz1El10V0Mqg0mUhdtD7rGNxIN81xsNdUjQuTgLm18OKnh70JPdc++CiPRNvSU0I5/4FIP3rgVdHcOwtI7W/mbmA59FnzuKK0aH3bZjzngo3U9Wt8zWcIPpXfQfyjo3kUk2oB70Qg35/8Nk+HqwxaQ43Hr4Q+4K7WhI3i/rkjjuwf8g5vz0wZ2nWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYaVrLMj98BmeoSFoqJAYEhEaYjM2ehxoQH/SkrRcqM=;
 b=MxlbqOR9wtym3Am0VbSBYW+Yi4VXG+jO77PTHfyX4T912Q4oPCxVNJbg1ZpdH/IdCZ2mjgtbtKHsgoSni8tkp2cWp/C6vHc8Ksw3cURux5qW2K4yXsXg3U838LfbCNGuJ22Q+8PWKDmuC5qzMCZi9pV3Qc03yrDQY4FsrYpF+LGTO1X8qVewoLG41EoM7qn+wbxmoYXRX/7CV9ca8eFhC6VdZnKPrtxawJ0/uRbI6SeDX6T4u8KOb8UPpOnfAz5des09pL3AhvtJd5b1BRr0p4b/nTVxgL66uYNlzBLyKSydHXXJOXDZTFl2YKv0CPJD3lancgHnGFfr8IlRie+xQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYaVrLMj98BmeoSFoqJAYEhEaYjM2ehxoQH/SkrRcqM=;
 b=aHzzZP6+gvguViBmliqBHX7s0N72D/HoGX51vqY6VAhelc5gl6SEhSy22/C2Yfrxqr1WbgVlj4dWSfb7GP0AWG8towVTVRfBJDNzgFWJRIe1IuhEgR75d5jHAAkzoKqfKQ/pjDRM45fz9ljCANEHnBczPGtTOu1pXIfHmftzpcE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7155.namprd04.prod.outlook.com (2603:10b6:303:79::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Tue, 24 Sep 2024 18:04:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 18:04:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>,
	Michael Wu <michael@allwinnertech.com>, Wenchao Chen
	<wenchao.chen@unisoc.com>
Subject: RE: [PATCH v7 00/10] Add SDUC Support
Thread-Topic: [PATCH v7 00/10] Add SDUC Support
Thread-Index: AQHbAdj4vMM0vFxPGUqJsXBRXsqJYLJPRK+AgAGWXdCAABuVAIAWXc8w
Date: Tue, 24 Sep 2024 18:04:04 +0000
Message-ID:
 <DM6PR04MB6575AE090B4E4F14DAE2A209FC682@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
 <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqJaAob7xceSkNe3aNogT55OoY5WRdPsFs450Sy3GhM2g@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqJaAob7xceSkNe3aNogT55OoY5WRdPsFs450Sy3GhM2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7155:EE_
x-ms-office365-filtering-correlation-id: 666dffa4-f6c8-4530-3f3a-08dcdcc34722
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OE5lRi9reHA2LzFhVVMwVmpjZFJaSG5NOFphUDR2ZWkzdVhJY0VhWXZBWmZY?=
 =?utf-8?B?S2FRZ29RZWpMSUh6T1hMRkxOak1HTnBTRHB1aTk2azZDZ3lyVjNwZlEwSkcy?=
 =?utf-8?B?WnkwSGowdFQ2Qm8xZW10UVMxVVhmcTZIVFEzT3VMdDNPUWdIZ2ZyVnZjNUcv?=
 =?utf-8?B?aWNGUnM2dm5UVHJ5TFpFM0Q2enloMHVTS1AzQit4azJZUnNLQ0xtUTZad0Rk?=
 =?utf-8?B?STNYald1NDJSanhKYmRZdlRNZzhxRS9WUTN1clNHNmVQMG02bEVoY2JVeGFE?=
 =?utf-8?B?Uld1RGN1OEg5WkdDaXkvMUdXcXBNU21KUmU0d2w3K0Npdk1PVk52aDlzNHNw?=
 =?utf-8?B?dkgwZVJTNVJuVWtDVlhyTDhYdXgxckxGdGF4VHc1VGUzcWZkUDlVN2hCM1NT?=
 =?utf-8?B?anVSU3ZpTmZYQVhoLytHYXZhaTI1ZlRhdzJrM003SUFldENBQkVNU01GVHZR?=
 =?utf-8?B?R1JsY1FKK1FpSzJsdGxieS9pcUtDK1NSVm1zT2dQVEdMWXIvRDZKL1lKQ1lk?=
 =?utf-8?B?ekRmWW1vM2MxNTh1cFdOZ0ZZV0VMb2ZGaWcybWxmUzBvV0ZVSUprWEduQTJv?=
 =?utf-8?B?cmNBSk5hVzJIcUc4Sy9UMXNKM0V4aFJudE9xemN0eS9oU1AzSmJUMHhrd2Vk?=
 =?utf-8?B?Qkx0KzloZm5jNkFHQ29wMTd3dVNMd1lyMGlFSVl1Q2t0VkFJVlFpaThxaElJ?=
 =?utf-8?B?UGJIVVFrZ095bWJ1R2svL2ZBZGpuaTBCU1E2WVRmV2xGRE4yNmVTTG1WVG9Z?=
 =?utf-8?B?cVlQcWROWCtJais5UWlJTnRoYnFaRmFLQzdaK2VhenFGa3hUQW9BZGNnQTRu?=
 =?utf-8?B?c2NqRTgxKy9ZZ2F0dy85eHRCUGJwbksrNzhOTzdsS2hFN1paQlNGRTBDQmEx?=
 =?utf-8?B?SkNlS3Z3ZXh4WVNtN3NYTXRSRlJ0Y0xGM0hraGZ0UG1veHVrSmU4OTFwOW9D?=
 =?utf-8?B?Wnh6NG5iNjVGR1VaWExST20zZnlQemRwK2hKWXBreWFmQjY5M0xlTzBuYVoz?=
 =?utf-8?B?WGVRQlhNNktXSzE3S01TRU80a29UUmVFSVhLVkU5aWczcS83KzkraU1uNWhX?=
 =?utf-8?B?eGtrcnpyd2JnZkxRY3RTWEZ3blJBVEpwS0hJZ21YUms0cU5ER3VNdTM3Zm5o?=
 =?utf-8?B?cWI4TlFXZ1kvNlorYktmS0VGUVhORzF5SHNCNEVXblZ1UVRTVzM0M3dhTmpE?=
 =?utf-8?B?cWJTY2NjSUduQ1F1YWJRckV0S2hRUC9xYlZIdGZzVGhHcUErM1NaSHRTK1Bi?=
 =?utf-8?B?ekFndEQrR3hWeklJenZTK21obkhHU2hxSkt4c3E5aS9nMXhmUjNFekFUaDg2?=
 =?utf-8?B?blRveENZSldZV1dKWmlLLzZoYlZPeUt1dFo0MkdoaDdUeitHbVhhbFNHUmRM?=
 =?utf-8?B?MlpSQTBGNTNIa2s0UnV5S1NkdlVsdm1UemZMd1FZMFBzenZWc1d2SmloWGJH?=
 =?utf-8?B?Ulh4WHFVbVVuZmRRRXBOaUlyelV3bDNXbllTVDRyZzdJKzVWL21RYlFIVHdr?=
 =?utf-8?B?Y09IQ0lCZmpVcXBxZlpFTmRYeWlzTGw3UEFxbXJ2ZDB3SjBLdEtyRHBCdC9I?=
 =?utf-8?B?QnJ3L2E0bkVPaG1tbmVjbkF2Mnl6ZmFJcDF0aUpxL29Kam9xZWtQeUp5b05Y?=
 =?utf-8?B?ME5yQ2psSjM1RmFJUGNBN0V3cjFHT0NqMDJFK1lwRmJPQlF3QkVuREFWVC82?=
 =?utf-8?B?R0pqMnhubWNsQ2lvM25VTll2clh0M2s4cjU2Vm5BRU41bzdOUEdxZlIzUG1V?=
 =?utf-8?B?ZHo2L21SN0l1ZzVBVGRaSzJ5RWZqZXR0dnozOGlyLzlja1kvMU5uVEFpeEpD?=
 =?utf-8?B?RTcwVDhiNGhkWXZvRW5HSHc3ZlRHYW9aenZmcTFVQnp1ZXRzTkZibi91d0Uw?=
 =?utf-8?B?MVphY2QzeDU2YkhnZmdwSDR6ekl6WEFQOXp6LzBwbUN1OVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2pGVGduUWtOTjgrK1JiaGwwMDZ5OU10ZkhkcGMveEJxUmtmcFBXczcyWmlO?=
 =?utf-8?B?cHlBV0pZOG9DMEI3dFRDOWJVVGo5bCtsY2x4NHVHRzkwcEZJQkxPMllHVCsw?=
 =?utf-8?B?TzFWL0FXUVk1bnRONm15ZXVTcU0rcTNZa0RsQTJISnFYaGdlYUdJcm40S2dy?=
 =?utf-8?B?cmh5dWVMWUszaXJjWWtONXdKT0l5M3gvVyszTmZzcmIzZnUxa25RUnVVblFX?=
 =?utf-8?B?TE4vdytySkZkL29IaElFMjJzVjkzQkpVOU9UMWtTUFg5c1ZnVFBxSHpwa0hK?=
 =?utf-8?B?N0k3ZkNPVnduaUt1cW9wbDd0S1djdVBsd2c0Z2QvdjMyWDJ3Y2ltZzNsQnRS?=
 =?utf-8?B?UVJ0eENsQkp4cTZ6NHVldmZOcXRwYXNsMFJZUUh5dlZCOVNPODBwMVcrd0Zn?=
 =?utf-8?B?Tm9iNHQrQVdYcEprODl5Q1RML0o5cEFhQWJlYnJxVHB5b1p5VDR3bjQwSm4v?=
 =?utf-8?B?UTFob2NLaHV5SWZsVDZaZW1NVG1PYm5vNHVCOEVLTWJXR2tXcGl2WitsV3d4?=
 =?utf-8?B?VFlGWHZHS2hxL0VEdTUzdnFpc0FXOU85N3BaeHhFYzdoTWROSHdOa0F6RVA5?=
 =?utf-8?B?K0VKRTNQd0p0YVNlVG8ybEVEWWxBc3ZLaDVjcUVSMHVIbW4vMXpZcE1QT2pu?=
 =?utf-8?B?N1EwUTFENWlMaUUzajVicDJiTUd4R2JHZWlqYkpEeGREZk5hOEhhZU8zU3ps?=
 =?utf-8?B?TzhNMlF6cUprYjl3ZUphVmtpTEtqRWlRRW80ZzhOYWllV2tSTDMxV0lnU3di?=
 =?utf-8?B?TDNBSFMzcVdYMTFtNCtDLzkrYVNyejcyYmhiLzVrOGY3c3RkMkJOYXowNFBV?=
 =?utf-8?B?aUFoYzdTRmQ0bW93ZXU0S2dBZnFKZ3MvNE9IRkZmTXZFUW1XU1NCcDBRK09O?=
 =?utf-8?B?NTVRdzZDcmJoRC9ReW5idDJITUR0TUFXdzBmdmgrRVRDMkdzNUlXTVllbzRi?=
 =?utf-8?B?b2tBQjVHYmpSdEtMS25MQUxyelBnNzAweG04Y0JFeGNGZzVCRnlFY1ltMS9D?=
 =?utf-8?B?NlR1LzhuQzRublZicEdGdkRjZVRMa1RYQ09SYXpuQVlaSDN4djR6TEYyckx2?=
 =?utf-8?B?dGFQQXJlZFU1Y2lQM0E4NXJHTTFmTVFJVUVSZ3NaZDRCb3VPOGU0L2dOaVR5?=
 =?utf-8?B?R0Q2SlIrM3FFNTdXZnRSOUJucXZac0dFK2VvUi9EeGdSTGpkQXpVTnc2YU4v?=
 =?utf-8?B?aGVSOGI5aTV1aGFzVHBwSU9hMnBOcTM1TGM2TkhicjA3bTlTZ3R2VU92emZ4?=
 =?utf-8?B?WVZDTXpjc3JQckU5bzBjUTh2Z0ZQM3B6N3A4TnpBQ0x2NW8xZHd5bzV3UkdR?=
 =?utf-8?B?UlI1US9Lb0dPdWVKRS80cDNhdVJpQm00QlNhSE1ldFBHSXMwdENLNE1BL0dC?=
 =?utf-8?B?dDBoaTR5MVc5d05PSEhWSkNxSWVmV213SHpVclZERjFoVjRhc0JYYlFlNWdR?=
 =?utf-8?B?aVRXMTZLMTk5bllmamcydThEMHEvTm0wTW5PUlMzZmZBVklIWHZNaEsyOWxF?=
 =?utf-8?B?V2o3QzdpTXZlTnBJeFoxOTM0M3V1NkdDdW1kczFwZXpzQWlTTXdSQ3paZENo?=
 =?utf-8?B?ZEZzQ0c5cy9BMk9lTllyb05MRm50NWpEbEZ6UnVtbFBlRHpnN3NVNDF1dFFn?=
 =?utf-8?B?SUtzK0JOZUtDMGlGaGVRQXIrSXV6R1pCWTVFYWs5bXlMRGdDbUNIais2SXNx?=
 =?utf-8?B?aEcyTWtFWnpLTCsvckZRNE13UWgvYmJGdWNQc2h2OEsxY3VBV0dMRnVnVkUv?=
 =?utf-8?B?cmRUWTlMalYwMlhkaGljNzZjaHRDM0JVUklWSGdtcS9wb1lSN1JsUWlCTjVM?=
 =?utf-8?B?dnJ1VnhIMUt4ODI1YUZoWUhpTWtTcFkvSTFjZ2llbGplMWhsTnpuRkFaSDRp?=
 =?utf-8?B?cWpDTWZmMExjTFF4Yi83NWxyMFRkNStCdnlpOUVKWmZKYW5mUFprRVJjVGR6?=
 =?utf-8?B?R0c4dWV4SXdIcCtHZ3VLbVFtbEd3d1Y1S3BIYThEUkNNRFc4NEprY00ranEw?=
 =?utf-8?B?dlhjT0NnbzJzcHRnTkRQK1Fybnh0T3FLYWg3NmxLWlBVR2srRGVERXlHaFpD?=
 =?utf-8?B?dXg5RDNuUTF1U29GM3VJcE55V0VsVys2RGYvRi9yZExxQ3hOZ3JVakhQZ1Bn?=
 =?utf-8?Q?7ueLGYH4LGjIKB2JLqYmmBv1w?=
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
	kw5d8vo/sWJYtot5Zkv2wALy8J70wR86+iDv2d9kVbyJahr9BeGcFZfRMZAaPCV8kHWxH4aGXZxuxF5GWThgsNn5emgXoNYNdYyOT0I852mlEdFbbpI3J/wGXpoS3mmsPeOxzBuQ4+bLwHsBigYOfkEBqRR+0Nkl14ShEWZ8Izn2YJbYKy4OVXLhbI2uC9VetzpBBTRzeB8JZsmvSwsm5KZllwxirENkwHPLsrJtM+AGTTPb/ryqRvNWmWnhpvjSUYUg0MEfobYb5PDn6gp6bwsRT69v1Jdol9x2CGDbHldAsQD7wzBBTQI+8jfmg7iJwceeXGFp+VUOe0VSjQWVFa5mV7iHbPRAuD6w2LVAxrYcJkspaavE+frz49h352uTh9nFTCXK4wHQOMxPTBOpHDX/ja9Fa3APn1JV4fCh/fd4Qd783PNMF/IO38OY7yVk9qC83ZTIFyjXMu8Oc3/VDDDRLuo1YBI4ttsxjOvhLi9byLUJ06kWTdLBQbA10TRZ+TElRUlNcDxkRJ0Kg4ccKu3CBg4gE3zWZxyplVt6nYf9G9yH2H7nH3Lu6bqLUvYUGHBS/4M4lbY/QNy+ltc7AEpubf4v/9khVG03n20OmQI69QdRLJxRZU5jQrJJ8lcF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666dffa4-f6c8-4530-3f3a-08dcdcc34722
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 18:04:04.9770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljXbg+hxELgJ7qdKwUuLtNsi9kiGDaAX3jLKyetv5BWSFKyMSq7tgW1fxim1m2D2WC6D0hMezK5oeTYnXQj/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7155

PiA+IFVsZiwNCj4gPiBBbSBJIGV4cGVjdGVkIHRvIGRvIHNvbWV0aGluZyBtb3JlPw0KPiANCj4g
Tm8sIEkganVzdCBuZWVkIHNvbWUgbW9yZSB0aW1lIHRvIHJldmlldyB0aGlzLCBzb3JyeS4NCj4g
DQo+IEkgYW0gYWxzbyBoZWFkaW5nIHRvIExQQyBuZXh0IHdlZWssIHNvIGhvcGVmdWxseSBJIHdp
bGwgZ2V0IHRvIHJldmlldyB0aGUgc2VyaWVzDQo+IGJlZm9yZSB0aGF0Li4uDQpBIGdlbnRsZSBw
aW5nLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
