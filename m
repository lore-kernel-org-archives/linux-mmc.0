Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242710942;
	Thu, 24 Jul 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374039; cv=fail; b=HoSnk4s3EQ54JqwMyUx0HUf+RN5byY+ahtLPVb2dnTrP3VOHcmmhE9AEOoKuNsIcctf+Vvq67e9491g1FXpXnFK7ddJdHACcLWygktg7KqlSookbS8ppq9xNUttNd9UcP4gl62ylLO+wc9hM9cxK45+zo9ccFfB3Ovol++Q/zN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374039; c=relaxed/simple;
	bh=Pl6Ma83HJAXo15AaYmC4FqxH8Rnv3sjZSwrOdfRkCds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ABJpro7PwUuaoXZFf3xY70HkAC7XK+1Vp40x3WA0UG/2LcT+D5wjv6zhkwKtUk/+bswm0LBgX+Bsb8ACoR9k72wdpIThcfW123NLhrHnkd9diAGD6XSnHy+at52RaDJrBfnbGrbom1AjFJbP4rtXP53DFaRJM3vhtVLcOxQ5npw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4qvB2vB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4qvB2vB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753374037; x=1784910037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pl6Ma83HJAXo15AaYmC4FqxH8Rnv3sjZSwrOdfRkCds=;
  b=b4qvB2vBMypHhxqMfeAPNnVB2Gxu8+Ox2/ew/vijbDt+MUKxhqtAkvGW
   sc6IIbECrFaWdUTEdGHy/ljyNfjUCsDkr4fND3K+k8ug14tnHGIYhqFjG
   CQePAScF3CigNyZBB/eApDnwaAFASpQb8qGV+CmcdWmHpJ5m9kicPVQlV
   wNi8XSuSReeZ+qqGz6vE/J7jeO43j0ALxF832+eiZCycoMnV60zrZMdw/
   2innWgDfkgmK3lpxdEE5Yc/m99Uh1Eob/8qkzwUvrhzk2eyaENmudbYxx
   Odgfm7EEoLxfwVZWhElo/HOj2wNxAPl9m7Vr6KyLZz8tMQ+gGEkZ5KWoX
   g==;
X-CSE-ConnectionGUID: Zpa9GUCLTpihtUvexyfD5g==
X-CSE-MsgGUID: pxD0mj8LQOG7FzfgnExq0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58320139"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="58320139"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 09:20:30 -0700
X-CSE-ConnectionGUID: Ws2Dp0EbT2W+3qHXxXy3NQ==
X-CSE-MsgGUID: LXQ+lXGvTLu2FcaB0HwjPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="165858904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 09:20:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 09:20:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 09:20:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 09:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmat87pNd3SZIl5Cb9sMoMsRSHFz+xDtEN2xVHPqBquoEZ2YH0KuvqfAtgfj+HUiyCXmIdI2UnPeFviJr4SWSgjqNllAQJzmZ/cygBdssmQ9gdEwoqUJMUe5IKufZP1Er2RomAUQib6+3b8Hig4l5OELcqj5EkMSdYs09XxcFvzxm6NRm3oRj6Uv33aBZxYBx0GQyuaEmseeegYKtwwBzBs16+dcpp366tF/XX+TBZf2d8/rtTUoaL5BqaP072A0oALlkyjkXb7WNx7VRu3udQlZNNxLmKuuuw0yalvVFN8DQVJY9D2SCk6qMaK+jZSHTGNbglFQ9J6cfAhFF+Vvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA9wXNIj9hYd07n+Pd3+u7MzRTteNWmZtuObj8EiK18=;
 b=eJruRP7Px/Ceww036FhnVeXa+CUR/l3nqv/2+fVRPMy/Ou1ly+ArSPMvolP8239sm+tqO5YD2/d6kkjLv/C8Z6255lvfj3mJs4IpJitOkHGlRmhGD90Mz8w5PELnrKnvFAvA6q//m7P26lsO0xkXoRdYuQclKtnreOl/LJN6barOImN6o8GdwZEQy9Cq+OW337+gRX528gIc7vS8dhFWSfzTcBQB4K0GOOupxyI4sH1ahFdakwMd3xKYKvr4BxFSV22Hp1Rxt3JSmBEvNLvd+OAzG5mwg8P/Wq5tIKOAU88theLxtb9lkEoj7Wa3m43RFZNzQSiEmP86PaAblnKGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB5898.namprd11.prod.outlook.com (2603:10b6:806:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 16:20:12 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 16:20:12 +0000
