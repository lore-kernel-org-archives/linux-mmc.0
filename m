Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD62459F2;
	Fri,  7 Mar 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373653; cv=fail; b=kYo8mnq7SKWzvNbXdAcaO1DeiBB827ZBaYjtJIvwbe0eECu7T0D/fSu9U2CfIp4KHibPkpsr6pZ8QbsSerbe4Sypnx/5TOH1AWAf3N3PHMPtf37PvrXDKfoopAJuJK3lLe7B4icP1zLKvwaugBeiqdfAHfb6i9HV206A/xkdGc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373653; c=relaxed/simple;
	bh=u8guiqaEs/Lh/MlJi5WEvWf4THrWCAmFkPXjHIVnCDc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JYQp2BNeGGHjFtnTxPVNwpWgdw/vZfIDjTPULwmmYfRMaumqpxkhNLARtrzmzVdCBQcXrZAecYoK43jhkZPM4hWHuRai+lYwuFCrUpHdYN9gwqX4Cf3vJfNZBsXQWfdo4wKLA4XrTVSQHfbqr6YXkGJ61H5MkA6pAHJIu09LSZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSHeKOz6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSHeKOz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741373652; x=1772909652;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u8guiqaEs/Lh/MlJi5WEvWf4THrWCAmFkPXjHIVnCDc=;
  b=aSHeKOz6R2tAsOTsKWDOlRVP43GaPg9BUd2Td2UA+71tGkjgKjqhQs1D
   mkZsfuazInevVl+5mKdii1SFFqOjyP3huhXCdjWwRuw5+XTW/x6NJRjs8
   HR3ZDHIKotxZV5rZNjz5PhrK8FN4KWv7V4Aw6dUMpe2WJGYGv4ekQ50W1
   3N7/d0Xl2OZaUvKD+V5MdA82HZbS0zWhyahi48c4v/T6UFEsvAj4w+9VP
   TY/cEaPrWtVRZhHvGhsGDdttcJN+IOhqGGrfdtIgL8EnCnm48NwzjOpHe
   Q3uPS/JkjUFo172gB5pbwDaq+h1+1IQ3yqz10nOQNsYB/qN8O73to+QyF
   A==;
