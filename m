Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319C4C76;
	Thu,  6 Mar 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269779; cv=fail; b=QIn4YK6YIXfdgOxYzdLbu67rcHTYB3GOxlaTm/F6GHtE2AelKebq+IjcZTzvnBb+M0Dmg8jiON0yeht8zm0B1vfT43Emw4wq6cIILNAYY4kGUXDtGiSiTevtba7Mp1KCC2zj8Mmkbm9ztZcvPthytxG1i14A5TAKsgO71aVoGFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269779; c=relaxed/simple;
	bh=vAAzWTqVhGZfOU6UhFkYSOzPV7voGEpGuFRtokJNShE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CW61hqJ8fKRMf60fPvCzsMt1DKgly+yocv1NmySEwReid35pUAe9l8E7N36kAteXXvXbTAWk8ezVTRRAttMlC17ctRnQBMzkkOAQvAfw/6C4K3wyvxh9Y2gNg+Fmzs4J60CXbklNbOKRJ98CIL4ONkM6pSlAcZoXAjLskIJUeMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jss4wQLK; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jss4wQLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741269778; x=1772805778;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vAAzWTqVhGZfOU6UhFkYSOzPV7voGEpGuFRtokJNShE=;
  b=jss4wQLK9P9EF3wWe6pEreoNbfr5YjCmJFXW9z4MBvOJQtmi3vzpmoji
   v4eGEqq8UXed1jY7ZkDCsZTU2d1EBnEwwEsf/3dZtinxmPZ3Zz3qeFIXY
   z/4rAbn5K0QQx7VWk1t7w6w4IDp149YR12X0elrF8EUh5HGfkCFo9kXYi
   amOj5Gq3GgMhuuPvsW492I/YNSeQFRgu3YVk2//K5SjkrsCcr6zzWj3ak
   WOYHI0778NNHyBeP734Bihv5x0cwYProUNFFCzYd9ZaXdvtaQsfznJfLR
   Vnr4BpbqxjneFzDU56WKFsvZAu21O2hVYj17vbtdkmsCk3FP8gPvHAAnr
   g==;
X-CSE-ConnectionGUID: XiZluT1zRA6Y4TVNkAiZrg==
X-CSE-MsgGUID: TB3uX9xiSMSPFkUQtJpx1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29862772"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="29862772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 06:02:55 -0800
X-CSE-ConnectionGUID: GmLfmG9ZQa2ZD1lP80kbhA==
X-CSE-MsgGUID: /9ddxpHbS9+pgx6OojVp3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="123615453"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 06:02:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 06:02:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 06:02:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 06:02:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4D96ZaNy6WCy/yoKYmx9uhZjN7ZdYaXgeySDDbKG3itt6+9uLqSBTUbaHXwIzd1zwICgd51NTxpv5Qk5abGBKJiV8Dwx5r7KE7ESJ6v/LI9KlDfNtsGR2J7lVVC0SBrCyT2kEt27N4WI1rGEm37ZlcbuwuT/7efparWquCdaeoAOBOCktQTIEbc6ivKIWNtJ6SyZYQM1kk3f9R0VxGL8DtrNRnhGzsuinFiTxW8G1YtDZZXXVzcptyAX/YHRKdBwtiJpJ82yrUKGfifk5HqAMgBL3/Tq/iHAosVwyNMwYJWwzDxKglQp97UocMqgHDdOEjSnRNl4GoOdos1e9HH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAAzWTqVhGZfOU6UhFkYSOzPV7voGEpGuFRtokJNShE=;
 b=tR+Tx2ebDsqyqo+tdN5cgikB27L+eGtZGw975/l1G7lXkxP9vbhLlbRtlrrUbKrmaRtIQG/cPzr3zdmDMaknRp25alFCKtFls7Dza9S9ww8dVhDClEenhB/X19wRZDiKIrdvVvYFsVUVo79fhTWmtjXa4t/Ar3KMsGjw9RhLV6ZQzbqzJVzMHasFqs8DWTC1v08FPVX1xm8AI7SVh+3OZeHnR2sc46ONvZFokvS59gs3K0na1gjCMuBRQblpz6YwG9kXbH0E/vcRvWu+feR/Az208UTIznSEVATJZTzzM5CGeedEhoQaWG4kCbrz4LkT2GS6urZRctBhd6WZu67htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:02:11 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 14:02:10 +0000
