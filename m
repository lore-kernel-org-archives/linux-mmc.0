Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBB944E
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657170; cv=fail; b=VVOGgDFK20RYh96mCBoj+Ma5CkBFYuqOzUsGDlXqtz/oZpe2R3siV/W1uOixge1e/0W5cM+PSXWw8UX/bE7TB/Xs7mQyAAWyV43dT56H/EWbqRfxuNNIFdcdjeZmfUrY8YaFMHIDFZYc+e9WTFeEk0lNA/umANJl5Es+385VHFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657170; c=relaxed/simple;
	bh=AAE0d17R3SS7fAdVVBQnPvv81KFr73LDQ+OgrpmE8wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ojbuQtD9sfFkeJP0u/gjhAn1crx35oZbkDxR/CrPJ49sYNVh2D5fvto0EG5Y+jbdbQASulH9C1B8zbTUl5YPN92NYlH4JEWR9QgpSTHjr80JikwvAi+XhCpSbplmG4XEKdbBGhIew6WdCMDl/htMMXKWP+O4FzccnXM2gNAWChg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K5lC9HOG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WDcB/LHK; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K5lC9HOG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WDcB/LHK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724657167; x=1756193167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AAE0d17R3SS7fAdVVBQnPvv81KFr73LDQ+OgrpmE8wg=;
  b=K5lC9HOGog+N78DqCKl2mhTnZm1gZWTsO9eaTbnLpaajQEQOU/POFTFZ
   /UNafUh91qVFMHrpeR0UePu9QWHbahMCRmDXYCSZCoD2DzhkAG88HyVWr
   jERsIejRjFyyP2APlhyQTbuJ9y0chKTrwkhz2QIfghHMzwrHzr8Wugv2R
   kyxZvvBpN4bcH7MSgxaV6+xdjh1B7QLWVCrzEIJ2RGXAh+TtO7naQbihS
   TocqZd74gglNg2siLOh/3NcpiSZGm2sLeI019aj20DLQLzExSv60nbFI7
   ajSCM68yEdKE9fW1YbuDpY6a6CjG+H5abV0mtEAVH00+vECikArcV4H0f
   w==;
