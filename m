Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894792C21C1;
	Thu,  9 Oct 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000463; cv=fail; b=BLT6o9sWe73b424z4GykQilgnDgyUtYrcVDZOiIjN6zGpG2dT4UiTgLCA4QlLR1T4a1h4PTBWUTN//SrL1ITN4ErptJ+IiKJzU2wQfO28q7k+/IZ2MQre2eQzH98g0UEOlH6jud83o8qmFdEZ10EqO1NW2Djb3vltDOU2/w1rng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000463; c=relaxed/simple;
	bh=tMTHw37drI7adgHi8swnlbP04DnFVLaZ9KjB4SlIQR0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lt0wq/ZLEqCxVHdQOjFVudxYiX8AsJcSKa2CCQntb+TcYY+RSIWTtIcmKnppkyVc0Oc5OASBMYALU5Od2OlU3+NBWWZ+e3aBM/Af63LLB0qUpBQCPIyGM8N6fJfEgQ7q9O4e/PfMioEo4QtIOYXTETKGKPtZoaPxH3p6iSc7PxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+4PRe8x; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+4PRe8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760000461; x=1791536461;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tMTHw37drI7adgHi8swnlbP04DnFVLaZ9KjB4SlIQR0=;
  b=Y+4PRe8xcFco54HbpceKEo4bKyHa/V/1MWWl2T0FtSQK94GDyr3cnA52
   2svpEmMfJZmKIzpK6mwtPCG/KBkPgVuhQqqygJNMAA+ggQlhLSVTdulei
   Er4CGwPZwvlHZ0lhXsyFs4xklUAQqsu8RTQ+WeAI4NBr5tgOIQzSAkPBX
   qFKYP0+SFQoxMyB1pnRzvFLqB43xOWNkHWmyhiKAL/WRKsxS0DdmkpeMm
   jyG0NET5jWUOffZD6tLp3EIEvrM9D2vsQ3D7eJLSr2BqIDssCqFyHn9sj
   azbiNLHgcbMFdrZ0FY4Nw8StNmvICMJS5PMjwClCvA70F89Gi4do9YSqn
   w==;
X-CSE-ConnectionGUID: nFqHPX5+R9qwwBBkTQkjpA==
X-CSE-MsgGUID: P0ZuMsKCREaNQfzVuJxRTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72885772"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="72885772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:01:00 -0700
X-CSE-ConnectionGUID: +Wrgq/5dQw2MewzHvSzNPQ==
X-CSE-MsgGUID: 2YxBFOIfRKiDQFRPm+WyVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="179774028"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 02:01:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 02:00:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 02:00:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 02:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbCl2T5LJWKMfolK2tNdS+QEwqNKSop/DRHbRCcYq5QOJBuatZFt38/UdL00y64m3rydMe0PQvXZ/CgtPuF0c+4QsAznP6GE8nAhRlHCj5aCJMnqwxgUwPBZmiuOMUUX4CxYpx/vdjAdEyMc5yN3X4P1ohEhoxkH1yyl+rYfxT/eoGSDo1AhB+8t7ghcZ9y9DcGGzRV84EUmyXGwvAB+3tBAKfPjZGNrK7z56qBXFaDZIwGjO4lSBZnEzgMqTRInkLoOBF6jCQ3ScRl8iTUekkKetc6l7vg0wVHbdjB+SVEMKTs++RMoK32WlT6hbi/UmUMAW2LW4nN62NEbqh/5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KONIayVUmnoNmY6E7G6LkcRBoJBDSN0E7gMKpaUICeo=;
 b=NUnAWJ5jeE9MGqCpPpBh6+MzwwvQW2D+B/Lp1yKgs59+/nnoIpFgXf4kqA8H7CAjLhBcxJfGxoD/nRdNoLDVBNi14HIvG+9svgL0J6W3XMWy9kXtRN40DSfGv96B2CPjmVEdRROruaIOc/DaXlSQBVvOzrS8EEasL8jejra8o7shQSWcHyRB/+CcjzalOeNlEkUUzPGOcpPvwMAW9Uaf7lz512oPds5ytZ5dN3+TLg1VvrfZyi9y/VZ9/TtMjAKATDEBRX/PG9Wm5XzxA+SCI+BGwxcHiecgn2w1nLBELPsxglRQc62yL6Vgjuqx6QvCkqzlvmcqzxuiOY+uNmDUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:00:57 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 09:00:57 +0000
Message-ID: <20b3bd27-38f9-4ab0-b6ac-dd1430c9ddb4@intel.com>
Date: Thu, 9 Oct 2025 12:00:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mmc: brcmstb: save and restore registers during PM
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
 <20251007140434.606051-6-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251007140434.606051-6-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|SJ2PR11MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: b6438c42-cb6c-4dba-cd50-08de07125c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME82SytwdHhBdE9VNmk3clZxdFRtTEFhYnpick05SVRSalNDbkV6UHN4L2JZ?=
 =?utf-8?B?STNhdHpQcTZoOGMybUd2TlhBUWtyWTFXUHYwZWNxMWk0Ui8rRlN6Mk51OUc0?=
 =?utf-8?B?MkIxVGM3cUtnc1pYUXBJM2FIRlV1NTNER1gvb09lRHE5Mkk1V3l3TXlLQmZn?=
 =?utf-8?B?eC9SWlNYVTIwTWlRa1JmWEhvT0thRFVwU2FkTS9uRk5ET2ZQTU5ETmozMGUv?=
 =?utf-8?B?U3NtQ0FNRnROa2w2Y0lVcTZTK0lLeWNPWnNEekVQNGl5aWwzMmNCLy9HMUM0?=
 =?utf-8?B?TDFSZ2hKZUZESXRRT0pjU2c2TnFseFNaUHUxTVZSdDVwbmtpcDd3eFhvOERk?=
 =?utf-8?B?U2c5TVU2QjcvUnhSeWk2OFRPd1JpVkpYSCtLU1NpdXU4YlJZSWtOSzFXYjVZ?=
 =?utf-8?B?Nlh2UkRoei8vakdEcDd0U0RpYzdoenVPNkVzVERzNkRzZWF5VkZoL2s4ZldR?=
 =?utf-8?B?b0JDN2hWKzlSbkZuUFdmWmtjay9HU3hQMVVlazVNNklHYVZlbThEQUpwUVAx?=
 =?utf-8?B?emYrZVpEL1lBMU0yY2J1a0RzN2RjU3E0UDg5eE9oYmZsSVFhNlNtQVEvc3dt?=
 =?utf-8?B?NEhDYnpQbi9xdHVMeXkyVmJVWkx5ZVIwa1RUTm5yWGZySG9jRlBlY1c0cVRN?=
 =?utf-8?B?U3lwYlNvbUlJTmZSbUhnckVjNTRIS3hVV005cFRHK05RWXRXSk1iMXJiSzdu?=
 =?utf-8?B?RDZkSkNBOSs5aEUrbW9FR3ZFQTNkeVVRb0ZRaVEvV0U4VnI5bjZQZ2ZjczVu?=
 =?utf-8?B?ZjJYdTF6V0NxZno4Q1ZxRmFuY2RsbTFwelFoOGg0NWQ1ZnpaNmlYY3JBZkc4?=
 =?utf-8?B?ME4vRGxBTHhYSTBpc2tFaTdrSXRUcHo3M3hjdFVRMG5vOE9ieGE2dFF0dUVP?=
 =?utf-8?B?ZE5pR2ttNVlldUpIVUwyYjl2azVzeXhtcTllZjZDZFcyVHcvbUxVbkdpaTdI?=
 =?utf-8?B?bkRFbUNKRXNEamhTRk12RnVHUDhvcEdyV3pUWEtpenlSOWJtVXVJV2VWZkkv?=
 =?utf-8?B?UkdOVllLT2laV2xIdWFIeHlsc0p4dUF1SnBldzVlOWFxOEdVeVF6UnlkYXZr?=
 =?utf-8?B?ZEhIYU1QdEwxeWpNRHZENFpxYUtMTTVudWJVVVJMcVZQS2Y4SGlpZWphd05L?=
 =?utf-8?B?cWxhMTE5K2syOTJHclc5bzl0WXF3VHNvbU1rbU16SnZnSGZhc3NBMms2bkVW?=
 =?utf-8?B?SlFEZjRZRGJ2VEFNVGUxdDA5WmdCTEZWbkU2V2lnU05BM3Vhc2NIemZ6TEhy?=
 =?utf-8?B?b2V3bzBjWUswQVRIODY4RFdJdy9tWVlZS3pMV1JwWVVQNWZBSXd1VStIdUhm?=
 =?utf-8?B?YXFEMlFYYXJWaVBEV01SUlg0MUlwcHZPYTY3MlNKenRaVU9zSFBlYWVmaUlQ?=
 =?utf-8?B?ckh1VDhkRzFpUTlXbFlsM2Z4VlpvbXBqMGVHVzIzcTdnWmY0b0cySkVVUUpl?=
 =?utf-8?B?OXAxZmh4QzJUQ2p1SjBnTERnTGY2emtZSzRROU9oM3N1RXhXV1JsR3JWemtB?=
 =?utf-8?B?Zk5oOEswaWQ0K3ZWTC9VZGdWelpXWlJoUndTVTVVS3BIWm84WncxL3JJdjFR?=
 =?utf-8?B?SXA5anJKVzFSZHFoamllK2NORUVkM3IySFJPdVVNQ2VYYS8zWWZPZ1Yxa0tR?=
 =?utf-8?B?VlhxeGNCU1Fiby9ZaEF5QysvMDhROWllZHRncHMyVTFTbWx0UDJnQWlpWUlT?=
 =?utf-8?B?Y1ZlejgrZCtMcGFjYWxZV3pRY2FzQzZ5ZFlPWUYxSWxlU0JnWStKYXN6QXJP?=
 =?utf-8?B?L2tjenlUNUNudEZvSUFQMDh2bi9tVHlVaGFkNGlNTHlobSs4Um1BeXB5RXFl?=
 =?utf-8?B?UVlSUUJPcExTOFFHRWVsS3VQdk9SMm9OOGxqSVFVT09QOHorbDAwUG1SRVpD?=
 =?utf-8?B?MVh3SitpRFp4K0szM1lwYUpsRXNxaU51WVlQaUFIOGFTT3I1Y1hLeDFRMFpE?=
 =?utf-8?Q?VVRGmlUIv5b5gdgbP1QPJUixjR/ckyt9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWk1U0lLK0xVUTh0cHBucjNxY1dPYjRpQTJWUDM2QVJmempwQS9FTGlZMUJv?=
 =?utf-8?B?dmF3R2NaY1FuQnhjWGhJKzAzcGlaM2VHMVM5Y1dxcGdVT3ArTXI5cDlHNi9L?=
 =?utf-8?B?a0E4bVkzejlFVG5Sek8ydFk5blh6Ym5zZjg4OW1sM2xjTSttWHViTFV6MlIy?=
 =?utf-8?B?TjQ1UkY0THpSaURWNGRxaVRmQjF1VlZCSUVJQVpWbUNacFY1L3lpdzJnWU5q?=
 =?utf-8?B?WitlMjVhMEtmWGhONDAyWVNkMTMvcTR5aytsR0o4QXpsUzlGcVhqakpkbVlM?=
 =?utf-8?B?VldoTElSbHZvMHVQbjlkYXMyWTRxR3VNSHVZdUU0K1hyTVFZNFdEMHl0OXZ5?=
 =?utf-8?B?akJaeEo4bGUvamJBMGY0KzJJNVFwZHdkZXZvTzVZaVd5ejZYZ1o2M0poS3VX?=
 =?utf-8?B?VWJ2Y2ZtRnFlT1lna3VnSmxPRGZvYlNqc1p5VEVFcThYRmxUeFI5VlZFZEdD?=
 =?utf-8?B?aU1jRnJyc3BWSWM4VnIvYnVrSXA2dTkxUXUwaUJiL2pFc3UrVlhnMS9KYmJ3?=
 =?utf-8?B?VnFpR3I5bkxnR1lQUm84ZXlUemxQblVmcVYyS25KVk9GNmxIWlhad1pqRkhH?=
 =?utf-8?B?NitMTWF2L2o0S013VDl6anBWdUd4Q0FBTDZlQ1BrejhmUDY3M3hBcDJEK3lR?=
 =?utf-8?B?bisrRmRwamJ0N0N5SGRDV2NDYlVUeUJBb1RyNVZNZkJLVVlHMjVKQnI0cWxl?=
 =?utf-8?B?dmFaZEt6c3ljR1Z1Qko5Uk9CeGZEZ0F3cTlUU3pCcnAwL3VtT0llYnVYNmtl?=
 =?utf-8?B?UjhSelRNckwzUWZpTjhnWEVXZFpnYXdrazAvWnI5czZhSGV2S1J6TFJyUlZ4?=
 =?utf-8?B?ei9GdGVpRlBkVUM1WU13NllUdlFGSUZpZ2JxbmQ3Kys2T1huL2RuTVVnZWcv?=
 =?utf-8?B?dXRtOWdwTjl1bllWTmMwYWZKeWE3bklGRkY1VlplQnBONVNHU2cyRHdMY1hU?=
 =?utf-8?B?S2xCOWpqUmQ1d1JuK1BYTjYrOHBrRmY4QTBrdnJyNVd2aFpWZkxEbm1ZVXhx?=
 =?utf-8?B?blJPTi8rZk41OURlemc5OVJ1eXdZWXhQY0Vvc3VtKzRGbWlmd2JSTkpERFBv?=
 =?utf-8?B?TmZKamM3bHNYTjRTc2RNNGNpbjZ5cVBqQnVma2w1b3IxZjd2a1RBbzRBYVlY?=
 =?utf-8?B?dzlpZ0t3QWw2YUo4NzNma0NwRHdyMzVQUnRvSDg0OFdPOXFKcWJ2M3RYbVlD?=
 =?utf-8?B?Y3AxUnI5aTRHRk41NzdKOE80eXlWK2Uvc0tBd0xodExlcWRsVWdxNlBST3Bz?=
 =?utf-8?B?QTI3Rk1WRkszNkpIZGd3ZkVDcW5CQTlZYmR6YUxRVnloS0RHTzhWMlhyd25r?=
 =?utf-8?B?cUNuOFZOZHNYWVN0T09jakpzM1E0MHRYczljR1N2eHF2Nk9NVUVQRTBBSXpq?=
 =?utf-8?B?ZjZqUUFrbUpJd01XSWVSV21Tdlg4Qk9mTk5tdEtUbTRnYjFrY3lCSTBwTXdY?=
 =?utf-8?B?azlRTW9PcHlMeEc5ZFFqb29XVHkxRFREblVmOVhjZm05UEZMRnYxcDNHN09X?=
 =?utf-8?B?L0RJTFgxMlpUSHE2TU84UTJDUlVlSnV5M21zOEtmZEt4dmpDVmdoU1RUVDA4?=
 =?utf-8?B?WUhSRityb1BwSGNpWXlqQWJ4bFg4WWRocml2dWFFNUxlbTZIalJuVG9zUnNv?=
 =?utf-8?B?eWQ3TlRNRXVyYzEvdUp1RHFKN2wvVHlFMVhXSHF1M1VvcUR1S3o0bW5zUkxv?=
 =?utf-8?B?QUdlOTJ4aTQ5YmQ3Y29ES2JUQVAxWVJCaVZIYWRRR3QxSHZnWGZIcGJNNmFL?=
 =?utf-8?B?eGEwck9VbXFEWnRIR20ydkZMNmhNbi9HMmNsVDEyUHQvMHlha2VRY1pSbFRo?=
 =?utf-8?B?ei9HM1licXNFWWwzL1JoNDBJU3A4eU84b0NmSi9rRHlINEVtcUZYcnBvVWpL?=
 =?utf-8?B?RVdzUlVsWUhGTklJVkVLOWhPdXE1Ky9Lcm8xSld4b2NPTjZtcE4yKy83OGZZ?=
 =?utf-8?B?UWRlMXU1aHdGYmx5cTV6NGR6YkhpcGoxci9yR3JKUFFSYklHT0o0TGp3a005?=
 =?utf-8?B?OXBtTE82QlNsNHBDVjlKYWVMamM2Zjl3T2pWdy8zNjRBL0VvN0wvTGhUQURN?=
 =?utf-8?B?QWk3ZmJERyt3VGUxSFU5YTlNbVBLWU5HMFdwMkJUL3J4QXhERkZ5Y3RsRDQ1?=
 =?utf-8?B?K29BV25LYklpWTdUcE83c3YxWDFDWE55dlp1a2Jxa0c0ZS9ZTWxhWldqdERK?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6438c42-cb6c-4dba-cd50-08de07125c09
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:00:57.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUqiL9PF2KgWA0mAHp3gcxNp7/naTpYXGXA+vdazIwbMwdgMF1Se0zDNJtGhdd68Pg5QXi1fOq4sp1lWPmN8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

