Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFA18DB16;
	Mon,  6 Oct 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736147; cv=fail; b=LEIT2rpns4Jwu9m3YPTLsunygAl1TJYhQI1QabqVTvcG4FJHwq7eg/HyMCT1z1q1BJycGKZDjEuFgQ/WPnVqa1qoSclBMcsBm+8iyqU4S5qdXYP0ZkKCD/XyYr+S0rlTkwDGmhcoxL8pSysequlqWGIm8bseoSoHcc7hfdtAXoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736147; c=relaxed/simple;
	bh=L+r0mKdXCIEWATW7kmABt0+pbcMVb5dFSu9a4R6IB9Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b4xXssY0OYzqBKp1/v42GBC9zzJ+tkkZiLlYPOWBvyoe+M7rSTygjGa0+D2N6rl4F2KMrawQ4skDd0h7IhZ/VB5kH66xulBu3Z9yj5H/I3/lzhYcVKBec0SlCw0KeokTHLPoP+S4R7B8SA4i8sjeFO2xaZEe2zvAATbG72kXmio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Km7/c5F8; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Km7/c5F8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759736146; x=1791272146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L+r0mKdXCIEWATW7kmABt0+pbcMVb5dFSu9a4R6IB9Y=;
  b=Km7/c5F8FUrQubQVL5iG7G+IUfVxW6PGJuoUcmdhDHqXKlwBWEd6BzJk
   oeyRXb0vwwis0dh0t4lZcVxDUYHNK1W9AXON4yaGjlA3Fe4z4mxNd7cqe
   +epfJBvGRxC5Oh5f993hM7f/FfcqH3EeTNqAe5RPjYPtx8pB/fMzp4hYM
   j+MKEtdea1stDvNvxRizN88izr/NvS4cK5Fb2VQ1r2k4ZsB+xij8a/Q2Y
   FVPvbNsaP5KlgA+mhiQoeI3+hSGMyKtME6t8WdoxuCdx8y+5U11ZiUWQz
   jiliu2Cr4O9XJd8qW8V3IHJhdmJVYzqidHD7x4PloEVFeVH5TuWELWhAs
   w==;
