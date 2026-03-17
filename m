Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE513B5823;
	Tue, 17 Mar 2026 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747213; cv=fail; b=KadDnZfQSbqqUO6/6YZF5WoG4WgbQqopjnl4y/tjKhaVj1S/iSWWxjuI5boaxi+bGFDoZuAYVLHQpHAmALnoKFHpiiygfDeDPKIcVy+MjaSQ8EMWJDR/WP7OQpfRvNzD8Rd7/02ZHAbTCI6tSSarQ52kLIZTnulEfmgFOOPNiqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747213; c=relaxed/simple;
	bh=/w1kcLaIfpNFc8F+CuZdPZFWwfJR/zoffw/9OYSHb3Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m3LnIcr6O66JH6blJMuYCW6QQZZb8bPFn6SgBSCZgJNUV/BvKdpu4oslCRjnNMpWCwa1m5czXeShtqBXDTTNjG1NN97DxmrMrirUTce3hz/JrX5mfioCMxoVtkHf2O5ThEHqclrHB9Xn5DOFUUa1hbinW0Jxavog7xrwiepCU/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7/I4WaR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7/I4WaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773747210; x=1805283210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/w1kcLaIfpNFc8F+CuZdPZFWwfJR/zoffw/9OYSHb3Y=;
  b=j7/I4WaRaBbt7scCI745aMQwrQOuLzUpwUbWH5O1jSddIoG1ztpGyg9s
   sTfxLuSTpDOkyhvAfbYj1DQY4LGBBSsNjgaWuQHiX+q+zovN5oxavRRcE
   HXknFG25vO+h82mDJWlY1zSXvBDVjJnLPH3g5+p8Na2Augpdihf5/+VKZ
   cimOyLo0AkEs/ZmsWmM2stWIeNU2nFKlSVseEM53LGhK4zHPBdyvdSn4J
   aCESEVR70v/+Cd14sZY34U2IIoLWmpTBSGaUHUhoIFSVclVR0NB9nXB5R
   445DdEYCqyC70xhyJyLoFkVkM5186tvUTilVkY81z0PjxIjDqyGbNAmI4
   g==;
X-CSE-ConnectionGUID: LGiu0BtrRQCGVubRTaF3lA==
X-CSE-MsgGUID: TogTtmYgQfS91LXrvPj7Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74958676"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74958676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:33:29 -0700
X-CSE-ConnectionGUID: hIVJVRhvQ7eXwbe5d1OOYA==
X-CSE-MsgGUID: OIXU2zQWQ7SYgOU6xL0vgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226366222"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:33:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:33:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 04:33:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX5T1I7J4cr2spkCV7ShaU3vbzzq2tSLvqS97n6VixT/ATnsCrBWNDEFSpM7FBmX4uYhHB3L5oBiB4RHWuhDmbs4qG3vIE43xAyjq7SYW9WPtbSmV7DJTTnd9sDpPVDLSvpw34ebnPkPneG4UPM/I07ry1DJynoPrjM4I7jsghFlREC8dGzCJm6HNNl7/X4A3KwMUVX0dbOAqohCnqaJ50CY9hTuBPAk5D7xY4VtPDXU2yV5+6Ac3gHvuwJ8yBc46W41yK48FZR47u3nj7FFLufovuAF0bLdtFJyArl9O1Y1qT9SWKZh9cVqpp27pVU9YcLjVVLFMRxVIaifijoVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiQhMUw45Hk1hQxizz1Ua6dXVtF21cve6Qk8M9mUq8g=;
 b=U5OwPucwUhEHNzZZwI1q+Zd9VQABGZO43ydIVW+SXYgXJ4jbEKr2r3SPGTFf6GPVDxYVwZE7pC0QYyVHi0e/Nvyp856XD/d4u5h+J16Psb7vNgieKgvG500q858KR7gycLkdHDtueWJ1x1rAKQfemObXr5EzabDWEvWxOyNK0RzSlkwXV8M/XN5eznaMe1h+324JjrxcXaGAJFyFI/VoO/vbhAdmDc2fgEs8pdJeyiCwCq0DL20jNtiReOAIeEnxpdGB/+CXjWFaUJxweZmT+dXPVCLtC1gKl0US3XJjOV7ibJbuTxTa5EwxYe4oabnap+FOAfLgdtpiclx//d80vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB9160.namprd11.prod.outlook.com (2603:10b6:208:57a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 11:33:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:33:24 +0000
