Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649B201033;
	Mon,  6 Oct 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745958; cv=fail; b=TC1u72N+o/QS4/lL7F6y57ietPacRlMOtzc3DLH4MEUGpgsuCw/Svt9DbpM31eISbEeikVK8aSuGDiaoBkOwXnEA9GF+83nzthl2efqANwIAjgUPGKo+BaP/M65hCGoZY61OncqpBa9hwcxc4xGZVeV8BY6ZLS39Py5IgeGnI0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745958; c=relaxed/simple;
	bh=EVIQ0icWbyJh5mMcMIaXayJ0knwzOmB0MKAY5il7qt8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gKfdhoK0tO/PWR3ou43PTvr4QaOU/0PMK0XuvVQ4YdZmF8IfoT+Y4mwbK9EwWjIvXpNiaqxIWar1Th0QFJ6Yaa58AsBi8kEzS27ULuSRff1dWuLpkMCefcuo6LROZ2asm95qws9Id/K32k4yujZi2UUm3wMZnpS5mYHwxp2J5A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOmbrhZW; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOmbrhZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759745957; x=1791281957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVIQ0icWbyJh5mMcMIaXayJ0knwzOmB0MKAY5il7qt8=;
  b=kOmbrhZWenJ5l1he2GCiZwQnyqahPip3k0/Sra9zV+tmxEtLvBEMKzI4
   KWCwWslem8i71tg+qgSj25TUcMw4jJ/VD+ZgeJmeoPZR2UESWRaUVoc6i
   fKqcEsJGX6jSyLjXqkLe9qQFGv1Zp2QqnCHm3UzcLk1MTUzE10nxxhmMW
   4/x1hYllDGp7oZN7FbVInCbmsGRkvh11DO7j9/1NMyojqsa+8hN83fhvw
   /l8t97VC1J+o4QbAVRvZsoI0ThiB8M/SSbtNNH5+RkNrpJagfRO+Qf7y8
   0mkiYsNqwQyId6XlatW5x6kPuOjO0vVDZ6SrcNEHtd9rCqpGiePG+9X68
   A==;
X-CSE-ConnectionGUID: ilpINnd6TQaqL5vqN+KsdA==
X-CSE-MsgGUID: Z4suvPA+RvqCYqAkMaQuvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="61952787"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="61952787"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:19:16 -0700
X-CSE-ConnectionGUID: 80FtoB/XQvySe0Rlfa2CnQ==
X-CSE-MsgGUID: G2iFxeRJSQujo/q2nkyJWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="183878159"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:19:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:19:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 03:19:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFsaO0p7NVf8iZ4HhfRbokT1RW/UmaWvjaflJeToMvu6hzsrny2Je97UMPYhpKk7A9hRu+LZxOToVj263ObWhSKjY9kcwRT7VxRJCuaCngtinx/T2yDor/PrNxdkRYyJmb79mTdArQ8xkJ/sHNVFM+TMiZw3Jny83k4fFSUVhqkHyeWLpWzHovHnaOsk+f3638WrCEc8RlW3q87hQNH9p4xQFkLBswc3H8IfoggD+iMiny+l4XlZTFk3UfJ1xudcHWGxpwrvL/k95lR6bBKO55/tgxEwJQ98GNmDv1Vz1eQoP8gyxio+sye1i5EAp4E74IBRmab1ewcFTGBURuHjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8D/HqtHkPwnGY3r1+VvZeP9Pc3OutXrSQD641EzXug=;
 b=MbzDEjsacuwQ/SgGCvQ9NMuS0tiNHLDJoONEawW67PcAsC95OS5fNuMC4cRGJJxq8SXcv1L1P4QZlews8SjCj42uAoz2cmDig2Go2xb1874uNOorMj6UvAUH8auRu55kmkZYp05aZAzYLaYb3/S2ASqBl1n1Ayhoerbqzr4I4I54lpIdkm2r8mKRsql/3WAWuajMI7ITe7+4QOUK/H7C+GhiZlBpn62iyZkTdmHvTVt5Dvo9BEusIz4eq5zlEhchtw3D60qZb298mu9wFZF4eSKYzQcaA/mQenjmhRmjDmijR1MdptG1mlZOoVdEOpTliMolnepy8wXN3Tk8iyfIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:19:08 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:19:08 +0000
