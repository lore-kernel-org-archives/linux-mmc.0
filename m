Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001344C8F;
	Sat, 15 Feb 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581745; cv=fail; b=larv1UMpyN2LizdFONyGhasbPoNffSLB1IVI/0mMgz7pPQs0WfiUPhonHB26wm4PxVw0WSoLgD+C31ewstIlW7/tVQ/iWbtWcpzG0a84ZsDVlC7gr8BDSF40Kwq/+24M5GRszyhcIOBbn8TJ497zccedhmqBI5GUDtFqlYMclV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581745; c=relaxed/simple;
	bh=nRqCIP+HgHTib1+gWHbS0EaSGrOcic0x7ReGBAxPY7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h91TawdTzeS8ZcwGBzVyYF63JT8S2Tw4+VMdiL7bMv1yQBCzHM9XSolKYLQ9/LcGXd6O6du8UzjoXlNioaVtW17oC6px8LpZiNOvT5josmkIl1aFhkiYyjgw54l6HiqVw9NyEFP8/Z6TrVmcaADj06L3qntsjiK33kwgm29MmQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwagiczr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwagiczr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739581744; x=1771117744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nRqCIP+HgHTib1+gWHbS0EaSGrOcic0x7ReGBAxPY7c=;
  b=JwagiczrA7pwjfkhG8caDB8+t0N1NJ5lYjU8jiAntiyGMJjpIe2x/oDk
   N/xXddzNG1PQ84CNrR+EiYFkONaYwR5vUyebFjqVA3QWHzvsDeAcwZU2e
   RQrrx8413WltS6hmSkItbdaM3c3N2gEThyvk0f7NpuSsk0iFHFaK5frGK
   R1QVcHqZAqwwoGAraQxLuf13x7EQBLNqF3vNAtpKRFIKlvXUweU6tqibj
   Ya0jK0l/+tiBx0QQlFUAged/SRHzCVP1hYYRgAgqAalWIYgQ4JrLQa1JA
   DXuc0RVkFla9iWUoCIerFe8XGTm+ZpEgnV/da0KXKvUSxlwUR5NOnwpeM
   w==;
X-CSE-ConnectionGUID: hVRisxF0SB+dlF9sqXLx3w==
X-CSE-MsgGUID: AOOvbAmgRVCUEpW/BPgOug==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="44273850"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="44273850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 17:09:04 -0800
X-CSE-ConnectionGUID: ECq9pSmDSMWnQK0yqXfXxg==
X-CSE-MsgGUID: b6m4KbbHQuKtPjah676GEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118227034"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 17:09:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Feb 2025 17:09:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 17:09:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 17:09:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGY/kbMQzlutFlgCuJ2ecUYa2AwZuiSRidzwSsJrZNiU8mKLQSaMT1l9drXgNn+oSw2n+bR4PNCUElbak5rYACnwq6PkrKKYfYUYtXx5v3jCUBfRUazIrl7NYIpJnvhodR73aT7WFa+yIhiCHE46f/w7qYsbq5VjQ54qEWK3Fio+SAa74aG1N2SrFvIIfDb36IIln+KXtcHoKzNUk6an6KxodndGggR3U0/g9xEeaAP80IiGttSDT+iRRq+zshh7WKt8r8caSMcFkTuu6XnxDHw70lqim97lgguJfjWIoMLqTCiPoPp7E8/X0Xw6SHoK+AqVEQDdyfBgkcCMac2zUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEm+Zd68haM7LtkQHOJw18FzwI3+uegoLf+7JvXpjlo=;
 b=P9EBeUVmPfIMIx6484gTpFChLT3nSRp/ObwZhogu4haypWiXQxYAWz907cPrRcBNFBJLtniNA4aozKfwyL3B7E6dcpG9tk/6awRSpbgu0eidYQWYxdJVL27QdSwjE/0nOKVmAc2vY4d0cJ2xRqJjq7duv+cr2pleqjgZYvdEWK/wuCFGfrdTJns300xXInDuaWQLUxwPHjY99z4kBGuv85JsxbxvMntaHCXjvfblkmmJww2kyIOCR+6PNRY7QuKXuN+I0XxLeqMxBSrzQNMEL2L4jDZiBLp7ljtTFn22VgIpQBIP0nHjjlCBEfzbuPTsBijGXKxXc0DTwP6NF9eo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sat, 15 Feb
 2025 01:09:00 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8422.015; Sat, 15 Feb 2025
 01:09:00 +0000
Message-ID: <c1863075-90bb-486a-bd25-b8ea6b2ae035@intel.com>
Date: Sat, 15 Feb 2025 03:08:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<avri.altman@wdc.com>, <wsa+renesas@sang-engineering.com>,
	<quic_jjohnson@quicinc.com>, <andy-ld.lu@mediatek.com>,
	<victor.shih@genesyslogic.com.tw>, <keita.aihara@sony.com>,
	<dsimic@manjaro.org>, <cw9316.lee@samsung.com>, <ricardo@marliere.net>
