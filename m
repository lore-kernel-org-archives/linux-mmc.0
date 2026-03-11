Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60A3C5529;
	Wed, 11 Mar 2026 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219927; cv=fail; b=SXGQxoIZNW557t5XXDu4benN+aWXvn1QQNX8yAb6PYj0kaE7yTE8mULyMtcOkPoTOv8xKiXuDGUScPIopNAZd9VJK3IneNurQ1H+l7eRpjkvgRU90un60pSQsrzKHzPOmyu6hb1wwJ6TmxRbCtkwqlNF9QTEACJyXo3vs0HfWjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219927; c=relaxed/simple;
	bh=fNzMK9QgACYZeZejdwDIl9ujGdIAcZlAGZ3pinazGmI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AMeiAtFp1Lojc6JyS5H/gXWAiu1ER5KiGwgOctS0E/cBLiDz0ldkRSBiJR5UYTayPWR95oj9W/YsaidZiYnboZXMTN5k8FUfsbzjbVJrTY3o4K2HepDPns2QapcV+J13WUpGtLoqRUcxd8dBpirKMy/D0XUH3Cixgn5LQzXxqaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSpg04me; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSpg04me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773219922; x=1804755922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fNzMK9QgACYZeZejdwDIl9ujGdIAcZlAGZ3pinazGmI=;
  b=dSpg04mefKYHDlYeeMDx0KpKu6Ud2XHGVz4Aa+uYMoGpUopE8HakNu1h
   20fXmqfugYC8QSrRQfQxgzuomWY5ATugUIsNmhkVRqrIe9IKYRdUS9xiG
   j54ZSO8Im2LqS92ekkAFORvAF0GguCNo6tcxNXF2XyA0BtREoAO1iD60n
   fGmpFko2R9g9g9BJ0mTk2NmyLdB0CyWDxHU6rGBvDByaDySHXSYV3857p
   Z45xZbmKGrUECZTmTfXxvHiT4LzjRcFFHrf/oRnKgv0SNoLZbsoXPPgBA
   odCslep0T3NCuKaNXuXsOkwNOg5cpZ1QfMHL0kbTK0W858bHtk8PhXeTb
   A==;
X-CSE-ConnectionGUID: zs3xK6wyQVe0NH5EGtqBzw==
X-CSE-MsgGUID: SUFg/KlJRyanLDjc/FHghg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76891342"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="76891342"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:05:20 -0700
X-CSE-ConnectionGUID: Xv4FT6D4R5qzkmwj5bkTuw==
X-CSE-MsgGUID: oYMm4DslR6aKCsyjl45BPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220580374"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:05:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:05:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:05:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnRFTKZ5/CkblW8sTMWEdKpJU1mxni4gMxjqoBWvpLFv/IfYBscFMtp9OtYaE+Cz4hoQAsZ+RgPXiW2m5bnliU8Ii6/Gjv1pptz3pySqYGKHmo/gpJoiXGqDk0TL1U0n3p92bI7BhPkjIS5uX05bE/gKLyWv22VXcnijqsP3vQPHbRd0eoeUlhgz/lB+/rjb/cqk2ZYnsNHoF4dchs7e9QikylT6/rAaW9bL/iaj3wrdtLN6ZOLFlW/57Cgj5IZ/CxD0eM6TI7udcFAQ79de2ESlTTjAB1ueH9cBVSM12MBzPkzaP3O3DoG5NEUVH2WsCSESUfRDvVDowz7mkBMe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lqHTaE70pU3JXqm77/EyCtSqItJhA0Te9d9zri6wGE=;
 b=rHtmTEJKV77aS2exHksvJrvGc2riyHBZSdoZBb3BqQZR61CuUBpXZq4DmXqyE0hljSVbU4zOqx00XQR7OsjkqYoBRuCJwWMgCFPSgzbbrdjHeE5HiyTyyBDsdwWvrQGoSUhtzI8X3sV0jdjxMUfdFZhT7CgGQvAEf5YwgFIdwUUgmAzjDFMBVGTZ/IHjL+LabI7VBc7qAln1NYibUti0WmunPEmeIXc5DI3AyE+vwVfG/cZBqpQXiAAmWO8N8gjpCeuBBRKHZUGG4hAY2OEk3W4HEwpKHZ74UfOyX9NWIvCYhrcVQtyK9pnAbtbHh3L/5yR824aWzmBfL65lGb2W7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 09:05:16 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:05:16 +0000
