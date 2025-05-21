Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159584B1E7B;
	Wed, 21 May 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825467; cv=fail; b=pHGxq9awFJK6+VZLOiV+gZM161A9nyYc1wXr2sYdy0uz+8RAZLb7EoQNtD4TFgFk4uQl9fLV0Q5Wd6Vb8sc7KFHxpSYIiGDdRld05HC/s/HQ04Xkjxbk3HR7Ry5W1/l23pT5oeHpWN2ry6MORfrlmRjzv4hD0H/196uI7MTTVqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825467; c=relaxed/simple;
	bh=bjkR3AhAx5Xwf/V2/uxFTXVaYcnOdoDokci0+CdwziY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mewskGB0BDLbvUijFtEhYOjiKLpZ6hxgCA3Iv+FFqFkpZKaCEhkPmBcR7GO9PNKPCyXBsjDkwTH/Levdgt4OxFpTuQb2J4U1x2Wd+QYTMIrhxMaH41dA5ZKHt2HNpd5TKvkoeoheDSTk+e5yvKHQg5G2mugmOC0c5HKS1vluTZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGXL8IOn; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGXL8IOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747825465; x=1779361465;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bjkR3AhAx5Xwf/V2/uxFTXVaYcnOdoDokci0+CdwziY=;
  b=FGXL8IOnT+1by7P/AZhNy3SL1BHw93jPdlsCZgiRwrqIeJTUGJMvbvsR
   IdzVAQMOfRdL/x2p06IWXUyhWRAZ+Whqaa3CASWt3SXWNnLaDiytYJMve
   a/KLbimlHr6U35e5PEY9sjLsWNs2ndGqL2q77m8HMw8BlOxMyu7LZUUJy
   MDNLECeX0jyHpgsjFBAQImfmGTQjQm65ph/bCFBUSsi5oz2JFMmvIVHpU
   Zi3kEycoxLSNTo2kwz8CXsUh6fqdIDEvXJuFg5NhjOs+BOWo3XuqHDcPv
   9QCBeF+RbpKeVBZ2qqxhoQVjooBs5AeQgiPxpt/pB0wlWwxcCzy3h5m0J
   Q==;
X-CSE-ConnectionGUID: bptqKK8MT06OmYP5BrOh7Q==
X-CSE-MsgGUID: 1b+XjrjWTxSDRjef/TRd3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60456130"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="60456130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 04:04:25 -0700
X-CSE-ConnectionGUID: ZYmBM/2tR2OwgVfMA6BSfQ==
X-CSE-MsgGUID: HYFglVYhSQusOQcYI0wqAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="170892088"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 04:04:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 04:04:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 04:04:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 04:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/p8lYdtGWINdY6fgeLCJnJnjw+utJr0V1DeTzzGum4cdRGEn6GL56vEHtL/GC309x3yo9VqjIyShxyfXxxkwCEqKMrmlYtFkf/Pq6lkYmv3mvwEqAPMTPcEpj68BAPevS/U2DT8mPx6tN8jkgwaoPUR12jqbM61BLiX5SAK8rBxBU/CiZbM9fexty+DmNLzA8/slEuGAlwzSQwDyS4b90sLOdzZzYyOAw+BiYOwuM3paS8xVtFB/BBCae+3U0SbMIlKIrQq6rKUqjHAza/gXu8K0onMrqJFEFUzjJgumyJyQOk9/9MyTHxbzIZu0OYeNXc+SatH8Xo/d9zS+orQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C19OnHw88pUJ4bH+PIbT2cC2AQP+BKx2bd3EOzYVLiw=;
 b=Y3iNQbF3VOALV5fS3WkDmnvyAISugEVwPKDNbKN1TL9IvDvJjKGlBsTaEqfCpaIHELqPI1bG0jvocVafrr8nENnoRUceXfso8KGir+wLueP3UjGV1meQIyhXpJBcKkzBNYKiE3z2fNOuIHj31Xm93ZHiQ5N5wIjd1v89ROjhWVAVPXJEgxrq2tGFEtX1venN4bugJ6G4djz5o5ThtnfCZczUHserys3yXItqUC1X5ba0NyaWf5kl7OJzhXLv+NOgPfGh5yqLwR08hu7CJ0VSewiD8F5TsJdW8oHoeqlHTdIHufrtdgHmAacW7c21kCzBK+Bjs/X7jyGsPg9MQvHMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 11:04:04 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 11:04:04 +0000
