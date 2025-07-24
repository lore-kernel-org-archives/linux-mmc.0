Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049E269AEE
	for <linux-mmc@vger.kernel.org>; Thu, 24 Jul 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354492; cv=fail; b=eAIKAzOSlznm7LZdDyJXzc8C1+22d/u6vuzc40NpVdUp3LqboNP3rmKUbUDARMDjxiGnHlbtnzIy4ECTOexc7f/jeDrXUc/nNUrU8jAMrn0JhzrdCSW5NWBHkgkeim2lpJvNMDiaw4rZaw/FEABEQSz7KmVuA1xtcyCnFa+ANTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354492; c=relaxed/simple;
	bh=cuM+bn4veezWIdn3HIpZmJmdZcjoF1+ktqGhSWkEyYg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qyfVnyz0uYHOYLdQWJN1EZ+sv1gM8n70GD72a/cEh5Pi4kEKHCVpnVS7AXKAL+H6u7ojxhCBDAiLyS2zHBMo9akdUGxPchxn6D2OZbwanauD0tAnS35+dp86Cvv6s4QfVKK3v74wMDQSFKZb/KzVIXnlP6DdwupaprWIUJbzE2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gt2NnzdK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gt2NnzdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753354491; x=1784890491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cuM+bn4veezWIdn3HIpZmJmdZcjoF1+ktqGhSWkEyYg=;
  b=Gt2NnzdKmxf5rXnSJpHguflf/vFo13E1XgByIlydpa+cp/E2oPg/T1z0
   qozAqzvTQ74MlwO6MqNzAfBJFMNJo+ztl4MzqNGYhbNFJRnqgD4bT0zXS
   x0Hn4XC89m/B7LGYft1s/WBqyPkOz30eeHCeawtMFta30DHPDyRMjV3lo
   bsKUOvG++0g5AVqp5YxcrCmDxBO/e0QNgehIlBmc256FlhqD3QlKtpYOC
   3Dmg+sx1RNn0wzU/nWcdAIHzHqPPs91tqCH9NpdUdPC+gGzju3vPcprb/
   ScX5X4/Z9klePKCX1OYXB2kwmxEnBoLsBDQaSpwLTDXUNptjPWJDgo/GM
   g==;
