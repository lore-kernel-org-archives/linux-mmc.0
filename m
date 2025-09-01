Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7C3064A7
	for <linux-mmc@vger.kernel.org>; Mon,  1 Sep 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749243; cv=fail; b=QO8qiwNL1JHqB8OJC12Z5Tgenm4X4pF6oqbxvD9Lt3Oy88Arb0bnxoSHv8JKOpBGpM+kSHvtb5bSzlJdlgd/Gdk1hcevL/kJ/j4qRO2Am/9/DYtvJ568U/YCT9MIGD18dbfpm81J4lnZrKZxSnakf7jfYl1umNDQ7K+qOi3gRfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749243; c=relaxed/simple;
	bh=EvToZq8D6w/G5tnFAY6I/JVIph2eub5gvQ1BVgX8yc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FV055CiRyhNryPk9fmRZOKG2guTKepl74dgIrp2vF3W3yb0AOygfAW5uzngAQc6p9DaVCqcqCRyb8H+RPWaNZ69zR1U+T+l3qWOLgDPKVh60axWlVBfy2cocUVimM/LCSXNi4geRqzyeFqkeZh1nQZy6czhiQdoWy3KAOd0fGvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=PGYJFOSt; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="PGYJFOSt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1756749241; x=1788285241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EvToZq8D6w/G5tnFAY6I/JVIph2eub5gvQ1BVgX8yc4=;
  b=PGYJFOStCeKCTasKARsm7ExVO9mufm/qNk3oquGQg4yjNySp1KmmER8d
   jld+8Ky4r3w78t0sAswxzwXKxd4bCAHDQpejKWgm73J5TpZlh2C9eN0tw
   L0v+HRREpo/SrVXeYNegnJN8QVUrQXiXx3BrNvMpvm1uyPVQdNBscJV7i
   M/sTgBMSPt8wVYheEuop6+Ko+3Qzb5XsDylylljyIhx6xEdGV712Hyndp
   OPuSqnm5ck75P2OolASQS4+uC+r/erE8hMDmzpo2cYddNIiTX6HDnt9fv
   X3lOWnqtMeZNjXTqbA2ID2NKmN9632+g+Sd7gy9XaM7N68Tm1HXEJ7vaL
   Q==;
X-CSE-ConnectionGUID: J2wvNagPQyGnkJE3EDOBfA==
X-CSE-MsgGUID: t19DE6m/RcaZbmhpr7PWCA==
Received: from mail-sn1nam02on2138.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.138])
  by ob1.hc6817-7.iphmx.com with ESMTP; 01 Sep 2025 10:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlXXly45vmu2H6TghcQNZ76XXJzFbtwPGM6VUgts5Y9RSirUDQtHxnJKsPOm8ktPQxjEsaqIFgGMwP17OQ8md9sTbCS9w9pomArnO1+yxvCuzNxIA7Bn2FtGph/STT06IsM0xP1mXMInMEgNlIgiyXPWXGBDHqHl/1VnFv571czjNieWPPp6e+o7CNggk+YHoCHXUDIhZFEg9Pv2FQTkNF+IAoKVOJxAA751MBSimAANxWED/8NZ6jHNkKR9sMX3YZU1824pDw+haeVLQFd+p5l+Je3V9+Yb9iR0zLXs57l2Aj9uczX5sMqfglm75u4zn8dieTz3/Xie6Vu2OHIY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvToZq8D6w/G5tnFAY6I/JVIph2eub5gvQ1BVgX8yc4=;
 b=jU2sGF0rYs07EIoHqj+w48XNT9+uy7WvgXhxkdKiNYPyvTDtJHfF/5tYxmhIPw1ZIqykjbqJJU/KfIACMi9NxuhwAifRCYRAYJ5mCWYbA/FYbDmLf8W1UoxclDcaZZWN/MWcD93wwkN+e4ej7Em9Bt4HYOumN5/kI7Wuj2YRtO4Q5Wyvlg8Rt1b5Gxx+pPQZkovdjXqdcmQhI6RoHD5+kGQgXt5J9RnAG754GipYdyEXO+FNkO4eFDW+y5lVF3Mm/LnCIB6t89qWxwTIhpGye56+Jy8d2+Nmm3kPUdF8IUgJO0lSkdKKCPXW+3eKv4nm/mGRKfqp02untUu4n8qmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA5PPFE6F70D378.namprd16.prod.outlook.com (2603:10b6:80f:fc04::925) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 17:53:57 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 17:53:57 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
