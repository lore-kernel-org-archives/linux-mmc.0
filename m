Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AB3D813A;
	Fri,  3 Jul 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086079; cv=fail; b=lhwiesk+I/mZZJaLKu83IVGvA8QrEJjmBcl3EM4zLEbMul3B6RQ3iBu0uubtWbK+jmDETPZxALzOlCq0OHM9yC9fIVyzmNjvno1RSVAHzYKUXJU5taFIIgHv2QQz13IMgRPoyAGoGLnef4AYVEcL6PS/nTWZTdY3Zn6HlOS57yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086079; c=relaxed/simple;
	bh=PnXegf4/vM55ur0jO3i8zQTaxvEtXHEKtVut9Mos5f0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dz2orqySZhsEaAqqUUYaCply9asY9vFqncPK5Lmy9D3eb7SuJZYu5O1j9acC+IwZyn7L0Gq67Bdo0QZObS8eIsIeZ2lvleeFJRIraVwAR03qLL4h8O+azDymSV0efaSHCT42cL8vaFHWeoydbyaPnkENogUUmZ5WdfAf0WIgTQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhYBlo42; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhYBlo42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783086077; x=1814622077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PnXegf4/vM55ur0jO3i8zQTaxvEtXHEKtVut9Mos5f0=;
  b=NhYBlo42bupdWuYhiiwc48ssr/COolpu+922ZVXVtWpEu0Ok1B/kIEOc
   S5dP3sz+PPrJgZ6rXi2t9JCtZWGokAJa0p3WzaZQ7KNji9iTC27vVVF9E
   uxIkw7Ks9wnfeKR+Gy8Qg95WmEP4zKEy6mrTz8aJb++Pi7nYjpAjcY9XK
   3vMLJPoARAlk71wKIjT6LDJ7PxVi+JpT5Z/Hag4CAXxJkh8MyRkfx/JzN
   /oFMMRB3jatVDmi/PYeR1AV8c1ZAv1ViHkCy1A/EZ7q1HXIZTw+FfXwsM
   +Mp5ImEE0Fd711rYiBjmZCUk89UUEL6NcE9jb/5WbPfToBTA9fwumjAur
   g==;
