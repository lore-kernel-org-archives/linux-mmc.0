Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E242D97;
	Mon, 17 Nov 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376483; cv=fail; b=TV1mKuZkF+0WEp702i0jpy5GpiI833pTcdO3OLGYCCzZFQ0suZKj+P6jTjcK7Ftac7IopT8YrsdyCRsM+0K0AgWKk47jP7BI+aDzb+bXn38ucCrNWNOTo1mShui8QQKQiO+kft+OqgDk+P4pqc0mv38wFwqtraW9cMfLzPhL0/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376483; c=relaxed/simple;
	bh=3pwZWcNymmPmvChv0uU4qugl7k10Srrn+0bAL7o1lmg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbmqSZQDmp7297PhaHUpP4f0NsUWhjRylZrSzzT16PGuG+JjqnqRKZ2hdcIxXVlWMLju5yJF7hzCSjqdZ15BhoFDMlRNgweLtziW/llTDe8S8fxMNzEuIzdyC2DDYfMBX+TPcZY41xu54eqDllWYn0byDJ3dL6+AHnDb1ljtGaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Plz1KxE9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Plz1KxE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763376478; x=1794912478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3pwZWcNymmPmvChv0uU4qugl7k10Srrn+0bAL7o1lmg=;
  b=Plz1KxE9kve2knFhQ+YlXn8r8LFhhvpD5zNvYWW62iXYru8Jywm0xDIw
   +vNk/D1trmW3qGwe+TXKawRwF7ztiZ8Z7iHmcODPjsZPxoU8K7XNdulMu
   cH95+oEHNvwoJ7rroUtO0wguitUr2bQhjUP88hTpGqEI5PUlU/JgHkz1V
   SOcTZU7AV27yVtQaAzg7KjPdoY7hpiHUy+YxYFR4cNOfUCGczvZfS+iSn
   xzPeamGnJSQPHxtaRzTm+NpE0L0s48wijMmj/EgI32M4c+7d2dSsNFvgX
   7JdQGkInDQ1vK31P97RCIUR5Ftekgu8PYpMep8rVWDqfzyH7tY8A4K+xu
   A==;