Message-ID: <e9559e3d-8c77-4748-90ce-4be5e8ac6ead@intel.com>
Date: Wed, 21 May 2025 14:03:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] mmc: sdhci-uhs2: Adjust some error messages and
 register dump for SD UHS-II card
To: Ulf Hansson <ulf.hansson@linaro.org>, Victor Shih
	<victorshihgli@gmail.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <HL.Liu@genesyslogic.com.tw>,
	<Greg.tu@genesyslogic.com.tw>, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20250516092716.3918-1-victorshihgli@gmail.com>
 <20250516092716.3918-3-victorshihgli@gmail.com>
 <CAPDyKFqCo2-9fYYAoNpmJf7XOiTvLM07hQks1io-S0MvmbAjCQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFqCo2-9fYYAoNpmJf7XOiTvLM07hQks1io-S0MvmbAjCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::16) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|PH0PR11MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: bf66875a-8f32-4731-c8b9-08dd985732f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkg4T0docXRsZ2RqWllZTnd5RHRORUVkdlRJUmN3d3hPKzV4bUl4KzM5bHNs?=
 =?utf-8?B?NkpjTk94Y1JVV05rYW8rVHZzbGlsQXBRdkREWTRFZHNIcDUyZHlpbURwZjVE?=
 =?utf-8?B?bmZUc3RwZ2pnQmtBN0laWjNreElteUg1VGVXSnJEMnh1VUNQTzZ4RHNlbWRR?=
 =?utf-8?B?NExxanVTRTNlUm0raVlFSk1Eb1d4YnBhRHRFbFpwSVUzT1c4ZHpaRDdXNU9k?=
 =?utf-8?B?dmZmOXE4OVovZitLOWtlTkdyN3RDc3psUm10RzFYVFA5YXhFY3VhNSsrdDRn?=
 =?utf-8?B?OUJ2R1g3R1BJN3YrcVNPS0lXVnJZeXBCZjRtTzZUSFE0ek9CUCtKN2xqcTk5?=
 =?utf-8?B?MWRuSTA4Sy9xYkgvQ3BnTktUWTJkektsOFRURHJkdytTbDJGd1JCaEZaeEww?=
 =?utf-8?B?UVBKMEpZNWxZRlc2OENWRDl2T3BlTmE3akdoYmIzVURXdHZoU0ZueFI4KzF6?=
 =?utf-8?B?WmtZRzhnazljT3MwMjJEOUpTYzdEanlBTTA1ZTA4MTZzMlhHZ3BvMnFvL0dU?=
 =?utf-8?B?MytrTVVjY0cxSlhFeU9tekd1SjBlSy9aRmt2UnhOVzVDdFVETXNkWnJsOTFU?=
 =?utf-8?B?L1FSd25nQkQ4M1h3VFI4bmZ4ZVhMWXg1dHVZbDJMQjFrd2RWZ0xGZ0M0RWFC?=
 =?utf-8?B?MXdPK2gydlhsejhHSTdPOXB4TU5EdS9TK0xCQWNicVo0b1J4L3JiMFdNNHV0?=
 =?utf-8?B?QjlsTjhKZGpnNXcxVVk5VG5sZkQxR1JISHFZSUQ3aXo4bUxXS2RNZGtaK2Nx?=
 =?utf-8?B?cjF5REJ1N3l3cklqRTV5Q04xK1pDVGpqd1hXTnNUZ2I3UWlBK3NNZURLY1VN?=
 =?utf-8?B?VWgyQ3dscTlnYWFOaG5ES0tOZ2JWWWdWSkFwWXZ5VlBBbTRCZDZ6TnlJNTFr?=
 =?utf-8?B?NjRNa1NRNEt3UlF0Mjl1Wm5Eekl1WHhNTWxBcEdzMkdQUWNENEJNUytPMnpm?=
 =?utf-8?B?ZWM1NkVkZWx4RGtUeGlrNlVBUnpId2Fva2RoMUVaOXgwRzRlS2RTSTF0VG1w?=
 =?utf-8?B?QUMydHFpMmNSN2h4cDRscFpQM2lOYnpFQjA0UWkxQjgwQ3d6Q0pnOFgxbk1D?=
 =?utf-8?B?c1k2ZlF5NHJLc29BVVVEemNGSVlEN01FTHpnN0R4VFR2VTcxd2J0MzNWNDcx?=
 =?utf-8?B?TlpZbkN3NnQxT3pFdHV0UUxNcjRzVDJMcEllamowbTBrVmVVV0NYeC9BS0JK?=
 =?utf-8?B?Q3lkd29EOUl3V1ZTd3NSakVhUU94UmFYcWJSemdUMEVldDI1dUhseE5DQzZU?=
 =?utf-8?B?S09tWnZIdTNTdFZSY3ZCc1hIam5VYU41anc0bFRYR2oyWHgwZ29LT1EvVjlu?=
 =?utf-8?B?dmRLckFoeXZvV1pWZ2U3V092UmFLL2pBQ2VYeVpCRnpZMkV1bVFYODJsOVR0?=
 =?utf-8?B?L2RUallkMWxlRHlBOGw5VytpdEVFOWxtVGFhck5qbTRaK2tOL2tGUUF2NlA0?=
 =?utf-8?B?TFFmTEdNeUxyZ2pBOWNIbzFoWEkrV3BUc2pqNW9FNk4rNDJyT2YvVzRxVEJF?=
 =?utf-8?B?V1Z2V1BNbnNzUGhwbGJ1WllYY1c3ZGk5di9RbEFIZUFoaE04bkZrZlRpL2xT?=
 =?utf-8?B?R1VPRWtxZ0ZuZytGaEVWRmNCK0NoZmllcUM5eFZnUkFlZUw1NlZFUXc5L25p?=
 =?utf-8?B?Yk5WTnhqOHBOZnFnTTE2M0Vpd0dlUEloeXJsQ1Q0c00wTmpNOWxYRFdQQlBV?=
 =?utf-8?B?VnIrM3ZhQWJ6Mzhab1dod3EyZ1EyMDVsYm55Sy9Md0x6RFBtTW1MTDc3MGZK?=
 =?utf-8?B?c0cwaVBTSWd0S25paEJlV21DazhqN01lQ1o1TjZNaEF3VHlIdVlQbVdDVnBa?=
 =?utf-8?B?cFYyNnliVUkybFpWazd4UXErZkFlc01aclhjL1lXN05ubUM3NHFpR3oxREkr?=
 =?utf-8?B?dHNpQVNkY1NwU1NTU3VlYU9XcnhXWFpCY2gvWlJaMlZMd2Y0dkdkRzFaU0Y3?=
 =?utf-8?Q?YJCJExl4Z0I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRRUzZxRW9PS25KNXVvUzdNT2M0SzFITHlXV21QMWRDUVQ4c3lrYlJTV1JC?=
 =?utf-8?B?b2IxQU9aS2ROVnFGVlFEV3luOUYxN0dGNzFZRVNITWp0bjdVTEpyZFcvSXFN?=
 =?utf-8?B?a20rZ040bmgzZzh1N3RsRGIyU2FJb3BQbkJKeHJyTnY2SmZUU0JTS1B6SmtI?=
 =?utf-8?B?cDVTWDN0a2tCZitkV09rdHM4N1BYZ2pTWi81WTlNWTIxUmFNYzJaQW1MWWpl?=
 =?utf-8?B?QVRTNEl6TEZ5MHZSalk5RFN3dlVVd2lGczdnWUFHbEhvdDVDK2JlejNhbVUr?=
 =?utf-8?B?a28wYTZ1cnNabThLV3M3dXMwVmhyQmJRbCtXT3l6YTVMb2ZiNkNISXhSdDBq?=
 =?utf-8?B?TG9rOUpoVDhweG5EL0E5U2drR2hmbWh3YmpiemRiK214SkZZcEQxc2IwSWpu?=
 =?utf-8?B?dlRMaXV6NEl0elBmYSs5ZTVtV29uYVBBVjlSMG9WbTFjS2E0SWQ0aTBLZGkv?=
 =?utf-8?B?T2JLQ1NJb09UMk1vTXVlaUdBLzVaSm9qTE5taE16dFlPcWdlZlpKYmNsSlJL?=
 =?utf-8?B?QnByUC9xVFVHTXZONFhXOHBETk94MzBtOFgwT2Exc2FZYmVGTDVoVkFybG5O?=
 =?utf-8?B?V2V3MkF4L3JTQjVYQzBhN08rRW52blVDb3RodzJzOTZPeW5DZFFjVEE1WHpO?=
 =?utf-8?B?RlVoM004cWxxK2NaUTlZYVVqSW9JdGROTDNEc1RTcFN5QWVxYjlodlY1L1hy?=
 =?utf-8?B?SmV3U3E1dnZZUEQzNzFKUTViQWxEQzdwZ0h2MnRYODQ4MlYwSWVpcUNoZGQx?=
 =?utf-8?B?SnFEakpSSFpJWWx3NVJqZGtmVjQ3MHBKTFJ6cE1OclFaTXJsNnZwaXZ4eDMr?=
 =?utf-8?B?YWx4cDVFV2N3c0RpN1hkTU1TaEh5c0VTbGl5OGpXdGZqUHo2S25HNXhLNEU1?=
 =?utf-8?B?dkpVMVZMSEdkTTdWUHpuMEdxYlp2UVliY3o2WWxMS0x4MUJ0REgrTWxiclZF?=
 =?utf-8?B?THBBbXJUVG9UNjVZUEdhNTRML3FvaldMbWRBRnpqdFI2anRkbjBkSXM0UDMr?=
 =?utf-8?B?VldkQmJuUjE0N2V6dFl4MkZ4ZUFWQzErd1hhQW1kazNmN1VlTjlKTG53N092?=
 =?utf-8?B?MFovenhkS00rZ25HdTJnRlpLSnhlbnRDREE3T0xuQVNwa3BjVUVtRm45M1Fh?=
 =?utf-8?B?TmlhQnEvWHYwYlNxbTlJOWVPSXQ4d3EzRVFhSU1PL3EwaFBYalJVNnZuQWJm?=
 =?utf-8?B?S0lTdXl1VGFLWTNURk1PME5Ec081WllxUnRqYitsQWpxQ1ZNQTF0VWpheFd4?=
 =?utf-8?B?dWF5UWhNay9LVE9PaFRCcXlLdjNaOUV2RUtPL3Ewbi9HTE9Va3Y1NDhzOGRG?=
 =?utf-8?B?VFQzd0dGVjNKbllPVXpZd1lYK3h0d2RiSjY2L2NtTVVudmJibnFvMjBIeXIr?=
 =?utf-8?B?VzFHM1JUenRQMFJyS3o5SU4zd1lXc1BiUUZoM2J4ZVo2U2V4N1l3bXBSZGhD?=
 =?utf-8?B?dWhjREhFbXJheXFUUFlIM2RZYmJibytBeThQbnRMczc3b1NZTGVyQURVTE96?=
 =?utf-8?B?VUJ4TTNyRVh5UEtCWW41MHY1R0hoUmVKUjVoZURpOUxlNHZIZ21yR1Y1RmVH?=
 =?utf-8?B?aUMra1JTeldPZXN3RUVlam14MTBaM0NXV0RoL2F1OVh1YmhCNFQ3UW9XQ0hU?=
 =?utf-8?B?ZmVZWjNQdVRwZ3djYXpLc1RCR0lmWDAvOVBjVFdMYjRtV1hjYi9TeEphQkkx?=
 =?utf-8?B?OFhwQjhmWDJmSktveVI4ZjlnODNYWElpODdsK0gveTVGd0JJY05kanRiTjlT?=
 =?utf-8?B?cU5ORXl6UHc1RGJtV1FrdEtvVy9WS1RCSXJEVVVibFkvRk5FYlB3VU96cHVu?=
 =?utf-8?B?NTJOb3VDUm9DdXMwVVJTSXlhYWk1S2F1NEJEeEIxQWdJWjRaMGswbHo4WXov?=
 =?utf-8?B?SDhzc0xQRS93OTlxdW1VOGZBTzJBMHBZSkwrL2JTeHprZndkQVA5dXZOS0tx?=
 =?utf-8?B?WWhKemYwSHdnb0VOM0xISVQ5Y2xBZThUcFNZN1Q2bjQ5cDViZnloTnpwandR?=
 =?utf-8?B?RzRNOVFFT1ZFdWRvV3VKRUJOR2tyR0tOMU5HU2dmOGVVMldFTE5zWGlVZGlJ?=
 =?utf-8?B?OXU5dTNzQ2NOVkR4eXZqTXZLeXlFUEdxUk13QndtWG5GeXovT1REd3UzM1Ji?=
 =?utf-8?B?RlZ0dS9wMmh4dmNXWU5lR3d4UGpRaWdWREFOaXh1TEdNeHlLbVNWYVQvZzRs?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf66875a-8f32-4731-c8b9-08dd985732f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 11:04:04.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3T8Ky6JQePiYRAucsgQaHlwZ9slnKYPu2S/bQ2H4xrM0cnK1/MUDca+qfBKalJkLq9n8beF8KOVS0IqsWwHkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-OriginatorOrg: intel.com