X-CSE-ConnectionGUID: mbC6SVzuT9KbzpbExArqrg==
X-CSE-MsgGUID: gU4U/LMlRUCeVo4hsqTNyw==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25949140"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 15:26:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMIg4gb6DUVaWxfDfkdcwotehZJYTI7OuYBcCqfs1oCrALceJBWdLFxDLF0p4I8xEtMdL6QikBmvR/NBbyZYhnLhe8jvvmMNvR9sg0qFfebwPHdBOnk4jpx7I54y8B8KaZU/Ds0v87z+O/WAJToSKaDyxQX0ZtOd8M4MltKEcHsq7gg4Te33JbyJq0BbzfWbFeEHs2v0m/xmLWeTyvUDQrHDAbdg2Oi9bWOfwPX7S9wJBhLOadIxsEfjvQYqDO7TdVjUAUtXy1muuJAOii/YiqkjEVVUTn+eISFkz/+CSCFhyoAg5BsMISgSChYW3lulkdCLk2ZjLmESNTCVV3f+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAE0d17R3SS7fAdVVBQnPvv81KFr73LDQ+OgrpmE8wg=;
 b=REk/dQM3jgmNmPO6l9u5dBPAY7oNxgvEq7elsXe3kAfboWM0niirRV10I962lKB8/6VYXewAA9RdJLcT0S+20ysXHi7Rt99PoOnuw90a/ZTRQtSAhZSSKmxugK1+RxHTuAgWQOh60EqLVuSlrYO2jCGj3a0ra9A5PgbqxXlrBE4WTFBWZbDtxEQMaQ/YyDddIpBR5WSFw+Ks7hyJcHGqbmBTYNutjhFRxcijKaHI3okV51eTPc0H0k0yZtRUXRLoUsguMC07J9YNCHJ5mHm7Wd6UgFBmJ/2RHxxkSS5u9sV1ie1V8rcxaGV34Y7noyZ0YL8+XQWviueKSQCqYtyaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAE0d17R3SS7fAdVVBQnPvv81KFr73LDQ+OgrpmE8wg=;
 b=WDcB/LHK742hXokilU2+NMrOPtGaKdxveb4IHupCZSSyJRJG35YCBOJ+CvhHPdNFzQl5k/6Kvi9CxBTAz/HVwvVgQ/vluPi/4kcbBXJZWMD5LAVXs4nFycGH02dfvGEV0gWs84cRK/HxjFuly/gWPIo6Mz+g2PP+V9BmpdfNUaE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW6PR04MB8843.namprd04.prod.outlook.com (2603:10b6:303:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 07:26:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:26:05 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: RE: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
Thread-Topic: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
Thread-Index: AQHa9sKKQsTDeM+JmE6NeIZbweHgSrI5FpSAgAAKakA=
Date: Mon, 26 Aug 2024 07:26:05 +0000
Message-ID:
 <DM6PR04MB6575F070F4F18224617209EAFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-10-avri.altman@wdc.com>
 <9e2bf183-17a6-42a0-ba60-4a2384e53ca8@intel.com>
In-Reply-To: <9e2bf183-17a6-42a0-ba60-4a2384e53ca8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW6PR04MB8843:EE_
x-ms-office365-filtering-correlation-id: 289b68a4-4930-4ce3-f38e-08dcc5a0588c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWRaaW9HNkVLbTlIWjVPKzRjY3Z3ZXRsejNxUjVtaVNmaHZGUVV2N0MvcTB1?=
 =?utf-8?B?NFR5RWdxREtMTEd6WlJObmFDTlpsZWI2Y0dVZnd1cE9wTFA1T0MrYSt1Q2sw?=
 =?utf-8?B?YzViV01ZRkp4cmd4T0EySTdqc2ltZ0Zqd0owck5hVGludEZHRVJBRHZzM1ZB?=
 =?utf-8?B?UEpZMTRZUmJzVkE3bHFZZ0lpV3VQNjd1Sk9vbUhidVVVV0pySkFUUCtQRXN6?=
 =?utf-8?B?QXU1ODZDL2QzdDJNV1JFeENSVHlIeVJ4OFF4YW9sVUpIVzVwSnRhbldVOXhv?=
 =?utf-8?B?K0hTWFR2WXoySk16Y2tnckMzVDduZHFZUkZsWER2Z29DSjdZVDdxNFhYYzM4?=
 =?utf-8?B?bFFmdEE5MS9SU01IaS9hRHhUOXlNWlgxZ0ZFZXJVeTJ0Ym10N3h0WnlKV2JY?=
 =?utf-8?B?aDBKQzVPUFJDakE3STY3aVIzYWxTNENyVklIdk9NemlFSlhFSm9TZE01Mkc5?=
 =?utf-8?B?Y3ZNYXNVY2VEaTRoSDdnWUxaQkNaMDA5Rkh4Vkd2SiszZ0tXc3hDUkc2ek9J?=
 =?utf-8?B?YnBPenhlV2NKdkJuVFZnYlVQYTN2VDVhSGdMYit6Rzk0QmdMTlNya0xuWG50?=
 =?utf-8?B?TmZiZGhIUUxLT1drVzZySFpza3FVOEtlY2FPL1FvTktDNzVmMDRicHI0K21m?=
 =?utf-8?B?aDB1c2pvekg5WkNHWXZwcUx5SFRxMHRUYWoxMVZZSGdoblBpV0hCQ0NXM3hH?=
 =?utf-8?B?dEpVSVg3RGEzNmRYTVl0VUg5c1ZLTmxHeS8xVW90dTJTN0ZDYllMUVZqL2Ew?=
 =?utf-8?B?R2VBQ2VjNjZsY29vQ3pvUkx3UDg3S2xPQ3lhMHBUWW85SDg4dGhhcDcyYWxy?=
 =?utf-8?B?elh3a1lVeEFJMTBIL2lFUk9VNTYwbXU4ZGppN1VMQUcxZ2JLYXE0TVN2NGo5?=
 =?utf-8?B?SCtJa25NQ281d0c0Um93OURDd243NVRUZEpMU2JodlhoZ0hjWVRLZXNyZTVp?=
 =?utf-8?B?Z1NKSC83YXNRcjM5Z0xWVG9NNnNKU2x0ZEpJVHIySEhucUhGdkNqUldXb1VI?=
 =?utf-8?B?WmxnM2VOZVRxT2RGcFo1b1pFWTl0LzRTcWFtOWZYZUtueE9VN2lmY3ZGeWo3?=
 =?utf-8?B?eUhvUkx4WE16NVk4MDljd3pkamcvYzk1ZCtUbC9YaGJrR25vY2wzSjRjUnlD?=
 =?utf-8?B?QUlWYmVhZFJCUlBaRTNtQkpwYmh4Y2FFQ3pzU3VuM0xtZVZaMUVyMXRNN1Fy?=
 =?utf-8?B?aFZPbDVOS21qVndNRzBVcWd2YkV6VE43b3U4OEdja0VhZ21LdmdLczVjQjd1?=
 =?utf-8?B?ZGkycVhUZHZuMGVXZjFTZzdwVEJCQ3h4THdXUzNoc2l3TlZhcEJOS2lpQ1l6?=
 =?utf-8?B?ZkVxZnlhRnJUbkJyK3N4QzdFcEZHN2U1dkgwYzRaMU1iRjVJK1NoL2ZqVXp4?=
 =?utf-8?B?M25RdW5KSzFGMXBXTndmYlpSc1BUUkpxaGJKUXEyR2p6bzRCbUNYc09XU1pD?=
 =?utf-8?B?YmlQTGxiWjBhQXIxcjV1dkxHUEhXNFpOb29LY2tHOEE1dXB2UHlUSjZvYmx6?=
 =?utf-8?B?MXZXeUUvRkFOcTl5cm41N2hBWkgxcHUrN3Z0NnE4UXZ6N3lweGVFMFdYR1pj?=
 =?utf-8?B?cCtpOHJNc0xpLy9rd2hVMUlXTnZxTjUyTUkxZlJmMUE1SGgwOXpWdjB4aExp?=
 =?utf-8?B?NEcySjBEWWM1NC9LTFVyNXZCMktXakRpRGtMVXpxT1pMWDRQVEdNWG9RbFdP?=
 =?utf-8?B?NjF2SEpaQTZ0bURRdUlZRWdVY0h3SnhZN05GR1ZEUWNrVTlsYnRHdk9WU3Bo?=
 =?utf-8?B?Myt2NytSVDhyRjBpVlVCd0p1ZnpoOHBDMDV5UHBXSzhrV0l4S0lYdm1DWWQ1?=
 =?utf-8?B?emFSSHppMlB1OUI3b0hSK3k1ZHFRUWRuR285TEFEYlhUUVlidnc1V0c3cWIx?=
 =?utf-8?B?QzlkOTRmOGRmdkZVU3MwWTNZQ3lhMjNlMmhCWnZ2V1B0RlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXc2MlVKZ1IvT05LS29XTW1hTzlpb3UzTGx5MXU4NXVyWENNWkVhNkFkSEJF?=
 =?utf-8?B?dFZOY2ZFTmN3a2c2bHBpYWI2bExjOXUyakdFZnBsa3pzODV5RThnRWxnMWJR?=
 =?utf-8?B?bkgwdlU3Zmw4YjE2M2dSQW5Meld2dys0bk45akRKU0hvRWVUVDVtLzZIRlFk?=
 =?utf-8?B?Y0x5SjMvb012dVVERXdlVW9XNmI4dWo4VFJ6ZDQxOVVqVU8yN3hRemRKK2xY?=
 =?utf-8?B?Unl1YkU2NHRHYjQyd2FsOWNMRWJ4QUxhdEJsQU1CY1p2cVZic3NyaEZ2V3V3?=
 =?utf-8?B?MXlHZm0yKzNhY1J5UjRqekhYV2FCdFdBRW9HM2pOTFZiQmVYZ3ZYYndFZnVi?=
 =?utf-8?B?Ti9pQ3ZjMFdVVkovQzFtd3ZWbGlKT3BVUnFHYlBqbDQ3Wkp2WDNJMDErZE9m?=
 =?utf-8?B?cTlXSjNUQ29MbVBjUlAxM2hyalQrcjc5R00rOHd2R0VrYTkvdjEzdDZPcEVV?=
 =?utf-8?B?OVU3ZGFpeE1vNkhCRkwwRmYwVkJrNzNsWmdSd0ZUeGo5VWgvZWxjdUpLanBa?=
 =?utf-8?B?S1BGZWFTSXBTeDAwSzNxWThXb3lxaFdwenY4RmplTXdWSEwrTEJyaktOS0h4?=
 =?utf-8?B?NFl6UGE4WXExOFh1bC9GSEc5RklKajlheGxmS3p3NDhKelVncnk0eW1Dbkhk?=
 =?utf-8?B?WWc4Tjh2Z3hoSy92Nk0rOVRJZ29udGpWWEJJbXd2STJSS1krSTYwQ0dnN29z?=
 =?utf-8?B?Y0FiQUhKSDIwYnFIemN6bCtvWDNDbWhGUURBT21BZkU0KzdhMGh0OVc1TzlO?=
 =?utf-8?B?SVNWUEI1TEdRWnFwVHZETU1wbVZpanRTVThqOWNyakgrSi9HMmNzcXZIKzVK?=
 =?utf-8?B?VjIyS3BXRjE0RC9rbXAxMHIvNG1QczhCMDNocFV1SzNEZitib0VlbzhHSmlI?=
 =?utf-8?B?TWZkZXBIbEJmRUhpSXgyZ0tNVFZXd0NLUk8zY05BYnAyRkRobEZteU9wbGht?=
 =?utf-8?B?Ulp0ZTJNK3dyTUpoQkN4dVhqOEI3S2s4Q215cGpoM2d4WTBRa05ISVMwZW4x?=
 =?utf-8?B?WUo5RzlVMUV3cWlSRWpWVzUxQVFzZ0tmRzVmYytIWjJyQzF4bmZCbTB1YzBw?=
 =?utf-8?B?cVZUMnVUU1pYRTRkYzROQ09ienFuQ3kzc1piQUQ1WkNhYjJmWjBBMzJSMytM?=
 =?utf-8?B?bUtoaDlLL0pqOGd4djlGdGtoSzlhWXpwWENUWDZCTk1OQUt0dHVIZE5RaHVU?=
 =?utf-8?B?SWpVcVFveVozVCtsWCtmWDRkNHVJRDEyTGpwbUFIb05DY1JCU1o5TFljKzc5?=
 =?utf-8?B?eG52MzJuQlV0K2xSaUU0MFlNbGJ0OFZDUGNJU2ZPVGNrc0ZBUXdRd0tQTlEv?=
 =?utf-8?B?YURYUjgxWW9ORjhTc0QrbklDQnN0NWZYRjh6aGxFeklFZUVwZHdBTXVjTVVj?=
 =?utf-8?B?MCtoTVc1bnRMbGFkRzlaUnczTVdBQzlJakQ2NTRqcVhYVTlVT0srNTV4Y2VJ?=
 =?utf-8?B?c3NzdkxjY3BHbmJuNncrdUd2ZjViemxxcHdaSXdUa0twOXZOODd6ZC92a3Bo?=
 =?utf-8?B?aVBHdHQzcmRxK1plMnhFNDdCV2ZmUUVEMk5sRnRPbWM1aE5vUTV3ZWJIZGlv?=
 =?utf-8?B?NVhMYkprNlpiNkpCbEhrd0drUEFrSkFTVnVBQWR3S1lZSmhWRGsrVnJhdUVo?=
 =?utf-8?B?VFJLUTFCUlcySHZ0em9sQjgwMkRLQkFEdTNha29qMGVoSUlxcU9lYkpubFg0?=
 =?utf-8?B?aGZVY05jNEV5M1EvT1BwbHFJNktNZDEwMTErbkFmOHJraWUwOUtwTXpudkVV?=
 =?utf-8?B?TVlNZHpQOXF3d2s3Y2xvK2dXK041UUpjQzhrS2J3TXY2eVlldnZXeEk1MkpR?=
 =?utf-8?B?YnNEaGZXNkRlYVhuWTVpL3h6ZVF3djlpc2tIN05OK1VIZHZDMjJCRkxEaktt?=
 =?utf-8?B?NndnQkRtUmlDU3dvWUdpQ0c2WGp0WGFtSjM5RWtZUTVUNHlVWGVndlpkcFhK?=
 =?utf-8?B?enBjSlV2NEhYbVFqMU53Tk9xejE5bTYvbkdNZkplUyttYm96dEtneGlGOXlw?=
 =?utf-8?B?MWlORnpyVXIwOUJEMkZDUXhjTldvREdjbDhtbFM4Vm1JMXFrR1R3OGVPbno2?=
 =?utf-8?B?QzVLcVR6c0Z6eWFqSUc4ODA0eFlpY3o3bEVwcHNnZzA5K3c4bksxNDZrcFps?=
 =?utf-8?Q?SWf7UGIub0ZmLGKfN8CeR6v+y?=
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
	fGyyxuFLP28PbmN0rzNLWpXjvB9GDix3kXsDnysHwA2yK9uA2F4jMX6nVvYR0fKO29GEnvbU/IB4icQ+xbmhJpyTtwGm7+RIpvZCzpIQog/xGsOV2ZfDrHou49ICKkFiLxpio8zQyvRS+rwFq1V2AJIUsWvXjq3QTJ8IBJLFcreFpT0amVmXNd0cx7CZrwyum1SXEkXR3KGz/GJmvFVlbkDLCkpH6+pkyDh3A4XXOy2W6yFQOYapxbhnxJnhM7cZxrttPiEfUzelNYxAGL2WlIt/y1U1omJd+dOGWEF9VdwX57OigdMRPDYTn3/PYrAoz4EKFWIVzj9USFxU2BcIpCDgkgy3VT9UU5h9zsPtO7+IOe6k3UB43jWHnAVfqGyOkMQuU5JcHzgxPKQASHR6PhyBUjbUgkR9dyhh+9ULglCu6ps/F4GH1AkpVtqv4wvHYyOJdZncTiP0eV5pKoiHTfJSUX4ReCQp5ZU83KeLS6FB+1+Kk+RyDMbWLby3hVCAeaeE9JwkDg9kVf2BcbXiyzy7LGfRdcx/Be314XA1BmFo5pLLUUB/Y2fO6JXG3+8WWXX0VotKTx3upNHcpChfBcPORTScEvZ7GncID5+5Pylg+QryyUzB5oTnmLCLMlAI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b68a4-4930-4ce3-f38e-08dcc5a0588c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:26:05.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ymEaOf7vz2g0XQF8SOXHAr8v9xth6lAwWlAAyEIaLsvdBjo4TWu+MK1XBLoPeWVzhjoSFbR9AzmG3rsMCcOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8843

PiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogU0QgY2FyZHMsIHNwZWNpZmljYWxseSBoaWdoIHZv
bHVtZSBjYXJkcywgZXhwZWN0IHRvIGJlIGFsbG93ZWQgd2l0aCB0aGUNCj4gPiArICAgICAgKiBm
dWxsIDUwMG1zZWMgYnVzeSBwZXJpb2QgcG9zdCB3cml0ZS4gT3RoZXJ3aXNlLCB0aGV5IG1heSBu
b3QgaW5kaWNhdGUNCj4gPiArICAgICAgKiBjb3JyZWN0bHkgdGhlIG51bWJlciBvZiBieXRlcyB3
cml0dGVuLg0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAgIGlmIChtbWNfY2FyZF91bHRfY2FwYWNp
dHkoY2FyZCkpDQo+ID4gKyAgICAgICAgICAgICBtbWNfZGVsYXkoNTAwKTsNCj4gDQo+IFRvIGdl
dCBoZXJlLCBpdCBzaG91bGQgaGF2ZSBoYWQgdG8gZ28gdGhyb3VnaDoNCj4gDQo+ICAgICAgICAg
LyogVHJ5IHRvIGdldCBiYWNrIHRvICJ0cmFuIiBzdGF0ZSAqLw0KPiAgICAgICAgIGlmICghbW1j
X2hvc3RfaXNfc3BpKG1xLT5jYXJkLT5ob3N0KSAmJg0KPiAgICAgICAgICAgICAoZXJyIHx8ICFt
bWNfcmVhZHlfZm9yX2RhdGEoc3RhdHVzKSkpDQo+ICAgICAgICAgICAgICAgICBlcnIgPSBtbWNf
YmxrX2ZpeF9zdGF0ZShtcS0+Y2FyZCwgcmVxKTsNCj4gDQo+IHdoaWNoIHdvdWxkIG1lYW4gdGhl
IGNhcmQgaXMgbm90IGluZGljYXRpbmcgImJ1c3kiLg0KPiBFaXRoZXIgdGhhdCBpcyBub3Qgd29y
a2luZywgb3IgaXQgc2VlbXMgbGlrZSBhbiBpc3N1ZSB3aXRoIHRoZSBjYXJkLCBpbiB3aGljaCBj
YXNlDQo+IGl0IGNvdWxkIGJlIGEgY2FyZCBxdWlyayBwZXJoYXBzLg0KSSB3YXMgZ2V0dGluZyBo
ZXJlIG9uIGEgc2V0dXAgd2l0aCBtaWNyby10by1TRCBhZGFwdGVyIC0gSSBndWVzcyBiZWNhdXNl
IG9mIHBoeSBlcnJvcnMgb24gb25lIG9mIHRoZSBlYXJseSBjYXJkIHZlcnNpb25zLg0KT24gbXkg
b3RoZXIgc2V0dXBzLCB0aGUgcmVjb3ZlcnkgZmxvdyB3YXNuJ3QgdHJpZ2dlcmVkLg0KV2hhdCB3
YXMgaGFwcGVuaW5nIGlzOg0KbW1jX2Jsa19tcV9yZXFfZG9uZQ0KCW1tY19ibGtfbXFfY29tcGxl
dGVfcHJldl9yZXENCgkJbW1jX2Jsa19tcV9wb2xsX2NvbXBsZXRpb24NCgkJCUNNRDEzOiAwOiAw
MDA4MDkwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCA9IFJFQURZX0ZPUl9EQVRBICsgRVJS
T1INCgkJCW1tY19ibGtfbXFfcndfcmVjb3ZlcnkNCgkJCQltbWNfc2RfbnVtX3dyX2Jsb2NrcyAt
IGJ5dGVzX3hmZXJlZCA9IDANCg0KQ29uc3VsdGluZyB3aXRoIG91ciBTRCBzeXN0ZW0gZ3V5cywg
dGhlIDUwMG1zZWMgbXVzdC1oYXZlIHdyaXRlIHRpbWVvdXQgYnJvdWdodCB1cCwNCkFuZCBmaXhl
ZCB0aGF0Lg0KU2hhd24gd2FzIGludGVyZXN0ZWQgaW4gdGhpcyBhcyB3ZWxsIC0gc2VlIHRoZSBk
aXNjdXNzaW9uIGluIFYzLg0KDQpUaGFua3MsDQpBdnJpDQo=
