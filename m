Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3E470E89;
	Fri,  7 Aug 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108127; cv=fail; b=h8VDH3cmX/m5PHcwEoZJEZ+S7hndu+tbMP7CYyJYvUtprYfE8kUjywGbluNR65T38p+NlKYdvICXI/aOJFADHxb1tzuEw0HqCvPgf7rWVO2J2oIahYLOJzIa5WekdPAE4b7hyIPP75ZvvuuBwUNDNae5bKy344/116efAnAERmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108127; c=relaxed/simple;
	bh=aj+BY4ilf/oMfiUci+4OAYpViqzVZwmXiDwt8sP7e/M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQmF1qgWw8BMKaRZWq6gaaX2x89LVQOhSZz7R4CdJZnNk2ULLLQiT6u0BzAxCe6H/726TR281+KUnrRd2eRoDgtKQfUTW41ogUy/CwWoGMe9NLnKvN0NpFs9vGg06oI2OM8ylkA8vGD33kAYvxd0ayRllesT+y92DPjg+DU1798=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fl4fkzIV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl4fkzIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786108117; x=1817644117;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aj+BY4ilf/oMfiUci+4OAYpViqzVZwmXiDwt8sP7e/M=;
  b=fl4fkzIVggl7lZrovcz+xAY8WlJZydAnEY4M8AVRFebyGF45gy5oi8fq
   PoXl8OZxh4UH7rcQJT0j9lvzfV1/fOTb3TUsehdUo8CI4lNXs39hMMwyh
   zaumzD8kzcvGMlrk8QB8wRQkYD0vH5AzzkGqZqbg3FJrbPe9nQAww8ZbN
   uU3yhCiltVPdahKgxvNe6mlA5D9o6ol2/OllCbxjDt3SudEn7IWlUwaxr
   /dwYUV/KVrrvoB3/nj1V2KncN4OIgZOIvutIZFaHLqlnuWKG9NQka/IBX
   M8OUdg6Dp43eCYhW3WEfswdaHwiX8k0GBIdJI480LzJX27gy5LmerF5/a
   g==;
X-CSE-ConnectionGUID: 4lGrIL4WT8CZxUrsY61QFw==
X-CSE-MsgGUID: oCY8chb4RAC3VkwugY5ttg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90595489"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="90595489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:08:28 -0700
X-CSE-ConnectionGUID: hYJDitkpSm2jKAZIz1W6qw==
X-CSE-MsgGUID: BmqA4Z+IQUuMEDd+0ZH7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="266641493"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:08:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 06:08:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 06:08:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 06:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL7IpBvmtJRLnBuZYGUCwksszlauawolIKGmt8tNoj5bvM2eoahMXTXrhf5UvR7QREnxwWZDfb6r/tZPl6Yg3gUxFyig7J2W9YE67DcInQSc3ZU98qTMbjfGfp3olUmiF93FtUov5IwcL1/pwUlwoKg4jEiJA9wPRH9f/HuAlU4za2uORnHiPP++WPMMEinVl8LmbYgS012B3j0bUSMBN4n9TZV1Xpo0FhMgGmUZUsniHTGqPBZikFw4Pf4I6DjFHcPh4b7GVpXJLJTvnGrNBIzAX869apMFKwnNWvlNUXBAzgGBF3mnSOYPiDsfEr6eXSdckzdj+KP6X0EMEhkmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjrFd0yl60guNcI4nnkggiXV7tXsgAVpr2F8lQvN/kI=;
 b=hb5NLO+pvWwRNj3eghJe8nFEcpTw11v091KnC7mwZVoQ8siwI7wYTMlZyWdox1YQcsgYNp+WQAr8j2/OMqJ+ecfmAxK+D9ZWApn4beuohfpTNSUlFJPfOTMSEH1i9eb+850eE0BOrPAkfWSJCXyUzOZWIOnKMBK7EJh/b0OJk+//quOVk4uUe/kYsOB9Wqmam/iQ3/ADIgG6HCCRzsgC+GeWsYsGCoRPAD41t1A564pYq8hggrxN5ZdvwgJWVCp7qLe1UfG5J2Frv8joJjl0H4ITqEk0i+BP09aNMNsngj5+4G8tEZnk60RBt203M84o9lqHXfNLG/5lH9eKHaASFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 13:08:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 13:08:23 +0000
