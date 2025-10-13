Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336801DE4CD;
	Mon, 13 Oct 2025 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337657; cv=fail; b=eZ4I5D+r9Jtpi9aAbLC0u67kn5XTlB4K6rn4OUtCt+VLy+gIZ/q9D2uXBIIzjEkpBxnasWgIIkonfVmUQcUXkd2LWHZLTLNCE14P1nBw4y0JB4j785qBNAFVniFdprcGKBQoHbJxnPG68WWFQU51qJF2QjgyT/xgJRozrg/cZI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337657; c=relaxed/simple;
	bh=34pZ1iR7dhpSC5PX8Wb7/0yjY5CTUsiAp/l9NaGS61M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AuYtZ9q62wEFw3ZHSZbNqRrbsJAyBhLPhTK4fJV1cHdJjrs6UfELvdL+htyIqEIEx6PF3e50u9LYSvSBwwmGavXzEKWZp7m/WFey+/ehtUA2p4EYUx9jBv7Prm+qIXjSZ6GtemWk2Xjfmk1H6i3v31/r3Q2egTrVSg4UgbLRBoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsnAQpmT; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsnAQpmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760337655; x=1791873655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34pZ1iR7dhpSC5PX8Wb7/0yjY5CTUsiAp/l9NaGS61M=;
  b=QsnAQpmTehXsVTVpntwsNlUxSFTcrstz1SLSyYxgsEKHKs752YfyLeAT
   hcG5FWkuMyyucIQNQxTH5kAfOjF/QMiErJ4c1k7EogxLbnvomJiE6Su0M
   mm2l5DUaLt7CgL/Kyp8EX5cPXyYM5Nn20jTkl/+920MWaKFAj+QuVoVNb
   VpBYaDjO9rEsrlGGMgsa9RhLvd7StXhlB8rOMMg7RZKYQdnLiqZdtvbLP
   hf4bdjLDu4gNQcimrJn8j9fsiQuS2wKeHSoM5HsHHZPR168tVfX0bBRqa
   vkmRpb4Zap1aVGrHD4XZUOvqc6Pki35iZxijAQMEqXi4CyhG7bIVDGdem
   w==;
X-CSE-ConnectionGUID: 5Gh9iZZVRGCcLnk+e8Mvcg==
X-CSE-MsgGUID: I8uyHnmQQcid6zFISItOQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="65090302"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="65090302"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 23:40:54 -0700
X-CSE-ConnectionGUID: FPJGdIfoR+aSaNFNRoXJKQ==
X-CSE-MsgGUID: 3XqvKxHJSTKPBIT6ww2pQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="218629480"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 23:40:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:40:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 23:40:53 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB/dcDAhLxnuXij8zkyIhRmcTKxOm5Dfz5tsBUKEGJ3+QF2nudQ+Ob3/1Wu0QPqdoajls8HxhBHm8CCCsXRp0JOe8jtdimtJPMpxvsHBTPxTosClFYmRpuFAmEZLRwS3QdCQ9WNMGtrefyXtkP6nlSN10AS5fvGk+iND28yWy8tV5/FavYB75XWMAahJmkOFFZAb+KdpKVhoBkMPisxl7k7KYyK+b1fdRDMkqAx2C3+mfFrBhcIrb2tiCXNeVgrSuBotjuJIwR72gM4cQvzUz9IxVuKu6izo66G7ivu3dKEc8Zt+rp3Nl9RkUVLcAWagEralN0BYbhy4M+HCPs/LHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC16vjyl0XY7Q3QkjjNYhv/4b7xlEtBSQCwOQhINP8o=;
 b=B536ros6c3cJaUr7IIJ9RfCwJdT0NBaSTm21tiX7rppV5WMZMOxP6etRplScoZhCfVtQjUCIdE9xTGGSJh/G1JIQujEwWUMMcf0h+lp4A+8hKgwwhe76QaDORdUnQBIzwnPEgfUM5QQl8trzNQ56KZnMUpsrHUcp3Nz2YnF+gtAfDq9+278eOJrXwrb9y+5EI41eNghlSnbu8FtC71qXVhe4AgfXho9omanoGKac6XgogVAnioujYMfTiNGGeq2vBM5fMhWUrMIswEUAR+7/z4UoWlBlh8qvd4KpYAiEFwxiALgtTb0DW3ITudRb3d6WnbXTKFl7hFby0LgxecFAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:40:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:40:46 +0000