Thread-Topic: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
Thread-Index: AQHcGyJ4+2gT7fMgeEaZfQh0Pvb0NLR+m1Ew
Date: Mon, 1 Sep 2025 17:53:57 +0000
Message-ID:
 <PH7PR16MB61961D92DC4EAF96C8378802E507A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
In-Reply-To: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA5PPFE6F70D378:EE_
x-ms-office365-filtering-correlation-id: 437fb342-ca69-4d13-c7c2-08dde980867c
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVJ5NmZ0UWxjVDFyQTlEOU91ak9KWmR1SWhFU05oMnlCK20wb1hocEpxU1hU?=
 =?utf-8?B?djJydHdOdThDL0J4M2NCVzNnYXJKU3hKNjl5UU00SlNzSVhodHNqNTBZT2hV?=
 =?utf-8?B?QmlOZ0ZJRGdwbmJyYXRKSlBBMERXdmI3R29qUVpnL2NQNmNCeE5xWWdDWUZk?=
 =?utf-8?B?eENNb09ENEF3RXdPSUxWRjFMSFRORW5Tc21Tc0toYW5vOG5IQWhqdUtCQVRu?=
 =?utf-8?B?YVlSMUtoTExkM1Q5clpwVnZoVVo0RXJxdXZBWjhlQno2TFdkREV6Q0Jjc1kw?=
 =?utf-8?B?czcyM09PT1pDbngvYlJ0Nmc1WnZtMklwcGxiMU1LdjNxSWxMWlM4SkhJbDcw?=
 =?utf-8?B?K0x1WHpmb3czSktLUzdzNFFqU09Ib2MrM3lwTWlwOCtSbVNSZENmemsvb1VT?=
 =?utf-8?B?M3ZlYm1YSUJoR1E4cVJ4U2dCajRqbFQ3dkxRa2tHK2tQYUpXQUxYcDBYZmhu?=
 =?utf-8?B?NFlnSWpvQy9palplb0kxc0pPVnJCdjQ3YjdnRExPNWlkenRpekUxQkxYTitw?=
 =?utf-8?B?SEViZ1d3R3BiTVhmVEpuOWJrSzYrdEZLNzlEbklUb3dKYlRDUFZ5YVZpWXF4?=
 =?utf-8?B?RkxWbmpFWmVic2xCR2dsU09sL2E1Smc4WkpvYWRuMUpiTmJhM251NytObG1O?=
 =?utf-8?B?Q0pFSmU0N1A2dHJYSVFMaXN6bUM1ZWZ3WkovWVc2Y1BaNHdpTDJpWGg3Rllh?=
 =?utf-8?B?RU9EVzdSWWQrSHRTVmVRS0owakVKVEgyZlNRR2VOeUF6bnJyK1QzZjY5Mzh6?=
 =?utf-8?B?cG42VzltRWRheTd5OXBXV3NUWjlLb3JBTVRleHVUWnowNURaeklTODJJSzdx?=
 =?utf-8?B?OHpvNUdUank0WDV5ZFhqR1B1MFo3cFE2SWthTlJneXZDbWQra3JEcFhFZWdH?=
 =?utf-8?B?enRnQUtQOUt5aUZjVDl0dGdQOUNzQnptcFpQMUFaSTN0RHdhV3RYOFZRaG9B?=
 =?utf-8?B?d3R5VkhTS1ZpS3hISm8wVWl4c3dINkg2Y1I2aExYK3JPdjc2MGVTV3ZUdC9M?=
 =?utf-8?B?ZE16RVpaQU0za2VUOW44aVdORmwza0d2L2dkVFZVbGZpWVVMaGE0YnBxc01M?=
 =?utf-8?B?aTg3L0EwVGw1dmFFdy96ZkJxdWlsdkpSTFV6blRIUzZrVy9SVVFiVlNpb3ZB?=
 =?utf-8?B?UTNMaXNLd3ZhN21sWmhBS2h1Rk5Zb3cxZUNiby8rdGw0VXJlSHpwTzI2dzJ4?=
 =?utf-8?B?V2FGbFlOTWFoMzVXcjBJOGlrZkhaeWhHMTlEaHF3SUcvUUM3ZzhGYjVIWjdY?=
 =?utf-8?B?L1Myek4wcWp1TFFocmdzYUwzakNicXp2dmsyVGVpTlh4M04rTzB3bFN0ZGgx?=
 =?utf-8?B?eG4zM3RlcmovWktjYXpEMm10bUFTNTA2VWtNeGJiU3YvaVpVbG5sTlUwTmRt?=
 =?utf-8?B?SW9GYjRMSUwwL2dQeGN1ajU4SEVXNTJQOEk2L3VZZkNTdzVCVUlWV0d5dlRG?=
 =?utf-8?B?ZzdTTmZjZXcvbm41eGNWOXRQK2NGTURCRERtNTM5elEweVhHay9UQ3dDbE1Q?=
 =?utf-8?B?VjE0TDM1a0ErSGxqdE5pM0c0U3ZmQnNENDQrQTFobm5pTWhFVmFHdGFxUFd3?=
 =?utf-8?B?REFuU3FNY0hNWXdRc2ZKWERYb2U4cXZueEdRL2dFbnZIVm4xSnk3bVRUQytN?=
 =?utf-8?B?QjJZcmI2dmprZUg1RThNODk4R1BEYlQySkswandPNGZaN0hpU2lzVlVUdXl1?=
 =?utf-8?B?MFJGejU3dmFvaEo0bzlFRVpqcXF0R0hLcW1wUDQzOUNrbHAwbkNnemJlVGtT?=
 =?utf-8?B?K3BrUmppVFBKZ1FEQytWSnYwblQ1d05GOURDaEtyUWRBaGxtQmcxQmJyVUh0?=
 =?utf-8?B?dU9RR1RKNmtvTGE4Q0dSWkxTbDBjbFJTeENvYnF0aE9WOFdoV25wRXIrQ3NC?=
 =?utf-8?B?UEN2dzUvRmV1VVdmeE9RS1lrdktnVlZNTmYxK0FNdTErcW5oSGNkeFh4QmlX?=
 =?utf-8?B?dnE4SG5qRWtKOUlYUGExWnRSVmRncnBXTmNOcmdHMkZPVzZqQmh1bG8vOUk0?=
 =?utf-8?B?ck5BejNLRjN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVZqM0N4QXVwSStKbVY0d3N1R2RJTHNWY2RPSnhGN1doK3MyNHpmMXRzVXo1?=
 =?utf-8?B?bTR5SGw0Mjdaa25CRGYrTFB1OC8wNzlpRHJJUVIzNzc3NzM4bmZQVXp6T0dj?=
 =?utf-8?B?bGYrTlJmYitZYnFYaUpwQjdoMVJYWTZFdzJmTnNzc0ovYzdWZ0RQWjc5WGZK?=
 =?utf-8?B?aVMyUlp1YU5seXl1OXE4WU5NazJjelMvTThTOW9DYlY3dHU2K2RBZHhlYk5X?=
 =?utf-8?B?dkVreE5RSlFQeTZqV3NZVm40c2pPL3IzdmcvMExieURodTkzQjJZaHlsdGFX?=
 =?utf-8?B?L2tnRFFIRTNwNUlYOCt1WjN0VDZaSWsxTkRYSXFsVzRMcXRXRWVqdll5b0dC?=
 =?utf-8?B?cVlQWXRYL09MTzZobXlPQ3piaHpuWFR6ZVczZXJzU1RyYThXWEE0QVlkdDlk?=
 =?utf-8?B?cDBTcWd5K1lzYSs3TTF0WHNWZ3RYaVdSS3JRZzVQWTJNTkh5ZnNNVzlxNE9m?=
 =?utf-8?B?UFBHaG1uOGpMT1MyZ21GMzdKTkRHRXRIWTFRNm82N1VscEdYSmdvUkdna2tY?=
 =?utf-8?B?WHdZRk1tU3ZNbzZPOFR1ZlFJMEVjTFlRcXA4ejZMeTFlVkM4elQraXJXSFht?=
 =?utf-8?B?cUszQVlkUWNaK1JkbG5CMjYwSlRIOTlTcE05UDdCMDFyVldEcmsxTSs1QjVE?=
 =?utf-8?B?YUdySnkyRElSLzlJcVdlYnBPcE9QU205L3JhMjVmdm5RdkZNRDd3c0hTaWla?=
 =?utf-8?B?eDhTU091U3p5dEkrYTM5Umg2MjJCWFNJZDdmeDFMU0JOcTI4TVNCNXVFenFp?=
 =?utf-8?B?bW84eE0veXd2S2NrWG8rakxRYWNLRms3aGlhdGZhd3pNdjVLeWNseXhYNU9y?=
 =?utf-8?B?QkJSc0pHeExCK2JOMzhEcWgxUEVsV3ZjeVF2Mjl2VzJaMEJyeHhsZS9pdHk1?=
 =?utf-8?B?STBpSk1nT0IxVnQvbkpId3V3TGRjSmV0dnR3MVRtT3c0TE9Da3BWL3loY0NU?=
 =?utf-8?B?SzZMTTJpaEdqN0t5NFZhTExTSFJYandGWHJTSUFqN2x4TXVxZVUwSmxPckRJ?=
 =?utf-8?B?RnpNSzd0aTVZUmZzUEVMTHRmblZJOEZQWC85UjhBRmFoRDZubGQxbjNaZFV4?=
 =?utf-8?B?OGEyTWxldG1qSUpWeDBQL3FFK1EvOXZLUk40eXA1aTJmb29hUUtoalhKcDVW?=
 =?utf-8?B?RW9FZWJReFhRWTRBNUphdjlmalNTZ0VzdDFSSDlnTGZYZmxyaFRINy94UTNN?=
 =?utf-8?B?dFUwTElDMzY2dlFhK0JyTys5WW1sWHRiQzBQWCttUnorR1FHZ2dieGcxZVFw?=
 =?utf-8?B?M2FXOStUcm15TThuOUgxcDlCTkhoTEZSdmNMU1dqNVUzelk3bmlFZkxiSVA2?=
 =?utf-8?B?b3Ribzl4WkFRRTR3NjQzLyszQk9BdWdIanpqTmxhZzdBbDVrMzBxbklld2cy?=
 =?utf-8?B?bEIvOFNzb0NXRmlUMFZJRVp6dSsvc2ZBSHhuK3lCT3ZMai9EOUdXamc2VHVn?=
 =?utf-8?B?bEZZdDdud1NXRVlRanBXQ0d0bklPUFE0VDJjQzM5YzhCTjJLditJUERaNisy?=
 =?utf-8?B?QVdqenlramFpc2RoNExNaGpNK0lob01GZFk0Zm1aQ3FZWmhFd2ZHMzdFMjc0?=
 =?utf-8?B?YzV2c3RJU1Yrb012M05QVTJvdFQ2YVE3dUZMbHRnam9nb2twNWRpSWJXVFJG?=
 =?utf-8?B?Nmt5Uzd6UzMxUGFJM2NGYmlkajhxNXRxRU81Q0hYM2hHUFpwQ3d6SDVpL0xQ?=
 =?utf-8?B?YU1BNEFzUHRLeERuYjB3KzJYcDl3MjBJNEpjYmJ2OXowbGxsNjBPSVo5emZq?=
 =?utf-8?B?NkZqUXprY2JOS0lyOXY0eHp1cUg3TjFFQWR0b2pCTlJnQTBHN2VMTitoVDlF?=
 =?utf-8?B?ZWM4MnU4TjNuNkVLZHk0RHVVbUErZmVuZWdkQzlsT2I1dXRvMDB2aXBNdjRV?=
 =?utf-8?B?L0ZkdUVXWi9LSWRQSW4zMUUwY1RlQXFzT3hib1hidWlYSXFTeURnR28xdTl5?=
 =?utf-8?B?WTBUeUREMDUwcUkrbmRGWXNYdjZ6MEtHNUg4aVEvYkpUeW50S0dYSWZlZU5r?=
 =?utf-8?B?cnRoM3p6NzFMdDBkeE52ZFZnTmpjdDJoMlZad0ZYRVBrYkN4UE9LSlY5aUdj?=
 =?utf-8?B?dWNBVXVvQWNDeG9vZG5TcFA5ZnRwdDN5MzUxUnRxRWVtbko2WHlxQVIzdHdE?=
 =?utf-8?Q?EayiSeW12PIEjWDT42sLRIiZg?=
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
	1or8HSf1F92onCkrp6PkCNcUKQ5pitKySM+LM+T/W+LEytqTpKB9bynv+RJG+29JufNFkfuXhKUrve9h6PciUpkNssRAbagxqgq9PRme6HnVCw0AwY32jODEhoZjmFwcfBKgJGhjaMn6XxJVs9QYhP5Ri5YY2tZp0z3tG8Ix9u/ncDxgeAPic/FwE6V6TCpWQLYNHs3JpNE6tvmszpXZOmLeCH1g4mmD6NAZ/pFZVzH3flhdvBvIK1oy7SGG/qHKoUcGgebhzuwofV0VCcrMgIbuTpsyoDxBtUNTlmkl0aZtCIvB1V9gjXQgWd+UGIg8QoU76EaMN4E2F/BcmwqbTpzc4t0Xy9E7Xm1qlN+6WlVFN3858HYvZGvO4CrYMPETowWAq53iSTr/Fzyfs79qe+mT+EDrrmuTsiH7rVQLcfj5JRIZvrXE1hxfjD1vy9umFLK5Seh+Rjx9TMB45J92fYVansmhSFLuaghcpO3fS8Bt0+Ml/a0iYdKJy/TM5ivQluKXAscDMeqlihToYy7Mtx15C5Jbx2sLxmcER6lD6aeto7czZs7LBpPR3oeGuDFhhipT8xNTSKaWiSyAnomMHa5JyEkXdisTxErvwMVgPTIOAUc9t0lXY4RSfMRFiz/+f31XC7LQxnPsa2MrzS9cQw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437fb342-ca69-4d13-c7c2-08dde980867c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 17:53:57.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DiQdZ9k9/u+iRz7xbMVLxMOIobGsg+PGupcVAUb4mSzvUtQdvz38bb8MCRhUFSMH4FyRsatxri90Fa2LJ6+mVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE6F70D378