References: <20250206210835.2980500-1-erick.shepherd@ni.com>
 <20250206210835.2980500-2-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250206210835.2980500-2-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: d55cea01-e618-4b41-d65c-08dd4d5d548d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFdDRHdINHlwaE5TYW5jcExJNHFBaUplS1hENGhYTlZxWFZSK0Zzc1lHWnlI?=
 =?utf-8?B?MENHRzZ6UU92Qkt6cTVHMHNKOVBTTzVoUGdxcEpiRkpnZ3Nvb1hzTWhDTFNQ?=
 =?utf-8?B?VmJ1eTNObWxaY3orcHpPQzNwQXJsZFNyaEpsUVVjbk5OYnZNcHJSZ1h6ZWxi?=
 =?utf-8?B?bFQ4MUFQMloyeUtnMkRCU21BQ1lZOUZ0cFFDTjZHM1lLNi9tK05FbXlEQTZE?=
 =?utf-8?B?YlBWWndnazBVS0lZemVJVCt6LzBsNHBBL3VCYlE0S0ZWVitldWREVVBiWSs0?=
 =?utf-8?B?YWR3SHcxaFEwKzJHbjZnbXhQWHM1MHZCYzA0YlovSDBMb0FockxlellvdDlh?=
 =?utf-8?B?QXpLS1hUSjJRVEZTS25VVmxhaVV6UVY2Z0dEeTNzUk1HMkpEcWVVcW5BY1da?=
 =?utf-8?B?UUcvZ3B2NDlmUXpQVHNvYmQ2VlhsNjdBL3ZCWWI3TUVIMVlIZ3V6d25yMnZh?=
 =?utf-8?B?S2g4bytOODl2QjRSQlVCQVlFbjhnSGh5RlByK0xkdVMzRGxOem9zMEVBcFdL?=
 =?utf-8?B?ZCtQL0daWDkwRG5JbHI2R2ZLeUExTDJuVXJ6LzRyY0ZjZ0ljRzQ5elIrQnZD?=
 =?utf-8?B?S3JBSXdaNFdpMGI3Zk41a3ZDTUFFV2Zaemw2YVh2cXp2eWczK202aFFvZlpH?=
 =?utf-8?B?RmRpbmc2bjVnRGNPeUhDbXFtVzFaYkthc092dlhtelNFZGpHditVRXUrSktG?=
 =?utf-8?B?Qmk5ODBJWVFzOFEzOEg5ekp6L2xacFdtZkQvOS8xYUV2Mlo3K0ppSnpRRVUz?=
 =?utf-8?B?dk8rWU5xWkdLSTFWMkZlTFMrWDNBTjdiUktnRHpTZllkR1M0c0JSNWN1ZXcw?=
 =?utf-8?B?dWt5K2EzUEhyblZ2ZnFob2liRHFBaGZ2Ykt4S1M4OERqaUNITXFvdFdnTVZo?=
 =?utf-8?B?bUZ5VDlSTU5WcXVSRkt4RGlYdEgyZWtsRUgxbnVKQmN1cXM3S3h5TWIxN0pQ?=
 =?utf-8?B?TFpDSW5hdWFaWkVFZTF4RVMvQmhqNmViSnBmUUV1Wld3Z095UzBsQ2tLNkJS?=
 =?utf-8?B?dno1YTc4MStROVMyRFFtMVFYYzlqMkVJbXQvZDM3WkQ5cXJTd29vUVlDa282?=
 =?utf-8?B?RVlFRFBERlR3bE9qelpjc1VnSHM3V1Y4LzBaMm1iaVNOR2IwREdVY0dCUUZ1?=
 =?utf-8?B?MndEd2RwR1g3SGNlSGZqdis3UGRpaVNtVmx5MklVeTJyVUpZbHAvbGwyZ2Ft?=
 =?utf-8?B?b1pucS91MEd2VzhDOUl5REoweGkya2ZZMHIyeGpQZmJoUlpyVUNyL2NkZW1R?=
 =?utf-8?B?WVJteldGcEZ1bFFiTEtHcmtaelZPMlU4aTRjYVgzR0IyREY5MU5JMDhZS25x?=
 =?utf-8?B?UmlGb3Z6MU1DdGZYMjlPRG8wSHpyaFBleTBId1lWT0JmVWVuVnFMa1NRWUpJ?=
 =?utf-8?B?aCsvbEY5SXV5VjU4Ym85ak0zcEQrNVM0T0swb0xVSnliNTV6YkhhcTJ0a0VX?=
 =?utf-8?B?SldPZjNvR3pxZ3VJM3ZDWDEzSXdKVDM2UGZKMjM2Qjd0RC91TDJ1VzAzck9x?=
 =?utf-8?B?VjhYVlVVcW5FQVJ1YzF2SmJ0TlhydGJOckVFTEtLY1p3Sk5ZTzBpenNMcGpw?=
 =?utf-8?B?SEp3aWpmVXRXVGtWbXhlNExnQVZLbmswbVV5bGxZclpBWFIrU1hGWGxRQS9U?=
 =?utf-8?B?TlJpUGRYTDBtUHFqbEw2aDhwYysydjBLelpZcHpSZnlYR1l0RlRnc3Z3Y21l?=
 =?utf-8?B?STl1VWlBQkZlZjlyMm83RTNmNEdqSit0Q0h6VlFRallKK01UckozSkZaaUZ2?=
 =?utf-8?B?QlBPcksyM1liRUlHeGhQMlN4T1NncFllcSsrVzlEVjR3WWtNOWxPN2VuQjc1?=
 =?utf-8?B?VExvN3NGVVRjMDNNZzl5M1dDOWRLNHQ5a0wyanhsSVRvU1BGYmF5KzhRUG1H?=
 =?utf-8?Q?R+aLFYM8Flota?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXhVcUtpN2hURmFuZlBHUjhWeTJqWWdmeUlJSU1QalBienV5encvNVQ1Z09l?=
 =?utf-8?B?UEtsY1FrRy9MNFBwbE1xYUFkWVVOcld1NGNlLzlRbVdaMEV5cnFZZmhCSUtZ?=
 =?utf-8?B?cnpFR1UzWFZrMDF6cVhGbERlbjFaV2xSdWkzM2ErUVY0QTJVQ0Ntcnk3ZjNY?=
 =?utf-8?B?UFYrSml4NXh5TlhNMEoyQ21McXRCakxGODNpTG5jSWdLVDBEU2dPME8xWkpT?=
 =?utf-8?B?Si9pNk0vTmdIRCswSkZJVVdray9qd2ZYR2JJUVdOQVZoY0szbnhVQ1RkTVc4?=
 =?utf-8?B?RU5qcGo3a2JSOTU2WkYvRDYrQndodTRqcjRuZDdnd0U5M1o1dEVpZTI5d1ZE?=
 =?utf-8?B?QWRwNHN2aEVKdDVyeERDT2gwZ0txWlpjQ3NqdFdHazVzMkFVNHJuU3BPaUdX?=
 =?utf-8?B?SjZ4WDFxY2xmeGYxT0FMUWhReTdpQlFZUnRGRzlRWEE3S01UTFJ6WHBPZlF6?=
 =?utf-8?B?MGFkZlZ5VmJlYTRmME5LUFZUNWQxamlidGJJM2xwbE1SV2NOMDVCSXdwMHVv?=
 =?utf-8?B?MFFLOEVOOWVXYnF1VGZaaTg3aUdKV1R0Tk9FTWppR1hqQnUvRTlQRFlIZE5O?=
 =?utf-8?B?Tk9SQnRoZVUrMGFHVm5UMlQxK0Vka3Q1MWRFWVMzeU9iYzZhM1dVR05wQ0xy?=
 =?utf-8?B?WGgvQzZpMFZrSi9XZG9jby9PVVZWd0xlYlAvQWtxUzhyNC8veUpQZVFoYWZt?=
 =?utf-8?B?SkVRSklMWS91MjkvQ2RYQXJwSExvcUlTcExudlRJUHpOWmgyUVROczg5VnpL?=
 =?utf-8?B?dmI1MXFDRGpSK3pXZ1c4dUNvVE13OCtlMGVOcWUwTjhTZmRnelNZWmZGbGU5?=
 =?utf-8?B?RjhhTlgyTVUxdWNzRUVPVTJaOC83N2N6UlFtczJJYjFnWXZIYVM0RGM1cDgr?=
 =?utf-8?B?RVgrYlJqVHN5aDZtb1IrRDVpREsrbWt2cnFsaDFGR0hhOEhOU1lFN0xkblVv?=
 =?utf-8?B?empqN2ZxV0RxbW43SVE4MUs0THRGYk5qVCtXNXdRWm10WHJTMm9qNnRNOGtl?=
 =?utf-8?B?NnNHWmRBMFJ4dGp2cFhHaUVqSUlWZzdjWWRJZU9BTEN2TnJWSTZ6UC9ONkRF?=
 =?utf-8?B?U2pSbi8yTE52OXV1WjFEd2FPQVduUHVlUzhzKzBwWXhJckswNGVVb0FwVmdn?=
 =?utf-8?B?aXlNZUtvMGZkZWRnMmtNR2NqSmVpczVuUlBXdDc0MDZyMDQ2ZWNraHMvSkxr?=
 =?utf-8?B?T2kraFdFYnd1eWM0STk2NGZmTEMxTUF2WkxHcndEWkNyNGJleDFQYjY3RjZN?=
 =?utf-8?B?VVNtczBQbWdjN2crRmRsYWRUOGtGMlZVZW5iSDlnZVBGK0dHcjhCM0FTbTBD?=
 =?utf-8?B?aE4zYmY4U0hQU0h3Z0VxYitzWG5VS0NqdUd0djgrb1hLUk9zMStET21vQVBz?=
 =?utf-8?B?U3JKN2doVGVERGY1bXd6amRPR1NZYm5Cejc1YWpDODg4NFphdk42OVpyOUtY?=
 =?utf-8?B?Zm1ndUtlbDFUanhRVFV4MWtmQWdLcVdQZ2N5Zi9HTnRHY01DMUpZMWhQUDkr?=
 =?utf-8?B?anV1VENlQmtpUFVPSlF2ZTFJMXlYQ2hXSTdpY08zd2U1ODYrdEh2Y3V2dzhG?=
 =?utf-8?B?Ylh0dmJ5Y1Q1S2NJMXovYjk2c0YrMk9vcUZJTThkZkZka3dnMGJRTnZVMHFM?=
 =?utf-8?B?bDQwbWpsMysxeEFYR0FyRG5NdVhjV3BhcW5jRG1lRmtnU0FlaTJLQWFSQW5R?=
 =?utf-8?B?ZXN3RUZlWmpSV1hvMTl4ZnphWkJOWU9lWEdpbkpPSnE2cWNLS29iNk1Mdkxv?=
 =?utf-8?B?WHcxSVRET2MxOG1uZDJNVmovYnFhZ2Q0UTNSMFNJTXVuSFhIbXQ2ZGZ3dVpT?=
 =?utf-8?B?Ry9xZDVPc2tJNFN6NENCL0lsQ2g1RTNheDNmbTBiYmtlVm1WTnptaGZWZUl5?=
 =?utf-8?B?NzNBekFNaHZTTnJmVkd5OFlwdk5zemJsK1lFZ1g0M1ZTUGZiVERiRjE3d25Q?=
 =?utf-8?B?aU5DV0FzLzdTNyt6Zmg5elIzeWVkUGNaZmZtdjF0Tm9HQUxlVk4zRXRDODRh?=
 =?utf-8?B?V3BFL0VSaDdld3A5NFNTUlRrU2R5ckl6dnJTL0tYOHFwTHlzVnVKYmhIVjNR?=
 =?utf-8?B?KytxeHFteHdrTldabTB5VTJKM3pCemFFY2IwQ2VobnQ3WUlQWUgvTXQxNlNo?=
 =?utf-8?B?aG9nMTR0VW9nZWh6WFdTRTV5NDNzLzdCK0tRS3JScXl2bW5pVkNLZ0NQUlQ3?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d55cea01-e618-4b41-d65c-08dd4d5d548d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 01:09:00.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmIHEyhiZ74hus+fiFpQH4C3obKo08RcVUpkx3+YCM/UDNg389d9N5YKR+Qe/4IBIbFe/CXrF68KxrIfXwTOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com

