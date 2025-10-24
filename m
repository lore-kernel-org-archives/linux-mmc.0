Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD9224891;
	Fri, 24 Oct 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284224; cv=fail; b=B/mEiKYwOJP5hgDDoUdadgiphSUHyfFaTT2uRokDONwr3lgGsbq10Ib05CQO0SqNFZGZDqtWj1Zo7abU/JR2XH6D9o5p8EKzKbZ37Ts4iwApK2R72llqNFS25JSnetlE/jSfgKD9xO9bfhoKsM2QqlrpXeWpqQ5bKl/lLxu/kw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284224; c=relaxed/simple;
	bh=X2JBYNT7Tr324KqEcdEzZ3jyD4U8VZyEeGKT44+mC5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rJVgrmZFqGWAq8M0QaDTmer+zZ1YucOQmtGw7BpHkBrzIiobOqHP3yJwRA6uQXf6LkGPuFa+vffnRjvxTNzCItOIwOGe4tufQ+rgsjIv+4kmyTk+jgOKQltHDLG58wgLaOP+wTe9Tpi8Icn0gPIoj2rbFFtPEX1TTm3bkiEobaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDHZDLxU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDHZDLxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761284222; x=1792820222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X2JBYNT7Tr324KqEcdEzZ3jyD4U8VZyEeGKT44+mC5k=;
  b=WDHZDLxU5fIzcD/kzm0F3/g3P2XoWVgL+vf1gRRveByXglX99xcIdGVR
   3RnGPYVtvQS5n6QLNbE3zsDEotuTSmJR48Stg3w+4OW9ajkefDHreuu3s
   eTJg8gPqP2vcjoKpObf5K3H6iANyyWIUoswqOJbmErwksFCXDpDg6c4bt
   ZQKch+MOhMDbfRLd9zF3xmxhDbm56f9S6w0jk3LsgiL+c1ZLdLnmpBQRi
   ieCCFp73E+7BdhyficPEoCsGXhNhftI4OoFXB2ihcBLRfwoyT/Q9Vs+Mb
   myhVGji1Y92NoQnAd7aopfa0rm5YIuOC5qH7OFIyuL3vuKyeAzYE3trGv
   w==;
X-CSE-ConnectionGUID: Xro7UpZqQ4+sj7ApRYjxSQ==
X-CSE-MsgGUID: G5tz3B5wTKSD5VlX6C0+8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63557011"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63557011"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 22:37:01 -0700
X-CSE-ConnectionGUID: gulVIvXyTO6wp60sJL41Yw==
X-CSE-MsgGUID: nmybPwenQ+ubrGT4k799jg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 22:37:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 22:37:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 22:37:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 22:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Od2bVYD7ZeUh4n7LTiVVkh3eQx2eKy+dk+0rD79MlcxBGNuGCmau+KVeX1Eqi7CnMF6eOvVQO0St5KfVRL/XBDeDFAHGihdPE0Zfya2T7wRR+n8oB8NU+4zyQDBFHVF4LVe88AEy60+Dv3AKtMoc9M0Iy8cOlbQuepGhOytg6B5jlNq1SCV12nitC87uOw4utGXBClkBR6GcCHu/NG0hdvPjdfz49WnQ5TRolvsCy1XN6DQpHLSDY7s7YcntU5AuVLx1cSp8O6u68XWonw9CSYkiSU2M1eFRUTnD8VJAqxtV3VrQMxoe1bLPT06lo/+SL7x7ZkpNiSIrZ3ct35oeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzu5A5Wk2vfYtGzvz0dDdZxWGCu8jWpZY2G+jknjXfY=;
 b=iVWgPD2Mp9uuy/ZalkYJlRve2jmtxxKcUsOA9c1EDmRijhYGZw/tQLpbL9yaiid5U1w0YEXzp4/YmgN+yZ5ts4JuoXiAVSDmV7D5UDTTtYoUSaMxDWMUQtVCmabBcCS4KhpEvQqAYMzEOF2QPkyCIyL0Tsb/Nk3Yqn0F5Gg1XY+jhEtgqM5cVp2eeeNGNt0j6eM97+SGZN9BuIlPanmC47ih5Aa8fswYLkbfimAY17UofQ2R5ZakaICJQUCWGA+ALfXV6x/BO2iz2wo6Kyql7LRKm+p7gI7bGKPed6l586wufGEnxyAwQmput9HVrOLUpQewC2j8c6vJTc4aM+Iyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 05:36:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:36:58 +0000