Message-ID: <1b7a6774-8842-4808-a61c-e3c0e4c38a3d@intel.com>
Date: Tue, 17 Mar 2026 13:33:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] mmc: sdhci-of-k1: add comprehensive SDR tuning
 support
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Anand Moon
	<linux.amoon@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-3-aefd3b7832df@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-3-aefd3b7832df@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0009.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::8) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddf58f2-6dcb-4a70-1287-08de8418ff7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xkOApqLgplPDJgk+Px6VqbWkeIIpAX7JG3++M6SwX8N/yjIlDDSgywM5mIZ8fYTFIXUU0d2hNxExXlM85HtvvH1euU+vFLNOej6jN69MjRiWbxUFNtvy53cbs1n/eVBx538Y76L8uymgI2bHBG705/KUCfP1IWOfzX94sO/xvdaP4i8+lBnvPAbxw/IF0DHSCsN9qWSKb45KdohfAX0I9VM7sbYNCzYvyr3lLocL7YPdcxfpKvAHf3YDWhGCXiZSl9qMrlbFpg2joX/BSHKaSZWv8xl11pcNBCAYBcObhBDiEkDxqfnc9Jen4idpPkEqLUrcG6CEhmkga4OVq3+cbHfITlUbQvyd6n1m8kcUHVczm995F23mDa5UlKTUzYvt1wsEi9UBGwv98XelYD4mMqHDOJ53JOJo4K7YOkhz5MrxSIX9Piz0TlcHyocp4fN0x1VeosEWvwdoNpRzQ1CYaner9VvS6AbprjxeZPM5OXPmBR5eQVrIdNZe9EG8dqnJg385hKmB7sSgNrQOwTPto1jkm26rFKkhqZlR2WGoGOPe7I9YBQQdeCe1DdTa5mO+hGHy839xe23fBhrw04hr6Jsyd3Ye53cQX8HDH5p+WjMx27W1VKToQDlJHUvb1onVkHvRFbU+Cj+9jixXXQQ9rEbpIaA+moCmqrB6yHjU/j8do+S7MCfH0ZZ//MED3k+IC93sUuCepHrVlQc4Z53+/JdMNqQQ/sP4qDDs94GHRPMltMTq3MRNAJRdw+bEWQS6bpnShnmK1N/73fACdLT93A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R094ODh5bGRkczZjczdwK01UQmJGS2xzNGVJeHdTWHFNb2R1SGp5dk9YTGlD?=
 =?utf-8?B?MjBGenU0bU01VDN0YndKRC9rdndPeFVDOVpMZ0NiRnM4NzcrVkFpblpPVi9G?=
 =?utf-8?B?ZmRRZS9TR0VYTXU4WkYzQnpvOXJVd3VZNTVScWJHQmNtOEFOU0lvNCtINzhU?=
 =?utf-8?B?aFJHN1l1WlBSZkVTOG5UUndKUFVqWHh3YVNINTdVU3VDNEpONVpuRnJYL29p?=
 =?utf-8?B?SzltNTFjR2NRWHhGazJDVmNWdUIzNWRHSmk2WFFKNUJtczQvbWVlczZsSUdB?=
 =?utf-8?B?RlZoQUdCenVTZzdGSEE5L2RDczh5d3ZxTWtvNWNUbGRmK1RRVnFPUUY0cUlX?=
 =?utf-8?B?RmZkSTh2QWt1NlFLUUU2cWxJc045K0hrLzVZeTdHTUNFMUxud29EcWlKalJF?=
 =?utf-8?B?TTZCRFd5aGl4bnVqVTE0WFh5L1pSNXAyMDVERlpLL21CTFJwSkdwUEhreHZR?=
 =?utf-8?B?cU9wVFdMQi9GMkMvdVRYWVM1SDRPNE5ZVFZtNGNVSHByUEZnZ0duMFpVUEtG?=
 =?utf-8?B?dVQyWEJXTTk1WkpnYW9Tc3lINzNmS0NqRDYzTVhjaHdRL0VYTDhtTlNHTXBr?=
 =?utf-8?B?YWlweFh4cGZhWHpGcFg1RlZBY3ErRU9SUGJtZjc0T1dmUW9SYkJ3M2oyQmRL?=
 =?utf-8?B?TndtWnA5RUlCcDFEZEN3bDRoamdORVpJdUUrL2Y0cmRRMW5KVnlGK2w0Y3JO?=
 =?utf-8?B?dUNhYmlaaVNRWklsMEd3a1RVK0VxcEliNS9qTXhGaHFRUGZMdGJQMjF6TXpx?=
 =?utf-8?B?Tm11MEpKZGZnelJXWHVRNlI5dStUQkZLRU9tanNyTkJjNlNRd2N3UU54MTFR?=
 =?utf-8?B?Y3V5S012RHVpSWkrUE8wdENsUGIyVFY3RnZ1aURYOU1PV2Frb28weHZ1d3Vq?=
 =?utf-8?B?R29rNXluaHFtdGZMYXZSd0p2REJqRjd2Z0RGNFd2UUVYQnFTQmFITWw4a2N1?=
 =?utf-8?B?L1RYUitwcHV4aS9aTDI2Yi9hSzJpcWZVR2V1Y2ZDbTNGU2lYeFQ3RHpBZWhV?=
 =?utf-8?B?WjFCV1oybFptbEhuRThRQUVWanZjcVBxaUhVMmJES0lrR2xEOHdWemdLK2hp?=
 =?utf-8?B?ZDJRU0RPM2FWTUdHNmZlREFVR0NiM1pna1ErR0F2cmdaK01LMGxxK2ZOUlBx?=
 =?utf-8?B?SC9iOXN5RzF4ZEgvdSt0c1pqL2F1cEZLR0RJcUIxZE1ZUyt6WkFjbHBIVFVh?=
 =?utf-8?B?SDlwZmoxOHgrcDFsTDJjdjdmTGVSQmNOOVR6bDl5RGFiNUpoNnhQb0lEQ25E?=
 =?utf-8?B?Mi9ZYlRTb2VPMlE3K2M3WlpLMDVJUGQ2TDBsamp1akZKL0VNeSs4VmJuZWxm?=
 =?utf-8?B?cm9TVkRPQncyTU9Yb3FzWXBhZGhmSTRyZkY2VUVZM2tKdUJHS3g0NFV2cUdH?=
 =?utf-8?B?WCtEVG9BVEQydjdlU280eGJoRWtnOTNpRlVzUS91QjEwZHZuMXNGYlREdmVK?=
 =?utf-8?B?dXNSVEd1ZDdHcFQxbnhGaWRkcFBic3NzUFo1QkFac0pGWCtqZko3OUFnN2hw?=
 =?utf-8?B?WFk1czBJNzlCZUZEdmM4TlVDb2hBeWNjcWJFMEdUeWcwWXU0YlYyb29KYWww?=
 =?utf-8?B?TzJxNlNiUUVSM3JnNzlWemhxWi9BZEpMM3R3T1dta1hwTU8vZEk1eERrMHBQ?=
 =?utf-8?B?UFl4WGQ5Vy9ZU1V1RDFseGoyb2p5bnpsclcyT0N6NVNnMWtoRHMwcTlGUThG?=
 =?utf-8?B?aGNyVmNac1BIV0c4Z2pGU1Q0WDJSUmZNSjhndWNLYXJqejZqNzI3ci90c0dN?=
 =?utf-8?B?d1l5WTN1TG9TMTVIU2JmTDgrUVhGdjdJNzhJNkI3VGNOMC9LL3NCRDdxb2s3?=
 =?utf-8?B?TDM4KzhrN3RaOWtKeWJkMkd0ckEwWnhuaVBBTnJqWHB4MnRQQmZPUEcvOGpJ?=
 =?utf-8?B?b3ZZWUFOM2tPcjV5SmdzTzhDWmxwT04xK1NWRDBiNzNydkFlQWtSalpZUHpT?=
 =?utf-8?B?dTVLMUtZVGp1bG1GWEhwZkhzNm9UWkoycVJ2Z0Fpekp0UmNRdmY2NjZkRVdi?=
 =?utf-8?B?T0JRcFhSRVVkZk4zWFZxanM2UHZ6MFNpTElnZTczcFRpMmJOU2Z5YjJFSU5E?=
 =?utf-8?B?Zk9hdDAwS1EybC9IV3M1S1hFM0EvQlhsQVd3WGVnei92N0tuaVBqZ2hlWTFY?=
 =?utf-8?B?QVMveHpKaHdmYjJZdmJEbTdRQklSZlpiY0RReEloU3gvN1hyWWJTTmRKdzdU?=
 =?utf-8?B?RXpLelcxZFk2bXE3UFdIUThRRm5rcm8rcHo3MjhZdEdvTjhSajliWFVKaVZQ?=
 =?utf-8?B?MUxJMFNXOExsaHc1a2RZM1BDZDhZMUYrVW5QRmxpRFNSbVg4WTFRcTg5RDNm?=
 =?utf-8?B?bjVpRDk0dWJ1bkY1TXI5Z0t6WW9EdE5JN1BrVXErTFRFMFdMenNUMkNZS0sv?=
 =?utf-8?Q?GK1DBy9g+9AypkyY=3D?=
