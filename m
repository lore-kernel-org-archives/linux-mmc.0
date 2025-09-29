Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57746305E05;
	Mon, 29 Sep 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152576; cv=fail; b=MCPMQCcdxRCIBVLIMxuSWI81xPSHaoRCwOVQqORw8fUFGfXHBixcTUAKOQwiZAveAu1Kbrn5OxDf4IkvNK6Z3gpGiBazDmfPtfXxkO/yYEVMlwvJXrCHQ9bo7e7iPkzieGu42Ai6tbtSqq5MaDSNFJlZZ8nsCe24cR7PFfHahys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152576; c=relaxed/simple;
	bh=+BHIA4I7LCaS4aAMY1o3LVrx44Ijfq3hlojR8k7v7MY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4GFvHubXkQTNU1xRGSmpFjrCJyyM7RqMJy2R92+vgzQuuu3iAY7r3SlTPYzvs6GYYXUkpIx8eKsqznPEIo2co5rWrUTWP1D3Dp1q7kxiH/qtCkCu3wstLnaskX8N3O7fU82D9lvvZQlcsHMCHMlN/Z1uTwlKrKFx+yXegyogDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFrZxyGQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFrZxyGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759152574; x=1790688574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+BHIA4I7LCaS4aAMY1o3LVrx44Ijfq3hlojR8k7v7MY=;
  b=kFrZxyGQGeGqz4E2vUm76iA/KSoAE1A3V8yNR42435PaebEqjAbMtsoA
   Z2CZhg4KYzXbOS6FL5c/pXUXNyfTWsHhf8IwoBHKLt91jifsLJX2KZepg
   g0v7OTdMAqRYmd5oHLL7Xyefx98tkP8G2/Iw/p3xxsmKWc/nAzF4Y5+vC
   xu6ObMo5zJKGmfe2MuqwiG1Ex76UgQI7LjvN2WDriW1fpH3/1rQkmzDwC
   F3vwUezIrCYFYXwYYNhyYeBF4h3mTv2MW93tKL6Hw06tNjhzlEYzo8f0n
   kb07p1pkvHARLFQ+3N6CNmLA4rS5dxu8RXiKMZUIxlWvkIGjqkMU04R48
   g==;
X-CSE-ConnectionGUID: g4uQ6HYbQsKex97ogi6oPQ==
X-CSE-MsgGUID: gD340BgDQuyGiKf2VQjJnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61502225"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="61502225"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:29:33 -0700
X-CSE-ConnectionGUID: HpajiPVbRcu+gx9pdCCsbw==
X-CSE-MsgGUID: WqmGm/OfSkWwsV1DfzUPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178178173"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:29:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:29:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:29:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AscSwBaqGAMMwuzgLKdlxqMLRxkmwocdPdtiG+cJN/uyaddZt7J/CXXcu6aXrEA1QdJdvkElF8JpeLHwCBd6rboli6gOiqceBKxi8c9vMNaO4KALiHsDaj3+5FrFBp3x+6q9FsDJ/RvcT69rZMMmq0bmat14Ioy8LOXI7/gU0MRSP782V7EjqFmboM5/YGzPHQvXv+LtjW4Ssug0E9kwGM/a2HE3vDHMXDp3CY85hsbQaT7cbTPZ1F+YKEOuJduGoZ+dhT+kgjed15XQsskHXMT2TXHSg1YySasZyjuosnonmrQfFYqsace6IbjEp/1YlOPmktN8kNeGO5KTitvDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8QD6uzcCPam9YXROxpQ2vMAxS+kpeiJM85PfNlctLM=;
 b=HKUvgSq9iTOkDtwY13XPvOcd66Kd/knIVaGxrXHy2XU2FpG7RMTLXQ/GO+RgSSDpVwW4Sqs3OYaK5nrBua+9n1dtmOtgvxzMr2LS97ovZ6YIgE1brRscUesnDTs8q8vxGerTYeP5/gVrIBSB0pWZ3bwgN6eb3a0x4Bq8CplgDlYoDK0beTpfmPsGxWjRUti4WHAtKrR5hcYkBbDtu+zBrhbnLZTp2AfqSiP2yhh3+GvsBwkmIYjg2As2AMuz/v3yLMuupSS6z27W1ZHvSWcX/BIBcGP0h5yjcFLUWRlYEBjoN0kEjdFDZBFYXPvHCtdyCc6GjRuCigkNhX3mbS4blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA2PR11MB4809.namprd11.prod.outlook.com (2603:10b6:806:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:29:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:29:30 +0000
Message-ID: <57743880-aecb-4300-8386-44d962659921@intel.com>
Date: Mon, 29 Sep 2025 16:29:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] MAINTAINERS: add Black Sesame Technologies (BST) ARM
 SoC support
