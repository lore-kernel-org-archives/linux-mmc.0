Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496043B893B;
	Mon,  9 Mar 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067986; cv=fail; b=qQXiV0QsPabmpTN9kojfO07lPI+3f8nw8bBsc6C6Q16hUEcYv5edDZEWh9jvSqYNmEW42TxvYi+jWDAXt/3MuSa/gkuYuhHj5AKMPnrQeM35d+r19YjIMBZuz5TX2Q9+s5x6U5wxWk/KAzqe/d2W+2SrTWi5XOk6O3K/stmuaic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067986; c=relaxed/simple;
	bh=QBBfqJoyZJ/IBTTxh2M1XZieXpAtjZA8Yim4P6QHRL4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O54XTH9HwWkI7CipHaikpXUF+2D/tsRUSnJhkbxtRVerK8jLjIGJu1rFA3D3X0dj507AEqlJ/HURIriLtU5SKjONRzn6DVVACX83+WOBbFG+1WBxhrbREyiyQJhJWNsKyPx5MbDuLTXq7ScbruzjIveRUQegGRsyQRdoviL3eUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpRACyCU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpRACyCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773067983; x=1804603983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QBBfqJoyZJ/IBTTxh2M1XZieXpAtjZA8Yim4P6QHRL4=;
  b=hpRACyCUi2cFHfwRewVLcYA7lPUHshQadah7pp3TNYNP4KayuTNNeaz8
   jFjP/YjFoOsZCM8/ZnKYKvvozh3JhkdTINewynKBzKl+tWhxD0p2kSLIm
   9QreKAdocuhSCnnSVtN470fOtyZSRTu1pVYm0qFZUFrMsZ1oEk76jZV64
   fAbKlAEOIB5GMg9K2Sbav84obbs7XDDjlvMxSA6qbgu4pkcX+EcntA6vM
   dYAx1qyLZFv0ufQfL5OIzL/l+taXZGqPcfcConok+ehLVAXHyQN4i/eag
   ievzpP3hzW+gJXKBCy4iLxW2/gtPLl33FFsDXjWlovEt2Cw4pS8JIJq0k
   w==;
X-CSE-ConnectionGUID: 9PSDodM9QX6hBPsMiMTG/A==
X-CSE-MsgGUID: MDC96/Q5TFuihOQ8b6TTuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="61661953"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="61661953"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:53:03 -0700
X-CSE-ConnectionGUID: qP6j8WfAT9eUkAQH+N0GsQ==
X-CSE-MsgGUID: 00iV4PyUTjmV5ls/9WDIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218922635"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:53:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 07:53:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 07:53:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 07:53:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcNn0YksULXyqsq5NpLJ8Ehl9qMczQZ7S4dkKWl/MqiC2KdOlCnWCzTnzHaAeuCvVHzWbFId9uwhs17iT7VGG+wdaWOSz3x2OoOc6KYEIKJpOqEel4xiZcW0HLU2dgJPlAlKctWhP+zAHGO63sEVevugNv3NcroACthKp/jD8vPJOLKAlVo5jeh1gmCmHra9aVD8H2MlkiWq2NeMZuG8L4cyRPWw1QZx7uHz275c7sxyunuhk8BD5D3/UWCWgf+skkPcDFd76Xa45e4PZwx79kXp41DwYW82tG9wv/hxJnU5HptbVklUOlPh0XwVkvVCwTE+LhnChK01yNUUm3zcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gKyrSpZV22jvZfhVLDiiCl63bC1Uol/+nVXfWB8k8E=;
 b=XIpbbGfLbeQ5Ca5Ubmd+x2wmCdb/hp1/XkxHOBSqABoOb7vTGKG3M+yimVIbBBAp6LBB/+kRwkGTqPj2poRSZVfdpf3WTIk4ASzqcrDtCRxPEfGXRcAt6oJhmpwHW8xJiPQaYv5g0aOAkkY0T6v/+AKIZOE5gZq4foHjOhVRHsRrTh0BVNED/SrKXtpHlD96oOQHvh4vMkjfafgXGYDwU19OdGsB4N9NTOXKfkCk9v0ZFqqgQd2z18Kj69cmEOsIEvAK1v9KPLQl2peoIl3xe73AHdVn6hCB0qNHa6gqdx3qiOr628VIhoDkFwUJ+ZtPeP7LVA1xAoeNifuxd4UzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:52:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 14:52:58 +0000
