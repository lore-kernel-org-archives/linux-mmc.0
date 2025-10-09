Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2C1FBCA1;
	Thu,  9 Oct 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000446; cv=fail; b=IX80fSAKDBdgsnCFIZOofAMjlJeY5gSKTlSAtQrPHXLAsndGezLWf5+IbzjsE6RA9F5Gd7TNcvULl9OqwDkJiMrUAMPFMkhNUhUDLKjBY7IqnFo+LsMNRP94wSSBar8mYX4ThgXOZfkrwfVjyVTdNvaAlbteEIwO68V41qysmGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000446; c=relaxed/simple;
	bh=KKeekC/POkQBdDOLiHIfEeA2wC6pYVXBOMsj13rFeKM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1G/qfIuxf0dMqFGUmQCUt8lFIvnMZEssDHohKfg2p5gdPYeccyZ/CeS59krpHYhEv3ArSlep1IG25sVmYhG8DE/+vJ+PsQFRIW5a5p+QVk73fDlNtLiUfeEcJ82EmKRV6t2TPVRz4vB8HgRU03OsqCpouk8bpL9ek9Xsm9dxM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sm7oJZCZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sm7oJZCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760000446; x=1791536446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKeekC/POkQBdDOLiHIfEeA2wC6pYVXBOMsj13rFeKM=;
  b=Sm7oJZCZvXa+jJOxSWZSxGR8Otv5fTHWAf466Nng6kIh/eok86uFYSCe
   FhxGm0YbCGz0WH+dvryIGhvCTLHum4260jhZ2bepANjBfH7y3Xtei1sAZ
   F5xovVdUrIpIhQ0W/kwJBfNccuZWiHMzEvapUkjw3X0/C4bAKv+iIzQAU
   4K+2G78K/pW2EZlOy2a7WnxyLvCpJ+pCFHJ0NYRGjA4oozli76SImVeci
   YIJ44bmTII7bOStPvkplMiBx0Vg1ksfjDIbBZ3AxL7AbDMj/sccV6TYgF
   ryh+NNsI0pgG21UcmeEE3OZbU8L/APXIyeGbixEbR4+81Ka1RjOz8tPRg
   g==;
X-CSE-ConnectionGUID: lVD2JNV2TayOQMWGAj7AUw==
X-CSE-MsgGUID: fZ9Zrv6ARnKUC/XVw7GfFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="79849114"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="79849114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:00:45 -0700
X-CSE-ConnectionGUID: 1d0ej6NYSMa6kPX1XU0ZzQ==
X-CSE-MsgGUID: 5NsIosNwSIGRHwJW/XJDcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="185952523"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:00:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 02:00:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 02:00:43 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 02:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9t0SHVNkeQM4zGY1a4V8q0G6amiNpW+rVOpXpdp0RpEkNBN9uZdLTw2F6pr2T6A91xSyCvz+EX/5Hi8rn0MTylAPsAOFTCV2wfXINVZt83r1r+woKmyTrDNQW+EY3QOFIFuanPVzPxp1Of0erUhO0GdHPPasuLn6szCFTE4uiHY1ZblfjQRv9LHTrviSWS3QmJAk644sIOPqYyGBgnEHnVb/oZ8vyQBHk4F6qi4nbWiRIooOBcqJ4iZgp63Y31ffEYEE5kJNGAE04+R0rTP31zM8oUHFK4SB+xxkATnnXV1gEUy7Vixa+xdBsWHN1e/NVztyhlnXR0mLsUPf6Gkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZZfHvV/jBtRNsQlgOsMcCjuaZhWNjUd/DQcyhTgEjU=;
 b=dNGNFbYFgMskjP//Jn31iUB+xu+3K/Pa40TK2kqx0Tc3ETo/Zlr2DaTMJcJMP3V0GsBoTJezyTalsku7+tOvXydSRoWdx3tf3xwJqrlI6mM3UTdLHwkZvhGQnJlz66zgDQSk9jHOdW5jUIRFWDLi7gmJlzQKQKJ6aqQMM+IYHgdPD0/qmRbWAv3Q1Blj2SKaHCThatrsDSJt0G9j/oKvHq3ZYoQf7q0xRYDUCIxS/a3Z3ByT71U0tAuVD8mX1ZYWx4GQlaQWxh/j1LX4tr409U62yz3xQnIdLmOQSTay39Isl6n/3W7KBh33lDsY9Ht0cMHjf8uV+OEd3T9YpfuPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:00:41 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 09:00:41 +0000