To: Albert Yang <yangzh0906@thundersoft.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>, BST Linux Kernel Upstream Group
	<bst-upstream@bstai.top>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<soc@lists.linux.dev>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
 <20250923-v4-patch-final-v1-9-2283ad7cbf88@thundersoft.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250923-v4-patch-final-v1-9-2283ad7cbf88@thundersoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA2PR11MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 506e3f5a-3122-405f-ba7b-08ddff5c381a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkdMcTJEQUFNTGJaOUNDQWNRTUZCMjRTdkxvRk1qODNNd0JNMW1sV2xrSDhX?=
 =?utf-8?B?dDlZaURYRkhqUTdHZ3dCczNybUs4TlI5RURWd1FITjBpRXNwV2xBK2V3UmVN?=
 =?utf-8?B?RU16c05zcm95QzhTa1hYVmZncmNGMXlYNi9QdzBNY2ZhOVpZTHBwbFRCMm9F?=
 =?utf-8?B?bjZVNC9JMXN4S0NFZG5yRGpRY0FjeUs4UGlWUzY1Wit2Nk5LSGtkamNVVXVh?=
 =?utf-8?B?WDJ1d1lndzRKcHhrWU1JZWUyRVUvbElvVEs5clVsUVhZNkhUajdDL3ZhLzhr?=
 =?utf-8?B?QWhGa1RWU056c1VIa2l4amo1K1JxclFjTWNKWE5YTWVLb3k5RmNiYkRTaThE?=
 =?utf-8?B?UWRJTVpPMHBVWkpLWVNOYTBBUmJScTE5S3BQQjhLSjZvc3JkbXFPSCtPYnYw?=
 =?utf-8?B?VkNGOGc2bWc5VklrTnlPZ3JZNHhXR042NXpUNGV6UTdseGt6YWtWOG5Bc25F?=
 =?utf-8?B?a3hIeXNBd3BwUENKSVphb0tXcnJtSDlMTkh2QkpvR3Jub1F5RG52OEJFRDBJ?=
 =?utf-8?B?L3NIWFdQQyswU29ZMWxtaGhPL3g1Z2kvQUR6R2t0UmQzc0NFS25HSTFhZ3Vm?=
 =?utf-8?B?TVo2c1JQNjVkaTlPV3Y4NUtmOCtCNEVHQnVnVU1USFRmY0FJUGh6UnBGYjlZ?=
 =?utf-8?B?U0haRGdoSEdvWlE1b3dCZ1A5eWE5R3NLSGkzb1BTWTlZWnNoNytSZUNXdHFU?=
 =?utf-8?B?THh3dzRTRU84Zks2VUo2ck1vRVJacnc1QUtzWG0xaWxmNml4MU51MG84L2VF?=
 =?utf-8?B?OVJwWGVUUVI3SUtGT0xZZzdIa1NjWE1tZmlvR2JiSGNoS0dOaFZlbzI3SDFo?=
 =?utf-8?B?cVl6S1Y0QmJ5bmVPcjZJS3pUVkVWUUtmL0szK2ZGTFhVRFVaY2lDVTI5RUVw?=
 =?utf-8?B?dm82ajRlSEI0VllzcVlQYnVOMUR4dGFzNmh1ZU9JNi85eHYzVjJzUG84blZw?=
 =?utf-8?B?TkwyNnJjdjgwaDVrOElMTnNML3Y2ZmM4RTJ0STlLR0VlZUtPc1RKUG9LMFJu?=
 =?utf-8?B?OGJTTXRKT1FvajQrbU5EWXBrM3RZNit2QWJyb0FWYWI4TTZPd3ZpWlh1NEhl?=
 =?utf-8?B?cENmQzhPdUtBaUtFaDRHN1ZrNVZHMnBNWkpFOGNlVGZIT2pHT0hndmtOY2FX?=
 =?utf-8?B?YTEvMllpL3pkNVkwbkUxK0NvTlg5WDJmNjBWdUJ3ZjBUVVNqYkErd1V4akUv?=
 =?utf-8?B?b25zaW9zaDNzYXl6UlVYS0s3QWh1UlBmcnN2dFpocnJydTRrcnBkZW91RXhJ?=
 =?utf-8?B?WHVnblhYUklqcWJCaVZxcktMWjVTS3NVTWt6Q0RBNFJtMUpnUHBCbWx3Tkhu?=
 =?utf-8?B?aDFEZG9ZZXlnaVp6QmFCeVZGVW1hYjhWeEwyWDJaNjFnekd0bHVKUXJEam0z?=
 =?utf-8?B?K1F6OVRJYmVZcnU1Wkxkb1p1YVJDZk1sd2Urd0ZOUEx1VE1FTFRhRjg4M3NG?=
 =?utf-8?B?SXRpVXJjS0traDAxVk1YV2ZPd3pBTXN6SzRtSWtwSnBiMmxWOThmMDVQSTRD?=
 =?utf-8?B?eWF6Wm1GSEFMd3krWTJOaU9sUHE3c2NUUzhKNldIWGl2aVBnSExISEtjQ2tH?=
 =?utf-8?B?NmJhalJ4KzdJRGU0NDhvMkEwL01aWFlkMzh3bXc1UVhhQkJMUEI4SW13V0lh?=
 =?utf-8?B?Qy9aL3RIeUlkKzFqTmFTbmpOckMyc3RVOERtWW5lclRxVjErT2JoWnJUZ2hX?=
 =?utf-8?B?U2s4WFdkYUJmenA0UTVvbVptdDhIUGJxNGlyYWRUY0V5NmtJQnJycmVORklT?=
 =?utf-8?B?VXV5OHRwbkdBekIwdlZFdE1rYjhiQUozQ20wL3N1NXFqWjBhZmVUdnRRY1NW?=
 =?utf-8?B?aEtQaE5ZV094SUlRMlRPSXM2SUxTMTl3ZUZ2cXhka0I1c0VEdzA2TGxmSE1Y?=
 =?utf-8?B?MmxSYVJuMndRd2oyZEtrSzJjK25XTmtvQ3JJR0t6NGxEQkpLWjB0VDBKcHNs?=
 =?utf-8?B?MXdjbmpqREw0NE5FUkFUQVBWQThBSXIwWU1JbkMrU0ZCdEtPVU5NM0gxd1RU?=
 =?utf-8?Q?0Ux49Rw1/4xU75IOc9PxPg5p4qi6jM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTdIY3pEUTdudVZtYzl2MzhVYU5lNjd3MmtuRmFENE5NRzNXbFBVbStPeG8r?=
 =?utf-8?B?amhLbmJGMStLbk1WcjdWWng3K3NoQ2VIVFVaQ096Y2VoT1lmSVN5TU84dlZt?=
 =?utf-8?B?MzhTbnQvTzF1M3hYK3UvL2d5SmNQcHVjSEhhZDVHM2hURWQwYzc0V3RjS25o?=
 =?utf-8?B?dGQ5NkRGaGxpR01Pck9NSGcrbWdHYndYTnBPWjFhOVdjMmVISHNWK2FuaE53?=
 =?utf-8?B?NldDNnFOZVAwNzJDTGdvdG9LSlJtS3hQTWhyVlRKd3JDTWtURTcwZHJwV0ls?=
 =?utf-8?B?ZXo3Zmg2UGFRS0VzUzBMUmRscTdLcmdNMGtueHQ2WWg1TzlNRC93Qkg4WVBU?=
 =?utf-8?B?cVVKT0k4Z3Y2NzJtcEhmMFZoU1BRTWV5WHlEL3UvcGpsbVlFQWdIUktGV0RG?=
 =?utf-8?B?OVZoekpRS0pMRmJXVGpRYkhNcnZsYTI2NHJtNFhwbU5FdlVFYytEbWFIcU9Z?=
 =?utf-8?B?aGFXWWpwaC9NZm5temZhZUE3MGIraGQwN0FPdTVha2o4STNFOXVSYVp4ZlhQ?=
 =?utf-8?B?RzRnbzdPaWNnb0c4bHFSTk9Bbk5HZzRNRWYzbEV0RmtMc0xwUVc5L0wvWW8w?=
 =?utf-8?B?TUwwQ1ErTEJ5aFJKellTa3Z6Tnc2YS9iOXRZNTYydXRKZGJmYmF0N3lYZFBr?=
 =?utf-8?B?QUl5Y01IZ09jeWFpb2plL3JiS0V6ZlN3c3lFWTFBMGlZZkg0WmdlYUhaWkhG?=
 =?utf-8?B?b2t1b0VWY1hxeFh1WU5IRTdsdmRuZnVYVUdCK0lwcWQ2cjZIREF3RUY5cHlk?=
 =?utf-8?B?Y09oNXJNTWhkNnhHNGU1emxpVTdyMjJyYnpmdmNTaFVMbnIzdjFYTlBJbytD?=
 =?utf-8?B?aXVRRmZDYWw0K2FjbGJJQTdDWSsvNEhZNTdKT25SRE80cW1rbmZxZEFIOFQz?=
 =?utf-8?B?ZTFnVUw4ekpBbnR5dGFLRUlla1VKdTdWSG9nMVlXU3VRaFkxT2VRMTB0S0gz?=
 =?utf-8?B?VkNqRmFkZnJwUXAyYms1RkFydWdJaldGZG1Ra1pZdUcyZmJkNlNqM3haTURH?=
 =?utf-8?B?Z2VrVCtzQiswSlZJS0RLWjUvMjdPSVg0ZzYydTZNcGNTbEYrVUNMOE5PaXk4?=
 =?utf-8?B?YlA2Nm5sS203UjVPdzhidE12c0NqbWVtem1nYm9IWDNEa0lxSWV2cCt2SGRV?=
 =?utf-8?B?R1FIeDBRMFhwS1VaNTZCUitNTnZrWEo0cFVxUnlHWU54dEZqWVJWSG1hUUpO?=
 =?utf-8?B?bEZTNGVobXlKOEZTdzFoMTV0dmxGejNDZkkxMzZEa2NSN0JsQVR0dXRLdWtE?=
 =?utf-8?B?ZUN1ekJDcWFyem5VUEoxTzBhUzhkK2xoTFlEMmY3ZHNBUGVQb2REMmRZMytw?=
 =?utf-8?B?Q3BGazRTU1VJRkNVZVJUL2dOZWdwOW5MRHRoRUVNUThPamd6Ymx2ZFlITCsx?=
 =?utf-8?B?dEQyTUhhOGU3dWNQTzBmMm9MdzVMTXJCWkVVTDJteFhqRUE4Vis3SkhUSThL?=
 =?utf-8?B?VmlCak5JSW1lWTlFTEZneGdwNjZpemdtakQyL0RZYitxRFJNTGpnU3JKa05Z?=
 =?utf-8?B?a1JHMzQ3LzlpdjIzclRCbnFWdlVTaUVqU0IxaGNwK1dTZ04vTUN6b2tDalFm?=
 =?utf-8?B?US9JY2tXNGU0RVpWRXd3UnIwRHNqSzdVNE1CNFNjekZBb3c0enRWUU8rT0dE?=
 =?utf-8?B?a25GNDhXcTVDaTU4c3hrRzExOWdOcFRzcUFybWhDVEIrYTMvUDcyQzhhaUtH?=
 =?utf-8?B?MG12VGpMeUxKUzVqRDVXNjhrWUlvc01YcDBONThFT3ZxQy9DTEphVTVSUnND?=
 =?utf-8?B?d0JvRkpaNWhxK2tSbml1RDVaK2hEWHJZNFNoUnBrNkpucXU4VW1ac1hZRmYz?=
 =?utf-8?B?SmtYa3BkTFE3V3pHYW5aU29oeFduUnM3THVpdFp0TjdNZEdmaVF4WGRYaC9z?=
 =?utf-8?B?cHRoTkV5djlhUEhURVllbGNvRGNlMmUyYzdQTUsvSTljOGdhWkRhR0JCTDJL?=
 =?utf-8?B?ZExSR1hWZHBzNGEvTkRVWGhUTWt6Yld1T1ZqZXZ0MnpoSkl6cjR0eHJKVTVW?=
 =?utf-8?B?ZUY2MjVQRERkd2ZCNUFXS0tDYVRUM01FU0JlNW8wbDZhYnlrVW41ZEN1KzFi?=
 =?utf-8?B?d0I5a3hRa0ZMbWlnTUJSdFhhZENIbG9ZYWNDaTBVNHp2WTlMNW4vZ2RvOXNh?=
 =?utf-8?B?RjlaTUxkamlXbjRmdEwxTklwcXQ5cUNsWnZnZUh6SDN1VHlOUXc3eGtnNXB5?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506e3f5a-3122-405f-ba7b-08ddff5c381a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:29:30.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+1gPut3xoLpMAhAnDDb9m+3s5/Xa2vH5X8Dz0EPrC+GwyFqbo6y/zOwxj/j6RLAscplHTPi/aqE55tyJH0n8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4809