Message-ID: <cf04326b-4de4-4637-aa3b-fa1c358b9ae4@intel.com>
Date: Thu, 24 Jul 2025 19:20:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, Michal Simek
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <saikrishna12468@gmail.com>
References: <20250721095357.3783222-1-sai.krishna.potthuri@amd.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250721095357.3783222-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::37) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 723ed2c7-7c7c-4fa3-4a78-08ddcacdf730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDZvWHNyOTZjWGVMTHdOZVpGcFF4YktQODJpNkVYUnVQMUlkaWo3VjlORk5y?=
 =?utf-8?B?TzA0RHhPVlZ3cWltSUJ4dVQ3N3YzU0xnM1E2T2dOSE5VVFdiYXF2WStxc2xN?=
 =?utf-8?B?QTBpV0dRT1JLY3BKY0pDOTNsWG13dU9Qc1U0TnNqdkhJWCtuNnVhVDQ4ZGoy?=
 =?utf-8?B?YzRwbzFsSEMxL1JqMGQ5d3BCMjNhRjB6eGFRbkwrb3FZTzlzenFlQktXd2lO?=
 =?utf-8?B?MGpxZkwzbHF3MC9lQjJOemdyRHJqNkZ4M1hHa1lMOFdEWk5lbTJFWXBna0x2?=
 =?utf-8?B?RTlhV0ZYcVFBU3ZhcE1kTFNoTW5wdXBhYkE5SEFqYWViMFVic0VpUnhLM3BE?=
 =?utf-8?B?eFdjMkc0VEh1M2plZ1U1S0wzRlVIZGxoN2VmNnVLL1BCT2xvWFM3YmNQekE4?=
 =?utf-8?B?MGJDeUgvR2Z1YWNOT2lkK2h5MTNZdUtlQXVBek1VWDg0WmZEdlp1QTNZcnJZ?=
 =?utf-8?B?QzNzam9RekU5dWU5Q3lySXU4bmE2WE9BWUl2UGxDQ2VWSVZuVnU2L3JaeXhh?=
 =?utf-8?B?d0xlc2RNTnU1UnJLUjJJa0laRml5cE1xUW96QmJVcXBSTENNSXFuNmtmTmgr?=
 =?utf-8?B?R1pMdjRzdHdSTkV0YWVZREptRFc3UVBaOGNuY3NUQnVuUzhseU1ubzE1QTZ4?=
 =?utf-8?B?emhVWHZ6dldqRUpKQ3BySVkxYTQ0SlBnY1l3ODAzNXdrdWQ3UUgxOEpxbk1N?=
 =?utf-8?B?ajBYRVEwbEwwZC9DQWhrdElnemxHSUZ3OTVicGhKUFZuTzhiQ3FabTEwaVIz?=
 =?utf-8?B?OWh4L3FpK1FVVDZ5RlVVK3dpOXpyRWNlRkp5aER2d00xclBueXFYWmswT3Nw?=
 =?utf-8?B?UmVBRXRNLzdCcHNObHpBcmcrb2YyWVd5UDlWRmZ6RUJ1dktSRElDL3JoZHNo?=
 =?utf-8?B?emJheVJOUFRJUldXckRaYktRWEE3alhEM0xmbFNvMzZoMElmRGphWW1YWWVo?=
 =?utf-8?B?czFIODkzNmtobThROWpheHRVNnJaK3B3Y2xnWXJwUHNCT05IcUNqVzh0U3dX?=
 =?utf-8?B?clJESlJrcVFoRllINDNBcjM0Qm5pSENiREFyaWJ6TmtMVzU3L0dJQU56eUNH?=
 =?utf-8?B?R3N2VkxKRXVmbkVVRlNZSmxDV2ZDa1ZobEdxRmxwUERTek1wREMxd3JGTyti?=
 =?utf-8?B?S3d2QWxsaGNyT3lxMHpYMDNZWW1uSW9jelhOam5sSVFSK0NmbU56WTJ2dGdJ?=
 =?utf-8?B?V05acUhCSnIySDBBLzBxYmJ0RXU3U3hxOWs5NjY4S0ZkbytnempIUGVTcXlK?=
 =?utf-8?B?bWxFckdubnpmcTZVRXZHWkNmeTFRdHBOWDc1SXVyNkl6d2NKV2lRdnEwanJ4?=
 =?utf-8?B?ZVR6SFpXVlhET0l2WHdVRGxiTTllY1VHUjYvMllNS1FOUGdZajJ3eGtSMlRF?=
 =?utf-8?B?YmNhUk5weEk2bnc4dFIvNHpLWHZXaTY1UWdTTGd5MkRsMEtnM29wYVhiZkNJ?=
 =?utf-8?B?bFRKb0ZpRWpkZHJpS1JEMVozMEs0TkswODZCa3l6ZVRMU2xCYXBVUk1xUFRR?=
 =?utf-8?B?MTRFM0h0Z080QldLNkRBaVd1dk5NN2pRWUdQeFZVQ3pPUXkvV2N1RzhlM3BR?=
 =?utf-8?B?YW1VcjczaGlXSVA3RGY2elZ6MTl1ajQwM1RPSkNmREpnOXl0YkF3UnE0OExD?=
 =?utf-8?B?TE51eXkya3R5dXl0L1Nqajh5VWNnSHBjTkw4ZUdnWkFkT1M2bytMNzRyUTYr?=
 =?utf-8?B?UGRnNjNVTjc4SnoyKy8xMlFyY2JxOUdoYTM3UThuTmZyQlN0NWlIK0x0Mnh2?=
 =?utf-8?B?ZWhhSlI5eUxjTVZOUCtlcnFaUmxVNlRLYmhvSWJVQUZRVDhGd2RmdzVwWjVW?=
 =?utf-8?B?Znhsd2I4djkyT0RwSlBBTzR4M1Y3bGJnaVUzM1E4Qjk2c211N3VJYi92YmxG?=
 =?utf-8?B?YmFMZVZLZWVLazBIeDRPMGNQSnBMZWpWLzd3dnprWDNzVmp1MFNZYTE3am94?=
 =?utf-8?Q?9PEMd5lK+Pc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czd6NW1zSitzVjVncnB5TTFNb3FKdnVYZW5BNWdib1pWWjU2VkxHRklSVkhE?=
 =?utf-8?B?U0prY1A2RXRGb1ovQmM4VncvRTZnb0JzQ2Zjdyt6VzFIMzFiVHhPVWp4ZzZy?=
 =?utf-8?B?YUV1cE9aWm83TUFWUllzeWJQMjdTTHVQYU02N2ZqNUxlbld3R0RiK3Q5UVgz?=
 =?utf-8?B?VUQrUHZkR0F4Nlc1QWhWVVVMZmxGNjgyWk41cmVnbHpyRG5ncVB2YXVUbnlW?=
 =?utf-8?B?VGlpMDdqQ1o4cFl4czl3TGQzdTRLTE1kK2ptdjBmSmh0M0hpUEE0YnF0VWNH?=
 =?utf-8?B?UnZ2b21CMnVBQ1BBQ3hCUWhiQWVlSzk2Z2psWDB6SmpTK3hPTEhuLzNBV09u?=
 =?utf-8?B?L0l2dGNRVUlMRmNTTDRjSjZYcUx2TmZNemFxZ0VIeEtEZFREeE55dFhmR1M0?=
 =?utf-8?B?U20yTHo1OHFVY1V6ajVGckUvMC8rZi9UbW5oTHBRUHpaK2FwdDdmN3cwRUJC?=
 =?utf-8?B?a2NCZGVqK3I5Y01TbytOZkpoRXE1c3paejBRNGpyV0IxZTNFUFJpbTVFWER2?=
 =?utf-8?B?SU1RVjR3clFBU29zeHUyOFFscWtTT0NOcnd5RlJNNVpZejE3QSs3QmhkeWZ2?=
 =?utf-8?B?d0t0WXVmYU1KZ2I0QlVmR2xuQlIxOVBwWWhEZXVVb3cwQ2x1VXRyV2QzSDU5?=
 =?utf-8?B?cis5NGxYQ0pCNUx1bVJDVTZ1RGQwWVZiNm44NHQvMzE4SjEvNjhwUnkxTlZk?=
 =?utf-8?B?WExSZjM2RDNmUmppNEZQZnErNFV0WEZOL24xYXFTNUhaZVYvQjF5a1NKTnFX?=
 =?utf-8?B?YjVTOTdUa1duYzNieTdQN3d0amcxMWQ2ZFlOR0xqUWZ1L21QS0RCRUR2N0pS?=
 =?utf-8?B?dEp0YnlaRWZOWk1EL3czc1g2d1lJRzk1TkoxVS9DY1paK2k3Zm5VWjVwcHhR?=
 =?utf-8?B?MXlGN3JuMlh1SVVpM09wN3VQdGVnbERNQlBmeDRQcDlMOTc3Mk42VVNybnZn?=
 =?utf-8?B?R1R6amtybjZiTDhyeWYzMWR3akpDQWFHUVJTVnJFcHIxZUdlZWJMRVd2UEZz?=
 =?utf-8?B?eXdKODROMUNuSEVHZGozajE4cHJvdGF0aGQwYk9jaEtlOFhXbVY4UWZCVUZ2?=
 =?utf-8?B?TWxJUi93RE15bDZwb01MWnlYbzdtL3p3UklCRFozSW55WFFJQ0VOQUVHc2Jz?=
 =?utf-8?B?a01UM3FVQkFvNmVHVzJWeVZyeXBIRzRUVnY4NFJpT1poVUhUTmVWc2FEcmo1?=
 =?utf-8?B?SHFuT3A0VHNmUGY5RXM4VWNOM25HK0JEMU5OOEF2OGZXMGNBSUphV1JGN3g1?=
 =?utf-8?B?R09QV3p2Qy82ZlFhTHBqa04vbThLRHl1OUhBaWZyeHJCZmJBSU50VnpodHJw?=
 =?utf-8?B?TXpnRDRmYzR4MVR4TXJQUTVjRytCQVBoY0J3SWFVaFpieWJIVGVVY1V1YlBr?=
 =?utf-8?B?R0t5SGdIcGdtQXAzYmxudFhXc0F3L2I3QmpLek4xSEEzdGhUMHJLalRGY3Qr?=
 =?utf-8?B?cGlIcG9kbVhCcVFKWHEyTVJoNGtvd1ovWUVXamdybTN3ajZNc01WYi9GWFFG?=
 =?utf-8?B?V09ETUZheHJwWklxUjZLOC9jZWttZDJZVk8rNWZ4bGlnUWlMd2tsZE5QRkpi?=
 =?utf-8?B?V01GRzg1cC9zcE5hQWt2eHFUb0xEZWFKdkRQR2ZQTXpOMHFZTWZlMG41a281?=
 =?utf-8?B?VTZuYllFaU1YSWZQTXVHS25HUGdZWGJwVDM1eDVjUzBSV2xPc3dCQUZhd2lF?=
 =?utf-8?B?YnE1SGIvM244c0NNZ1ErVzdIM1dRb3ZoelVGVndqZXdibTlRZVRFYzZ2YTdw?=
 =?utf-8?B?Q3duL0tFYUJUMllBTGVNTzdTakRVR0pZWDZNZFRlaHAxQnNFQ3F6SzJCTzht?=
 =?utf-8?B?M2hVbWNsalNtZURnMFdPSHlMOER1MktlREZadmwyeXcyOEltNnFGOUdpU21Z?=
 =?utf-8?B?L1lKNTFJeE4zLzhBT1FVSGJGRGlDM3JMdUxQaVVCWklLZ2d4TlQ2Y201SXIv?=
 =?utf-8?B?bFVmTWduMDlUdDlMbFFEODk2clJBdXZ1VG5GOEVGTmZKTC9NZG8vOVVQSndo?=
 =?utf-8?B?V2QwcFlCSHU5d2ZRejJ1Tjh0UXI5U0JLaXoyTHFPNnFsQVNjUW9CTk9Hd1Iv?=
 =?utf-8?B?a1p4SmJNTHJOc0svSFFIVllCVmxMVTF4VTdQcnNkUW9OL3hoL3hTQ2pVK09V?=
 =?utf-8?B?ZGM2SytOR1ZMSnZGOURUMThDUFlFZmRPTjNLUlphNWc5dlB1ajU5bHN1QWww?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ed2c7-7c7c-4fa3-4a78-08ddcacdf730
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 16:20:12.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze3bVqojZ+VT+UkK/asQrkkZcvmEXphktDmlpiT9+DlCbsQSG+pTKvs3BM1xx1zLwMMsa3Y3++VJmhaafNWkgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5898
X-OriginatorOrg: intel.com

