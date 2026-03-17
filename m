Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797113ACA72;
	Tue, 17 Mar 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746910; cv=fail; b=jjEv5+Ta0Ww5e9I1HV/O4QkdPqJYbl7Ez5kh20gTF7WnD1b6GeDaxVCBaDxEhyoyVlKhIugX7F+qUIVPS45XQyOTklYWxWUsRdbdCF8j6a7EBn4LE5aFpzFP9E4d2/S4a71ieV92cmQSBZz77sFv/N4ZIRjIILQatKjqxO8pzZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746910; c=relaxed/simple;
	bh=CJuwca526CovWnNdCHzzBuQ+wSaEbisShA5bWpejDjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P8YQCAgZc+fW2jYrxKPQUowrBJBWIQhvkK5I69U8cLCUb00lXvY8WVAXzd2ejA6YHFZ5QlYJWRFIbBYy8jJf8oi40gXZWKrUsYkPzU3AyrM5ZTBxQRxin3/C51eDuBY1y4+oAY8Z0lD37vqv2JtGe93FFlnG++tO2gQHLIU0lD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQYP2PGR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQYP2PGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773746909; x=1805282909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJuwca526CovWnNdCHzzBuQ+wSaEbisShA5bWpejDjY=;
  b=GQYP2PGRGESkXhZMBTQnscZVDZDJvB2HvFprLrRwEhxPA0fPABd8GXiN
   GAAtL2FsB/fPIR6wyooSlqDf8zoQbtO8hYWxKtap82EbqtCE6sHdkgq2g
   ffndWWp72VkoOomRYbD+P3y5wKxuYhvFPliX1/zwnJwiLuX7u9By/R3AK
   tRiYjHKPH+a7Svzm+MsNumscBW39RgyGyUm3WvtP2JpV4YxG2zAv2JJcE
   rubDSzqKK6LLDuSVCV61cDzHCiqkYGvPNpZpPz6FnE5L51c/GFQbZPO8E
   b7T/nzqAeXONXcE3IvIsfxv1ynyhOxVPXyeNZ9HHxjFmOWpjMlX1PQ86Z
   Q==;