X-CSE-ConnectionGUID: AHzpW6vgQTyC15gT7yzvug==
X-CSE-MsgGUID: LhIJw/lcRRSQUwYT2ubdPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66359393"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="66359393"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:54:50 -0700
X-CSE-ConnectionGUID: ktvZ6wzqRh6FNtUqJOI5aQ==
X-CSE-MsgGUID: +6T5iE2jSTugSHCgl0zzOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="164406998"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:54:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:54:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 03:54:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MopwpHDv/uiobY/fmO0LULwTRuj1k/gWT76TlCff+jqVSTy4rCOk5U/1xKITXk3kXhzZeFGLwzjxK6iM7Qmi61k87cllCX7vy2iDRkY9nUc20KkN1lLtO76XhJsp40kmIYd56zYLBQLp0w2PZf5fUJCUi85FbHNzVzDFZ+eHTvj+EbYcQxib8cVa+xzi5RTcbs51xQNc1ag07LU7NSY3hR/e4HXkn+3MtSW1B8xKfaZwBxiV3k3P1gQ0K+m9JUV8T1TBWSAWOtJ+Hsw2+777fXhSOWdlz1Hj/yWqFcM4m3nhAR7uGMJOia7NdR2sUzRBCtODecIEUoWGMyeCpBWYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R33ncTc+CRbEN15qINzfNqlxs1wsJf/T/Fm4XOaE0O4=;
 b=tDeJRqNXn10EjuTMOCEKDhrt5BnaME8H+PSA2jqLDHwSxymzkuDgQM27FRHaJwO6zp9RUwdfJ/6zebgsG3g/Gt9IMHHbV3ZqsR2xzhtnGgxh95MuZs+seKPb6lwCqoVRfex6FaLsP67vJNKFc5t2qAhfrZoWD+Xoe9YUT4bGSOvChkTyNwF8UfG72V7Gaclb+mILTCzaRV2R8DolfBuhbXHl5G5ZNbpS9tO8gkzLY/Jd1pU7lkXwYc13O55pi1OHhVC1H0Z5VVJCcpjhX2A6Bj37r4WocXuIjsVobwNNO61n2F78rAmzRnJutJqMQ9OwykeoPptobRD4peU1XTyBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9009.namprd11.prod.outlook.com (2603:10b6:208:56f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 24 Jul
 2025 10:54:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8922.037; Thu, 24 Jul 2025
 10:54:41 +0000
Message-ID: <7b124fe1-4f7b-4218-b564-e16ad2c3882f@intel.com>
Date: Thu, 24 Jul 2025 13:54:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing
 parameters
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Kyle Roeschley <kyle.roeschley@ni.com>, "Brad
 Mouring" <brad.mouring@ni.com>
References: <20250723214216.3259-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250723214216.3259-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6723674c-e59d-4914-bb75-08ddcaa07d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHd6VFA5UjQxdnRmbG5QYnlEd29DZ1FtQWNDTWN6eXd0WDA2b1lKK24zVTI4?=
 =?utf-8?B?V3lNMkI2bmg0aCtFeFhmVmovN0NhYVpxMUJvazg0Q3BxSkV2OFVuNW5QSDBS?=
 =?utf-8?B?R1ZIRHNhWjZwajl6MWRlQ1N2dlJzdUdXdWVPL1FWYzEzblpON2lIWlZaNTZB?=
 =?utf-8?B?c0gxMWZRRWxWRDk1RGlSTFlRd21CMGw3Tnc4VVB0a2tCZmxhOG56U085ejdx?=
 =?utf-8?B?cjg3WnhSVkkvUVBrUEo4NG13V2c1aktSNWtJRFUwUGtMSjV3L292bWFSU3pP?=
 =?utf-8?B?TDlXMVB1TWVnaFVETEw3TVFXOG1LTHZuUUFRMm0rL3l4dlZ4bXJKendtVDlX?=
 =?utf-8?B?MFdVeTgvdy96MHB1UHhxZkRENHhycWt6UjQzd3hsUGhyMmFtTlVKVGhWV1hl?=
 =?utf-8?B?NXUzZnpISisrck9CUG1GZDJFcVE5T3g3MGhPbE52MWNITzNtOUdiODdyb2tT?=
 =?utf-8?B?QXBpYmRRSEt4bUkvd1NIRWtPZkpLUXBnQWR0RkFZYzQzOEVzM1BIMXBoeC9C?=
 =?utf-8?B?YzVTWWhETXpOUmk3VENCUjRnak4rRms4ck9iV3VYc2J2dTF5eEZJdE9DdWF1?=
 =?utf-8?B?TFhrWFlWdWowbS9FUW1tWDVtWDZmL1JpTEhuZ2EyaDRnc21iYTNSSG01Z0Q5?=
 =?utf-8?B?UU14U0wyZlp3dnliekhrazN3MDJJQnF2dzZGZ2VCUGZ6cDZhWDYweWYrZjJp?=
 =?utf-8?B?N1h2UW9qSTVPaWFUQTczMUp1UnNsUFBKMHhpUXRMRnZ2QkJaV25EbHZ0V1Zk?=
 =?utf-8?B?VmEzMnFwbTQrSlh2NW5XaFVLemVYUVNvZVZBbkMydmxudzhxMi82V2FOMlU3?=
 =?utf-8?B?bENtS0d5V3VIVXJ2Z21FNVlBSVN4cVFJbVhCS3FTWnJqbEVEbWk3MTBvVGFH?=
 =?utf-8?B?OXh4bUNOVHFIM0UrcjlxejJ6TXlDTDJZcVNkUDQwc3FnZE1tQy9IamRPNTda?=
 =?utf-8?B?bm9iMXMyOG8rSFVJUHZybUVPVER6TmlEQkk3UW80N1JJRHV5MERISFp4VlZR?=
 =?utf-8?B?MUFlYVpjKzdoVGhlS0FhekQ5ZWNyT01vRnFhd2ovYkt1WWY3NEFnWnB3eG1u?=
 =?utf-8?B?dUxaWjhKbUxCcXlkS1RtMHFjWis0Vm9lSlg4VUo0MG9BaG5MTHBvQWdYeXZu?=
 =?utf-8?B?ZXZEbUhJeVhyY1VNU0pDRTR2RjJybUFUZnpmeVpxeVJPbUQybStOZSsvbzA4?=
 =?utf-8?B?Wm5hT2xIZHpaWjRtUVNjTkxkTk5sdnJ2bllIWTMyRVd3Y0NWLzYxVFJuZmZo?=
 =?utf-8?B?QnpFOWZDTFRHZ0ZWdmVIMTdKMFJtSHBwZ2xwRG5OU2lScXpPdm5FdzVLVkNh?=
 =?utf-8?B?SHhNU1dSaHZXcnlvZytmOThSY1NWbHM0ZGJqemRtb1BuQ2Z5SjBKMVpZcFJ3?=
 =?utf-8?B?UnZ0L0x1UUJRcGRrWUFCYzRaMmhsSGFBZUE4L2czYUJVTWF1cGpvelR1dUVC?=
 =?utf-8?B?d2dsK2xIdVkwdVIzSE1reWVPNmhwbEFiellqdDFyMTl6L0lKTW14UEUwMG1Y?=
 =?utf-8?B?MHpvNFJDZGRKV3A1aHU3WFp4dERvUXQxaFdmeXNHYkxSQ29RemFlODRwcmJt?=
 =?utf-8?B?U3dsRFdCaDc1c2hCaSt2eExJRHZLYUZBZTg1YUVqSTNrNWFiY2RNOUkyMExI?=
 =?utf-8?B?aW5zVGhTOFo4L2ZFTGZHM3N1amFMbUtnVU5WVXhFQTRuZExuaHVrbWZ0WlZF?=
 =?utf-8?B?dnhINEdBcUIvNGlwNDRiV1pPSmtwSlpIWUVEemZaVUhGcnZsT2QxNTN5STAw?=
 =?utf-8?B?VG1GSElCSzRsSUNGUS9XZnRxZ0FjWmVoTFVXR0E0VUxqRlphMC9udzRiak5N?=
 =?utf-8?B?b2JCTGhUVGtReWZwbHRoRnZuOVo1NjBMSEQ1TmRHNCt4NnA2cjFQcGZnUHZW?=
 =?utf-8?B?UVFKcmVOaW5qSHRUZVlCallnL2hicmVTZlpWNUlsQnBzS3g1ZFd4MnBUeU52?=
 =?utf-8?Q?f+Rs3dmL0ck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXd6ZVRzWDZ2RmEzb2dPUE5nUEwzQjFkcWlqcUh1dGFQMk5tNEo2RFVKdk0w?=
 =?utf-8?B?b21tVmFFMTVPbSs0TXpOUVJ2T0VXRGFDb0l6eUJWNG5jRGNzRGhkdTR2THlC?=
 =?utf-8?B?MHFITGRJVGsxczgrcjUvaklqUHVNTkRiNHJyTGFaN0t0eFJMSHRhWmZ3T3pp?=
 =?utf-8?B?VzVaOEVjYXhCVnU0czViYnZ3MldpWHMxRHVNOFlLbTdEZlJqOE5ZcG5ZRzBi?=
 =?utf-8?B?OVVXNFRWQTlzREJQU2IwQ21sMjRYejZtaU1qeG8xbFUyUmMvNm5FQnhjRWIz?=
 =?utf-8?B?alk3Q2FPeUZkOVJmSUI1NFVCTFJWd3BMbjBwcGloK2VvTkp4SEZ1UXBYcVcw?=
 =?utf-8?B?Wi9MV1FQcjJxdXBuYkwwUjR1dS9TUHc5dFlIc050RnpXRlo5SmM2M3ZuV3Vx?=
 =?utf-8?B?eFRETE9DczlLV3F5QWoyOXk4eFVqN2tlRU5ZbFJRNDlsbS9Sb3ZiMEgzOUJL?=
 =?utf-8?B?VUFBRlZhdVF2cnZwZzU1UExXWWVCZmFxZEZOSlh2N3VBZ1dYWUQ3TUFwdXN0?=
 =?utf-8?B?SVRYYXc0SWF0ZXczam5mM0wxNWFvREhzQlE3VVdSVHBTYXNJS0oxVlFvdk04?=
 =?utf-8?B?cldHWUMzaC95bVhodE5MRVNEU3NzMDVaaGJHaUtlUTk1K2JibHgyZkl4MGNY?=
 =?utf-8?B?VThrYjIwRXhnUzZYWFp1T0t3QzIveTdoSW5QVmVXdk9hWFcyVjFRaVUwZEJr?=
 =?utf-8?B?YVpVakVQL2tKa0NTSUlMbFBBdkF6aXEzVGlja2NPY2VLTXd0Nk5jQUlZbnVj?=
 =?utf-8?B?elBWK1Vic0FzSmI0d2NGSDY3NGJ5Z2REUTZTem9yOEUrSDNPN0JxZUJsbHRI?=
 =?utf-8?B?Y2FDMkRyWVNnU1gvd0kyOFlMOVg1a015eXFhdWxzekdGdVBuSnZuVXlJcGdz?=
 =?utf-8?B?eWF4bC9QWkIzQzBhUmdMRWRjbmpaTFUzUlNTSTF1Y1BTSjA3UXNHczVIOWxC?=
 =?utf-8?B?Ty9qT2FoU3I5amRnMy92ajUzK0pPeVRoenVteUFIUHRLN2RMY05Cams0Yk5r?=
 =?utf-8?B?L2ppWFNodnRlSjZzektUZmpweExvQmU4U3J4RmkrZDhWd1RSbWdKU1E5VjJu?=
 =?utf-8?B?cHl5elc1UnBvejR2WnBveXNBOCt1ZFltSll6ZkFQWUJscEg2V0E1OVFWR25x?=
 =?utf-8?B?QVc3L1RBdkViRlF0cVNwcHIxbS9wR09rZEErVy9Yd2VlS3EvUzFLaW9KdXBW?=
 =?utf-8?B?dWpFNUdtLzNldG1nenhBYnRybFV4bHBheHB2TEMzNVVkMGF2OEJaWmw3U0pU?=
 =?utf-8?B?NGxiN1FuODUxenFOclRyU1hUUU13alNFbnRtZm5tMTBlT3M0SmdadzBsQnRu?=
 =?utf-8?B?T1o4aGNqL3Z6bENxWTJTdjBDSDhaVGpTd3dUVlBlbmNDdnpZdXhOcVp1WXZw?=
 =?utf-8?B?aHhQYmFxZWxoWmQ0NVhsOFgxanh0QjVSNUdZVCs4dWx1dDZpVkRDSlNGSmxK?=
 =?utf-8?B?cEFQL2ZBSlN5VFNVb1YwNHd5WWJNTEJROUtoNGVySXNLdm1JZ1d3YXFWcHZT?=
 =?utf-8?B?RVZBY3NCVG85cU10N1owbEFVbFIzV2EwaExFbnNkSzUwUVBXdGtNcnRvZjFW?=
 =?utf-8?B?QU03WVcvTk0xTzhrSCtiT0Q5SkxzV21zOFFrejBVWHY3R0FvWElpTERsUHVI?=
 =?utf-8?B?dTVBSUovT2t3dlhoQmZ1ckI2VURwL0kvOXV6b2IyYWNSMkdaZjJQWlBraURI?=
 =?utf-8?B?Q1M0RmM1VFBUTUFtV2Vvc3I4STZOVmNFMm5tbW00ZWhHTmtyZjFFNFc4SG5Z?=
 =?utf-8?B?T2hkL2ZXaU5kUmMzV21pZWQ1OHplSkpRcEtuMkJLdGpXUUJCNGtzcHIzMHdI?=
 =?utf-8?B?RXZtNzRkaVJsWWlOTTluUWNjLzJISU5CNmg1d1FWb3VpL2xYdW1MSm1xRVgr?=
 =?utf-8?B?NWY1MU5sK0NuREliVzY2OElMZmtnOG9ZSVp5MFpiQXgrRjB6M2JRRGMvR3hW?=
 =?utf-8?B?eDZtcWc0TUJFSnZYcG9sRUkvYkpBZGNYU1JEcGNkM0kwcWhUdG5reS9RVXRQ?=
 =?utf-8?B?QU9saDIvMDFzaHlqOGlqdzNRemJLclNKS3FwUERGZkZxcVZkZEswVWN5bDhX?=
 =?utf-8?B?VDkrdzNlYjc1REs1c21tbnVsZXc1Z0VCNXY1UGxLNHFERHVmaytlUmNjWjVy?=
 =?utf-8?B?d0hSQmZPYXVqS3lVZTF3bVg0N1RCVlNTWlJ2N1p1Q0xoUmNjcGZscUFybDh5?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6723674c-e59d-4914-bb75-08ddcaa07d5a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:54:41.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68DGTqOMNnWEMQdXvEIEPWbvmyX184QxhnOMzEcPANgtDH8UxvatNgO2Aaxx1APc4pndBXSRAuBSH08V/0sqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9009
X-OriginatorOrg: intel.com

On 24/07/2025 00:42, Erick Shepherd wrote:
> Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
> the SD card clock parameters only after first disabling the external card
> clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
> SD controllers which otherwise breaks voltage switching with a specific
> Swissbit SD card. This change is limited to Intel host controllers to
> avoid an issue reported on ARM64 devices.
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

One formatting error below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index b0b1d403f352..d586dbaecae5 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -689,8 +689,19 @@ static int intel_start_signal_voltage_switch(struct mmc_host *mmc,
>  	return 0;
>  }
>  
> +static void sdhci_intel_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	/* Stop card clock separately to avoid glitches on clock line */
> +	if (clk & SDHCI_CLOCK_CARD_EN)
> +		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN, SDHCI_CLOCK_CONTROL);
> +
> + sdhci_set_clock(host, clock);

The indent is a space but needs to be tab

> +}
> +
>  static const struct sdhci_ops sdhci_intel_byt_ops = {
> -	.set_clock		= sdhci_set_clock,
> +	.set_clock		= sdhci_intel_set_clock,
>  	.set_power		= sdhci_intel_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -700,7 +711,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
>  };
>  
>  static const struct sdhci_ops sdhci_intel_glk_ops = {
> -	.set_clock		= sdhci_set_clock,
> +	.set_clock		= sdhci_intel_set_clock,
>  	.set_power		= sdhci_intel_set_power,
>  	.enable_dma		= sdhci_pci_enable_dma,
>  	.set_bus_width		= sdhci_set_bus_width,