X-CSE-ConnectionGUID: 3wqfctG/QyO8FtxdEMrOIA==
X-CSE-MsgGUID: nA/mzrzwSlGLYr80zfjPgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="82947702"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82947702"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:41:16 -0700
X-CSE-ConnectionGUID: kPNVtr7LSAKrpC8L8ERRcQ==
X-CSE-MsgGUID: RLfJO9spSd+yzzR5eedRwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249154079"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:41:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:41:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:41:15 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/lQljRpX4MOu8O6BLQ/Edvybcq8FjOEkM7BjnkAO1fXyaRTVZHbMJq1VrO6lgxcEXlI3ES5jLtL6TswreeXynMlUlXd9QHOUzio+Yy8rD7xi44binoBFmnk/pS6A2PfaCtOhIsGDuBB/DMhrzp/fixfjPzal+PBnr8gEO5tL4DMGROqeh3OFvSK9EGtZps6hHi6QA0TehkZ3ZjlqGm/wWq1I7d1UtAYp4tycl3lk8NtjahDGRe9qgsfBrN/3ckYHra0+3zSQLjpuH8woZQr0OLiNXtvqTueB+12gaUWAu3k4jSqWSvIjhLnMshdqPlS5U4tiD/3GRphW8h53fs/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDic5VezhB8I3ULDoCWEYcd/TWIOIMOsZ4KPBg7dA6Q=;
 b=Ey12BqtVuh+zVZHDB2DV52WcC3V6iSwfxYefWstcGDBcYIjOneozoGyohkUhtREaZmsvPiQxyd9gYxRzVsPQii5an2/3i3DmyceCaeU4sxNUxHL2MoWOs6S93pxAZiKwmckdlPJHHdrCxmSgdhxehVQk6PkECaOLdFHh436kKUO/noMatuXS377z1L8CR8tv59pN9gI7n0kYDRVh6GKHqhoN3RIdCX6x1p+OjfeSRCu+YrTn9cTakXX8O+i1z2Qe/V3IGgCcxTKCOFeyxJUwoxvFZGrtvfREoJi3d+R5fgjA94O0E56kF3Gl+EQLkSnHmhTSEMrDN5aJLPt96HBekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV1PR11MB8817.namprd11.prod.outlook.com (2603:10b6:408:2b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:41:12 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:41:12 +0000
Message-ID: <3425c3da-86fd-469d-a3ec-7805138d3e2e@intel.com>
Date: Fri, 3 Jul 2026 16:41:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset calls
To: Satyansh Shukla <satyansh.shukla@oracle.com>, Ulf Hansson
	<ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260618105319.217717-1-satyansh.shukla@oracle.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260618105319.217717-1-satyansh.shukla@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0061.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV1PR11MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: a705d033-b8e8-4eed-3c75-08ded908bead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|6133799003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BT7F2pHsnDL12auEXDEWnxauiIxDxkz/f91J2eCsoRW0jGkL480saMxrih2kmeiGivigypHNnSUCO9RBPQ7EmkgiFZUWqIgkoi5qlPGSWmxfgKcXUw8bBp2ad0drfOH1fbp2lIDsJY0YXrePgLwUhDTJdMA+VKJeJaY7p+KsMX6BUuw/vG4NKv2Ml4dytDkmQ9oejr7aaesojHwPBMoAcFIzP6tFSK80yoZ19o8Z76jsHb3qVwMAD9hQ3wI0ENNugDTK+KA5dzZO0S68NDwqFwHr+o13vFifLE8gcTuHUrEjlYDa6z0VCrBSMYOXaIOoCQDfDQ4bBc/HFE0iPT5uxLPmUFuVAEt2v5KGagu581Z3HBOG9juPC6RYWZkASt50qKyloY0S4Xjm4/1ooxhyEw9CCra3c5IJyEBx0DOYjsL8zxgZac7AH2yIz+O+0qU5i8lrde0mwRLohQOWhZ05KWWjwKb1INhqPVTHJkqQBN4jyeMFrfdxxM81jYv1Q4wjkltwNqiw7iEPASBRwCCMEDsT7yqcC5KKUvAFktNoQH4WKQ7isL4MTQiaLpEU+fceZSHHLqNyyuneIlSmS0iia73kTy4lP/YJNLpjQ/s71wnfPdv/Tzvzyqd6Nc3aUHaDw2VM+yI2brh+tHSkK/r+BuoX791Ar4X04lK5wr2wiLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(6133799003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVWYmZKMzNVTFIyeXA0bUFkTVRBMmNSeEdUZnlJUVUzckdQODVaUENFUGxD?=
 =?utf-8?B?RmNFVC9tc2h6OHVPa1JiaHBXTjJYU2Q4Y1I1V28rNk1qcnpwSVByZFV6Yko4?=
 =?utf-8?B?RjhpUHZCUVI3VDJ3d0hkTHhRUVpkNzhRZDlITnYxdnV1eW9DQ085Ly9EWkZM?=
 =?utf-8?B?Q1FOQVFwMllIOVZPMFpFN3VrZmh4Mk5qeHZHTGJ0R0U0Qm8yQk4zaVRjMis1?=
 =?utf-8?B?QVprVU5Zd2FKakVnYmxWOTlYNkZLZm5pZDhmdS9RVnpLb1RKVnloZmxLOHds?=
 =?utf-8?B?alFZRy84aUNoaEZ4MFpmc1FzWEM4NWZ3NkRrNnJOcVBabFdqVHNNeCtqNnFM?=
 =?utf-8?B?ZDNaanVGNVU3T3QrMm1wVjQwZ2oxdXQ3REg0bmpMa29wU1IxQ05JcVdmOTFj?=
 =?utf-8?B?Y24rYzNBM1U4TXRUcEUxUDRneCt1dkFEdUVTUDdrUE1wVmozcS9WdmE2ZGMx?=
 =?utf-8?B?dG1DekNlb2w2VE1oelBWYUNhWWtVSTBxeGp5RmQzSVMxelY4TUZrazdBbXcr?=
 =?utf-8?B?WVd0dVNCbnVDWDlsbjlLaHdISGlqR3lLK2hQb1RySHZublM3ZHQ0UWlpYXpO?=
 =?utf-8?B?T0lvRS9UenQ5MWxFbTlDV0t2di9CYTFyNnhjSzlwaGlqSU1OQ2hHeU1vZUJs?=
 =?utf-8?B?NWdDUWxId2hjWjVWb3VIV05pWGt5SWlXb2NrdWE1aUx4VUJtZUc1TXI0cHZn?=
 =?utf-8?B?cTdMdDhERklja1JIdzZGcVI5Y3Q3dDFlS0RBOWFndkF2d3paemttdWVxV2V2?=
 =?utf-8?B?R1Jrb2ZjcFE5U3drMWM3NVhqc1h0NXQxRjdFMVlFY0FHNkY5b1lwQXE4RUE0?=
 =?utf-8?B?eXducmFyek5rR2Q1cjIvUVNEZUZ6Z3FSVnBnL3NTaDJNWk03YmduRWh3MnNK?=
 =?utf-8?B?S2UwUyt1T2tZWEZZMkdwMHEralpqbnJMbDZKSHZMelMrSUNMenRXeS9CN0NG?=
 =?utf-8?B?Sm5CLytoR281UzdlYnpIMFZuVGcvTjhhcmdoeDRMVFZmZTJnTGEvai8zdG5T?=
 =?utf-8?B?YVNsOHFFR2x5akg4WUZCUWkzbGR1N0xZOUlpMWY1a3dvMk1vRzdSQk5ZMlVq?=
 =?utf-8?B?a1ZFUFRqdlpiVmhKRWw0M1BJakkyenJHblEvb2pDUGlTOGV5YS9rR2hEOFVO?=
 =?utf-8?B?cjF5a1licTRkZWZwOTdoYWk5NWI4Ym0zczZBN3NJSWNZSGFKV1VrajNwdUZR?=
 =?utf-8?B?N292QmpJb2FIZVpSUG0zRHlCdWdBR3dNUmswWEQ0bW42YVYvMzJ1UEhXOERH?=
 =?utf-8?B?REV2RlhOclRJRmptNytKMk1SVENUYVA1d2ZMNUVVNFczSDF3R3ZvUVlCZWdp?=
 =?utf-8?B?N1V0RmxhbkNEZUI2SWJwdU44SUs2dzl4cHVqekZ6TFVhUTRjSEh4N3hRUnZs?=
 =?utf-8?B?TGt4NmFQdmpWTlhVMTFLaEdKalp3UkhnbmRlOUpUUE5QTlBmbld6UGRpVzdZ?=
 =?utf-8?B?bDZXQ1dtVkw0bDlmZFE4YjBjL2graXMvNm1wcWRBYUJ3Mk43N2Y5R1JoZ0ZC?=
 =?utf-8?B?UXd0djBpOGVmZHZIbWR3WWgyUG9OazhYdzhtT3dMam1iMi9wRHlxTlFTbnpt?=
 =?utf-8?B?aUtEbjBzQlRVQWdTUE15OENlNG9zblptWEVBWm1TYXRyeGt5dkhvWERYbTFq?=
 =?utf-8?B?aDhySkJ0MEtKVFMwamVJUC9jWStiWi9wcFZWRHBtc3NyNjZtYnZ1VEFZdDRR?=
 =?utf-8?B?R21XNEp1TGtxdWU4SDNxajczS0tVb1ROdkRCT0hBbmJrcUIxb3dKQ3F6R05K?=
 =?utf-8?B?UjhVRUhveHJjUjhYSTZ5a04zWnNINWdLZ05aUnVQNjBYbmcrd2RtdFl2bE1S?=
 =?utf-8?B?VXFCNmVFZ2ZOUkY5elQ4Vyt6K2o3MTFQN2lpQUw1Z0twVzZaUzFuUlU5djNy?=
 =?utf-8?B?aHN1cmtRK3k0cEgrdnRhRFNDb21TMHA0cHJvTUtFQkYyemRmMEtBUlVwbE9w?=
 =?utf-8?B?cWdzVUNBMnptb05CUUkydG9kdTFrVXQxZ3d1SWJZdFVFemNQblNyemI4SDE4?=
 =?utf-8?B?eW9Fd3M1RllTcHI0UkNDOTRReFBFWTNWOXFzcnY0UEd5SEE4c0FvcFJ6NGJx?=
 =?utf-8?B?RnJyMjNtMDVUT21hWFNkcHFMc3V3UTllSWZHTm01ZFRXUzRtMW5JbkZGU21T?=
 =?utf-8?B?TnZaenVQak9wRWJQL2FxYmJTTkRmd2xadGs1RHI3WXhJTFF3QkFVcHRLOFJW?=
 =?utf-8?B?T2FhcFFWUFJ1Vm5NNERBOHpUUEhDNVMwYUg1YzErdEp2UjlETGJwWTNLdXl1?=
 =?utf-8?B?MXZuRythNXpWVnZsY0J6NWhFdldGakhucFlJREtzUEs2MUw0R0hETFZObFgr?=
 =?utf-8?B?Z3FhMjJDV0JrUXM2cUhpZ1FMUU81US9LbXo4OE5SS1JZSXo3b3dyVHp2cTBZ?=
 =?utf-8?Q?o+ACMd50hl3sM4zA=3D?=
X-Exchange-RoutingPolicyChecked: aXsEsTU6OrsSKXYSsKlne4OClFN+ilz/iJGelAZLarfY/psy1vXntN8v2zdXPKzFT3GD+oeCZKjEHXD+6lMJ5wuH2UqOsYPXkJufR8wGRwS57saPNjcRQ6pbQLDI1vJS+QsyxU7y0W1Kr41L1nxzTj5rS08naseQpbcxfoIGhXQjsanpp+Ikh+uQfg3c3K0yURiQypEYg22V71k95Ahp0j9c/LoMA05TGhfx7A0qbbDYCshkK6xx+NzZCmENip6PYwarQmdGCtxEqJOvK6Nm8MQLEDKXlKYL3jH7gGolXp+x0GwvWzzPU+/Qrtdcn6HDi9aLiDCTVOeckN0DZk8icw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a705d033-b8e8-4eed-3c75-08ded908bead
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:41:11.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCCKZrIB1lVkOB6sagXOIaPYorM0GvEUTR8a+yczK0grUSCABPxcjCpzKDpAW5RL+6yuNkJEFvPSbpFQ65v19g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8817
X-OriginatorOrg: intel.com

On 18/06/2026 13:53, Satyansh Shukla wrote:
> Log when the BlueField-3 eMMC hardware reset path is invoked and
> whether the RST_N SMC call succeeds.
> 
> This makes it easier to diagnose cases where the controller recovery path
> depends on issuing an eMMC reset, and helps confirm that the reset sequence
> was attempted on affected systems.
> 
> Signed-off-by: Satyansh Shukla <satyansh.shukla@oracle.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index b9ecd91f44ad..8acd4652a12b 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2019,10 +2019,13 @@ static void dwcmshc_bf3_hw_reset(struct sdhci_host *host)
>  {
>  	struct arm_smccc_res res = { 0 };
>  
> +	pr_info("%s: resetting...\n", __func__);
>  	arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, &res);
>  
>  	if (res.a0)
>  		pr_err("%s: RST_N failed.\n", mmc_hostname(host->mmc));
> +	else
> +		pr_info("%s: RST_N succeeded.\n", mmc_hostname(host->mmc));

Diagnostic prints need to be pr_debug().  Also 1 print should be enough.

>  }
>  
>  static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {

