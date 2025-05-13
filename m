Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE41EB189
	for <linux-mmc@vger.kernel.org>; Tue, 13 May 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121061; cv=fail; b=d3ldfAHkM4BzayW6MIl9EpXPSg4kpRYKFWF153mKQApzP0tGtOhclJa9xyfkl1+aNhlaNEvzJq22A148wI10JnFxkG3HU9V9bagqB+0oiqp+yvZZMlzmXPZjWNNxjuV7YL7mYn51SbZc1+4MdHN86coLsk0m7JY+Pg/10oyB92w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121061; c=relaxed/simple;
	bh=NJwBkw3N0NTgYzaApLW+CO/9LY6oo+ZOeSwT73MTbkg=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJNfm9xenY+htzNU1cZ1RawlXSr28OgavhQ2o805DxlDKVIBIaXG2dEzZFZ/Kt7SCKhvyZRuuaa8pwbqccWIPCB7vWytk4HpAG1nUsdCAEDlt51MS9HD+0Pjj2NYe4RFgvY4LTOTedXpwO8nc2TqMBef7xL/JlTcQfAjvfvF+Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYFtU4ln; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYFtU4ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747121060; x=1778657060;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NJwBkw3N0NTgYzaApLW+CO/9LY6oo+ZOeSwT73MTbkg=;
  b=HYFtU4lnWuN1toHOiciqRDIEX/GO8KS1sqLgWhgmjRanwxYqj6X8zDam
   mPDZRbRobXiYj03uVne8jnhU8dLH3R9/f4I/gW3IPv2P/uXZ+aeSxtnzR
   mGT3AOtlwXsmAIuNSLsWL5kXAaJJ+0wFsDB/0lWbNpZD8/9OtqvgsWnCW
   +4cwLbeMi1CmeaDj8QbyqVcGTMKyjNbQoVyIIJDjOWV10ccZUuNA3MnZf
   kHtwEDXuC6tORQjX03WKz8Y6ZkhfB7ncytd/Yezb/EELMFseAqyi4uTZ+
   kueysFbYiHoCiE8AviW9FS+SVuEZ4XMfZsE7D9swaA+cKV1r4b2dRwLQW
   Q==;
X-CSE-ConnectionGUID: 4T/DXt+nStKAp+Spsb3KHg==
X-CSE-MsgGUID: h5EqHU9ESzenwVV/Lo9F8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66357187"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="66357187"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 00:24:15 -0700
X-CSE-ConnectionGUID: QicjQbE1QuG0G+Nlgf/SzQ==
X-CSE-MsgGUID: yPw/Af4ZRkWDdfBVD10C2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137530824"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 00:24:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 00:24:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 00:24:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 00:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKQKsMQtsfBqWwlGcuVDU0V2QaNe0JyxTo/y1AY4VWky+fbjIMRHGLUxIzQXqgYl/q3b+sfbEkqSyfsPU1n6niYI8+FuFOK8JMWkf5hr/HMIwTBlBtjtKfxtjQW9zsXV7YQSuAXmqjtHa/AdqQNk3FoaUBrevtXAZRw2+mnhYbJdc+aU6qwuvDPqfwiSULIKWno5tf1R5rmWyIRb9xxz/YgUSTNf9vUWrbYIQdZUKh8ck/ROHhpf1VxbUBvF200ztPzT/YxQzlBuQ1mr70hTLocoZcSWQWWU238cDwyU7DuK4Do6yU4MhGt1F4bSFkqtz9nQ70MN8OqgjzRjRVPb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOssLllF72DiiYxbl3jYwZDER/7x129SWlfMh0vivEk=;
 b=fmt2GS1xB2+fEgGsLT+3m2QPaHtwvYNIYKCp33xIj4RHaKNc7pAuJO0fkgQPmGJkMoqV2KKEZ7v+sxdcBG6hSTBABPFTfWo8rnO92iyHgUvR8SLBAWFfpN8qZ0/l37UOYK299Q1Xlpt/5WzG3B/lHTq88NC8FHWb6NsYL9Q7aoTrTE7sP1bHen50fjL/kOSyeTyQ+I2bZ01nWQQ+wm0uYTKJAbxn0Fq6n4z1nmLe32h1vuI0fG8FdxzZhS0YdW4ZbAOiR26AjfceapAE81vvl/6iBa6vAXhDuwAR/udGXmoqaN0Xx8TCI6TMyX7JOUARr2ZE3sigBTIcyMQk+H8Q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 07:24:03 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 07:24:03 +0000
