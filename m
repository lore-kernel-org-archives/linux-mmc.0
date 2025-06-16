Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841D2D9EC5;
	Mon, 16 Jun 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072755; cv=fail; b=S0TRlBK3nX35uMw/jtOMM6PzwLg1gT3RkrqhexyaAltk7jVlgGfwpJH+z/foYlSp5Q4aJ5+zfp+O3dOWYZDBnvRb1YYC3u/zqLRH1UVi5p6Z3eOJquSjwhyLki7v3whPqkCa3HBlbaHLr3++3ZlYZhnpluPEb+fQMo+AdnR3uVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072755; c=relaxed/simple;
	bh=QcgXg7mhEKSn7bdbijQo8IeRWqHZlnkvza3vUrgSmXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n6qlXarOqxFnOQ2SanCYLM3JXF0quioBFV8cTmMDEnvYq6EFOqOy7gpgrX/EYpJCJkvsIW6ZmfxQwMV19Qom1fwCpATzzJlkP+7saUcZNIpqYpkE4smsfAGZZVtTF6pLpEUETTtG9kRhMvAfbRc3jfE/5uWDP6djFLwNaIj+xew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/jPHDvV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/jPHDvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750072754; x=1781608754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QcgXg7mhEKSn7bdbijQo8IeRWqHZlnkvza3vUrgSmXU=;
  b=M/jPHDvV7RtrFW2Expq9qdGpmFJvrZlBMUccYRAhOpk9kv0nfFXexX8+
   zgcb4T/s96tg3jiSydg7tT/D9fCoNluSh/8k0oSq+Hov4JwY+uoQDtV8x
   mipDR/CHIFJS8I1Qc8AdBRWOKEn1VEez3eIGwj+QbUYM1NHRB1n9K0FV0
   ms0GbHsEVnI483ebC1mgQ4rbGuUhf4eATp6lTbBKbm0jPL2nz3a6GRX22
   8NgnExjZrIEh5TcJYVsl52a/ZTsM2PkTNye5d8A3Y2sJQGCrkFtLaQasu
   lHLPwLihMZGb+lMq1G+iVLTTHIaijveUynqGx/m2wcjbM5vqcj35uxueE
   Q==;
X-CSE-ConnectionGUID: tyezbV36TI6A7rJlEwFsMQ==
X-CSE-MsgGUID: ZciMGRFvSP+J2JNBXD0YFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69789554"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="69789554"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:19:13 -0700
X-CSE-ConnectionGUID: FYM8LReLQfCVDF6IlHDMow==
X-CSE-MsgGUID: rc4dziLNQc+zilw89SUH4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153599582"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 04:19:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 04:19:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 04:19:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 04:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9JNi0eRsC6dRKHolHcrv41Tqe3H7X5KrL67e4QW/qK3WAFgxEtMzChfohAu3yHVaU3MDZEoUo4ULXv0XMI6g9+rtv3/EsoYALKYwHreJzpRClTBkVIT31q0/PCAuh0U5QVVw9R5GFq1YeSbDrLIGNWuBSAir3pDBCQqTK/o3FoVm3SLRyMglB6kx0fPQPvwzWYg+WXjd1MXGlXU3MzRnSzhqL/CnuslBpWDADZAeWHoMeA6JGWpRrHrytrorzzexbnuBBPkFrUyrjh5tqwO1Thy4poGR87G0Ikm4ja1omPQBeAGTWHTjNbPXIQbpC8sZkdkvr+m5ZsW6ZhasDsuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2y3UcUHDIeApblInph6mEAVDuQcU+1KXAGCBp+DHjs=;
 b=fiR4vY7RDCgmv5FmvxQXv5w/TbMp5veUThvEWoFW4zSNjKCkcrzHKZj1mSW6pfGo5sib5prJuzZXGmE1bPDGyBc/Rkvu8CPUYr/6FoKup2rDyR5BfD0aWdHR2C76vTeyDbuZRjYxtsHqKk8psniyfUFlwjp9OkZK1KiYClpdipyz1Oa3zVmEaHe/WgUP9uYw7XiD0o20LEwhPX1bgfbWFK49n7Hph2hxXndauAumOTxod0qYGxDwA3QqVeKwevfz2G3DfK9fWFaDMEuK6viVsd67P/vXg5Ffr1b+oXVItY2Qst1HUVhcbPfbJ2/DnWM3TMsJATtrwe5GNKcR4OJkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3206.namprd11.prod.outlook.com (2603:10b6:a03:78::27)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:19:09 +0000