Message-ID: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
Date: Mon, 13 Oct 2025 09:40:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
To: Michael Garofalo <officialtechflashyt@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>
References: <c895cd11-4d8d-475c-8ef8-3007f9037aef@intel.com>
 <20251010211651.85281-1-officialTechflashYT@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251010211651.85281-1-officialTechflashYT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 38400ced-f4f9-4093-6fe7-08de0a237066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFd4RTlHRWQ3UnoyWFRHUU1lWmhsMVM2TWdRY01YbXRJbXVIS05NOTcrNW0x?=
 =?utf-8?B?eHhUa0diN2J1MENiY09RQXlIeXhVTFpLN3hHdmlxY1k4NTBuK3pLMk1tZ1hi?=
 =?utf-8?B?TXBITllKUWVyVEtrU0NHdFdHRUVvY3BZSHdwTFNYV3o5OHh2bnZlZUJnMVYx?=
 =?utf-8?B?KzhMSnZXRTRMYWwwWjdmdnpEZng1cW5CbDMrakEzRGtGSHllTkJoZlpJUHRB?=
 =?utf-8?B?K3NCOE9KZHdVMmplTWNrUGh4OVZtRHdlY3RQQU1NUEhoMm5UZlRYRFF4cmJW?=
 =?utf-8?B?NVVJMGJPRzVSa09qMWlIVUpSdEhsZkFxK242RDBMSXBRcFNzMUpYNVZ0eTdh?=
 =?utf-8?B?dno0ckpNblBrZXdud09TcWliVXlneWVLMUgrSlhETjcxbTdoQ2tiWlgzMjVq?=
 =?utf-8?B?WGxSQWRwaWZ3UmdLZUZpUGJqUUMyMjZRWXZkNHB3WjJFaXRpNE8zby9jd0RF?=
 =?utf-8?B?TXRpNmFsYnJOczNxZ2RnM1dsUHFSbWVLbnNDbE9CYlBackVhMFd4YW5ONHBo?=
 =?utf-8?B?aWtuUnhVTitVdS9EOXBFRTZQZ0svV0hoOGVwL0VWSVZ6OXZacTFNc1h3Wklh?=
 =?utf-8?B?U3pEYWNoYlUvL0FUNmhkalVtMkYzNHI2UXBhRDdDbDA4UUl5c2tVbzh6MUl0?=
 =?utf-8?B?UzFTaGYxUEV0WUYxZEUrT2c5Mkd1bFM0b2ZRTVdSMCsvNnlxOWxDNkhuaVdC?=
 =?utf-8?B?NGpqeW5xVndTRWRmdGZTM1hpMDNyUGlVTTdMcDgvcTFYVFo4dmZyY3VSanIv?=
 =?utf-8?B?VmpiS25LaDV3ci9kUkFGcjNUZlBWTW54SVEraWJsTkpyR29ZdlovZDYvQzRp?=
 =?utf-8?B?U2tqbHdSNUZTblV1dEcvcmdvZkRaRVhienZBM1lwMVVIQWVKK1B2V1d6dTBQ?=
 =?utf-8?B?MlRwdzZOeCtmMy9sRWlEVDNCclFVVTZqU2V6RVIzVkYxaDNzditTZVpnWWIr?=
 =?utf-8?B?MDVSUzE5RGtXd0ZjWHV0OFR4c05ZUVA3WkhaWHdtTnVEcDlrOVNlTThQOVFB?=
 =?utf-8?B?eE5haG8zVXByRFpOY25WNmNRVm9WbGM0NTZoWmtNd3NtNWdwUTN3NFFobDZQ?=
 =?utf-8?B?b0thbS9LTFpMZWVCeTNkM2pUa2d1TlV0UTcrd2dZcmlyNlBvSG05VDBPSkt3?=
 =?utf-8?B?d3lOUWNWZ05TaUNleXhuWFpPaW9uQktQWGVGbzZOY3FqTnN0Mk0wRnN4TU1o?=
 =?utf-8?B?T09MU1pCbnAzVDA3YTdKa2NIdk5WVkZPSGd4cmErUnRZVjFrRkh4YzNzeDY0?=
 =?utf-8?B?Y1N3TjN0bVZFbGJiYW14RjlvQ1ZqVmNmNzE2Q0FCaEZQTTBIaWVkRFVJWEJE?=
 =?utf-8?B?aVplVjB6dERoSEgzMko0WGpKeUhBK2J4MzdQUlZ5SFl4QnFLMUFOd3hHL2lv?=
 =?utf-8?B?QXJ3blc2WDR2ZnNMdVdtVXNZNGYxYUtNOVV1czIzQW1LTTJ4R1Z5Uy9keU0x?=
 =?utf-8?B?V2xXdUh2UC9TZkRBM2JMazhpVTVVa2dMcy91ZWlHMURKeEFxY2I5ckU0T1Br?=
 =?utf-8?B?MlhTbGlEeFEyUE96TXNDYjVXNlRYeDRvSlNkVnFMd2pWNXF1VDVMK3l5emlh?=
 =?utf-8?B?ams2NGRReE85L1NEL0UrK0JKZFEyNXg3MzRGVHNmZ2hKUElaeW5QZk5TVTZO?=
 =?utf-8?B?bC9wbjFvV0tQSDFyMGxWY0VaemhMQjkxeTVrSGpxTXJJR0xwaW5nTVdUNGE5?=
 =?utf-8?B?bCsrMzRFampKV0cwZkl2Q2dFNjZsbVh2cFc1d0EweEU3WExCN25OS1R5M2Uw?=
 =?utf-8?B?djFNZmFCRGlGa1E3a0NVT3lKMk4wT3Q0dXJIdEZIZW01UXlEUjhxS3lFZklP?=
 =?utf-8?B?ajRMNFk5Y3UzSkJjUFZaVmgyTlFHdEZDL1ZSeGo5bjNOaDJFTEpabkcra1lD?=
 =?utf-8?B?bktvSExBYTVjRStJUjgrYXNUNUVlWThZbHcvZE1CRTEyUklqd1RYazJhTEMr?=
 =?utf-8?Q?zDmSpQpi/KTUEv12UxGhYsXbtBYLDGqH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWorQjhyTThiQ3N4eXo5QjJxcnF0MkZaRTVmd0YwTDBUWlc2ejQrVGVUSUFk?=
 =?utf-8?B?czIxek9kdFhsQzR4RGN3RWJLaHJyNzdLbFV3Qk5SVG9zOStCbCtrdkE3L3VB?=
 =?utf-8?B?RGh0M2FiSC92UTJ0d3o0dzRjeWRXOGI1QzArcklmY01pNFRQT1pNRllYc2hZ?=
 =?utf-8?B?L0Q0YWR5UTdPcG9tVkJMUXRrcUd4bmlDeUxHTzNESSt1ZjR2ZHhxeURBdVVy?=
 =?utf-8?B?MEZJVUtJbGE5ZmZiWlkwWDBYZmpFRTRJYk9keWRxMm43MzVkWFVSUFFkckor?=
 =?utf-8?B?OVVNZVVqZUVpUE1XMWgySzBsNFhzaVY3VG5qV2RqT2tqQkFZeWw2SU42WEVN?=
 =?utf-8?B?a1hoVDNVVkJyMDVKSFRQL3h6QkFHV3F0OUZEVFJUaStmOWVFbGdPdjVRaWZM?=
 =?utf-8?B?bzBOeUZtYUFGOFBxVGcreFFBVTVBOWdxZDZsNldXM3ZmQ05YRXFRd0Zod0M3?=
 =?utf-8?B?OFo5SGdscmRtaSt0WENUV0ZjT0xKNmdabkd5U2gzYUJienNtd2hzMnNpSFVj?=
 =?utf-8?B?dXVoZjFoSW53SjQvWDZVNnpFbSs2bC9Cb1luWWl2UWtvOWxCbWVkWTExbUN5?=
 =?utf-8?B?QVdCRlRpRlZ4aGtaUzVMbit4VkZ6YnE1V1cza25HQndOT09zL3JkY2MyQ0tV?=
 =?utf-8?B?TnVxaDE1MmxpQ2EvK0hVaklPQTRKNDB0cVBKVVZVVytDaHFuL3AxYUF6bTZw?=
 =?utf-8?B?TmpmakV0VDk2dGdINUsxdEdwZk51RDNBUVdZTGNGbFJBVXgzQmFKSERxWktx?=
 =?utf-8?B?alVaTW5GMHBibTBLNHV5QnUxRHdSZEZCUXJ4bWl1cmxDQjFTamRoalBqNkIv?=
 =?utf-8?B?a2ZGdVRTMXRRTGZhSVlhVWtUVUVVN3IwbHlxeWxkc2tjUDZuU0xEOUtlVXh0?=
 =?utf-8?B?UDZ5SG84a20vUHJPVUhSTGJENitGbGIzWFdYd1drZHRJalBOOFYxTUE1YTZY?=
 =?utf-8?B?ZWlDa0Zna2hGVFYvVzB4MC9aUWhsTWlaaEpzU2ZLMGxlSDJKeEZLQ2d3ZDhW?=
 =?utf-8?B?NDBMeWJTcjhvRDU3Ykp4YXdwRWtKc2xNdWRRZjJqK1NFenVMZmxtaWZuT3BY?=
 =?utf-8?B?bVpwc0M0WHZjbXU1bHM1NHVWb3lnTnJKSkJrbUFEbWozR2tDU1NrNFVDUndM?=
 =?utf-8?B?clIzcmZ0cGVRb2c1SG8yOThwM0k3MUdLK1dzcVA1VXpQSzBXeDIyRytaRFlH?=
 =?utf-8?B?UHdHTXg1NG5WbUNaVXVyR0xoTjN6MnlOVUFlbzd5eWZKNTVZOC9TY0poY1c3?=
 =?utf-8?B?ZW1FOE5BMW9HdWxMSU1TaEtiK1JOTEFPRmhmYTJSNENjNndxY3k3ZkpNUUhv?=
 =?utf-8?B?bUkwdHNQbWwrckduRVNSdFpwYnlWZ3FxOVBaNko3OWl3R0VWNkhwTXBSMG9K?=
 =?utf-8?B?b05rT0h3WHdxc1UrL3ZNeEZnVzFmWWY2eVd4VTYwU0VrRmJNakFLdm9hNzJT?=
 =?utf-8?B?VXRHNUQ4YmJzcDdjalJuZzkyT0ovZXgxTHI0R3FsUFBCM09CYUcxYjF1aVRl?=
 =?utf-8?B?QkxtZVVURE5vRUFteHgvdXlEYTRhNUJOQzM2cGNVRTFoaWZFZmFRM0JIbWh4?=
 =?utf-8?B?ZHh5WHFZNHZaZEJxUktuSytsQ28weU5VQUlBbW5GWDBaTDk4OEpCa1M3TmJt?=
 =?utf-8?B?Vit6Q2pnTDk4dFBmdGk4WGZVQStkbVZWOHFSZTk2Mm5Ea2dhUXdVTE9Hc1Iv?=
 =?utf-8?B?UWh0cHJ0NlV1d1AreWxLL0xlSkZ3dDdVMkhjS3JvK2dST2wwNkgyak5FcXlY?=
 =?utf-8?B?RUpwR0EyTnY4M0JlclRocnVqUGNzZmlTTnliSk1iVWN5a0x5TmgrQnFTVTVJ?=
 =?utf-8?B?L1RDc3FQTmtOSnZ5MnVubmJxVGFHd3hjazBvaGJRQVZHcSt3NTdlOFhFUlJi?=
 =?utf-8?B?cVJiS2lVK1QrcXNlNGpXY0pVdkhZNE9uRW1WK1B6Ynd2N0hHQXQzb0FIMDdS?=
 =?utf-8?B?VEM1c1dSa21sN0ZJcDZybzBvSWY2MFlRL1lPOVdFYWR2RzlPaE81V0R6TWVo?=
 =?utf-8?B?RDBiRjdobEJRTjZHS3plZEF2UEZRL25VRysrZ0JtN3ZNNDFGQ2V4VHlpNWNE?=
 =?utf-8?B?MTJIUlJ0ME16d0dUaHlLd20yZTNmSEdVVm5BVkxkTGNXRmxmWUlWNUdCd0VE?=
 =?utf-8?B?YzhidUloV2dhY3J6L09NbUtuMFllcTJUVVBNNlVTMHMrM0Y3QyszYW90cVFr?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38400ced-f4f9-4093-6fe7-08de0a237066
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:40:46.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITUNU3LyelKzw3hga6uYsU5Bs4c0OBaKfgkUt/Ay+JO3bQWgjIcHrDygL12kr9oF6r4vD+uvsYycp7HJ7WVURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com

