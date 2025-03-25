Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44171F584D;
	Tue, 25 Mar 2025 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884490; cv=fail; b=jgQahDlmx23mMVzviNfUOydcKNYW3sISMdvLVJqom+f9zJ0FCeL0lY9MeebMCt6XiCOlb3FJtK1d0vZ5ZACoh4jJV3NOet5/bw3Ovx8rg/LEtqY+VPXh6p2uJ9vME+DaQYG0KhlTzUmxVF976NgHdy7o0/Dfa4IawZ/f2MtDaKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884490; c=relaxed/simple;
	bh=sCocP+1KKpjKQHjBrHKc/BAd4AYFqxuuXX4AIzJJMgU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPOyIQ4fwsKkHc3UN9cf8ofgMk5Qi0xr3vxzNBwDunBbNsp/Rbsz0BQAPygzEutX4pwh0NAjIHAhbZRPwBgElbUPUYG+2sIcHUghytWywSh+YuA5CQxp7LmJ2jfBMufLg0EA1hRDgNWJsw5TLVaOMMFODlbkvz2oc+TtwBI/KCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDKb2EkO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDKb2EkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742884489; x=1774420489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sCocP+1KKpjKQHjBrHKc/BAd4AYFqxuuXX4AIzJJMgU=;
  b=MDKb2EkOTIodi6anKB5OcWFKkL4rpZTLdVvolcpZgy0WXGflseLweUel
   EU2+hveBWobgJD/t1wY6mqx/7gUA30nnInfRswrQtYnal4Ujd+8pi16w5
   dMSxjPPg7jwRX9Pcarty8Zq5pnnqAko4AixpDLEX0U/YeEQJCzyY74Fbu
   QGdD7AzgJvi4ncK8as53Iu+neg6NtfXYJrl9t3xvvqlYKzzrmH2+mxB/L
   dOMv48XNyq+kxTbDK5f3BsBxsqpZxP/Am6eq8W15KPSJajjTfJkxSLEn6
   Y3fvD4z/X02huxJSDbrcgbGUcrUsU44AujiQHXVDRLvxceRoym46WqbQY
   g==;
X-CSE-ConnectionGUID: tjKSfNTGQxur5QnvUjcTsg==
X-CSE-MsgGUID: 8sUNUZHLR2SO4OCMz2qbzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47769444"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="47769444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 23:34:48 -0700
X-CSE-ConnectionGUID: LJcrE7SbSxS9liew/klonA==
X-CSE-MsgGUID: WZnhqU01SL6FS1QMinou7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="124451845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2025 23:34:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Mar 2025 23:34:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 23:34:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 23:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGZG1Am+i1zaopwHe0L3ih0rBV0M0x09NS6gAPiuogW+6jN3PTuMnbSRUPur54qFP2LXVmi1EIyQF+2GggdygwzumOx2cIRF26SZoqhtCH/Dex9u9cBAY8ZTacU+7ZkdyKEmJrlBBN8gZVDzwWg36gp2QgCoJEubqkatuAbLirv8d2NfSgATTc1laAaAz+ekCVs1uZK0kRQxxiEotEy1iJIFn3+wG5WVC62bCm0DyaKaDx3egixk8jJywHE1Y8qZqB+rda04QIssVlFGqqghbhX9DDmfepkCST3qlQ4dmkVaHrJ30TVEkNlKiJWiacjsXhAyEp/DCub1HYejRDreTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOpHBD1XIRZ7npvAKJZ97HWojxcm4a22KeclYVdZfkE=;
 b=wfcGHAWlUQRI2KFU0li60nwMYtrrUt4NPSTxBlUFjsMpSp3HUtKRbblKlwE1K2RMJMeyz5CsZ3moFVYlOTijhPf4KtFo0WZwciP0Phxl3xV9Mminvhq2gP7dYSjImyGX9VyGJ1zM6r/p5ckFOO+ttaPqbWODYVqOz147a8JWiJYIYIRXZG0Tfye1t+2zLB6JXuogilISiUo8S4OSsLBaOMcYiOs7xOuTjtKDIJuBLMRMO7p2+GhVeDEZLuZZt61cCmGGu4MM6HIntlLOWN9RxvVF7o7v0L8LhFyWCBFjFMNRYRXBdqsPPnuYHL1d58UMT9I6vckIqT7FqglQZcK5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:33:58 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:33:58 +0000
