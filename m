Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1941DDA14;
	Thu,  6 Mar 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248810; cv=fail; b=m06MCmpSoWPq6NwKX535GZsVKgBexz2KDVj68wQ+cLWUZNxs4bETzn2BuRHUxSuCln54EXzHPT0mfP+sqTtJE7lJhlPHcpLvXSar2Or8kWen/tJ1D9skCjt28/jG4FHcrhEsPXeOEAYMna+gdYOiNqLikFjw9aj9QDmzR5kzW5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248810; c=relaxed/simple;
	bh=+Q/iQ/6ePUPxIQ9F4thHRrE2hsLhhMejqdXJqyPFB2g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLI9kXcY0z7qgFVRgCEutTH9h7c2Tj0SKBPfIEtR3ARDjHdx7Fz2kjfKWK8codgyZnFmzktp4j+g9LQfRhYEuhEGbQb5vZcN6y5zS8DOY7hoHCQ2uHM68rdZykfcihgEEH9bpwkE7TIyTLcilwrNaBkHvOqxGwv8qPVCKGykn80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In1pUr+h; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In1pUr+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741248809; x=1772784809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Q/iQ/6ePUPxIQ9F4thHRrE2hsLhhMejqdXJqyPFB2g=;
  b=In1pUr+hVNEVGoerEp6uICYo80ZWQuhEF5e5xY0JwlXooLGbORBjg1QU
   9flTp3z9s3U1fcGfR6E0vskn/8WZM8psYPN4K0kNzGKTiFBRjoG8dFRLy
   4VOYBK0VsDbzAONUpsTCcqZ+aAayF42KDS9A9HNLCG967WgLa80xB6CCr
   9JxWxtX8naVD/UzJvVD+tN+03CffIH1boltPThKehR7Mwc+I9qOe6XsGJ
   BBN5S+PhtncHPbRk/bIEc7nwghiMTHjIeM2AuZ9nGYl58mK4qsV0yNkOa
   mffCk0wJezEis1wjlak2KgD7I55OG+MolC2HcM+LwoUwuyRVw9Ncp8JJ8
   Q==;
X-CSE-ConnectionGUID: 42DjNIwASHCTXskPm66cPw==
X-CSE-MsgGUID: RbO6yitcRN2sUjeZgwEqVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53230450"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53230450"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:13:28 -0800
X-CSE-ConnectionGUID: qNXJRu6pTbCf+cXAigNFcg==
X-CSE-MsgGUID: cArZ88Q8R+SAPS6Ahaxf4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="119643247"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 00:13:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 00:13:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 00:13:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 00:13:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTHopc4n9c5RTVB+scjyr6EnysQDBzCcaqo0wYqM/uNRCcC3+tJFrRcJeTeZI/iOmZx8yJk3tmTxpe6XADNaJZkakenAYskbdOV3GM3uZDUlYGlstdxxAvoGVgYzz6oSJE775qof/qJukuAZ4yhUpT96x4o1eKKrAZSBleRdzWXZ+81uz+mGFWZAZ4w1stLtB4rVWbQTWMymBVeEAXF/FwlWxXIBpclbuYeIiNxKz3LJFa2pw64R8BdJETRRt1Xb3QWdL+zImu7I/t362rbcNlgTBGW5Z3a3JLMtGYyGLZ41mZ7Jol91Q7JPLjp3Q/yxPwX8R9wDQ0ApfESGzYLHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK7exU7eQmihNBb5iMy2wuWc6o6l8oGqXkN5zHYEQ5k=;
 b=U6vwRNu5DPFxrQ7L3qkiJ27OF64K3kSoJPq17M2COvAhR+xvUejDszC8N2S8deZja0Fyi/2/czTFashSTTRE6f1xtbRsHnJwVFJNR74SBG0kEp5kcpFXVFvQ3jUrSRwRtRCHSSLer+A0k5abINMX0EEcF4OXifzS3WYhPYfYwD+JN7JgQMT3u0TLwl+jIY8gPSi3ZOqWDneVGD8vamRlkPArn+tRY1Rd18nNKlrlwxV6usUAKrBQhXEgu6Incu6v6TiyRXa+8I6rN1dlh+o7dfJKY3QKFUl+AT2HeB0UZrMjMV6eZU/2l3dAuHrhaa7Vc/k3zFXpqkKDCd5x6848eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 08:12:43 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 08:12:43 +0000