Message-ID: <d6ff4cd0-cd8a-4967-ae57-6de607e86f16@intel.com>
Date: Thu, 9 Oct 2025 12:00:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mmc: sdhci-brcmstb: Add BCM74371 support
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
 <20251007140434.606051-5-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251007140434.606051-5-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|SJ2PR11MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: d04b52c0-c67c-4d02-342b-08de0712528e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0dMMzQ1dGkva2U4QnZWWTdPTm1QZEY3bVpuZVd1ZldGSVVKdmJKcUJUc2ph?=
 =?utf-8?B?MlVIcHpMdDE0aE1vTFRKWlowbjVldW1RbGNmK0FVTlgvZzJBK0lTOWxIV1Rx?=
 =?utf-8?B?RHZiU0hkNzZ1Z203RXpBOHN1aS9pL2RmZlNpaTBMVnlaLzdENnRuZ3hKOWox?=
 =?utf-8?B?aUNQZ3NWVTdybjJLbTJCelFoZmN5bjNMNmJQdkFCSUlmNjE1UlkyZEVkVVlQ?=
 =?utf-8?B?OUFiZ2hHUmszWDNSUWNhY2h6ZmdzRkw4L05hRzRWZVFnSFpSVjFtYXJldGRl?=
 =?utf-8?B?WEt0WXNHVzAraUFESnVNTXhTbm1ldVplRExyZFJhc3N6dWlhVFFRK091djNZ?=
 =?utf-8?B?RTBQaTZ5S0g1QTdWT29lSC9jK2NyRHVZaGdzOHI2c1ZCVWd0SFU0YUJaTE1E?=
 =?utf-8?B?VjhpcjFrYTZIc3BmWXdLL3JodkRhWU1SelozdCs0LzVXMm9sWTl2aGZVdjlW?=
 =?utf-8?B?Wnl1cjJnRzRRclpKTHh5amEvRmREYVlhcmkzeVgwczdJUmd5SXBBTTJNK2lI?=
 =?utf-8?B?cGFLNFJCTXhMLzZFa3YrVmxaU0lsVFM1M3d3dWw4eFIxRUwrOFpIdGRmaW5L?=
 =?utf-8?B?UGpGL1BlTG5ZczJxUEEzbVF6dThFV3d6NThTUW0vbWRzUDlCekJQN1dOVnVL?=
 =?utf-8?B?SFUyQitKYmZjNVBuN0E5WG9xMS9KeGNxaFVubEl3SkNlVjdaMXA4YnkvWEp1?=
 =?utf-8?B?RlNCbWpzcS9NRmZidDFsVDdvL29QdFNJdDQ1em5naWZGSFNwWVNJaGFvcUFh?=
 =?utf-8?B?NTlEZFR2SWUyVnk2djhNUXJYcURWTmpVbHRmRFd3c1pXVW43eHNoalQ1RTNo?=
 =?utf-8?B?VTY1V3pNTnVVVWZEZWxuclpybHNobW5VRi9iWGtuWjlFRVY0Z3VEc3daTUlH?=
 =?utf-8?B?UmpMall4KzlURmtDTHQ1WDB1MmQ5MURRNlRMQ1ZTUnJMQ1pZaHBhYS8zdnBK?=
 =?utf-8?B?OURka0c1NzA4cUVMWVZ4L09IUXpOZUVlRjdYU2RBcmJYSWwyM1Qwclp5Z2tl?=
 =?utf-8?B?cUZmZVBKRzYrWnRBMDE1dzdOK3VYQ29UYlN4TTZFV1ZERzZzWnNacG5ONTcx?=
 =?utf-8?B?LzhMd0RCZlpndEY2dS9vT3JwSlFVYU5JV2Nqc0JFaDRjV0hidEs5ZDRQeHlE?=
 =?utf-8?B?a2pnNjhNNjNNNGZHYk5acGp5eVRwejV0UzZHNEVHTllsdlp5UE13bjM2elNw?=
 =?utf-8?B?ZG9VTW55eW1XaS9DTEFlVW8yd05Pd3VPSVFhL2ZLN1I2dDVxMmpvM2QrdDk1?=
 =?utf-8?B?YmxpRy9SeTZMVGozT0ZFTUFLMHdyOE82UmxtUVMrZjNjWERWR0I5dm1sZEpM?=
 =?utf-8?B?Um9KVVVNTVRRM21ZeVBFOGhjd3ZUNWZUSVdhWjlaT2NESllKL20yUklpVWo0?=
 =?utf-8?B?elFublhEKy9WNWtrZVhOYW5KR0pPVEJTRjg2NGlXUXVXZ2wzY01pdjgvL1pY?=
 =?utf-8?B?cHk2b0RhTUdDaURQMGNEVGQyM3BWWmYxSUpaZnAyMkVPU216U0ljL2c0QXBF?=
 =?utf-8?B?VlB6QnRKVzRmSHFZaEQ3enJyT0ZxcTRCRHJKQlZ1UXBZSWFTMnRFRkx6QzRW?=
 =?utf-8?B?OVFmNnYyUksySS91ZnAzcTRreUI2ZUI3WFB2UG1kUGNWcWdadHZjNWJmcGZ5?=
 =?utf-8?B?ajY4Rkp3dkdtSEpPR3RwN2RqbjJabU93MURQT09EcWJqNVlEVWRuMGJHNGFO?=
 =?utf-8?B?YnNBVGlOTWhnOG1DQUdaWiszVGxPcERNNlZhQzZ3ekhveEU1SWhQbmtSTnd2?=
 =?utf-8?B?QW5Sc1paU0krRnRocEgzV245QW5GcU9ZY014bWVzQVkwZnBPTStWSUZnSVlS?=
 =?utf-8?B?Vm9TMnNOZnlGK3JENitMajd5OTBLbVJwREwrcnBUT08rcVk1bC9NWVJmR2hj?=
 =?utf-8?B?MUhlT3Y3TXVWV0QwdktwYW5JTVpxSkFKRVM4ekFtOTdKSUVXNUxXUThjbXRa?=
 =?utf-8?Q?RnjlG8xta+czQWLBJhrWrYjwnps1KcMT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2loM1hzY3lkcWdnSjBvUHpUN2lXcXFnSWdmdktScEtMZUlDUTNpZzRoZGh2?=
 =?utf-8?B?cC9FR3hWdzg3MVR6ck1DVDd2Y3hGVWNMaWJlclE2Wk1NRERXOSt1eEUxUmRR?=
 =?utf-8?B?aHJ5MGxwM0ljQWNDT1FOT09Ocno0UjBGcmFjdnh1MVdmQWduQzFrVG5QT1dp?=
 =?utf-8?B?MDJKdXFoN3hCRGFtejllWGhZNDBQcklid3o5dGR1cTc2Qk5XTFYrc1JCSjVn?=
 =?utf-8?B?cm5PckpWN0R1KzhnU29JR2xZejZGRGNJQjUyUXFGYW9qRkhjeUt3VzhNYUNE?=
 =?utf-8?B?WTIxYnp2VWZidERKZDVuV1BxTkIvaExLbEtpd3NWbXlQRk1Fa2VLc0dFWkZJ?=
 =?utf-8?B?MVNzNHlLaFBwc1U0Ti91dHZuRk1EMVFJUjFtSWdleW9oQXVpRjJDbTJuTkhU?=
 =?utf-8?B?cjZrM0hvdWxrcExVN1pwVUJhYmhWWmZ6OGVCQnRJUG1rY0VjZWRiUGFkK0tj?=
 =?utf-8?B?bDMxMk0rYjBpU1cvZXRvNFVCaEUvaGlvM1JMTy8xKzFnekZNaXVscGZrUHVR?=
 =?utf-8?B?S2ZyQ3ZOOXY2RDQrdEJwZy9MV3UxeWdseGp3ai9MM0JhcUZCRWZEaEUvTVlW?=
 =?utf-8?B?ZmhRcEhtSFJqYVd5cVJZRnV1ZkhjQ1lscDhkQXlnblRXWS9aOVdsbE5aTGlY?=
 =?utf-8?B?RTJzQWY2Ujk2T01vQ1lidkVJS3N3V0ZyVDNSV2Y3cDdiNHFxTW5TcExmejZv?=
 =?utf-8?B?SHpEZ3U5aC9ER2ZVMmhvcnlDQW10UWpNRUd4dzlZVEZiZjVIVGo0cTg2cUgx?=
 =?utf-8?B?MjNocWpKc2ZZVkZYcmFCcFhQdnljb0psQ3NPN1BVQjJtWE1BTzVBUk84ZU9L?=
 =?utf-8?B?K1VJenJRYUtONllLaUJVSFZ5ZU1WME5rd1l1WTgwakpidnQzdTFVU3NSWVBM?=
 =?utf-8?B?NVBVYmUzRzlwbzlyeFFxWmsxR1p3WHVva014NGs1S2hsRjhuTDhiYmo4bzdt?=
 =?utf-8?B?OFUvRkQ5SGlIVHZMenNNMjZlOXI3N0hwNDVBZXFnQnpOVGNkU0h5NUc0Vm9i?=
 =?utf-8?B?ajhvOUNOYnhWeFZLM2xVcitYeW9lYjEycUVOcThwOW5GdUFuVkFtRGFSR2xN?=
 =?utf-8?B?bXEzU1I3WUdQbFI4b2RTWjhRcjJJMXovdGlwSzdrNWd3a0RVWTZYRG5obmRF?=
 =?utf-8?B?T00vWUwwUllBNzJ5b2ljNEVOTjdLR3RwZG9SKzJoR2tvS3BieENFRDVXS0Rq?=
 =?utf-8?B?citCUDNTRW1XSy9QWjI5cnAxbmorUlJqaGgwY3o1d2Q1Nm1IbVpWSmlFaFh0?=
 =?utf-8?B?RjdqTFh4WWpRdnN0ZlJJU0picXY3VlFwRWlwZEYxUzU5QlZ1REdsRGpTSTB0?=
 =?utf-8?B?bFdCYUFNRkNXWWhUL1dTeHkxWC9xVk5OalFQeE1BUGJUb3EyWUUzYk1pSGtr?=
 =?utf-8?B?cXVta2c1Y0E2TldURlZaUHE1ME5nbmN0TEZjRlV4ZzNiK1pYdVdsUG9FcXNl?=
 =?utf-8?B?RU1ZNHpwVEo3TFE5YUJEdVRrMFNZSXFsR0ViNlNCbUY1YlRiT2JVKzZJdEdp?=
 =?utf-8?B?TEZFOHprTG9vOTFFN3B5bVhHRzBoZEhnWUlROEMvVExnZzZNa2tMRDFNWStl?=
 =?utf-8?B?NHpTY080czBtTDFHZ2VDeEl5QkRJL0VOaHYrSGFqTHdwb3pxcEwzQ1l3NWRl?=
 =?utf-8?B?bmdhOG1aZWMzdDBOVmVuelhDN0UyZDhJY2NOU0lBcXVTQ05nNnZYWmRXMWJl?=
 =?utf-8?B?T1luMmw2aHRPQWhxVTFlQlNhMCtRYjN0YVFCVnFLSHI3eUJDUDFtVXBsalBU?=
 =?utf-8?B?REExQlpJdFJsVzE2dStIUklEQ3o3SjdYdUVwZ3hzb1RSL0k2WlZwWUp4RmVs?=
 =?utf-8?B?elBpUlVkQk4wakNwY1FmMUZhaE5BZXNHVDh3dVRSdVJncFZNOTZhQ29GR1dD?=
 =?utf-8?B?SGpsSkk1a1VIdksrRTlHd1BmalV5UHNyUU1mSDNaZWJsZSt0MmlkOXpkWitN?=
 =?utf-8?B?OGhqQjIxSTdpcHJPb1gyLzlrQnYyVGRObGRSSG9DdTBZRjF3Wmc0MDJrb2pt?=
 =?utf-8?B?Q2ZKdklTbFhHL2JXeFlxYXdtK24zRGdUNnlxNVc3UGNJVmlweUlZZXN6MGxC?=
 =?utf-8?B?Rmc5TnRJQ1BudWt4RHJLbVR6NUNkMHZxL09MV1RHR3hneWE4ZFJ3UGNwbXo4?=
 =?utf-8?B?Y3RzOUNNSjJpUCtzY29lYlA4c1hpNnUwWDl1R1d0WE1wTVE2UHZqZUk5WWdn?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b52c0-c67c-4d02-342b-08de0712528e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:00:41.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLAYsl6KDNHMlwZlQWW3tnMUfXLClgnhSmwBcsaOL8J4FTlCpEJwhEM7SWMkRVKCKmmw3D5GoIKwDPcYUv+gCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

On 07/10/2025 17:04, Kamal Dasu wrote:
> Added "brcm,bcm74371-sdhci" compatibility to the controller driver.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index d25bf71d79f4..42709ca8111d 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -299,6 +299,11 @@ static struct brcmstb_match_priv match_priv_7425 = {
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
> +static struct brcmstb_match_priv match_priv_74371 = {
> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.ops = &sdhci_brcmstb_ops,
> +};
> +
>  static struct brcmstb_match_priv match_priv_7445 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>  	.ops = &sdhci_brcmstb_ops,
> @@ -324,6 +329,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
>  	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
> +	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },
>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>  	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },

