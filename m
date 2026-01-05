Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9C33C18D;
	Mon,  5 Jan 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616290; cv=fail; b=MzLenBhJEEsFU7u9an6sjewePtiM3DZHsI2tjTe+ImiPJi/J5pOuoWJFjIZtn4YPx5K2ktkNjNBqn0E41wLqR5wQN75Z9aDEOL0m9VHmkjGmnpaz9AzttR8YPDiM/S/3pr3M5QknN/4+zAYkCQURWVRnhfj3j2uqoJeKKYPBTRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616290; c=relaxed/simple;
	bh=oC8N5QIaCkYJNwHCUjFaZlgZKyTgUbB6+YUqEMw/Rk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyjzQPz47O1ouPOXvXLu36sjUxpj0yV0uThZXjmGHT9RR4KF5ALvVEpLbUIaEeu8pHTZQIhz0BFEYpp/MbOIxrAvrLWkAQ7ntvZ9hGZtOMx5gAjBRt5fT1jcdgS0Ug49Pg4M2CmDRWhyjC0cbKqnlCGL4kCa5vdACHWngtXnP4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dR5X6wLe; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dR5X6wLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767616287; x=1799152287;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oC8N5QIaCkYJNwHCUjFaZlgZKyTgUbB6+YUqEMw/Rk4=;
  b=dR5X6wLeYcfHQFAafaH8KtVJEuFOoapbDs9cjob5p2wvMJWckOhvonuZ
   Ifz7ZiiieQmH0pHb0TKpjg4MBQgGZETLVNUVm0MuXAXkRhushfRSUWqbW
   nMbbH3VzRXZLTYVZqNq4ZLe/dJvukA+fn5I2NgHfbSL5nB6BhrLv/i8aF
   XTaFXmU79nOEnPpBlxklHOO8hfZbIVaeDTYN66nmzzKMoYJdoRAxD60Xu
   HLNHVE96T3/GbyLrRBz/1QsiiUbd4UP0c9FS64+p9GgMG27qOXHXHfiyw
   VC8KHnsSCgVkTYYyC680xNgwtWilEw9lAErNO1ptRfbD/ZSOZMPgi16jR
   A==;
X-CSE-ConnectionGUID: eNWW4Gi/RaObTklAJFjFtw==
X-CSE-MsgGUID: 0UFwRjwHTUWFU7m3+6bSBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="69053005"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="69053005"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 04:31:25 -0800
X-CSE-ConnectionGUID: Pe8UcyPqS3Gt9ABnvh9vLA==
X-CSE-MsgGUID: SJfn5pmdRFe3OYeJtVi47g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="206867775"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 04:31:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 04:31:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 04:31:23 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 04:31:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWey9uttVWPKtN/UEKxLLHC1hyeJNe1yd+PEUabBVMXzQ/le2dWxtQdCnUWSMmyRyIzYd6PeAqba574F1yo/VvYtaenUEeZqmoHPjYupT1p99afJ+RcwRe8nYppunHDHdf4VpQrJG/rjCigBN5gGBO6TKhFytVjLXeMlW9gfEFjfwROZa3MKfu1kBVhAL5Gc1TTNHjL9ul+g/zgd+4VaObO95Xp0L1IOLqycsZyY8KaQgzR6QechCB+1KDlivDl9r4ZIemu6hjktipc+59E1BiUBExgXGgt4/fVlm3T8YZveBY8j101jO0lERwWSru/aoGgMNP9kcwwLyZtfX+5LGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7welZBmpwHno2OKk60VcgKYs1NaC4cgeMcHq+rzduTg=;
 b=sx4zYj7YiMfwAPeYelKgharQhID4gfcrErnMI2P+L1jsKNfVqijYZz/0SYb0fwhFUqaBY5G9HU5TWcl8UUBtA8Wy2p5lMfj3UHnyGaowKpZ+eI8tyKjgvSzUpXThGIEW/BvWmX4HihLG6sozGFChqs6YNTDT7QSjY6P4U843upMjApQdHh0EzMH6O5SHFXCHgduZPoSmraaRfbc2Isnocy2vsvRpCRyyKIIy53T/OL+dd62tabyBnRCRJ7JV9qQmyow6+gLTHCbqsfnxP1NNzE1zfqOkXLUR7QRXqW/Rm9uOTRbbX96SXMgoq7Ln8r7N4lM2fETJdezROJu9C4NnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:31:21 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:31:21 +0000
Message-ID: <f91584df-eee3-4c26-b1da-a8049a4d77bd@intel.com>
Date: Mon, 5 Jan 2026 14:31:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is
 enabled
To: Ulf Hansson <ulf.hansson@linaro.org>, Tabby Kitten
	<nyanpasu256@gmail.com>, <ricky_wu@realtek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
 <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
 <CAL57YxZagMaZF1X1bpx-nB76s=vZMWhUDiVbvB9P3CLiXG-qHQ@mail.gmail.com>
 <CAPDyKFpRi8u3MPauT1hnYC1pW7L4kAohAZDsgS2pgQ=4_sjgNA@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFpRi8u3MPauT1hnYC1pW7L4kAohAZDsgS2pgQ=4_sjgNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM3PPF341F90799:EE_
X-MS-Office365-Filtering-Correlation-Id: 152a324d-3273-42be-f046-08de4c5654e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFaRWV3YktCYStEdC8yTVd4ZnhYSEdyV0NScWhvZlFOeGJyUmlEaS95SnNs?=
 =?utf-8?B?SVlPdElTd2FRTEVldGdFTWY1cjBJTGY3b2dxRVJnamhldHNuSXVMb0RPeFd3?=
 =?utf-8?B?Z0tRSWFtbXRYRG9FZldhTjBpaDVYUnV1VzRkTnR5Wk94bmhJbmhBcnVSTXhp?=
 =?utf-8?B?SGp2WW5zblk3bDZ5K3hhemc0bFphc0MyNSszL3BaMExxL3BUWlJVdUoya3Ba?=
 =?utf-8?B?QlVmK3FybVVUdVltcHRlNVBPeFpnM0taYWx6MktnUmh3ZkdtNHVnR0htZzQx?=
 =?utf-8?B?YTFWdTVxWHFrUnBRRzNNZzVqeXBVSUpOK1N4V1VJSmtVdjVOUG5DdUZtdUNw?=
 =?utf-8?B?a1dsbUtDeVVCbVl6QWlnK1NoajJSUVVpWG9PbFA5QS9EemFUSGpoZWtsZnJw?=
 =?utf-8?B?UFE0OFRPanNvWDRYVkI4YWdUb090azRIb0t4NVlCc2VSalg2OU4zcCtPOW5u?=
 =?utf-8?B?WmJ6dzB5cWxCNksvWmpVa2VkMTJ0eTdjTUlwamx4WmxkSlBGN0pZY2JQYjNV?=
 =?utf-8?B?OEhab2ZYMDFZSEtXZ1RyMnNkSVRGTlI0V29CSm1vSVMzaGxFMUl4Sm1TSHRh?=
 =?utf-8?B?U1FyVnl2N29ENE15MWw1L1dRbkJHcjZWU0crQVBqd2ZkZ240NG5ZdnRuc1Vl?=
 =?utf-8?B?Q3FKdEdObElaMnB4Y2NEZHZFSnhvOVBJbEJtWXc1MTNKeEh4OE5JbUZWYXZX?=
 =?utf-8?B?cENwOHJXWVVXZzlidkVDWFdKYTJORzMxVW1aSVY1ZGMrSkxLNk1aWFhaYWk5?=
 =?utf-8?B?dzF0amg4OFBXdGFHZ1Y2ZmpveUJyeHd2Nm1qeVRRcnM1QVRCZGp6ZXRhdFI2?=
 =?utf-8?B?a1JMY2ZaZjJCZ2xiT1VlVTBzUGpSNHZCWU9nUTRxZG1NdFNPSUtDS21xTFpL?=
 =?utf-8?B?YWpCYkJRU1REVFFRS2JXcDlKTldNUUQ5OVdFSjJ3T3J0dWN2T1U2U1FSTWtX?=
 =?utf-8?B?NUtRczNZenB4Qy9ZQTYxM0tsV3lGU2JMS2hHSVhVT2RJMU1leC9IN2RRTCt3?=
 =?utf-8?B?QUJuYXVNZGFvTnlFNzRPZWkwS3o4RUZUZERyMkU4KzJzcHE0YktjQVZ2bjJ3?=
 =?utf-8?B?eE44UmtRQ3JMV0JBRFFoQ0RKS0dLT3BpZmd1TTQ0OWlpbWtKWFVxbUdVVTl3?=
 =?utf-8?B?TlFhUFpYbjZvdHNDYUZQMFlZTmpPMWJ5RG1vRzcvbTI2SnpDNGsvbUVQR2xC?=
 =?utf-8?B?c0N5WlArY2RpeWVwMTNWODVSYkZIUVFnUGQrd2Y3dVZ2bytlVTlhVHdlT3FC?=
 =?utf-8?B?aHlGU2ovTHVCdU9CMHRUZmZkN1pBQ3dlVHhaaDh5SWR4cklyUUdXOHFQZzJT?=
 =?utf-8?B?UHBnVlVacENwZmk4UjdHcktWYzUzS2xuTDM2aDF2algzZmVpMnhtU1crNXd3?=
 =?utf-8?B?SDVzYWRQcXIrVWd3TWc3VDE3RENzZGNhQ3FjMVI3a3JuNDBPYWFNMU8xWGVi?=
 =?utf-8?B?ejJ5cDRxazludW1uNFF6MDdKMCtPeUhodEJ5cDNaS28yWHNuclhmS2xxekZB?=
 =?utf-8?B?RS9PTzZ6WDc2eVFGTFVZVzFYN3cwVWJVSGoxb2ZSWE1LNlNGdlhSblFkU0t2?=
 =?utf-8?B?b0lOL0NOMGVNZFpScGgvQkpEYjZuL3NiVVFlcXYrNG90czRKaGxEcmVMZ1BB?=
 =?utf-8?B?WnZpdDhLaFJRWmVuZUtFOGlOS2hlWXIwSGRSRWE5NWJhNnpyRFJKZk02UHFw?=
 =?utf-8?B?OHU2Y1I5c1YzRTJKK3RRQmZucWNCeFk2WVpSNmVTd0NlbkkxQmVZTmZrcFBp?=
 =?utf-8?B?YU9sbXFSemx2SU56Z21QeGxFZVNZdkc5THBKajNWMkliQjByOThRYkJzZ09z?=
 =?utf-8?B?VHRVVEFoVXU0N2NZb29lNXZPNjdOK1RieEhBYWhVMmtKbXJKSGlISWxJSWFT?=
 =?utf-8?B?K3g2QTZrL3V3dTlkSUhnblR0dmVXYm10RWZhTEVBa005OXRmSGR2cGdFWWVH?=
 =?utf-8?B?Qi9lY0c2K2h6NS82VXNFK1E4S0ROdU9odjVZeEUvWk1vSlhiajZpaVdsYVVv?=
 =?utf-8?B?Y0pSWTlzRU1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBiV1V0MlZoZHY0eFdmWHRmWk0wUmIyaEVuNWcvYjZKQjhmeXpoUnRkQUpH?=
 =?utf-8?B?VWJTdmxFVDZkSGV3NzBEUVBrdXZxcUJDcUNsZzRJYjIrekFoWkhYUldHQ1Ir?=
 =?utf-8?B?cVdUallJclRYZngzTGptaENBNDZOYVZDc2dSR3dhM25EcC9KWVdWMmNYR1B2?=
 =?utf-8?B?L2N4QjhkQ1ZRbHpJUWFnN0NFS1cvWU9DOExGWHFvZTZFM09vZmg5WExjUjFP?=
 =?utf-8?B?MEs4VmxodWV4eW9TV1VOSjIvVUMrZ1hZd3ZvOE5pZytEMXQ3OU1jT3htSjJW?=
 =?utf-8?B?WTdVTlh4d1VpQ1M0eTNZS1EvVmpDV0c2MmV3MWZKcEFZak5odjkvN0FsV2lG?=
 =?utf-8?B?dFZuSGs0SUNTVnNxdkVDblpsemFuUzVwVjczanVQQUNIcm1SRUpodkJQdkF4?=
 =?utf-8?B?MWFiYmZERWZWRmFFdU5wbkRSbE04UE9ZVHNwa1lFWnRobFp4RWp3N1hjNFkz?=
 =?utf-8?B?bms4TzdlbHVNZ0xRVHNBZmRiTkVBWUUvMldTeHk0SzlsbmE1UnpZR2d1L1E0?=
 =?utf-8?B?NHkrWmpCeEdmVUZ3RDFDQVc0alJEOHFjY25tZWI0TDhEdE9rWXpLaWk4R2ZK?=
 =?utf-8?B?ci9vUkxUdFYrZWtSbEpuay9ZK01PMllDTWh6SUxqWU5pNnBld2xMeUl5cVJz?=
 =?utf-8?B?eDhRZXlBdjN5MmJ2NXNkMUFFYkhELytKTlFyM1dIMktLamFCKzR2SnRGWkxp?=
 =?utf-8?B?T3RSNHVrcHNzTGRXcEY2b0Z1L25aYVBhL3NvYmVUMC9CUWYyTXNVQ0ViUSt2?=
 =?utf-8?B?b2pUNXhOUzdldDhadnIyTnIyNjRCc0F2SGF5b0ZyRTIydGVHdlBVdnBLTktI?=
 =?utf-8?B?bnZid3c5Rk91ZjBEalBjZU8xWWgyRFJHeDg4Y01CSi9kdzhDdUVJTmNvZ1Bk?=
 =?utf-8?B?UlNUV2ZhMHV6R1VMS2VjN1RuRmhlYkJLSCtYekQ5VEthOEkwZGJIeWJldkM1?=
 =?utf-8?B?a1R0Tjd0Nk5tV1pBaUpMRFdITEFPRjRZclVvQjV6Wkg2WHVsbkt3MkNOenNP?=
 =?utf-8?B?RGVxM29sbG04RWdGb253UXZhRUROb2ZQcXV1YlE1YllGcUcvOTJ3b0RzZStX?=
 =?utf-8?B?cU5oOHE3VHJsbXhvZUF6QUlSZGZsYVZ4Vnp3MjYxczNHM1F1U2V1ZUdiWG8r?=
 =?utf-8?B?bUZmbnoxMFFMZEhMQWhqRm5VcVI2SlNxQWhIcmFpYnRmNlJyaXdjQUZUNXQ4?=
 =?utf-8?B?aDFlQUhkejhRNUFrY0lBZTA5NmcyK042K01INTg2bEd1OWIxQ0NQTHNxQlFy?=
 =?utf-8?B?YXhxQWt6VEsrcDhaMWttUFh4d2hJTGJlTTN1akY0dUhFSzdRSG94djUwdUVV?=
 =?utf-8?B?c2crUVV3bGZJNnNjWjZBR0FYSHBiZ240K24zcjVmUHNuWVNMOVpoRUpqdlRp?=
 =?utf-8?B?SHhwYnRXdUdtS1FRSW95Y210VDZFQmFaMmdQd0QvY3JXdGhtZlZ1ZHFXa2tK?=
 =?utf-8?B?WExsamplWVdQMFVwYVgyaEVLb3lpS3krQVZlQXRGK0pRS01tOURCTXp1NnV1?=
 =?utf-8?B?UUM1cktmR2l1c2hOajJhWE5sRUp3OXJSb2xFTEpHSlZpUDZuS05hbGM4L2Y2?=
 =?utf-8?B?ekluVW9oZEZCa0ZubS94S2hPUEptQlhnMFFwUkJrNEVZM3Q1ZmFoOHp5cUxy?=
 =?utf-8?B?cXd5c3ErajhqVlJ1MHFNZU1Ia3BwMThZenFjUG5KMjM0K20zYzQrOXY3N3Ro?=
 =?utf-8?B?YU93Yk1QWE9Jb3NGT0NFSzhHRy9sZEtMeWdmTGhCNDdWeEtGb1E1VVZHMVAz?=
 =?utf-8?B?V0ZHcjZhbUlmWElkYkExc2k3MmlLdGNPSDZ3eFFURlNyMFRyVG9ZOUtoVk12?=
 =?utf-8?B?bm1RMU0xQWVVZlpic3VHOWZyZklQejJiWkFUREhXOE1kbVUvbm5HbkNMY1FR?=
 =?utf-8?B?T3BWWGR4ZzhsUzZNWkxPalBLVHNxcDMxTnc2THJ6MXNGdHg3Nzh2dnJ3MW1Q?=
 =?utf-8?B?SzBzVVRsT3I0c0xSeWsyN29TQnNYU0Z0NksvNUhyTHYzcmI4ZzlRZWR5MHFC?=
 =?utf-8?B?SG93MDhvcng5c1pBdk1WNGhGWGoyM1BHenloektZcTFWb1Qxb0VYY0lmSzlq?=
 =?utf-8?B?R0N4cDJ6ZmF6d0VET3RLNkdKb3htdzZhRDJpNEtnenlXSEdJTGJpbGRkQ3FP?=
 =?utf-8?B?L1VRNHdYQmVzRUR0UzFyb2lXUjVhSUc5QXFBc09tV092dEo2Z0hheG5QVkRa?=
 =?utf-8?B?SzlIOEZiVkVtSUYvTlpEL3FEVnRjQ25PMVlVcmhpZHNvQVA5RjhqUnh1a1RK?=
 =?utf-8?B?QWRqUEdPVTF1ZzJoVVpVdEd5ekwzNFRUck5lNWhvSGtSZjFQZFRvaG8xM0dt?=
 =?utf-8?B?dlNnM1N1S2ZJSTNXZC9FYjdWaUJWbkYwKzg1d255SUJxTzh0cklLZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 152a324d-3273-42be-f046-08de4c5654e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 12:31:21.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u08xJPD7WhMwpQayq5o12KcxEkUc/lRkoVqi0Ho+a7a/Mz6S5Cd7eWsmGdXVqFASmVFTNI28KXDjN9yJyGToNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
X-OriginatorOrg: intel.com

On 03/01/2026 13:12, Ulf Hansson wrote:
> + Adrian

+ Ricky WU <ricky_wu@realtek.com>

> 
> On Thu, 1 Jan 2026 at 05:58, Tabby Kitten <nyanpasu256@gmail.com> wrote:
>>
>> Hi,
>>
>> It's been a few weeks since you looked into the bug. I think the merge window is over now, have you had the time to look into resolving this issue?
> 
> Yes, sorry for the delay.
> 
> See below for an attached patch. Please try it out and report back.
> 
> Kind regards
> Uffe
> 
>>
>> Tabby
>>
>> On Tue, Dec 9, 2025 at 7:09 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> On Wed, 26 Nov 2025 at 10:08, Tabby Kitten <nyanpasu256@gmail.com> wrote:
>>>>
>>>> On a PC with a Realtek PCI Express SD reader, when you sleep with
>>>> `wakeup_count` active (eg. sleeping from KDE's lock screen), the MMC
>>>> driver wakes up the system and aborts suspend.
>>>
>>> Okay, that's clearly a problem that needs to be fixed!
>>>
>>>>
>>>> I've found a sleep failure bug in the rtsx_pci and mmc_core drivers.
>>>> After userspace writes a number to `/sys/power/wakeup_count` (eg. KDE
>>>> Plasma does it to distinguish user wakes from timers and Wake-on-LAN),
>>>> if it attempts a mem suspend it will be aborted when
>>>> rtsx_pci_runtime_resume() -> mmc_detect_change() emits a
>>>> pm_wakeup_ws_event(). This breaks sleep on some hardware and desktop
>>>> environments.
>>>>
>>>> The detailed description:
>>>> The recently released Plasma 6.5.0 writes to `/sys/power/wakeup_count`
>>>> before sleeping. On my computer this caused the sleep attempt to fail
>>>> with dmesg error "PM: Some devices failed to suspend, or early wake
>>>> event detected". I got this error on both Arch Linux and Fedora, and
>>>> replicated it on Fedora with the mainline kernel COPR. KDE is tracking
>>>> this error at https://bugs.kde.org/show_bug.cgi?id=510992, and have
>>>> disabled writing to wakeup_count on Plasma 6.5.3 to work around this
>>>> issue.
>>>>
>>>> I've written a standalone shell script to reproduce this sleep failure
>>>> (save as badsleep.sh):
>>>>
>>>> #!/bin/bash
>>>> read wakeup_count < /sys/power/wakeup_count
>>>> if [[ $? -ne 0 ]]; then
>>>>     e=$?
>>>>     echo "Failed to open wakeup_count, suspend maybe already in progress"
>>>>     exit $e
>>>> fi
>>>> echo $wakeup_count > /sys/power/wakeup_count
>>>> if [[ $? -ne 0 ]]; then
>>>>     e=$?
>>>>     echo "Failed to write wakeup_count, wakeup_count may have changed in between"
>>>>     exit $e
>>>> fi
>>>> echo mem > /sys/power/state
>>>>
>>>> Running `sudo ./badsleep.sh` reproduces failed sleeps on my computer.
>>>> (sudo is needed to write to `/sys/power/wakeup_count` on Fedora.)
>>>>
>>>> * If I run the script unaltered, the screen turns off and on, and the
>>>>   terminal outputs
>>>>   `./badsleep.sh: line 14: echo: write error: Device or resource busy`
>>>>   indicating the mem sleep failed.
>>>>
>>>> * If I edit the script and comment out `echo $wakeup_count >
>>>>   /sys/power/wakeup_count`, the sleep succeeds, and waking the computer
>>>>   skips the lock screen and resumes where I left off.
>>>>
>>>> * If I run `sudo rmmod rtsx_pci_sdmmc` to disable the faulty module, the
>>>>   sleep succeeds, and waking the computer skips the lock screen and
>>>>   resumes where I left off.
>>>>
>>>> I think this problem happens in general when a driver spawns a wakeup
>>>> event from its suspend callback. On my system, the driver in question
>>>> lies in the MMC subsystem.
>>>>
>>>> ## Code debugging
>>>>
>>>> If I run `echo 1 > /sys/power/pm_debug_messages` to enable verbose
>>>> logging, then attempt a failed sleep, I see output:
>>>>
>>>>     PM: Wakeup pending, aborting suspend
>>>>     PM: active wakeup source: mmc0
>>>>     PM: suspend of devices aborted after 151.615 msecs
>>>>     PM: start suspend of devices aborted after 169.797 msecs
>>>>     PM: Some devices failed to suspend, or early wake event detected
>>>>
>>>> The "Wakeup pending, aborting suspend" message comes from function
>>>> `pm_wakeup_pending()`. This function checks if event checks are enabled,
>>>> and if some counters have changed aborts suspend and calls
>>>> `pm_print_active_wakeup_sources()`, which prints `wakeup_sources`.
>>>> Tracing the code that modifies `wakeup_sources`, I found that
>>>> `pm_wakeup_ws_event()` would activate an event and
>>>> `wakeup_source_register() → wakeup_source_add()` would add a new one.
>>>
>>> Thanks for all the details!
>>>
>>>>
>>>> To find who changed wakeup events, I used my stacksnoop fork at
>>>> https://github.com/nyanpasu64/bcc/blob/local/examples/tracing/stacksnoop
>>>> .py to trace a failed suspend:
>>>>
>>>> nyanpasu64@ryzen ~/code/bcc (local)> sudo ./examples/tracing/stacksnoop.py pm_wakeup_ws_event wakeup_source_register
>>>> TIME(s)            FUNCTION
>>>> 7.254676819:
>>>> 0: ret_from_fork_asm [kernel]
>>>> 1: ret_from_fork [kernel]
>>>> 2: kthread [kernel]
>>>> 3: worker_thread [kernel]
>>>> 4: process_one_work [kernel]
>>>> 5: async_run_entry_fn [kernel]
>>>> 6: async_suspend [kernel]
>>>> 7: device_suspend [kernel]
>>>> 8: dpm_run_callback [kernel]
>>>> 9: mmc_bus_suspend [mmc_core]
>>>> 10: mmc_blk_suspend [mmc_block]
>>>> 11: mmc_queue_suspend [mmc_block]
>>>> 12: __mmc_claim_host [mmc_core]
>>>> 13: __pm_runtime_resume [kernel]
>>>> 14: rpm_resume [kernel]
>>>> 15: rpm_resume [kernel]
>>>> 16: rpm_callback [kernel]
>>>> 17: __rpm_callback [kernel]
>>>> 18: rtsx_pci_runtime_resume [rtsx_pci]
>>>> 19: mmc_detect_change [mmc_core]
>>>> 20: pm_wakeup_ws_event [kernel]
>>>>
>>>> On a previous kernel, lines 9-12 were replaced by a single call to
>>>> `pci_pm_suspend`. I've posted my detailed debugging on the older kernel
>>>> at https://bugs.kde.org/show_bug.cgi?id=510992#c26. There I found that
>>>> `pci_pm_suspend()` wakes PCI(e) devices before sending them into a full
>>>> sleep state, but in the process, `_mmc_detect_change()` will "Prevent
>>>> system sleep for 5s to allow user space to consume the\n corresponding
>>>> uevent"... which interrupts a system sleep in progress.
>>>>
>>>> On my current kernel, the same logic applies, but reading the source I
>>>> can't tell where `__mmc_claim_host()` is actually calling
>>>> `__pm_runtime_resume()`. Nonetheless the problem remains that
>>>> `rpm_resume()` is called during system suspend, `mmc_detect_change()`
>>>> wakes the system when called, and this will abort system sleep when
>>>> `/sys/power/wakeup_count` is active.
>>>
>>> __mmc_claim_host() will call pm_runtime_get_sync() to runtime resume
>>> the mmc host device.
>>>
>>> The mmc host device's parent (a pci device) will then be runtime
>>> resumed too. That's the call to rtsx_pci_runtime_resume() we see
>>> above.
>>>
>>> The problem is then that rtsx_pci_runtime_resume() invokes a callback
>>> (->card_event())) back into the mmc host driver
>>> (drivers/mmc/host/rtsx_pci_sdmmc.c), which ends up calling
>>> mmc_detect_change() to try to detect whether a card have been
>>> inserted/removed.
>>>
>>>>
>>>> ## Next steps
>>>>
>>>> How would this problem be addressed? Off the top of my head, perhaps you
>>>> could not call `__pm_runtime_resume()` on a SD card reader during the
>>>> `device_suspend()` process, not call `pm_wakeup_ws_event()` when the SD
>>>> card status changes, not call  `pm_wakeup_ws_event()` *specifically*
>>>> when system suspend is temporarily waking up a SD card reader, or
>>>> disable pm_wakeup_ws_event() entirely during the suspend process (does
>>>> this defeat the purpose of the function?).
>>>
>>> Let me think a bit on what makes the best sense here. I will get back
>>> to you in a couple of days.
>>>
>>>>
>>>> Are there other drivers which cause the same symptoms? I don't know. I
>>>> asked on the KDE bug tracker for other users to attempt a failed sleep
>>>> with `echo 1 > /sys/power/pm_debug_messages` active, to identify which
>>>> driver broke suspend in their system; so far nobody has replied with
>>>> logs.
>>>>
>>>> Given that this bug is related to `/sys/power/wakeup_count`
>>>> (https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power), I
>>>> was considering CCing Rafael J. Wysocki <rafael@kernel.org> and
>>>> linux-pm@vger.kernel.org, but have decided to only message the MMC
>>>> maintainers for now. If necessary we may have to forward this message
>>>> there to get their attention.
>>>>
>>>> ----
>>>>
>>>> System information:
>>>>
>>>> * I have an Intel NUC8i7BEH mini PC, with CPU 8 × Intel® Core™ i7-8559U
>>>>   CPU @ 2.70GHz.
>>>>
>>>>     * uname -mi prints `x86_64 unknown`.
>>>>
>>>> * `lspci -nn` prints
>>>>   "6e:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI Express Card Reader [10ec:522a] (rev 01)".
>>>>
>>>> * I am running kernel 6.18.0-0.rc7.357.vanilla.fc43.x86_64 from the Fedora COPRs
>>>>   (https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories).
>>>>
>>>> * dmesg at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf074e44a#file-dmesg-2025-11-25-txt
>>>>
>>>> * Fully resolved config at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf074e44a#file-config-6-18-0-0-rc7-357-vanilla-fc43-x86_64,
>>>>   source at https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/mainline-wo-mergew/fedora-43-x86_64/09831015-mainline-womergew-releases/kernel-6.18.0-0.rc7.357.vanilla.fc43.src.rpm
>>>
>>> Kind regards
>>> Uffe
> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Sat, 3 Jan 2026 11:55:44 +0100
> Subject: [PATCH] mmc: core: Avoid runtime PM of host in mmc_queue_suspend()