Message-ID: <f76517de-9d59-4cf7-a7f5-b19ee4b2b3b2@intel.com>
Date: Thu, 6 Mar 2025 10:12:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing
 parameters
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<gratian.crisan@emerson.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "Brad
 Mouring" <brad.mouring@ni.com>
References: <20250211214645.469279-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250211214645.469279-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::23) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d17171-9817-478a-7902-08dd5c86ab04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEVscklvaWh5RTBuNWFHNnM4bGZVNXJQR3NLcGxtcGF4elJ2ZmRNcmNTbGZp?=
 =?utf-8?B?bEZyZmtnTjhwejJWNTBTN3JEZ2JMTmRXOC9YUlZoN1VjRTVYRlA2QkszL2VF?=
 =?utf-8?B?eFpsYi9Ualo4dC9ocVBqMU1ySzZHc1NIQk1uR0kzVEVUcUtxSVFWa2FDRzlP?=
 =?utf-8?B?QkxvOVJ6YUJpay9uVEdLZUNsMjZ5MEloR1NVQ1JXbkU3ZkhJUGYrdHk1d1Er?=
 =?utf-8?B?WGFZSDVhbTg0bXBWM08ycDZHcEN5eXJZcCt6RXRtSThQTXVram9xS1hBc0VP?=
 =?utf-8?B?dW9aSnl0bDhNb05KQjZQbncrNW81K001c3hDODVlMGpSSllqQkttSVJmSGtY?=
 =?utf-8?B?YjMzYWoyL093QjFyWEozMS8rYzErY2NNNnlRS3Q3U1JhRjhvYXBod3N5QU5Z?=
 =?utf-8?B?RHVpaHg0Yk5VajE1WU0xb0FaY3FJS1owN0RjdlNoTEZJOEZkWjYrSTdGdy9w?=
 =?utf-8?B?aDJpR0JZK3AzN2pVWU5MZWxvY0tIcHpiWFNuMTZqVWFCSWRmN3pVd1JTUGY1?=
 =?utf-8?B?bDQ1N085R3pjdWNuK1pBTWFaVlZwWnZTdWUxaFdGUElqeitmVWwwbFJSWjVk?=
 =?utf-8?B?bC9CVEJGVExjQmdhdTZnT3ZYODY3d2JTZndZLzNVMkhTUWRqUWR4NTlGVFZp?=
 =?utf-8?B?emsyNXpBWFBoOWJWMXhTSWdvdzl3OGt1Q3poTWhNOFhWTS9nMXRzU2pZM2Zk?=
 =?utf-8?B?RS9rdnFtaS9JN3VPTmVCTE53V1RFVVEyMDN1dzM3T1RHYkdtY0traW9IQmwy?=
 =?utf-8?B?V2cvelNlY0U4UnVTeXkvRTBRUk5odzgwZlFqSjIxdXE5Y1lqUEZHczN2RVFZ?=
 =?utf-8?B?K3diaWNuNllrZFJFa3BYNXVQOFJIMUtHQVZlWTgxb0JkakpIUmJjSEo4Slcy?=
 =?utf-8?B?bmpnRFBJL3RnSEVMUllneGdyZWtnTWIwSEVjVHdxUngzTW5Yc3RwY0dvT1c2?=
 =?utf-8?B?eUQyTWNpZ0ttZTJDRDQwck9aWVZ2K2F1TEd2Q1BtOERGd3pjRmtrUlVucGhu?=
 =?utf-8?B?QWlEMzMyMSs1UFIvVUVkeXNLeW9DWnlVOWZHeWp2a1hjaDhxd29ieHdqRXBN?=
 =?utf-8?B?dm5VMFNyMHliSVNXYnZYN3FuNVhhMStVKzY4YXA0SEVCSnMwZTNUOG5HeDdW?=
 =?utf-8?B?amVkQkx5ZTBOVEVPREdwNWJKOGZFRExyTEZnNS96TE80bTNjUnMwdlc4eTJq?=
 =?utf-8?B?OVRmMC9PbnZhcjVndWJRN1JtdFBvMmsyQnVGZWMvei9ONHVtY3ZXVzYwNGVn?=
 =?utf-8?B?SkxlMTRLQlZuR2xvbkYwVTdpelVyQ0dXSlE4aUx6Mk9hTHFVN2xZZ3h1QmYx?=
 =?utf-8?B?NzJBdThJb0traStRMUZkVEJ4c3RsZUpVTGpRdDNnU2lBSjl0NjBESXBsbGlL?=
 =?utf-8?B?YkdvSEpYSkdka3BhQVp1cGR4TkpBUlVkSFAyYXJmdG5INHN1eGNXS01HS2hR?=
 =?utf-8?B?T09icUVIbkFVR1NTM0J5aE5WTlBxTm43MVlxVllUa0pMZkxxZDJlUjJ1ZzJ2?=
 =?utf-8?B?ZVVjZnd1QUg1Y1duQjBhUWVsSm9ReUF0WnhrVVJ2Tlk5ZjhzVXFUazRReHR3?=
 =?utf-8?B?bis1UVliL3dROXIzWnEvMG5mVDl2bXNMMytBM29ONGp4YW5zeG5uSHVQaXlW?=
 =?utf-8?B?dnJBRkNxTERsdnFjZFJOUlRWNTV5eFRCS0VzZVdJOWlKeDMxOHgxZ1B2M1oz?=
 =?utf-8?B?cmNNMzhGOGVYRE5TVjFKRW9BZlN0ZE82ek9PeG9DQ2dhM0lrT2pMK2RyQXN5?=
 =?utf-8?B?djk0U3EyV21aMnljV09rOFJvRHZZWWVWTnBEbFg5OTBkNmE4TUlGRWJoVk1w?=
 =?utf-8?B?WFE0WFZnb3JGTXdmZW04em1zazZveWVMZGp0bFJlZFpZUUFDbU1jK2dJa0tS?=
 =?utf-8?Q?kYmqP8bGHzh7K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZkVG81REh1a21YcVZUWUp1NHFUY3p6OXpIblVzZlRqR0xMaEdhengwYmUr?=
 =?utf-8?B?a3czbGFkL3U1Qi84NUM0T3dBV0xZOFdoWk4rNzhUQmVDK1dMVHVPUnhDMkJu?=
 =?utf-8?B?NzZEKzNoV3JlQk0wcTFGV2duMGVBUmFSeXEwN1luc0pydWQ2N0prR1BkWnAz?=
 =?utf-8?B?czlJdTZpZCtvTE5GUWdRYURUbCtjMm80MFJBeFRsWlhZMTRoakZJTjZsSm9p?=
 =?utf-8?B?cTVLM08vTHVKMXYzaDBOVDZTSm0zeVN3RUFSa3RjR29pcFdTOWdPSjk2dlYz?=
 =?utf-8?B?M2gwN2ZTWmF5c0pKUGxmSXFUZVBTUnlqQTVuN093cXZjL0o1eDlUMkQ3bXVU?=
 =?utf-8?B?ZjRTZS9kUlRMRGZ6eS93VFZ2eTFNVkxpaXVVb3M5cFU0aXNEZ2VBcW5FbU5N?=
 =?utf-8?B?b0EyNmNqZmNkZjczOFdldkVuRlAvdUxqdHhOaUhZc3RpTlhWOWkrdkdNOTRV?=
 =?utf-8?B?QW5xdFBSdUU5bnp5cjBISTBVV2tFZWpQV1hqMVNtOS9CbU1CWjdMNDNEQ08z?=
 =?utf-8?B?MnNOcnhCeWV3Q2VReDgwU2xCU0JLUGhNMCtHQVdpcElVK1RuWVJrVnJQS3Fx?=
 =?utf-8?B?YVJuOGtoSDJaeW5ZQmxjSy93SWJsNWlBSmEzZHhLV2hHclN0NXFsbjNEc2V1?=
 =?utf-8?B?Rk5ncm1BekJ4eGJlY0FhNEFYQllXcVNScjJoSnZZUk1PdFZLaGFPL0hGN0x2?=
 =?utf-8?B?THRJaW5GQ3NkeFJXMWdYekRLL2VQaUwzVTE1ZVAwaHkzR2h6anBIMWI3d0RN?=
 =?utf-8?B?NmpoRkNEQjkzRC9lc2Y4ZmlzNEpINTdaOTlUS0dremwrYnMvaHZ2VjZEbEt1?=
 =?utf-8?B?RWtDRnpyekNPVXZMcC9ZVUJuTTI1ZzcveU4vTDRSTUZZMExpRWRSamRJcXNr?=
 =?utf-8?B?ZlJWdFluUzlNWEJrRS9wSjZaLzU3WmZxa3UrcVJNVFAyZE40K0tEQnF2TEtL?=
 =?utf-8?B?SDJyNW8xdkRwKzZ0bmphUk8wQzNiTXFkMDFXMWY2czAzdHhpVnkxUDFQaThG?=
 =?utf-8?B?dENhZ1hob1M1MnNPdEhZM0JKYUd5UlBrZmUrTXNVeUYvd1VNS3JDb2JNYmJL?=
 =?utf-8?B?NTdncE9OMnlHaXR2T2R5Q0l4TlIyQm5VcnlnVVdLQ2hFVGZzblpHZHFHYXQ3?=
 =?utf-8?B?dWZMY2tWQ2VKSldaeCtGV3lzWk9YRW5FWlVGbEdkUUx2VXBBOGEyb1o0SXl3?=
 =?utf-8?B?V0tuc2QyRFJFR1plUG4xNmdvbjJTMDE2NkNMeEUvUGJ6bmR1STE4Q0tYODVN?=
 =?utf-8?B?TkQ0U29icXpmd2NCM05jSVR1Z1VKaVQ1cVkreDFSak9sdWJEZlpydDM3dnNp?=
 =?utf-8?B?OHZUc3BCWSszNUxOcU03NWZyRVJYQ2p4ZWFlNGloVmxMbk0yTmFhVEVic0FN?=
 =?utf-8?B?dy9iR3QrbmxuZ1EzU0NnaHZaOXlkSEZBcnJQY3VNeHQxWEczZnY5cXhHd3N3?=
 =?utf-8?B?K2VIc1BrZS9heks3Q25ENUZxTGg4N0FCbVJLNmdxd2V6MUpEM0V0NjFpRzNn?=
 =?utf-8?B?eVpLdGw1aHEwZFpvaGhzUm1vWmNRanFEWHR1SmlWTHBMcHNWU0U0bmY1TXN1?=
 =?utf-8?B?aW5hek0wbjB0aVhpa040TW00bVp0VjJtNE5oa1FsbVFtTkhacE41cVR5c3d0?=
 =?utf-8?B?bmVXdDBJWHlpRGxWQW1qcm4yOWpWblhsdWo1YXkxTU1HSXN5NkdPbERkNlpt?=
 =?utf-8?B?a1YvV2F1L0cxZWVIMHQ1aC9GR3Y3aTVBbUV5OVg1QU5FTVdNeVdESGdMZ2p4?=
 =?utf-8?B?UUJVSTY5L0xwdzZoK2d6dXVoNUJRaTIvaDVLMHVOb2xadWt1cmFpZUhNeWJy?=
 =?utf-8?B?d1RnZHhGWE1YM3AvNjdIdnlHVStxODF2eXEvZyt1MDV2a2x3emdwdTE5dmdO?=
 =?utf-8?B?eDQ5M2dIZDN5RXhMUllESUc2eVJQN2prVGpPNkdoaVhURkJybnY2QWdkWXAv?=
 =?utf-8?B?OWRnTGR2YVhsckdLRmNvTTM2aUZSdHBsRzQ1UndnSGR1M3hteUFYSVdEQzAy?=
 =?utf-8?B?TkMwdjBFZklpT3pnRG1BRkRLbUp5LzljdGFsNFhKbWloSVIrY2hSTll2S1pS?=
 =?utf-8?B?NTI2SlNZdVg5bjJpaEtwdy80UlZ3YjNDa3ZUbnI2TmhsL1lrby9ORnQzbDVM?=
 =?utf-8?B?ZWpodG5jcjlBWGlURlMrTEd6Y21OZzUrN0FSOStoQlA4enBVZnNkWTcxcDBo?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d17171-9817-478a-7902-08dd5c86ab04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:12:43.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EKrZ1DS/z4bVjS4ogpJ7R2ceOeLxxTvw3c+pbPUfUFSvPTFL6lXXQIXhqnkGMvTLZf5Q92fdCJRAQBeZAevQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com

On 11/02/25 23:46, Erick Shepherd wrote:
> Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
> the SD card clock parameters only after first disabling the external card
> clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
> SD controllers which otherwise breaks voltage switching with a specific
> Swissbit SD card.
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..5f91b44891f9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2065,10 +2065,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	host->mmc->actual_clock = 0;
>  
> -	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (clk & SDHCI_CLOCK_CARD_EN)
> +		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
> +			SDHCI_CLOCK_CONTROL);
>  
> -	if (clock == 0)
> +	if (clock == 0) {
> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>  		return;
> +	}
>  
>  	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>  	sdhci_enable_clk(host, clk);