X-CSE-ConnectionGUID: 7GoYHkMCQUalMsRyzYOElQ==
X-CSE-MsgGUID: ObbrurmYS7COwc6tKQASnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="73261370"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="73261370"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 00:35:45 -0700
X-CSE-ConnectionGUID: vxpeZO7pS1KllVPKp5dcAA==
X-CSE-MsgGUID: fQo/Zd74QJyDMRSbfJcjXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="179850539"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 00:35:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 00:35:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 00:35:44 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 00:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzzhITKPPIvryqBo3VX2aKG+L5S67Fs3ZALDd3INSYaNmFBa/PNBZTdIO5M5XP4oTn5oBflke6vF1lm4bgfxtEztC5fWvh1RFNod+Y++apGlj2jaugJm5e57MkW+ODwZr6xc2cNYNN3x+/floYhuDlykgXcH05jwhQKr+ch0tGGPJauBdlB7gsvv5ZL4brJMKb4Uzu5X2Q9LfTsRtzD7P4ZYMH25tEKCI6sF1dNTpJMzbcNJ9Ij3ot7aZqd5Co36i+YitTJhufKtOaHlTOtacZV2j892aGipB5+5d7pSJqnyBCzb/wtNm99DifhWw2ygTQ0auSu1vyK9FzyUTHf1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsZOr9scfjFTsR4o7whJLuLtFRQv7wU7H8Jy3wmhDus=;
 b=J7RWspsLq+5knrQv4OkMNqlf7IAAgLVo5cARN1ypFzXQS0WEyGwkxDPq8xqXAPw7mE6hxJ/dULjUebgqIJk2b0gIhVOlGVadNw08YmOyd6BjCEjgjMtRyF06jcaJ27AP0/dYYwPaXHJbsXEiBo13DY/BKm29N8t1evMUzCxqSxQt92qsQjpBFCcFGdSHF2+a2F00gjxHJGPPlFoy5qPg+i9C0bhUoki4/oO2YCy7UweKnK+AlDi1yNcwINSOXk/8td9vpVpsmDtCyaYG0LuZ0VK01YSCOBHoqAtwz2PE+rWWLAZEjV2DYPA1gy5UCbLy4XhnIsd2OpmiwxrvpBPExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB9456.namprd11.prod.outlook.com (2603:10b6:8:290::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 07:35:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 07:35:38 +0000
Message-ID: <a9934d68-8b8f-49b8-b4a3-053e3949c666@intel.com>
Date: Mon, 6 Oct 2025 10:35:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
To: Michael Garofalo <officialtechflashyt@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0056.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::33) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab7478e-df51-4641-5531-08de04aaf215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zkg0QXVHcnJuS3JtQlVxaUZXem83OC9yZmh0elk4aUQ3TTd6cHY5Z3NXcTdG?=
 =?utf-8?B?K3NGNzR4Vk5ibGpFWFNjRmZYTmlSc3BRb3VRLzlGTUtDczl1d2F0b3RsL1VD?=
 =?utf-8?B?N0NoR0JGN2wvYWl1Qk9Kb1FjQ0JWZFNhZjdVZXRxdEJUNjM2TTNzYWNKdnRY?=
 =?utf-8?B?UVdnRmRwb0F6Rkhzc2ZyNy9NNGlPa2h1UVFSMjI1VGgyZHhJTFB1MDNPRnJp?=
 =?utf-8?B?TTdwWjJEK245SzNtTExuQVFRKzZIVGcxRTFqcmIwTlFaSzI2amx1b0c4RHor?=
 =?utf-8?B?Y05xd2xJRWpiM3BDaU9oSUluUU9QUmlOZFMxcXA3Sy9rOTZxMXRFRzhqVXIx?=
 =?utf-8?B?V3FiSGhXdzYwblIyNEFSdWFST296TmRPVmxDM2phYzRTVHJnRGJ5YW1rRFZx?=
 =?utf-8?B?UE5PREh6ajBtZEpYSzV0T0pyRWQrMUphSjU5SFJjc3dBa0dhRkdtWXlCNC9X?=
 =?utf-8?B?eURxbzBuc2duMlRlQjRGdVhsZ1Mwd0dLQTBRL1JaWFNSV0FnTkFNTUU5Y1N5?=
 =?utf-8?B?ZTcxdUVBOEtiU2hCZmFxTHltc1BYNkIwU00xWVpmaVJpUVNMbWxha0FMUU8r?=
 =?utf-8?B?UEZmUU5KK1ZrN0FyZEpRSDF6VDhxejVkRS9rQlZqaXV6T05MSCsvK2RJSnU4?=
 =?utf-8?B?YlpUOWhaOFd6a1FPaTNWUDVEODB2U3RGRlVva3dDSDJnZ1MzSklvbDFEMTRx?=
 =?utf-8?B?blFoT2tSR2xXMnFJeVBReUxuTzFVZTJRTkdGSkN3aE45dG9oSDlQZW1YN2s3?=
 =?utf-8?B?VTlITGtrTmpjL0F6aUYvd0t4djVvT2daWXY5TEM3MGhYeE5VSTNtM0IyVE5T?=
 =?utf-8?B?alRBcDJZK3FPeDRYVCtheGVTcWwzQzlvSUhUeWlrZzlpRmQvRlcrRFY5ODc0?=
 =?utf-8?B?VW5ZQVJRM3hDREVQa0MxZGs3eGh5THdZc05jdHUraU82V0N6VkJCZ2RLSWR2?=
 =?utf-8?B?TGtzeEVyUWIyM3UycHdwM0piVnpkUU9OYlZuNXo2R29tUHRZQkEyNFNRSGJm?=
 =?utf-8?B?UDVZNmZBTjlXLzNLL3QvZDY3ZEN6WUltNTFoNUxBV1NWNE1GY01FMW5IQml2?=
 =?utf-8?B?K0pLN01tbkdiOXlhdnh2VnRpczU2UmhaemZveFFZWFVNRDFPa1NrMUxzVEU5?=
 =?utf-8?B?K0QwNy9FZ0xHUVVkOFhRdmlwejhnZHdXWk9mamVCMk16RytqUHpiNklvSWZW?=
 =?utf-8?B?VkFaM21xYkZ3Q0ZFODVOYTRFZXBOeGFjN00vbVRlMHFYSEt2aEVWUHNNMGs3?=
 =?utf-8?B?WVlGZ3piNXRKQklSUU1zcnk1Tk1XYUpDbm9FdWlObkZla1B0emJrRnJkSHZr?=
 =?utf-8?B?bVVkZWFMZTVMQjdtMFVoME5GY0t6cldiZFpEMnZ0UzNDZ0FMM0dmR2IwUGNE?=
 =?utf-8?B?ZlB0cEpXQ0tDSGlFb252dUY0aDNJeXN5eEthVUdQZ0xPbjQzNnZPLy8zSWM2?=
 =?utf-8?B?TWdIOXczbFhlaVR6b2VFSEJaUmo3ZkF3V3l2N2VFNWRUdXZTNzM1TnY3VDlw?=
 =?utf-8?B?Qk5Gb0xqbk1qVGhYR3g4M080cVdiRTFIdjF0Tk5STDc1dUdxUi85dFNEaTdt?=
 =?utf-8?B?RzkzdDhVVzU1cDN1RzNWUXRRTVpMNVJhWHBvVjE5NUN4Wkg5TVdBeWp1WDQ3?=
 =?utf-8?B?T1hjRjl3ZWMvL0Z0MTZJWUQ4eWxQeTZEUGZ1VG5UeCtyODF3NEJtQ2RpT2Ey?=
 =?utf-8?B?NWNuNzBQNWtuZitzZmxLakZOTmtuYlNUVHMwdm5jU01xTVVsZEhpekpNT1hi?=
 =?utf-8?B?RWh5dFFkNDVGc25sTGRETWNUWC9TMzVQMXdFSm1HanlDRFNaeWhtTXdTRktU?=
 =?utf-8?B?S2Q4SEV1a2trTHVRdVgzU1dPQjNMcWNEcWNJZEhGS3RvZjlBdTIwY2J6dlZt?=
 =?utf-8?B?REYrTlBLUVJlL1FLZkQwWHU5N2Jad1hzeUp3bDJpOGEwTWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJpQi9xbVNaNHRRak1kMGZtdnNtMFNrRkxyUC9UWWE3MzF4dDFucXpPWDd0?=
 =?utf-8?B?eHEwTVpnL2F0TFZLbXQ3WGwyK3RvQ0JHano2SEpoZUIvK05XUXdrdkZMVDV3?=
 =?utf-8?B?ZHZaZk5hSWJTMnhxZER3djc0SXE4OVRySmNSeS85QVlwRzlwd1IrRHdhY2Nm?=
 =?utf-8?B?Z25XT1MvbHJ4YWlEK0k2eTB3alhZWjZEWW9GaVBvUzRRaGwrSVlQbzJiSXJW?=
 =?utf-8?B?YzJNVzlCK051SGdLVlBkMHl3TG1xYzlpbk1pN2o3YkF4TnJQZGtnZE9uKzhJ?=
 =?utf-8?B?aEJDRUpzVHZkTkZSbFpxUmYwRnU5TnZwSmF4dlA3QlVwWVgwSGNNS2xMbG8y?=
 =?utf-8?B?SG01bkhsQUtVNWUrMXExMm9CcTlOY05yUWN3MGJ1cTc3ejlnWmNsWGdFQjc5?=
 =?utf-8?B?WmtndG5RZFR2ZWxuSHRoMEhoR2NvT0tjeldKbVpsYzVUSE5Ia3MwMVNQTEZJ?=
 =?utf-8?B?V2tvNER2d3Z1NnErY2lPRDE5T1YxK0l1d2JLUEp2cVM1QXVkaTlxTHRVS29M?=
 =?utf-8?B?d2ZuUDZGSDJ1UkZCcTEwV1lYWnRsNUJqY3BZeEdPajdLRWg1OE5LWkJkSDJM?=
 =?utf-8?B?K3N6VVEwNGVNbERiaGI4bXp3OEgvYmkvRTZFVGtxenRPc1N2aHlKT1JBSXBa?=
 =?utf-8?B?c1pwYURvTnRhMVNVL2ozUG1HQ3NESEdQMVE2aFZxcVpvZEI2ZFJiY09UMVNn?=
 =?utf-8?B?WGxZVkNHbE9DeXFzcTNjejlNNm1MR3lyVnJUREg2d3Q5NWs1WVlsd0xyZ0lh?=
 =?utf-8?B?VndwTDBIWktxZUdiMzVQaUlJVXVEeWRQdnNIa25Ed01SenJZaXBYb0p1MHZR?=
 =?utf-8?B?T0NOUDFpdU5vWVlXZmd0aUw2MXNwNGVUOG5ENlVKS3IzaWt5cG16cTZIaGpo?=
 =?utf-8?B?T01haFpaQi83K1dGNEk2UDlNV3VSNHQraU9zTERtc2FzSUlUT0JKT2xKTFQ2?=
 =?utf-8?B?K29XWHlZRHdZM3E2a0lWMGkwTFBFWDhZMkdydHV4Sk9Qb25nNDlsNmt6UHpD?=
 =?utf-8?B?bHBtcWR3azBBZ0NjTkw0clpxd041VjRzQzRnWUxIaFg5RXVLam5vcEpSKy9y?=
 =?utf-8?B?NW5YM2ZqYmNMZHEvMytUcUJhTUFLanB6N0g0ZUZLd21pYXdVK3lPdmtCYkho?=
 =?utf-8?B?U2pmSndjbTRvZ3ZFRXpTbTNJRkt6eVZYSmduL1Rpei9wVTNoeGcwSTZ2ak1k?=
 =?utf-8?B?U1FiYW15Q0hNYm5pclpyeFpNd2lySHdvR3NsYk9wZWFObjQwVWtuSjdyN24y?=
 =?utf-8?B?SlNQMlY0dHgyZS9CZDVGS3EyVTN5MUE1MkYyWkd3TnZvcHZlMXE1b3NBblhl?=
 =?utf-8?B?Z0NUL2tvamRvM3U4S1JSMDVuUElIbForQldnNUdRenZGK2cyMTNrelZGYWZQ?=
 =?utf-8?B?MkZ1K0V0SE40WE1jZHJ5Z0N6M0hjN0x4V0szUUdybXlkQjMwR0JweVZWQThG?=
 =?utf-8?B?cEpld1JLM3Zub1gwSTZFdWE0bkdzMllSenlSajYwMlR1RlNPUnN0OGZnaUpi?=
 =?utf-8?B?MzBCY212N01RNTJ6MWdzQUNhVUhSdUM4N3NsejRXaGRkVjhJNVNaRXlDcDk0?=
 =?utf-8?B?eUY4ZTgwUVBRTXlDcG5qeWVvdGdWUTlpL1dQTU1UMkU2MkMvZHhTV2dDRm1T?=
 =?utf-8?B?U1JZZUNsR3p2bUs1MFQ2bVZraDRrdWpiNjJXU3U4bis3RURsZEYzY00ydlY2?=
 =?utf-8?B?dmRNUEdVSm1xaDlmSXZEMHFqUlZxVW05OTZTUCsvRXZzU1ZlT3AyRTk2czZL?=
 =?utf-8?B?R2QxUVRyeTBNKzNYaGNhcXc3NmlFOG9aOWluSDFrR1V2d2hadEEvSHFMUSt0?=
 =?utf-8?B?TmRZSVFFeHJoclJzRk52bEttcW5kV3Y5a0NoSEkvdVQzZGxCNjNhSFJQZkZn?=
 =?utf-8?B?d3I3dkFEaGVJbmFPQ3cwTHA1ZTdoU2tRdzdmcWNBSVlnYTk3bUI1SndST1Ro?=
 =?utf-8?B?dTFtY29Md2t5UlVRYUVFYmIxWGlhVUpTMlBvRk54WGphNVZOVGhpVWZGYU12?=
 =?utf-8?B?b3NZMFlvdzl6aVZyWng2Qm1jaGJHRE51TmM2TXNxZ1V3VS8xNjRQVzd0M1d0?=
 =?utf-8?B?a2RRWGowWXZUWlNJZlJrNHo2eWt2dTBoNEZJTDZSdFlmSGxEVU9rQ3BTYlNo?=
 =?utf-8?B?QS9pKzdHMGQyS1VPcDRkME5uMVRsWXBDT202Z3lDdStWaHVsa0lYYVZsakdz?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab7478e-df51-4641-5531-08de04aaf215
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 07:35:38.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odfKJ0EbWsD/P0EVh5dCBEARZtmAulnUP8pAnFdI+rcrsaci1DUdhMPaFNKO6prq8GUlu1t5h4jfjO3pAK+vRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9456
X-OriginatorOrg: intel.com