Received: from BYAPR11MB3206.namprd11.prod.outlook.com
 ([fe80::4001:1e6c:6f8d:469d]) by BYAPR11MB3206.namprd11.prod.outlook.com
 ([fe80::4001:1e6c:6f8d:469d%4]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:19:09 +0000
Message-ID: <87619781-629b-4393-8c14-b34483a7c734@intel.com>
Date: Mon, 16 Jun 2025 14:19:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] mmc: sdhci: add Black Sesame Technologies BST
 C1200 controller driver
To: Albert Yang <yangzh0906@thundersoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Ge Gordon <gordon.ge@bst.ai>
CC: BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Victor Shih <victor.shih@genesyslogic.com.tw>, Shan-Chun Hung
	<shanchun1218@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>, Peter Robinson
	<pbrobinson@gmail.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20250528085453.481320-1-yangzh0906@thundersoft.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250528085453.481320-1-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To BYAPR11MB3206.namprd11.prod.outlook.com
 (2603:10b6:a03:78::27)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3206:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f64c37-06f0-4fc7-233f-08ddacc79cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUduSkpFZks5TDVGYmg2V1Bya2cxcE1Vb0NON3BDTWNMZUFCcmhPMG5ybk4y?=
 =?utf-8?B?cEdNOWJmMDh0cFFEU0VhemVqVVlkbWZIRWh4S2V6T3BLZHBFK1pVd1FSYzha?=
 =?utf-8?B?b3EycXN3OTVNcFNKTEIzcXp4ZlUyR216UGxLWTZycW1JYkdkR3Fsdkp5RGE2?=
 =?utf-8?B?UXE1allYSTdEZ0hWeU0ycXNBOXB2U0ZCOU4wbnA2TzRlZUVNZ1hvbC9ZWEFI?=
 =?utf-8?B?ZVd0bW1kYmwvQTk4YkFNTGIwR3puclpkSDM4WGVVdHJRb1pjQWVKaVhMdzVG?=
 =?utf-8?B?TkFmUVB1Rlppa1dKOUpweHpwOXBDVTFsRzQ5cnlUaDVrQWdlUzBBdzJOcm5t?=
 =?utf-8?B?SzU3akxpdzNRTjV0UEUwNzh5d2hWdkwzYXZGR2VPRjMyYkJPbU9kQ2NlaFNO?=
 =?utf-8?B?WkNFTHc2MktJbUkzVE5nL2VId3FxZGRGMzBHUGQ4TFZ0MlcrSDhsYlo5citL?=
 =?utf-8?B?eEtMK0FCdzB2YmVpNzZQTEh6TFM4c3pUV1NJUlpSYUpFL0N1cVBlN2tGZVM4?=
 =?utf-8?B?T1RBNGliZFVyT1dlYTd1Y3BZZm9RaHJTbm5KZ2pZSUFLQm1FS2RVR0hhNGNR?=
 =?utf-8?B?QW5wTXRZTXEzWEtWZzliSXpzVGJhWVFTQ2k4NzJ0a3lvVmVRcUMyT285Tk5X?=
 =?utf-8?B?TUhhNmpUL1JPTHR1am5odmVmRzRCcTBFTEZwd2NXWkRVY0xGb2hwWVcyejJG?=
 =?utf-8?B?M3M0cVZrZHBTdEFYQU9Oc2VueTNCaGVJZDJnWEYwdmhJeWFBazhsTE9QUC9s?=
 =?utf-8?B?MTd6OXp1cktvNENSNHhRMjNrRlVEOFcybS9UdVBQNzV0WFRmQ1VzaEp1THNj?=
 =?utf-8?B?UHdQVnlYT3ZvWWFaekVteUZ4NUtETGwwMCtxWWhobEpTWTc2ZGw4TDdlTEQ1?=
 =?utf-8?B?VENrQm9RcjROUW16M0lDL1Z2Q0l4Y250cGVLbU0zaisraDJJdHRpRStlUXZk?=
 =?utf-8?B?SjUrN3JTalZMYkt2K3lydTlaQitmSVBuS2tTME9BaFF3dDcrRDhndTZOeEVD?=
 =?utf-8?B?UXFJRnhCT0NmcGgyVG84WmVWSHNqNk5CRlU5aGJuV1ArTEZySTYwOTF0cHRC?=
 =?utf-8?B?OGk4WXZVaFFmRXVvbVpib3dETFYyMzBHMzdPQlRJNWdkcVZQbzNoZ0dNL1VW?=
 =?utf-8?B?WVRYZThMY1lheWFFYjZTaE40TmJpRVFBMlZ1dFRxOXhtbktjZXowVTF6bXh3?=
 =?utf-8?B?YWNtNExqTWIwQllLbEM2UldzZGIvM3RSbWhDOTgzSWVZajBlZTJsNG9UR0Rh?=
 =?utf-8?B?ZlpXcllNU2l1TmR4aUFIZTIzUDZld1NYU1hwUkoybG9XM3BNc1ZmSjFaUEI4?=
 =?utf-8?B?NUd6SWFrWTd3YUtuMFM3azZhRUViSTgzWmR2dHF4b3NpdG5Wbm9pQVF1Y1pG?=
 =?utf-8?B?SXFDZUwwa3N6MmtpZEFsaFNsUEVac0NrTFYyUzBrYUtOMnlLdjhMOWU2V0lo?=
 =?utf-8?B?ZFA1OExPaW43Q1ovVGZMTHN3byt0RVJGNG5LaVdObk01MzVPRW5PbExmMmYx?=
 =?utf-8?B?NzUySFQzN2wrNzZ3VHVJZlZuQ2c5L3RNdEo3OVJkSGNYeTZtU3lZMjhhNzlr?=
 =?utf-8?B?T1lUb0RKdlZiTjVyS1VjYTdTMm1GS2djWmJHRDJHYXJRbEdabHQvZE5nTlFv?=
 =?utf-8?B?R2hrODU2U04zRVFFVmd6aVdJS0d4Q2VBUXFkbHlxZjV4amR6cGtlRU8xQ3hp?=
 =?utf-8?B?Ujh1TWNqN2xOM3I0bXROZGNBd2FaN0tLSXMxV1doWXpERDRBMmxvOFR5V2hQ?=
 =?utf-8?B?ZkFFWnhkc1pXNGFvTU5zTGpLK0lLQlVDbGJqVWVudjZUTHZmcWJIUDBWTnpi?=
 =?utf-8?B?R0w2Q0drSkVnbG9ZdkF0ZUdlR3ZoMmx2UGV4YndWNHk5TEJnRnBLMi90WlI0?=
 =?utf-8?B?a0xOT2RnbjQyZUdmTGxCQmQ1b0M5WHN0RmtUL3ZWUEJUak5EcmlRQXpSRzJR?=
 =?utf-8?Q?AtjFNL3BINc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytFM2t6UGVvakRORlBXODBBbjdHNE5WQWxDZ3VyZ1F4U3JnOFlOOWwyeHlq?=
 =?utf-8?B?NU15czlKOFpvMG5jWXVCVk1PVWRGelNDOVpNZTNsd0ZrdW9sdGk3L2lhUTlh?=
 =?utf-8?B?VEovVzdVWEY1RE01RHpVdzhvb0NOYXUzaHBxbEtKSFZJV0lBMkFCUFlVdk5I?=
 =?utf-8?B?bUIvdUpZSmtJdkNyNHVHQzRtRHBDY0RET1BaWldWRHFLU1lzdmswLzlsMHpu?=
 =?utf-8?B?R3RsMWVLRnF0bEIva0ZMUllxcDB3dHJqUFJzV2dvdFpCS2Q3Y2pJNVBYSGNQ?=
 =?utf-8?B?QVVsbENsYzJUc2FVV0JTM05Fd29jSDVEcHY2MjlheERkMnRiYVBwa2hraW1P?=
 =?utf-8?B?aVhUQmRzODA1OGFQMUVZd0RPcHhhV3BJL0ppQjExNk56YjFKamVJQ28yOFFW?=
 =?utf-8?B?SW5MSUZpeHNyQkNIS3F1am9HVDdENHgzR0hWSlNmaTVNa2NKd3IweVpmcXlB?=
 =?utf-8?B?bmFJVjhmWUt4TW1OajR2eDZIM2kzdjk3Q3pIbHpOYTNiWUhtVzNqcG84VmpF?=
 =?utf-8?B?eVkzOUV4alM0bmlMYUZ1enZDWXVSTS9BKzQzQndnVDIwUDBBY3A4UGtMQnhi?=
 =?utf-8?B?WXR4WFBBT3p5dEd4enRBcHQzOHVZc3l2MVcwbjVzcmVhNVpla29CemxSMi9R?=
 =?utf-8?B?OE1SeHh2eW5kY3VxemFKak40b2Q1UGhxUytmYlZmeDhsNlVXUnlEdWQ4WkRW?=
 =?utf-8?B?MkhxcXVLMkZ0VWRVcHJGVXlYT1VmUXA4UWpQeEZqemxXeWNjaVd3Q0R6ZGln?=
 =?utf-8?B?Q3Y3eE1KMG9MZytnYkxaRG4wRDNoS1Z6WU1xeHBydklvbG1NQlZSbDZuQmYv?=
 =?utf-8?B?MzJ2b3NEbUpZa0Z1UnJDTjhSd1JadVZMRHJQS2RUdjlCbHJCRVZaT0lBSHBE?=
 =?utf-8?B?dkQ1UXYyOHIwRXJsdjAxSSs1SDlCTFFvZVZjcVI4K0JQQlZHRmtkQjdzbFJo?=
 =?utf-8?B?QmpGTzBJbGxpc1REOGkvc1BzL3lKZ2lUYWQ0dld2WHlUa0ZHOXBSalpUQUxJ?=
 =?utf-8?B?SW0vU0hTQnQ5VHI3SkF1UG1ZMVVmMEIrZU5IUzNrUjR0LzMrTWtSR0huT3l4?=
 =?utf-8?B?VVJDYjRTSmJWYlJCUEdlQXJsL0I4UDhlSHlkVHFDcEdia3MrK0FMQUdGcCtq?=
 =?utf-8?B?Q0t0V1lWVlhSUzAvK2kyN0w2cklab0pDV1RNTXl2d2RGbTQ0aTFXZHFyb1gx?=
 =?utf-8?B?TWFneGw0b1ZDSytTSlE1Yyt6Z1J5NmNmOFV0dmplVXk4WkpuY2hSZmtPMW4x?=
 =?utf-8?B?Sjk1eVA2dUhDcTBxc0tqYXRzMFcxMzB6bEltek1NbThCTzVzSE5FM0hpS0xk?=
 =?utf-8?B?UnJyQ1JUM1BhNlBzdkoyNHBBUWdzcnBvV2RwOUUxUnJGeDl0Q1A4RFFZRHV0?=
 =?utf-8?B?dTcvRjl5ZXBuaG9hcE9WYXExVllMQVBUZUdGMzZkT0pXcm5MYVIyaVZZdVRX?=
 =?utf-8?B?bmVhM21BL2I4STk3ZU9JenlUbWtycnFKZzFHWEY4L2xESzBWa09lVy9ra3hG?=
 =?utf-8?B?UnNWSCt4eVQxSnBzM3NyV01KeGYxTXM3TGhLUE84RmUvbWs5bXJWYXhuZ25U?=
 =?utf-8?B?b0d3UlJOUjNla3BUWlNQb1pDeTE3NHAzQ1ZXOHpXWEZIa3JjUnYrNUQwWEFJ?=
 =?utf-8?B?VkxLOGpqb1NSdVVEZ1h6RVRSMGdBSXZwdVBqa2EyVk1RaVJKN1RneEpOSWN4?=
 =?utf-8?B?OTh5OTMrdDZvSnpHcjFQMThxTHl1OVZncnUrOXNnc0pqdXJiUGlsMm55WHhL?=
 =?utf-8?B?OVBZUUpaaHpvSkh1TnhYUjR5NlNRSmhuVWlBdUpxLzFmY1VFRUdaMTJHT0JE?=
 =?utf-8?B?UVdNNXNsY0dVa1E3OGl0ckVMS1Vjd09hMy81TjNQYTk3NFo2MC9lYkhlWThj?=
 =?utf-8?B?YkxaTkllVVVyeTlKa1prSVNtdHhkQXpQc3NPOFlNSmpzbDFHSDFGU05RczNk?=
 =?utf-8?B?VUY1VmIzN0FUclRTdHUrNDZKUXpnRkJwcVU0YndHOC9aMjQraERxcnE5cDZh?=
 =?utf-8?B?cFM4MHBJKy9Ub1o4eFRGV3A0S3ROcCtyNjI5VkpWV2hDd3VNT0NXY0Q4dks0?=
 =?utf-8?B?N1lVU29aY0YyQlBQcGZYd2NRaW1icGowZW5BeCtQWVBJeGVvcEROa1I4bjFx?=
 =?utf-8?B?aThET2FUTWw3Qk5peG52Z0hCUTVMaGViRzdIV0hLSndKcGFTYy9LVTNoeWpo?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f64c37-06f0-4fc7-233f-08ddacc79cd0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:19:08.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EQyYHrvInsHOec/VOfH6Z2pGS0D/NFclqdFUSZEvzge0fs4RcX3aETZjmCihOH4HW87ov/PTM06mOlu54OpdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