Message-ID: <8215026e-821e-44be-a6a0-625eddd14287@intel.com>
Date: Tue, 13 May 2025 10:23:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: UHS2 init fail
To: raoul via Bugspray Bot <bugbot@kernel.org>, Ben Chuang
	<ben.chuang@genesyslogic.com.tw>, <victor.shih@genesyslogic.com.tw>
References: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
Content-Language: en-US
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::14) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: fc295bc5-88f6-4d63-97ad-08dd91ef2338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmJUbmg1VXJoTE5lNTZyTFhJN01ob2JPcUVqSXM2eHpLT1pMbUdhRWNQTVc2?=
 =?utf-8?B?YnZSY0VCTDZGV1I2OGxrSXh3bUZ3aWUyVGRKM0xVcS9iSHVOY1NzanRWNkJC?=
 =?utf-8?B?WGY1RElIdUViZDlFR0NvQ0RrQnhESXh6OFV6QnJuRTlNdkloazV3OExZeHgw?=
 =?utf-8?B?SFEwMmRGV3pZV2FwRkpzWTdWTWJJWFp1SzltZ0htdXVGbTZqOWN6cVRXS3BB?=
 =?utf-8?B?eGErVno5RXVnTVgxV1Uyd3NoRkc4eVNXRnJCcGt0STI1bXVKb01DT0ZkV0dy?=
 =?utf-8?B?bkJ4TVBsbUZPSEo5elU3bkJ2OU9rWmxnUHpFdGNkdHY3N3RoYnJLdk9xa1Jz?=
 =?utf-8?B?M3dJeGpvM1dEdVhqdUF3aGp4QmttVHZmQ1FSTXF6R2Foay8zNmtxWkFqczhv?=
 =?utf-8?B?ZGUvVjhNRXh4bDNRU0Ivdkp2bHozeEhLdzNNd3FWbEZFclRqak1xNUx1SmJV?=
 =?utf-8?B?ZzhqdmZuMTUwVGUwblhzYnRVUm03eWc0TmpoR1pQTjUyVkw3UDZjNkFSOXJP?=
 =?utf-8?B?WHlmYjV0bVpoU3VsOFdnOVA0bURoSnBIQ2w4c1RtanNjeEtJcE4xMnZ5bjhn?=
 =?utf-8?B?b0lyRVhOL2FWQ3hhVFh5MFhFejRQY1FFT1luOTlmNmppRi8vSXlCVlJlSmhp?=
 =?utf-8?B?ZGk1TmZNY2FmTFJNVG1BaVZOcTBYL3YreTVwVW03NTMzeWdMaEQvQk5NNEkw?=
 =?utf-8?B?cXVEMkdpVy9OWGlEZFhDK3dwRmhUT0o3QzJwVDlJK2hWNHlNNkdrRnYrM0Rl?=
 =?utf-8?B?NTF1dkdXMHZ2cHE5YmVnbm5PSEZBalloYzhrU0wrSnNCdWd2WGZ5cldYWFJ3?=
 =?utf-8?B?UEFrZjFYVHRvV0VTSWYvZS9vM3JNSFg4cEhERTU4cnRjcHQrVnhLcjd3ZkVE?=
 =?utf-8?B?SExValRUcCszVllhMUNJZ2hTRVNBSmpBc21kTW9KcEtvU0dFRVVFNlNUaFFW?=
 =?utf-8?B?QVVnajdxLzVXejh6V1F3VHh3N0RZRE9JZjVtemlBMzhKSUtxaGxWL3BONnov?=
 =?utf-8?B?WjQwSTRqZEkvTi9rc0tWVEN3aVk2TStvT1hxUi9hN3Qwa2kwd1JMOWc2TGYr?=
 =?utf-8?B?N3RVbnRVSFI3SnlZOXRNVHhlVm9maDlaMThxVklwaWF4bE9tVTBnT0lQajFN?=
 =?utf-8?B?RXR4NmRGcUtrQisvV2RGUWFmckVwamo5MGtiTDFmejVnT1Z0aG44bWx4d3VO?=
 =?utf-8?B?YW5zZ2V2bHJyU29NWXl5WXZPVGYvTmdGYjFENmNqWVFHRVh6cHhjRjJTeEhD?=
 =?utf-8?B?bnRtWURoOWRCaExlYnZvU0xUbEZ2b1JqWFdkdXFhbXFVc04zaHdQZkwyZUdR?=
 =?utf-8?B?bERTb3FRcXJIdWZ4c3dxbDBYQVpoTmlkeE9SMkcxVURKSGNrRDNJRzliVzVH?=
 =?utf-8?B?S3E2cjI1eWVlV1BBUEMzcW9zdXh0T3poelRTUFViWXRhc0YzaTlxNThQUFVa?=
 =?utf-8?B?dk5lNllNTjBmVlQzNE5aY3htRkxwclhZeHFXWkY1RTNOdk9KaG5pTXZtOUV5?=
 =?utf-8?B?bUJ2c3ZKTkJPenJUNHphTDd0UmpUK3VLZ0JFSi9ScGNhYkRRQlVQcjRiRk1s?=
 =?utf-8?B?STNnTEZ3eU44TjVsU0h2NlQ2WEJHY3EvR2RJZEhpeHBJcllrNTVGbFpoWUxU?=
 =?utf-8?B?bi81UkhtclRwaUJGWDFQdkMyVlcxdGRyU01GT3RiUzZ0cFhNalhjQXp5MGc5?=
 =?utf-8?B?dmZ4YU9ZS01tUUs3SFFZczNhMGdKUUxUbk0vRnBqczFoM2x0bFZsRGFrV0Mr?=
 =?utf-8?B?ZDdRNElRV0lnandrQWsyU3RwU3J2bUZhRVZ2bjhyS3FJMHB0dnNnU2J5OHZD?=
 =?utf-8?Q?aR/XuGQ7cUwAtLW5LjwWIrKCb4xxa1rI67wE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRDNHZ2djZ0dDkyWENWV2pRaUN4WDZXb2h0UWZOQjlGL3lqTm1sUWhnSGtq?=
 =?utf-8?B?clFCTldZblEwWXRCeDFEQWN1VGF0NTFZYjA4Nzg4OXl4RDcyeTVxSzBBK293?=
 =?utf-8?B?TXZOTkx4UlJrTllRL3Uwb2xuNWJKY1JSTWh6ZUl3SCtCb2dMNWx2bjBnNTJp?=
 =?utf-8?B?YWtZOCtyM0gycVdock5OUyt3L0ozZEV3YnBVb0xOTG04NG1UaUI0SU9EaGRt?=
 =?utf-8?B?NFlXWEd5TDZmazJwRUJMVnYvT05qaW5Oc1RWRDRIdzd4YXFXdFJnUU5uRGk1?=
 =?utf-8?B?Z3o1V3Q2RlkxeGZCcFdqRmlFNlRDREdsZVRacmNMS29GdHJzUDkveU9vdytZ?=
 =?utf-8?B?TzBwR2g0YWxGWHRxc3lxMEhHRVFaRVYxdkdlSFh6aWx4THhEdURocXJTblZI?=
 =?utf-8?B?RUUxd2pNTkd5WGFwWmYvOCtSeGh0N0tTdHB0QWNpVE5ZYnRPM1U0bmM5c09K?=
 =?utf-8?B?TmJoZEo0MG52KzZGbFlYc1FPVWdmNElwcFZLL05oRUVnYXBwWVMzZ3JmUnoz?=
 =?utf-8?B?Z094bGlCQ1ZJWG1haUY1Wks1dXVZODBleGwxVW1yZk93bVdjTEZydUJoMUJ0?=
 =?utf-8?B?dWtvSyttREhwZ2VvZWU2R1J2ajc5NGFlMnJsWVlmQmYrLytxWWNkRk5lNnRS?=
 =?utf-8?B?QzZpWDFHcWVnRGJJWExyWlc0SW1mMzYweVdlaHNUSzBIZ05JYjlOTndITzlQ?=
 =?utf-8?B?S3RYRkFkL3hnVDU2VFM0L0I4NS9TNHJ2bGtYTm02OGpXV1JrY0lVaFdndTQy?=
 =?utf-8?B?RUphQUljdWpJS3R4a242OVBlQ1J1dSttRkNLWTZPVTVyM0VEbTVkWlpZNTkz?=
 =?utf-8?B?bXZkVVgxMXZZQ3V4b2xZRVBEeHFmUDM4bUN1anBta1lxa3NKVjF3cVBxSUhJ?=
 =?utf-8?B?Mkw2cUt3ZGJTVDdHTDQ3a2tFQWkxSnBmLzlVeTFLdjY2MktyRU5tMnV3ZWE3?=
 =?utf-8?B?WjI0alV1NW9OWEEvL2UwMWVkcEh2Q2JMNGdQSkpDR0plSWNRK3orcmE4aXcw?=
 =?utf-8?B?MWh2N1ZRbHY2TnV5UzBQUHNocnNVVThOZlp3Tm5LTW01a1Q4ZTBWZG92dUVJ?=
 =?utf-8?B?cFRkWVlDTkl5T0ZReWJZWGRqMEdqajdKamZGc1FENEhSdmpWb3lQcjhMYU4y?=
 =?utf-8?B?QzV6dnFjVWdyYTNhSjE4ZDhyRkRKQ2xTenRVQklPTTQ3T1B6N3RLckZCakJa?=
 =?utf-8?B?ZFlkM1Z1aFFEdmhicUNnOE4xLzVid1Z6UjdNczR6cDNDQ3lrSzhjSytQSWM5?=
 =?utf-8?B?eVVoRE1FWUdFNkFlTEloTWJpT0hIZk5GeHFVTi96dElmWmFuL0oyZUdqUFR6?=
 =?utf-8?B?aUpiQmtBb2JncWtLNGNZb01sVzJDZjNQNThuT3lYNGRKUVo2NEhsODArTFVC?=
 =?utf-8?B?ZS8vOER6VTA2ZjE2ckdDQ0hMb0dFZERrcWI0Q3NzcjRJWmJkRVhVSWZEYjcy?=
 =?utf-8?B?Y3luWHcrbW5KSm5XNWtTQWRWWXBOZHJVL2l0NXVLQkU3TThoeXY0U2hJRHpx?=
 =?utf-8?B?RXozN2lrZzN5K1J5dFJ0S3E3ZFdQWEhyU2hZSlRua25oekZNNnhqL3Y0N21h?=
 =?utf-8?B?NVZFaU1TbmNJenlrRkJ3aEExSUtKQm42cGFtSm1Vbk5XdHBINlJVQ0lXRjlu?=
 =?utf-8?B?Y29qQ1NZZDVrYXJVRU1LWlEyT1diYU5XMXZpVmRQRDZWZmZhNDZSZDNtY1I3?=
 =?utf-8?B?aVkvU1VCem1IZTVYaE9xaDZDVXpuNW5ta1F2WWRpM1lneVZta1pSUDdWU0lD?=
 =?utf-8?B?VWR4RmtNdXFKV3dlN25NdlNOdzJ5YkhXWHBCZWdicEttM3ZONmRXd2VJbVBa?=
 =?utf-8?B?MitqQUJ4YXVpcUhGRzNVa0JQTm83Q1pOZEVER1RtZEtMdzlFZ2dsK1k5WTZk?=
 =?utf-8?B?K20xTW1xY1FTMEd0SFFIOVRjYUlkM3llWjFabm1xMTZtdVNScGl6QTJ3QTh1?=
 =?utf-8?B?Q2l6aThPRHlCaUNIR3FjcElJc1p6UDE4Z2hvV1lTV05WQUM0YlBsTCs0YW1W?=
 =?utf-8?B?eFdOODhSUWErNGh3MU5xcU9jenlwbnN2eHJKa0V5Nk5XdlBHelVwT3EvaTVR?=
 =?utf-8?B?aTdDNUdxek9MU2d4R2s3QVlFSkttNGxkdDlydzFpeEV5SklrZXFyc3BoUncv?=
 =?utf-8?B?OG9hdm8xRHFUckZGYWVlWUZNdmFVWEg1eGl5Q3Ficm1sVGRJcXFhZjNSSGdt?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc295bc5-88f6-4d63-97ad-08dd91ef2338
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 07:24:03.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAxAYMf0HHrK0xhXxQHVUx3J/y6rYrOH3YzMmqFcFu8m5X2bZZm1lDrcGUxiXd2BtUfcdsuBcS6QP8qOWgcBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com