Message-ID: <fbf5ff3c-444e-4678-9781-6d083fb98cf0@intel.com>
Date: Mon, 6 Oct 2025 13:19:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-3-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251002210426.2490368-3-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:10:234::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM6PR11MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ef63bd-7746-4fe6-bd3b-08de04c1c8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFBuZjdpUlIwKzlmd2RnbWxGeTBkRWV4YWNDMXY2RkN5NmJZS3FwcU1RL2ZX?=
 =?utf-8?B?bk5pWE43YWhaRnBTSjF3ZkVlRGpka1F4VUp4VTZBUXFsMmhUdStldEpwVjM3?=
 =?utf-8?B?dStaOSsvcFRBMUk4RXVvc0tEUWxpeXB6NHpaaXNGK3hVU3VQeTVFMDVxSUZv?=
 =?utf-8?B?V0w3L1VjcitiaWxERWlCK0YwNThZWmgzYXFOYmZ5Q3FaZlZjdU4rVGhNbk1i?=
 =?utf-8?B?L01RbkxWU1U3d2FuOUVzWFpSU3lmUThTV204VkJPN3JDK0hLNW50T0VTNDlY?=
 =?utf-8?B?Q3pnK2piTThNQ040T05rcnpjMUxCcTRnZE9WdmswOTg4Ylo4RTJhc3V5L04z?=
 =?utf-8?B?SVdYckJBQ09zMys2UGRmMk1NVVNCc1Q0WEhqbUlBYjUyUlJ5bEs2R3ZXeXVM?=
 =?utf-8?B?VFhxTzJ0THlBc0w4eG9YS1FkdnhVWmRPY2JqcktuMmFQK3VibHlQeDZyUUg1?=
 =?utf-8?B?QlpDcW1OcWIxbmxzUlo4Z1EydUF3Vmk3TlBLKytiYUMraWh6WmR2OGduOE9u?=
 =?utf-8?B?cDM4MFVQLy8xRzRYSFlMeEc0SldZY3FKRm8zVDNCOUNLZG05ellLT3JYY0Rt?=
 =?utf-8?B?ZTlTUktMbExxUUk4cmV4WDRpUmx5S0xkTnJGRHZBbUpJWG9yL2psZXplTmpH?=
 =?utf-8?B?emVCcWhKY2hhR09EeEJkSXgwR2RjME9rZ0dPMmZmZXZBQ3d4MW1lTTZjenkx?=
 =?utf-8?B?VVVtQzRWNnhsRTFWQ3BBWFFGbUZpTC84UXpmdm40T2Mwb2h1NmdXTWYvblpG?=
 =?utf-8?B?WTFxRWU3dURjbnFCWE10RForNzB3dHh0aVJqbEhsbHV4TmVaRXhCb3pSYzBX?=
 =?utf-8?B?RHNpWWQ3ZDhqdEsveGNSWjV0bjR5T0k4czd0S2xycDZTNFU0R3RrOE1oTks0?=
 =?utf-8?B?TXFzOXdjUHhySVRmYVdEZE9sdkluS2l1dStmVnd3UUFsdmNKeS84bERzZ2sy?=
 =?utf-8?B?eHRlL3BoSnVyN0tZY0RrcERJYVpvdzE1WFlUd0dqV2twYSs2NTFPZTRGMmt6?=
 =?utf-8?B?VkRFTnl3Qmp0SE1UcXFHbXdVYjZxRDE5aWJ1Q0krYWowdzIwNTlXVmF1ekFC?=
 =?utf-8?B?eVArLzBvbFpCeHErUHNKakdERGFaQi9FMTlWdHFuK2N6MkYyRVQyOEE2a2hI?=
 =?utf-8?B?Wkg5NEc4VTVlNFprTUtaSEhCYkhkNGlHRVQwaHZUWGROVXVPazhkWXc0K1U0?=
 =?utf-8?B?M0FvR2ttSHRhUUZ1T0MxTE5sYTFhUXpuZXhjb0h5K1RnYkhzMUxpT3NEZ2hM?=
 =?utf-8?B?anVGVDBkZld0N0JvcWE2b1BJWk1qUDhPdU1zdVk5Ukx0ZG8yUWNkUjJzT043?=
 =?utf-8?B?Wm1NcmExQlgvcm55Sll5SWxCRmg0RGh3S1RwaCsreXlrVXdmUFhrTXdXOGtL?=
 =?utf-8?B?MkZUd0RndU5PWU1MbkZTd0toOUpZSHRtTDlZUUpTU3FPcENGWVFia2IzM1hF?=
 =?utf-8?B?OWdnd1Q1Vi95ZHExbmg5cUYwclhVbHlZUE1ldlJYNTQvSVdwR1gwMzM1U0lB?=
 =?utf-8?B?SFlxbHRLeStiVzg1RnhlMlR6RnR6MWhYN21MQ1JrMWx4NTZZaUNqdWdCaVZP?=
 =?utf-8?B?TGV5ZHJsbHV1L0ZZZE9aNkpXdUZPTkRmM1prOTJ1TEhLUHd1V2pqVmhrTnla?=
 =?utf-8?B?U1hsMk1UVTZ5d1MzU1ZpaDNLaVdBYWJjVmROMExCYm9mWGJ0czBENUFibjBS?=
 =?utf-8?B?NGRiZzhRQU9lcWpUbVQ3cVphR0NuaExCYW15NTNGSnRiT05BVjVFVllwUnA3?=
 =?utf-8?B?eWhxSDd3NXBvYlhTMkNmR0tkanV5aUV5UGxmZEdTSlMvUDJuKzV3SzJ6dWZo?=
 =?utf-8?B?VlQ1d25LeHNjU2NkaGNKMGNIZ2xBaHBYZm11L1dYa0hBbVArbTBoQTB4V09y?=
 =?utf-8?B?ZEdzSytha3h3ejh6UFlmamkvTzNSUER3WWVZd3dtMDJXMnA3YnE1eENVdUc5?=
 =?utf-8?Q?r3D9DqrEDkvGVE5uw7FbZpqfJe70SRvw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3B4c0tzTXZLZkYxSEc5TjVWRldPOVhPNERFWFJ0WEdMdVBZMmZNcnViMFlv?=
 =?utf-8?B?OHVNV3hteDFBV1IvYmRRU3JFWTZyMm15Y3NRdlg2cWR3eFhNS0txTWlRTXVI?=
 =?utf-8?B?WjMwN2VDdVpGWGF2aURkVityTEdWSVNNTDlTalNwYk5DNnNQYnIzV1FweEU3?=
 =?utf-8?B?SENDaEFKcjJUUUVJT05CWnQwME03OWpEUHJEOUNUNnlrUmVoWmVNQ2pYZ2RZ?=
 =?utf-8?B?MHgzV0hLWDBkUktFTnA0OHNQcy9zTUdnejdmMEdlQm0wL0hpblZpSXdVK3Jj?=
 =?utf-8?B?cU9ZdXpwNDV5SUsrNkVreDVRVmo4Zi9LZGFDT3BneElueFFvRGtXQTA0emxo?=
 =?utf-8?B?YUdBOEQ1TDYzOUd1a3NkR1BjYU01aGRnUVlCUTZxMEVMcTFWczBwZmxPWkVH?=
 =?utf-8?B?UkYzSXh1MFkwZjR5WEFQS3JHclA5S3ZqdjZ6QkpRNmNGa25QTGc5aUFzN2Rs?=
 =?utf-8?B?KzdwOTB4VE1iSVVVek1hQldtbk95U3NIeEJYdHRHTmJxQWxscmlsK2JzbUYr?=
 =?utf-8?B?SUZkV2FiemVFWnhRZVRxT0hFUFlhRkN4OHlocFE1dk4vMVV0aUF5YWRRNjdT?=
 =?utf-8?B?Yms3dHlnOExucDhZekRFRTJ6ejdzVXBQNlV4YnhLZDlJaGhuZmVKR0dQL3Ux?=
 =?utf-8?B?djRvNExjQ3YzNFhUOFNqSGUvcG92c1d4Y253akVrUk1OZWxoOFBLMnJRaHJY?=
 =?utf-8?B?OG9keTFBRDhJbVJoakdqMFBZb2orVlI4MDgxYzJ0bm1MQ0d3aThqOXEwMjRJ?=
 =?utf-8?B?azZwRVlvU3VhK0g5Nk1SU2lpcmZ1ZVoxTXdKZzVveFF2dWxwckY2dWNZR3JN?=
 =?utf-8?B?KzNLSHZQdm5XRkpGa0I2RXR5dTRGcWFSTlpkcmpGdmREdFR3b3lzZ0RnZDBS?=
 =?utf-8?B?OUVXSzFHOXowczFDT2JsVllEWnVwL2dhc1FqNnozc1ZBNTNrd0NYTDJualNt?=
 =?utf-8?B?ZEJjaGJkQXIwVVArTkN5TXFGRGVHOVVzaituTUtDTm1Cd3RDSStoZmVYYnkz?=
 =?utf-8?B?eG9OQXpBNDZrRWNZUDhCZWR3QktxY1RsaUo5MXhiZkR3YmVMcUtLaWVYVGE0?=
 =?utf-8?B?S3R4QnpMZEVNVzBlSDMra09JbzJjaFNPSndFVlRtN01QZjdhSEk0R1hndEJV?=
 =?utf-8?B?UWFtL2ZKcWJ5UWRBZE9SeVVDNGJVZEtibFJHaUVKYS9GWW5PL0tsTnpnNWlC?=
 =?utf-8?B?aEdwa1FrODQyOEdwTDVHUzBIdXhsdC9pSkcxZDVRYkZSY1RpRm54MkRzRTUy?=
 =?utf-8?B?WUs3aCtsMnY0QWk4R2h6UDh4VmFLMmdoY3R5V1ZRMlRzdXdDL3V4ZmhXL1RS?=
 =?utf-8?B?bFVqQTY0bmJYUGZMOVo2TUhpNFpPeWJjTGpTVElZZUI3VEtBM21MRWpwSzJK?=
 =?utf-8?B?UjI5bSt5RGd6OWM0NGRuSWoxUkp6Smw4czZGZk9yWERHYnZPb1Ara1FFRXBV?=
 =?utf-8?B?S1BHbitRT0oyOGFDeUE5SXFuTTN0aFFpTEticENGYmFoNWJTcGVWTmlZUkha?=
 =?utf-8?B?TzQ0RHhhQythV0FtNy9mdlVvV2JFaUdzMW93SCtQckc4OUNSWFFuSzdxNmFK?=
 =?utf-8?B?cnlJWFlQZW43bUhacHJFejloKzlIbzlhanhITll1UFZNWGRYMlBtL1czelB0?=
 =?utf-8?B?cUpKK2NabjNkSlN5QVZDNmtpY0o2VHkzNUExdVNEdkdwMWp1K3hqK0huclBn?=
 =?utf-8?B?QlBlMHNXQ05KdlFOTGlSNG9tRkxaVjl1ZkJ2Ry9wRzFPTE1LbkU0MDBOQ01j?=
 =?utf-8?B?akJYUWhIWVozU3IwV2N6ZGwvQWFlV3VscnZkRTRabmNSRHduZVIrZnJ1Q3JV?=
 =?utf-8?B?ZnlwYjBGd3pQVFowLy96M1pkdEVPMm1NZUNtODhYMkNhaUh4NnZDN1pXSEtC?=
 =?utf-8?B?NWVNbVlzcTNYZ25WTmxmeGpDVk9YYmVjSWo5aksrdGZ5eXVLWkYrY3VjVmpY?=
 =?utf-8?B?NHppd1pPMkN2eG1rK0hFSmJteDI4RTljbzFJME13MStVNUVNTUhPVE5sbjN3?=
 =?utf-8?B?d1AwVmQreUh0dy9xZEl5bXh2dmFEdWdJdVRPWTVPMDdmUGd6Q0xEaUJBQUVL?=
 =?utf-8?B?QWRQMWorMFV5SG5oVExIcWJQd3d1b3JvTHhtdFZlc2ZzUnF1VVRDWVJuTTlW?=
 =?utf-8?B?ZG44M2VYMEU4TEtXUmhHZDFNWVdVdUE2bkwrd0kzMVI1STBKMVhhMmhaT3p0?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ef63bd-7746-4fe6-bd3b-08de04c1c8e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:19:08.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAhCyAvj+tOYsBvAMql4WslF+1NH1yMD2ALDLB6uMx0XPp7c0L5j7xkAaueO41yqcPqAiw6ou2tcbuTtJK0E+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-OriginatorOrg: intel.com