Message-ID: <3421109c-cf72-4184-ad7a-60951a178e5c@intel.com>
Date: Mon, 9 Mar 2026 16:52:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] mmc: sdhci-esdhc-imx: add NXP S32N79 support
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Haibo Chen
	<haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Lucas Stach
	<l.stach@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <s32@nxp.com>, Christophe Lizzi
	<clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo
	<eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>, Larisa Grigore
	<larisa.grigore@nxp.com>
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
 <20260309143411.8231-5-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260309143411.8231-5-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 61266109-a3ab-4664-113a-08de7deb8d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: MKB9O+FF/Ub05CFW/WOaB5646ZyKujlu+Gsj/+wxMJDNZHe6zsPdOrYsapm5SmZxJa5HQoKhh1NFMpAOEZKBYPd7dwfbdBz6lNJnVIETfwce/6qwXqY8LeizrAreV1txNa7IWGu9e4kTJ13TTWYOTbpLuJYPbp9gYl10NwPE2lG9RhzfnZTMJe1PmtaDLOpG51nVMEudPJG3JuQ9fvqbyCOWN6aCUYIJ4yEOJrnT0v9Zzx6qr1RBn13L6aXaNI2qWpqkpbGs6er9pbO67+BHSb8uZRAW+ZGV02FKZ6ufbB/1ceXShPDikRHUeZSKdsqueK6c2LNrtLPO0hkcxZVmLRNO2tAqlgURblkbTgcrhzNgQAvXmkxoTkjyIQ0t7JU+4c9Sd65rb3uYhumx+2EahAJ1Fwle7sptARh3lyvm1D0XRSTljCpkdHI9cQwwLxuWLN1wFAkudsd//5vDCU/BREFmY7hD4V7aF8GV49L6EAzAqCrVajxcDA9q6CsKzE0aDlA/qNb4Xz8BUC5yzLsY0pArCzBq1k5wXPC2ntR7rGtmZje1UBWZddygscXMWBCJ2ZJsjCK0275wM8B49XDMnBqTI4xpLc1la4h0sTapxPi0UqZO9PIcKsVzGrNOUtfXQKBr62vHKEB51JmeeWeHQk9wRMf68w5ChXR1v7sdA08/4J96dniyj6Ua+9T0Ycpd/8oxY2g9nDTOPI+aEOifsnx+qLt0QdFXVP289s5R2ZDnsWcx5Qos76Nd1bVSCjfyEpkxPlKp2M3wOEAEZHm+NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVoZGVZR0xCSGZOeU91TjZ5THNIaWpTOWRIaXVtalE4N3pSRGJhRFZEd3Ba?=
 =?utf-8?B?UkFHb1NCNU9lbko1K0FVWjlNUGdkV3FXYUF6QkJyUmRLWFpJWExidzVqbWt3?=
 =?utf-8?B?UUpNb0NVU2F1SmVCR1REL1c4Z3FPb0VFbHJjeENsdndxeUUvcUgrd1BKeWN5?=
 =?utf-8?B?WXZKUzZEbjhhQzNsYnV3eTJzRHg5dDZSanFKaHRUbzVmQTFKUGpXRDdDbXll?=
 =?utf-8?B?ZVMzaTZ4MEZ2dlppM3RHYmRidGMrNHpqclFFOHBrZnVubGpzcmpOeEhFMlBp?=
 =?utf-8?B?ejRiNXVLK00vSG4veWpLZnRud2hSN0hZNlFxdUFpQlM1dnRGTVFweHF0SVhC?=
 =?utf-8?B?ZWxNRnljSk4wdVJCUmlDb3haa00yRDJzeUhmRVkxTS8yUXh1S25QMUZ4M1V2?=
 =?utf-8?B?UHNPR1VxZWNYUld6K2tUODAvSVBYcE5HWUNUZTJXVE1HZExzYjU5VmV3RXNS?=
 =?utf-8?B?MlAvVjBkL3hBUzc4Nmg1ZE8wSVR4N2FVeVJsYmhYeXJCTXdwRmU0MjlFejMz?=
 =?utf-8?B?SVZDeFF3QTJDRHg4L0RwRUNLdkY2OVI2RWNVQXc0N0xTVjdxRHZ6K2ZkNEJU?=
 =?utf-8?B?K3JPTVRqNzd1MjBDZk8reWJxWi9xbFlBYnIxYlJtbzdDQUV3OWs2UkFXMWtK?=
 =?utf-8?B?ZnBaS08yTTFnNUNpaytEKzc3L2VQWW1zQW5sYUNhTUlwRFQ2dXYrbUtERkx3?=
 =?utf-8?B?cGFuTzBLK3hWSjU5cHZsQ3VyZlFUTFcwcFo4ZUpWYmR4NWlPaGlVdE1qMFpY?=
 =?utf-8?B?N3VqZEJubzBHcmZKbDJZQlFJVzlmRG4yQzNrR2E4MWRKUHhTWGlyU05qMlhr?=
 =?utf-8?B?MHBZL0xxYWN0STVsQVpKeEJqRVo4TFJJT3U5bDZ0c1NTRmdwa2VIUDJXUkd6?=
 =?utf-8?B?aFVuK2N2WTlJWUl4WVgvRGdEcEFhT0NUWERYb3p1M2tqQUFNSE5HVkxNK0xy?=
 =?utf-8?B?dHlMOHV1YkZHTkt5REFqK1ZtMUVwait4b2x6L2lKQVdJNXYrZy9XK0ZtMnRQ?=
 =?utf-8?B?d0wzZTZxTjRPZk5wR2lOQ0d4eFhKS0hzV2Y1YlJMMWp2MGVVMG8yTnJOL3BF?=
 =?utf-8?B?M0xMQ0o4RE1EYzZzeTVxL3hzenpFN0xlRHgzRjVpQ1p4QjloS0dnTmRFdlVD?=
 =?utf-8?B?bWJXRjkrbm4remhwSHMvL3JDcm5XM2NXV3V5dUNSVkJENld6SE9VYTVXT0pZ?=
 =?utf-8?B?TC9HUm5FTmFvK2U2M2luTDljWEFMMFVSS0VWMjdKeUVNSFlzRERGRVlLY1pi?=
 =?utf-8?B?bll0TzRqckx0b01EQVVvK2NtdExDeFhvV1k1bEFGR1RmZGNLVk5tQVlkUmxE?=
 =?utf-8?B?Z1JsZUVpWjB3dUVSYUVoRDFodVNVR3ZsbVRZSTdiTWRnL1ZKL0tIai84dUpy?=
 =?utf-8?B?VHQzUVUvSDFiMi9ReHRNTE9uU3dqOUxSczBQV0FybEc1RzhxcGMxZk9CaHJS?=
 =?utf-8?B?SmtDQUdMK0ZSUUt3dGRNRkpWVW1KUnBDODFQelJHaTZZM2dYSzU0bWdVOVNw?=
 =?utf-8?B?UjJEc3E2a2lWbE5HUENtWkJSRk15WXV1VXFYUGdkT2ZGMDlGRHA2MTZQcDBO?=
 =?utf-8?B?YTNIZTBjWGkrODQ4Z0MyZGdTbUZEbjVCNHNzaURxWHkyRjd2UVdRWnFzeGFH?=
 =?utf-8?B?QWtBN3hmc0c4SG1tRVVsRGFYckpiNUF3NGVZUzR4MGZOWDM3OG5kMDNsZTlp?=
 =?utf-8?B?ZnpsYTZ3V2FtblB4MzdiekMwbFFqdmJKdWtjZU9iYVRNUVU4RXltVXhreitk?=
 =?utf-8?B?QllwVEhqZnJ6aHJZcC9zQnpyVW85QnZUV3NLUUloeTd2aWIxWlZ6TGRlV3k1?=
 =?utf-8?B?eUZSSzI1dW1PWGsxcUpaM0RBN2Jwcm9kSVl6UUJjdktpODBVc0JONm1MaU5n?=
 =?utf-8?B?M1pxdFlRUEV2TExuSlRocTF3UVVmTXdScXZTZXp3SXQvWHl2VmdqSmczSXZi?=
 =?utf-8?B?WkUxMGMraFo4WnYvSzJrRERsaSs3VVMybEhFdjB1ck1rOGFHdjdJblNXeXZZ?=
 =?utf-8?B?TUJHdVVyaE8vS1RnYUxVR1BpUC96UGExbzZkcHRoaGN0T3Bta0hSVnl4dk4w?=
 =?utf-8?B?TFdVZXo0dHJMQld6OThzV1RmYTV1bzRKRWt5amxDTDJxa3RkaC9ObXJZcXZR?=
 =?utf-8?B?ZS9kTG5leFNZa1VEMVNnTXZpTWZ6ZTZoM2tEMUFyRUtSNGpzd2xSbHZGbnVH?=
 =?utf-8?B?YTRxZWlCY2NkQ2ttRmZaMzNlNXVUSVZOVkJrRFNzZ0RZYlJMY1ZaZ0p3TWhZ?=
 =?utf-8?B?ZmFkWERuY2J5S0NreUtsN2tqbFI5VW5JZW84ZEhoV25COEdYWHdOUjBsZFVZ?=
 =?utf-8?B?VDR2cVJQQXNsUFgrQndOVkdsMUZjb2JveThXclpUUUo4MnZTNUQwdTNvNFB2?=
 =?utf-8?Q?l2ub0u3IDyRwIE0I=3D?=