On 21/07/2025 12:53, Sai Krishna Potthuri wrote:
> During SD suspend/resume without a full card rescan (when using
> non-removable SD cards for rootfs), the SD card initialization may fail
> after resume. This occurs because, after a host controller reset, the
> card detect logic may take time to stabilize due to debounce logic.
> Without waiting for stabilization, the host may attempt powering up the
> card prematurely, leading to command timeouts during resume flow.
> Add sdhci_arasan_set_power_and_bus_voltage() to wait for the card detect
> stable bit before power up the card. Since the stabilization time
> is not fixed, a maximum timeout of one second is used to ensure
> sufficient wait time for the card detect signal to stabilize.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 42878474e56e..3ce55009ba4a 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -99,6 +99,9 @@
>  #define HIWORD_UPDATE(val, mask, shift) \
>  		((val) << (shift) | (mask) << ((shift) + 16))
>  
> +#define CD_STABLE_TIMEOUT_US		1000000
> +#define CD_STABLE_MAX_SLEEP_US		10
> +
>  /**
>   * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
>   *
> @@ -514,6 +517,23 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  	return -EINVAL;
>  }
>  
> +static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host, unsigned char mode,
> +						   unsigned short vdd)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Ensure that the card detect logic has stabilized before powering up, this is
> +	 * necessary after a host controller reset.
> +	 */
> +	if (mode == MMC_POWER_UP) {
> +		readl_poll_timeout(host->ioaddr + SDHCI_PRESENT_STATE, reg, reg & SDHCI_CD_STABLE,
> +				   CD_STABLE_MAX_SLEEP_US, CD_STABLE_TIMEOUT_US);
> +	}

Doesn't need {}

Will this work with all Arasan variants?

> +
> +	sdhci_set_power_and_bus_voltage(host, mode, vdd);
> +}
> +
>  static const struct sdhci_ops sdhci_arasan_ops = {
>  	.set_clock = sdhci_arasan_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -521,7 +541,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_arasan_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> -	.set_power = sdhci_set_power_and_bus_voltage,
> +	.set_power = sdhci_arasan_set_power_and_bus_voltage,
>  	.hw_reset = sdhci_arasan_hw_reset,
>  };
>  
> @@ -570,7 +590,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>  	.set_bus_width = sdhci_set_bus_width,
>  	.reset = sdhci_arasan_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
> -	.set_power = sdhci_set_power_and_bus_voltage,
> +	.set_power = sdhci_arasan_set_power_and_bus_voltage,
>  	.irq = sdhci_arasan_cqhci_irq,
>  };
>  

