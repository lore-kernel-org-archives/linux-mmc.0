Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018B3BF69F;
	Tue, 17 Mar 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749903; cv=fail; b=tkwedINfHLhzuKWGsZ2cBYs3bBE3b62SzXOpD0tsJWf3bam1Ah6T0f5czyP9NmQGjIWOUglZM25kZ/A41u9NvHpbbQEH+/7p82pSNr3b08qmf2z5LeZ5PrtJAeAKW292XCyn+NtpIhzyzDOX9nB40+H1q6vbhtuHtsgZZxqBMQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749903; c=relaxed/simple;
	bh=p2wqMCxrjtAnlerll63crcH7XjsDNuATZXJU018GCZE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=knGBlQv+TpvkvSaPbSbnVlUf4j0+ivlDgyehmj4bAJvMYBeTp6MS9UR1tL7Xz8dzhbivu+Swt9oR0AgBecanCsHJU1rHb1XhbC6Jn8El1x8u8ndTK0GEJyZdHVIPo1crymA7zzksWUr0uga3blm4cnBOhkNb5Wr7cpBbk1n4Z8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtvV1Il1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtvV1Il1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773749900; x=1805285900;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p2wqMCxrjtAnlerll63crcH7XjsDNuATZXJU018GCZE=;
  b=GtvV1Il1fcoMQC9KBkZBymKJGGv6KoEcI/MRRm6v5XXuF27X66Uuna5p
   DLhe9WpatTrNqv1/67LPIRF778jhAEexC38Bex6z6tX9PF0uWQoXbFrPq
   L7ffJb7q10PnmaYRA+MXLAFEKYspFbPihrH1XnjjSnreNoO8rk3lBEejx
   cYkPiRCDZ7YlQx1Lo4IOmFrEQ/Ba+ibn2yENdoUlNIMz3YZdvFDBk4Lzg
   H9uxD94hbVjU6jAOrxCHeWbOv2l3NG7zzTldmsf0hMKq0meIZqZvoMcHY
   gNngflOhMdqUVG4h5E6GqIkfK6XEo+LoGW11LxnsYoMggZjFpSxwURdJj
   Q==;
X-CSE-ConnectionGUID: EVl8ZDzHRW+5H3QkdZCyFg==
X-CSE-MsgGUID: LzMmeyQyTzepGWDIcyb8hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85095724"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85095724"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:18:19 -0700
X-CSE-ConnectionGUID: tCvAjvA7SmWJUzUA7ipZgA==
X-CSE-MsgGUID: E5I1B5CyS6K9idqz70V1wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222201560"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:18:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 05:18:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 05:18:17 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 05:18:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0LYIVMoc+KIv4b/blk0QbhcNeAf9aKx4ICT/uCxIPsloruSM+ngXHcIYrPjdhdJXattDC9EoiaZz0hHEbr9FMisI0neypOvcK3Ttx7XN+QjAsfJQJxu+Wyq8vlyZXXsyN98E4X9/QGAnxg+HpP+agmzkJcVoMyFH6UApIkk7wvOk99iGQRj1dkajz+91jWu4uaF0XSxke4+T9PJRtGgyI3aBXIiDkVgYDo+Ua2FpzIxLVkMbfRTwotpRVicrdOyOGErguUmN9kUxbRwvLm54CNZlrTNWvn9Q7o9AgFdDUL8pTIR0sERH2nepqQ0FhS6HqXA/uGzFZC/6BzBJ0WBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMZbMfzULvgreNaqfyngaKOEUxMNidMRTQVy3hVKiDk=;
 b=M5ZDNxasl4HlQMAKSBYr0WxMEFDwAb7maCRo8ApLaDAuR90LuXdgsw3BLBfUZwb9HUJjYkymQxLfYjyePKLNa7eQv2dnAQjiWSsd3Alq6B3ZlTd4+nSRwqFhSJzjJ1Z1unH4SAScEERazOHwvMECozZH/3DDdqr6se6MvRyuLTZssTXkLFeY3Jn0DhC02MF5WhiY5Mw1lNlTLCKs4XL8VsQtXew3PBR+UNJMr5OgbGujB8pjAH7HfKbgCHr3AvFU8AjSqTJkbOfaJpQWqKiiPLjTFWfYwnv1y/hqaxAfNRQAESv9JZd5N6viQR0CXm0zizmLgvnMrpMusIsfGClnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:18:14 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 12:18:14 +0000
