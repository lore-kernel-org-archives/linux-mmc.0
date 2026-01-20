Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1E42885F;
	Tue, 20 Jan 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915737; cv=fail; b=Vhtp37DizC7vlMMI4uC0f7BtifoVnFWSU57x5N0ifDSg3V/uOxJUtneeg+J3y0yNH2jCNPk6MOEFEijTS+Dryv4RWs6Wr6JqGLuXmOLeL2qGSFDhhiZ+X2TvQwNf7nW4ssmwLy6ui6pNI3zwldXKCrZc4KpmxNpus4WxK0adz6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915737; c=relaxed/simple;
	bh=3ajNBKprAA2ArWU762Z/rmQttr2Kjcl6GQjb8l0qQ2o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHtQPWK+i3LRGxhgKgWbG+uGMcb/Pp8iIQ/Y+P3PnkIxCw0alcYu6EmuLWvO+6HgIuOkG3X6n4Xp/NluRc0YGG2Al8PNpzBfpmNKBXW5V+EL8KgRkyZ8BUcSoyUvzyIElRQDx8mFTfrf1pnH9uXTKkvJpEGg5/tyjBeY8UcNsAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ywcc5lLw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ywcc5lLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768915736; x=1800451736;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ajNBKprAA2ArWU762Z/rmQttr2Kjcl6GQjb8l0qQ2o=;
  b=Ywcc5lLwSdasD1+xRUeDHBUhgMsk1zoeGq9ii/7fuw0T9ZlQGBSfaMZs
   SWc6Cu7Ryik5eCAWeDv+V1HldQWUEbLLP7O+a5JwSv/5N0hCWMGA/WTZn
   9qfybDmQzHxNs/ZBO/lWuYquYnLnyilCCVKDeWIyLu34uBHan8dq7S24v
   tufK6opNdumRJEdSCVdyXnfNGnD60n0SheebozACIuJKx8pU5eO6/K3eg
   tejABcRPdxweex3EaM14XZ/otgCNqud3BwRvgo+jGkIOeHIEkNithuKQC
   QlR6hrjw/Ol36lmbbY3gRzb4giK1Jm1TrAMwAA9wQ+TWvE2u3D1v9k1bw
   g==;