PiArI2RlZmluZSBSUE1CX09QX1JFU1VMVF9NQVNLICAgICAgICAgICAgMHg3Zg0KPiArDQo+ICBz
dHJ1Y3QgcnBtYl9mcmFtZSB7DQo+ICAgICAgICAgdV9pbnQ4X3QgIHN0dWZmWzE5Nl07ICAgICAg
ICAgICAvKiBCeXRlcyA1MTEgLSAzMTYgKi8NCj4gICAgICAgICB1X2ludDhfdCAga2V5X21hY1sz
Ml07ICAgICAgICAgIC8qIEJ5dGVzIDMxNSAtIDI4NCAqLw0KPiBAQCAtMjI5NSw3ICsyMjk3LDcg
QEAgaW50IGRvX3JwbWJfd3JpdGVfa2V5KGludCBuYXJncywgY2hhciAqKmFyZ3YpDQo+ICAgICAg
ICAgfQ0KPiANCj4gICAgICAgICAvKiBDaGVjayBSUE1CIHJlc3BvbnNlICovDQo+IC0gICAgICAg
aWYgKGZyYW1lX291dC5yZXN1bHQgIT0gMCkgew0KPiArICAgICAgIGlmICgoZnJhbWVfb3V0LnJl
c3VsdCAmIGh0b2JlMTYoUlBNQl9PUF9SRVNVTFRfTUFTSykpICE9IDApIHsNCj4gICAgICAgICAg
ICAgICAgIHByaW50ZigiUlBNQiBvcGVyYXRpb24gZmFpbGVkLCByZXRjb2RlIDB4JTA0eFxuIiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgYmUxNnRvaChmcmFtZV9vdXQucmVzdWx0KSk7
DQo+ICAgICAgICAgICAgICAgICBleGl0KDEpOw0KPiBAQCAtMjMyMSw3ICsyMzIzLDcgQEAgc3Rh
dGljIGludCBycG1iX3JlYWRfY291bnRlcihpbnQgZGV2X2ZkLCB1bnNpZ25lZA0KPiBpbnQgKmNu
dCkNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIC8qIENoZWNrIFJQTUIgcmVzcG9uc2UgKi8N
Cj4gLSAgICAgICBpZiAoZnJhbWVfb3V0LnJlc3VsdCAhPSAwKSB7DQo+ICsgICAgICAgaWYgKChm
cmFtZV9vdXQucmVzdWx0ICYgaHRvYmUxNihSUE1CX09QX1JFU1VMVF9NQVNLKSkgIT0gMCkgew0K
R2l2ZW4gdGhhdCB0aGUgQnl0ZSBvcmRlciBvZiB0aGUgUlBNQiBkYXRhIGZyYW1lIGlzIE1TQiBm
aXJzdCwgSSBhbSBub3QgY29udmluY2VkIHRoYXQ6DQooYmUxNnRvaChmcmFtZV9vdXQucmVzdWx0
KSAmIDcpIGFuZCAoZnJhbWVfb3V0LnJlc3VsdCAmIGh0b2JlMTYoMHg3ZikpDQp5aWVsZHMgdGhl
IHNhbWUgb3V0cHV0IG9uIGEgTGl0dGxlLWVuZGlhbiBtYWNoaW5lPw0KDQpUaGFua3MsDQpBdnJp
DQo=