On 07/10/2025 17:04, Kamal Dasu wrote:
> Added support to save and restore registers that are critical
> during PM.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 112 +++++++++++++++++++++++++++++--
>  1 file changed, 107 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 42709ca8111d..7de395c86f2f 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -38,28 +38,109 @@
>  #define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
>  #define SDIO_CFG_CQ_CAPABILITY			0x4c
>  #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> +#define SDIO_CFG_SD_PIN_SEL			0x44
> +#define SDIO_CFG_V1_SD_PIN_SEL			0x54
> +#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL		0x7C
>  #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
>  
> +#define SDIO_BOOT_MAIN_CTL			0x0
> +
>  #define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
>  /* Select all SD UHS type I SDR speed above 50MB/s */
>  #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
>  
> -struct sdhci_brcmstb_priv {
> -	void __iomem *cfg_regs;
> -	unsigned int flags;
> -	struct clk *base_clk;
> -	u32 base_freq_hz;
> +enum cfg_core_ver {
> +	SDIO_CFG_CORE_V1 = 1,
> +	SDIO_CFG_CORE_V2,
> +};
> +
> +struct sdhci_brcmstb_saved_regs {
> +	u32 sd_pin_sel;
> +	u32 phy_sw_mode0_rxctrl;
> +	u32 max_50mhz_mode;
> +	u32 boot_main_ctl;
>  };
>  
>  struct brcmstb_match_priv {
>  	void (*cfginit)(struct sdhci_host *host);
>  	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
> +	void (*save_restore_regs)(struct mmc_host *mmc, int save);
>  	struct sdhci_ops *ops;
>  	const unsigned int flags;
>  };
>  
> +struct sdhci_brcmstb_priv {
> +	void __iomem *cfg_regs;
> +	void __iomem *boot_regs;
> +	struct sdhci_brcmstb_saved_regs saved_regs;
> +	unsigned int flags;
> +	struct clk *base_clk;
> +	u32 base_freq_hz;
> +	const struct brcmstb_match_priv *match_priv;
> +};
> +
> +static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
> +	void __iomem *cr = priv->cfg_regs;
> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
> +
> +	if (is_emmc && priv->boot_regs)
> +		sr->boot_main_ctl = readl(priv->boot_regs + SDIO_BOOT_MAIN_CTL);
> +
> +	if (ver == SDIO_CFG_CORE_V1) {
> +		sr->sd_pin_sel = readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
> +		return;
> +	}
> +
> +	sr->sd_pin_sel = readl(cr + SDIO_CFG_SD_PIN_SEL);
> +	sr->phy_sw_mode0_rxctrl = readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
> +	sr->max_50mhz_mode = readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
> +}
> +
> +static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
> +	void __iomem *cr = priv->cfg_regs;
> +	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
> +
> +	if (is_emmc && priv->boot_regs)
> +		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
> +
> +	if (ver == SDIO_CFG_CORE_V1) {
> +		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +		return;
> +	}
> +
> +	writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
> +	writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
> +	writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
> +}
> +
> +static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, int save)
> +{
> +	if (save)
> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
> +	else
> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
> +}
> +
> +static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, int save)
> +{
> +	if (save)
> +		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
> +	else
> +		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
> +}
> +
>  static inline void enable_clock_gating(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -306,22 +387,26 @@ static struct brcmstb_match_priv match_priv_74371 = {
>  
>  static struct brcmstb_match_priv match_priv_7445 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v1,
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
>  static struct brcmstb_match_priv match_priv_72116 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v1,
>  	.ops = &sdhci_brcmstb_ops_72116,
>  };
>  
>  static const struct brcmstb_match_priv match_priv_7216 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v2,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_7216,
>  };
>  
>  static struct brcmstb_match_priv match_priv_74165b0 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.save_restore_regs = sdhci_brcmstb_save_restore_regs_v2,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_74165b0,
>  };
> @@ -429,6 +514,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->match_priv = match->data;
>  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
>  		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
>  		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
> @@ -446,6 +532,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	if (res)
>  		goto err;
>  
> +	/* map non-standard BOOT registers if present */
> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
> +		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
> +		if (IS_ERR(priv->boot_regs))
> +			priv->boot_regs = NULL;
> +	}
> +
>  	/*
>  	 * Automatic clock gating does not work for SD cards that may
>  	 * voltage switch so only enable it for non-removable devices.
> @@ -536,8 +629,13 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct brcmstb_match_priv *match_priv = priv->match_priv;
> +
>  	int ret;
>  
> +	if (match_priv->save_restore_regs)
> +		match_priv->save_restore_regs(host->mmc, 1);
> +
>  	clk_disable_unprepare(priv->base_clk);
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_suspend(host->mmc);
> @@ -553,6 +651,7 @@ static int sdhci_brcmstb_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct brcmstb_match_priv *match_priv = priv->match_priv;
>  	int ret;
>  
>  	ret = sdhci_pltfm_resume(dev);
> @@ -569,6 +668,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>  			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>  	}
>  
> +	if (match_priv->save_restore_regs)
> +		match_priv->save_restore_regs(host->mmc, 0);
> +
>  	if (host->mmc->caps2 & MMC_CAP2_CQE)
>  		ret = cqhci_resume(host->mmc);
>  

