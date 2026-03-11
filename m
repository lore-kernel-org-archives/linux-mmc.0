Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84D368947;
	Wed, 11 Mar 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220333; cv=fail; b=EIZBsQL1kSSY/Si66UV5dDqj/VSyOvPjXqmwPKj0KYzvL/zZUPrRuQ0/kDwQFnRrhnQJWHT8qQBfVEnrYC6j2ZcMwBbk6X3MECvVlBB8ZFdgpMrEp1VbxQAymlavX1SjVrKq6eipI6yCDn6dwsZoWKkE0y66mA/HLVPgjfWOvS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220333; c=relaxed/simple;
	bh=bYdSIgIayC7n6gBMVY7+SYokzc663T5NTVp1WUVB+Bo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5i8ayOIUdl5+pxjJFx2ji40JleXg1pd1ThcYhsv9+pJEQB0fZTZ2blpr4DaY3yvMt3yObrsUplZXk81YaHdZejmbd6kXxuZGLZbtRt2TDFfKFJ9azf9VyCUeWJSnlt2fO7LevJU0/C+pekNtylRlhwncV5uxKaxSYudAO54JE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evwjQSdl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evwjQSdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220322; x=1804756322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bYdSIgIayC7n6gBMVY7+SYokzc663T5NTVp1WUVB+Bo=;
  b=evwjQSdld+jBNkUotioPvcvzcJH3534lsqThmoIpYnnTWRkxRF6xBS5V
   mFvxFcjHBn66teUA3WwPczOvqnJWPbwVbDk3ySzoYq1UesDqKJXs8IKIc
   +t+TsAE28aFvSD3ocVSeq3maAixJTyzpqt1grqgljiFFxpO2zAuSk8v8+
   D5lIBhCgKdwdZKM0gecZaU0aammYi45PCKs6Lk1Vp65YhHUlgeEhJsuBK
   pTVTZcHE/mI8sDpPnXLXKWN0dK6pVhohTIwJZjFffzMNsQewRq1+vA6As
   mMM5K9JpjW309yd9wTqirQ2apJCJ/JVEvuRBaRDcb9yCSD1yYqJn5Wthl
   A==;
X-CSE-ConnectionGUID: hrsn+84ARnOzF4AJacF9hg==
X-CSE-MsgGUID: xjsaevR5TjKJ8Qu3DscW0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61855476"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61855476"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:12:01 -0700
X-CSE-ConnectionGUID: XrvSBo4gRTiOR5/SP7aUow==
X-CSE-MsgGUID: GptfO2LGT7aMzpZQe8ljgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258312222"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:12:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:12:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:12:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muw+fRye7vHP6rT0dknKzGVfqWHClcNk5GlrfxKQMCEx7Xs8gsvqd5ivcMF6rV1+wtdtsb8pmZqLH2w0T77KLbAGD9FiNn3VdMeCaVKPSEi3bWkDjEOwmTDrwrvR8tFaJQIVfCtiWenUDTk8rTNtkfqaHWclxcjQ7Wb4Ir7LgoqimMuBirApmaFy5T4br4+ISUHwlI7InuYh5Pz16txvElwa1gu3Q5IosS0pkiKpiXIifcuEg4yUG5MQFKZgQLXoAfZZ3K84P9pZppZ7UOovvpVUbdh5AYVtVVWmQhYkpx1xicAxOWrz6Ez/tCOb/ERVvCtADeMhxevnVIhv8NWDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSaomNSNqWLqRcYv7zyOlbN4M7hJu5uLV+BbakfUQtI=;
 b=YBE3dlhnCUywZea8uSWOsogATfloiCLIW+eG62lF1XVi38Wo43wMMBa07poy/UwDVdLjlL7pRXQ20hM0Rv2K/NYDSIXG4kZcWyXaIqcD9+bXs8CZKaGSao/DbLNEPZMMXostrdw+Iy073aw1g8Cvu3pxS6XSNeOAB0/oQ4YFq5+FI5oW5WKsAVtYOVOhK/Wh/7dXjZcn8Fdn9e97jV9tzbhugeRSlPHLT6v2kd+/MpY4jrl7nYBUVdysFSuENJpSI5Y185I7bCTC/wJKynCuDnhcf95x3MNHDvL8YbGWielJQXOFG5tCMMyQjv6JoEOrY8vzT+HB/qGd5k1xnpxI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 09:11:53 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:11:53 +0000