X-CSE-ConnectionGUID: VdXCZkjAThmG5fhz8GjxXw==
X-CSE-MsgGUID: Kpo3lyDXRR6HKPBC9hQxVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41597360"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="41597360"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:54:11 -0800
X-CSE-ConnectionGUID: +IGOUWguQwSyInlTsUtTkw==
X-CSE-MsgGUID: M0eVnu6tSzyTa1oCPwNr+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119922213"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:54:10 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 10:54:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 10:54:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 10:54:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEbIgaGbAeFTpTGa8wjKJ2rVgkbhGqpP/Gb9NZ3eBka0xditm1YvjdhQ1Z3mVSZJ6Zqy/70UJT+T0RUWYBKdcbJlB/Qm8qgPTy5euEOvDedRk2BJxp5+aL36OdG9/nmEZLFejZ0ZW+ANEUnbMg0fINKORzCVdSlU8gwMp1NVn6MGCWFkIQvM4eK215G3PnaoGbj112+lqckzBR6jF69e/6bZIhpFWV6yl+9rqIfqYt2EVbN4KIXY6EOc9DDM7NVpgKglCxzjOySYV+A1fPJ7qVC6TJi2EUSXJNMvYINlJclAzG7Jqr3VxisPQqA8vh0KHlOqKG7X0fmKx0QFNJiUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9rlhXMjB4xh6KIdw6pck77tjWu9BhmeQrbonAbSXHA=;
 b=p6ss6x5At8ZqhJKIhWD++eCW/OJrTMvC+nBE+dai+xIpQ10AKIvG3S/I9tsFh7BTqDfoG2VmHpZ/loJpJZ2JndxUuQY5wUhZ8FubBFS7IwQHTkWsBkEne1FtMK3YIYszbVq/Y/xkvQ43Tf1N7fS3teEElbDpQUAXLv5VLM9bpfFHFOaqvexxD3dHB+MfAtJC2lR4LUEGJY7ssjvCAJC+3/bIoXMdCU6EhOFCUWPWGJLifEobXiu3yrTYZ5zV0febbVMe2Y/1QEhTVVGjdcf3/ZDYhULHzBR5kmK+iAg+D8YTj8nIjnhU53/CeASkb+ISNRWevEIJl1UMNKfXWa3CyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by CY5PR11MB6342.namprd11.prod.outlook.com (2603:10b6:930:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 18:53:53 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 18:53:53 +0000
Message-ID: <440723b0-a1fa-4f9f-90f4-50dc831c68e5@intel.com>
Date: Fri, 7 Mar 2025 20:53:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <brad.mouring@ni.com>, <gratian.crisan@emerson.com>,
	<kyle.roeschley@ni.com>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
References: <35aebb39-ae2e-4186-8de4-6830ec661f4d@intel.com>
 <20250307174643.1288695-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250307174643.1288695-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|CY5PR11MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa78e11-d011-45c4-c787-08dd5da96753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUhpdDh1Y1h3b0NHcGxraDdhTWdVd3FMSXFwOEpnWVRycEhmdVY1UEI0YXFn?=
 =?utf-8?B?cFo1Y0F2TVV0em9nL21hN0JMQXdoRlFkbU9lMXBLSFVLR2VOanB4SGRHYXJB?=
 =?utf-8?B?d3A4NmNva1lsTGNvUVJjKzJjOGxmOHVNYW1rdUY0b0dBenBVSEZuUi9razdS?=
 =?utf-8?B?b2M1WTFzUVJwSHBjU1cvcVJSTTNKN0Z6UC9PQzk1K1YvTmJyUE1HQ2hGcTNL?=
 =?utf-8?B?cmNORlVxTGIwamxua3EzYW9OdDROMFBJbThkNXpTcWRXODVEdU1vbURHc3c4?=
 =?utf-8?B?R1dJNEtQbDk4VVBRS3JaUTdoLzFnSkVpcmIvS25ibXBHc1dhS0JHRDUzc0JH?=
 =?utf-8?B?ZVB6d1I0QXlZSzBnbDhHa28xVlU2cWxrdXdUUEVFSkp2UnY4RnVBR1A5TkRz?=
 =?utf-8?B?SEg3U0U3NnhKWVdBL1ZtWWFOa3FQaWFMcEFDTzhxdFhwcmVDNGViOE5LYjJx?=
 =?utf-8?B?bXZGbkM3S0lqUFVqWDV6V3Qzb2hEQ0lRaG1PTXFGQ1p2OTJoRFpYT04yMEd1?=
 =?utf-8?B?cGY1dzBXNXIvN2p2VG5PSlMxL1NqL09ySVk4MlpJL2Z0cTVHZjVYTWpFcnc4?=
 =?utf-8?B?NXYyT3N0MXpUMGI3TjVJMk5SSm11QUJBZVJlT2g3RE9icnZaQUxLWlUrZmxt?=
 =?utf-8?B?bXVKUm9ubFUvenJxcTlnRDRsQU9penhteGhHRWp4L1VqaXd2MTZuZE9HTFVQ?=
 =?utf-8?B?TmxrcER2SGNFZ0cvVHZvYUYrYXNGZ2o0MjJSK2dUcHJKK282MjJXNlB5TGZJ?=
 =?utf-8?B?MTIwZjI2T25mYWR4MzNSSDFLQVlkN3BieEZ6RzVCT2pBNHpyTVhYeGZVVWJ3?=
 =?utf-8?B?cEpaQjdFeXlxa1M4NGFXQmlyVnFnR2pJU0o5VmR3djJDakxuNUxsam5sMzN2?=
 =?utf-8?B?ZWF0Vm00dmtsK2lJeXdRNVZUNDJHcUFzRkhWRmw0cFFEV1dmNU80RFlsa0dV?=
 =?utf-8?B?RkxCUlB0VlgxU3hQV2U3UXRTQW9yK084RERxYmRnWlBwRUQ2aVBheWprOW1k?=
 =?utf-8?B?azZ0N2Q5VWJyN1hRalVhTy8vN0FLYUNRb09vbDl0b1NueHRuQndWUThENU1C?=
 =?utf-8?B?TlQ2OERBRHpZa01aeDArYW11aG5nZjQ1Y2JkTXRKNmZqZFdSTk9nWGdrZkNj?=
 =?utf-8?B?R1RwNjdxUDBOeFYrQjA2ZGxVVjBsYTlTNURCcUlTWXg5dVoyNnd4ZzlXb3Zt?=
 =?utf-8?B?UEFzdklYa09kWE9LTkVFVGlwRktCUXd1TkpDMXJPVmRHT2l3Y3VCMFl3ZGRZ?=
 =?utf-8?B?dDJPamdkTXZvbm5NU1JHS1Q2QVRZNHU5VzRqUFBIaXZUWHpaRi9rV3cxTmp6?=
 =?utf-8?B?WTdhSUxURC9GWmVNazM1cnVwbEFhQlhWQkZDamRZbTVzT1JvUjNnMzlMUVlY?=
 =?utf-8?B?a25idXNCajJtVnBvSkFFQUVwNGRoNXdTWXVuK3JreDB4S3pUSkl5cmU3Wm11?=
 =?utf-8?B?THc3SEdxWmdrV2ZpUkNaVXVGVkhnQ1ZqVVFCMkNZbEt4SDlFNERVWW03T2cv?=
 =?utf-8?B?Nmx4OEREQ05TNXRjT0w3TnBVOWRWK1hpblZmNVRoRi92OXpzT2MzUWdvNEZ3?=
 =?utf-8?B?Q014d3hOOGZ1TW5BVTJOQjI1WDJSRHdpbUNvRm5VTytleGtUOU50VVdpb1M3?=
 =?utf-8?B?RUlJcmp1dnA1ZmFrM0Q4TDRFeGhqeWxYU1BrZ0N4Z2E3NkpzeXlqNVdlWWJZ?=
 =?utf-8?B?bEdSVGhSRHVNY0grNHJENzc5SGpONG5mcGNzdndoWVAzMXhCckUrZlZoTnFW?=
 =?utf-8?B?MzAwWThJdnVvVy9mQ1dKeG5wdFE0M3ZWQjJKVUV4MnZxM1dpRlhsZEY1bFZB?=
 =?utf-8?B?UTNOWGZadDhMcXQ4aDVPUlFieWlVZmJZWXpTLzNzS1cra0Z0NVJSKzF2VVNo?=
 =?utf-8?Q?ClCPO5YOQiRgN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGV5Zk1zNE83bHBJb2taR1FNL2ozSHhUMWMvaW80Z0lycVQwWElTUU9kb2I4?=
 =?utf-8?B?NWRvZnhxTjBjSndHU3IxQVhpVWQ4QllrZElIVW9GRjA4Tk1WZysxRW5SN3RI?=
 =?utf-8?B?S1NCUEVYcGs5OGtHZFVBYkdRU09zR0s0RCswd1pSZnVjRCtSQXF4OWRlRjh1?=
 =?utf-8?B?MysybktnQ0M4Mk05U1lCcXpUam5MaGRiYTBhYmRpaTd1VHdpNy8xc0VETXY3?=
 =?utf-8?B?cHArU0ZPcVpqZ2FucXhXVUpkNHBjWG1FNWM2dFpyNGdIV3NWMitNbWlFR2lt?=
 =?utf-8?B?aFBPVm9kWExmcEdTanRhZjh2WUlMVG1tVEc2K0tuQVFpRGxUV1RaRTAza0FU?=
 =?utf-8?B?UGZzSVZBcEZtbDFpMUh0WDhpcVM1cW1sYi91eVpmWDNSM1hsRXp2TVgzMzhH?=
 =?utf-8?B?RUZHcWhzR2RrQzJkNGRpYTlZK00wdHBtamY3S2xXVDg1bXBhdXBOc1doQlRQ?=
 =?utf-8?B?Vnc0d1RDUzJEcFRvYUdzRUtOc3BNWkx4Tkp4NjgzVUZNV3pKN00zaEMyU2N1?=
 =?utf-8?B?aTJ5QzFteUJuUGc5ZTRoS3lEb2p3OExOTEdncCtCamV4b0FwYS8yY0pvb0U4?=
 =?utf-8?B?Tm1sd3BST3FoWHRyNzZEM0EydGV6aWxwYzQzcUhUOURQSUFWRmNodC9leEpZ?=
 =?utf-8?B?WUFnd1F6TUVTT1VnZk14T0VhZ2VhQ09uM1VXNXltVm1ad1V0YnlVOWNma3gv?=
 =?utf-8?B?alY1YkFYb0tuaE81NkYxLzFxa0MyNmpPdjVxeTU4QVJ4TmhOTkthUTFTWWJP?=
 =?utf-8?B?U1ZCZUgxcGhEbEVpb0w4M3RUSzFkeFVUc0d0QXdSeDYrQk5QZG5aaVYwYk5m?=
 =?utf-8?B?STA5cUhoaSs5VHZ2cUZtQzJvQTl6OFhDb2Q0QjlMSWlla3ZyRWVaOTF3QXBX?=
 =?utf-8?B?Z2h4VU12dDZnODlmMmJsaFo3OHVaOEJVMGp6R1BHV1hCbWpWbWw4VEJDU0Jz?=
 =?utf-8?B?Mmt0am94UW5uYW8wdStzUlo2eW5MVkNwZ0VKMVdtbjhBM3NYaGhVUithd2J0?=
 =?utf-8?B?amRKRlJ6VmxCUW5nWUpJazZnbWNoRWNtMnhMQ3pXSFdXaTNteE4xbkdYeFZo?=
 =?utf-8?B?WDBVeXY1eWNMUWwxOFRoaTBkeEJyaUVkdFd6NHJhS2pxcVl6c3pJUmdXNUpH?=
 =?utf-8?B?TnBpMHo3SUlzaG1HZG9UZWlhRGVtMDhyczBMM012c0lsS25PR0hOUStITkVk?=
 =?utf-8?B?RnJmcXNYZzhIQmw5MGpkYnFuTmorcUljNXJDZ1M1c3g2ZklQOGxJSzRod3lP?=
 =?utf-8?B?ZzRVMDNNQ0E1RGFmZFAvU0RQS3RxT250bWZScklJSGUrM1lTTGlDRFA2cmhp?=
 =?utf-8?B?a0dSR0J0RHFxMzA0MjFyTjNtdzVLTXlockZidStnQ0dRSkFYbjFIYnloZG1h?=
 =?utf-8?B?SVBNblNxcGZodXBTVkpEYXY4L0RYei9xOXhHZUNMbktFV3FLby81Syszcmxo?=
 =?utf-8?B?RGFuQ0o5S3JsNzNYSGFIRThCOXpPMGV0bWJaZVltNmYrOXRQYTYvYmZsVEJ2?=
 =?utf-8?B?Rm5lTVlNeFdUODdyRVk3T0xENi9sMzMvSkozR2dXN0Z6ZldaVHdrK2dDOHU4?=
 =?utf-8?B?MUIyMUxqZFdyRm9GOEF5cmF6T2Q5M0JVaDU1alNRZ0xDSjhKYUZtOVZ6Ymox?=
 =?utf-8?B?SUYrZXdPY1krUnRUK01KMEFPbVVQdHNJeGRsQnVOcFg4bTdacWRZNE5OZGdJ?=
 =?utf-8?B?cU0vN1dxOTdjbUMrb3BjK2xBMEN1cDNLV0Q1MElrWXJ6dG5DOFR5NzMzSkFv?=
 =?utf-8?B?c3dmSCtQVU02Y29VRkxzVXVWMnhZZ3VpWU5IekQ4b1dCeGJwOHAvMWQyV3o2?=
 =?utf-8?B?cDJtQnc2NGppYkk1Q1l1MEdjcEJ5VVRnWHV3Si9VQzN1OUxjK3oxNXE5QytZ?=
 =?utf-8?B?NWtoQThaQlRpeXVscjNWbkVhUXdCOEtSMEppZU55T2VnYUZOd244czRSUjhJ?=
 =?utf-8?B?ODhZSiszbnpDeUVZdTljQk1sNWdJWHRVemZHUEtvSnFzOE9SSVVVRmR2bVVW?=
 =?utf-8?B?akN6cGYwMytGNGdsSVBUdmZHd051QlhDamx2WTJZdXU3MzlzM2Q5UUNSRnpM?=
 =?utf-8?B?S3JHS0xFSzFDTTVxNUF4bXEveUt1eUdmaWs2NHAwS2dueHc0Zm9TYktoTzQz?=
 =?utf-8?B?OFJFejhKd0UrRVhQTFQ2RzA1VkFTQWtEZ0EwTG5tUVNSaFB1K1Q3bFVxR3Ny?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa78e11-d011-45c4-c787-08dd5da96753
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:53.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bRfNbWoaCPJpibFTwF/w39iBXqPNT86DUXD+W0rKcqmkPz7TwffkBzcfSBlYoGu+vqsZKJp9IsqNKI1tzSs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-OriginatorOrg: intel.com

On 7/03/25 19:46, Erick Shepherd wrote:
>>> The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
>>> lowered to less than 0.5V for a minimum of 1 ms when powering off a
>>> card. Increase our wait to 15 ms so that voltage has time to drain down
>>> to 0.5V.
> 
>> mmc_power_off() has a delay.  So does mmc_power_cycle()
> 
>> Why does this need to be in sdhci?  Are you experiencing an
>> issue?
> 
> Thank you for taking a look at this. The initial change was made in
> mmc_power_off() due to an issue we had with some of our devices
> requiring more time for the Vdd to drain below 0.5V. Ulf gave us this
> feedback on that change:
> 
>> No, this isn't the proper place of adding more "magic" delays.
> 
>> Instead, make sure the related ->set_ios() callback in the mmc host
>> driver deals with this instead. In case it uses an external regulator,
>> via the regulator API, then this is something that should be
>> controlled with the definition of the regulator.
> 
> Should we take a different approach here? 

It probably should be dealt with in the ->set_power() callback.
Is it one of the PCI devices in sdhci-pci-core.c?