Message-ID: <77df0c0e-a8e6-43af-8b61-7ddf6449ea4f@intel.com>
Date: Tue, 17 Mar 2026 14:18:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: <nick.hawkins@hpe.com>, <ulf.hansson@linaro.org>, <jszhang@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<shawn.lin@rock-chips.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260316150115.2616827-1-nick.hawkins@hpe.com>
 <20260316150115.2616827-3-nick.hawkins@hpe.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260316150115.2616827-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::32) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM4PR11MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e52668-33e7-46e4-eb80-08de841f4296
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AXKZurCrrb+I+0LpiRvm6zGuhjHRdw5jaQbH6NxpoYPpDzXSS9uw0ZJXYI2PROtUBg/AJr7w/M3UyRsrKfqX/CKZEW/a/aZeCBUpgmM4NdMNzlURNZdoI3j1pb3EX3ZjiG3BzUG2YP3H5tZHditpxIcuv4SbNTRX8wrSjy2LYdYDi1vJ9bGzv4GrKaSViUdxtidw4/fL/2nCd4iy30O00vQf6FTByecXOj2AtD3p1QFNIRmaGgVhtGHM1UA7lNkg54nwYtP4p8LmfJe2RVLxjpub/CHAv+zh/AzXuqgw/NhkISrZzSNMConWv8sP3QQBwIrSKhPHB2KdyzD98miipCzyeH1D7MsOFKTLBOI/gwJIkAWg3Cg1VK0n0zNjtO9h5gQLC40Y76kox0MPLgpY22TVg4iG9uL1K3HA9/vbzyKoO34VmNWv0XE94CzREpFH7Yc9szqLHHsLljcDlz+t6BQXudNNqlwT8k9XZYb3M2BhWENRJn/h8H/uZzZnMf9/TIcCvPgm8HrpzHF5FLAKDkCqQzIJQiDrPWCkndcv9JP9NgtmKVNJBTNzPw+xjtwEJ+4hNxHE4EXxNz06XJNVLbTfUvxXWXBFxvnBD+S2YbabNHBmU+q41SV5siqh8QkUjfn8/mO8gzrikXmpuX4U1vg9bTCBwuoZHJRHLNjLyLrphueJmU4VjhAAiGihMgkSzoa2TnA0e0wrfOz4WGjtb4/QoTNH3UR+jNngOYhR1bQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dTemdmQzMwYkIxTGxldmwzWXp2OEVBbEtOeFN4MWJnbkFCNkVYZGxPR1lI?=
 =?utf-8?B?eXpLVFR6NnFjQVMwZUdOSEVSVm1QUVpCQXNKK28zRzI5WGd6elhSYzRzbDRI?=
 =?utf-8?B?aFU0NVlpQ2UzMDFSdkdtVFFaK1pML1c5eWRIZ0QzazBUVHBsZkMzRDkwZjl0?=
 =?utf-8?B?eVQ5T0N6dXdwbHdXaWIzenVvaWY0OGthRnduNGdOUmxBdmEyaFlhbWJsMHZq?=
 =?utf-8?B?a3Y5WVhaZkVDUEh5dmxZQW1GSWoraThKSzI1Q1Nzc1JSMGRSOE5UOHFFMElH?=
 =?utf-8?B?Qjd5SlhWaDVjM2tSR0xOaC81K0RMTWx2c3BBSzVRS0NwbTRXbzdlNnNJTFI0?=
 =?utf-8?B?MHZMOW1pbTRYQ3pGZVBvNnJBMUUrMkttd2VZeUR5NFdnVmxxQ3V0a3h4cVA3?=
 =?utf-8?B?YVRrRWo2V0F5d012YVlqSkVnMFZlTUpkcnFoYURObTdnR2c0c0YvSG0yc1M1?=
 =?utf-8?B?YjZMZHJXa3hYOGZEdmpuM2ZMM1E1MG5ldWM3YzhOSDBHTkxLTWI2WDNTVVVw?=
 =?utf-8?B?dzRLdU9xQXpiNDJKQ2RUdFA0WXgzK2dpaS9CSnc3aWZLWFB4allHam9WNXdF?=
 =?utf-8?B?ZW9VZk1JT2lOL3pWSnBWQzEzSWF2RG5oTGZiTjNzNk82SEY0VDRFVUlidGFt?=
 =?utf-8?B?eWxsMEM1bUtnL09mVjVrT1AxMkQ1VHp0NjhKSmxCR3VyYlk4M0FTUnZaS29M?=
 =?utf-8?B?YWR2SUc5OUh2LzhoSWVVNnJRVERRS09KYTRjTVpFVWMzdFV2RTY0ZTYzTUVP?=
 =?utf-8?B?M3FJcGpiV0NMTWlndFlPS0R0Z0JHcWcvbnh5cTFmNVJoZmM5Slc0cTAvTWJw?=
 =?utf-8?B?N21GNVpEY2xFVmsvaU96NXl1T3pvYmpTUGRjUzJwOEdGd3BWUXhpMzNPMUVP?=
 =?utf-8?B?UGtRS2xxYithblJlWHVzUlA5WTVjWTRJdGNTU0t3U0J5L25TOGlmSlFtclEr?=
 =?utf-8?B?aWJnaVJVQzJ2dGNlZmFnamxhSS9aSHA0UnVISm5RM1F1TVhNZUpnM2xEUnU1?=
 =?utf-8?B?RTc4UUlsOHZQRFIva3k4aTBCd2gzM0pBRmtkQ29BdExxd3Nyb25KZDJyRGJ3?=
 =?utf-8?B?cGgyaTlEbUQ3dkxjdjNrT0JhU2hEY0lTVUV5ZEZ6d050OWIwV08yZG1vQ2VE?=
 =?utf-8?B?TlRtVURYc1RDL2xjWmtYZWFNN1RmdTExcW41OExvazFhNXJ5ZitaVVRIcTNh?=
 =?utf-8?B?K3l1cHY2S0VGSFB3MHlFNS9lcm5pMEpGMXhyNmozU0NRWnJER3J4bFNMT2I4?=
 =?utf-8?B?RERNakZWUHd3YWorTFJrTEVzSTVvWkVxWmNCYytBUDFBSmlCVEZSNEo4TjBa?=
 =?utf-8?B?R1I2MDFzeGk3QkZVMWlVbThSR0wxK3VYRDBXcEVCU3BwVWM0eU01WkZCMDZo?=
 =?utf-8?B?bktrMU12cFdBdnU1M1VseUFrTEFoeWxrT0FNM0padU5mZmx6KzR2ZEYyekNo?=
 =?utf-8?B?MDVYSUF5NWRRc1VOZXViZHVVL0lEbU9DZnljV01QYk5NM2crR3FOTFZaVHEv?=
 =?utf-8?B?bzBSUTI4NVlDZ2w1dk9ETjNPSm9HZVEvUzkxeXBqRWZIczZKb2tQRi9TalE5?=
 =?utf-8?B?UnQvUnlzbm5kQ0VJenVjR1JUNjUvQXh0U2g3Q09aMzQ2S3RlbVpoU2dYTG9x?=
 =?utf-8?B?bHN1Wm1wci9DcThhVUN6S056ZXFsM1pyR0ZTbndxYUZkOW5TRS8wQnU3dExU?=
 =?utf-8?B?YmtvQlozbjBCWWFaZWRoVGdZWTJydmxUbklsSGRDdTc2Zk9lLzIwaTVDc3pv?=
 =?utf-8?B?MFlxek5Jb0ZrcW9MbHYrRjdTdWs2Q3RnNEhqMUhQNEIwaVhtKzU0L0t3eGhx?=
 =?utf-8?B?Nk41VDBEOXFxVVZkK2VmdDVUcFRVTmNTbDRrVkd3dWEyMXlueUtrdG04aUNB?=
 =?utf-8?B?U3kxalZWYldicWhBd25wSTc3R0JYbldWa3dPcGdBUGVXNEVVZ3pZVXkxMDgy?=
 =?utf-8?B?My9NUkNZNnZtak1WME10UmRudDk4WVUyMTRLNFhlL2Vmd2owNUgxM25tQUZM?=
 =?utf-8?B?SzhmamNCOXo4ai9ocG41d0tFWm92Z1R2dVlCbGJMajI5eW5yOTNoRE1DeGFC?=
 =?utf-8?B?MHZqd0RSZSt3NGVNTDE5WWgyUmowcUhya2U5QkZWMmVXRTViTzk3S3JVOXdN?=
 =?utf-8?B?OWdXY0YxVGxFNzdvSkxidVlqWEhPWTlRSXJwT01zT0k1blhkd2JNSU9ObURL?=
 =?utf-8?B?ZEQ3VWRubmdWMXdsdEhOSmxoZkJLQm9BaklibERjR0tHRG1yRzViYzRFQ0NV?=
 =?utf-8?B?cCtBSWJTb3Z0Q0lZM3lFQWNUaXF0ZW1pM2JUTERuWWJuMkZxcndMYkZWTEZ5?=
 =?utf-8?B?K2xFZkdWeTlqQnhyNXhTcHR5YW1WZXh1NXBEME5iRFJlMkI2eUEwd1VHK3Q0?=
 =?utf-8?Q?mLUMfVLwVQn8j9+I=3D?=