On 06/10/2025 04:36, Michael Garofalo wrote:
> This patch series adds a new bit to quirks2 for disabling the bounce
> buffer.  On some hardware, this is required for proper operation.  An
> example of such hardware is the SDHCI controller of the Nintendo Wii's
> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
> Wi-Fi fails to connect to any networks.

The bounce buffer should not make any difference, so it is likely
a different problem that gets hidden when the bounce buffer is not
used.

Could you enable dynamic debug messages and show the messages
for the failing case?

Dynamic debug for mmc
---------------------

    Kernel must be configured:

        CONFIG_DYNAMIC_DEBUG=y

    To enable mmc debug via sysfs:

        echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control

    To enable mmc debug via kernel command line:

        dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"

    To disable mmc debug:

        echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control

    More general information in kernel documentation in kernel tree:

        Documentation/admin-guide/dynamic-debug-howto.rst
	https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html


> 
> Patch 1 introduces the new quirk bit.
> Patch 2 applies it to sdhci-of-hlwd.
> 
> Michael Garofalo (2):
>   mmc: sdhci: add quirk to disable the bounce buffer
>   mmc: sdhci-of-hlwd: disable bounce buffer usage
> 
>  drivers/mmc/host/sdhci-of-hlwd.c | 1 +
>  drivers/mmc/host/sdhci.c         | 8 +++++---
>  drivers/mmc/host/sdhci.h         | 4 ++++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 

