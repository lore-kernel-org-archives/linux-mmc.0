Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619F79CD;
	Thu,  9 Oct 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000393; cv=fail; b=As/EHIX+cbQuylcayKfwtyeApa5/f4o0SAe76TIj0dgmXtToJTCrdNzNbRZCRaa27PsdztGgFM7I8CJ0JPk6Pu+Q13PA0NrRWcxETXzg8D9S/zmPw+CbjxdXmBYdWK976ROuoSgsGi8kqIen3iI3yH8xD4t7h/TFr2vvXVVAxIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000393; c=relaxed/simple;
	bh=FcQyKS2Q8wU0cpQoPaHCJhzPHO4a3HsXOuktm/WORI0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JjGhPFy+4+VYHDU1wyKg+p5zXaWrYcoNTLFvk8ma8OxfVy208/4hg6VmeoCW+ymYPjwp00FA0psvDVeBwEdJAkPvGZk7v2gtLCFYYL07wlvIjlcf/wiCzbVhQXdz4U5N5RbiD0ktiRnlQkPW/IZuwdQ4p0DvKhBBiDniGon8NLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXiHKcs5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXiHKcs5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760000392; x=1791536392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FcQyKS2Q8wU0cpQoPaHCJhzPHO4a3HsXOuktm/WORI0=;
  b=EXiHKcs5cXJvPgGbcZBSSmeW/lDP9A+1BkbaPeDoXJcQP3+CGWVEOHbE
   0Fv5ow+MgtAZ1E/GsPxuF/0Mfjyi0JOJKhLqB+VaSVPP87xnG+DDsHCGq
   X+yYXQBNgOVrFS69TLfZTVKhzWbQrNYq5OL2AukavdGd5n/owoLk0WipB
   3jzWwV9riD9icY1a+DE2Nx3C25RdcbY4UeHxMQdMVWIC94xGW/t9d7aEk
   i/0AHJb2I2m4nocWX4FAs+nbjPYkj6ojrUEeTW9r9j5fn/DSvDbGfy4gx
   DcFbz3tVA/0OOf3K6/CSAgDdHO18JfjNjA0IYKxLSCA/MRRon8NUtQKHz
   g==;
X-CSE-ConnectionGUID: hfEk4uwJTeySfeW+ixzNWA==
X-CSE-MsgGUID: GbtqrRrvQoGVKJC5gVb95A==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62248962"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="62248962"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:59:52 -0700
X-CSE-ConnectionGUID: osOfFxqTS9GwEd3sHJXnZw==
X-CSE-MsgGUID: UO4lO1mYRdqwyWXQW5rYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="211308574"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:59:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 01:59:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 01:59:50 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 01:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh0fs9hfQgDX038tyrFEksmZ4iJmXRf86d1hGSHBSEh9ntbcfo/jf0vCymKRNQK6fKyjGtgGKcR6JWVVWWfJZGhyVfbiV8MVHxFZSrQEnR0gVM/OrxAN4IA+2zM20SWe8tBMh0PUzM7myFnZURqEeH68NWm3Xi92bI9g8J/kZhQrveb+jyGUQkbw2QvgysgbGta+dsKzyyVloNdLdWl8K+11QwR2KPLkyqK0hxKqByr3rqz1qmj/3OtBSGacDQ2T9lGruKQE6NzG+TPyd5SttVI4UVUPzqGmAaEvxaci+q5SfFw5HqVgtdkY1T1Fkk2uyLDVm92/j7QP2HCO1RXbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXYc1pXwgUi6dPT4bZ4T92ciwvtlXeH6dfawtpngNp0=;
 b=rE7Y2c+eZGtMotwsHORjMeMKnCsd63dEbcAQxwpNFA/k+d2ISuhxE+QbKjp77L6xoXLPHDg2Tq/FqWjx0xmccdXRFKO+c6vM64+/po5sQ1xJZXDXUPzmNmKjzXMPVOwRgBbwUiIHVNW1Gd/IKVWShyOilHoKplW4KXtokYB5/uUYZHWHDDkSjftijadq21SuRxXYhXjJtPHNWPMdudrYCFS5aqM1S5NCmcCqjT6lMoyvXj145LpWGwvZOhzQxCb5sjg5gU9lk/LFjaZ6wwoA7fuxFIc0BjkmpSGR5BnzpnQBzmDCx1XTfJxXyevaMR1wtCgNc54DDa0VSaehP7DLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 08:59:48 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 08:59:48 +0000