X-Exchange-RoutingPolicyChecked: GoTeK2ux80Jw7o32TVAhlmkSFJ22YW3VDbuQC9im32Lgh1KCr2n+2XG5pBbgGZnKxcIRs4E/lEnB5F7RPDUbAV8IGUDqjLpzkp+fE0fZgUa960G3Y+EL5KbehAmYFQaCPCWcRrz3x1lE6NUCdSHQMPQxFWsJ0mr+VhXVbAsOOJUvb8dDO+Pkd2CPhK50WHn6xqkCxbQsEFIWGXhmSXFxzqCt+NIaX390+R5qAw8CnsfdJLLr318JKjrwtsj2oyPTwV51A32u5HJ1D1yQRSHSSh4Mpic8xzzc1ko/5wksfs4M79lW4LBfY4xt6lYX9zOpJqW7lKUP+4crQyl+Rb9IuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e52668-33e7-46e4-eb80-08de841f4296
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:18:14.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cWN/rODaiZ8s/ORN5OeTL9oTQwgIJYQdKeHRu5/1FFIrE5c/vXWFvwFB6nMDN/Ft2uBK/IUhuOLwGv5/Vy1wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com

On 16/03/2026 17:01, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the eMMC controller integrated in the HPE GSC (ARM64
> Cortex-A53) BMC SoC under the new 'hpe,gsc-dwcmshc' compatible
> string.
> 
> The HPE GSC eMMC controller is based on the DesignWare Cores MSHC IP
> but requires several platform-specific adjustments:
> 
> Clock mux (dwcmshc_hpe_set_clock):
>   The GSC SoC wires SDHCI_CLOCK_CONTROL.freq_sel directly to a clock
>   mux rather than a divider.  Forcing freq_sel = 1 when the requested
>   clock is 200 MHz (HS200) selects the correct high-speed clock source.
>   Using the generic sdhci_set_clock() would otherwise leave the mux on
>   the wrong source after tuning.
> 
> Auto-tuning / vendor config (dwcmshc_hpe_vendor_specific):
>   Disables the command-conflict check (DWCMSHC_HOST_CTRL3 BIT(0)) and
>   programs the ATCTRL register using existing AT_CTRL_* macros:
>     AT_CTRL_AT_EN           auto-tuning circuit enable
>     AT_CTRL_SWIN_TH_EN      sampling window threshold enable
>     AT_CTRL_TUNE_CLK_STOP_EN tune-clock-stop enable
>     PRE_CHANGE_DLY  = 3     pre-change delay
>     POST_CHANGE_DLY = 3     post-change delay
>     SWIN_TH_VAL    = 2      sampling window threshold
>   This combination is required for reliable HS200 signal integrity on
>   the GSC PCB trace topology.
> 
> eMMC mode (dwcmshc_hpe_set_emmc):
>   Helper that sets DWCMSHC_CARD_IS_EMMC unconditionally.  Called from
>   both the reset and UHS-signaling paths.
> 
> Reset (dwcmshc_hpe_reset):
>   Calls dwcmshc_reset(), re-applies the vendor config above via
>   dwcmshc_hpe_vendor_specific(), and then calls dwcmshc_hpe_set_emmc().
>   The GSC controller clears the CARD_IS_EMMC bit on every reset;
>   leaving it clear causes card-detect mis-identification on an
>   eMMC-only slot.
> 
> UHS signaling (dwcmshc_hpe_set_uhs_signaling):
>   Wraps dwcmshc_set_uhs_signaling() and calls dwcmshc_hpe_set_emmc()
>   to ensure CARD_IS_EMMC is set for all timing modes, not just HS400.
> 
> Init (dwcmshc_hpe_gsc_init):
>   Obtains the SoC register block and MSHCCS offset via the
>   'hpe,gxp-sysreg' syscon phandle argument and sets SCGSyncDis
>   (BIT(18)) to allow the HS200 RX delay lines to settle while the
>   card clock is stopped during auto-tuning.  Enables SDHCI v4 mode.
> 
> Quirks:
>   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN:  base clock not advertised in
>     capabilities; must be obtained from the DTS 'clocks' property.
>   SDHCI_QUIRK2_PRESET_VALUE_BROKEN:  preset-value registers are not
>     populated in the GSC ROM.
> 
> All HPE-specific code is isolated to the new hpe_gsc_init / hpe_ops /
> hpe_gsc_pdata symbols.  No existing platform (Rockchip, T-Head, sg2042,
> etc.) is affected.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