On 11/10/2025 00:16, Michael Garofalo wrote:
>> On 08/10/2025 04:10, Michael Garofalo wrote:
>>>> On 06/10/2025 12:28, Michael Garofalo wrote:
>>>>>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>>>>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>>>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>>>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>>>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>>>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>>>>>> Wi-Fi fails to connect to any networks.
>>>>>>>
>>>>>>> The bounce buffer should not make any difference, so it is likely
>>>>>>> a different problem that gets hidden when the bounce buffer is not
>>>>>>> used.
>>>>>>>
>>>>>>>> Could you enable dynamic debug messages and show the messages
>>>>>>>> for the failing case?
>>>>>>>
>>>>>>> Actually will also need to see the messages in the "fixed" case
>>>>>>> to compare.
>>>>> I'm afraid I won't be able to provide those easily, at least not with the
>>>>> commands you've provided.  Since the rootfs is _also_ running from SD,
>>>>> turning on full MMC logs like this produces an obscene amount of noise
>>>>> from the storage, unrelated to the SDIO wireless.  It gets even worse with
>>>>> my original intention, which was to save the logs to SD Card, (since my USB
>>>>> Gecko serial console is rather flakey, and introduces corruption now and then),
>>>>> since it's now logging the writes of it's own logs in a permanent loop.
>>>>> If there's a way to narrow down the logs to specifically whatever portions
>>>>> you're interested in, and filter out the noise, I would happily provide it.
>>>>
>>>> Are there any error messages?
>>> If I drop the debug logs you mentioned so that I can actually see what's
>>> going on (they produce hundreds of lines / sec), here's what the Wi-Fi card
>>> actually reports with, vs without, MMC bounce buffers.  With bounce buffers on,
>>> it takes several tries to load the firmware, and it can't authenticate to any
>>> network.  I've tested and confirmed this effect on multiple consoles, across
>>> multiple reboots, on multiple Wi-Fi networks.  Meanwhile with MMC bounce buffers
>>> off, it's much more functional.
>>>
>>> Logs with MMC bounce buffers *on* (without my patches):
>>> [  168.492687] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>> [  168.493516] ssb: Found chip with id 0x4710, rev 0x00 an package 0x00
>>> [  168.508519] ssb: WARNING: Multiple ChipCommon found
>>> [  168.510597] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>> [  168.510886] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>> [  168.530151] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>> [  168.538447] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>> [  168.719257] Broadcom 43xx driver loaded [ Features: S ]
>>> [  168.722231] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>> [  168.724613] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>> [  168.740666] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>> [  168.762630] ieee80211 phy0: Slected rate control algorithm 'minstrel_ht'
>>> [  176.156693] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  176.157159] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  179.993008] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  179.994373] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  186.940346] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  186.942559] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  216.368668] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  216.369135] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  221.750016] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  221.757700] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  223.437731] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>> [  223.437764] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>> [  223.648472] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>> [  223.859770] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>> [  224.064469] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>> [  226.045361] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>> [  226.045393] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>> [  226.248488] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>> [  226.462378] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>> [  226.664487] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>> [  250.424168] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  250.425629] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  255.806790] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  255.807256] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  257.467380] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>> [  257.467414] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>> [  257.672475] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>> [  257.880474] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>> [  258.093974] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>> [  284.326415] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  284.326922] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  289.836233] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  289.837612] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  291.528250] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>> [  291.528283] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>> [  291.736473] wlan0: send auth to da:b3:70:18:7c:14 (try 2/3)
>>> [  291.944482] wlan0: send auth to da:b3:70:18:7c:14 (try 3/3)
>>> [  292.152470] wlan0: authentication with da:b3:70:18:7c:14 timed out
>>> <keeps trying and failing forever....>
>>>
>>> Logs with MMC bounce buffers *off* (with my patches):
>>> [  383.974268] b43-sdio mmc1:0001:1: Chip ID 14e4:4318
>>> [  383.975824] ssb: Found chip with id 0x4710, rev 0x00 and package 0x00
>>> [  383.986645] ssb: WARNING: Multiple ChipCommon found
>>> [  383.987414] b43-sdio mmc1:0001:1: Sonics Silicon Backplane found on SDIO device mmc1:0001:1
>>> [  383.987744] b43-phy0: Broadcom 4710 WLAN found (core revision 9)
>>> [  383.995898] b43-phy0: Found PHY: Analog 3, Type 2 (G), Revision 7
>>> [  383.996249] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2050, Revision 8, Version 0
>>> [  384.077562] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>> [  384.077687] b43 ssb0:0: Direct firmware load for b43/ucode5.fw failed with error -2
>>> [  384.086571] Broadcom 43xx driver loaded [ Features: S ]
>>> [  384.144620] b43 ssb0:0: Direct firmware load for b43-open/pcm5.fw failed with error -2
>>> [  384.190831] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>>> [  395.097838] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  395.098158] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  397.667851] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  397.668171] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  403.940787] b43-phy0: Loading OpenSource firmware version 410.31754
>>> [  403.941110] b43-phy0: Hardware crypto acceleration not supported by firmware
>>> [  405.366065] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>> [  405.366095] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>> [  405.389013] wlan0: authenticated
>>> [  405.392814] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>> [  405.600498] wlan0: associate with da:b3:70:18:7c:14 (try 2/3)
>>> [  405.808479] wlan0: associate with da:b3:70:18:7c:14 (try 3/3)
>>> [  406.016481] wlan0: association with da:b3:70:18:7c:14 timed out
>>> [  414.301216] wlan0: authenticate with da:b3:70:18:7c:14 (local address=00:1c:be:ab:73:27)
>>> [  414.301245] wlan0: send auth to da:b3:70:18:7c:14 (try 1/3)
>>> [  414.351544] wlan0: authenticated
>>> [  414.403769] wlan0: associate with da:b3:70:18:7c:14 (try 1/3)
>>> [  414.422775] wlan0: RX AssocResp from da:b3:70:18:7c:14 (capab=0x1411 status=0 aid=25)
>>> [  414.431879] wlan0: associated
>>> [  415.272393] wlan0: Limiting TX power to 36 (36 - 0) dBm as advertised by da:b3:70:18:7c:14
>>>
>>> If there's anything further that would be useful here, let me know and I'd be happy to provide them.
>>
>> Seems the SDIO function driver b43-sdio does not print any error
>> messages.  All the error paths in drivers/ssb/sdio.c print debug
>> messages instead.
>>
>> I would suggest the following, which would limit messages to
>> host mmc1 which is what is shown in message "b43-sdio mmc1:0001:1:
>> Chip ID 14e4:4318"
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 860378bea557..2719b21783ad 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -169,33 +169,33 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>>  	 * - The card was removed (...so just complete everything no matter
>>  	 *   if there are errors or retries)
>>  	 */
>> -	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
>> +	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
>>  		mmc_should_fail_request(host, mrq);
>>  
>>  		if (!host->ongoing_mrq)
>>  			led_trigger_event(host->led, LED_OFF);
>>  
>>  		if (mrq->sbc) {
>> -			pr_debug("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>> +			pr_info("%s: req done <CMD%u>: %d: %08x %08x %08x %08x\n",
>>  				mmc_hostname(host), mrq->sbc->opcode,
>>  				mrq->sbc->error,
>>  				mrq->sbc->resp[0], mrq->sbc->resp[1],
>>  				mrq->sbc->resp[2], mrq->sbc->resp[3]);
>>  		}
>>  
>> -		pr_debug("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>> +		pr_info("%s: req done (CMD%u): %d: %08x %08x %08x %08x\n",
>>  			mmc_hostname(host), cmd->opcode, err,
>>  			cmd->resp[0], cmd->resp[1],
>>  			cmd->resp[2], cmd->resp[3]);
>>  
>>  		if (mrq->data) {
>> -			pr_debug("%s:     %d bytes transferred: %d\n",
>> +			pr_info("%s:     %d bytes transferred: %d\n",
>>  				mmc_hostname(host),
>>  				mrq->data->bytes_xfered, mrq->data->error);
>>  		}
>>  
>>  		if (mrq->stop) {
>> -			pr_debug("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>> +			pr_info("%s:     (CMD%u): %d: %08x %08x %08x %08x\n",
>>  				mmc_hostname(host), mrq->stop->opcode,
>>  				mrq->stop->error,
>>  				mrq->stop->resp[0], mrq->stop->resp[1],
> 
> With these patches, I still get copious amounts of spam, but at least relevant
> to the wifi card now.
> Here's a hopefully useful snippet (it's just a lot of these, from what I could see),
> from with my patches:
> 
> [  154.177276] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [  154.177297] mmc1:     4 bytes transferred: 0
> <...>
> [  186.707195] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [  186.707217] mmc1:     20 bytes transferred: 0
> [  186.707358] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [  186.707382] mmc1:     384 bytes transferred: 0
> [  186.707477] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [  186.707498] mmc1:     24 bytes transferred: 0
> 
> And the one from without is very similar, except I noticed this pattern:
> [   85.942269] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   85.942299] mmc1:     4 bytes transferred: 0
> [   85.942523] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   85.942555] mmc1:     4 bytes transferred: 0
> [   85.944548] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   85.944581] mmc1:     2 bytes transferred: 0
> [   85.944777] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   85.945160] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
> [   85.945187] mmc1:     2 bytes transferred: 0
> ... occasionally, some of the requests don't have an "[x] bytes transferred: 0".
> 
> Hopefully these help.  I can get a capture of the entire log spam and
> put it on on pastebin or something, if that would be more useful.

Need to know if there are any errors.  In "[x] bytes transferred: 0"
messages, the "0" is the error code i.e. no error.  So you might be able
to find errors like:

	dmesg | grep 'bytes transferred' | grep -v 'bytes transferred: 0'

Also the debug patch could be tweaked to show errors only:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2719b21783ad..7b18fe6d5738 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -169,7 +169,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	 * - The card was removed (...so just complete everything no matter
 	 *   if there are errors or retries)
 	 */
-	if (host->index == 1 && (!err || !cmd->retries || mmc_card_removed(host->card))) {
+	if (host->index == 1 && (err || (mrq->data && mrq->data->error))) {
 		mmc_should_fail_request(host, mrq);
 
 		if (!host->ongoing_mrq)