Message-ID: <86acec8e-f093-41fd-bd03-60707c92821c@intel.com>
Date: Wed, 11 Mar 2026 11:11:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] mmc: sdhci-esdhc-imx: add NXP S32N79 support
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
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-5-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260306161555.9000-5-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: edf87ca9-8531-414b-c542-08de7f4e3c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OA24ATzEulcwsT4EnxtVR+QZ7zfkZfSBWMyyKbPyJzZsfA/LcbJj693Zww68aq+greS5HFIv8gMd1AojQVScFtgJMHZ8zQo2rER4C7xqyMhV5tnP/QuEK1m8jjgn6dQXswZEaEdNrNNInqUOQyEXP5oCH489fuoUhZFWe+fF8Bh7x5byaqW1vnDnRRBW5N2tykRre8eGW7wMldPX+Vu3wNhXA0b3CsSZz678iq6CJS5oSA/jOjpSeqIqcu9Cx5sg42nJJhVcQdhpdecuXQ7gAMQ6u1/dBXGAHIyrZYknr4mMgL6v3dTefsklUvWFfYNZBLmpfN0j1VE9SrVUDSz7M0SH/OJXRIZXhLPmcU7qhAhHnNOUnGjUfwLwTGLQo8hqES0vYG3y5X58phZIMhZ+FCywdPxm9YfCC67XmWFxiRpb3JesSjeN+FrbedOQzpvUVAJ9Zy/hQRiqgb3NG7IfLsAM1MbzApq8z1CrhGKQDj/K8ZRAULq0lIxGVnrSnuR+KU/nB04vT7rs755yVPsvEzIs+ZAxs/fAR0a593RFsCqsmQumom/BsqSahpE//uT+Kki2x2KjGOI+0LVvzQIcQJCDMJfJHKgo9oGai79a/zbafmVF7u2HgVoB26fS0fBR3HrDI4mJTM9KHFVmLY5oCR6DlnXn/hlr7eAhI73V0lVg/bE7166+rHLhOz2qeZvra5uyn7Dja9qw0NuWZICC12j6Lz8b4VkNnV5Dy4pf/YAtqfJewSixtINbX9LGqW8/M+dSjvLg4K0imLlRg+87kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTd4Q1E1UFhkR2NjV3AxVzNXSHZ4SCtRTzg0Um5CNVo0Zjl5R2Rrc01hOTVk?=
 =?utf-8?B?a0RpSXRiU2FoSkh2UmFZYjA2RjVhWjg3U1hMTER3T1FBR1RvVWdoVWMxdUpU?=
 =?utf-8?B?Q0xyRW9NcW9VWGJHc0QyaXJSQmswYmNiR2xmRU5zcmdMUnM2eXM5SWJZRmlD?=
 =?utf-8?B?aEdXaUhiL2ZVOUExU3hSRk93WitIeTZUa1FlUmkrMC91Y1dYMmJCWWFMbW1H?=
 =?utf-8?B?V2MvajZyZTcvSGVIT25TTml0dCtsVW1wZ2tzSGNiUnkwZTBmTG1aTHQ4T3dz?=
 =?utf-8?B?L2N6WDdKclo5Y21zeFFTZmlSeVFhc0hIQkh4dHNVYnFaTURYc0k4QWFDZHl2?=
 =?utf-8?B?cytZcHdLZHlFOFY3UjdaNjUrYk9JaVpKb3dTd080YndzOEE3WkdQNEhIYjlo?=
 =?utf-8?B?YWlOdXhKMkRNZWs5aFY0MUpCNVdLcE5uU3VuRVJ3bUY3a1J6dlNSSFhQVVla?=
 =?utf-8?B?Mm5SZVB6V1ozQ1dqUWF4U29rYWh6M3pVbUpBaW1XZTZZbjJYWWRncUVUQlVP?=
 =?utf-8?B?Mm5MY2dkSGlua09aT2Z3QTBiMEJiYzRaZE5Gc2t2VDNNQktCcUt3Vmp3N1pK?=
 =?utf-8?B?cXhWNW1mdDlzTXRUdEdEa1RteS9VbFRxbC8yT3lnamFDSUY0NlJwd2FkYzVu?=
 =?utf-8?B?eWNoTGgybXB5Q1dUUmxZS1pUaDR2ZUdEb2lHZHRWcWdFQTIrYnF0TzdUajVZ?=
 =?utf-8?B?Tms3RThldEpRU2ZBVStmaERXTk01ZHZsaDVKb2hIcUxWODZSZFh5c3NhTTFO?=
 =?utf-8?B?Q3RQTWl3S0haV3NRdmFSU2c1NVVXKzVUaFRyaEtmL24wazJMYTJyVnNlRXhC?=
 =?utf-8?B?aWxHaG14WDMzcUFoUlk2QUs0d2ZrdytrSVFwUkcxREQwZ2QzZzRZZHAxU3Z4?=
 =?utf-8?B?UHBKV2RVckdHZGN3Yy8xUWdMWkhja2h0L0ttaWtEQmpmbit4ZWNNb2dUK2E1?=
 =?utf-8?B?RCt0L1A4MEdqZVo5UmRUM29aNG9Ia1ptNDZzMG9ZOERSYjFYY3hUeEVYeUli?=
 =?utf-8?B?VnVkMUxMZUNFWFNKUk9KNFE5ZzBtdlJ1NDhKY0VPZGNlaVBtQkpiemh6UW5L?=
 =?utf-8?B?Ti9HRVM2bk82d0RsVWhBTDhibDFYYnpSb2UybkErdW5nQ3FObkVibjFjNWZX?=
 =?utf-8?B?cW1UUXpxV1AxeVc0ZWZvVTlTOGM3Y2FYWHZuS0txSnNpMEdkcVBSSmwyYzht?=
 =?utf-8?B?azFEQjJXV3lpVmYvN2ZTMisvSmZPUnQ1TDF2SnJKOGJVdHdGUDBBYkVNY2F2?=
 =?utf-8?B?Rm00OTBRRFllYnBnSlphOVhxcE52SWpIa0F3ZW1BTVdYMmQrMzVtTkhKNmpz?=
 =?utf-8?B?cGxmN1h4WnZrbVZFWXVJN1FzQ1VhLzZNNnluKy9SL3E5bkxoeW1XSVUzN3hC?=
 =?utf-8?B?QnliRGFRcVVnc3oyQWt0NHJsd1hOazdjNHJyU1hiK0R5U3RWY05GSkNuVStI?=
 =?utf-8?B?dTVUZ2ZnUjdFNDlPeDhSMEFTNG1lTTB0WG83RGpFa0RidUJVb2ZpMDdDemYx?=
 =?utf-8?B?dTQ3ZUdCeWs4eHBNZFVkbDFGWnN1Vjk1TUZWV3ozOXpTOG03cGJGbG9XaCtp?=
 =?utf-8?B?dmVLNFR1Zk9LdXB1UzdDUW0yME1tUDd1VmJYajlTM2IvUGlBQndOSzZoUDhQ?=
 =?utf-8?B?cnd0Qk5YZHByeXk2NGNaT0E4K0FsalF2ODBMcEg0Z20yU2hBanpYSnlYQ3c4?=
 =?utf-8?B?V3ptalUxbnJxeUdEblhsZE5pdVE2RjZpVk1GUDM2T1RSbm5EQkd5QXRSajl0?=
 =?utf-8?B?U1lRemh0b0tLc1VucTJvUVBWbkU1dFlZTUltanMrYlgyR0ovdHFnaEFLYkd3?=
 =?utf-8?B?NUJDOWY3Q1k5b1k0bHlVY2pIaDVSVmUvUXBTWHN0STdZK2d6YXo3cVJQY3RY?=
 =?utf-8?B?STJoNk43aFFYek83OVBvZDluR1pOUUdIei8wYWJSZjlkYTZqOHh6ZFNDMlZM?=
 =?utf-8?B?WkdaTW91Mk1Ra2dTQnhLbmdIUEM1clRyYTZVQUFya3Zoa3VHZUhZcFpzVC9s?=
 =?utf-8?B?czN5TmtUTzVtY3ZXdHV4WXdKMGRaSDVrOVFnb3dOS09sanVSVTFOdU1rbHd4?=
 =?utf-8?B?aHRnUU5HUHBjbm1oeWhEaTMzbTh4Wk1QV3NNeEZWMGxFd0xJaWgva0VPcTNy?=
 =?utf-8?B?VllzSFVPMzE2bGNwNzgxa01uYUU1b3FNcDIrREE0NDlGUmFmazF3NkxBTjFK?=
 =?utf-8?B?NElMU1JEVnpCSk1FOVJEUWwyNWF6eHVvWW9WTnVkTzhmN2Z0bE5KSitQeHg3?=
 =?utf-8?B?VGN1cE1wVk5hUldYMDBEa1M1dXNNSHJXSlNITXZKVUFxalV4ZElWa0ZjY2k2?=
 =?utf-8?B?ZWVQaUdKYnFKQ2o1VGxERTlxVk5wb2NPVFJ6L3dLaUdWSTkySERxNUM2bG51?=
 =?utf-8?Q?Rl/PVg1ZYbnZTD8A=3D?=
X-Exchange-RoutingPolicyChecked: cpGJzfyq1g6S7JHLnvugchEznk/754XWUrBY3mb2hWBNHFQqXcYexQ4NVA7NPrtec/C6sr8CcrOgOKGs0kTmZWyxat67Fl19wgogYXocpIHKnJ45/vn8Xy9wZtXlCt3+ONk7xJI5FAbd713mVN7hs9IMWfwwuokK1oGkz18KiXuxo0gndqHhKPYG8ptrK5RguwIp4gwXnMJGB2FdTJMKc5TH816kW0sySENwv+B76vQNtuR/Hja8rst0cRa875in2gzFnZiglzWRskNsyPohLptGsZbhWcRhFp4tTT1J4B5Ybz0ssDK8aLXnUfBjc/uaYVqK19jAw3kiLk3M4eKHTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: edf87ca9-8531-414b-c542-08de7f4e3c66
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:11:53.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl4JAfseMQMXphvcL0z3gLFyblvNUAd2aOK3MKusCgAYTJBIC8XOQEB1L+9dAS+MnEFuxl0zb6gyi/3+332z8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

On 06/03/2026 18:15, Ciprian Costea wrote:
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