Message-ID: <9e34fea2-6bdd-4673-a75d-837d9b793c3d@intel.com>
Date: Thu, 6 Mar 2025 16:01:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>,
	<cw9316.lee@samsung.com>, <dsimic@manjaro.org>, <keita.aihara@sony.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
	<ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
	<wsa+renesas@sang-engineering.com>
References: <c1863075-90bb-486a-bd25-b8ea6b2ae035@intel.com>
 <20250218184156.574787-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250218184156.574787-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::11) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|PH0PR11MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: 48476b65-b505-47e5-1d87-08dd5cb77c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVpBVFoxNUhFU3hlSENCbHhBWWk0bzdSc3h5amVJZ2pJcG9uTlo0WktqTkNV?=
 =?utf-8?B?SzF1RTYxR3l2K0huMmR5YUV4V3FqZmlObjR0SDdGRGtaNTY3ZEtXZU5CUWd4?=
 =?utf-8?B?SnBNdlMrVWM5bzVYcko3N1hWQU10SWtCdFp2ck5PN0IvZUoxS3JxcWNncTFk?=
 =?utf-8?B?RnFOMUtxZXRmOWNMVE5Nb0lTVVdyVFRiY2ZlejN2OFRwQitVRFRpNldCaU5R?=
 =?utf-8?B?d3hPVnJROVZFRUVGUlZGRVdVQ2YyYWt4MWpaRnBUZGNrQVRGZVMyS2ppeG1s?=
 =?utf-8?B?RTFBbSs1eUpidkxQTW9iV0tTMmpWdTh5bnljTm5uSldJaG1uM0N3K01LQnZU?=
 =?utf-8?B?d3d3OHpJY3NYdDhYQm1hRDBBYUtpOTllMlBsNGFuc0ZzMWtKeEE2anB5ZXB0?=
 =?utf-8?B?NlBWSTk4ZGpUNEdSTmtnN05VRFRkQ28zZWdxZmZCR3JLY2FUTXVaUGNQdm5o?=
 =?utf-8?B?OTJUU3RSWHpHaTR5NUordUZzcDhUVmVlek0vZG9Na0k5WFRMeEVmT2ZOUFQ2?=
 =?utf-8?B?YXozWGxpM3ZFL2F0TWlWYlNOdm5hZmsyQWEwZDJCMU0xbHU2NGFFS0N3a2Zo?=
 =?utf-8?B?Y1o2UEd5N3RJakMzT2Ntd2xrdStNWmxvd3lPNk1WUFZ3U2JyUGZCR2RTcnBa?=
 =?utf-8?B?Q2duWnBRUFl0eTBEc0dNMlFJTUNWU0RicWFUNzV5bnl2MGhvaFFsc29SVjF5?=
 =?utf-8?B?T1JZV3NoeGl1bGJ2RlF6QUkvVGQyOEVMWVVXdWFEYkdzak5yVzE5TGJBaTB2?=
 =?utf-8?B?Q3JVRVRKejlSZEVxMzlnRG4wbGJKUnBTWGdVc2JoY2U1eElUYlN6VFZSRitT?=
 =?utf-8?B?L3ZsK1k4U2tNam9venBhaG8xTnViMWkwcVhFTGtqL1FsdUh5WW0yL2dVNVBk?=
 =?utf-8?B?eU9RWkx5N1p6ZHF2NFN3eDlxVDlJaEwvMkxsR0tvazhjMmYvWmZsZW5YN3Zl?=
 =?utf-8?B?YVVMNFFGTkNjV1ltOThzSytLeWRlRmdvM1J5NDVRY2s1WEF1a1ZpSHlMZ2tp?=
 =?utf-8?B?VkNtcnE4Smk1VzN6UWFnelJsTnduZ2krK0FpSllkUUo5Z25TZ3IvRzR5b1Mv?=
 =?utf-8?B?MjEzM1Q2NEwyWkdnZ0gyeEZUdVBpdVh0VW82eVd2WW1lalU5YWt5UUNXczND?=
 =?utf-8?B?cXJ2K2R2NVBsWTFlU01JdUpFS0NDcDQySVErbTZpTFZYZjVZbWtLMGhGdk0r?=
 =?utf-8?B?SXhMSVVxRGcvYWtlVUdJdjRQT3JoY1lrRzBFN09oNUV6NTJSbEdncEZORXpp?=
 =?utf-8?B?N01OR3Q5L1d5eUdsdTU2S3JiaUVKSy95RXBqSjk5SEd1YlcxMTYrczVEcWk3?=
 =?utf-8?B?aWF1L3ZxelBGUnRBWXZET2Z2QVNUampaK1Z3d1F0MHRrdWZWRW5NZyt5Rnk5?=
 =?utf-8?B?OERhL1J2Tk9rU2djeWRqRmpKbmFRZjZEa3R3RGJWM0tzSGFJcmVFTzVtcVhQ?=
 =?utf-8?B?UXhUMFgxMWpZL1dVSmtGTkxiTEZObHFQTmIvVXZCUTB1Vmd1ZGdnTG9DTmkv?=
 =?utf-8?B?R3JHUFluVEJIQ00rMWZabisyZXZDeVRwaWZsZEs0V1BtTG10L3cvWEROZVpF?=
 =?utf-8?B?Y1Y1U3hraGFaak5pRjZnMFdocUM3YlI5VUk4Y0tKWUtKb1NHTmNZS0NiVVhV?=
 =?utf-8?B?bUVnVFZQOGlwMGtyVEZWZlBOYTczNmNYQ2NEMlhVU1NPaExiVVBHMlh6eFZ3?=
 =?utf-8?B?bXZhbDJLSTlGVDRMUlZjMVBXaTdMRFgrcDR1c0J6TWYraXdpZklHMC95U1lQ?=
 =?utf-8?B?alVMeFJSZDVIMEFtOHlJWDI0RVczNWlYQ2x3eEp6ZmY3WXdNNnprYWxHaWxj?=
 =?utf-8?B?NVllREVWeUwwZFJOOSs1TStSR29IWFVwOFFVT29DTFNVZWprNXRyLy9ONVZM?=
 =?utf-8?Q?f8g1d+u/kfQLz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdzSjRQeDdJU1prdzZYM2FRa1FsSUZESEJtYTREZ0VLdHhkZUw1d3JZZ1hJ?=
 =?utf-8?B?N1ZDemNzR0c4TUxQRC9pemZvSWdPOUs4UEJHRGhpd1QwR29Vc3F4bUtieGFZ?=
 =?utf-8?B?bDNCaysxYnI2cGgyKzRSRjUvaXdLU1pMQW9jTmpHSi9QWTFXZ2RvSlZjendI?=
 =?utf-8?B?ZDZlNVJ1MkNZaTRjajdyS0JNZG9KeFgzNHhtelhHRlhUcjRBYjVURFhkWkhK?=
 =?utf-8?B?WXBhUGVkb2lpTzE3QjVOdjUrbGtGTlpadnAwYk5hSDlsdVlQTi85RU1sZDZn?=
 =?utf-8?B?R0d3dlh2TlcxL3VxNW5WUGEwYjIvVGdJUFE3U3gvc3pQb0pWUjdzaUxWQW0x?=
 =?utf-8?B?dDh5SHFGSVh0ckc0S2J2Y0JZd0FVVDZLSkRGdkNxVEZYR3BYcmVnNlJSNVgw?=
 =?utf-8?B?Tm9odnc5ejFJeTN1aXN6Vm9GSTc4cmlqRGVTWTRRemZWRUljb0g3N2FKaEpW?=
 =?utf-8?B?c1BhcDJHSXh6RVJMM1RHZTBscHNvOEp2SU1mU2xjcnZWYkl0elp0NHJLV3F0?=
 =?utf-8?B?TGNjQ2Fla1huTndsUEtLZGdjck1PMTZGYW9oQjVBb3pZM2FQTEttZkJHdkpP?=
 =?utf-8?B?Y1NmN2lieTYyVUFzbWRpMjlPbjBPTWgrdTZZeld6Wk9lUEYzR3V3NmdPMGVC?=
 =?utf-8?B?SFdCM2tuNWt1dE9qMjlvdjM2QUIyZTVpRUEwVzFNK2FYbUhEbnc1L3RrTlht?=
 =?utf-8?B?amtOZ093NTZTaHhhcjBuYkJINlROM0tOajJyR0tkRXFCem1xUjdNVVAyVzg5?=
 =?utf-8?B?cmJCZzNxRnJpM0V5dk9UVzMyVzNxTTM5MWRtZG5YUzZVUWl2cVFLeU1EN2Vk?=
 =?utf-8?B?N0s2WGd0eTZCei9kQ1gxSFR6SW5qYlpTNmZYdkxUeWRoaUptS1poMWxvNEdz?=
 =?utf-8?B?c0N4TnJRRVVSemwvOUh6bHJtUWQ1RDJwNEMvdTdNVkl4VmYvblRid25UYlZy?=
 =?utf-8?B?d3U2Q01KVHJ4bXBsUnR6M2ZzTzd3NHBwUloyS3FBdFIxVmVUV1krVGYzWG8z?=
 =?utf-8?B?NHZNOXdLVC9KdTd6ck5wRE5tT0NJK1F6ZU9ZSnNCeFBHdlc1RXVJVDlLQWox?=
 =?utf-8?B?amRxUFlzc2U1Z0pPMTZvRHZZM3NnWEVnSk5nVlMzNnh4bWIvTEpLSHV0cG5v?=
 =?utf-8?B?cjA1cnhldXVubVNvN1d1b2NiNDVzbGJPZmxCZ25Hcmx1Q1J2bGdWR01Qbjcr?=
 =?utf-8?B?RiswUDFIMXdoWnNvNkFMYVpicmlmMHB1MW5MeEZtS3dGQWQ0T05penN1SU5U?=
 =?utf-8?B?QUV4RkNBQkdObUtMZ1MxQVNlKzJULzZIWXh0cjEzZTBaUGRNOStHQkgwS2RZ?=
 =?utf-8?B?UVdhL21Rd1ViRW9jRkpXVlA5TUhIalZRU0syRVpmd051bEdkT05kd3N6SXFW?=
 =?utf-8?B?L3hEN2lFNVhVRjlEVVJ4dEhkV3FodUVoeHphRENMUUdiSkliSmdlY2E0VWNn?=
 =?utf-8?B?cHlXYXpNckVZMnVhM0dGbWNtejdId1pZa1VuZGtGQlRDOFdNM2xEZFR4YTk0?=
 =?utf-8?B?NGxudnhHb1FMNXVWOFROSFZISXdmVjI1K0syYy9BNmpKSlVwQ01VNFFaWWZQ?=
 =?utf-8?B?cml3YTZ1YUdXRlUwWFVVcGpNN09nanB1ZUdIbitISWZaRXpOcmtPblFFMXRO?=
 =?utf-8?B?S2t6aHpUTjZDNjBZS2dDUW9LRnhLZGlSeDl4RzV0ajhQZTg4RTlXNkhiTTZU?=
 =?utf-8?B?bzhFM3Mzd2tneTJzOW9KUmszVFFWYS8xdi95ekdQTUNZcEVJemVHbWJiVVJE?=
 =?utf-8?B?ZC9vYWJSRkg2RzRna24rWU1Jem1nSDdmMkRFa1ZIME9qY3RPTStneVVmRWlL?=
 =?utf-8?B?dUFjcDZDbnVRcTVPNVl1MGMrcDZKQTM3Y3ZhNHp6WWdhTlVJbDEyaXdndkhK?=
 =?utf-8?B?dlV5VGhXNUNNMVJVWGxzMnZtdVgyVDFJdWtuc0RURjM2dUxxaDFOd1lPQWhK?=
 =?utf-8?B?RjBmdENDek11aG1oK1ZhajJiSnA0N1QvNXZqdFkzYTFibUZGWGNBaWM0Ymdp?=
 =?utf-8?B?MEowakNrNnNsdXRFZ0liY1Q3ci9ZWjREU05HSUdVdWxPVnphZlprcHNuRmVh?=
 =?utf-8?B?OHI1L1Fsd21GY3BUVE9HVFlnZ1h4dW5YZnI2RW9UK1V6dmJxYk1mbytGR1FZ?=
 =?utf-8?B?bWtnZlgrS25qRVN1K2tDV05hdzFEdkg4SmxSdTBMRmlwV21XRmFXbit1QVRD?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48476b65-b505-47e5-1d87-08dd5cb77c20
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:02:10.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vQrwoAq+3u6/79dtpJP030aOrOyBXv96tm4Oi6bWuLSNscBvnIjRx3/9dEWHb2siXouqFLaZMbRyssKvDdJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com

On 18/02/25 20:41, Erick Shepherd wrote:
> Sorry about that, the context for this change is that I have been
> working with a DDR50 swissbit SD card that does not support tuning.
> The case I'm seeing is that the first tuning times out and any
> further tuning attempts cause an async page read I/O error. I used
> this change to prevent the card from attempting to tune again if it
> is ever reset in the case where we know tuning isn't supported.

Sorry for the slow reply.

I would expect if there was a general problem with DDR50 SD cards,
it would have come to light before now.

Does the card work with any other host controllers with linux?

If it is specific to a particular kind of card, a card quirk
could be added, say MMC_QUIRK_BROKEN_DDR50_TUNING