Seems reasonable, but isn't there also:
	bus_ops->suspend() == mmc_sd_suspend()
		_mmc_sd_suspend()
			mmc_claim_host(host)

In general, it looks difficult to avoid runtime resume on
the suspend path.  PCI will usually runtime resume anyway
i.e. from pci_pm_suspend():

	/*
	 * PCI devices suspended at run time may need to be resumed at this
	 * point, because in general it may be necessary to reconfigure them for
	 * system suspend.  Namely, if the device is expected to wake up the
	 * system from the sleep state, it may have to be reconfigured for this
	 * purpose, or if the device is not expected to wake up the system from
	 * the sleep state, it should be prevented from signaling wakeup events
	 * going forward.
	 *
	 * Also if the driver of the device does not indicate that its system
	 * suspend callbacks can cope with runtime-suspended devices, it is
	 * better to resume the device from runtime suspend here.
	 */
	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
		pm_runtime_resume(dev);

So maybe alter rtsx_pci_runtime_resume() to avoid calling
pcr->slots[RTSX_SD_CARD].card_event() == rtsx_pci_sdmmc_card_event()
when suspending.  Perhaps along the lines of the hack below:

static int rtsx_pci_runtime_resume(struct device *device)
{
	struct pci_dev *pcidev = to_pci_dev(device);
	struct pcr_handle *handle = pci_get_drvdata(pcidev);
	struct rtsx_pcr *pcr = handle->pcr;

	dev_dbg(device, "--> %s\n", __func__);

	mutex_lock(&pcr->pcr_mutex);

	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);

	rtsx_pci_init_hw(pcr);

	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
