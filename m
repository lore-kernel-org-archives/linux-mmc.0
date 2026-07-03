Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6B2E542C
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097442; cv=fail; b=nRiprooPXQGz7FV5mKbwn+0WcGBUwv5jVfV0ZqtTGPML4i2pBpw2IqBbRw0WFllZknAv+has2MsU/fxMJ4Y1YADfjtOuZFVTIAhpGmA9i0mDjZe/bXRUjJDHM+vPMkvQ3b0cgoMKvQ1VlXljogBcMj1oun3BqSnIiiHGOzlKP5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097442; c=relaxed/simple;
	bh=S/8cylgfxj/S3n1uEospbZHClB2KkqjExJk3JARVSbE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhTtngAXxLdHoVkQXSiAwTnQNiOy8nxbK3CqXefTyrbQ9PrCdWgaHjaOIxQuprZ8RCKjnp1NiiG+/o2MssTG3Eq2nqGqX+6qYysa9NpN0J6JnOTj0t5DGpotMyZcayteKgh6fO05pSqvLfFmMSeYJflciST/YVepk2+kzd6FJDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3arVhmK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3arVhmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783097440; x=1814633440;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S/8cylgfxj/S3n1uEospbZHClB2KkqjExJk3JARVSbE=;
  b=j3arVhmK182WxaMHGQDnMUCmlWSoeWpw2S1EjurnQxEp8CEyWxEICiPd
   Zt/0vILQGhAcuHXlzVdUvXY4LvGucSli36Noixb+xqW1j2egPX4MX/lIv
   QgMsaw+nAbC6ZPNRNyCtQqPJcId9JgsIPgpTBb+v4bZXI/Ed2su6/GA5K
   XK7DmFewcJ9r80j/cwjThcVcj/4U9aP4UkGoM+s/mrt6t6rPiIm6Cw3if
   wJ9D+zQ1RfeWpvjgscX+keZSNOM3lWfsUG83C/tKiqia+NFzLeIdMVsC8
   J7N+SdzSc+0cau09cOrLFkahNO1d1gTjfoa1gM3XSivG2hTxkApsmoxY1
   Q==;