+ Ben and Victor

On 10/05/2025 12:10, raoul via Bugspray Bot wrote:
> raoul writes via Kernel.org Bugzilla:
> 
> Hello,
> 
> I have a PCSpecialist notebook with SD/MMC card reader. When I insert my SD card I can browse it in Gnome, but I see the following errors in dmesg:
> 
> mmc0: SDHCI_UHS2_CAPS_PTR(65535) is wrong.
> mmc0: UHS2 init fail.
> mmc0: failed to initial phy for UHS-II!
> mmc0: SDHCI_UHS2_CAPS_PTR(65535) is wrong.
> mmc0: UHS2 init fail.
> mmc0: failed to initial phy for UHS-II!
> mmc0: new UHS-I speed SDR104 SDXC card at address 59b4
> mmcblk0: mmc0:59b4 ED2S5 119 GiB
> mmcblk0: p1
> 
> The device:
> 
> Class: 0805 SD Host Controller
> Vendor: 17a0 Genesys Logic
> Device: 9767 GL9767 SD Host Controller
> Svendor: 1d05 AIstone GLobal
> SDEvice: 5006 unknown
> Revision: 03
> 
> Thanks
> 
> View: https://bugzilla.kernel.org/show_bug.cgi?id=220103#c0
> You can reply to this message to join the discussion.