X-CSE-ConnectionGUID: CXxu5COkReCzgRdd9kG+5Q==
X-CSE-MsgGUID: b45ceQywTQOQBBbbXToeRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="100232048"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="100232048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:28:28 -0700
X-CSE-ConnectionGUID: 8C6Cj3gFSPSUbGEYeVRCow==
X-CSE-MsgGUID: NGxf70o2Q52Doa2P09GHLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221275184"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:28:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:28:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 04:28:26 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhGwCmRXptHP1nPC6o2MB8uI38jw2yz/nuOHByDnOjbddPOgqAu0ZlKwF80YutfY4KaTikiRFgQSm2JqdvUkRcjZh+kQf0YSnTIxPaDrbuVNqmawWMSiQP72vn7uHmSGY1EJMM+KzrjlU37W0o25PwWmo4ign2rWYmTg82aYRrx1ZnE11VkE40alZNUCy4TE17ZOiUEdZlkpDZ9a2r3d51LhS4tE6I9s6PYDZ8xmevChS4ETTKxLfln59DzW3vFu9ovmiMO3QynDO+nb0p+xNRjuBjdFYyNpeYGQJOKwm9C7IPGdu6S7sVIhQxW5owhvd1/oKiTT5wDRvLYJcQ87nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvZLRAOMt0yRTRtRw3SruvQCOpm39uj+U7RdIO5J31E=;
 b=aUAo2jN5qCIQNoB0hmfkT11MdIvEo1rs42Nf2MU40yMlWl6pDMB7sY0fO821xdqicxxWclMYUoKCDdnhYJkB4qC5IqUPTysaiU7Nxirf/QC6az/9PYzyujOrb/CP9nMehnWQa01RSQ2UHWEuZA7lstztXzdlZR9vAQ6Q43UwyMxRdkrRV7c7fLPw71xqs8PaH6iRjCCOMDDVt4J8MbOkjJLkvbtXSbVXvfNZr9ILChHpqnOdPgJt7ZHtHuHcssErKKgOibH19ID6kGG1pKpm1HgTCmCB+KlrkLc8MkArA0t7DCX8s/ItO0dhNOUqgfobTK16tnR3GIXs8TOYgPxx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB9160.namprd11.prod.outlook.com (2603:10b6:208:57a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 11:28:16 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:28:15 +0000
Message-ID: <182321ef-f01e-4bc8-8f23-aa85b4c70860@intel.com>
Date: Tue, 17 Mar 2026 13:28:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] mmc: sdhci-of-k1: add regulator and pinctrl
 voltage switching support
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
 <20260316-orangepi-sd-card-uhs-v3-2-aefd3b7832df@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-2-aefd3b7832df@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::22) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cc5122-b564-4d3b-7486-08de84184770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Tiaa3eCi/CJI6V7zPLCzVQsbUBVZvKeZ/4xX7//S4+KJA8UOMmQ+RhCHUloPvwThzI9aq76d1cHJVnKJdAVOefKWEnydT0B5gcCcLf9HsEvg/Jmz4MDdhWTeUJzbVcyFBVIZQJAFzOjYaQr79PA2qI0rDuQR2EnRMW8stzTlcXKUkoZpBZ8a8wTgrO7EYOC0xfJSxkhGUhLScO6Ua1mMz/0rw+UepaDenyLZl5zo31//IaSQ5G8q/iaeL+NnjS00eG3huoU1zqQHgvHQ4MIPUs860IagS2m4xnTTN3JENtqoYs50DRdDGg2LqbIV6KRQiKcQiHrHHhXs0QFiTapCHAAnvQh8xVSDoLhXtu/hdbBQtvVxQK9nAORjub9Bb57IMaUJx7UTviUKzvPQwMwtIvzS7mNtZ0Kl7/J5p7szQcQeTh/40rFeErKxgbesAAxL3ZrzrbUtAZ5Wl6BmgPvchPwjA+lqOYFM2jOp0A2cx3hsjutH9p5Hy3KQRf5KMdBSDdcuWKoakh6Z7jBINoYzkIaAKciNbn9qoJyOKYj1Z4eZPEJveaBsjQ37y+OyluJiCIbWkmrJcoxxIzwNo/reI7YNgMMCljpMfMTVU6PmYNnmtsHVL8wnnOnL6T5bm3vXJzBfSO01WCQfpVXKU0YMnsYoCFhYzg6JoyNmKwPAnb24blwp56xyZ7hou2eKorC1M5Le8jR/LG676ef5uLZRadRFkldmua/09gxp7frbkh4SESa5gRN3OxtY8sNFEggUwlgdSPAYZ+bdG8SxKMPT9Ayy3rzirNQbs0n/YxB9tLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2dwQXdZNUJ3WHhkMk5JR1pkeGFwNDRBQmdlRkNJQmNtT1BsaWxPamp6Wmpt?=
 =?utf-8?B?TllDNm1xL1FkYlFHZGRnV1NrZUE5RldTcUs0VFdpeDFjY01MeTl2aER2VDRv?=
 =?utf-8?B?VEtiNjAzYk93cURSSjNoMmtLNXJOUENVc3Q1MUFydXNub0d1WXkvKzZ5dGxH?=
 =?utf-8?B?eFVRL2dpUm5CSnZDRnpFRkZlczI2NGVJRkgvZXE2WUhReFJnNWFFSTBqWUZQ?=
 =?utf-8?B?c0lHd2hIRFFEUmZRSStJVHFhQXgvazIrRTlYQUhqOEhCODVleS9BYU9NRkNn?=
 =?utf-8?B?ZG5DSlNlejlBaGpCTUk4ZUtiMVZXbG02M2VsenFESjVJdndzcnVtL3NiVTRY?=
 =?utf-8?B?RlY5dzJkVHk2UlM5dGJnYksyVUFHRlNuc1lYQlZLS0lzTCs3WkZ6MDhqUC93?=
 =?utf-8?B?WjRoemNsUlFES3I5UFhhWGYyL2FEcWRVWCtSbEF0VUVGKzlYM3RRWEptMFJ0?=
 =?utf-8?B?NlNZN2FOOThmVzZhYVdJZkNzVXdzc3VQdjl5YWlDNkdmOC9IQXVtRjdrTjht?=
 =?utf-8?B?RVNFeFhyVUpkN3FXWERGM2dZSmNUdkl4cUdjYVltSExFTkRqcGJxeWliaXYv?=
 =?utf-8?B?bGp6RENySDIzakZCaG11MkwrWFlGUmJWeWtOdDdlejFiR3FJR2c3ZzYvTVc3?=
 =?utf-8?B?WkUzYksrSnF4TUlObHVKRlRKcTVPRHZ6d0p4YW9OeXBUaDlSZ3VuZ084K1o2?=
 =?utf-8?B?R3hBMkZmOHd4RWVYQnBTSUpZdHViUW1vemYxRUYrcTB5SldWZTlmWkJseUxP?=
 =?utf-8?B?RjF5U2pNYkthUXNTS1pJZmRzbDZvUk9ES3FXNkd1Z3YyVVlZK3hvWlFaZlJL?=
 =?utf-8?B?VUZNWG9tY1hEVHZSeFk2NVpmaGR2bEE0YWJ6R1IzS1BBWXpGSW5tQ01UeHhH?=
 =?utf-8?B?Mmc2SUFEVFNkWGFBNHhKS1VqQUtqNzlvQ3ZybXBlNGZXV25YMHFHb3FFT0J5?=
 =?utf-8?B?Y0pQcmE1Qm52R21nR2NEdmNnb3k4aS9TN2U5dFpGc2FjczQybTVtei9xV08x?=
 =?utf-8?B?aDRRSCt6cTREWmgwV0d2ODlTZkMrQXFrTDRwQy9aUExveW9KK3dEMEVJWlF2?=
 =?utf-8?B?Vy9uM0RhWW4zSm9VSjdpT0NDU25wQ0hNa0VQRHVpMWNKRmQ3WGdRanlvNkJD?=
 =?utf-8?B?eW8wRkIvSVBTZFZrN3daZHg5WWZOMERGSUZzQmR2NW1QK0Q3YXRONDlkUE5P?=
 =?utf-8?B?cFRHdW5PaFBYbE9aOFNzZmFtcmZhd3NGdW00TnZyaHJ5SG1GUGpKV0RWcWpH?=
 =?utf-8?B?S0RvckFLYy9UUHZXRlJuM3N0N1gvN2lRcGIrVUF2K25RckxIZ0RsMWZIWXRu?=
 =?utf-8?B?NjFxVFB5T3F1cTlUckZCanUvUW04cHdvaStFNWg5WHozN0x2VDNlOENVaTF6?=
 =?utf-8?B?MFdaUWdMdldCcmw2SDBhYThoSU9UcEtnSlFCRHA1b1YvNkRuNFRuZDZUY1kz?=
 =?utf-8?B?ZHNuR0hiR0F0VGdHc0pOeDlxYVN0ZlRhRlc1MTNUazkwQllxTmgwenkvRVc4?=
 =?utf-8?B?c2loMUZkdkI0UENNUGVJaC9pa0dZanZjNzQxV3AxZ0FzQjJvNWJBdmlIV2Nw?=
 =?utf-8?B?ckNsOGZ3b3VXN29yOTVEWVcvcDhYNFIxSkpSb0tBcm5YRmw5SVJvSnhabjRr?=
 =?utf-8?B?bFlSNDM5ckpQWWovZ0ZHaG9wSHg0cDN4MjdJQ2Fua3NTcGV0SXJTd2VYQjkr?=
 =?utf-8?B?YWxCWUFzTUVQKzhTcEc4dkQvbWhRK2RDZ0h6NDgxeFk3TDhLY3VzOVRLQXFN?=
 =?utf-8?B?Z05xL0xNTS9RZG1aOGkvbEdEVkQvb3NnakN3WGxTRm90QzJCSDVkMEdUZGJ0?=
 =?utf-8?B?WGVLWmdxTGZnNjI1cldhbVZaTytOQWxsNDd0OW1yOGIxY0cyVGJpVmFuL2RR?=
 =?utf-8?B?ZHZDY2FkR29nTkJEM3JnM3JCUzAyZjhMNG5ZR1JSalF6V2R5dExXZDd3ZU9x?=
 =?utf-8?B?M09RNVFRSStSVitBWlNnRDVRQVNWNHVLTU9wY2p4NGZPNkpsNU0vRU1kRVh1?=
 =?utf-8?B?Mk9GSmhEQ2RrMmZGS1FHZ2NzeTFTMXZKSitkNy9yV3U4NW1kazJySGlSSkM3?=
 =?utf-8?B?NEtvcit0eHdUSkdrREJPT25Pd0ZTYkdETHJ6eURzUXREUkFpRStjQUVhREdp?=
 =?utf-8?B?c051VHRmZmNyTERjK2JTUUR4UVVZaU5lN1h5c3pUZXNiVjlZcHBjNkt4aUJn?=
 =?utf-8?B?c1FWcUdmU0lSTngxSzJ3aDRzWDVtNzdWNlhnTmh2N1hmOEY4T3lMekZWWXlv?=
 =?utf-8?B?dXFwWUt3Yk9haEdOYVlQMWJ1MWFMNEp3ZGV5K0J0b3RJSEc0RkIvYUZoS2Zy?=
 =?utf-8?B?MXRQZDV3Z1BtN250NVM3eHZudmhsdUdQd0pOYlBINThKMjZSaEdQKzJqekRo?=
 =?utf-8?Q?rqAYyue6t9k7kbLk=3D?=
