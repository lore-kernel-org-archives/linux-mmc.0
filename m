Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7F2836AF;
	Fri, 12 Dec 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538289; cv=fail; b=TZ6jWeNP7bo30SmkLJWegkc+uxms/8d6Yx22R0o0B7gejo+g4jnE6hBeb4gVcwKpFlau6He/bveOPLt2o7v90LqlLmj8zSM/bWPbE+djmxTmsWtiudrzirBIjr6oBplaH8APbZXTK+XiToWM2IlEfgg0eS69dRUGqyKNem6aOVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538289; c=relaxed/simple;
	bh=jtmPZW1ouPNQmTX4iuagUu4u7vsp85onR0ANxgbsJDg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0rxSNDKRFe5gLMu5FNqkCY3MMWXmlVzTUMr/TlIz2J+O/narPNJ3OtZHI3O4vK8PQKqfuWSpgJfT738XUzWZTxYo4HcP2Bvj7D0lsIRAk8Hj9d+bONoXkNgedumyorXTgsmfNLQUR1rnp2UsWwZm9LKJZMwv5fdkCd+ugK/xmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsJVBSHO; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsJVBSHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765538288; x=1797074288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jtmPZW1ouPNQmTX4iuagUu4u7vsp85onR0ANxgbsJDg=;
  b=EsJVBSHO0m/CYTZzKHxQCOSl7RIUm36WQcaLy9jQsjs14IvOwkzdC8Cn
   aAOVOKsmAsnMRmNSJ8QGEfeH/zhd2fABCmpwUpjnyMuTJjMErIft5grAB
   6y1vOiPqTZEhIc0bCm2yunvSACsn9jC3glYle8WLyypgOik/k7me20muC
   7oMZP8rj/qJa09IIOcWCnLvgwdXju9pdsbfC0t5uP1FvoA+eQuUdzxXwb
   /EKPAuoNvHPm8L+mK+mG0Zfjizj0LsKuwZ5xEnhigkydqazMcKnR3vZdU
   JzX1r7nTteiGCmafgboes8VDsUhS5XzDnAL+pf2NfoZVBma9rUXgkm2t4
   A==;