X-CSE-ConnectionGUID: L7I7/m6fQtW6hstfR5fy4w==
X-CSE-MsgGUID: DCzOkO5xQqmM8S4PSEWkXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81494414"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81494414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:28:55 -0800
X-CSE-ConnectionGUID: 70okQRxDQUyJ3xuhMF4/Ng==
X-CSE-MsgGUID: 3oJp8XX0QvGhHHpysclaAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210271094"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:28:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 05:28:53 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 05:28:53 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 05:28:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5+pUObzWSLk2uaAPgiBUcQH3otBqo7rVKQmTnjdZN42QF064Iejclj6G1xs+bhDFjrl6YfbfbH6f65GbFXyeTz9ynIt3HaqvUx/5YuOUKbN2r8uqhESaEoyQzpycZYpS2wcgrCHPZ/ME6WR9eBA+gfR02XDl4d8ULiyPLlFO8UADDUEfi0F8kC9Z4bMh+yc/KK7NsUj1pOlpnl2t/UfLT4U2/SzjOOm4t+TLuQ8/r0kkd5jX69EkLaQr6BafwlpGyTxKmcCf2oj6si+HxVzHw2p3gM0N2L5QHpBXHMDBD82yqZjWoLrilURKk/JH5QZzgfC+IKIqBQFv+57OW0Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atXfD4n0fTaYSqtFD/6TNI3eK7d554Qm03sSAiyZZz0=;
 b=G6A8sHPV2CJ2m0MH4T+T2QI+Qi34lxqgWB0+a/a+rTotBH8BaD+NuzcCYiANJWEbgyeNm5VYRVIGFMoRvrMaEy6bHO48KbFeDDx2q5cq1pf1WRbRGQqOB0EF85KAmKoh7dh69h8FFsvXeau9wT/Mqy6sM8K77oyiYoWMlLOfnORIlc5VNrd49ivUVU2Gfdq5wFTnbKNbbJrF62QLGX3k5c6DrxHmqG/SfHl8nNpQkeLa9/HXE3sU2KZA0OhMqTOX4LxRwlaTWvhWEb81AT+kSRlwLvVE2MnxcDW0NRCffdHFPQff+tUe1pPq84IghMb/E0XWQ1ARcqHNfa+NVFTQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9082.namprd11.prod.outlook.com (2603:10b6:208:56a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 13:28:47 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 13:28:46 +0000
Message-ID: <c52378b8-1690-42cc-a7dd-f938dcbfa708@intel.com>
Date: Tue, 20 Jan 2026 15:28:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci: Stop advertising the driver in dmesg
To: Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>
References: <20260120-mmc-no-advert-v3-1-1c7a6a55ef9c@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260120-mmc-no-advert-v3-1-1c7a6a55ef9c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: c66f0d38-7830-4e05-1a36-08de5827d6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXlJbEE5dGpEdll0WnMyR0lNaG1XNmROQ2tia2UvY1ZxbjhHK0YrQ0V5VVF5?=
 =?utf-8?B?UzRnL1hUbXpCbE5wRTRWSWlmWnlsOWd2ZGc2Vms4b09GRjdoKzBpK1FiYjRw?=
 =?utf-8?B?Q0UxemZmK3o5YkgwUG9WQit2eTQ5NS9QUXY5KzNOT0F5dlM2TU9pYWxvMFZT?=
 =?utf-8?B?WmczNnZ6L2gxb3k3eFJGcWwvSUZBSkdxZ3I3bFhvVFNlQThwY0NuZ0FFSXFU?=
 =?utf-8?B?Q3RzbzJLdU9qYlZEKzlkKzBHSWt0K2c3M2xlT3F2amtGK2xwa1RkWmxXcUw5?=
 =?utf-8?B?WGJPc2E5YVY3cUpVOE1JSWNyT1B6NGZpUmNHdUFGK0RnWVg0UXFFSGx6TGsx?=
 =?utf-8?B?K3MybjhxTTdITDJqbzZ4ZDNMSkFGQVp2Tm84ckE5aHk2elJvcWxtbUxyM2hn?=
 =?utf-8?B?cmFNY1ZDLy8yb0RxNHNVSWUwZkh2MEsvVTQvUGdINWY4L0t4VjlhaCs0WHJH?=
 =?utf-8?B?V2pZUDBpT002WStRWnFwZTBOOVNydWh1eXpmWmtMRjhqTklnVGVvbXk0bmFN?=
 =?utf-8?B?TXZTZnpMNi9TRlNuRUtpUVZkZEhDQURMbmhuRVhJOTF6WHYybytYNjZMVGxN?=
 =?utf-8?B?RzZKM3A0aWtOVVBycnlQVFMzMlZxRS85VGZzM3hBRkYyelJnc2ZHU0k1UTBO?=
 =?utf-8?B?TWRVU2wyb2o3TGF4aVNEVU93WkI5V2Q5bnFveWlBbUpVR0tsZEJCak5Kd09J?=
 =?utf-8?B?dHovc2RjamRINXNKOTVXVlJDQzFaN01NQ0lrN2Z3bVo4L01sN25CT2sxV2dj?=
 =?utf-8?B?Q004QXVPUlc2YmdrcVpxbCtabmJhbHR3S056S3gzU1k3OE9PUVRkUkkwR3h4?=
 =?utf-8?B?VEdRN2tma3J1UHJhVW9xNnVOYnBpMmdaSzNTc1I5NUt6V2dWQWU3MHRnaXJz?=
 =?utf-8?B?ckV0Z3pESkcwQ252dksyd21JL290SVFaRTRnOTRRUkF5YmV4SjFOZzJ6SnJq?=
 =?utf-8?B?RzQzc3hmMTVmdytmaXNNUFQ4Zy9PMk5ZTnJ6RmY4SGRZb3NTTFNmbGN6V1Fs?=
 =?utf-8?B?eDY2SjJVVHhIKzBkdGkwU3Y3ZFdLWWNybG90a2xJMTZSZzBWUDlQdm9Cb0xC?=
 =?utf-8?B?eXBxdm9ZaDRpRjNMU3VRTHc5bkFtMEY5VGQ5NzMvS01aeEZUQldxcG14dEYy?=
 =?utf-8?B?b1haSFJkNXFBTDRqYlpQQnI2am1DSE9HT21QZWg2TlhOOHBuNFFQS1JSNUVR?=
 =?utf-8?B?MUdjM1hFY25qcDQ1TG4rYlhrTitkZ2JoNzBKWUo5d2dsUi9tTStLUTdhSnIy?=
 =?utf-8?B?ODdIRk84YnU0L2lhKzF3Ky9rZjRPOHVScmhjNGdOZUVpZnhLMW5rbnVTejJO?=
 =?utf-8?B?NytYQi9wTlVGSlI3SGpwaXJhSEcwckc1MGpCdklSWk1aWEFKTkxWbkpzYlNu?=
 =?utf-8?B?ZTFNemN2b2h0ZlBOUGxpV1RtTjMrNG9kZzlWaS9nK29reng5Q0g3YUhvSlo3?=
 =?utf-8?B?MFdGMHlraWRMaDcxV2RWVXJFU3Z3VitHbDVoOFMyUG01cTNCOEg5MmIzSTVT?=
 =?utf-8?B?Sk1WQUd2MlVIK1RlY0c3czBpTmxQMVBkaFB4OVRVWithZDlKNEc4Ty9LWFZ1?=
 =?utf-8?B?aTdqSlZTaXJTdEZaTVV5OW1xKzRQTVFyVjZhUFhTTmVzMlpMdU5xdE1NeHhv?=
 =?utf-8?B?MUc0TVRTdy80RDFWdmROVEJsN0x5YkhWSkJSQkV4TzVXS2hVYTQrbThESTYz?=
 =?utf-8?B?NlJubzVtbFQraTR1Y1NUWGR2aDFQNnNDM3E1bHZlbGVRaHhmZXlxR092VFY0?=
 =?utf-8?B?R3VjM2prN1VFYlBBMnY3S2FyVUEzbC9BQUs4NXIxbXg5SnBsZllzT3d2MjVh?=
 =?utf-8?B?YktNemJiMWpjNjIzSVpMYklMTEVadlk1SENlV2s1Y0hPSkw2dG1xaGZlY3Bv?=
 =?utf-8?B?bzdzOGhSVTlQRXdnekloMm9vTGdnbFRONUx5RlZLbEVkUTBENUhGc3NtcmFN?=
 =?utf-8?B?ZzBCeEhZU0dhTGF3NTJWZTZrT3IwcHRKM2FOeWJNV2NrSWhMWVBha041UCtH?=
 =?utf-8?B?UEZLSWxzUnJ0ZDBFbng1YmZ4Y3RiVXRrTndQRjBHcXlQLzdObGcyMFBldDJH?=
 =?utf-8?B?cFl4dzQ1Z0dKVlpMWGJ4ZlpCU1ZOZWFtcGJXcDRwY2lUSDYwWnptWDdrVE1h?=
 =?utf-8?Q?v5of+D6ThjbkHJ406xasyRWg5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk9xMW1EWWk4ZW4xa2NRWDVCeDZuZzRpbGdzd1BPeWFkeFc3TWovVkJtcUZk?=
 =?utf-8?B?Q2hTU0xpbkN0OHFIaThDalNldXozR2htMkR2Vmtmc29hYkEvWkNpSXJmb1Ro?=
 =?utf-8?B?ekwyTGh5SUNjL2dFMU9pQ1YrUlRYSzlTWE1Nb0RQUTVEUVVJR1F0ZHhPM084?=
 =?utf-8?B?ZEtJNHA4VEZzOEtxV3JxV2gvTGI4aTR6RWFwU01oUENpaHNCamczVjc4M2pX?=
 =?utf-8?B?TWRnQjZBVVJvZklmMlczeTdkaWxWdTNnUHpFS2xxOURMZ1VXWmhOdk5TS2J3?=
 =?utf-8?B?UG5QNlhadHFxWTVGTjlsUUdKajBoamcyZ3BiYm5WZGtPa0F2S0xxdmtrcGtJ?=
 =?utf-8?B?R01ZcWdVblBUMUVvdXRuTTRTang2WEhmcUY4NkxSQlR5eXNWUXRpdjFvQ3Rt?=
 =?utf-8?B?c3R3L0c1alVZQVozVFduS2t6emJYNUhKT1JrK1J5L296elYvdTNibGMxQVVt?=
 =?utf-8?B?RHdpb3pOQTgwbXJUOGRpOWZzWWhJSTBpakpkZzJ4M29oclJ2REEveTEvY2Fi?=
 =?utf-8?B?L3Y1a1Z3M3JvNnlFVTNpT01wYkl3eW5iLzRTOVhXcG1xNEUwQWNTVjA2YmU4?=
 =?utf-8?B?K041OW5sVmp6YVc5Z2h2Q1UxeFV6Vy9GZEx6Sk8rTUFxMThlN215Q1BlbXFD?=
 =?utf-8?B?ektLOTZJUlJRQ1g4dVYwbWFRU3dQdmtjRmcwclloTm5ldnpmd0VnUTdmT3Jk?=
 =?utf-8?B?YVMyTTA1dUs5TG1UVVY0TFlCcXl2dWU3V3JOZkh1WFNISnFHcm1KakRxaEVS?=
 =?utf-8?B?cGdpNlplSThBTG0vRUxjYzZBWU9IVTBrcUltZkpBVlVmcFZ0cFd4UnV5K2c1?=
 =?utf-8?B?bDhNd1BpZ2l6SHR3OVgySUd0dEFSWiszblptZHAySEZjcWZvdVhQR0xJcVRy?=
 =?utf-8?B?dytCcVdlOEZaN1dFM1I1WGg5RWR5b3JidzVrNjY1SVRzNnZnRmFjUUtwa3NI?=
 =?utf-8?B?NFBCVGNpRVRoQmxTK1dDMkhzTmdRaEVhMjN5aWRJNjBmdzMyUGQwM0ltS1Vh?=
 =?utf-8?B?VDFBaEpReGxYYXV6RHZHNE9rRXVZL0dyeU1keURMVjF1WWZQb1ZVcnRPeS8x?=
 =?utf-8?B?ZEJtZk45TFVoTTVoZWFtQVhTRWwzRStnMFQ0TGZMdkFMRjhlNlZZU1NLbHpa?=
 =?utf-8?B?SmJGVGpUT3I0bUZDbHh6RmJaVzhaU3R5akZ5MitBbTJHc25COCt5dTkyd3Fs?=
 =?utf-8?B?Y0QxSmNDL2E4NGo2OXVRVWkwR0FxUDFtRXhkckNjbUx5UHV0WmtkSlhhK2pE?=
 =?utf-8?B?cW1TNTE3Q0VZeG9wMGp4Y0I5eVVoTzNJaDRsZGd6MEppekZXTkxrUTBJSEFP?=
 =?utf-8?B?WkpSQjZqZ05WSTdtQytNdTVDNVdQUDcwNTh5K3ZoQ3BkVHRMNzF0QWJZTGo3?=
 =?utf-8?B?THJTMDhKVTJUWTdLT1hwejNYREltQUdwQzF2RHJJaEVGWDJzaGZmK3VSRG04?=
 =?utf-8?B?bFY4bzREeXJKa21JMUpKMzMyYjJUTTBJakdCZjlTK084Z00rL0RiMXN6TWRz?=
 =?utf-8?B?cVhwT1VLaTZFSDVCNnFVYlpFbmhaK05kaUNKdyttU3R2Vm1OVWE3eEZCMll3?=
 =?utf-8?B?c2ZZai9QdytFQ1gzdWNXVHB5Y25DTm85a2FaNkxQV2J2ZHl6YjlrWFNDK29j?=
 =?utf-8?B?eFJzNzJtSGNNdjBaV2xqQ1RyUENNSWZDYVdwV0I0K1dkWjdlckt2SjEyTUFt?=
 =?utf-8?B?SW1MalFHajRYTG1XUURVeGF4ZU9rRy9yUjNCU2VZa2taWEtKT2ZIcEk5RDJ0?=
 =?utf-8?B?RG1RUXJMOXBUWitXVUh0T1U0OUc0WDZlZVRkakJQZXZwVm1iLzg2RWFIZFR5?=
 =?utf-8?B?QVBrOGtrYjhWMmRzS0lWMGIreVFJME43S0FNaUZhWE5rNS9BUStJU1c2MXhT?=
 =?utf-8?B?THRYVXBDWHhXdFBUMmNsSldCTFBLNWx0RExrMEhlK1lRcW0zaE1ZNkt3WGk3?=
 =?utf-8?B?d1BPRUN1YjdYRWVOZmtuT2g4SS96U3RDcW9Dd1hYMFJwYUplTnNPdEdVYTA0?=
 =?utf-8?B?S09acHlZN0ptdnBOOWVEQ2c2R3J5SUpvVmFSY1l0MDYrOFZOSExjTlczTU5U?=
 =?utf-8?B?alhWMENROEgwY3ExT1pIL0JLSlhHN3ZKVFMvdWVsMnBxTEQ1UlUrUFAxK0U0?=
 =?utf-8?B?T1pOWFdrMXJacFAyNlZTTURhSUlQNkhaTHNEMWhHUGNiVEZSLzJCRVp1S2hj?=
 =?utf-8?B?djAzTUJ2Zk51dVRTWDdmZGdMR0gyQXVRN1d1VVFWbXJ4MmE4WE5xSVBPSHVE?=
 =?utf-8?B?aS9aYWRWcUFBRVl6YXZuQ1BUenVRS1ZTckZGUU9oSlIxWDVlVU5wcFh2YWt2?=
 =?utf-8?B?eVJBb0tEbE1TMU0ydmYzWGZTcC9TUXF6M290Z2pPOTZCTXBiTC9hdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c66f0d38-7830-4e05-1a36-08de5827d6fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:28:46.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgD22hKF1tMvrxFNZjFhAjiY62oo0krcL8hAc/uH7AE6KOSvxT/9w51X46us6My74nu1JSDs9ZZ40VmP3kt5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9082
X-OriginatorOrg: intel.com

On 20/01/2026 15:05, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> As much as we have grown used to seeing this message on
> every kernel boot, it does not add any technical value.
> 
> Drop all messages from sdhci_drv_init(), and drop the
> module_init() and module_exit() calls as well since they
> now become empty.
> 
> The modules becomes a pure library module, meaning it will
> get pulled in by modprobe() when the symbols inside it
> are needed, or compiled in if any users are compiled in.
> Kconfig already makes sure this module is compiled in
> the users are compiled in.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v3:
> - Rebased on v6.19-rc1
> - Link to v2: https://lore.kernel.org/r/20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org
> 
> Changes in v2:
> - Drop all the messages instead of demoting.
> - Link to v1: https://lore.kernel.org/r/20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org
> ---
>  drivers/mmc/host/sdhci.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af7..1ff15fa9b042 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4997,22 +4997,6 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
>   *                                                                           *
>  \*****************************************************************************/
>  
> -static int __init sdhci_drv_init(void)
> -{
> -	pr_info(DRIVER_NAME
> -		": Secure Digital Host Controller Interface driver\n");
> -	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> -
> -	return 0;
> -}
> -
> -static void __exit sdhci_drv_exit(void)
> -{
> -}
> -
> -module_init(sdhci_drv_init);
> -module_exit(sdhci_drv_exit);
> -
>  module_param(debug_quirks, uint, 0444);
>  module_param(debug_quirks2, uint, 0444);
>  
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251007-mmc-no-advert-8f5646c44dd6
> 
> Best regards,