X-CSE-ConnectionGUID: hP4NDyDvTKeqpPBwLpyUcg==
X-CSE-MsgGUID: fBngifVeRdmxnwZe1J4LhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="69221186"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="69221186"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 02:47:57 -0800
X-CSE-ConnectionGUID: RerP6lgkSFygTRDWsZesdg==
X-CSE-MsgGUID: 8OKGZv3oSEW6jAOE8o6K6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190859649"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 02:47:57 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 02:47:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 02:47:56 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 02:47:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiLM+iR/jEdpJqYwsb19SGldfdNQ6fw+eXG1GFPvS+fZJMIS1lgXF9WrrMiVoBTIp5qMxSoI1TMt8z9/InaI77ez/lfojX95lsA6edRncniDbL7UEQAXcYw5N6GZzRTIFOVgO+/Pif7XT+GHJ4mneHNl2rDQ7CZcbc2uXkLHWoLIRrttHCU6vTmDra0hqyYWE4ZJMEy91Qp/nJ87onf2f0sBMkbcv4HVEX5ZHWOdLLFBwYBZhnvoQdl5Tv2s6NGAdxSoGgNVvHzjssKoP1do2E3fU4I/zc/EyLDrLRydJN4IAe9zoqslL+6/uxonHXSqtUr4UnEusc419arYuRKrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6plrgPyTaJ5rthJxSaYpeJdbnZazOIKDkIfZ4ffUOgU=;
 b=HmYO5aLTEE5tCxDtECVBmdEEclXPOjslP8b8sMV0FDJxmGq87Tn9oecGwv+mpqeCG/Gqrzq1ZVoN4ZJvFqinLLmmjmxuNlIj7vVGPFJpaqj8yp68QQ4h7Bgfzbhdh0IBkDc4c4syLoLAVjt/f0ZqXBvsB/6nZpFC3tw+NJ6WMtRx5KZWg8l6nMzcCd/vkKRDvoPAcuV5AhReIq7o4lIOPQPCBFG/jjO5sSaT9zVkN+y3NLncL1lxjVsbFANVFyR3Ar2dS0UcyNd8HRnuNj/blM8VLmNoX/rNvJvtxrN/FmX2CTKg4ykJCPTSPr3UM5v0dutsJUNZiGyS5uLdptRtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by IA3PR11MB9304.namprd11.prod.outlook.com (2603:10b6:208:57d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:47:54 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:47:54 +0000
Message-ID: <ec3c6315-cbe2-44bd-a84f-f8f140c1d390@intel.com>
Date: Mon, 17 Nov 2025 12:47:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Marco Crivellari <marco.crivellari@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker
	<frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
References: <20251107141654.226947-1-marco.crivellari@suse.com>
 <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com>
 <7e99c811-2081-46b8-a089-19d6e1778cc7@intel.com>
 <CAPDyKFp3wBv4Kk5TXjQ49CxUjV1sd3uxreX0mOKpD5Gk=OiJrQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFp3wBv4Kk5TXjQ49CxUjV1sd3uxreX0mOKpD5Gk=OiJrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|IA3PR11MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe311d7-ff6f-4b03-0020-08de25c6b7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU8ybGVoMG9RMGFPeUljQzRUR0dkcHdWWWRqanpzak1EOEQ3VHdINDBPYUJk?=
 =?utf-8?B?K3dvb0ppN1ArQ0JKRHFaYjRHdk1xT2F0SGdyU1p6OE9KM0w1eExvdDl4Rm1P?=
 =?utf-8?B?MW5VWDd0WnBWcEVoeXAySVdRTitXbUhaUXZZWVVVQ3RmeDROb1F4Z2RqTzN0?=
 =?utf-8?B?UHVrcEhFSkk5bEs5YWlxdXRtYVQxeUlPeHJBNlBqMEIzWXNyZ3ZMQkZmejlP?=
 =?utf-8?B?K1JXUlFBT3N1ajhuemF1N2lHc2hrOXN0YkRuNThhWmYwdUJxSS93T0RuYWd3?=
 =?utf-8?B?OUxFc21zcmdlVG1uaTBkd3RuMVZqRUNMS0VDYllhZnhHODU5K2FLTktLVmtj?=
 =?utf-8?B?R1JWUUlCcVNBQU9IVkZHL29xN08rQnUyOWJ2R1ovMDhGeDdIZTZZRDFFa01k?=
 =?utf-8?B?VkYyVitxQ25nS0wvOTlXMjFLUkRGWXJVUFVRN2ltMksvUTNrZGpCcjJ1RGJS?=
 =?utf-8?B?ZlFvNWRPT1R2bncvQTFMcHppam5OeDRFenBQazhJbjFSdlp4OVoramxYNWpS?=
 =?utf-8?B?V2pzd1R6d0xxaklaUDFjeHBKUEF2ZE81REg0ZVp3M0hYbDlJa2RNL200NGIy?=
 =?utf-8?B?Nm55M3piQ05SUlo1NllscThzSmlkVmc0VCsvaVBCL3pvd3JCT2tlRDFnT3do?=
 =?utf-8?B?VTM5bXBRVW9KYWIxV0lVN3hzVlYwQmFNWDZxUWk0WXJRLzlBSXhJaTl1dTFs?=
 =?utf-8?B?bndBS1M0TUpHelhrb09OSisxVFcvZTJ1bWJrWHM4RXRHdDc1ZEJrMnp4TTIr?=
 =?utf-8?B?aElsZStXMHRpbmpnT0pQMkNxUHpka09EMHZEM01wNVFRcElhRis4WkM2dXp2?=
 =?utf-8?B?S09zSzh4NEliQzdqaE5JYi81c3FUR3YraFQvbmw0RjFEWmRvSnFrVTdPYm43?=
 =?utf-8?B?aWR0cUUyWVVDUldONFB5eS96QTMrTjEzWVVyR21aY0tmZVRldHVRRlhnMUpC?=
 =?utf-8?B?REpIY0cvRmNUeko5Kyt5ZUZGTUVkeThQQTl3ZlZEdWswYkd0eTRqM0I4eC9S?=
 =?utf-8?B?UGVQMzR0Z3RjcHBJS0d4c2JOZXVPb0V5MUlDOXB6clBudjhMYmxBWUlPMlhH?=
 =?utf-8?B?TVU4SFY3eUdEQ0dLWk5EaGJhc0d5MkYyMDVZZUFsOFoxYVpGNklzMlc2bXJu?=
 =?utf-8?B?VENWSVBRWWdGNTduOTl6OHkyZEc0eWRsZFNTZSs3MGxyWGl6dlpHUHFNQk5W?=
 =?utf-8?B?cTk4a3NvbkVyZHo1Q0RWMk5xblpaYTd4Z0J2T3ViemlXU2wwdUR3UE5FZm9i?=
 =?utf-8?B?ZmlMOTV1OTVwSFpzZlBkNUpaWlJtYVR0ZlYrNzZXaWJ5S2s1STJKdUNxNklj?=
 =?utf-8?B?WWcrbXpEWjdiejdRY3d3UEQzTEdlMVBuVGJQZ0Y3UzBoVlJhY0xtTjFBZHp2?=
 =?utf-8?B?aHJkdmJ3U05mSTNobHBBWm5UTGo4WElUYXd5d2UyUlVzcTZGQ3cvRWtpQnZh?=
 =?utf-8?B?RC9oQXVyODVha2NkSlpKQWJNOUg0SVhpdHFwdUlpc3kwWW80eWVwT3RpbjhR?=
 =?utf-8?B?SWg3ZFhqb29KZjBSNXR0VU5EQ2lFcUoxK1huRUt2bW9oOHFxL1A3WG81YkUx?=
 =?utf-8?B?a0xPTlRYdHdnSUQ5aEJqeWtGbFEwRlZLVjNJd1MyV2ZKRVFiRlM2Nml1NnNi?=
 =?utf-8?B?UVJ5Q1dTWHJnWjlMSnpwQWlhL0I3Y2pVbUpYTlZvUGQyMHZ5NHZ4YXRBQXBL?=
 =?utf-8?B?dytsazFvaytYVSs3ZEo1WTZoaGJxZmxIMFBWTlNpY3Y2NmltVG9OREQ4K0hR?=
 =?utf-8?B?VGFlMlJmU0kyTklKNDZrdVZJMnNHQlUzS0k4dGFDMEpBZ2w3dkMvMUx5T2Yx?=
 =?utf-8?B?a0QvTkNLOG0xcFNtWlFaVDdzaTBIZlBtUmhlWkZtV0wrVlFkQVVOdHYvTjMx?=
 =?utf-8?B?NmNmYjUzUFdsbytNUmVJVFV4QUszYlBWRGg1cU1Gc0hJODhHdk1iUWVWa1hQ?=
 =?utf-8?Q?W3eZINb2jXcoD5j+uxpdy8JPYDryUCUJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDVTTlZVTmdiNjRDTUhpSEFQeXRMOHkyazlRc1JUUnIyUy9Fak5pWXBUSzEv?=
 =?utf-8?B?U3NLdFc2SjFqeUQ3WGtFWUIzT280QTNLejZCbW44emc4MzRuSnpHYUZjNGsy?=
 =?utf-8?B?ekY1RmQvbXl3S3oxSFBiRDhYc0pVTGF4SS82UW1hWWg0NEVKdSt1V3BleWI1?=
 =?utf-8?B?aUdWVGc4VVp4WDVuNTdhMGROM1NJcDNxSC9IT0dWSFVNS1VPYTFpSVZHeGZp?=
 =?utf-8?B?Ky9va0tnK3p3eWxtZmh3QmEvV0ROVU1ESTRyVCs3cXBWbVh4dXFyK3RJYTVN?=
 =?utf-8?B?dXFaY3ZYMnJUV1VWMThXVFRDd3lyU2FKVnd2anFFcjlCYnJpdmVoYlBTYkNi?=
 =?utf-8?B?a2ZaVG4wSnFKbzZqM0RyOG5hR0xFNnhKd0dSZDA0Ti9WTFRvUzFSNlBteGdW?=
 =?utf-8?B?d0NyTExmdUViNkFHMGxNMVZxNVBrOWV3Z0dNZFphbkVQcUNRVU41TW9ILzV5?=
 =?utf-8?B?d2d0alVnWGl5Z05BTWVoS0tGSmVkSGViMkV4bWl4NzdUR0daMXBwOHphbHYv?=
 =?utf-8?B?SWVuTWtXR2QwSUFDS3liSTRkR1lmc1R1SGZlc0JvRTBtekh4S0MweWF2TG9H?=
 =?utf-8?B?UVNpQ3g3RERTeDVya0pnL0xjTmpDR250Ymw5SVJXaGhqclRyUk85dm56YnRW?=
 =?utf-8?B?WHFxcVk1ZytCTDgyQ1FZSGxKSXROaks0TjNTaWowUXZ0RXl5UWdYVy9qYTBy?=
 =?utf-8?B?SUVQTlRqRVNGZnZvakZaZkdYQnlPNms5clFaN2xHSFkyL0VkSFhSYW0wY1Yz?=
 =?utf-8?B?Z1pZNnJNdmdzblhpRWFkUEkzZEd1Z200ZldlY0R1bGVnQ0pyWGRlUmtGWnZx?=
 =?utf-8?B?M3oxbTVQY2h0NUdLSEo1VHpLSFBCL2doNHJKSW4wU1NmNGRKZ2l2d01acnhq?=
 =?utf-8?B?UnlCdDBvTk50RmN4d2JhWUJaakJDVDJhUFJqWmh6OHg5WVBZQ2pyN2I5OHQ2?=
 =?utf-8?B?MFVIa3E2QWZyMk8yeXEvd2h2eFpMVU16eTNkL3hhZklMMWlsWUFWRm9rdzJn?=
 =?utf-8?B?OVNOQXVTVCtKNTZuN3MxZmdMbWdXbTZtY3gzd1ovQklNUXp5clpIN1VVRHRz?=
 =?utf-8?B?eVRuSkpXVVduQTVWZnR4VWRxTlZiZWJ1QzlBMU42Q042NGlnV09UNDFPRVBO?=
 =?utf-8?B?eWJBM0V4bExKUExxSjYvR0Q1V1p3cDAzdWp5UURsZ1U5QzM2Y2lFTXhuS0x4?=
 =?utf-8?B?MDd5S0todFpMSWhoclFPOEppYWZmaEdvcEZIUHF2azh1QmM5ZVpMOEQrQlJX?=
 =?utf-8?B?bGppUkEySnhlMmlGblh4K056cU5vYXRnNVZiZ290MlA3YVBFcFhPcHhzdUNF?=
 =?utf-8?B?L2ZkTHpKVExPMXIwM0EzVzB1ZlNQWko5SGdVZ29GVExDNzZCWkViWTc4ODAz?=
 =?utf-8?B?c09uejV2OUMrT09aeEZmcjRZWURoMHpvNk1JTVhCNnlyMFpkY2p6cSt0blo2?=
 =?utf-8?B?emJXUlltcXZiSURlVUFuckFOcGtxUlVONStoUGNkaTQ2cDFLazVISTN6Q0FG?=
 =?utf-8?B?YXlzRkdMR2ZJSUprYmtEUTFTYTl6SWlmTFoxcW9iNkdVZ1AzUzczcVdIMlBx?=
 =?utf-8?B?MVlpTGNZVElwdVBSWmczR2dlMUVURjIzQU4xQjB6TjlCaE95QW1vdVRGck84?=
 =?utf-8?B?eEs1QU4yKzdiQUQrd0JlbmZHd0NxRXBwbWpHZXA1OWFUellBc1pwNjBhUVB5?=
 =?utf-8?B?MDh1R2NQNDdsc1BkWjZpNkRZbXFyMGlIZllqNThkaUdFTkd4SytpR2NuVHhJ?=
 =?utf-8?B?WjZtaTZKZEdwVmtSeHdpRGtTS29BckVvU2pSNzV6aG1zVW1VVGRaZkQ1eEVL?=
 =?utf-8?B?WXRtaXRZenFmaE9OMGw4cUpUNjUrQUU5bTBBL0hNbWZzTmV1cWU2WTBNNHNH?=
 =?utf-8?B?TWNRaXYwL1hsb05Hemt6VzBsVjduOUg5OEU1bnh1eVk3ZFRqc1h6V1R4Lzdx?=
 =?utf-8?B?TnR3ZEdacnA3NmFwdjNSR1lJZzJQVnJ6RDJldUVLZ0V1aFMrU3YrbURUcUlh?=
 =?utf-8?B?MmJ2Vmh5VjJkakZGek5sNy8wOVlEN1pnMTg4V29Id1lrd1ViY0VRRjJtZzZh?=
 =?utf-8?B?Y01ZZVd5L2FpWklnYzFwZ3lQa2FCb0ZHRzdLeU9PcHZUVnhjcmU2VDgwQ1RZ?=
 =?utf-8?B?M2crWTJwSlRIWHJBcVhIakdoUFV5YUMwLzBucjh5bW9EUUl2Njd3a1J3RzFG?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe311d7-ff6f-4b03-0020-08de25c6b7af
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:47:54.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnisSHmfl1c5YSH8LAnhHgaBfGGpYwTpeUiyUABJns4dqKhhgNJWONdoHWffxE/oOD7dUN3BjchsDyIfyCIFJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9304
X-OriginatorOrg: intel.com

On 12/11/2025 13:45, Ulf Hansson wrote:
> On Wed, 12 Nov 2025 at 07:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/11/2025 19:12, Ulf Hansson wrote:
>>> + Adrian
>>>
>>> On Fri, 7 Nov 2025 at 15:17, Marco Crivellari <marco.crivellari@suse.com> wrote:
>>>>
>>>> Currently if a user enqueues a work item using schedule_delayed_work() the
>>>> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
>>>> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
>>>> schedule_work() that is using system_wq and queue_work(), that makes use
>>>> again of WORK_CPU_UNBOUND.
>>>> This lack of consistency cannot be addressed without refactoring the API.
>>>>
>>>> alloc_workqueue() treats all queues as per-CPU by default, while unbound
>>>> workqueues must opt-in via WQ_UNBOUND.
>>>>
>>>> This default is suboptimal: most workloads benefit from unbound queues,
>>>> allowing the scheduler to place worker threads where they’re needed and
>>>> reducing noise when CPUs are isolated.
>>>>
>>>> This continues the effort to refactor workqueue APIs, which began with
>>>> the introduction of new workqueues and a new alloc_workqueue flag in:
>>>>
>>>> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>>>> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>>>>
>>>> This change adds a new WQ_PERCPU flag to explicitly request
>>>> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>>>>
>>>> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
>>>> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
>>>> must now use WQ_PERCPU.
>>>>
>>>> Once migration is complete, WQ_UNBOUND can be removed and unbound will
>>>> become the implicit default.
>>>>
>>>> Suggested-by: Tejun Heo <tj@kernel.org>
>>>> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>>>> ---
>>>>  drivers/mmc/core/block.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>>> index c0ffe0817fd4..6a651ddccf28 100644
>>>> --- a/drivers/mmc/core/block.c
>>>> +++ b/drivers/mmc/core/block.c
>>>> @@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
>>>>         mmc_fixup_device(card, mmc_blk_fixups);
>>>>
>>>>         card->complete_wq = alloc_workqueue("mmc_complete",
>>>> -                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
>>>> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
>>>> +                                       0);
>>>
>>> I guess we prefer to keep the existing behaviour to avoid breaking
>>> anything, before continuing with the refactoring. Although I think it
>>> should be fine to use WQ_UNBOUND here.
>>>
>>> Looping in Adrian to get his opinion around this.
>>
>> Typically the work is being queued from the CPU that received the
>> interrupt.  I'd assume, running the work on that CPU, as we do now,
>> has some merit.
>>
> 
> Thanks, I get your point!
> 
> So, to me it seems like if we want to explore other options, it would
> require us to do more analysis to avoid introducing performance
> regressions.
> 
> BTW, do we know how other block device drivers are dealing with this?

AFAIK, call blk_mq_complete_request() from the interrupt handler.
mmc_block does that in the case of CQE or HSQ.