Message-ID: <4ff711d8-cb4f-4ef9-b357-3fbfea5124a4@intel.com>
Date: Wed, 11 Mar 2026 11:05:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mmc: sdhci: fix timing selection for 1-bit bus
 width
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <Frank.Li@nxp.com>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
 <20260303105006.989339-2-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260303105006.989339-2-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:10:110::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f514c16-c539-4d85-8c66-08de7f4d4fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L5fwWRHw4uAmZkRCo6O+UWsP6FBOsY+i6LMXpVuwQWTwbW1qvujDVhdxuypxJ5QglSn1DUw19sUSouWp9CIdrgiNJS+FF2vj5UGFhwWufAH16Tn9MYNTZqtACR+EvbtN/iRpYXh8humLRbtPcURgNE6jyAaN463foB85WzyRnUEDWPvqntE3HdwC2FHBv84nOv4WOp5seEK/OfS4NUzDoAI4OeNu//FGfr1q2+b/7KsOOQOrIjB3D1ZOh6CLL/PJfT0XqXoJTA8ex9Z6G67kFtJR60caphRbI5aSkwqxhDsAALylb2EG9S8m1LyD49t9syi6KmAb0gL2BSo3x3T6Pbkr8euKiiAg3CwpAM0h7w4r+RMu66nAy2vwNi6fjDhzGKWNK6clDnSfd+QS+MLSz5dLpI71Q23pZATufn/dfo4e09jOfsLAsnhRKJO66ysAtChGz3w47Tjt/ztG3VfqpR+7QlABJ5Bj1wM4cGOO/pnPXR+deVwaW3Ss5wa2vQOcWgtwM2wdUFTTGgKegqrk8Z8SbxGriY1EmMFRLtDjFwLJYvpJD4Fn0qHjXjJ/Tj6qcr+YYCgDthtik+9hnG/dju7uMTlqs0h+sRhy1l5kRQNh3Q4+ViVEEhiLEIk1PQJTO+epfiiYeCWO7nAMfjo3lxnqlVnI5jXyj6ENFWPw2/QTFFjKODuG8dFYWYQ7R6HHsYn7CoNel67sYFIRSMHPLPMQzax4BweOjxTuU8m3DHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmc0NlIyK1UyU3l1c29xVU1LK2RNekluMmJKWklaRFVFZ2hEdDJSSzR0ekFT?=
 =?utf-8?B?Z2xacjRsZHVuTHl0UC9jbUxIRjJaWDM1MHVGZjZPSzBUdlBTQkp0em8wdzln?=
 =?utf-8?B?d1JLWXRVVUdvcy9QdTMwUnRLWGZGS0lrcDdlbml4VG1wdjRLaElBVFZkbVk2?=
 =?utf-8?B?Zi9xUjhPVVI2ZVZmQW9HSHNiZGVoU3VyeVo2ZlVNamVKQ21DaUNiM3FMRTB4?=
 =?utf-8?B?azBxYXU0WUhyTVNHMVpwckxlcEFZdzFOa2F6MS9iRWMwZDlnQlZkN0NRK3g4?=
 =?utf-8?B?M1I5NElDMVVWRHNMbFIrQy9yMkpqMDJYcjBmMFFpWUQzTnJRejlvQXcwOGZY?=
 =?utf-8?B?eVRFdkRYOXV3b3hkanptSlByWWFpZ2pLQVJzQk91RzVkWEpxTUNtMzczWW5r?=
 =?utf-8?B?QW92LzZudzBhYlIrUlFRR0pBMjMxOXg3bDExc0NuSGVrdVJDalJBMml1VGNQ?=
 =?utf-8?B?elcwTTZmZ0VZVXJUUmRxZmtXamMyK1F2a1g3aXZrUEhFT3NUd2xoQlNRTlFy?=
 =?utf-8?B?cXRBbHRGbmp5NE5jTGg1M1gxRkUwdlVydnRGalltWU03c056SVJ6eXdRK3dt?=
 =?utf-8?B?dWNkSWNCbStYMmJlN0dxZjRTdjJ1S1ZFckxjdzBMQVE3cmYvUWdEZzQ2eUpH?=
 =?utf-8?B?RlM0Yy9nV0xnMGp3MFdrQTZpeDFJRVdyOGRIZGVpUzJiS1RDNElJUDJ6M2pt?=
 =?utf-8?B?a1hsSmZITERPL2xuT3hiQThJa0FFV0l1aUF6Yy9NYU1rNTVSTnFLOFk4NEt6?=
 =?utf-8?B?TkZLQnZlYjh5R1gyWGZyREVFbVVMZXBMS1RMOG4vOWpZRWttd1RDVnVmL2N5?=
 =?utf-8?B?M2xlSllPak5hVnMxMkpBcnZGMG1CY0JtcjlJQWllNU8zaXJsdkk0YktvVS8v?=
 =?utf-8?B?ZENrWnlQU1BHOEJjVXFGbDZpQU1Tb3FJVEZMd05XWmRYUE1VOW8wbGpWS2E2?=
 =?utf-8?B?MDZ0NnZVcEc3c0h3aWdqMll4VUZMMzNUQjVZaktSYldHYURyNjVVVlMvb2J0?=
 =?utf-8?B?Q2lWTUdIQUZXOGVlZTkxWWlQeDFxdDRwdEtzazgrbFd6cDljeW1KYlU2eTJv?=
 =?utf-8?B?Ny90enpNczNvcGtpYW5wREs2eDloeGVudUJEcUxkYmpIQmNHbGV5Wm8wZnNy?=
 =?utf-8?B?akZiYmorblJ1c0lpajg0Tjhvbmd6VS81M3YwdlFRUjg4RzF0bCtFcENiTENG?=
 =?utf-8?B?V0VBRi9uYmhBb1RERllwN2NPRVN1MnE5S0x5d3VBSS9oTkk4alpKNkJreDQ5?=
 =?utf-8?B?TCtJWTM4T1doaVJ2dGpJVDNLeENTQWpWS0loMDdsMlZiaWo3QnBlSVl2YndH?=
 =?utf-8?B?Z0k3SnBLemFDeUJPRHdIdUNPT2N0dGFuWE11RFpzb2h5OU0wUnhGTmdpZWk4?=
 =?utf-8?B?NGx0NjFiT0w5QkpEY3JQcGxpREMzOFUzMFkwVkluL2dLV1ljYXNQRCszVi9t?=
 =?utf-8?B?S1UzSmNUY3pUeGNYU3NlWWQ2cWMvRTQyYXZRSjhlQzJhN0pwOXhFSWJEQlA3?=
 =?utf-8?B?dlpWTE1TZzdPc0VFWDV6eTk4Qk9mVFM0K09FZ1lCMWlxQjJ4cjY1S09sek80?=
 =?utf-8?B?dTQ1TzUxb0F4TmFrdkRTOE5BVUtDajlRbU9EeVdCNzlsRTJDYTAwWEVYb2Jj?=
 =?utf-8?B?RzljOTVURTZEcmQyUmljTFgyUjluWExlb0FSRFU1SFV0UkxTSEhHUXhtWEZz?=
 =?utf-8?B?SFVUKys3ZGE0MEFKbC84SjZlWmYzVXRoL3c0a09iLzNBd3NhWjJ3dUd6YWxP?=
 =?utf-8?B?YTdDUHkzSFZ1TG82Z1dhc3JvOHBkRzZLa29TUVQwVXRCS29IRDdUZ0pQS0Zt?=
 =?utf-8?B?U042WEplaWwvS1FDNjNpNTRGRjBSdm5WYnFYbWVFcVBteno0TS9pSzVVcENv?=
 =?utf-8?B?eVQzU2I4VGRpRmI1V1hncERmczlEQXZnT3hHamJ0L3hub254aDZZUTY0ZWpQ?=
 =?utf-8?B?clEwTW9FL0dJRkZzSEY1NDQyZEx4ZTVMVDQydGhIYWNLY1pkOHQ1YURMUnpH?=
 =?utf-8?B?cDJmZWN2VkxKVWFuRzgzOUVKbzJocjRYMDR6MTNoRjdWTFhoOWN0N21kcy9E?=
 =?utf-8?B?THZOQmZRZDV0a2R6YmJQRGM4WGl6L1g5bGhMc1U0Q2g3M0FpZWRWdlRKSWo5?=
 =?utf-8?B?ZlI1TmpoOGRpSDluMDdnSGhyTmxPWkMrbG9FV0xpbHhVUlgzZnlrdFZodG5H?=
 =?utf-8?B?VXRtWDZMelFKazUrRitzQnV0Y01CRGwyVndrQVFmZkNTYldham5McjBDUDMx?=
 =?utf-8?B?dzY4VExtWkNGL05RN3ZRd1ZjRmlsSXRkbGxVT2h4dFN0ZkJRd1RqQmlxR09B?=
 =?utf-8?B?Vzc4ZGc1NGRHSlByTVJHaDVRWUNqNmVmZ25HaGNtVmF4V3BaWnNVbVMzSy9v?=
 =?utf-8?Q?rm1Ve/hEb7rIFzIc=3D?=