On 28/05/2025 11:54, Albert Yang wrote:
> Add a driver for the DesignWare Mobile Storage Host Controller (DWCMSHC)
> SDHCI controller found in Black Sesame Technologies C1200 SoCs.
> 
> The driver provides specialized clock configuration, tuning, voltage
> switching, and power management for the BST DWCMSHC controller. It also
> includes support for eMMC boot and memory-mapped I/O for CRM registers.
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
>  drivers/mmc/host/Kconfig              |  11 +
>  drivers/mmc/host/Makefile             |   1 +
>  drivers/mmc/host/sdhci-of-bst-c1200.c | 920 ++++++++++++++++++++++++++
>  3 files changed, 932 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-bst-c1200.c

<SNIP>

> +static void bst_sdhci_allocate_bounce_buffer(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned int max_blocks;
> +	unsigned int bounce_size;
> +	int ret;
> +
> +	/*
> +	 * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
> +	 * has diminishing returns, this is probably because SD/MMC
> +	 * cards are usually optimized to handle this size of requests.
> +	 */
> +	bounce_size = SZ_32K;
> +	/*
> +	 * Adjust downwards to maximum request size if this is less
> +	 * than our segment size, else hammer down the maximum
> +	 * request size to the maximum buffer size.
> +	 */
> +	if (mmc->max_req_size < bounce_size)
> +		bounce_size = mmc->max_req_size;
> +	max_blocks = bounce_size / 512;
> +
> +	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
> +	if (ret) {
> +		dev_err(mmc_dev(mmc), "of_reserved_mem_device_init error\n");
> +		return;
> +	}
> +	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
> +						 &host->bounce_addr, GFP_KERNEL);