X-Exchange-RoutingPolicyChecked: V/NRuZQwUFXvL6qtBAYH4HUCBJdojaxFe+I83sTzzQ4ekr2CLhd7KAeHcJl0U93uBJcdeyc2cyMyMwwHtxkZq5KSDyk5JBdCf4V/Qz2A4kSO09JZ+M8u3xzoBa42thNBwAC6KgOibLsAn8qp5AZx16aWHVEdfNti8luzemuYw5cT/chFeW4NQANqxovgpT9VN7ilfFgsQDrsjPxPiMw311PFXt4Q9yE8dyk3HAPD0oIh/5IEL8Di+5eEmRKEIp00SiGHww4dlXi9IZeEniIb8EVx17VvS7IQnzzrZXIoYcDj56KYAdNXrxvyqVnQ66y7IfZw8i8MEEtGX1oV3HII4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cc5122-b564-4d3b-7486-08de84184770
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:28:15.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ow2CBjQ1N4QFrenOQ95PoYhtvn9HIpqCW0NnH2GMvpExSUDa+G4QIx5VWw4J1+7wc4vhxOiiBp5toKaAg/MPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9160
X-OriginatorOrg: intel.com

On 16/03/2026 16:03, Iker Pedrosa wrote:
> Add voltage switching infrastructure for UHS-I modes by integrating both
> regulator framework (for supply voltage control) and pinctrl state
> switching (for pin drive strength optimization).
> 
> - Add regulator supply parsing and voltage switching callback
> - Add optional pinctrl state switching between "default" (3.3V) and
>   "state_uhs" (1.8V) configurations
> - Enable coordinated voltage and pin configuration changes for UHS modes
> 
> This provides complete voltage switching support while maintaining
> backward compatibility when pinctrl states are not defined.
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770..01afdadcf70796704b272ee5a31543afd5e01188 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/reset.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  
>  #include "sdhci.h"
> @@ -71,6 +72,9 @@
>  struct spacemit_sdhci_host {
>  	struct clk *clk_core;
>  	struct clk *clk_io;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_default;
> +	struct pinctrl_state *pinctrl_uhs;
>  };
>  
>  /* All helper functions will update clr/set while preserve rest bits */
> @@ -219,6 +223,33 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
>  			       SPACEMIT_SDHC_PHY_CTRL_REG);
>  }
>  
> +static void spacemit_sdhci_voltage_switch(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_ios *ios = &host->mmc->ios;
> +	int ret;
> +
> +	if (!sdhst->pinctrl)
> +		return;
> +
> +	if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
> +		dev_warn(mmc_dev(host->mmc), "unsupported voltage %d\n",
> +			 ios->signal_voltage);
> +		return;
> +	}