Message-ID: <e5f80aed-a39c-4fbb-b758-c38e90d1d24b@intel.com>
Date: Fri, 7 Aug 2026 16:08:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulfh@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <dinguyen@kernel.org>, <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
 <20260724145009.7456-8-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260724145009.7456-8-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0233.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::17) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA0PR11MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a7694a-e3c7-4bab-9364-08def484f616
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|18002099003|22082099003|4143699003|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 39A9ajwoTYTs9cme/FuZ5T5Coto/F1Hfe6xfIgDzkrNajBUzXy7FZQQLsRyTTdWmWl2YXPCFNIYKQMv/tWjMAf/G9B+O3jTanaVZzy8rP1PQaWEDbUH3eKQR6DusOz8T0/gdM2HYwtxP9UX6/CDX3+NhCp/aQmzzb+funDxoF7mbDQwsFlYjkYI/jEvhgAzNigT+TMKWCJfrOlCXaeOJEjno0YIfGbg95I2NJ2BllCdQHtwEmh3RVlhtpviu9O4JIfXC/Rv1pXJK6ctHAwyUAv9dv5ypbjlMdkLLo/5EVWRhdWq8nRNwmRKVVaMFbqiegG0dgXMtlt2lQtHdsta5ROQwHRuN6AiekHWMPZ+xYZi3kxLhOh6R/AZ0H/KNCaGDBRo7h2h3zzNAQewPOQAuXdFLvfpRMTnTAtlWweDwPbQxJFqhsitpuCcbW1x5PW4gqC+uOCsMCpu79kxsNsT00dXgMybx8DeXhXOFO2fus880hJfc1fbDxVYpvrVyExXYtRVh/jRlHl6PorPBzf3xL+v0v50TRViBzUGPgyxu3eDSXtTy2svH+m772BJAWrObNgSps500HTMFdG9wMj7jOqoqgWM4qVK+N1qwALsvZNnwEDJLaH0VI6hqApzO5GvtM73H0TpE9qGwyFNslYjeADeyL1A9eVJwmNYRSb0H98k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzF6aWNsMGhDSW4razlRTHNLSU1HYm5FZ2htVXBzU2pSR2JmcklXUXZ1dW12?=
 =?utf-8?B?Rlh1WnFEUGFhYWQraENQSjVreXpTTXJBRTFtS2tzZlU1bHBqY3E3SXhobkRx?=
 =?utf-8?B?cFVscDhENDIvY09JVllhY0VDbHRDWDcvcW1zanF6Nk1XZThpck9uenMxbk1V?=
 =?utf-8?B?czZrdVRuQkVWUGJyWm5DWWhIOUxjT3VkeGNtcjMwWVV3MElNcTY0Y2tQYU1V?=
 =?utf-8?B?ZVI4dm0wVWhtbEM0M2N5aStyaGtxMzRpWEhNZFhrQWs2K1p1WVVYM3MvdTIx?=
 =?utf-8?B?WFd1Wkhaek5DOVROL1hsQmVXVVRJRG8rSEQ3aVpIYlkxdVRsVXljZVRxRklk?=
 =?utf-8?B?RlZlR0R0Y08xaEFITzV4UUk5MStSN0dZaFgyQkFLaXIwWk0zNDI1Mm1weWRo?=
 =?utf-8?B?bzRJZVF1ditmakhCZDV3MEw2SWFjK0Y4VG9wSHRWeFZidWVCU295VlFIZXFo?=
 =?utf-8?B?M3JhbVcvaitWYW1nRERVWjJhK2kzT1VOM0Z6ZTFsMXBlODdJSWg2L1V3WGVV?=
 =?utf-8?B?Zit3WEtBaGhIYWkxdmdnY1BsQkJqWkxURmJkTDB5NVVnZnNZOGFIYlhZd0J6?=
 =?utf-8?B?UjhEeHZMTHRFbm5sTzA3ZFhlLzJpRWFDK0ljM0tYNEQ2L292UUN0VktrZkJy?=
 =?utf-8?B?Mm5xSDFETDZ2dVhrZWVoV1NqekkvYzN3QTU4Z0JKNWtTbTVLWlM1ZVI4NmZQ?=
 =?utf-8?B?enRxNnZSZGs5UlhWUHpqRWpwdXJtcW80WE9kaWdkMGpoMmNUbUZXWDV3RFA0?=
 =?utf-8?B?RTE3S1JVaGdSRmZQaWh6OXQrYURNUEtEVnpOVzdpTEpSN0hJQk5nMUhlcmlL?=
 =?utf-8?B?QkRLNnd3N1RMNUxxSGU2Q2ZUZ2xFK3E2MjhJU0hVeU5XWEt1bmxxc1JaMTZk?=
 =?utf-8?B?MDA2Y1ZpcW9ZVnBNOWNFbGxXZXBBNTVKRlY2dlY3OXR3a0hIdE82cWt0SXJT?=
 =?utf-8?B?VVlIRkVzZEs5anFCaWxKN1YvWk41T2c0SUFueXFEc1p3L2hXQmVDbk5RYlhh?=
 =?utf-8?B?bUhyN3RRZnQ4UWIrdnpTTXBoTFhkU29tK2REamI5MUhON1QwVHZqMVQvK051?=
 =?utf-8?B?S3ZFNHZLS1lwTHJMcm1jRmdMRy9RTVQ4Mzd6ZHluNzRJOUV2cE1PaElqSHN5?=
 =?utf-8?B?a2Ztb2lvNFZKUHZ5UDZoRFJNT0hPb045VU9JVURvelNpeDlHRU4veTVyQnN3?=
 =?utf-8?B?V21HaXhSb0xoMkJkd04rMXdTMndCLytjL0J2bjQ3eFBVaWRxY2hXOG13eTVo?=
 =?utf-8?B?VG5lRS9pcnVLT0Z3QU0rL29NbXMzdHpLYTRxZ3pzZWRLcWNiRXBIT3IzSFR1?=
 =?utf-8?B?Ty8zY2dXbFQzY3Z2ZlZKV29jelZiWEdBcnZiZWU3NnNnU2I5aU9lUlJRQlA5?=
 =?utf-8?B?NVB0cVE3K29RWjUrTCtLL1pMM0QyWkVVaGNBYng1eVJNNVU1OGJKVmZUbnJm?=
 =?utf-8?B?TmcyYzJON3hydHV0K0xDanVpdFBxcmh1dXJWMW9GRUlCeWFESHVrZFA4cVRP?=
 =?utf-8?B?UFpRU0lySXY3U05mV1FqN3hYTFhrYWVSSm9XVGRwdjRycFlDaUxMa1dkVjg2?=
 =?utf-8?B?R1FYeU5TTlhwbEtPeU0vMzNsYk94aHBoeHpMaS9VOXVudUpsR1pUaGFBd1Vy?=
 =?utf-8?B?TW9zUGJTSVcvMWp4SmhETUVyTmRNN290ZFlUNlVBWDc4elRES2tVQk5SeHFp?=
 =?utf-8?B?c25VZ3lsU0xMaG0zb2lHTFhmSmtwN0p2KyszZnVIYkJsQ1U5eGRyN014a3RQ?=
 =?utf-8?B?THEzYU9OR1MvUWppUU5vT0FObU9oQTF6azFEN00xTTBLL0tDZHd6b2h2WUtH?=
 =?utf-8?B?TzhOM1c0ejVNRWlFYzJnSDhrOHFmcHhudmJVNlpKeDRRblZyd2FpZjN4ditl?=
 =?utf-8?B?c2xVN1NqaDFSaXFBR3RkYWV4ZjlRRjI0czZUNTVacGM2elBoR1VpVzVIb3VY?=
 =?utf-8?B?Tzc3RDdDN0c4ckxaZ1VKcmNQaXpSS3dsL0xiWFZzMjdhdDIrT3g5clMyUEdG?=
 =?utf-8?B?eWwxalNPck5xTm5GdlhvRUdoVmdnMlczdWlQUFRmUC9FWjUwMllqWE05ckQ4?=
 =?utf-8?B?YThNMlhvcGR6YjlqRFdkQTRvOEo1M3RNVUZJZGtXTjE3SHBNeGFrVWpoeU1P?=
 =?utf-8?B?R3BvSEtEZE56c3lSV2UwSFBxSjV4R2NrRkVSd2FvM05oSitXbFpxVXRtOVYz?=
 =?utf-8?B?L0RFdjBKMGNSaU9ZbTRjT2F4YnhLN3Uwc0RVZ3cyeS94MUQxaEdtcGhJWFFB?=
 =?utf-8?B?VzROMFJUYzdVMEVQbWdWTFVXN0tXYmNETXg1U09pMk9FR1lWT29zYTYvc1hq?=
 =?utf-8?B?TWxBaEo0aDBRY2Y2ektmS1h1OGoxZkVlR2dFdWxXMyt4dnd5d3dEbkZ5TEJO?=
 =?utf-8?Q?1QB4319327GBVfsc=3D?=