On 6/02/25 23:08, Erick Shepherd wrote:
> Add a new field to the mmc_card struct to disable tuning for the card.
> Currently the new field only gets set when a DDR50 card fails to tune,
> which indicates the card does not support tuning.

You need to explain why this is needed.  Presumably it speeds up
runtime-resume in some cases?

> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/core/core.c  | 3 +++
>  drivers/mmc/core/sd.c    | 1 +
>  include/linux/mmc/card.h | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5241528f8b90..ee91d53c45d5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -934,6 +934,9 @@ int mmc_execute_tuning(struct mmc_card *card)
>  	u32 opcode;
>  	int err;
>  
> +	if (card->disable_tuning)
> +		return 0;
> +
>  	if (!host->ops->execute_tuning)
>  		return 0;
>  
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..dd65485c61d8 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -676,6 +676,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>  		if (err && card->host->ios.timing == MMC_TIMING_UHS_DDR50) {
>  			pr_warn("%s: ddr50 tuning failed\n",
>  				mmc_hostname(card->host));
> +			card->disable_tuning = true;
>  			err = 0;
>  		}
>  	}
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 526fce581657..f9733c7ce430 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -332,6 +332,7 @@ struct mmc_card {
>  
>  	bool			written_flag;	/* Indicates eMMC has been written since power on */
>  	bool			reenable_cmdq;	/* Re-enable Command Queue */
> +	bool			disable_tuning;	/* Disables tuning for the card */
>  
>  	unsigned int		erase_size;	/* erase size in sectors */
>   	unsigned int		erase_shift;	/* if erase unit is power 2 */