X-Exchange-RoutingPolicyChecked: WpGmvZAwq6S/M/6mU+z6r9TwPU/ZuOa95vBi16YjOczJBMWBvlk7ruKhUX40Eo8b8kd9+r+/6bLBqNKyRGeNUSos1nPSQrVGwMlNV+hsKG2f4nSLonH/LWNgZ4gpeGwnkFnKlBbp5PssVklJdJmm8QVATgzOgJTURQRHVDeFQHVMHtyaL2JqMAxzp/ksrHe4p4N5e+bw/C89g9OYRH+yIEYhYTmNyC5zVnikbQFRPbNZs/r8XG0Oec8ENlLeyhmSbqt8AYqRELntoHc6ZDuxBgeek0B1H3qQhbmHIrPDSGi3LfdWPyn5FBYRlGAIwLH8SUalgrD1cy/U5EOdEsTtWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61266109-a3ab-4664-113a-08de7deb8d4d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:52:58.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBP/aKdo2gmtoufqSX0104RPiwBEF+/7K9bttGXFHUI+GwBbJXN0Z7ASjuZGXsiv0/nXoNG8bFFvsSwoe/opUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

On 09/03/2026 16:34, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add support for the uSDHC controller found in NXP S32N79 automotive SoCs,
> which reuse the existing sdhci-esdhc-imx driver with slice difference.
> 
> Compared with s32g2/s32g3, needn't set ESDHC_FLAG_SKIP_CD_WAKE flag
> because s32n79 does not have this limitation.
> 
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a7a5df673b0f..28288fca87ff 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -321,6 +321,14 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>  	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>  
> +static struct esdhc_soc_data usdhc_s32n79_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> +			| ESDHC_FLAG_SKIP_ERR004536,
> +	.quirks = SDHCI_QUIRK_NO_LED,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -408,6 +416,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>  	{ .compatible = "fsl,imx95-usdhc", .data = &usdhc_imx95_data, },
>  	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
>  	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
> +	{ .compatible = "nxp,s32n79-usdhc", .data = &usdhc_s32n79_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);