Message-ID: <d7be077e-9972-4364-9804-201c19757480@intel.com>
Date: Fri, 24 Oct 2025 08:36:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
To: Michael Garofalo <officialtechflashyt@gmail.com>, linus walleij
	<linus.walleij@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>
References: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
 <20251020075348.266824-1-officialTechflashYT@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251020075348.266824-1-officialTechflashYT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0054.eurprd06.prod.outlook.com
 (2603:10a6:10:120::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fc8d30-dbde-4c54-c34f-08de12bf5929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dCtqRDczQ05lWEMwNlpUVnhvQWpoMEVFVURzaDVTVXdPZDZ0Z0VsTFp1aEU3?=
 =?utf-8?B?QWNvcnpjYzExbERwcXZmR2tVbC9tY1BRclJtZkJLek5Wa2VpZ0o2a3VXTjNN?=
 =?utf-8?B?cnlrN2NNMDdMME5MbmF6d0tzM3BQYmFXcXJ0bHdiNllySDlaNlJtdTVuRnpQ?=
 =?utf-8?B?K3dVZHlpMWxKazBtREROa0VnbG1yVnFOTDliZ0tFKzNEUEQzemZ4aUgyWWdU?=
 =?utf-8?B?ZGFxTFUyODNCTUY3MVlQeXMxVHlYcEcxOWJpWXlXVm96Z2E4Z1Z5b05kUGE4?=
 =?utf-8?B?SWlObVlJd2RtTTAxdWNLRWR2SlFkNWhTMXNqOEo4MVlRR0ZSWk5EdUZHZkJw?=
 =?utf-8?B?a3VuTkQrSnRWb08zNFduNktlcUxWYXFnU0Rob0lZcjlVRS9qcmxCK0JWZWNp?=
 =?utf-8?B?cE1hSmsvQi90b1VNUXNJMDJwK2wydWd0bWt5eFpzWVdXWHp0cWxaY1V2ZHdm?=
 =?utf-8?B?aWIwRHJhQjN2S0p3aDZ6dElzSjZZSUxvWnpPL3FmUnpWME84bE96OFhRNVZN?=
 =?utf-8?B?Kyt2YjdDcXJoZU5YT2s5SzRzbFlvVVpwd1JEWEhhSk02aVJPWVZTTWxqMzZD?=
 =?utf-8?B?eUxBSGRIYXdTNFVTNkZTV09PU1Bwd3UwK3ZDRnNXTFZPcW8raGFkTXdQQ05i?=
 =?utf-8?B?NUl3Ym0xdDNYTS80c0JEOGEwdWMyajdVTXlNOW16QWttMW9reVIxaHM2bmU2?=
 =?utf-8?B?bWJtMUFKa1UyY294dWFkNEk0R2Y4SVpBcytrcjVvK2tDR1BLUUJQT1RRSHEv?=
 =?utf-8?B?ZWJ6WEJ3Zmd0L3pLNXU2dTZydXBnRWw4Y0pFeU1xdlVTc1pWZUV3bWhTZ3Fs?=
 =?utf-8?B?QUtnTXpMS01Jd0M4ak9GUkZSSDhzdDhFMkViZzV5UndWTUhCa1RiYUF4TldG?=
 =?utf-8?B?QTBqdHFFUkJXSlQ0YnZpUjdFdGI1ZDBQYU9SUkcyYnZXUVhlMWQ5QXU4aklv?=
 =?utf-8?B?ZFZjUTBCb3FOcFFtdHBkK01uR3ByV244Vnl2YTVqQmx3SmxpdUF1b0tTZlR2?=
 =?utf-8?B?SVhuazl0b1Y0dG1SQkNMRkRaYXloWFBHc1lzdFpaRmM1WXNIL3RmcW1UemNq?=
 =?utf-8?B?bmg3VHc0VDlCdjRwUVkxek9Ud1VqbVZqa1BCbkNkZWJ1NFY4VWYxdDFVMWJR?=
 =?utf-8?B?UmhOcGQ1STRtZjFxS2NqZVZKQmVOT09XYjFqUEhKcDI4ZGxjMDhtNm5PeDI2?=
 =?utf-8?B?Z2xQdFpFck9HV0ZwVjBSN0lUd3dpWGxSL1BvN0tWUGdLd3ZzOWwrNUZxa1hY?=
 =?utf-8?B?cGVvNzZRMXNlR01LRStsYml2alZjMU1QbXk3WmZVd3l0bitpbXpJSWZhQXZ6?=
 =?utf-8?B?TTNkZWZSOTExcjFpUTFzQlF6dERvSVlOYm1qUU9ia21JN3E0ejIvMDI3eGpI?=
 =?utf-8?B?TDc2WmVyczJMUHhDaDY3bC9ZYlMybzljamc4VmI1QUp2cFZOUkYwZ3R0d3hL?=
 =?utf-8?B?Wmswb1Q4OVBUSXdmckVhR3JGVUVqQlkxWHEvZDg2TUF5dHBFbmgzemdrVTFJ?=
 =?utf-8?B?SktMKzNPQ0x0WWkyWnVZbjRVNXdlQmcrcHR3RFhqcE81T3R2akQxS2R1bFhs?=
 =?utf-8?B?eUVRMVlRWlpGU0dWTnU1b0xkU1RWTnl0cklLdmRCb2FNS0JLUnhjcFh4alV6?=
 =?utf-8?B?ejlWRWpyQTYrYktWRUxUN3lWT2l5bkV3ZEthYkk0Zk81VkZXMVp4N3ljL1Zo?=
 =?utf-8?B?U1JIMGhaNDlLOVpDL3dRbkVPdUt0TlBsSnp5V1lvQ1hiTWlTNHptRkRJdmd4?=
 =?utf-8?B?Y1lYTThNTkR1dW5pWW12NlovcEhuR0hSQXBYU1NoRHZWSTFScjFnd1haNk9v?=
 =?utf-8?B?MkYzenAyQVVGMGJNS0JmamF6MTVSUlZaUWJwTThpb2RyT3VscXd1QkdiODBm?=
 =?utf-8?B?VGJ2cFFJamVQTmlyTmhmLzd1NGI1WnNZTVBGVlpaNGxiMTk1MWQxY1VwUGxw?=
 =?utf-8?Q?V2nx66emKRIEe8diqGlkBnnWTcvR1HHR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNiVXVBUUliTE50WWVBd3JzUVFWRTlFbEpPNUJWa0wxSGNVa2pFaG9zcHdx?=
 =?utf-8?B?NXZyc1BoS3dXWVNOUjd6S0VuMmFBQWhrZ0laVGVoNnJaYSt0NlZTT3Q4eFEv?=
 =?utf-8?B?empKY0MzTlJWU1pXbE5CaFFpTkp5dmNackY0eDlzVTdxVXY3L0VOKzUrdGFk?=
 =?utf-8?B?N1ZQS3pSQ2kwcytGc2hnRmR6bmVrUWJlcytYSkNlZDlyRUtCc3R0NERpcHIz?=
 =?utf-8?B?Z0kxUGh3WlNRbzdqWWluRmhqcHJBZ3phT09jS0ZFSE1UTDBxblRDNVNyOXlE?=
 =?utf-8?B?S1B4VzdGWHJkWHB4dDlHQlFhV0VZSmE3b2xqa2pFVVhUOVhQamFWMGt2WVk4?=
 =?utf-8?B?Q1VtRnhnSldXUW9McXZ6WmowdEJDblFqQUV6elNKOXRnMjJXRVg1bzc1WkFs?=
 =?utf-8?B?QUJXT0o3ckcwSG01dnViVE5LUlRqTW9MNUFHZkVpb2I1Q0w5MnoxSEpEZWhX?=
 =?utf-8?B?anpCbCtmSU9ZV0IvK2ZwWGR5Nk1wbk02OUx6dGNabWlMbHgyNlhvWkk4djVP?=
 =?utf-8?B?ZW1TRHVudHpHaFgrMldsamFyems4bE5TWmtxRXNMOExiVHk5VC93dmQ3elZl?=
 =?utf-8?B?UWVlWHVWNlJFdDVkc09QVWRGbFZYdldHRXcvbVpZMTNSWE5CTlZHVXliZ3Qx?=
 =?utf-8?B?UUExYXF0MHE0ZHROT3IreExDVVNIbHdvYjg3Y2JWOUZWd2lLS1pDcG1mTHBW?=
 =?utf-8?B?bFNTWTdQZ21nMWlobnIwcXMvYWhKdUpQZTNzRDIxN1BBWGtDajNZUVk3R2Yw?=
 =?utf-8?B?TEg5Rkt0TEJOalBZK3ZIN2M2TVdudlZJZVBFSGVDWVREdTNPd1RzL0IzeTVl?=
 =?utf-8?B?VVV1eXM3WjV6SitGWGhyMGlNSlBRaXRBcDRvdXVsVTd2T2hRbWxnai9Ca3Mv?=
 =?utf-8?B?dktMVXJWbGk3dFBWdlU1NW5vOWVMMlRwdVRGbHVYby9oWUdlSzdVUXB4N3hk?=
 =?utf-8?B?QjJDNzlXenFjUll0djZ3U3hJSWJnb3JQekRqL2VmZENUUUVNQm5iN3RiOVRC?=
 =?utf-8?B?dC9ZUDAwamU0MXNoMURjbzNDNjR0RzN1KzJyekJYdFJmUlJuOFIyaDZTU0VO?=
 =?utf-8?B?Tnp2VzRUQ1BwdENQREpaVExzVHYzWXR0T1d5ZVFsYS80WUFRTXNLOURSUkZq?=
 =?utf-8?B?MjZSUHpxMCtjMDQrenB5ZmJ1U0RSS3hzQVB5TzVZajFPVkg1WDFNV2xjdHpB?=
 =?utf-8?B?Y0NDSFJrNHp5d1JNWlFtcTQ2cFB0ZDg4ajY2Zm1XanZCUXlwRmtYVGZZeUJs?=
 =?utf-8?B?bG9QTnE4K2JGNldBN0pDYi9hRTlCbkhjRE8yVkZGbjJ4NklkUWVhQ3ZYc0ZC?=
 =?utf-8?B?eEZDZ1lJeUEzMFFQdlBjc0JvRXAyWUFKMm8rSElVcjhCN0QxbTJEKzZldDFL?=
 =?utf-8?B?V1BOejgyMTdWZ1l4UVBob0c1SGpCZUlBMjlRV05keGdMcUFXVEdYVGpXdndF?=
 =?utf-8?B?TTVRUTZMWE9tTEtDZzloVGMvMDIwMWQxVUppUzNFY3VVeDkrTlkybHJpUVdr?=
 =?utf-8?B?Y2ZmYmtPc21uMkRlR2J2Q21tM1l0MlBtUjZtdDVwbnBOdU1SL09helJXQmF5?=
 =?utf-8?B?aXpTMERhRlVLNm9aRTA2eFBEYXRmejQxYXdmcjY2NWVHWEU1bmxZUzRnVnk3?=
 =?utf-8?B?ZmovdHI0WEF1dngzUHFVQ09QQTE3LzBjb3lLenVNd2ROM0hvUWUvWVVyd2ll?=
 =?utf-8?B?ZWNZWjRwUWxuaG9IOGFVemlydXdLZ2xlT1d6TVJTRVNjdzdET3ZJMDhPcmcv?=
 =?utf-8?B?aGs0MVZRbGdzeU1LS1V1R2tGUituM09IL2FuZWJ2UFlPQW5JdGVPcWZVMUw2?=
 =?utf-8?B?YjlxRzlTUzAxV3lnVW5wblk1UkdLSStkekl0Z1B5ZXROdndGSEV5N1BRSWhk?=
 =?utf-8?B?MU1Sc3BLVzUwZ011Wkw1R251Sjh2M1ZRUGpkRVZrbGNIU3o0R2F4OGMraG9h?=
 =?utf-8?B?eEtsNlp0NWR5aW9jQWlKcVV3MktNOHBBb0RGSWxMdDFRNVdiUnp6VDdnNVg5?=
 =?utf-8?B?V2Exdk5ic1lGTzJZSjFTVjNGUHZWeUl2c2tQcitwRWVtWHM1QjNrWGtRZ2tU?=
 =?utf-8?B?WUZCUlJNNjdDeDRRTGpqemROdVJDYUF2bUZWK0d4OTVyQ1lneUF1ZHA1UXY0?=
 =?utf-8?B?WTRTNDdVS1hwaXdzUTlsVGRMZTJENFh3YkoyQWJMUHlSb3ZwcHZOZVNBTlFY?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fc8d30-dbde-4c54-c34f-08de12bf5929
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 05:36:58.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoilweFNMirdx8wY3LIg/AArOmoiHslB0Mo39R5waD0rKQxQuPAEXjs6FViBs5tjZGAJp7CBOWY5oceUB4fkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com

On 20/10/2025 10:53, Michael Garofalo wrote:
>> On 11/10/2025 00:16, Michael Garofalo wrote:
>>>> On 08/10/2025 04:10, Michael Garofalo wrote:
>>>>>> On 06/10/2025 12:28, Michael Garofalo wrote:
>>>>>>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>>>>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>>>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>>>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>>>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>>>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>>>>>>> Wi-Fi fails to connect to any networks.
>>>>>>>>>
>>>>>>>>> The bounce buffer should not make any difference, so it is likely
>>>>>>>>> a different problem that gets hidden when the bounce buffer is not
>>>>>>>>> used.
>>>>>>>>>
>>>>>>>>>> Could you enable dynamic debug messages and show the messages
>>>>>>>>>> for the failing case?
>>>>>>>>>
>>>>>>>>> Actually will also need to see the messages in the "fixed" case
>>>>>>>>> to compare.
>>>>>>> I'm afraid I won't be able to provide those easily, at least not with the
>>>>>>> commands you've provided.  Since the rootfs is _also_ running from SD,
>>>>>>> turning on full MMC logs like this produces an obscene amount of noise
>>>>>>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>>>>>>> my original intention, which was to save the logs to SD Card, (since my USB
>>>>>>> Gecko serial console is rather flakey, and introduces corruption now and then),
>>>>>>> since it's now logging the writes of it's own logs in a permanent loop.
>>>>>>> If there's a way to narrow down the logs to specifically whatever portions
>>>>>>> you're interested in, and filter out the noise, I would happily provide it.
>>>>>>
>>>>>> Are there any error messages?
>>>>> If I drop the debug logs you mentioned so that I can actually see what's
>>>>> going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
>>>>> actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
>>>>> it takes several tries to load the firmware, and it can't authenticate to any
>>>>> network.  I've tested and confirmed this effect on multiple consoles, across
>>>>> multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
>>>>> off, it's much more functional.
>>>>>
>>>>> Logs with MMC bounce buffers *on* (without my patches):
>>>>> [  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>>>> [  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
>>>>> [  168.508519] ssb: WARNING: Multiple ChipCommon found
>>>>> [  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>>>> [  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>>>> [  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>>>> [  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>>>> [  168.719257] Broadcom 43xx driver loaded [ Features: S ]
>>>>> [  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>>> [  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>>> [  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>>>> [  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
>>>>> [  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>>> [  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>>> [  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>>> [  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>>> [  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>>> [  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>>> [  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>>> [  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>>> [  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>>> [  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>>> [  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>>> [  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>>> [  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>>> [  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>>> [  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>>> [  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>>> [  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>>> [  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>>>> [  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>>>> [  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>>>> <keeps trying and failing forever....>
>>>>>
>>>>> Logs with MMC bounce buffers *off* (with my patches):
>>>>> [  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>>>> [  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
>>>>> [  383.986645] ssb: WARNING: Multiple ChipCommon found
>>>>> [  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>>>> [  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>>>> [  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>>>> [  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>>>> [  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>>> [  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>>>> [  384.086571] Broadcom 43xx driver loaded [ Features: S ]
>>>>> [  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>>>> [  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>>>>> [  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
>>>>> [  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
>>>>> [  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>>> [  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>>> [  405.389013] wlan0: authenticated
>>>>> [  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>>>> [  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
>>>>> [  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
>>>>> [  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
>>>>> [  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>>>> [  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>>>> [  414.351544] wlan0: authenticated
>>>>> [  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>>>> [  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
>>>>> [  414.431879] wlan0: associated
>>>>> [  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14
>>>>>
>>>>> If there's anything further that would be useful here, let me know and I'd be happy to provide them.
>>>>
>>>> Seems the SDIO function driver b43-sdio does not print any error
>>>> messages.  All the error paths in drivers/ssb/sdio.c print debug
>>>> messages instead.
>>>>
>>>> I would suggest the following, which would limit messages to
>>>> host mmc1 which is what is shown in message "b43-sdio mmc1:0001:1:
>>>> Chip ID 14e4:4318"
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 860378bea557..2719b21783ad 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -169,33 +169,33 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>>>  	 * - The card was removed (...so just complete everything no matter
>>>>  	 *   if there are errors or retries)
>>>>  	 */
>>>> -	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
>>>> +	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
>>>>  		mmc_should_fail_request(host, mrq);
>>>>  
>>>>  		if (!host->ongoing_mrq)
>>>>  			led_trigger_event(host->led, LED_OFF);
>>>>  
>>>>  		if (mrq->sbc) {
>>>> -			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>>> +			pr_info("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>>>  				mmc_hostname(host), mrq->sbc->opcode,
>>>>  				mrq->sbc->error,
>>>>  				mrq->sbc->resp[0], mrq->sbc->resp[1],
>>>>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>>>>  		}
>>>>  
>>>> -		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>>> +		pr_info("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>>>  			mmc_hostname(host), cmd->opcode, err,
>>>>  			cmd->resp[0], cmd->resp[1],
>>>>  			cmd->resp[2], cmd->resp[3]);
>>>>  
>>>>  		if (mrq->data) {
>>>> -			pr_debug("%s:     %d bytes transferred: %d\n",
>>>> +			pr_info("%s:     %d bytes transferred: %d\n",
>>>>  				mmc_hostname(host),
>>>>  				mrq->data->bytes_xfered, mrq->data->error);
>>>>  		}
>>>>  
>>>>  		if (mrq->stop) {
>>>> -			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>>> +			pr_info("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>>>  				mmc_hostname(host), mrq->stop->opcode,
>>>>  				mrq->stop->error,
>>>>  				mrq->stop->resp[0], mrq->stop->resp[1],
>>>
>>> With these patches, I still get copious amounts of spam, but at least relevant
>>> to the wifi card now.
>>> Here's a hopefully useful snippet (it's just a lot of these, from what I could see),
>>> from with my patches:
>>>
>>> [  154.177276] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [  154.177297] mmc1:     4 bytes transferred: 0
>>> <...>
>>> [  186.707195] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [  186.707217] mmc1:     20 bytes transferred: 0
>>> [  186.707358] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [  186.707382] mmc1:     384 bytes transferred: 0
>>> [  186.707477] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [  186.707498] mmc1:     24 bytes transferred: 0
>>>
>>> And the one from without is very similar, except I noticed this pattern:
>>> [   85.942269] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [   85.942299] mmc1:     4 bytes transferred: 0
>>> [   85.942523] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [   85.942555] mmc1:     4 bytes transferred: 0
>>> [   85.944548] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [   85.944581] mmc1:     2 bytes transferred: 0
>>> [   85.944777] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [   85.945160] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
>>> [   85.945187] mmc1:     2 bytes transferred: 0
>>> ... occasionally, some of the requests don't have an "[x] bytes transferred: 0".
>>>
>>> Hopefully these help.  I can get a capture of the entire log spam and
>>> put it on on pastebin or something, if that would be more useful.
>>
>> Need to know if there are any errors.  In "[x] bytes transferred: 0"
>> messages, the "0" is the error code i.e. no error.  So you might be able
>> to find errors like:
>>
>> 	dmesg | grep 'bytes transferred' | grep -v 'bytes transferred: 0'
>>
>> Also the debug patch could be tweaked to show errors only:
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 2719b21783ad..7b18fe6d5738 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -169,7 +169,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>  	 * - The card was removed (...so just complete everything no matter
>>  	 *   if there are errors or retries)
>>  	 */
>> -	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
>> +	if (host->index == 1 && (err || (mrq->data && mrq->data->error))) {
>>  		mmc_should_fail_request(host, mrq);
>>  
>>  		if (!host->ongoing_mrq)
> These patches were mildly revealing, I see this near the start of the logs:
> [   32.222988] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
> [   32.224789] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
> [   32.227574] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   32.227834] mmc1:     0 bytes transferred: -84
> [   32.229615] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   32.229876] mmc1:     0 bytes transferred: -84
> [   32.230400] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   32.230659] mmc1:     0 bytes transferred: -84
> [   32.231173] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   32.231476] mmc1:     0 bytes transferred: -84
> [   32.233287] ssb: WARNING: Multiple ChipCommon found
> [   32.234489] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
> [   32.238533] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
> [   32.264908] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
> [   32.272565] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
> 
> This occurs either with, or without, my patches.  However, no further
> errors were logged.  Despite the lack of reported errors, the
> functional behavior remained the same as I described earlier.

The absence of mmc errors narrows the possibilities.  I notice that
sdhci-of-hlwd.c is using:

	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR |
		  SDHCI_QUIRK_32BIT_DMA_SIZE,

so there could be some conflict with using PIO sometimes and
the bounce buffer at others.

Also the bounce buffer uses slightly different DMA APIs,
and was designed for the block driver not SDIO.

Adding Linus Walleij who wrote the bounce buffer code for
his comments.