Message-ID: <3a6f1801-30d0-4e7b-b5d2-412d67ce16f9@intel.com>
Date: Thu, 9 Oct 2025 11:59:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY
 define
To: Kamal Dasu <kamal.dasu@broadcom.com>, <andersson@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<florian.fainelli@broadcom.com>, <ulf.hansson@linaro.org>
CC: <bcm-kernel-feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
 <20251007140434.606051-3-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251007140434.606051-3-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|SJ2PR11MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: a3617422-d98f-46a0-bda3-08de07123259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0E5b0d4UVZ5aklIL0dDSlg4c1lnTStWOThCa01rbnIzdG9KdWRGcWdvN3Br?=
 =?utf-8?B?MmFRcmhrTWVIam5xdGVsbFhPaVdEdUo0d1Q2a2trSkpRL1lVcHJVT2FCK2Ix?=
 =?utf-8?B?SVY5UnJ4Q0tuR0tiMURlc0xDN1haWmRwQ3BISGZGUjRXYXNrMk5IdS9aUmpX?=
 =?utf-8?B?MDRsTFYxTVlSQ3o5SHd2YjFzQks3WUppb3RNYWpBMzBxYzF5a3MzT1RpR2Jt?=
 =?utf-8?B?OFZaWThsa1l6M1RSby83UkJJTjRzYUxhRXNSamVTeGhyNkNISzYzSWxHU3Js?=
 =?utf-8?B?NEhPVFRkcHVSSG5VR3hJaStkVSt5TkVFUWVWTURScjdNeFh5Z2R5YzQyOU96?=
 =?utf-8?B?dkRBS1J2ZXlMT3pmVnR2M2tVVXVubTJGN1RvVDlFYzhDV3dkVmx3MjNOUkVh?=
 =?utf-8?B?L1BNQlgvYnpRNHhVbS9KeGkvbHdaWmc4M1c3b3V6dFg1SjE3Snl1NXVFeG5m?=
 =?utf-8?B?REZLTG1QQTJZVk03cXdyS2hyTkNzaWlMWHEwdUs5TDRVam1XUVk0S2EzUUdr?=
 =?utf-8?B?U0FzUEEwcUJmSW1LYzNZYWRjVkV1aFE4U0hJVlNQcngzbnNwVHg3ZnJRdEdq?=
 =?utf-8?B?ZDJuRWh4VW9wMVNLanRUY1huTmdiTmNrY25NWWV5SjYwL21iczZNRmltblRC?=
 =?utf-8?B?ZmRvQStJdTRhY01rYkNEVU52a2hHdzQzUGJlaE9XMDY2TnF4b3Y1cmt3U1VL?=
 =?utf-8?B?QXlyM0psOGNEWUVydW5zcVV2bVlmVWFRUHdROVgvaFRCT2hnTjluUm15NERW?=
 =?utf-8?B?ODFya1FpSFAwNStVVWovWElnNXR1ckFzMURnT0RyRml0ZThrbDBzWXJWcVFR?=
 =?utf-8?B?b1RpeDdtaC91WFFTRi9KQkNxaXVvYTBKRXhyUkxDcmFwRGd3cGtqOVI4YzFI?=
 =?utf-8?B?dUxnaFRMc01XR3VKYnAweWRGTk1XTUh6T3V6S09IVnI3dHBuQzdzN2d1UDkw?=
 =?utf-8?B?cTF3T3I0NUxLTkExUTZWdVo1SWdEMjBudlVLY0xwaURORStrK1pJd0dITDJT?=
 =?utf-8?B?M2tTejlVSno1bU1zRzBJQVY3Vm55UHRETERmM3AxWTdVOFFFcVQzSTBmS1Bt?=
 =?utf-8?B?S04vTmZpVCtRZnFBakI1eUVJMUVDNVVpS2p2VTd2L3NVMEwrYytpUUEyMEMw?=
 =?utf-8?B?amhaMmE2SE0zUGRzVytrUnlFMzExUkhHc1gzaEEyejVKNk1TMTBSa1JQcWpG?=
 =?utf-8?B?aXZqdWk0c0FvQ3Naa3d3QU8rUUNyTzF1RVZ4NDZVL0VBbnl0UzE1enJiWHRZ?=
 =?utf-8?B?SkMveXJzUVo0M2Q2R0d3Wm1Nc1k0M3B0V1hGNW54eVVQVWNTTWxjRG45M3Nk?=
 =?utf-8?B?UVpUZHFjbWQzbHRzNkpGa0ROcWNPZW1PeW94Q0FhdlV6RGluS3ZoaU5XVEFQ?=
 =?utf-8?B?SDlQNDZla2ZGUm9JQzJsNjV1ZUFxbWN6TnI4S3BzTUR1REpvSW1vYnlleXV2?=
 =?utf-8?B?T2xZNlJwVFcwcEVjMkhaTGI1NUR0aUZSRFgxN01zS0Q0ZzVyMGpja1g2Wk95?=
 =?utf-8?B?SWFlSUdJOEkzNDhsSlByUlNnM0s4QWlDeUVrM3VUVjJZTHlxVFI0dUc4S0pa?=
 =?utf-8?B?WkIvYUVVcnJvZVlHMzlKbmRXa2UrL21jZ2p0Z0dLRlI0OUhORUNIbm5FWnN5?=
 =?utf-8?B?ak5aaUoyUlFVMXFoYXlxVCtPc25vRk55S3VYaUJoajB2N2xTeDFERVpBYUxi?=
 =?utf-8?B?anlsdE1HNWc4OHlHYWFobXh4TE10RlEya2lEZ3ZXTWJyckJGdE9lUTk2aldu?=
 =?utf-8?B?dTJkSWFjdnhudTRoMnhoY3Y1ZGNpdTVvV3lWYVZiSjc3QUxRelNucmhSMWxH?=
 =?utf-8?B?bHMzUENiaXQwdHliNUJuQzFuditjWEZHcFEzekx4NnVuUTFRQjVBWWtGd1Mr?=
 =?utf-8?B?YnR1VmMyaGpMSUw4akc5WnIyN2JVSUJOUnJkTFg4ZElZK0ZEOEJUTXlvMEVX?=
 =?utf-8?Q?nflxb02z6BPjg5X2rusW1qPq3Q2loAti?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri9LUnNLa0RSVVR0cHhvQ3NmYmY5dk5oU0hGZW9LMkVuRXMrY2RaU2RxTEIz?=
 =?utf-8?B?OVZtRnNaK3pNK29vUVpWSzVFcG9UNEdQWkI0Z2pCb1dxdC82VWhYa3Rzc3h6?=
 =?utf-8?B?OVdFYXNQYUFJZlBkdzB5N08zVFVyT1JnZ1RFNEtrVGdhOStLM1VaY0lBTWdJ?=
 =?utf-8?B?MFg4V1BRbHgvNFpiRk1Yb2JYM2VUeFFpdVFaVkMyL0VuSHZvU1RERzgxTkV0?=
 =?utf-8?B?eHFtdU5iVUdNdElKZ0xWMlEyMVlkaXczSllSYU5vRzAwV0d0QkJVMGtBZzZ0?=
 =?utf-8?B?RlVmSXFkUmhSVzErWTI1OWhLMzVuSEVrRVN5Q0ErNUhxQVN3cEx4QXBpWlRr?=
 =?utf-8?B?aEtoVDlxSCtYUm9VVURZL2dCQXNHSVR5MVJpMTYvNW1yNXpIblpNbUZnaGtl?=
 =?utf-8?B?TWdCTWZ2d1YydlA4Rk1Rd000YjRZaUFwc1ZaRkJOVm5DR1UrUFZkamVkZ1lR?=
 =?utf-8?B?VlliRnByK0lya3k5Y3VlQ0FwWWpJZzEyMmFwSVZ2MWxRdXN0dmJIQTNJVVJ2?=
 =?utf-8?B?dEo4ZTk2TUplTXR5WEJLNG9oc08rbTIyQ1RlZ0duZ2liK3M4Q0ZRUUpyamJ5?=
 =?utf-8?B?M1VaYnFIQTRyTjdJd3VMNjlab0J5dDRTNnJ3Y2xIK3BIcXhRV2cyRTg3ZXBh?=
 =?utf-8?B?YUdHaERLcGpNeTUzeElubFpoR1R6dkFvTm96MVJLUXhndFRIQldKUUZXaUh2?=
 =?utf-8?B?TkdLU1VxUFdxZGU1aWVXZlZYazRmdWNvSkJFb2hGT2JwcHFiRlNBMEZuVzMr?=
 =?utf-8?B?VTl3WEVzSjdnem0yL29nVGd6aElocDVRb3d1QUNIdFBoVWlPZEs0MTBpcjZS?=
 =?utf-8?B?ZEZZZUs1Tndnc3lPVTJLcVRDUnhwN0RxK3czN1A4SDRrL0d0dGRocnJOQi9a?=
 =?utf-8?B?dDZsME5sRjBzblkyRHlPQVlEWWxETzBjV1hKaDMrd0U0b1gveU5tcUpEU0ZG?=
 =?utf-8?B?MkpDVi8xaVpab0tYNE5aczlYWGFtdDNvcWRHT0N4dmN4c2pVMzk2QkxpUWQw?=
 =?utf-8?B?VDluME5kd3FBaFBIT2E3K1ByQVltTWI3WjJXRzJaclZpY1RVL1FBcmMybHY5?=
 =?utf-8?B?TGRSeW1xcHVSdVVKcVp4a2FpWGxSMVRWU0FGeWZDNU15UjRaTTJkcDZJMks0?=
 =?utf-8?B?ODlGQjVrMnQvVzdxa29HZlhUU2twVTJpb0hma293YzN1ZlczSlRHVXVkZ2lZ?=
 =?utf-8?B?QlpaVVlnRnZsWEJYeWs4ejA0TFErWi9WTUVZS0ViVFl5Y3RBZERGVEFubUM2?=
 =?utf-8?B?eVd1emo1UVlKWUhoTEFOUVJvWXZ5dGZYNUVFNFZoZEY4Tlk0VVVmRTJVOVJ6?=
 =?utf-8?B?VmdreFc1L3BrQXpoOC8rQ0MvcW5tQ2lRZHBOOFVhOFAxbkVsTDFyV3RrS3RT?=
 =?utf-8?B?WlZuVlFhek9iNjBPbGxZVUNvQTFveFJFdUVxQUQwTThNSnBLZi8rVTNkS2c0?=
 =?utf-8?B?Y01NK3hsWW11NFZDWE9HVEFqQ1pKV0J3Q08vUUJZMTJwNVZmN1JDeEhHYjd2?=
 =?utf-8?B?UEo3ckRnbys2ZTZxMTFMN0E1L2VNTDdQbnlSL2wvSHdXdjJMT3JQYkNmYUxl?=
 =?utf-8?B?aXlRZXNxM1JyVzcxdENIQTN6ZmF0dmNHdjNNdk9xU0I4b1VVYUQyR0tFNHNE?=
 =?utf-8?B?TGZvQmxiZ2Z4bzFQbjRuSFhxUytSU3RZdFQ3VERDU3JEMUswdk1ZL2ZjMHg1?=
 =?utf-8?B?VUVHNkdkdHVPbTNYcFh2TlhGbzdYZDMzWE81dllCTUMzZm1sQmJUREVFZzh0?=
 =?utf-8?B?VC9vK0hYREg1L1hDWkZwVUFjRktCeGkvYXB2dE82bXNsbkdtRXZZd3p2RnRX?=
 =?utf-8?B?ZW5aTzVFUjdxVWdGOEVlNzlzRU9qZlpXLzRvbVRTalFkQ0ttMTlYTXZ2K29Y?=
 =?utf-8?B?d2htSzRLUmM2bFVVeWQwcGFjYWF6d2R1NWlxZkNPcGpRbzZoa1dadWh3ZThi?=
 =?utf-8?B?YWxZTERkT09YbmF0aXgwZEhDR0hBQyt1STM3eSt2eTMzRTV3Y254N1ZpT0Ur?=
 =?utf-8?B?aGEwVDdiWWJDQ082SGYzVkE0bHQyRWM1T1h4TmlqaUNYb0czaEhNK3lKL2dY?=
 =?utf-8?B?ZjVaLytKYzRMTHRRa1hNS2tIYWpDbXI0a0VEYnp6UEEyUTBUZ2N1N1drS0VE?=
 =?utf-8?B?ZFhZcTd5U3FzK3puUzg2ZnhlVldJanlmSHZYMlJlbFl4VkNTalFEL0VnaUdX?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3617422-d98f-46a0-bda3-08de07123259
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 08:59:48.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUjQwWvfWToqlU7Ad9VaoNpIEBxjDsvEFfOo0AGYfvN7G5VCH5JvnWPKA7q1ebnkNZl8xkI1bF5mLfH4gDHCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

On 07/10/2025 17:04, Kamal Dasu wrote:
> Moving SDIO_CFG_CQ_CAPABILITY register defines to be in sorted order for
> better readability.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index efc2f3bdc631..f81cc1889ac9 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -31,13 +31,11 @@
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>  
> -#define SDIO_CFG_CQ_CAPABILITY			0x4c
> -#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
> -
>  #define SDIO_CFG_CTRL				0x0
>  #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
>  #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
> -
> +#define SDIO_CFG_CQ_CAPABILITY			0x4c
> +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
>  #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>  #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>  #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)