+#if IS_ENABLED(CONFIG_SUSPEND)
+		if (pm_suspend_target_state == PM_SUSPEND_ON)
+#endif
		pcr->slots[RTSX_SD_CARD].card_event(
			pcr->slots[RTSX_SD_CARD].p_dev);
	}

	mutex_unlock(&pcr->pcr_mutex);
	return 0;
}

> 
> WIP
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c     | 18 ++++++++++++------
>  drivers/mmc/core/core.h     | 11 ++++++++---
>  drivers/mmc/core/queue.c    |  4 ++--
>  drivers/mmc/core/sdio_irq.c |  2 +-
>  4 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 860378bea557..c3923522833a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -781,6 +781,7 @@ static inline void mmc_ctx_set_claimer(struct
> mmc_host *host,
>   *     @ctx: context that claims the host or NULL in which case the default
>   *     context will be used
>   *     @abort: whether or not the operation should be aborted
> + *     @do_pm: whether to use runtime PM or not
>   *
>   *     Claim a host for a set of operations.  If @abort is non null and
>   *     dereference a non-zero value then this will return prematurely with
> @@ -788,7 +789,7 @@ static inline void mmc_ctx_set_claimer(struct
> mmc_host *host,
>   *     with the lock held otherwise.
>   */
>  int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
> -                    atomic_t *abort)
> +                    atomic_t *abort, bool do_pm)
>  {
>         struct task_struct *task = ctx ? NULL : current;
>         DECLARE_WAITQUEUE(wait, current);
> @@ -821,7 +822,7 @@ int __mmc_claim_host(struct mmc_host *host, struct
> mmc_ctx *ctx,
>         spin_unlock_irqrestore(&host->lock, flags);
>         remove_wait_queue(&host->wq, &wait);
> 
> -       if (pm)
> +       if (do_pm && pm)
>                 pm_runtime_get_sync(mmc_dev(host));
> 
>         return stop;
> @@ -829,13 +830,14 @@ int __mmc_claim_host(struct mmc_host *host,
> struct mmc_ctx *ctx,
>  EXPORT_SYMBOL(__mmc_claim_host);
> 
>  /**
> - *     mmc_release_host - release a host
> + *     __mmc_release_host - release a host
>   *     @host: mmc host to release
> + *     @do_pm: whether to use runtime PM or not
>   *
>   *     Release a MMC host, allowing others to claim the host
>   *     for their operations.
>   */
> -void mmc_release_host(struct mmc_host *host)
> +void __mmc_release_host(struct mmc_host *host, bool do_pm)
>  {
>         unsigned long flags;
> 
> @@ -851,6 +853,10 @@ void mmc_release_host(struct mmc_host *host)
>                 host->claimer = NULL;
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 wake_up(&host->wq);
> +
> +               if (!do_pm)
> +                       return;
> +
>                 pm_runtime_mark_last_busy(mmc_dev(host));
>                 if (host->caps & MMC_CAP_SYNC_RUNTIME_PM)
>                         pm_runtime_put_sync_suspend(mmc_dev(host));
> @@ -858,7 +864,7 @@ void mmc_release_host(struct mmc_host *host)
>                         pm_runtime_put_autosuspend(mmc_dev(host));
>         }
>  }
> -EXPORT_SYMBOL(mmc_release_host);
> +EXPORT_SYMBOL(__mmc_release_host);
> 
>  /*
>   * This is a helper function, which fetches a runtime pm reference for the
> @@ -867,7 +873,7 @@ EXPORT_SYMBOL(mmc_release_host);
>  void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx)
>  {
>         pm_runtime_get_sync(&card->dev);
> -       __mmc_claim_host(card->host, ctx, NULL);
> +       __mmc_claim_host(card->host, ctx, NULL, true);
>  }
>  EXPORT_SYMBOL(mmc_get_card);
> 
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index a028b48be164..5979c90d3b09 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -135,8 +135,8 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card);
>  int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
> 
>  int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
> -                    atomic_t *abort);
> -void mmc_release_host(struct mmc_host *host);
> +                    atomic_t *abort, bool do_pm);
> +void __mmc_release_host(struct mmc_host *host, bool do_pm);
>  void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
>  void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
> 
> @@ -150,7 +150,12 @@ int mmc_card_alternative_gpt_sector(struct
> mmc_card *card, sector_t *sector);
>   */
>  static inline void mmc_claim_host(struct mmc_host *host)
>  {
> -       __mmc_claim_host(host, NULL, NULL);
> +       __mmc_claim_host(host, NULL, NULL, true);
> +}
> +
> +static inline void mmc_release_host(struct mmc_host *host)
> +{
> +       __mmc_release_host(host, true);
>  }
> 
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..76e83f49ff4e 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -477,8 +477,8 @@ void mmc_queue_suspend(struct mmc_queue *mq)
>          * The host remains claimed while there are outstanding requests, so
>          * simply claiming and releasing here ensures there are none.
>          */
> -       mmc_claim_host(mq->card->host);
> -       mmc_release_host(mq->card->host);
> +       __mmc_claim_host(mq->card->host, NULL, NULL, false);
> +       __mmc_release_host(mq->card->host, false);
>  }
> 
>  void mmc_queue_resume(struct mmc_queue *mq)
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 2b24bdf38296..e5d4f8c634c8 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -172,7 +172,7 @@ static int sdio_irq_thread(void *_host)
>                  * that doesn't require that lock to be held.
>                  */
>                 ret = __mmc_claim_host(host, NULL,
> -                                      &host->sdio_irq_thread_abort);
> +                                      &host->sdio_irq_thread_abort, true);
>                 if (ret)
>                         break;
>                 ret = process_sdio_pending_irqs(host);