X-Exchange-RoutingPolicyChecked: de3VFoye1/B8ORiegZn3RLVhRP/gkQqJreSnkw1d3Ng1lh6hoHpdcMI9s7WcwwMVDTovLi1zVqWUP/z28Yo0LvGxPFhFwGOc/X9WHQBOguGq46YyewQExSlkg82mTIMaAG8OoLZlIA8LUokRqOYvcbV7AxacpCvaCNt8ywpwxT+9HmdL6qchV6YKa0U8g2OEXsk+G1e3XTaYMwFVajfBlhwKHvqx6CNpnGHdgw94D7b3EpGvYQlW2u8A+CGtjfRG0KqpVMwkOuoC68mEbLvhF1B7/oyCgcaic3QABwWhyFPb7jO8m/4oriqc9umnX3scQ9p2vwni8OxOv8LOxS2x7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a7694a-e3c7-4bab-9364-08def484f616
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:08:23.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbcQmO4lLrO9G3965XIUdleqFy+Ago6Mohf6cHHeX89AaihYNd6gndCf5HSHx+R6tsN73knt5nTD3Fj4mVXTvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com

On 24/07/2026 17:50, Tanmay Kathpalia wrote:
> The Altera Agilex5 SoC integrates a Cadence SD6HC controller that needs
> platform-specific configuration to operate correctly.
> 
> The SoC requires three named resets: "sdhc-reset", "combophy", and
> "sdmmc-ocp". All three are exclusive and must be asserted together before
> being released, so the SDHCI, SoftPHY, and OCP/AXI clock domains cross the
> reset boundary simultaneously. SoftPHY is shared with NAND at the SoC
> level, but only one of SDMMC or NAND is enabled on a given board.
> 
> The IOMMU maps DMA addresses within a 40-bit physical address space, so
> the DMA mask is capped at 40 bits to prevent allocation beyond the
> controller's reach.
> 
> The silicon requires the MULTIBLOCK_READ_ACMD12, CAP_CLOCK_BASE_BROKEN,
> PRESET_VALUE_BROKEN, and ACMD23_BROKEN quirks. Since
> CAP_CLOCK_BASE_BROKEN prevents reading the base clock from the
> capabilities register, the maximum clock is supplied from the platform
> clock instead.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence-core.c | 113 ++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
> index 18846acc0b11..24130655a385 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> @@ -90,6 +91,7 @@ struct sdhci_cdns4_phy_cfg {
>  struct sdhci_cdns_drv_data {
>  	int (*init)(struct platform_device *pdev);
>  	const struct sdhci_pltfm_data pltfm_data;
> +	u64 dma_mask;
>  };
>  
>  static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
> @@ -196,6 +198,23 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
>  	return host->max_clk;
>  }
>  
> +static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
> +{
> +	const struct sdhci_cdns_drv_data *data;
> +	struct device *dev = mmc_dev(host->mmc);
> +	int ret;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data || !data->dma_mask)
> +		return 0;
> +
> +	ret = dma_set_mask_and_coherent(dev, data->dma_mask);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
> +
> +	return 0;
> +}
> +
>  static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>  {
>  	u32 tmp;
> @@ -462,6 +481,72 @@ static int elba_drv_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int sdhci_cdns6_agilex5_init(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct reset_control *rst_sdhc;
> +	struct reset_control *rst_combophy;
> +	struct reset_control *rst_ocp;
> +	int ret;
> +
> +	/*
> +	 * Assert SDHCI, SoftPHY (combophy), and SDMMC OCP/AXI resets together
> +	 * so their active periods overlap before all domains are released.
> +	 * SoftPHY is shared with NAND, but only one of SDMMC
> +	 * or NAND is enabled on a given board.
> +	 */
> +	rst_sdhc = devm_reset_control_get_exclusive(dev, "sdhc-reset");
> +	if (IS_ERR(rst_sdhc))
> +		return dev_err_probe(dev, PTR_ERR(rst_sdhc), "failed to get sdhc-reset\n");
> +
> +	rst_combophy = devm_reset_control_get_exclusive(dev, "combophy");
> +	if (IS_ERR(rst_combophy))
> +		return dev_err_probe(dev, PTR_ERR(rst_combophy), "failed to get combophy reset\n");
> +
> +	rst_ocp = devm_reset_control_get_exclusive(dev, "sdmmc-ocp");
> +	if (IS_ERR(rst_ocp))
> +		return dev_err_probe(dev, PTR_ERR(rst_ocp), "failed to get sdmmc-ocp reset\n");
> +
> +	ret = reset_control_assert(rst_sdhc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to assert sdhc-reset\n");
> +
> +	ret = reset_control_assert(rst_combophy);
> +	if (ret) {
> +		reset_control_deassert(rst_sdhc);
> +		return dev_err_probe(dev, ret, "failed to assert combophy reset\n");
> +	}
> +
> +	ret = reset_control_assert(rst_ocp);
> +	if (ret) {
> +		reset_control_deassert(rst_combophy);
> +		reset_control_deassert(rst_sdhc);
> +		return dev_err_probe(dev, ret, "failed to assert sdmmc-ocp reset\n");
> +	}
> +
> +	/* Hold resets asserted long enough for all clock domains to capture. */
> +	usleep_range(10, 20);
> +
> +	ret = reset_control_deassert(rst_sdhc);
> +	if (ret) {
> +		reset_control_deassert(rst_combophy);
> +		reset_control_deassert(rst_ocp);
> +		return dev_err_probe(dev, ret, "failed to deassert sdhc-reset\n");
> +	}
> +
> +	ret = reset_control_deassert(rst_combophy);
> +	if (ret) {
> +		reset_control_deassert(rst_ocp);
> +		return dev_err_probe(dev, ret, "failed to deassert combophy reset\n");
> +	}
> +
> +	ret = reset_control_deassert(rst_ocp);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to deassert sdmmc-ocp reset\n");
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_cdns4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> @@ -481,6 +566,18 @@ static const struct sdhci_ops sdhci_cdns6_ops = {
>  	.hw_reset = sdhci_cdns6_hw_reset,
>  };
>  
> +static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
> +	.set_clock = sdhci_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.platform_execute_tuning = sdhci_cdns_execute_tuning,
> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.hw_reset = sdhci_cdns6_hw_reset,
> +	.set_dma_mask = sdhci_cdns_set_dma_mask,
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns4_ops,
> @@ -508,6 +605,18 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>  	},
>  };
>  
> +static const struct sdhci_cdns_drv_data sdhci_cdns6_agilex5_drv_data = {
> +	.init = sdhci_cdns6_agilex5_init,
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns6_agilex5_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_ACMD23_BROKEN,
> +	},
> +	.dma_mask = DMA_BIT_MASK(40),
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns6_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns6_ops,
> @@ -709,6 +818,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "cdns,sd4hc",
>  		.data = &sdhci_cdns4_drv_data,
>  	},
> +	{
> +		.compatible = "altr,agilex5-sd6hc",
> +		.data = &sdhci_cdns6_agilex5_drv_data,
> +	},
>  	{
>  		.compatible = "cdns,sd6hc",
>  		.data = &sdhci_cdns6_drv_data,