Message-ID: <c6093207-2b68-4e3a-8a70-7ab4541ac59f@intel.com>
Date: Tue, 25 Mar 2025 08:33:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: Add quirk to disable DDR50 tuning
To: Erick Shepherd <erick.shepherd@ni.com>, <ulf.hansson@linaro.org>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <dsimic@manjaro.org>,
	<jason.lai@genesyslogic.com.tw>, <jeff.johnson@oss.qualcomm.com>,
	<jonathan@raspberrypi.com>, <keita.aihara@sony.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<victor.shih@genesyslogic.com.tw>, <wsa+renesas@sang-engineering.com>
References: <CAPDyKFqrT0zXVRya=sgEOdjmn7D6xb-e+nD9Q4JpVnh1ddu_Fw@mail.gmail.com>
 <20250324192116.1756281-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250324192116.1756281-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: e4059cff-229f-4a81-9bb5-08dd6b67057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzV3ZHFxWW5QOG1lOHV4d2ZIL1Y0bndicFo1QzdMZERQUEZwblM0cnVoWUJQ?=
 =?utf-8?B?eUtmU0piTTBRMExSeldkTHlWVkUvekJPd05ZUW5xbzVacythSXdJdWlGT0VG?=
 =?utf-8?B?Y3plVGhKUWpRWTVrTEZpa2NreGRtdENDWlNFa2JOaS91NnQxL2xNdEpNY3R6?=
 =?utf-8?B?ZmwwT2REOUUySU02a2FtWE5oSytxaHVJZ212Uk5EMlVaT05PTFJOaitPUEdF?=
 =?utf-8?B?UUxvQ3JqY3FMNjVFdUZTOHVpVmJ4NjRaL1N4aFNUQVlLQ3ZpRDdkSXNvbERV?=
 =?utf-8?B?aG9uUGJWZ0ZuUy9iSE1tN3d6TWFHa3pKMWhKZ2tINDh6MFZvSnhrNEdZU1Rr?=
 =?utf-8?B?czNaSkJmbkdhZGlhaWprYmc2WnJKaFJkYnBiS2RzR1k0SElWaElpNjVFcUdF?=
 =?utf-8?B?KzM5Y1RyK3dNdTJnb0g5SnZ0RnZvWk1QdS96Ri9aT1FlMGV6M1ZrSjN5bzFx?=
 =?utf-8?B?V01rbW1wWE0xMTZmQklYM1JGVWRIWXFOcmFZSEVNWHBiZnc2T2N3WEN5eW1J?=
 =?utf-8?B?dW43NlovQmxaeFpuN29CdFpwTmZPOVZldzUwVStMcHRoODNiWEp0TTNlOVVy?=
 =?utf-8?B?OWRzd0NnWFJ6YzI5QmJTcVN5MVBxbmFFUUptKzFXeTB5VWhuUWVoaFVlWE4z?=
 =?utf-8?B?b292TWlDZHluTjNKSW1wb2xoMWtVWVpDbGdJejF0RENZRzU4cDlQK09DU3ds?=
 =?utf-8?B?QzVpWGowNEljb3BjMWpxb0cwYXBzVU1KQmxVWFREMVpnZUFGQnZuUXJjcENm?=
 =?utf-8?B?TGl4bGJmZHFZNU9TcEZpQ09hQVJ6Nk9CbS9FdHlUaGhtTUNSSGErSWxRZ0pT?=
 =?utf-8?B?ZldBWUltMndlTzFWU0tFbDdrcTh4NklOcGV5VENkVnFwemZCcVRHd0hETFBG?=
 =?utf-8?B?dXFtWm56QlJQTURrUFI4UDg0SzBOUHNnc3lQclU5bXM5aHJmMElaMVJNbStw?=
 =?utf-8?B?WHYvSnNsU3RWQ3BxV2p1eVU4QTJGVnhwMWFYQXRJemZYUGYwekN5VUl6a1RR?=
 =?utf-8?B?NW9ZSWRaYVpDLzNGQXhIMmxFaXU3WFVyZzhUUyt3ZFB4Y00wWi9HUFhZWGd5?=
 =?utf-8?B?SEhZWU0zL2V2UEovR2Nrc3AyR2MvKzR5MmJETjJqZHluMENsaUZVbGdSTjhK?=
 =?utf-8?B?amNCVGdrcFE2QnZBMVcwYktIU0VMT25HaEdOTXVQNFNRQ082SC91SFFHVTcv?=
 =?utf-8?B?SUkyenBsY3o3eWY3WHBaNEVNVHdlVUsxK29QZ0lnWUxyZytKbm9RU1ZyNmVH?=
 =?utf-8?B?c3A2RkErZUZlb2xlekpSTWllM1JEVjc4RHhFcm1qRTcrdk80alJ6c3ltM042?=
 =?utf-8?B?eHEwa1NyMTVCejB6TnBQdXljUnhUSkdYVXpNaEd4dlh0U1VBdW4waE1KQXNm?=
 =?utf-8?B?VEk2clFqV3dlTE5mQ1U5NHZXTnR4RFNJa3pSWmlNUDBmdE44bERzazVVeHVC?=
 =?utf-8?B?UUQ2NDhiTzBDRVRmZk9LcHZqQkgyckNBbFlrckpRYlo1RXd4NGNtS2czalhZ?=
 =?utf-8?B?ZmtPR2NCQlBUMHlBazJVWUl6VkhaOFBsenFSejkzK3J5N014cjNGOVptcmxm?=
 =?utf-8?B?RmNyZU9oNEFLMCtTMmpRemNQSHN1dUJjQTlESnduc0xsbWV6Q2ZFb1FqeVRi?=
 =?utf-8?B?NjFtSWpnUmY2eEFPOCtuUFowOWFCVSs1RFNYV09Udk1WSEVZMC9Hc2hCVDJa?=
 =?utf-8?B?ZXRxT2ZGYWhLWHh4cWtNdVpRdTRHbmQvSTBKT0J3eW9haHNZZ1NWM20rMCtF?=
 =?utf-8?B?dkJ3N3dlalpJY3YxaGc0M2s3QjBIMUlEbG9DQksvNzM3bVlnUG0vT2NyMEVL?=
 =?utf-8?B?SG1kQ0pjUTFaRTU5QTZwMUFrdTIwYUpTUXpzQnFPMDRaaitZT0t5ZUZIWlN2?=
 =?utf-8?Q?6qEnKCBdztQBW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpydDVqeTFOUllIMGtJUGJlTE9nSGFLU25xZDNHbWJZcC9YU0hMQXRxYXhI?=
 =?utf-8?B?UHlWQW9zcEZacHU3eDBsK0xDdlJOZU5QKzR2TUQ3ZUltL3FKTVpNamlXcksw?=
 =?utf-8?B?UGdub1kvWUJBc0pzQlFaREl2UHZPekltQndUL2hRbVh6R0VaSWdLbnplcFEw?=
 =?utf-8?B?ZW9vZGlGVnZWOVNIbFVZU2t1bWpaU0RKSUVrMG4yRnJFNXRyTDJKVU00a0l2?=
 =?utf-8?B?VDVqMVV5SVZsWGpjOGFsR0pLYk5zSGdrSnJvWWlsS2dVYmNNVDQ5dVdhOTNr?=
 =?utf-8?B?Zy9lZmt1M2dsNEdjUjBNWEdaUXZWRnl3aDFBbXo0c2k3eWNqUmpXQ2lqSXRV?=
 =?utf-8?B?RjNob2VRQ1ZqUFkxWkMxVEZGbUdzWTlIMldzaGZQNzZCdGNXclJ5WTVDaExE?=
 =?utf-8?B?QUp5T1V3KzBnUEgzUGx1aEd5OEdGdUtpSnRNQ05jZDNaR2NscDRDUDN0VXdx?=
 =?utf-8?B?V3NtbExOY0h2VlEwNVh0eGtBQ1hkRG03N3k2WFFSaGNIZVBJU3FXYkZVQkdB?=
 =?utf-8?B?OTFSRTlyNzJzYUtncExPeFNoSWxEalVoUm84STBZZm5PVXF3TjZOL0tick5w?=
 =?utf-8?B?Ym43clJ3QVkwN21YS2FpcHZoSzh4NlZYRzNuVUZ0UWJCSVROUkJ1Z1l3Mi9h?=
 =?utf-8?B?RXo1MExzQm43dUZSV3F4N0hwY3Y5UWo0UUtSV2tET3VBRWpFNENGL1EzaHZm?=
 =?utf-8?B?N2l3QU9VYVQ2NzF5Q0U3bUx4T2JDMzJPNzNxRS9VSjR0U3JmQjhmZmx4MW1l?=
 =?utf-8?B?d1d2YXk0Rm1xWTRXRlVYcUdWbWx2VUFoblZZOElJRlM4dFRnMXRzOVNMcVdk?=
 =?utf-8?B?U3hlV29HYXVUS1hqYTlEeHFuRmIvREczV1NpS2FKZkFaNGdmMEZNMnE4VnN4?=
 =?utf-8?B?NmZiWGJxV1JPS2R5M21XZDNweEdyeHNyQ29xV0tYSFFsT2xpd2hOUk50ZjZJ?=
 =?utf-8?B?MmxUZXBzMnRkRXBHejhiUzNleEFNZHpwbVJYa0FqdlNLQXBIODhyYkVFSTVj?=
 =?utf-8?B?NUR5OXU4YysweDNJbnhRaUUvY05tU0hEbEF5Qzg5cmZGTW0xMElQanR5UkhV?=
 =?utf-8?B?M1JkMVFiSXpDNnpDWGFoeXNXR0JjTEcvcTVRamo3Q21sSmdjZzdrMmhYSUM1?=
 =?utf-8?B?c1dockw2eVE2NGpnNWUyS3hFSXdlcUlUZ0FLbUpFbDc5QmEvd0JLc0JaQm5K?=
 =?utf-8?B?bEQvaVB0blhTcVFnYWJVR25Ndk1xczdiaU8wMUJxOVlNUUZRMXRFa1I3U3lI?=
 =?utf-8?B?bWM1dHRqR054N1JPTytER2xYTXpha1lEZlFoV2NrWGgvNkRieDlKUTdxY1Mz?=
 =?utf-8?B?VkdOYnlGQnRXVkFHZVRRVHc2YWdnZ25GU29qdkJ6ejVGdmJNQ2Izelk3dlRV?=
 =?utf-8?B?b1NWejVwKzhvSGU1RlI5SmtBM0hkZ0Z2bDU0OEs1b3J6K3RlYnRvVmZzK1NB?=
 =?utf-8?B?VU50L3NaWG9jUzFIa29weno0bDVVbUxDL2xGSW1vMlQyQ001UW1Wd05yQ01D?=
 =?utf-8?B?dVcwOHhZOERnRjFSV0diRmh3WWQ1aGMvclpPZElnbGJyUTZzOG5ZVE8xSVlE?=
 =?utf-8?B?MEdFalhnZmtFVUloYVNueUdHSmt2VUdNNnhwSlRVdHdQeC9MTitrcndsTm8z?=
 =?utf-8?B?Z00rZ3htejBRQWtDVDUxeW42SlMvMHBkWVNSUUQyaG82bEdWY0xtanJpZ3VO?=
 =?utf-8?B?Y2ZKZzZRcjFMQU9FRFNOQ3BQWFdWSUdZNTc5WjJhYmtkendrNlcvZElYdFJ2?=
 =?utf-8?B?UDMwM2w3RGpVTStwRGpqblNlQzFrNmZYVjA3dkVhcUNtbGRMOGh1YWplSHo3?=
 =?utf-8?B?WXNBNTFxdG1LcnFEM08zcGpUaTNHNUxGVE53TUd4ZzY3ZlM5dlNUT21pVnRq?=
 =?utf-8?B?eURzWXJRanprY3lFbzZJV2k3UVgxQXkrWXI4RXMxeXBOOW9QTmlLdUppMkdz?=
 =?utf-8?B?VWVnSmVCRTBqNXo4VytRSEQ0Y3pmbnNpaFpaVjJta24yblUwSjJ0alIvK1RG?=
 =?utf-8?B?ZGduOVpCd2ErWis4WlpmcHIrd0FqeXdxSi91bjhmUEluSnRGdVQyZFN6SEdz?=
 =?utf-8?B?SzVsMWVTR0VvVGlHWDB0Q2ZZcElFSXFrZXk4TGt3UW9LemU4NDh2S2dkTDcr?=
 =?utf-8?B?Q1lFc25KVzdtejRmc2ZWOXRMV3hVdTNueEw3RlpKcklJT0I1MW1KbXFEQVZU?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4059cff-229f-4a81-9bb5-08dd6b67057a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 06:33:57.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRYsV0N84ixWRcrnJmy3useN8bptcUMtFpaRTcSoNFJLc677YNfKB66agRCU51148hRl7RYw+KY/CJdxwCrNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-OriginatorOrg: intel.com