X-Exchange-RoutingPolicyChecked: YHibpFHlaIDdK9YlyvP5qcZDGm1nWYgr0X26XyVY8sFNeVsBmwRyYHXj8ynJ1k9KYd7yuti9+HB+qm4Ns7XCGln4I896XuV5rn95LNh5vK//wfihTeQAsmK+4wmT4FXYu9nPqs7eH5dKQY4hqWMkF4/EDMmekrt4WFDOUj8vbjLxvjcExWv7ICJCq38cqASiC9BD0Tf0vTC6d+XKwwIkYf/ib8rkAG1JWV7dlYuZDY30qC6YW1oOo1Mi67lhAQh0ZiFXheisotNKRny3glFkHnHDOP9ilsu31+84X3bsZvzniLq62SM+NzkQNuTQbZ/RMRXiFysmROV7wO9/1aTl1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddf58f2-6dcb-4a70-1287-08de8418ff7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:33:24.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oENy/6PLqOBLWsMlVo/RQ88w8kGbpVm5+QokVRXou0czPWynDm/+vsoXALnWJiOyNciXS9i5QBwL3cbkzpn9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9160
X-OriginatorOrg: intel.com

On 16/03/2026 16:03, Iker Pedrosa wrote:
> Implement software tuning algorithm to enable UHS-I SDR modes for SD
> card operation and HS200 mode for eMMC. This adds both TX and RX delay
> line tuning based on the SpacemiT K1 controller capabilities.
> 
> Algorithm features:
> - Add tuning register definitions (RX_CFG, DLINE_CTRL, DLINE_CFG)
> - Conditional tuning: only for high-speed modes (≥100MHz)
> - TX tuning: configure transmit delay line with optimal values
>   (dline_reg=0, delaycode=127) to ensure optimal signal output timing
> - RX tuning: single-pass window detection algorithm testing full
>   delay range (0-255) to find optimal receive timing window
> - Retry mechanism: multiple fallback delays within optimal window
>   for improved reliability
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-k1.c | 172 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 01afdadcf70796704b272ee5a31543afd5e01188..83d7f9fad5c1fba2f07624ee657cd979a1c7e25d 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -69,6 +69,28 @@
>  #define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
>  #define  SDHC_RX_BIAS_CTRL		BIT(5)
>  
> +#define SPACEMIT_SDHC_RX_CFG_REG        0x118
> +#define  SDHC_RX_SDCLK_SEL0_MASK        GENMASK(1, 0)
> +#define  SDHC_RX_SDCLK_SEL1_MASK        GENMASK(3, 2)
> +#define  SDHC_RX_SDCLK_SEL1             FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)
> +
> +#define SPACEMIT_SDHC_DLINE_CTRL_REG    0x130
> +#define  SDHC_DLINE_PU                  BIT(0)
> +#define  SDHC_RX_DLINE_CODE_MASK        GENMASK(23, 16)
> +#define  SDHC_TX_DLINE_CODE_MASK        GENMASK(31, 24)
> +
> +#define SPACEMIT_SDHC_DLINE_CFG_REG     0x134
> +#define  SDHC_RX_DLINE_REG_MASK         GENMASK(7, 0)
> +#define  SDHC_RX_DLINE_GAIN             BIT(8)
> +#define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
> +
> +#define SPACEMIT_RX_DLINE_REG		9
> +#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
> +#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
> +
> +#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
> +#define SPACEMIT_TX_TUNING_DELAYCODE	127
> +
>  struct spacemit_sdhci_host {
>  	struct clk *clk_core;
>  	struct clk *clk_io;
> @@ -96,6 +118,50 @@ static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u
>  	sdhci_writel(host, val, reg);
>  }
>  
> +static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_CODE_MASK,
> +				  FIELD_PREP(SDHC_RX_DLINE_CODE_MASK, delay),
> +				  SPACEMIT_SDHC_DLINE_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_CODE_MASK,
> +				  FIELD_PREP(SDHC_TX_DLINE_CODE_MASK, delay),
> +				  SPACEMIT_SDHC_DLINE_CTRL_REG);
> +}
> +
> +static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host, u8 dline_reg)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_REG_MASK,
> +				  FIELD_PREP(SDHC_TX_DLINE_REG_MASK, dline_reg),
> +				  SPACEMIT_SDHC_DLINE_CFG_REG);
> +}
> +
> +static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
> +{
> +	spacemit_sdhci_setbits(host, SDHC_TX_MUX_SEL, SPACEMIT_SDHC_TX_CFG_REG);
> +	spacemit_sdhci_setbits(host, SDHC_DLINE_PU, SPACEMIT_SDHC_DLINE_CTRL_REG);
> +	udelay(5);
> +}
> +
> +static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
> +{
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_REG_MASK,
> +				  FIELD_PREP(SDHC_RX_DLINE_REG_MASK, SPACEMIT_RX_DLINE_REG),
> +				  SPACEMIT_SDHC_DLINE_CFG_REG);
> +
> +	spacemit_sdhci_setbits(host, SDHC_DLINE_PU, SPACEMIT_SDHC_DLINE_CTRL_REG);
> +	udelay(5);
> +
> +	spacemit_sdhci_clrsetbits(host, SDHC_RX_SDCLK_SEL1_MASK, SDHC_RX_SDCLK_SEL1,
> +				  SPACEMIT_SDHC_RX_CFG_REG);
> +
> +	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200)
> +		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO, SPACEMIT_SDHC_PHY_FUNC_REG);
> +}
> +
>  static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	sdhci_reset(host, mask);
> @@ -191,6 +257,111 @@ static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
>  	return clk_get_rate(pltfm_host->clk);
>  }
>  
> +static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int current_len = 0, current_start = 0;
> +	int max_pass_len = 0, max_pass_start = 0;
> +	struct mmc_host *mmc = host->mmc;
> +	struct mmc_ios ios = mmc->ios;
> +	u8 final_delay;
> +	int ret = 0;
> +	int i;
> +
> +	/*
> +	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
> +	 * if clock frequency is greater than 100MHz in these modes.
> +	 */
> +	if (host->clock < 100 * 1000 * 1000 ||
> +	    !(ios.timing == MMC_TIMING_MMC_HS200 ||
> +	      ios.timing == MMC_TIMING_UHS_SDR50 ||
> +	      ios.timing == MMC_TIMING_UHS_SDR104))
> +		return 0;
> +
> +	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
> +		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
> +		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
> +		spacemit_sdhci_tx_tuning_prepare(host);
> +
> +		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=%d, delaycode=%d\n",
> +			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
> +	}
> +
> +	spacemit_sdhci_prepare_tuning(host);
> +
> +	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX; i++) {
> +		spacemit_sdhci_set_rx_delay(host, i);
> +		ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +
> +		dev_dbg(mmc_dev(host->mmc), "RX delay %d: %s\n",
> +			i, ret == 0 ? "pass" : "fail");
> +
> +		if (ret == 0) {
> +			/* Test passed - extend current window */
> +			if (current_len == 0)
> +				current_start = i;
> +			current_len++;
> +		} else {
> +			/* Test failed - check if current window is best so far */
> +			if (current_len > max_pass_len) {
> +				max_pass_len = current_len;
> +				max_pass_start = current_start;
> +			}
> +			current_len = 0;
> +		}
> +	}
> +
> +	if (current_len > max_pass_len) {
> +		max_pass_len = current_len;
> +		max_pass_start = current_start;
> +	}
> +
> +	if (max_pass_len < 3) {
> +		dev_err(mmc_dev(host->mmc), "Tuning failed: no stable window found\n");
> +		return -EIO;
> +	}
> +
> +	final_delay = max_pass_start + max_pass_len / 2;
> +	spacemit_sdhci_set_rx_delay(host, final_delay);
> +	ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +	if (ret) {
> +		u8 retry_delays[] = {
> +			max_pass_start + max_pass_len / 4,
> +			max_pass_start + (3 * max_pass_len) / 4,
> +			max_pass_start,
> +			max_pass_start + max_pass_len - 1
> +		};
> +		int retry_count = ARRAY_SIZE(retry_delays);
> +
> +		dev_warn(mmc_dev(mmc), "Primary delay %d failed, trying alternatives\n",
> +			 final_delay);
> +
> +		for (i = 0; i < retry_count; i++) {
> +			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
> +			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
> +				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
> +				ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +				if (!ret) {
> +					final_delay = retry_delays[i];
> +					dev_info(mmc_dev(mmc), "Retry successful with delay %d\n",
> +						 final_delay);
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (ret) {
> +			dev_err(mmc_dev(mmc), "All retry attempts failed\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	dev_dbg(mmc_dev(host->mmc),
> +		"Tuning successful: window %d-%d, using delay %d\n",
> +		max_pass_start, max_pass_start + max_pass_len - 1, final_delay);
> +
> +	return 0;
> +}
> +
>  static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -314,6 +485,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
>  	.set_clock		= spacemit_sdhci_set_clock,
>  	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
>  	.voltage_switch         = spacemit_sdhci_voltage_switch,
> +	.platform_execute_tuning = spacemit_sdhci_execute_tuning,
>  };
>  
>  static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> 