X-Exchange-RoutingPolicyChecked: Y206fcUAtrmnIdGIQK4Ols6U/R2+ZVtGhHIPmWXnjhUP/XFcwdYd71yC1AfxgK/G7G+R/RQbWjPhwPXBUwsMZownLv4EQ+gXvJCYTZHd1Zs22OuZ4owbhSQt9wlNZTZ7dDqBqz+PNJxOscyal8K8GOlT4pR7zczPDTWaJdon6qG7uonACxC9HEuQMI5g8+n8CHgvlhoyhRXrLpx/VN+rYlBMcXP7yZ9qN7oavQLCcr39yrSXdlzQAz3/ZTqG0kHbbMRTTp6L3KMx/hl3gwghj7LJ+cnQKI48Dj4KOQFAWIszMbbLQFjd73JNtLO4be4a7KBWNxy0OxRHt/wzYcY3qA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f514c16-c539-4d85-8c66-08de7f4d4fda
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:05:16.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7qregIbiAArMtOYQnBm+meYXcAojapj/aKtHn+BJKJAfC+JMQfpJ8zJl4EICFRfeq3CM2K8/hefZhtzns1GLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

On 03/03/2026 12:50, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> When 1-bit bus width is used with HS200/HS400 capabilities set,
> mmc_select_hs200() returns 0 without actually switching. This
> causes mmc_select_timing() to skip mmc_select_hs(), leaving eMMC
> in legacy mode (26MHz) instead of High Speed SDR (52MHz).
> 
> Per JEDEC eMMC spec section 5.3.2, 1-bit mode supports High Speed
> SDR. Drop incompatible HS200/HS400/UHS/DDR caps early so timing
> selection falls through to mmc_select_hs() correctly.
> 

Fixes: f2119df6b7646 ("mmc: sd: add support for signal voltage switch procedure")

> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b1a3cd574c84..3e163f14a640 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4539,8 +4539,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * their platform code before calling sdhci_add_host(), and we
>  	 * won't assume 8-bit width for hosts without that CAP.
>  	 */
> -	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> +	if (host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA) {
> +		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +				 SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_HS400);

SDHCI_SUPPORT_HS400 is non-standard.  Hence the check for
SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 is needed:

		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
		if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400)
			host->caps1 &= ~SDHCI_SUPPORT_HS400;

> +		mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +		mmc->caps &= ~(MMC_CAP_DDR | MMC_CAP_UHS);
> +	} else {
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
> +	}
>  
>  	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
>  		mmc->caps &= ~MMC_CAP_CMD23;

