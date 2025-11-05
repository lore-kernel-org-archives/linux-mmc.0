Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CD1A9F82
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372752; cv=fail; b=S6AvcW+e30IxCEfNKjQRNw21pUhLuJlRiG60g+8sMFNe2lI0Q2vpslTybrwvkruWFCCW5DYroG/UscUmeUr6deSUuZMBYiYgv6HKy2ps8ZfjEAHqw+KOLyXPMd4gs3rETZ9hfokXJevzDMYzpQ+RBXrakV1qk4bXkTqqxbMGtlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372752; c=relaxed/simple;
	bh=e07B+qDvvfg9An8Zt0DKDqqoercfQsGgyhtu3kICxiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfdHZzJbKrrgJLwFKYW2rWXTMW857Z7sODqZphHqgDsh8bK64g+bB0WcnvK8P1we+ScLuemJm2IHAZcZptNhqQVAmLaxXTMjVHmIMRQs1Adrz0BPZ8rbUs2JJyFCaq6cFUj5vMrqlCe+d+FLYSevGzvxqwENBechnOQUP9lit2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=u2Q590/H; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="u2Q590/H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1762372750; x=1793908750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e07B+qDvvfg9An8Zt0DKDqqoercfQsGgyhtu3kICxiA=;
  b=u2Q590/H2bmugmzbEzLpe0UdwBpwEfknsAxQI0DKgE3A4dTAN/Gl2wJc
   RGDIRz+MDepEukGf4oOp15uCP1lvWy5Xpo78p8MR6BZyWxavIYrJL1EKE
   MY9Py9LL+56mjuUtAOvVPTG2wiHDOqwVwAOUwsDv4P6z/6FuR0vB5Pmzf
   b8DEHLSvzeGVEwrVpWtHZa85b4yqsM/lknAd4LmnnrPsWTwiOL6N28BMg
   FTG2LBc7FK1cHGTvaN5sH31Scvf+WZEtenTqq/5NRzoPtTJzYZoW6/LnP
   8apjKsnq2BRt+slDnqGfwTwIKKFDluAh+eZYyV6j8RjRDPYbY7XIjXqf4
   Q==;
X-CSE-ConnectionGUID: RvwmO5qXSb2NgbHCfdE6nw==
X-CSE-MsgGUID: qEAR5xHUTRu5Bts1RRRN2w==
Received: from mail-westus3azon11022075.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.75])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Nov 2025 11:58:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytbe2RnfP1LM9DSBnbDleQ1hO1Y+s+7ZbCk4T1cOFyRdZtAKyO3ZTnhA+Aqi5m73uB6NUe69PnPMT1GqBwkN1s4UMtBN7CGulyLv2NCyLY0L6JVBsP8qDhO9K9WSVYFTrDSBdP/346bXeNqWAl4Mf2auPhZe8rpa+w9h0UOAIoMP7ZTQoqj8QUKdZyXjzkAtYiI4m2SlW1/cFRr4Yrr2TTyJu4MP43IrD+1kTJBi6UMG7XsGBPvJoCWJxRaR2R+9G/PzFlSN3RYcsZhB9KyBSoXhe+O2l8+LuMh6chN3qfhgQQtAYApF0RGPc7h8JdDI5nI6AlFrk/oswax+U8AJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e07B+qDvvfg9An8Zt0DKDqqoercfQsGgyhtu3kICxiA=;
 b=fN18AMTwC/VFkRC9Jk3TBYs58JhGn9UMucmSJBFRNsvM/84vDQOTsGvmZmTDVCKLmK8RykiO3PCcUFblJDBY5NHhZ0QMo2xbhUzDsjzRnAGLuxwjmlaOvNei/V49L49Wl7pMG1DslZMesumlphkNBvzrvI4YHVJ/y9sjyMHxu6gJPvahd2Iukdgb3x755Sx5REr1ixkf/swKrULpe3ReMW7jciLHJVwOxfWLPXv7m4XKzEsSpITQ4enOceW/m+ajRhvqy3h2IJfEhVaWHy0x3q1kVGy23wu8JGFfUUkW2WSC3LLs9EzxqZwL7ZryJX4Yhkr+Q/f/v4ymoSQ4+cOVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MW4PR16MB4719.namprd16.prod.outlook.com (2603:10b6:303:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 5 Nov
 2025 19:57:59 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491%6]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 19:57:59 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Peter Korsgaard
	<peter@korsgaard.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avri Altman
	<avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