sdhci uses dma_sync_single_for_device() and dma_sync_single_for_cpu()
with this buffer.  Does that really work?

> +
> +	ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
> +	if (ret) {
> +		devm_kfree(mmc_dev(mmc), host->bounce_buffer);
> +		host->bounce_buffer = NULL;
> +		/* Again fall back to max_segs == 1 */
> +		return;
> +	}
> +
> +	host->bounce_buffer_size = bounce_size;
> +
> +	/* Lie about this since we're bouncing */
> +	mmc->max_segs = max_blocks;
> +	mmc->max_seg_size = bounce_size;
> +	mmc->max_req_size = bounce_size;
> +
> +	pr_info("BST reallocate %s bounce up to %u segments into one, max segment size %u bytes\n",
> +		mmc_hostname(mmc), max_blocks, bounce_size);
> +}
> +
> +static int bst_sdhci_set_dma_mask(struct sdhci_host *host)

This is identical to sdhci_set_dma_mask() just just drop it.

> +{
> +	struct mmc_host *mmc = host->mmc;
> +	struct device *dev = mmc_dev(mmc);
> +	int ret = -EINVAL;
> +
> +	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
> +
> +	/* Try 64-bit mask if hardware is capable  of it */
> +	if (host->flags & SDHCI_USE_64_BIT_DMA) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +		if (ret) {
> +			pr_warn("%s: Failed to set 64-bit DMA mask.\n",
> +				mmc_hostname(mmc));
> +			host->flags &= ~SDHCI_USE_64_BIT_DMA;
> +		}
> +	}
> +
> +	/* 32-bit mask as default & fallback */
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			pr_warn("%s: Failed to set 32-bit DMA mask.\n",
> +				mmc_hostname(mmc));
> +	}
> +
> +	return ret;
> +}
> +
> +int bst_sdhci_setup_host(struct sdhci_host *host)

It is not acceptable for the driver to have its own copy of
sdhci_setup().

Please describe what you need to customize and why.