On 24/03/25 21:21, Erick Shepherd wrote:
>> Please move this to mmc_sd_init_uhs_card() instead. Moreover, please
>> add a helper in drivers/mmc/core/card.h for
>> MMC_QUIRK_NO_UHS_DDR50_TUNING, similar to other quirks.
> 
> Sorry for the late response, how does this look? I can change the
> MMC_QUIRK_NO_UHS_DDR50_TUNING check to be before the tuning
> if-statement instead of within it if that seems more appropriate.
> 
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -89,6 +89,7 @@ struct mmc_fixup {
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
>  #define CID_MANFID_APACER       0x27
> +#define CID_MANFID_SWISSBIT     0x5D
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX	0x90
>  #define CID_MANFID_KINGSTON_SD	0x9F
> @@ -294,4 +295,9 @@ static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
>  }
>  
> +static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
> +}
> +
> 
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -664,6 +664,10 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
> 	if (!mmc_host_is_spi(card->host) &&
>  		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
>  		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
>  		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
> +		if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&
> +		    card->host->ios.timing == MMC_TIMING_UHS_DDR50)
> +			goto out;

Perhaps make a helper function (untested):


static bool mmc_sd_use_tuning(struct mmc_card *card)
{
	if (mmc_host_is_spi(card->host))
		return false;

	switch (card->host->ios.timing) {
	case MMC_TIMING_UHS_SDR50:
	case MMC_TIMING_UHS_SDR104:
		return true;
	case MMC_TIMING_UHS_DDR50:
		return !mmc_card_no_uhs_ddr50_tuning(card);
	}

	return false;
}

Then change to:

	if (mmc_sd_use_tuning(card)) {
		err = mmc_execute_tuning(card);
		etc
	}


> +
>  		err = mmc_execute_tuning(card);
>  
>  		/*
> 
> Regards,
> Erick