If you re-spin, there is 1 cosmetic comment below.  Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 147 ++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..f4c5c1aa0ebe 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -40,7 +40,10 @@
>  #define DWCMSHC_AREA1_MASK		GENMASK(11, 0)
>  /* Offset inside the  vendor area 1 */
>  #define DWCMSHC_HOST_CTRL3		0x8
> +#define DWCMSHC_HOST_CTRL3_CMD_CONFLICT	BIT(0)
>  #define DWCMSHC_EMMC_CONTROL		0x2c
> +/* HPE GSC SoC MSHCCS register */
> +#define HPE_GSC_MSHCCS_SCGSYNCDIS	BIT(18)
>  #define DWCMSHC_CARD_IS_EMMC		BIT(0)
>  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL		0x40
> @@ -1245,6 +1248,127 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>  					     ARRAY_SIZE(clk_ids), clk_ids);
>  }
>  
> +/*
> + * HPE GSC-specific vendor configuration: disable command conflict check
> + * and program Auto-Tuning Control register.
> + */
> +static void dwcmshc_hpe_vendor_specific(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 atctrl;
> +	u8 extra;
> +
> +	extra = sdhci_readb(host, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +	extra &= ~DWCMSHC_HOST_CTRL3_CMD_CONFLICT;
> +	sdhci_writeb(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +
> +	atctrl = AT_CTRL_AT_EN | AT_CTRL_SWIN_TH_EN | AT_CTRL_TUNE_CLK_STOP_EN |
> +		FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, 3) |
> +		FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY) |
> +		FIELD_PREP(AT_CTRL_SWIN_TH_VAL_MASK, 2);
> +	sdhci_writel(host, atctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +}
> +
> +static void dwcmshc_hpe_set_emmc(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	ctrl |= DWCMSHC_CARD_IS_EMMC;
> +	sdhci_writew(host, ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +}
> +
> +static void dwcmshc_hpe_reset(struct sdhci_host *host, u8 mask)
> +{
> +	dwcmshc_reset(host, mask);
> +	dwcmshc_hpe_vendor_specific(host);
> +	dwcmshc_hpe_set_emmc(host);
> +}
> +
> +static void dwcmshc_hpe_set_uhs_signaling(struct sdhci_host *host,
> +					   unsigned int timing)

Unnecessary line wrap

> +{
> +	dwcmshc_set_uhs_signaling(host, timing);
> +	dwcmshc_hpe_set_emmc(host);
> +}
> +
> +/*
> + * HPE GSC eMMC controller clock setup.
> + *
> + * The GSC SoC wires the freq_sel field of SDHCI_CLOCK_CONTROL directly to a
> + * clock mux rather than a divider. Force freq_sel = 1 when running at
> + * 200 MHz (HS200) so the mux selects the correct clock source.
> + */
> +static void dwcmshc_hpe_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +
> +	if (host->mmc->actual_clock == 200000000)
> +		clk |= (1 << SDHCI_DIVIDER_SHIFT);
> +
> +	sdhci_enable_clk(host, clk);
> +}
> +
> +/*
> + * HPE GSC eMMC controller init.
> + *
> + * The GSC SoC requires configuring MSHCCS.  Bit 18 (SCGSyncDis) disables clock
> + * synchronisation for phase-select values going to the HS200 RX delay lines,
> + * allowing the card clock to be stopped while the delay selection settles and
> + * the phase shift is applied.  This must be used together with the ATCTRL
> + * settings programmed in dwcmshc_hpe_vendor_specific():
> + *   AT_CTRL_R.TUNE_CLK_STOP_EN  = 0x1
> + *   AT_CTRL_R.POST_CHANGE_DLY   = 0x3
> + *   AT_CTRL_R.PRE_CHANGE_DLY    = 0x3
> + *
> + * The DTS node provides a syscon phandle ('hpe,gxp-sysreg') with the
> + * MSHCCS register offset as an argument.
> + */
> +static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
> +				struct dwcmshc_priv *dwc_priv)
> +{
> +	unsigned int reg_offset;
> +	struct regmap *soc_ctrl;
> +	int ret;
> +
> +	/* Disable cmd conflict check and configure auto-tuning */
> +	dwcmshc_hpe_vendor_specific(host);
> +
> +	/* Look up the GXP sysreg syscon and MSHCCS offset */
> +	soc_ctrl = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +							"hpe,gxp-sysreg",
> +							1, &reg_offset);
> +	if (IS_ERR(soc_ctrl)) {
> +		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
> +		return PTR_ERR(soc_ctrl);
> +	}
> +
> +	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
> +	ret = regmap_update_bits(soc_ctrl, reg_offset,
> +				 HPE_GSC_MSHCCS_SCGSYNCDIS,
> +				 HPE_GSC_MSHCCS_SCGSYNCDIS);
> +	if (ret) {
> +		dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
> +		return ret;
> +	}
> +
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
>  static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1834,6 +1958,25 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
>  	.init = eic7700_init,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_hpe_ops = {
> +	.set_clock		= dwcmshc_hpe_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= dwcmshc_hpe_set_uhs_signaling,
> +	.get_max_clock		= dwcmshc_get_max_clock,
> +	.reset			= dwcmshc_hpe_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
> +};
> +
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_hpe_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
> +	.init = dwcmshc_hpe_gsc_init,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1942,6 +2085,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "eswin,eic7700-dwcmshc",
>  		.data = &sdhci_dwcmshc_eic7700_pdata,
>  	},
> +	{
> +		.compatible = "hpe,gsc-dwcmshc",
> +		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);