On 03/10/2025 00:04, Kamal Dasu wrote:
> Clear SDIO_1_CFG_OP_DLY register when using HS200 mode to be
> compliant with timing spec.  We only need this for on BCM72116
> SoCs.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Some minor cosmetic issues.  Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 37 ++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index efc2f3bdc631..0905b316a24b 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -31,13 +31,13 @@
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>  
> -#define SDIO_CFG_CQ_CAPABILITY			0x4c
> -#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)

Preferably moving code around would be a separate patch.

> -
>  #define SDIO_CFG_CTRL				0x0
>  #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
>  #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> -
> +#define SDIO_CFG_OP_DLY				0x34
> +#define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
> +#define SDIO_CFG_CQ_CAPABILITY			0x4c
> +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
>  #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
> @@ -212,6 +212,22 @@ static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
>  	}
>  }
>  
> +static void sdhci_brcmstb_set_72116_uhs_signaling(struct sdhci_host *host,
> +						unsigned int timing)

Prefer to line up function parameters.  Using up to 100 columns is also ok.

> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	/* no change to SDIO_CFG_OP_DLY_DEFAULT when using preset clk rate */
> +	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> +		return;
> +
> +	reg = (timing == MMC_TIMING_MMC_HS200) ? 0 : SDIO_CFG_OP_DLY_DEFAULT;
> +	writel(reg, priv->cfg_regs + SDIO_CFG_OP_DLY);
> +	sdhci_set_uhs_signaling(host, timing);
> +}
> +
>  static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>  {
>  	sdhci_dumpregs(mmc_priv(mmc));
> @@ -252,6 +268,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> +static struct sdhci_ops sdhci_brcmstb_ops_72116 = {
> +	.set_clock = sdhci_set_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_brcmstb_set_72116_uhs_signaling,
> +};
> +
>  static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  	.set_clock = sdhci_brcmstb_set_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -282,6 +305,11 @@ static struct brcmstb_match_priv match_priv_7445 = {
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
> +static struct brcmstb_match_priv match_priv_72116 = {
> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.ops = &sdhci_brcmstb_ops_72116,
> +};
> +
>  static const struct brcmstb_match_priv match_priv_7216 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
>  	.hs400es = sdhci_brcmstb_hs400es,
> @@ -298,6 +326,7 @@ static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
>  	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
> +	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
>  	{ .compatible = "brcm,bcm74165b0-sdhci", .data = &match_priv_74165b0 },
>  	{},

