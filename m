Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA117A2EB;
	Thu,  9 Oct 2025 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990281; cv=fail; b=pV4bE9FJjC/JLz4ik3DqiupoxmhreUU4dEUqbsNb+BhVeQeKBPLLW7BQ0SeBn7VE6x2rihdTy2MhL6aVqepd+EGupdFd5Y3nMzcQnVSNgfMYj2HDln8iIKZq4GVhvZbtfIrFMmbHjpe4uFnXZ2djCdbU9n6gZ1l/lT58YDCS2+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990281; c=relaxed/simple;
	bh=F0P/A/UgvFBk5mIEwgClU+V6Mjmy+pqCItdMfRwz2mo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SIczBUSP96Uh1sdNgepSnOizTcP20BerBpQuqqlVGDx3WwsxTTagGKS2oGZjd8+aFm1AQJNBy7EZO+DyGGz0/imVlzKq/WCyXTDhkRrUvlKc3bZsucUgViCbuLsBSePcgQ/cWo7bhNiDjY9yYYDxLfnot3C4xkAWTy4EuOXkt/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYZQiSlA; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYZQiSlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759990280; x=1791526280;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F0P/A/UgvFBk5mIEwgClU+V6Mjmy+pqCItdMfRwz2mo=;
  b=IYZQiSlAY+rFGY/+zcpscLYBzV0QxYWZgAewsg+VvS92t2U2XaEuB/Re
   OvCul8xult8byZMZSih2fs0ctZhMtYVISCGknCpgTPK4jinzcrgkXEBbc
   m6aU7UamIHpK8XDJupHD8jX6jcoecy73ejNDNb3Yn526gTvIk/QYI3dMz
   CtjczSTX5YrdyyZARvkuze8N2005cb4ozXtFR5IStuHzINj9IQMMbOkS9
   nKesqM0TDkRp7W2lNHVjyvBZDZeBt6uT+9ntLq10ojP8Q+dwiCrdQUqMv
   JoP+v38IQsViYbFfmX1HzzvcltKjQqVJDtPAfw1WZ1IYLqx8QEh5x8ueF
   A==;
X-CSE-ConnectionGUID: LmnplrGATIi6kHqnGFANHQ==
X-CSE-MsgGUID: 9hV8SCcWTZWguoa1xo7zmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62099128"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="62099128"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 23:11:18 -0700
X-CSE-ConnectionGUID: WIV/GHeZRHy2y8RrZq+6ig==
X-CSE-MsgGUID: lTMBr6uqRHa2twhrVhHAig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="185753416"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 23:11:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 23:11:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 23:11:17 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 23:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2WVM5MqabIdDN+d3rDFu3SExyuVpiQMZzZSesNSClH8XxIf1N9i54Rwx/bjjqOO/1i9UvW3DAIMK6101hWMrdS3dlCnIeJEr/8Wj51UY0ck5mEdbdICZN+KvFJi2NAvynN+y6Py8akZCOxICft6Ul4sq/ugqsE00TC2M/lX6Rmscu8UcJfVZz5TAUV9PhAPnL8MQaIynBtorHsK9RAhoMwnsBwuA9uE3mZNlhkK4rgli9zNBhu2O2IcZEjvY7wuXK0I1wEeZxNscwnZC1MXq9ZZ2tGzwNpzNOlbeaZ2+JJf8y4Bh1ebItAlQRkmZUtohHkBOj8Cntf9dSW3qc2Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCTb3VLsECtX/l4MXDcZ6kXuV/oohkn+Hb3d+/vi8V8=;
 b=VQ/wcCRmKUkyDNrz0OPS0wMq9luXSdoQLjslo706eyC2CcIChFqCdwzEtmLHB0Hpvz6/k0RKjDdOV20Jg2WKhK5ZtOWo3gxlbLIjkY2SASZPZCNj3/7BarWAful4FCnUDPAtKqf/aXOuM9JZSm1DRrNI6KUyxYeTFEJeSCgjnSgdmAtkdlkxvr1Fpp0tW2EbaEO4WCsSdRGqogPAFHott2p4CwKlNX0V9L2DAh35+e1JgPjGqtrJnf/1jxceSNqQ7ea62OpODYYsbM/VPhWCj5w2M5G4eSZVvZ/dnNyTAHHdLT1pET3RjKAMV38Juz5dDHTuCsP3WZlsCDzMNw62+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 06:11:09 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 06:11:09 +0000
Message-ID: <82b1d733-df39-4f20-8f69-69b34bfac3b5@intel.com>
Date: Thu, 9 Oct 2025 09:11:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci: Stop advertising the driver in dmesg
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b151961-c03a-4c6f-aba2-08de06faa399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3ZUZ3JSMC9POWljMkMzU3VJTUdobFMrQmVpQlNILzQ3TFZsQUNHZkJuQUxw?=
 =?utf-8?B?OXM2SlNCMUJ3TG9UcHFsQ2luYzlSbWI2Z094Vm5TdG92RjBoRUo5M3AxTVlw?=
 =?utf-8?B?NENtN2gzcFBFcUV3aC81cmFFUEtMUU5zYzFCT0ZlQ1BmcnVxZzJvNzAyaTA2?=
 =?utf-8?B?N2dYc2NHNnBhbU1mbWJjRHh1S0ZiejVYcllGd0VPSUlpTDNKWXpDQUsxeGVy?=
 =?utf-8?B?WUZvTUY4T3FENU55LzZmckcyQUtWdkY0VnF0SU1oZnE3d2sxQUUza1c3dExK?=
 =?utf-8?B?dlk0Tkx2OGlDTEVHWXFaUDNRWm1zbFEvS1N2MmtvenVRVWxLTExQV25xSEpl?=
 =?utf-8?B?Z0g4SzZoOVkwMWU2Z1N5cGZRS3RqZU1ZMDJ0ZGU1ckVQTFJvaHdaQ2g0aUhj?=
 =?utf-8?B?d1RTYTYvQmJNak03RVpzcElydjI4TXZmTE1kZEc3OGM2eVh2UGlvOTVYeHIy?=
 =?utf-8?B?NVNnUzdpYWVmd2grZ0MzZHB2SFpsREowSnloSlpqaWxzNlVYMTB2YXpiSExI?=
 =?utf-8?B?MFZpa2NUZzhtei9FU1VsSWs0NDhydjNFZGc1WDNUTFk0c0FwWE5lUTJoNXV5?=
 =?utf-8?B?M1VkT05YUTJ0L1dUcHpEc0YweTY3VXRta1AyT0lYaEd1MlRIcllFMDljZzlz?=
 =?utf-8?B?MkVTVVV6OXdsdEwyTlhmM2lkUVJKOG40OGdHSXJxdFRacS9FRXZjVzBFVnlH?=
 =?utf-8?B?UEREaG93UUNXb3hGMWR1WFNHdUxUZlBTQ0FqWnlOYXEyYks5WTZ1a25nTzAz?=
 =?utf-8?B?VnRjNUt5OVU3VVVEcEd6cTBVYjlpekdINkZSaHdRbE1tWDRDQ0EyaStjSGth?=
 =?utf-8?B?SWtHVDNCd2ErWkhNYjE0VmlvRmoydlE4UGRFREhiK2x1S2ZPR3RQU2ZhbzRa?=
 =?utf-8?B?ek9WUGtBcGprbUFjaHlaN1gxSHozcnU0VUgwT0ZjUUxlVk5QZ2E4T1hGWnVr?=
 =?utf-8?B?MDJKdjNjbHVZR21vcEIzRit1ekM4WFRjMC9UZHVjcDhRZTlWZEUwWlV0d3Rx?=
 =?utf-8?B?ZVZNN3oxODhOUUc3RmdKR0FaVHZsRzR2dzRGY2pscXpZcDluTjNHWGJtcEV3?=
 =?utf-8?B?Wkc4Z0Q3WmtPMGgzL2ZyV3VlTGU5MzJJN0lYRDFtaVJtVlYrQ0U0eEFidXRH?=
 =?utf-8?B?c1JxOUIwMS9iaGdTdm4vcVZ1Z0hTcHlOaDdRMzRINlVidXZHTG1xMjY0RE9D?=
 =?utf-8?B?TnZjZCt4QkFKeGRJeGUvODVYelJqZzFkKzdQZkJDbXJLYUxBZEhzVzFrclU4?=
 =?utf-8?B?ODlaRHlzOFVXVjBlVHNWWkdSZFozQ3k3d1lxcDVGZkIzOUdLbDdYQUE3TmN2?=
 =?utf-8?B?NkpCWEFFZnNGKzRrYUdHSnV6eUVZeHJ1dXY2OHR6L0kvajgwY0ZPSWJYYUtr?=
 =?utf-8?B?WnJsV3lDTjQ2SjVLaGM4MlFidVJ5a0NjMW1nVURSSktmZ2MwS1RyOVRaSnhW?=
 =?utf-8?B?WlVoR3lPWnpTbG1CMGFGNXduLzNHZlpTVU1FR2Z5QzZWL0dVV091OUttZUFo?=
 =?utf-8?B?MnZITlJndVkySUpITHI5N0VPWTZPNlZQOEhVMi91SG92VmJhWTF5d1RmT3NG?=
 =?utf-8?B?dTVNTEtZc0VZMEZXOWJUQkk4MjZVZDhQOFlXUkNuaXlKYkF6Z2FQS2h1REpa?=
 =?utf-8?B?RG96UDZOcWRTZ3Q0NFVWblNCU3p5SnNpMmlBcmtSakNzaVdNMW9uYkpBSjNR?=
 =?utf-8?B?S3VOWEh4UkQya3Q0eGU3QjQrQUFYSlpNL05KaC9IUkpnRllqaHFtcENqZWdo?=
 =?utf-8?B?aUN2cG00QTc5NEM0LzRLL3hub2pkSXpudStQRHNVN2gzeVY3T3QreFVhNHl3?=
 =?utf-8?B?Smp5cFB6N0I4OXhEcVlKWFFqMnFVOWdXa0pDaUlDTVlrd0hWa3IvbU5RR2JJ?=
 =?utf-8?B?SmxRK09mWWVGeGI5U0pVTFBKeDJlQ0p1NEdTU25aS0I1RjVZazBhVWtydS9a?=
 =?utf-8?B?Nnl3MThsMnBHMnRmVEZtdkl4NGhtYmpBYW9JOGt5Q1NSeWFjV0JoZnVCZjNR?=
 =?utf-8?B?Y3Y3djFIcjFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWo4Wk5TS2ZFY0E1UXozQ2Q3NDBrcjlZTEUvNVkxdjBoNnJrdjRBeVRnek4z?=
 =?utf-8?B?Qk5admNjM3NsL05hL0pOTjJha3djS1JEVDgxRDlta0ZxVzdGZTduSytNYWNt?=
 =?utf-8?B?ejc0TktRQVcrSTFoSjh3Mm01dUhFcmhOb0k5YlZ5a2NRUUJQdW9OOG82WWda?=
 =?utf-8?B?TVh2bHE0a0NvbGZkRlFXT01WVDNmLzNhT3dsUGE1bHQrcDE0ZWJJMzcrZm9H?=
 =?utf-8?B?dXUwTGdoMUN4cVNDS21oZVFxVVA4azlYL1drR0ZKWXczYnBaaGNtbzBGand3?=
 =?utf-8?B?bmVIaFFkVlNXSWhab2tYSWRRWnBKVTRpVktxcjBwMmM0T2tRRU83elpNcVZi?=
 =?utf-8?B?QmRKLzd0UHhKbFo2QjNMbHd6UEpiRmhNM2JNTFAvSWRSMXRIcW1RWndBWWwy?=
 =?utf-8?B?eTczZTdHVVZIWFZZdjhFVGYrZUpEak55b3FKSEs3bGVUY1VDU0hJNmx1VjJs?=
 =?utf-8?B?Z0pUdXF1KzV2UlNEQ0w4c2hPaGV0OU9kUVFSZkhDaWxvTCttdDJONGFCeTgx?=
 =?utf-8?B?enhiTE5xM1V0ZFQ0b2ZJWjhiNHpTQ3J5Wk9reEdab2c2RmY4WmJVMC9Ma0Qv?=
 =?utf-8?B?eC9sYzN1emh4bGE1dHBYdVNROVdBUXMyc1Z6c0wrYzFoNDBlYklXQ1BFSGtR?=
 =?utf-8?B?dldUQmp1UDBySGN0bEJQZVpEMlNjZ0JjaFVoeVZDVFFva0pyKythRkFOYU9w?=
 =?utf-8?B?c1VLSVRodTdvTGtuYmxtYlVFWW1ZQ0FsQWRsSFZvanl6Zzd5YU93TllkYTQ0?=
 =?utf-8?B?QytwaDd6YzZWMDVpNk5vdklBbkZkczFvSGJUSEpLNXRUS3V1MzNkampxOGxv?=
 =?utf-8?B?MjIzTWRzQm1TMUxTZ01SL0JRM1hqNDBINk1tRW04THM3Y2xXV3dkT1JnZ0dR?=
 =?utf-8?B?L1BtVHdkM2tObDA4QmN0ZW9oSVZjVjMvSGhDbTdIQXZaZXRGaktkbjl2NUMz?=
 =?utf-8?B?SjhmaGxHZ0c5WmVuL1EwSVNlNFBVSnVWZkdDMm53cmJMOXRkN3p6TFkrVjVn?=
 =?utf-8?B?VWE1Zk1tNkxVMUtJQ0lSQjZpck9LREExUnNCaXQwdmJ4cVcrOWRMWUNMNlRo?=
 =?utf-8?B?bXdZd1YrSEdHbXF6ell1bGdpeDVGUHk3aUZORDMwNFRVWDVkVTR6RGVpTTB0?=
 =?utf-8?B?cjZuaG1FSE0rdWlNY1FidnRGaWorMkxYekdsTUlQeVJXUWZpckNRMW5NLzVM?=
 =?utf-8?B?UWprN2ZXOG9BOXdMNkhZWk4rQUhEL2N3ZTdmV2F5VXRiM3hocHBGdXFjUDds?=
 =?utf-8?B?c1E4NVo4WEJqUyt4M3N4ejdtUTh5MmRVQnpKTVhiMUhJYU83WG5LKzgrQ0Zn?=
 =?utf-8?B?Rm9aUmNzNmVQZ0grQnVrc3ZsOHpndGowYldTeDAycWozNzBlNVNYbHcwbDBj?=
 =?utf-8?B?bndEdFlDSVZObEp6UGdIUmFBYjhISG9NR011Zjc0TEtRT0YwNU5yTE9FUWI4?=
 =?utf-8?B?WHhGZW96QkR3d3dNcDdCNWJwWGs0TUNnVVZSUUxvOE5iTlE2NnVqbWhWSFZV?=
 =?utf-8?B?Lzg2c2VXSlBLZXpmUlJidHczMURPUjRVT1dqdHJrN1BNa3ZLeXJZU0YxdUha?=
 =?utf-8?B?UTVYanR6YWxXMEExVkVoQWhmbFBUTVBGM3EzWUpFNEFSQXN1azdldjFsUWg5?=
 =?utf-8?B?NmliRGJYd1lkOWhQQVhaalJ1UFFBZyt4cm9EU2M4TXdTRFlhMkJnVWpYdGlS?=
 =?utf-8?B?RE1UZ1NLZ2tGaDJKWUtmWDQwMjBOYUtLZENFWURsTXRidVpGMWdWYXBMMmFz?=
 =?utf-8?B?ckptVk0rL0szZTRBRWRVaGR1bU5TWnNTTi92TytkKzBOVU9YR2hPZ0NRU2Fp?=
 =?utf-8?B?emlGSGpqZmJpUlJidHZQdkxKMWZUT2p3T0NxeFZyaEVFVUZuNmxWS2VOcWo1?=
 =?utf-8?B?ejhtNzk1UUZRdlMrZEZaYjdOUVF3dlJ0ZkhucENMeVZFL0JENHpSM1A4aE9m?=
 =?utf-8?B?bW1LYnoremFRdks0OTc4RTA3OXJSelZyK3duMitYRTIrU3liTmJYVEFSTEJF?=
 =?utf-8?B?b0xlRyttT2VqbGtabExtWTcvcmkzQ1EzdVJjVE5PSzV0c0pKRlNQYXN6NkYx?=
 =?utf-8?B?dHdZUVpKd29Jd1c2bUoxaXN0MEt4SGVDc0o5Y3UzODVqQmNRdmp6UzNyUk8w?=
 =?utf-8?B?eHdSOWRnZmp0Z0svTkxqbGFLUFpNTU9udTZUOWYwOU5PUm9Lc2NWVlhSbnRZ?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b151961-c03a-4c6f-aba2-08de06faa399
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:11:09.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GEN0A9IBBGUvlQfaEtohbFOAFfPn1nqduUc6yH1Pzjo5RanMVhDz4CuoQG8zQK2GpjNf9xhj5RSaYLSHXMmUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com

On 08/10/2025 01:04, Linus Walleij wrote:
> As much as we have grown used to seeing this message on
> every kernel boot, it does not add any technical value.
> 
> Drop all messages from sdhci_drv_init().
> 
> We need to keep the module_init/exit() calls to stub
> functions for the module to work according to
> <linux/module.h>.

But is that true?

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Drop all the messages instead of demoting.
> - Link to v1: https://lore.kernel.org/r/20251007-mmc-no-advert-v1-1-0e16989d28ef@linaro.org
> ---
>  drivers/mmc/host/sdhci.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af71fa5a70eb579fd812227b9347f83..2025b33bd6bfb51fc3116148299807054179b2e2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4999,10 +4999,6 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
>  
>  static int __init sdhci_drv_init(void)
>  {
> -	pr_info(DRIVER_NAME
> -		": Secure Digital Host Controller Interface driver\n");
> -	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
> change-id: 20251007-mmc-no-advert-8f5646c44dd6
> 
> Best regards,