X-CSE-ConnectionGUID: i0ousG4eSEOFdKN1GH5xiw==
X-CSE-MsgGUID: Ae9Xph0LTrSShQK7x8y2qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="55099087"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="55099087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:18:07 -0800
X-CSE-ConnectionGUID: +eVhO4+5Q52KaEh/JyWMlQ==
X-CSE-MsgGUID: K7hiIr7cRXytUKknRjgdtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="220438948"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:18:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 03:18:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 03:18:05 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 03:18:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itNY83SDLMYfLKlNNlg+0idJvaFsywv1cA++Qq6dRJ3sf/q+UNQwXDZKFBnYbcYgkhPYQ5BLGHVQVvAZFyXsYcA/sSHE+/Tu0IpU12FHkohLy9t6nMdl29DhQus8XciA626DwBsNFjLIUtP9rLsWSnwzTJyeMciKKRxyntbNvvsyN31Kn+aKAHoEKCfY+9flvccJgAPTBFSD3oDXoXx6qHe5pUkhAKLzXDrcws8cavuTDi8J+nKuP1/7tco/cxZ9q746e7tqZ/mbzMyOmTb/BKTGwJU2V+PsPKoXUgVJwR4NYy3aZrDMeXWX9bof33N1w7RcCJ9/dOOB2LSpcyo0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENeSu3K99dQ7ByIFY53TYYCSo5UlzHizvaXPVXzQND8=;
 b=fDOCHr4n3Ztu5vguTTLfHZI330Jj1Dgkkh0wBEq+TVbmiPs/6sHy1TJhAoo7VBiLaoGSM+WqPtEyIpKXRbM3RnzOyhZ8WH+exSyIwHTnwJQbsGyZ3a5WSZmUy6rFV4uVmhel63r9kLsj0dIzuL6pBYdnNnXXlD2cICzDlZPW4r4l9RdA/kC9u4GJyZtAgGoxH07Dx5SWu8l7nlr/x3DfhTWiHMydqC0NZel04+e2dqNzm7BmcEUe9x64m6D0E+XHfjqj9SVUkPPIHdVYXwQ5DymqpzlJ/ERIUgJeSeOVcoFbeskGGiXxGhDJOWP4lRd2doAfifZ+4/BjBiFGiC0NSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW4PR11MB6716.namprd11.prod.outlook.com (2603:10b6:303:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 11:18:02 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 11:18:02 +0000
Message-ID: <9744b89a-9a60-4f04-bcca-526a6bb7eddc@intel.com>
Date: Fri, 12 Dec 2025 13:17:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Increase CD stable timeout to 2
 seconds
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, Michal Simek
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <saikrishna12468@gmail.com>
References: <20251212063509.2002910-1-sai.krishna.potthuri@amd.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251212063509.2002910-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::34) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW4PR11MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 02578886-e249-4afc-3f38-08de39701d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFZQYnQ2bS9zUklxRGx4WkJZUzNvZHlwNFQ2eVpBcnVOMHRpVXNVenFCVnJy?=
 =?utf-8?B?bjIraUtUODBYZHNxMEMwdlNERkNkUXE3RVdicnRITkZPa0c2N3d5U3Fqdi9Q?=
 =?utf-8?B?T3lMYllLVTBiVnpuZURySC8xd3QvSkdGVksvdlRSMlhrYlBLeUhaVFMzdUw3?=
 =?utf-8?B?a21DQWlseGgwUWp4SCtmdE56TG9IN2RPSW5XREtiRHVrSVNrV1VweGVkQWUx?=
 =?utf-8?B?QkFSK2pVMGRGSmtwUnZMSVl2bWVLaXZxYmxGN2N1TWUyZVpaNVErZmlHaFZX?=
 =?utf-8?B?R0tLaXR4VThVdjJXWTEvYTdKZTFNT2taUGZPby8rejhuOFlCeUVNaEdFT3la?=
 =?utf-8?B?WGJVb25HaE1PcUtleFJ6RU43N09PcGh6akNLbkJzUkcvU0FBdUYwcWlDdktW?=
 =?utf-8?B?RWNJaTdaQUVQN0Z3WSt1UjNwZnhKZXRxUmFvT2Z5L2FxSGFYaW5oSlN3cjUv?=
 =?utf-8?B?WE05NExtQ3EwOWtya2Y5cUNMeWFqVU8vUzY3SVhXVHY3MGQzNWQxc2NBb2VO?=
 =?utf-8?B?Q1huYkV2Y3FpUHp1SjEzdTU1bkRKNDA1OU0ybzVWcm9pNVlLdWZUQ2EzclFq?=
 =?utf-8?B?VnE5VmU3cEUzanNkamN0MVAxSTVzMndCVndYOG1oTnIxSUxKa2U1QXFOQ1Ay?=
 =?utf-8?B?c2YzWFp1VE1XSTR3UmprUHdYSFhnMjc5V1RWZWRRNzJESElsSkxWZThjQ1gv?=
 =?utf-8?B?cTVYd0hvNW1oUXJGRlFuYWRqaGNGMFRSZ05XRDVzYzM2NWQ5cEdTcVhMNlBk?=
 =?utf-8?B?Q0RsYVhQMmFWcTZWWUlTYXRCczJUaDJkZDRwazgzZk03T2c4bHNxcFFHRHZP?=
 =?utf-8?B?MzlsRFlONU5QUThtdmx2SEJpb21JaGJOQ285d24wNEQzbjZ5SzdUditpby92?=
 =?utf-8?B?czNIWVJ0L3FEZ29EeXVlOGV5eHVxZEY5ZGRhQjdpcmVGRVA4OFZUTlNrbU9z?=
 =?utf-8?B?RUw0cUVFTkUvdFlOTHJWUkFpS2JPRm5uQjNZQ0g3MEdVMVRjeXVqb21MaFRk?=
 =?utf-8?B?VGxyTkZ0ck9ZMm1yNWJqZ2Q1S2NJYU5xbllWU1V4VUppYU13akgzTXZsQVlT?=
 =?utf-8?B?NlF1QmZtZktyRlNtU3NZUnozQVpJQ3lRVElndXV3Tld2TUVseXl3cmJsSVNL?=
 =?utf-8?B?Q1pYUU03V2tiNzVnbUZaWWpqTnpqYUkxVEtUY2ZzdFBUbUlmcStHNHdWK0la?=
 =?utf-8?B?NzBGTUZKWUM1amx0YjhNNGd4b1Urc2JXTkxQZ0N5Vk4zdjNXemVZUlRuWWRa?=
 =?utf-8?B?RzV0S1BxVWlkUC84bU02MThISyt3OFBDUVJjY2dvWlN3WDNkRGR6WitCdzBG?=
 =?utf-8?B?YjBYVXA3OTV0RW55Ujk5dkt1azBhcTcwZ0dwNzdndG1VZFNZQ0ZkaVkwNUw5?=
 =?utf-8?B?M0NKdHY0M1pqUlFzUjFsdTlmdFk4Nkk0WTh6aFhBeTB0NUVDR1dRcGFoWHkx?=
 =?utf-8?B?U0Y1YTQ4ZS9xZ2g5THJjVDJ3eFg2Rkd4NnBaMWxiMTc5VVF0WXd5bE1saDFU?=
 =?utf-8?B?MjRoVkp5NzZQTEpidGRFYnltUm5aSENLWW03Y29Ia2tFdEV0RTVZVUZDU3Vz?=
 =?utf-8?B?QklaKzg3U2VMRCszek5ZTFE1RURNSkNTQ0hONzNFWmVxeXBOZzBWWVN6amZr?=
 =?utf-8?B?TWhSWFZEQ2ZZT1BQUk5RQVE5Z1IvZGJzTkJiaXQvMHd6ZEI0S2VPazNjazRG?=
 =?utf-8?B?UENoa0pHNS9mZWdkTGtPVWtiQkkyVE1zUDN1ZlJ4MGtKUER6QUhyYmYvMy96?=
 =?utf-8?B?WGV2a0xEd2ErTFA0eHhWWTJNQlRLSnFhSnFOMWt1UlR6YzRBTUdEb3NENnI2?=
 =?utf-8?B?QlhNYWYrT1cya2NvZkNjREtSd2NVUitoU1kxSnY4Vjh1UitTc2lHWnRaYUFm?=
 =?utf-8?B?YVJHQ3huMUxmNW9sSXAzNHRkb3NFZHpLQkRYWFcwTEpablpTcFBmQVZ2OVdu?=
 =?utf-8?Q?IS0a3KYxwfqNGvnZyTUMeLHnFzk8YbXc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVlMzB2ejJVclNaT005V1RzU0R4ZWc0c3NKK3hpc1J6WG5OazV0N2lkOFA4?=
 =?utf-8?B?UHJaaDhWa2V3Z1NEMHV5NFh4eWRBazk0VVJqdzBuY2ZHMHVVbmhJVVk5dHNK?=
 =?utf-8?B?dVFQR1RhWS9rTFg4TmgzdFpSb05VQUdscXhMKzFEb1lnaERSQS9IY1dIVWlm?=
 =?utf-8?B?M3B5TUxXc3FXQ1hjeXhLQ2htOVR0eTBPcWI5ZmVQVlJ3bVV1YnF0ZTRseVRL?=
 =?utf-8?B?T2JWN3BzamR0Z1RaT2Y0dnNhOWtrbEs3elh2Z3RyRnNjeFVqWUlwWFEyeVhB?=
 =?utf-8?B?NGYzbTRmcDZqb2d3MWVtUTg0bVowUEF0dGF1VWxFRDEzeFNvQzlJbVBIa0M1?=
 =?utf-8?B?a3ZVSURkOWorN2p5Q1FlTGg3VXFUSUtLNHdsYjN6azVITTN2UVYzZ2VDK0ZJ?=
 =?utf-8?B?SG5XWTlDZzhHMlhOR25KRm5aSjF2aVR5MzY2RzZ5RUJXNGxhSjRMNnJObHhF?=
 =?utf-8?B?eUFqVU1pRmpkbFpRajFpbnl6UG5OUGRLQis4b0w5WCt1UXZzN1NackxGN2xO?=
 =?utf-8?B?dFVCZGJnajZTbm5JQitOeU5qdWxndjl1RWc5YWNpekd6TXZ6cDBrSmNvM1N6?=
 =?utf-8?B?RXNNWE5KU21GSGpPT282S3Z5Ymt2d09Db1BvalhZbVhsRHhPTFR6cFBjVEhy?=
 =?utf-8?B?emVMR0IyOUFscE1wbmN2bXUzUE1nUFA5bTVQSEY2QUwydm92UTlpUndpVWdY?=
 =?utf-8?B?R0tOTngvK3J6NzlLNisyNm5yWTZHeXhHQUNlbEh0amEyQy9mdEZYUVU3Ym9j?=
 =?utf-8?B?S0pGS1VqbWFFcTEwNUVtRnhuUmQ3Y2FMK0VTVGZPVk1QNjFNN3ZOejQ5eXpR?=
 =?utf-8?B?NlFvSGR6bWtmNmhPb1Y3MjZnZVFrdCtXRkJZcFhzZnFYSnNFRnJhOWE3R0JG?=
 =?utf-8?B?T1ZycXZ3bDlqR2ljQk56cTI2Um9MWDFpTlRsanNYOU1JWW1sSTJYN2hjTnR5?=
 =?utf-8?B?Mmdkb2tmTlNIcEREOE9oQ1pDMmxmRXJPRzA4ckg1VWtZTzdtbXdJcTRBVnNn?=
 =?utf-8?B?NFlTd04vcU5GUXo4V1Ara1QwZmRFWTBYSG9qMmpNckFBYUhDaHZCd2crRFdW?=
 =?utf-8?B?cjdZUmg4YWg3RklJNWk1K2dJeXlFOGF5aWpRU2tpTG82L00rekZacDcrMEQz?=
 =?utf-8?B?YXBKcnpDTm1YdVlUTFU4UnhvbHZOcHJrQlc4LzFQQzVvOFhlRjZpdUhBaDUz?=
 =?utf-8?B?NUNXenVIdHpuSk1ZZGg4U1c4dUFUT2IyeHU4U1drRkFIdmNNR3NxbFBGNzJO?=
 =?utf-8?B?cW8vV1B2NTBObXBuSnNQTDI3YWt6YjQydFVsQzZ1Vkh6NkE2SlI1UW5JZ2ZG?=
 =?utf-8?B?VXZnS3RuTUlBUUJiZzR3enVXNU9ENzlXRW03N0I5MVRXVjJBdG0yUXBaR0lt?=
 =?utf-8?B?c21nUjQxVm1pMk5NeW1sR0EyWXVWTDltb0pRQk1WUWlFUi94SHdHbkZ6ZXdk?=
 =?utf-8?B?MjNHQ1NFUGp5OEdtUVhsdWxLLzVaSktlMGxud0R5TWVGdEpsLytCY0xuOXFn?=
 =?utf-8?B?cW15Y09Qb1JiTkQ3emtWYjJ4TS9raFZJVWdyWGwzbUZ0TzBJUy9hVUZuQTFC?=
 =?utf-8?B?cEVxZ0hWWWkzaVo1WkFSeHR3SG9tTkJyWElIcHBxSHd0YzUwOVRxdTk1VTRu?=
 =?utf-8?B?cEFLUUM5cE05SDFHTFZWUGVMSlNhTForQThsS081blpEV1U1Z2VkcDlFS1U1?=
 =?utf-8?B?cjhPdFp3NDRSNS90eXRKQWVoZUpnT3BjaFJhK0w4cnFWSEU1ZExFSUJsSThn?=
 =?utf-8?B?Z1Z4QTJWOGpzUzJ2dFdoZVkxb1NoMlhIaS9KSUJqcmVpVTV5R09UNWw3cXQ0?=
 =?utf-8?B?cHlXaXNCQ0I2TlRHNFFuckhlT1MxWTNRTVdmQVJNdTI3WnZaTjZDNWZBb2dD?=
 =?utf-8?B?NnlVK01VMHRDL25QZmd2Y1M2Z3I5NlUzWXBBTnBYT3p1bFo3MjlvcHhhSVVT?=
 =?utf-8?B?d2lidW16NzBpVXpPVm9GaGdVTllUZ21XbldDRWJIZTJ1bmtmZWpiOUg3TjF1?=
 =?utf-8?B?UEwyOFhmQ3lFT25wQXlVcWdPNTFpRDVUM004K1AxclJkWktnUXpoaUVqTXBt?=
 =?utf-8?B?TXJaVFNtazEzd0xyRzQwc0NnVWFzK3kvM2hWU0pEMzlyMVRQL2dzSGhobU4w?=
 =?utf-8?B?Um5TL0tZY1RRL2pWMzVUcnZxYUFuUTlOYko0aklRRDB4WEZ0ZEw0V3I5TGpC?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02578886-e249-4afc-3f38-08de39701d0b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 11:18:02.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OzUWlKW6kaGQyTBD8qvEg62of9LlmwZqzbchBi/5REGIQ7qvblKohrr09LWrEW+6q0+ekZEN1bzPU7vArfOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6716
X-OriginatorOrg: intel.com

On 12/12/2025 08:35, Sai Krishna Potthuri wrote:
> On Xilinx/AMD platforms, the CD stable bit take slightly longer than
> one second(about an additional 100ms) to assert after a host
> controller reset. Although no functional failure observed with the
> existing one second delay but to ensure reliable initialization, increase
> the CD stable timeout to 2 seconds.
> 
> Fixes: e251709aaddb ("mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up")
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b97d042897ad..ab7f0ffe7b4f 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -99,7 +99,7 @@
>  #define HIWORD_UPDATE(val, mask, shift) \
>  		((val) << (shift) | (mask) << ((shift) + 16))
>  
> -#define CD_STABLE_TIMEOUT_US		1000000
> +#define CD_STABLE_TIMEOUT_US		2000000
>  #define CD_STABLE_MAX_SLEEP_US		10
>  
>  /**