In V2, I put "->voltage_switch() is called only for
ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180" by
which I meant that it does not allow the driver to
switch pin state back for 3.3V.

So you probably need an approach similar to the original
spacemit_sdhci_start_signal_voltage_switch() in:

	https://lore.kernel.org/linux-mmc/20260302-orangepi-sd-card-uhs-v1-4-89c219973c0c@gmail.com/

> +
> +	if (sdhst->pinctrl_uhs) {
> +		ret = pinctrl_select_state(sdhst->pinctrl, sdhst->pinctrl_uhs);
> +		if (ret) {
> +			dev_warn(mmc_dev(host->mmc),
> +				 "failed to select UHS pinctrl state: %d\n", ret);
> +			return;
> +		}
> +		dev_dbg(mmc_dev(host->mmc), "switched to UHS pinctrl state\n");
> +	}
> +}
> +
>  static inline int spacemit_sdhci_get_clocks(struct device *dev,
>  					    struct sdhci_pltfm_host *pltfm_host)
>  {
> @@ -252,12 +283,37 @@ static inline int spacemit_sdhci_get_resets(struct device *dev)
>  	return 0;
>  }
>  
> +static inline void spacemit_sdhci_get_pins(struct device *dev,
> +					    struct sdhci_pltfm_host *pltfm_host)
> +{
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhst->pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(sdhst->pinctrl)) {
> +		sdhst->pinctrl = NULL;
> +		dev_dbg(dev, "pinctrl not available, voltage switching will work without it\n");
> +		return;
> +	}
> +
> +	sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");
> +	if (IS_ERR(sdhst->pinctrl_default))
> +		sdhst->pinctrl_default = NULL;
> +
> +	sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "state_uhs");
> +	if (IS_ERR(sdhst->pinctrl_uhs))
> +		sdhst->pinctrl_uhs = NULL;
> +
> +	dev_dbg(dev, "pinctrl setup: default=%p, uhs=%p\n",
> +		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
> +}
> +
>  static const struct sdhci_ops spacemit_sdhci_ops = {
>  	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
>  	.reset			= spacemit_sdhci_reset,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_clock		= spacemit_sdhci_set_clock,
>  	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
> +	.voltage_switch         = spacemit_sdhci_voltage_switch,
>  };
>  
>  static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> @@ -324,6 +380,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> +	spacemit_sdhci_get_pins(dev, pltfm_host);
> +
>  	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>  	if (ret)
>  		goto err_pltfm;
> 