X-CSE-ConnectionGUID: cvVlxCWfTyi1qF4Njb6nEg==
X-CSE-MsgGUID: N4T4MyD4RaqgeLP7J458xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="109397431"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="109397431"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:50:40 -0700
X-CSE-ConnectionGUID: 560OakLjSk+MaMz3ltdwTg==
X-CSE-MsgGUID: RAAYr2HNTTmL2vnZWXAuyQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 09:50:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 09:50:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 09:50:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 09:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voQF2Hdqa2T0VEO0o2KJWDmd8PjZxrwnDbVx38Z0d5a1RTbsKf8NChUhaixVkhs2C2dx3g6ai1GiwBy/Wp6d3fsLnpO95/xIYU10G/bLZ5e6YkCD4d2+h1pO2Q6ni22tcYLWcUMhCJotoz4KJEx/hWNYbVTux3U6gmEUfsLJAC/P/tcypqsdPrtxB618uuiixN2AYgVDtLosT8N5oGxpWPHRlwd6+g+V7ly8J4U7i2kAQJPvbxuCuTqtG+n8GBK8GqnVfg6vclklJvNE9D5uFrKnQ6s+NJqbNiH7JChjQDvTDHRdgncWGFXjHlQyV9j/N5z3uYmwNVr+nBgteBcK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYT5MRdBqPtxw8Rq+N/HbogvLPGPYQAlobjtJO34BaM=;
 b=XM41sIIc0nKRtLxJuXi4hrUedcBzqZcJPFzBuBrs7CV4p+rjtQ66L5GdiDrr6ge9+iv2c+01PMZxocyCbbv1+mIO7+2eOmRv3PnyhDLz/WLlyVJqwEqGoeNfpqOyT47rN4vxgaEuh7MmOF6I/uvaiM6ECknr3NdipiKvXhEJt8MFFuI/rhfVy7IIz2rGLwR4d8cClFRT4k74dB6t21tb45UHS2rOF6k+KpRAwu3AcSKl5C/C6uMSGQXkG6NKnUsWxOeKl0tCbsUuwbe3C3PpdE/cypsiWPeuTlgTwbmX2awgAboh46ckpXPj6Dlkzz7T+HT3OsV+nmV9KsWBG27wAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB8261.namprd11.prod.outlook.com (2603:10b6:806:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 16:50:31 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 16:50:31 +0000
Message-ID: <60f3ff8d-3754-4aaf-90ff-a886ffb84ded@intel.com>
Date: Fri, 3 Jul 2026 19:50:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself to maintain TI AM654 SDHCI host
 drver
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, Moteen Shah <m-shah@ti.com>
References: <20260618220209.211875-1-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260618220209.211875-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0287.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 814dc77a-09bb-493c-b91a-08ded92331b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: +nOkLt1QieipZT0QGP35VMpLzBmmVYR5rL2QkG+aS6FByBkxMhQj88YwKRczKqx1+ciHDypfCmgVY/b6CL66A+g9csm3I/AI3N/sXW3yt2/84aCYkYgkQPyhv3nQmtBhvF6E6C7UFJh9uPcLuMRQyY1hFA1lVzL4Ff/CMgbvICnMpTpjzvBStIjFM5J42jKAOswbSQvur4So+YZNLzyhWQVeAPP9PkO4aFJz81wYpribdijbAavIlPgpGtwUCKg86Qpjew+LNuOXPQNVXG+bZqKw96ohwILhUjyUIFxvPqyMNZOwiI82QxvEMEUvcqBnLb+jfNx04biVGUXPvUb5Dq3DMzXTP5mA4KJ+pdCSd+379RRy06daduDLoxWPrFxpTRzfCJaMc4oGBN8hPnq+R5b5gy95rx6a60eQz6qAWHWiNiYF16C2yqPtAn+Ja9CAMdLJv61mnDtTTf17z8SbJ1G3QzvIJpfOTxndr1ONLctLF//6ynZoBmItzcfFV0UFO7EPB1NdgsM/jB2Eso6YrCwrIT/EGoNDUSxFqYg6AMzVi6rEXypadhTGLyKVKBFajWF6H0bEx4i/X3kQK3Jitk15Z/IXtx2MrxENGzucxcseZE06SvrW2I0jNDrYL4dXU1T8/KlHO2ofDJkJNG5yNJZFtca9fGweX8+rEzv9TJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZpaWUzMEVBaENpR2thSzVVT2pYa3ZmcWV6aFRIUE43YWs5S1pXTXdiY2lh?=
 =?utf-8?B?SHFDTnAyNyt3ZGE0Q1B5dDV1dk56Ylk0TDEzTXZpeHhDUjhVY0RNanB2djJD?=
 =?utf-8?B?T0lQdXVGWnBlWHVGTVhyL3FLcnFwSStPcitXSDZJNW5Gc29nUGk0UmozWlkr?=
 =?utf-8?B?V2pjUVZQQ3pUZjNSTW4wSmM3emxOTGcvZSt4SjNZYjBMMEJNUjdMSWUxNXdF?=
 =?utf-8?B?MUczMzRUMHpZd09rY2dBNCtzblBzQ1NPUEFhZUtQT3B1TlRjcUpweXNocHpM?=
 =?utf-8?B?dEhlQUdHT0VJY1M0OUFLWnkrV3Y0TUJuMk9POHprcnE3blVMeE1wNng0K1dv?=
 =?utf-8?B?S01kWmliZUcxRWJQRmVIRlorSmdwL1dwK1Nod0MvRUd3d3ZtZXU0VU5JU09E?=
 =?utf-8?B?UldJUE1OTitMOGlaSWo4K2ZiL3hDNnV3U0QvQmN2R003RzhLRDY5QWlNN0Jn?=
 =?utf-8?B?bURGN2VjSkxhWHF2Q1FIekxqRVJYQTQ2Q2JnWG16VUp3cjVsODNISHAwQTVm?=
 =?utf-8?B?bWtzbnpCSyt5am1Fc1gwazByNElWOElib0llVFRJdjJXR2UrQy8yeE9qeEVr?=
 =?utf-8?B?aERXTWtjdDM2S0dFVTFKSVpMNGVpQzNMTk1yK0ZoelhibFJKOG9oWnBTT2hJ?=
 =?utf-8?B?Y2hWay93WEJLazVkVFppczZwU3RnbFZSYTFUQjNtOW44ZDl6NkNPUTVYWmxq?=
 =?utf-8?B?VG1OSkdVUmx3ZWdPN0FzUmxwdWdURk9EdTNaSngvTFZSeXdReXlPbys5Zi9O?=
 =?utf-8?B?Q2pUV0FvN3NpYXM3dzhOcmFVTFVlbVpwN1VzMWJ6dEJCRDNUUXp6NUtGUUlm?=
 =?utf-8?B?U3lBR3FHMnMvYVdLODNMbmhpMzdLdUg0aFN5d3RrbmkxWGRRenQySHp1amhF?=
 =?utf-8?B?aENJYndzN2NGMVVLYkFlWjJWbEszVEYzL01NMkNyK1F5a2JCZC95OWNIK1Bi?=
 =?utf-8?B?OHZ2ZnAxTGtkKzhEVktPNjV2MFUrMUJISlUyc3g3RWNyeUJ1a29pcDdLWWl0?=
 =?utf-8?B?ZWZzdjdaZ2F0KzVFdmF3Qi80TFRqVXRvV0ZyUTRLc0JNVXVTM3VKU1dVY2hh?=
 =?utf-8?B?MDlRelkvQVNSQTM2cENHc1NhU3h3TWE1akd5clVyVHAwVmEvUGY0YTEyK1V4?=
 =?utf-8?B?SGJROW5QUWdzNEJ6M1RsbmplaGxSaTI5dnc2WUVLamVLdVh0VUxjNHZiZ1B0?=
 =?utf-8?B?cUljVmtMSGJLdWRTYi9mVzBJTXpXeEkvNjFQTmQyeTFzK1loaytKL0RmYmxS?=
 =?utf-8?B?cEJkWkZtbHRENWxYcUZLand3WXlLeXpnSFpFTUVaY1dOQnpiOGl2WDVoS2cw?=
 =?utf-8?B?ZEx4UStqR084Wk5yS3gyQWs3OTNveUJONWtrbEE0cm9CY05BRkZjdHUySERF?=
 =?utf-8?B?MnhwMkVZczVPOTFqU3NIWE9JMm1BVHZhUjJRc2pVUkVHbXBNR0RhUE9LZGpG?=
 =?utf-8?B?QS9yQzNDTFMzSzRYOXUrRW5iUlZoRGtLV3IveUg4amV2TFVYSXF0dlRFdnFh?=
 =?utf-8?B?N21mMU01NkV5SnF5L3pKWUdGdjRaYkN0SjhwNE9rcDlIMUt0WkFTYWVObmUv?=
 =?utf-8?B?eXU5bXJkeFVsNTFRZlRjQlhkUTNFNTdsbFN5Sk5MTE5oWmVrVThLU2ZFTHE5?=
 =?utf-8?B?dlVFMms0bE5ubm9ZTkNpK0t3UVlWOTBMb282M0ZQeTdOdnJ4bk9tWXNiTGI2?=
 =?utf-8?B?eGxrYk4yWTNFUGg2NWpYOHhoNGlkVlZteWdpYnM3QUlvWkF0a2ZpNUFoVWN0?=
 =?utf-8?B?RXI2U2xNTXNvUEJGRmYyRmFDSHFVb0pnOHJRQU40Qm5DbldtN3FFUU5KU3Vn?=
 =?utf-8?B?VUlLU1Mwcnl1Qy8yY2Q4ajBYRnJsWk10OVoxUWg2eGFOVWZOdTEvRHlMcmN2?=
 =?utf-8?B?T05NclgvL2ZTT3R5Q2o5RTFrbHhza3VLSlZmL3JQVU1NYmZGaFFrekFPb1NV?=
 =?utf-8?B?ZEx0eHNvcUdKWlk3b0ZUZjJ0alhzMmxEbDBObmRLcExsTWVuWGQ1M2cxbGM1?=
 =?utf-8?B?VzdNVXJDZHNwN25NeVhmUUkyWDFxa1NMMUtybThBM0ZKcUxKaldFdk45R1ZF?=
 =?utf-8?B?V2VPN2kwSU1JVUxTMDhySnJucU85ZXMrSUdxWVB6ZTVQL0NYeVNKaGFKaG5H?=
 =?utf-8?B?QWV4VitVZGFoL1ZjenExUmpOQ21hZDdXb1JFanRTRmtDbURyL3hjVlY0QkEr?=
 =?utf-8?B?MjV1a2cxamhWMEhIdWNya2V6cDNPTXFYUStPd2c4bkJ2K2YzOXV0cEE2NmZZ?=
 =?utf-8?B?TW1tKzZsYnV5YVhCNUVKSjZORk41VTlsZ1kzcHNmaktTeFlzMEZuYmp6NHNI?=
 =?utf-8?B?TzJ5WU16ZUs3TmwydUR2R3BodzVkUmlWWUJCdWx0OERHOU5sZmhIdz09?=
X-Exchange-RoutingPolicyChecked: Pg1liUy6gZV6NxALflpdCUbtZ2/wW3jRExIDn9l3E8FSX5frdTtnDJSwjBAF3sJ5PZj76VRzRceaYwY68GLeaT/hNN3hTZtqWUUYR0v3v9ikWTZKGZSVxnnodPmUpodFte1AYYDg1DytsdcD4bhBT3vjo7xTy+kuoV3DPcaqPUIyu74o6AJuNouvfeyzMOVpnyw5MwNb11QpHKYvgb06ppvGVeDCEL6NmP31nCwCHk875FOpjLJxqXSNPZK2gMl6af04XrQwUKeiHj9XoCeyD+hX0jZtWeyw/RJqhEbC4tOugszNzZGL31rcSyxFsIc/VpACY+TEFFj0O7kAjKxhJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 814dc77a-09bb-493c-b91a-08ded92331b4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:50:31.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aU1PY7SbwFPZAaztG1FvNLu7DWhNr+t3zphfnsdbOiinKQiHXNka+wNX2S7IUZun3wVTk9bRziW8JHY3R2e93Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8261
X-OriginatorOrg: intel.com

On 19/06/2026 01:02, Judith Mendez wrote:
> Since actively working on TI AM654 SDHCI driver, adding myself
> as a maintainer of this driver.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2040011a3865..97b9b01275729 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26640,6 +26640,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
>  F:	drivers/media/platform/ti/am437x/
>  
> +TI AM654 SDHCI DRIVER
> +M:	Judith Mendez <jm@ti.com>
> +L:	linux-mmc@vger.kernel.org
> +S:	Maintained

Should probably be "Supported" rather than "Maintained" ?

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> +F:	Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +F:	drivers/mmc/host/sdhci_am654.c
> +
>  TI BANDGAP AND THERMAL DRIVER
>  M:	Eduardo Valentin <edubezval@gmail.com>
>  M:	Keerthy <j-keerthy@ti.com>