X-OriginatorOrg: intel.com

On 23/09/2025 09:10, Albert Yang wrote:
> Add a MAINTAINERS entry for Black Sesame Technologies (BST) ARM SoC
> support. This entry covers device tree bindings, drivers, and board files
> for BST SoCs, including MMC and platform support.
> 
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
> Change for v4:
>   - Changed file name: sdhci-of-bst-c1200.c to sdhci-of-bst.c
>   - Changed title from "add and consolidate" to just "add"
>   - Simplified commit message description
>   - Removed Signed-off-by line for Ge Gordon
> 
> Change for v3:
>  - No changes
> 
> Change for v2:
>  - No changes
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd7ff55b5d321752ac44c91d2d7e74de28e08960..685294ef3e2ecf124219b2c5eafb8cad25600652 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2505,6 +2505,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/blaize.yaml
>  F:	arch/arm64/boot/dts/blaize/
>  
> +ARM/BST SOC SUPPORT
> +M:	Ge Gordon <gordon.ge@bst.ai>
> +R:	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained

Seems like it is "Supported" rather than "Maintained" ?

        S: *Status*, one of the following:
           Supported:   Someone is actually paid to look after this.
           Maintained:  Someone actually looks after it.
           Odd Fixes:   It has a maintainer but they don't have time to do
                        much other than throw the odd patch in. See below..
           Orphan:      No current maintainer [but maybe you could take the
                        role as you write your new code].
           Obsolete:    Old code. Something tagged obsolete generally means
                        it has been replaced by a better system and you
                        should be using that.

> +F:	Documentation/devicetree/bindings/arm/bst.yaml
> +F:	Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> +F:	arch/arm64/boot/dts/bst/
> +F:	drivers/mmc/host/sdhci-of-bst.c
> +
>  ARM/CALXEDA HIGHBANK ARCHITECTURE
>  M:	Andre Przywara <andre.przywara@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 