Thread-Topic: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
Thread-Index: AQHcTcW8gIeaM93jREaullbZrewtA7TjVWkAgABUwXaAAASTgIAA0KLA
Date: Wed, 5 Nov 2025 19:57:58 +0000
Message-ID:
 <PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20251104200008.940057-1-peter@korsgaard.com>
 <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
 <87qzud6jq8.fsf@dell.be.48ers.dk>
 <77ce48fa-dfdf-43c9-8094-c1c47ff48aac@rock-chips.com>
In-Reply-To: <77ce48fa-dfdf-43c9-8094-c1c47ff48aac@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MW4PR16MB4719:EE_
x-ms-office365-filtering-correlation-id: ab9c4da8-954b-4b78-c861-08de1ca59e9d
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzdCY1YvYmswOWFteDZ6Y2R2SXVPUUZXMEwzMUxxWUdYVUxwNHVjaXYvWW9k?=
 =?utf-8?B?RFJNRDZwNjdYUzJPSzE2dWtpcmhFTUp3a2w3a1lYUHpIN3RJbk82N2gzQ1Vq?=
 =?utf-8?B?UEE5cExFYmMyYnBJMzRnelo1ZVhQNjJEak9QOEFlUVlQS3VFeWRBSUlEK0kx?=
 =?utf-8?B?T01uV3lueWVFQ29mTzZ6SUtubmp5Nnd3eHZrRlUvN1hLMC9yeE5GaHRUQytj?=
 =?utf-8?B?UWVDV2tvcVp1NTQ0eWsxcjdZTGF2a0l4T0ZZTmcyeTlmMVd1Z1pvaVRMM3Uv?=
 =?utf-8?B?OFZucmFRMk9waEdZVmtIUnY5R2UvQ2FsWnRmb3JZU1ZYeS80MmZzYks1MEE2?=
 =?utf-8?B?TVVUWk1YVVIwUlBnRjVWUnVCMThUQXlCWEdFV1ZHRjEvb01UTVQzTEVscEVN?=
 =?utf-8?B?a3lCeitQWlZmUlB2Y1hpL2F0eXVHcEhvbS9pd2RIK2VnWGNrSUwzYWxzZmwy?=
 =?utf-8?B?YnJrV0xiYzZCdUR6V1dsUHhUMk81MENBRzRzKzNOc1Qzb29Fa0JLRnZId2dt?=
 =?utf-8?B?eVJaUVFuQmhxaWlGam95WHJ3amRmMGhLd2F0dmlMOUhVN0VBMlZkNFBjY28w?=
 =?utf-8?B?UEFPdzErQTVvbHFKQzZJMlQ1YXM5MnRjVXRYVXhpRWJXZUthT3FFVndaNTQ0?=
 =?utf-8?B?eXN4ZXhFVXlaYU9kb01iVWNscEhZb2RZcDVpRTkrQm5WbnV3Wml0bVkvZG10?=
 =?utf-8?B?VEtldGc2TERkM1p0MzBOVTRtb1l2V3BZVnRWUzBtT2wyYUtZSVZybzVxMmwy?=
 =?utf-8?B?cjZzMU9mUzVia3V0UlpIVWQ2MUlGSHdtS0pENmhzN0NINUhGcXR0SEVpZ2Va?=
 =?utf-8?B?SDdYRFVYWW83b2NMSU84eVhvYXlzeWJRUHdTZ3BraUxhOFczN09YYVNYYlZC?=
 =?utf-8?B?RFFqcnBZMlpLRERZZ1Z3Rk1rTWhTQlJabnB2VUMwazZYNlMzRDFZU1Npdlhq?=
 =?utf-8?B?QTh0enBHaVVrVytWbmZlbFZJWVYxZm8yOWFQem52SHFhRWg2em1aaFRxbzF6?=
 =?utf-8?B?RTFIN21zbDRGZThFalhFYzlsVzJ3b1BZQ1VISlc1Y1dDbG9zaExFYXpTS3Q2?=
 =?utf-8?B?NjVSR0oxeGc2SHIyTnk0dzI1SVJ3S2o2ekJxYzFZcnlkMy9IaC9sc2k2YjMy?=
 =?utf-8?B?Qzl3VzdndGxscmx5SDVHV21Id2U4VS92VUZKKzZlK2Yrc2R5MXhleFlQZjVR?=
 =?utf-8?B?akhTdnlFcWFSczhxcVZ4REtsNUppY1NFS3FIMFhudjE1M2N0S2h0SVRra2M1?=
 =?utf-8?B?SThWb3V2c01RNnBZa3dCSmh4OWVEMGd3MWF0Vkc1ZE8rL0sreU93YVowdkkx?=
 =?utf-8?B?d2VUd3g3Qisva1Q1eExtc1VyeXBzU0ZkYnhiYkZUbiswZ21zV3N2d3VsNzg5?=
 =?utf-8?B?KzlsMEFRNjRaeGw5L0U3OXcxYUw5UjZyMXpLbzExdVBOSUZzTVJYNFdkWVZD?=
 =?utf-8?B?RGRSWEhMS29OQWtjc0NIcTZRNVJZQ201UkJ2TXB4Z3hMNHppaWgyTDE5RExE?=
 =?utf-8?B?NENhTzdNQno1YUwwWUt6U1BtNjcvYmZVeEdmcjYyZ3Mzb0l1MDN3ZHVWWVhP?=
 =?utf-8?B?WFIyWlR1NG1ncHFuSTRVdXJXTnZ1SjhLaXJGd1FlejJta01UTE5xVTlVZlVX?=
 =?utf-8?B?UzhkQ1pmaGJEaDgvelN2eDg2QjB5WmNrVW53ai9CaGN6STM2WlhmNzV3R2hX?=
 =?utf-8?B?S3lhZGJsMUFmSTFuWHBqUm9lUEk5OHZaeG9yTTFoK3pwMmJjbGhmM0NTVjBM?=
 =?utf-8?B?eEYzUWFURldDb1RyUnFEdlZmQWxKU2lLTkd0aDM4RUg0NVJsem5ZSW1WakZZ?=
 =?utf-8?B?TFd2Z3RzclY1NmNjQkdVTVVOTyszS2FGb3M3WUJCOWNIMkFIaFhtc1BzTXF4?=
 =?utf-8?B?b3M5K0psb3BESzc4SngxMk9vNUI4WnJmYk9DdHdBZ0JzVEdBRS8vaTNJVnpo?=
 =?utf-8?B?WEs3Y2hWdDh2Vm5BTU5Md1RzMWNMaGNBaFNxMlJlRUpLM2pXdGNzNjk0WjVy?=
 =?utf-8?B?bmZjc0lWUEkzeXRuM2RhL0o1NEdFVEk0djAvNkxrRWZmTTVOK2dYdEdMVXVm?=
 =?utf-8?Q?zMQ8C4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czQyaTR4VE5uZjE3bGQ0T01WRHEwZU5FQUd3dk1JM3RCdVNNWldtQzhua3lo?=
 =?utf-8?B?UDhURUVHd1FGb0hhSGVvb24xTUNnNnNqa0lVWmxxNjFGZXM2Z0Q5ZE5vamZS?=
 =?utf-8?B?QWhzbUZUZFFXMEJLZUdwTUNRVEM1SFlnQXhkTFExQWY2Qm1iNmJQNnJac09K?=
 =?utf-8?B?aTEwRlRIY28rcTc4dXhZbzVHNi80b1JOOWgrRC8vQURDb3owWGF4ZHJFR0RB?=
 =?utf-8?B?TEZwcjhsMnNjdXBoYVVEcmV4K2xaN3grYlR6bC9DYnRBNndGWjRDcEtQWUFV?=
 =?utf-8?B?bmpPN1FHUk90c2ttU1BuWDZFSG13RGt4b1dZWW9pMHgweXdNTlgvQnd5Z3J1?=
 =?utf-8?B?UEh4N2FPR3ZaT0Z4MUV3amozdE9GOFltczAyN0oxNHpCcW12UkhFc1cwTTZK?=
 =?utf-8?B?anpFcHAvZ0NsdE9ya2hzQkNJTHRlWHpQam1VcmJObklSSWh0WlI1cmNYNk9C?=
 =?utf-8?B?TXRXKytyTFdqL2RxQ3ZQK2JSYW1NZi83YTdUTUIxMnA5ek16TFo0Nk14djBn?=
 =?utf-8?B?SFBtS0F0a2FWcE93RlJ0Tk5LWitWN3liaWcvM1F4eEgwdG9xb3B0Y1lTVjBz?=
 =?utf-8?B?OUhHSzZoQ0ZmRWNnSkNWUE1kZmpVcEE5alBLN08xemRlU3FSbklDSzhBVmtk?=
 =?utf-8?B?OUMxL2Rid0JvV1BhZnBDRCtXd1JZbEdsV0FnckpTSU9FRVdwR3lPc2ZmRGhF?=
 =?utf-8?B?Zk5pdk9MbHFidVBzNHlkdGlXSDJ5SGZJakRIaXp3OGxUK0lxK251VkRPN3Nk?=
 =?utf-8?B?akQxcFVtQzVxQWVYMXBtRnNOS3ZUZGtYQWlOZGtFQ2ptb3VVUU5VS1lhdkVu?=
 =?utf-8?B?YlZvUU92TXVCRk1yQ2RzUi9BQjVNKzUxcytpVkdTRWNvbGxrdmZqWWNabFUy?=
 =?utf-8?B?ekx2dTB6bFpsUVpMNFdKdE9LSlFSZXZaKzgzcWIzNW80L3k4dVp6UE56akdj?=
 =?utf-8?B?OTJ5SnovUGZYQzA0U0pSVDdBcDh5T08rYVhsLzE5cjlYcTZNRHU2d3Y5SjNI?=
 =?utf-8?B?aFZyU2ZvV1JKbUlHRENvVmxZcXlVaGprWEdOV0R2aHk1SS9BZjlNRjJrWlBK?=
 =?utf-8?B?OXhIZndpR1ZQTU1lNmZxcC9ieGRvYXkreHdlOVR4bm55RmlzUkdLOW91V3pH?=
 =?utf-8?B?bEt3YzlVcWh3RHNnSUZidEhhNktZTFlyTVg5SVBvMTJ2SmMvcDVsR1RrS3VH?=
 =?utf-8?B?a3dkN2lMOCtwbEdpOFFWL2d6Rno0ZVNyZHgwbFBtN2ZEY2s5NC8wTmJIU3Fh?=
 =?utf-8?B?YUFZOG84Qnhjc3QrdGNPWEI3aWJHV3REZ0c5UHltL2g3K3E4LytnWG9HWmky?=
 =?utf-8?B?ZWE3WEh3d0VrY0pHUDBtdXlTL2t0dUkvYnc0VjR0eDc3YS9aNC9OS2lKQjFK?=
 =?utf-8?B?KzI2aFBkS0daMjUvQUlYQzMyNTdLWndrOHlGcGxiM1RUK0VwWm9rWGszY0RX?=
 =?utf-8?B?Qy9UMUtkUWgrZDZlMTZPOG1uWjR0SU1WaUFJNDVXdk9RbnN4WlB4MnBkaFQy?=
 =?utf-8?B?SGZrZWx4bWZHRjNJdm9FWDVxZUxieWh6dmExYmVNWDlQK2ltL2lLQUlYVE1p?=
 =?utf-8?B?TEZwQU5EYUIyN3g5MFhRZUZyU3Jpam9aMUExaE50dXR3TlArUW93Y0d6aThR?=
 =?utf-8?B?NVROcGd1a2t1bk1mVjVxeDRLOXpyZTkxRi9kdVJ0c2JON29tY3RvbzNlWFR5?=
 =?utf-8?B?NlVleVFQZ0prRkpFZTBwTzBpK0tXRitYV0lpQ2lKeFZOakIvQk5JUFNNbHVB?=
 =?utf-8?B?M0Q5bFNKaUxmZWgvOVQxc2RPWXRvMlZIUmYxOWZDZFByMFlpbTFDMEdDSG93?=
 =?utf-8?B?ZEhabkxKY1g2Ry9zbzJrU1lkVk52bjM1UkpERWVMdk1JQVNzUVc5TFU0V1lx?=
 =?utf-8?B?Z2JMbFR1anlhaDVLNTk3cFEzUVBWbkZpb2ZqQjF0SjRMc3F2Nk9xODFNaFE3?=
 =?utf-8?B?OU4yR0hkYllaTDVVWEJ3SnUwRHdzRmxPNWlyU2NHYWhaUXdUVHE2WEJSUDJM?=
 =?utf-8?B?WG9mQWlwVUlyeFBzZDNpOWdWaGZYYjBtd3Y1YUZWOXVMSTVGeFh4bWNaOVBW?=
 =?utf-8?B?dUtpQ3RSVkEzN1Q2aHY3aFJwMU9LL0dFdkRhamRJdUZ1R0RWU1lQL1RWWEh2?=
 =?utf-8?Q?M+23Tgl4WiYI3409Mmn60jlxk?=
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
	u64QobxXCmj/SKmJSr3ezR6+oqm0lk9UoOPQjVBdL7lfX6WR4w9gmbrf+cSXI6aUlGlf/iD3x217g1cqhy1A8+ytPDr5itaGdtXLRMUJnhnlshVDnDIWLtEuEX7aAXdFM3oySsLIIcN0CbN1XUzX+FFOiK5UwMKBAhfJu6R6yOwkox8klkSNx+BLrwGSgMB7HTiU/WF5OCDFIqJcOpl5H3H8/nZU7y2kLn6TugVLiWimst7Qb3QGDfSdvVjSH0mlCmH9/Df/T4M7t9auV39tUmoNX/bpm8cStQbjwduR/ShyEp3NidUxpJKjdd4e+PbRepOfbfeEn0UgJqPNtgLB3hAbefUPLZhWpy8Pz3IP619u9hyl1fsPapTWA4DkysburkYdoVm5u9Ss8W84N6unCNR+lAwsL5LIs6lDGteWXQbgC9jm1HyhygCYV0h6ijDAKxydqI294RGbf4N3b4KH3A7FqxfIKfD8btnkU20uCinP5LjVC4IVE3OIfitwZFMz+j1RWXbuQRPmq7tUp0hVy4vUTcYrTb/reZDwKEFkN8Rk+5c4e/M0nS/rNO7yWqyCHGflJm/z/an76brEQskdUEeUBZi1ES+FI1Fl860+2hWHv7exZwn0RoH5yTy7thW5pvekdk/QYZoEJj5erCdodw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9c4da8-954b-4b78-c861-08de1ca59e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 19:57:58.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XGV9l3ef7+z4/j4c/Wcdyis4+UVSS/W1BpxWWgNB+5Qs96OFLh4oWdA0dA/PVEgBLkk5sagxpBjX4dfH496Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR16MB4719

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gTGluIDxzaGF3
bi5saW5Acm9jay1jaGlwcy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNSwgMjAy
NSA5OjI0IEFNDQo+IFRvOiBQZXRlciBLb3JzZ2FhcmQgPHBldGVyQGtvcnNnYWFyZC5jb20+DQo+
IENjOiBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7
IEF2cmkgQWx0bWFuDQo+IDxhdnJpLmFsdG1hbkB3ZGMuY29tPjsgVWxmIEhhbnNzb24gPHVsZi5o
YW5zc29uQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBtbWMtdXRpbHM6
IGxzbW1jLmM6IHByaW50X21tY19jaWQoKTogY29ycmVjdA0KPiB5ZWFyL21vbnRoIHBhcnNpbmcN
Cj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgU2Fu
ZGlzay4gRG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yDQo+IG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGF0IHRoZSBjb250ZW50cw0KPiBh
cmUgc2FmZS4NCj4gDQo+IA0KPiDlnKggMjAyNS8xMS8wNSDmmJ/mnJ/kuIkgMTU6MDcsIFBldGVy
IEtvcnNnYWFyZCDlhpnpgZM6DQo+ID4+Pj4+PiAiU2hhd24iID09IFNoYXduIExpbiA8c2hhd24u
bGluQHJvY2stY2hpcHMuY29tPiB3cml0ZXM6DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+ICAgPiBG
cm9tIHRoZSBKRVNEODQtQjUxLCBzZWN0aW9uIDcuMi43LA0KPiA+DQo+ID4gICA+IEZvciBl4oCi
TU1DIDQuNDEgYW5kIGxhdGVyIGRldmljZXMsIGluZGljYXRlZCBieSBhIHZhbHVlIGxhcmdlciB0
aGFuIDQgaW4NCj4gPiAgID4gRVhUX0NTRF9SRVYgWzE5Ml0sIHRoZSA0LWJpdOKAnHnigJ0gZmll
bGQgc2hhbGwgcm9sbCBvdmVyIGFmdGVyIDIwMTIsIHNvDQo+ID4gICA+IHRoYXQgeT0wIHNoYWxs
IGJlIHVzZWQgZm9yIDIwMTMuIFNlZSBUYWJsZSA3NyBmb3IgYSBsaXN0IG9mIHZhbGlkIHkNCj4g
PiAgID4gdmFsdWVzIGZvciBzcGVjaWZpYyBl4oCiTU1DIHZlcnNpb25zLg0KPiA+DQo+ID4gICA+
IFNvIG1kdF95ZWFyICsgMTk5NyBzZWVtcyB3cm9uZywgdG9vLg0KPiA+DQo+ID4gVGhhdCB0d2Vh
ayBpcyBldmVuIG5vdCBlbm91Z2gsIEUuRy4gSSBzZWUgdGhlIGtlcm5lbCBkb2VzOg0KPiA+DQo+
ID4gICAgICAgICBpZiAoY2FyZC0+ZXh0X2NzZC5yZXYgPj0gNSkgew0KPiA+ICAgICAgICAgICAg
ICAgICAgLyogQWRqdXN0IHByb2R1Y3Rpb24gZGF0ZSBhcyBwZXIgSkVERUMgSkVTRDg0LUI0NTEg
Ki8NCj4gPiAgICAgICAgICAgICAgICAgIGlmIChjYXJkLT5jaWQueWVhciA8IDIwMTApDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIGNhcmQtPmNpZC55ZWFyICs9IDE2Ow0KPiA+DQo+ID4g
MjAwOSArIDE2ID0gMjAyNSwgc28gd2hhdCB3aWxsIGhhcHBlbiBpbiBhIGZldyBtb250aHM/DQo+
ID4NCj4gDQo+IFRCSCwgSSBkb24ndCBrbm93IGlmIHRoZXJlIGlzIGFueSB1cGRhdGUgZnJvbSBK
RURFQy4gOikNCkhpLA0KWWVhaCAtIHRoZXkgbm90aWNlZCB0aGF0IGFzIHdlbGwgYW5kIHByb3Bv
c2VkIGEgc2ltaWxhciBhcHByb2FjaCBieSBleHRlbmRpbmcgdGhlIGV4dC1jc2QtcmV2IHRvIDku
MC4NCkkgaGFkIHRoZSBjb2RlIHJlYWR5IGZvciBhIHdoaWxlIG5vdyBidXQgc29tZWhvdyBmYWls
ZWQgdG8gc3VibWl0IGl0IHlldC4NCkhlcmUgaXQgaXMuDQpUaGFua3MgZm9yIGZpeGluZyB0aGUg
eWVhci1tb250aCBtaXNwbGFjZW1lbnQuDQoNClRoYW5rcywNCkF2cmkNCg0KDQpGcm9tIGMwZTVl
YzFkMzY3MDE2MTQ0NDk0M2M4OTg0YjZjZGFmYjgyZmFjNjcgTW9uIFNlcCAxNyAwMDowMDowMCAy
MDAxDQpGcm9tOiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ac2FuZGlzay5jb20+DQpEYXRlOiBU
aHUsIDEzIE1hciAyMDI1IDEwOjEwOjQ5ICswMjAwDQpTdWJqZWN0OiBbUEFUQ0hdIG1tYzogY29y
ZTogQWRqdXN0IE1EVCBiZXlvbmQgMjAyNQ0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdA0KDQpKRURFQyBKQzY0LjEgcHJvcG9zYWwsIHdoaWNoIHdhcyByZWNlbnRseSBhcHByb3Zl
ZCwgaW5jcmVhc2VzIHRoZQ0KbWFudWZhY3R1cmluZyB5ZWFyIGxpbWl0IGZvciBlTU1DIGRldmlj
ZXMuIFRoZSBlTU1DIG1hbnVmYWN0dXJpbmcgeWVhcg0KaXMgc3RvcmVkIGluIGEgNC1iaXQgZmll
bGQgaW4gdGhlIENJRCByZWdpc3Rlci4gT3JpZ2luYWxseSwgaXQgY292ZXJlZA0KMTk5N+KAkzIw
MTIuIExhdGVyLCB3aXRoIEVYVF9DU0RfUkVWPTgsIGl0IHdhcyBleHRlbmRlZCB1cCB0byAyMDI1
LiBOb3csDQp3aXRoIEVYVF9DU0RfUkVWPTksIHRoZSByYW5nZSBpcyByb2xsZWQgb3ZlciBieSBh
bm90aGVyIDE2IHllYXJzLCB1cCB0bw0KMjAzOC4NCg0KVGhlIG1hcHBpbmcgaXMgYXMgZm9sbG93
czoNCg0KfCBjaWRbOC4uMTFdIHwgdmVyIOKJpCA0IHwgcmV2ID4gNCB8IHJldiA+IDggfA0KfC0t
LS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0tfC0tLS0tLS0tLXwNCnwgMCAgICAgICAgICB8
IDE5OTcgICAgfCAyMDEzICAgIHwgMjAyOSAgICB8DQp8IDEgICAgICAgICAgfCAxOTk4ICAgIHwg
MjAxNCAgICB8IDIwMzAgICAgfA0KfCAyICAgICAgICAgIHwgMTk5OSAgICB8IDIwMTUgICAgfCAy
MDMxICAgIHwNCnwgMyAgICAgICAgICB8IDIwMDAgICAgfCAyMDE2ICAgIHwgMjAzMiAgICB8DQp8
IDQgICAgICAgICAgfCAyMDAxICAgIHwgMjAxNyAgICB8IDIwMzMgICAgfA0KfCA1ICAgICAgICAg
IHwgMjAwMiAgICB8IDIwMTggICAgfCAyMDM0ICAgIHwNCnwgNiAgICAgICAgICB8IDIwMDMgICAg
fCAyMDE5ICAgIHwgMjAzNSAgICB8DQp8IDcgICAgICAgICAgfCAyMDA0ICAgIHwgMjAyMCAgICB8
IDIwMzYgICAgfA0KfCA4ICAgICAgICAgIHwgMjAwNSAgICB8IDIwMjEgICAgfCAyMDM3ICAgIHwN
CnwgOSAgICAgICAgICB8IDIwMDYgICAgfCAyMDIyICAgIHwgMjAzOCAgICB8DQp8IDEwICAgICAg
ICAgfCAyMDA3ICAgIHwgMjAyMyAgICB8ICAgICAgICAgfA0KfCAxMSAgICAgICAgIHwgMjAwOCAg
ICB8IDIwMjQgICAgfCAgICAgICAgIHwNCnwgMTIgICAgICAgICB8IDIwMDkgICAgfCAyMDI1ICAg
IHwgICAgICAgICB8DQp8IDEzICAgICAgICAgfCAyMDEwICAgIHwgICAgICAgICB8IDIwMjYgICAg
fA0KfCAxNCAgICAgICAgIHwgMjAxMSAgICB8ICAgICAgICAgfCAyMDI3ICAgIHwNCnwgMTUgICAg
ICAgICB8IDIwMTIgICAgfCAgICAgICAgIHwgMjAyOCAgICB8DQoNClNpZ25lZC1vZmYtYnk6IEF2
cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkBzYW5kaXNrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbW1jL2Nv
cmUvbW1jLmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9t
bWMuYw0KaW5kZXggM2U3ZDk0Mzc0NzdjLi44ZjM1NWE3MmI4NGMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21tYy9jb3JlL21tYy5jDQorKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQpAQCAtNjcy
LDYgKzY3MiwxMyBAQCBzdGF0aWMgaW50IG1tY19kZWNvZGVfZXh0X2NzZChzdHJ1Y3QgbW1jX2Nh
cmQgKmNhcmQsIHU4ICpleHRfY3NkKQ0KIAkJCQkJKGNhcmQtPmV4dF9jc2QucmVsX3BhcmFtICYN
CiAJCQkJCSBFWFRfQ1NEX1dSX1JFTF9QQVJBTV9FTl9SUE1CX1JFTF9XUik7DQogCX0NCisNCisJ
aWYgKGNhcmQtPmV4dF9jc2QucmV2ID49IDkpIHsNCisJCS8qIEFkanVzdCBwcm9kdWN0aW9uIGRh
dGUgYXMgcGVyIEpFREVDIEpDNjQuMSAqLw0KKwkJaWYgKGNhcmQtPmNpZC55ZWFyIDwgMjAyMykN
CisJCQljYXJkLT5jaWQueWVhciArPSAxNjsNCisJfQ0KKw0KIG91dDoNCiAJcmV0dXJuIGVycjsN
CiB9DQotLSANCjIuMzQuMQ0KDQoNCg==