On 19/05/2025 15:24, Ulf Hansson wrote:
> On Fri, 16 May 2025 at 11:27, Victor Shih <victorshihgli@gmail.com> wrote:
>>
>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>
>> Adjust some error messages to debug mode and register dump to dynamic
>> debug mode to avoid causing misunderstanding it is an error.
> 
> Dumping the register may be useful for the debug level, I am not sure.
> Maybe Adrian has an opinion?

My understanding was that the original issue was that these messages
appear when it is not a UHS-II card, so the register dump should also
become debug-only.

> 
>>
>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>> ---
>>  drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
>>  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
>>  2 files changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>> index c53b64d50c0d..9ff867aee985 100644
>> --- a/drivers/mmc/host/sdhci-uhs2.c
>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>> @@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>>         /* hw clears the bit when it's done */
>>         if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
>>                                      UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
>> -               pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
>> -                       mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
>> +               DBG("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
>> +                   mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
> 
> As I said on patch1, please use pr_debug() and drop the macro.
> 
>>                 sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
>>                 return;
>>         }
>> @@ -335,8 +335,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
>>         if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
>>                               100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, true,
>>                               host, SDHCI_PRESENT_STATE)) {
>> -               pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
>> -               sdhci_dumpregs(host);
>> +               DBG("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
>> +               sdhci_dbg_dumpregs(host, "UHS2 interface detect timeout in 100ms");
> 
> If we really need this, I think we should first introduce the helper
> function in a separate patch, that precedes $subject patch in the
> series.
> 
>>                 return -EIO;
>>         }
>>
>> @@ -345,8 +345,8 @@ static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
>>
>>         if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
>>                               100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, host, SDHCI_PRESENT_STATE)) {
>> -               pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
>> -               sdhci_dumpregs(host);
>> +               DBG("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
>> +               sdhci_dbg_dumpregs(host, "UHS2 Lane sync fail in 150ms");
>>                 return -EIO;
>>         }
>>
>> @@ -417,12 +417,12 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
>>                 host->ops->uhs2_pre_detect_init(host);
>>
>>         if (sdhci_uhs2_interface_detect(host)) {
>> -               pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
>> +               DBG("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
>>                 return -EIO;
>>         }
>>
>>         if (sdhci_uhs2_init(host)) {
>> -               pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
>> +               DBG("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
>>                 return -EIO;
>>         }
>>
>> @@ -504,7 +504,7 @@ static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
>>         if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
>>                               100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true, host,
>>                               SDHCI_PRESENT_STATE)) {
>> -               pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
>> +               DBG("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
>>                 sdhci_dumpregs(host);

If the message is to be a debug message, then the register dump
should be also i.e. use sdhci_dbg_dumpregs

>>                 return -EIO;
>>         }
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index cd0e35a80542..2c28240e6003 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -898,4 +898,20 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
>>  void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
>>  void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>>
>> +#if defined(CONFIG_DYNAMIC_DEBUG) || \
>> +       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>> +#define SDHCI_DBG_ANYWAY 0
>> +#elif defined(DEBUG)
>> +#define SDHCI_DBG_ANYWAY 1
>> +#else
>> +#define SDHCI_DBG_ANYWAY 0
>> +#endif
>> +
>> +#define sdhci_dbg_dumpregs(host, fmt)                                  \
>> +do {                                                                   \
>> +       DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
>> +       if (DYNAMIC_DEBUG_BRANCH(descriptor) || SDHCI_DBG_ANYWAY)       \
>> +               sdhci_dumpregs(host);                                   \
>> +} while (0)
>> +
>>  #endif /* __SDHCI_HW_H */
>> --
>> 2.43.0
>>
> 
> Kind regards
> Uffe

