Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898542D24B4;
	Mon, 18 Aug 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541028; cv=fail; b=R41InhtUaN6Oc49eQimPEgfSrInJO9fLuXpcuRh5zy0jpK0MLU280i558vG4sDjFEuXkDP1LMl0iw7cZ6p6hnGfb/a0b2i3F/4szYq+8AK9GKEPrWcl0KmaumptT9kqhdH+wwg8IdUljTOYpdlv4g9nAa3L3PtpYuMQoQeNhSE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541028; c=relaxed/simple;
	bh=7DJNbr7b5HZQvT05E3xP1LHmhQ4WDoOA2SPDJU/FYOM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULavbwC3AUb9p3gCYN42ompfdGnMjtnP1vU6z/USK+R56eOzAKClMBNcsUAAY5BikJDHL9ZVzMy5GylYX4PydDOM2K94c080QV0jKEpZCb41KlYuTQdBUJ+h48kEpcKLE++rMy/01fKsFLqdGb3QLOKVzyU7XZkyKdd0LHGuocQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UN0QthcI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UN0QthcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755541025; x=1787077025;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7DJNbr7b5HZQvT05E3xP1LHmhQ4WDoOA2SPDJU/FYOM=;
  b=UN0QthcIjYnP9ZWAt8bZSkFFtSoBZ2+4ERT2/3JNlJ9ci9n1bNsM++mY
   3mDEvBAzyMecmzcyBKZoLBl5Yv60WbmZF/EqZBO808naNPrMkyA5wqoh9
   ee13spfcn0Uf0JkfNeIOkvGwxX0saGL3SK249eAsueIaHJBtaA5w5NwSS
   Iuuh+etf9XngIVN24aLQSj//5+V2vl+71zic/1QNRDykjuS/Pm6FmmZA5
   o8yTSb1a/PQDw4WIEIRpjl5XbFF6XuXnyho0QsL8iNgC4DPiGSfb4SXcA
   X9F0Zmk06nACueF0xfHBCleVQn/IvxdjKVzmUxgBQpspsSTqAMq/uPilN
   w==;
X-CSE-ConnectionGUID: YRbLAzcHRQ+W6mCh78bv9Q==
X-CSE-MsgGUID: CdoFUHK9QZSgwP6OPLNVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57702087"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57702087"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 11:17:03 -0700
X-CSE-ConnectionGUID: p9dp6XOGRv+NQrXljeDU3Q==
X-CSE-MsgGUID: Bh2PZbfyT1+DOGN1i6gTvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168032939"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 11:17:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 11:17:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 11:17:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.83) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 11:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3kD3h8bpP4jJDrLxLVKUSp/S+mqCTEyiuKsJ3Wna9BimyG2ceaa1M0P+P8DtAFju1yn1GNvrHtOVQpZJxBqimRcmPU/mkfVjfheDhIU7LYj/HTTeWxwSvP4KB6SbI+B9ANyA19equUJPWM4Vrp4J1zBSck42Thlx9mcvY7qJkGsB2llP42UHXALVETA5V1j/LTc7mlaWJPOTCWkHXhyJgWmQk89mt4Bk0y7rVF+Ne0vl+3996gVCduGHKpZaBH2+ZjeNuII3esVC61pf+gu1T4Uy+Q9GKiUW4U1SfVw1oBIWE9ewzDzkrnwpc8DI6ZLq5Gx/koGkxaSOq1ClGo5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rR1CSGfbQ1pxGfxDnu5M/5or0lNYxfw+zya2ORbrBo=;
 b=RXBujd52yg900RuobehVv+OC7QnX+I4INrB5iRr88uzPBKs8nOleSxq1sODj2jnR7sNX4CmYpY1hhXR3YHRfZSY+fU/EAmAooNSeJU7futkuXZka6XJoOAjgfTPZRJNWM9UaiVTP5VK8ettrpWvgbvvSJ2laNmABuN5BcnZFIiSRvz0kGrAXLgjQ0AQ/37ZSF4dnQZaTz0bvnsnGKG2V6uCIxliBXGiaRe3Tq3eahmegUwTHlM/VkQFqnz7wJSSvKPnR9XhZg+SBRX61obdTghvqFX2PHdLj30tE9jdTrzfUAInM+aiYComZbZ+5yncNb8y8McZbmtoN23/KK6fgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS7PR11MB7857.namprd11.prod.outlook.com (2603:10b6:8:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:17:00 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:17:00 +0000
Message-ID: <2b23bcb9-abc7-4667-b939-a19ecae935a2@intel.com>
Date: Mon, 18 Aug 2025 21:16:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] mmc: sdhci: add Black Sesame Technologies BST
 C1200 controller driver
To: Albert Yang <yangzh0906@thundersoft.com>, <krzk@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<ulf.hansson@linaro.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<arnd@arndb.de>, <robin.murphy@arm.com>, <ding.wang@bst.ai>,
	<gordon.ge@bst.ai>
CC: <bst-upstream@bstai.top>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<soc@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
 <20250812123110.2090460-6-yangzh0906@thundersoft.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250812123110.2090460-6-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS7PR11MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: e17f6eec-c9cd-4c6c-aed9-08ddde836ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjhwaXhkTXBHb1ZYb1ZqNHFaZzJINUVaMlFiT1FXRmtsSko3OGRhaGhBSm4w?=
 =?utf-8?B?WUN2ZEJsY1RYY3Y1S1ZQR3J0WmdDU0RPdlVJR2NFME9PbmpjbXdKbFdobU55?=
 =?utf-8?B?T2hhaVNOSTU5aFZNQjFSMXZKZDNURzNvQkpHeGEvdjB5T3B6eTIyTmVscXVO?=
 =?utf-8?B?WlJpZVNpYlJIZm1tdW5KYTZSNjRBM0M1NUhtZDdCa2J3dmJBd25HOG9SQjV6?=
 =?utf-8?B?NWhWYjgxNTl4Wk8rbUtZRERZR1FJV0ZtNEc2RUFyQnZ3YU5MQVE4dURaMFcz?=
 =?utf-8?B?a3JVd2VEb0NoSitvOVBXcGtJZjVmUWtKVEJ1OWVjNnVMT2ZCL1RuUnJUYlo2?=
 =?utf-8?B?c3Q1YjRxVHNmK0w1K0dGc3lkYVUzajU1ZHcwSE84SStEaUJobGFGRzNiRGE4?=
 =?utf-8?B?UzAyOEdIcUFURUhIMmI4RFZEcjFMTWZ2djNibEZ3dEFiTEI4QVFwWjM3QXBX?=
 =?utf-8?B?YVk4Z0xoVml3OGE5czM3dmpVZUVvYyt1WWlGcXVzOGxsV0hsZzU4TzR5Z2Fy?=
 =?utf-8?B?MkNEczYxekxKbWx1OVJuSDNUMjVUYlh6aThmK2F6SWZ5czZBNlFGaDZwMmRh?=
 =?utf-8?B?ZFhiWElWWTJvQ2Uzd0JCMXE3WFlrekhPU080T0Fia3BWU3hvNCswTlNXZWtH?=
 =?utf-8?B?anluTGJNcEpUUlRCQmtCaFBvRzdtWmx5eWJ3N2lPMTNHb0JZbGtVTjdxMXZO?=
 =?utf-8?B?bjlERXhLUE1BclFvWEtHUUhPT1hVTnBvNklBZmFEd1FYRFNLdVF5S1hBSUdn?=
 =?utf-8?B?UUpjeVowQTNlTk9Qb0FxaXY4aC84WGcrc1ZTVk5pM1BFTlBRSEhheXBlcVNt?=
 =?utf-8?B?WHczV29YL2NuREVWTWFJYURHQkJ0bmcrWkY0QXFLTTFmZ0ZkMlVsOVQ3U013?=
 =?utf-8?B?Y3FXenRyM0xuOWd5dTFqTkFMamF2MDQ4VFRVSkRHU3FLNWtINk5GaUFjRDl0?=
 =?utf-8?B?eE0rOVh6TUxkZ010Qk9Jb294cXNld2JBSlByWXcxazlLSHZvMjNNMDV3S1dM?=
 =?utf-8?B?WFc2RlUrbUJJeFk5MXI0MklJNU10bXlDQ3c5TXlCMHc1ZGZET1dFa3ZIcWdS?=
 =?utf-8?B?Z2p4MXFiTWtiZXZpSDJQMElMc3BxT01TbWc5cEttVU1PNFBBZ1IwbmZaTWZX?=
 =?utf-8?B?ZHkzcjVOY0dJTExNc2RPM3F0MlZSWXh2bk4reVFPbDB0aVUwWWFRa1lXVktF?=
 =?utf-8?B?RjVFWkxyREhYTUxmN1RiRWFHOGJlQ2hWQzJlQ3NTbXZ2T0d5alNidTF2Q1hu?=
 =?utf-8?B?eStNUWlZV3p1Qk1qeCtBK1kzZ3dtcjh0bzcyTXVlK3ozVHR0b2djUDVOaEcw?=
 =?utf-8?B?TXUzdko5T01mcjAxbVhEZUVyd0svTlZqaDYxQzZYcHhXMXVhRExzMk1DTDBt?=
 =?utf-8?B?WHBvTWJGZldwU2R6UlZ5SEhoYjJjMWVTbGRZbGhuTTU5SHNwcTVFZDV4REty?=
 =?utf-8?B?UnNpSnIyb3NsL2d3R0gxMmtON2Q5bXEwTTdEa0d2dmUwVS9WZ05QYXV2bVhW?=
 =?utf-8?B?OHdOWmZqbTBQU3FKZXhEdGQ2dWFPblpKazV5eXpPb05CeUpCZjByd3I0SDNF?=
 =?utf-8?B?elhITTdYK3ZuSnNORERWOXB0WEgweFo1WnNtZkVOT3hhMS9MbnFFMXUrdUp2?=
 =?utf-8?B?cVdsTWlRMlFFTFJlVk5QL3hleDJjbU1tVGNCVUl6elN2L2lSSW9rNk52a2xT?=
 =?utf-8?B?Wkhjek5kRWNBVncveUZCREFaS25rN0g1K2lPRFpsNWlNcE90ZXFTOHhHS3du?=
 =?utf-8?B?SUF3U05mK01nK0s5VEpzbzczYnFNZjQvM01WSjZvOEdXcHNaYXhVR0wvWUpI?=
 =?utf-8?B?MHFybTBEbm9BQzBPT0RJMnp2eW9PT3NYR0NkMkRJZ2ZiMm1oMml1QWwrVGwy?=
 =?utf-8?B?a1NDV0dmVS9MQS9pTE52QnFybUFTcnVEa3pjMEZ2RGJ5MDdnS2pxc1RRRU9G?=
 =?utf-8?B?a0RueTVKQmRWS203YmloaGcrWXFpNmJxazNNdUR6Qjd6RXRIc1IxRTM1R3Mw?=
 =?utf-8?B?L0dIdFFRNnNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RtVGxydERVODV0RDAyN0g3eFVkQVg5eFJ0YWJHTU1Zck40Um9LNUlPK3Iw?=
 =?utf-8?B?dVJDM3cyQ1dDYVNRY1ErN2lvbEFZczRTWGFFeENMYVJYV3hObTc2UUZhTE5s?=
 =?utf-8?B?N1FKVTNYRVdGeThRYkRGdHdmSFVmY1J1Y1A0cGRpQ214T0JtWXlJRWFtN3B2?=
 =?utf-8?B?ZWZJME9TeXVWTlhPOFBaZTdrZnEvM3l2ak9Hck13V1NsMUhkdVBBTXVEMUFE?=
 =?utf-8?B?S3VETmV4RWpyTnNaNktoOUVCSithcXpFV0V5emxJNFdULy9kMXh4cnNlTXZi?=
 =?utf-8?B?cVRzNXJORXRJelppLzJSVzZmMHlmWEtISkE0Zzg0VjhKYVMrTEVsM0RsMU1N?=
 =?utf-8?B?YTluNGx2N1l0dmgrZnZvOTNvRWFKTkVNWGpQL3NjYi8wSENsd0c1clVnSU9E?=
 =?utf-8?B?eHplQWRzZTVCUXJXZGloY0xRT0ZmRG9VTng2bHJHZVh3NWpoMkpyb29aRjlF?=
 =?utf-8?B?R1psZWgxbi94SlVkT1Q1WnRsOW9wbTJBUlNGKzVuS0NCK2FPZ2p2aDBDbFRV?=
 =?utf-8?B?OXNZVkk2dnUvMWtLL1dvclBmaGlrTTRQTEFXbE1GdU5EQlhnd3R3OHZ3a3Uz?=
 =?utf-8?B?TFJPNzhNY0llSlFIWUVKQ1VhZHQ0U0xzS0podEdYdHdFOEFWcS9HZ1YzU1hN?=
 =?utf-8?B?SlBiaUdGSVUzZ0FFVmYzNnAzcnhZY2dIaVQ0SGJ2dXRNSktDSUtiZkw5SWpl?=
 =?utf-8?B?NFNDR0FiWElaWWR1bTNmamFJRDRCMWsrSGhQaFRoMGgvSmQzekhyOExKbUZ3?=
 =?utf-8?B?VGw4TUdOQ1p0dmw3QmRoNExZZlU1cC8rcVY2U09HeVQ0WnZUc3VEZ1FOekpE?=
 =?utf-8?B?dkZ5TERObHZaNTUwWVN5YlhRUWQxTlRQZFlRdUE5QmZLRUFxWkdEdE41SFZj?=
 =?utf-8?B?NFltT1pSTU02Q0dCS1dMWlluakxGTEFZaG5mdmdtY0wvQlJDWEN0WjRpTGU3?=
 =?utf-8?B?V0lLZ1hzQVRxRjRjeUdHK0JwWitLT0s0Ykc4c3VQbXhoaGM0b1d5d3RZZ3Nl?=
 =?utf-8?B?dkg4MmExMnVoVGlrUVJKbkFZd0wrUkVFZXZEbko5N2V3bkJIaHU3blk5cGlr?=
 =?utf-8?B?SVVZY1cvcUpBemNaYUxVejRxcWZDVUlTRWVYOHRQSEI4b0pqc1BsbFZ6MWk2?=
 =?utf-8?B?VWJ3YUhxWHRiazljQVJ5eStmT3NQaFZvZ0E2YWhQTysxM2xRdWdBL3Z6Vmlp?=
 =?utf-8?B?eFhxY210TXVqR05aSjNNcHRwR0FyMkhhWGNUUjZNZVIrZGs4S3JUWUgrd1li?=
 =?utf-8?B?cFQraEo4S1JqVnpRTHVveXZHQ0ZRd0daSE40L2pXaWxFWXJ2bGZNNll1RGF6?=
 =?utf-8?B?RGt6ZnJxNnA0Mm0wOXp2OVBKcDZTZ0oydUZsSDlKZkQ0c1BvTlVoVjNkVTg0?=
 =?utf-8?B?MjVRRlhQMHlQU3g5TU9EMXVHT0t5dlRsSHcrb0cvdm1TK0ZvWkF0b3RneHdY?=
 =?utf-8?B?Q1VSdVZhNC9QbXZ6OEh5d0oyQ1A0RGwwTTNocmVMMW9idXRlMHhFdkhWL1BK?=
 =?utf-8?B?Tlo4aVhuRkFyejRjNUFIeXNIaEozeVJjZDM2S0FQYzdUdlhyUFFLYmY2UHU0?=
 =?utf-8?B?MmgySXJDQ2FBTUFrb3AwZVY5OXorMkkrejVWQ1F0aHY2QzVTcW81MFNrWUg2?=
 =?utf-8?B?WDM1MWZOR3BNekNkVjh6MEprcGs1WktrL0Nqc1gzbjVDVjdmQlJhNHpJTGc4?=
 =?utf-8?B?S1g0dHpFaFRWZ0UvV2c0bi8rL2czN3Q2OXkzaS9nc2oxZmFLY1N0RERNY21U?=
 =?utf-8?B?dTRhKzVheXBjbDVHblVaQXYvRXdEdVliSStyS1hVSTJvblJqWmluRFo3Y3l6?=
 =?utf-8?B?V1VMdFlPK01tVDRCMG16Q21SeHBhQU9XTTFuTWFTdjJHU1p3R0VZakxQaE1N?=
 =?utf-8?B?VGJVWkxadTFZQ0h0bDJ3ODI0Wk81OTVSVVRWZVNGUnNIRkJLeTRnMTUxZDBO?=
 =?utf-8?B?d0U4YTRXbWFLeDQ4bitodi9aMmtjcmxhRE1sNzdtWkVCZVFkQms2NktKQlVi?=
 =?utf-8?B?d1pwakc5cGNEOTM5bUlHYnN4M1A4ODNPTWxqMlNoN2FtREpoOEpVMks5OCt2?=
 =?utf-8?B?bzJRdUtmZ1FueWJLL1daenFnS05MWnRqeHVGQXU4L1p5WHRrV2pXczFLVUtL?=
 =?utf-8?B?NVF2aWU0djZKWXNSRVhMN3l1SGEvbE9rVFhFUlovWmpCRjkrbDFaUXlrNTF0?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e17f6eec-c9cd-4c6c-aed9-08ddde836ca3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:17:00.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeCLzyB7QkVbIvaU4rchfh749zGXTaiYl6lP1NyxRm4ogxWaCnThKkSNxPGVc8mi33jQot3YFGLQSpIa5/EYGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7857
X-OriginatorOrg: intel.com

On 12/08/2025 15:31, Albert Yang wrote:
> Add SDHCI controller driver for Black Sesame Technologies C1200 SoC.
> 
> This driver supports the DWCMSHC SDHCI controller with BST-specific
> enhancements including:
> - Custom clock management and tuning
> - Power management support
> - BST-specific register configurations
> - Support for eMMC and SD card interfaces
> - Hardware limitation workaround for 32-bit DMA addressing
> 
> The driver addresses specific hardware constraints where:
> - System memory uses 64-bit bus, eMMC controller uses 32-bit bus
> - eMMC controller cannot access memory through SMMU due to hardware bug
> - All system DRAM is configured outside 4GB boundary (ZONE_DMA32)
> - Uses SRAM-based bounce buffer within 32-bit address space
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
> Change for v3:
> Code improvements based on review feedback:
> - Simplified dwcmshc_priv structure by removing unused fields
> - Improved helper functions with better encapsulation
> - Used devm_platform_ioremap_resource() for resource management
> - Updated Kconfig description and alphabetical ordering
> - clarify documentation on hardware limitations and bounce buffer
> approach
> - remove duplicate sdhci_writew SDHCI_CLOCK_CONTROL
> 
> Changes for v2:
> 1.  Dependency Simplification :
>    - Removed COMMON_CLK dependency from Kconfig (MMC_SDHCI_BST)
>    - Add ARCH_BST || COMPILE_TEST dependency from Kconfig (MMC_SDHCI_BST)
> 
> 2.  Resource Management Improvements :
>    - Replaced temporary ioremap with persistent mapping
>      * Mapped CRM registers once during probe instead of per-access
>      * Added proper cleanup in remove callback
>    - Refactored bounce buffer allocation:
>      * Simplified error handling and memory management
>      * Removed unnecessary DMA configuration layers
> 
> 3.  Code Cleanup & Optimization :
>    - Pruned unused headers and legacy vendor debug code
>    - Removed deprecated sdhci_bst_print_vendor() export
>    - Converted internal functions to static scope
>    - Standardized naming conventions:
>      * Renamed DRIVER_NAME to match kernel standards
>      * Changed default_max_freq to DEFAULT_MAX_FREQ
>    - Optimized clock configuration routines
> 
> 4.  Hardware Integration Fixes :
>    - Fixed register access macros for EMMC_CTRL
>      * Added proper offset calculation via SDHCI_VENDOR_PTR_R
>    - Corrected device tree compatibility string to:
>      "bst,c1200-dwcmshc-sdhci"
> 
> 5.  Error Handling Enhancements :
>    - Added robust ioremap error checking
>    - Improved bounce buffer allocation failure handling
>    - Streamlined probe/remove flow
> 
> 6.  Maintainability :
>    - Updated MODULE_DESCRIPTION and AUTHOR fields
>    - Added explanatory comments for hardware limitations
>    - Removed redundant multi-host setup infrastructure
> 
> 7. fix build warnings from lkp
>   | Reported-by: kernel test robot <lkp@intel.com>
>   | Closes:
>   https://lore.kernel.org/oe-kbuild-all/202505290615.GZzN5rNL-lkp@intel.com/
> ---
>  drivers/mmc/host/Kconfig              |  14 +
>  drivers/mmc/host/Makefile             |   1 +
>  drivers/mmc/host/sdhci-of-bst-c1200.c | 510 ++++++++++++++++++++++++++
>  3 files changed, 525 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-bst-c1200.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index c3f0f41a426d..fb057c46949b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -429,6 +429,20 @@ config MMC_SDHCI_BCM_KONA
>  
>  	  If you have a controller with this interface, say Y or M here.
>  
> +config MMC_SDHCI_BST
> +	tristate "SDHCI support for Black Sesame Technologies BST C1200 controller"
> +	depends on ARCH_BST || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  for Black Sesame Technologies BST C1200 SoC. The controller is
> +	  based on Synopsys DesignWare Cores Mobile Storage Controller but
> +	  requires platform-specific workarounds for hardware limitations.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_F_SDH30
>  	tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 75bafc7b162b..bb5df05c3174 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
> +obj-$(CONFIG_MMC_SDHCI_BST)	        += sdhci-of-bst-c1200.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
> diff --git a/drivers/mmc/host/sdhci-of-bst-c1200.c b/drivers/mmc/host/sdhci-of-bst-c1200.c
> new file mode 100644
> index 000000000000..6d2ba4232306
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-bst-c1200.c

Unless you foresee more BST sdhci drivers, maybe sdhci-of-bst.c is an
easier file name to deal with.

> @@ -0,0 +1,510 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Black Sesame Technologies SDHCI driver
> + *
> + * Copyright (C) 2024 Black Sesame Technologies. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +struct dwcmshc_priv {

Name sdhci_bst_priv perhaps, see comment further below about
names.

> +	void __iomem *crm_reg_base;
> +};
> +
> +#define SDHCI_CLOCK_PLL_EN		0x0008
> +#define SDHCI_TUNING_COUNT		0x20
> +#define SDHCI_VENDOR_PTR_R		0xE8
> +#define MBIU_CTRL			0x510
> +#define BURST_INCR16_EN			BIT(3)
> +#define BURST_INCR8_EN			BIT(2)
> +#define BURST_INCR4_EN			BIT(1)
> +#define BURST_EN			(BURST_INCR16_EN | BURST_INCR8_EN | BURST_INCR4_EN)
> +
> +/* Synopsys vendor specific registers */
> +#define SDHC_EMMC_CTRL_R_OFFSET		0x2C
> +
> +#define SDEMMC_CRM_BCLK_DIV_CTRL	0x08
> +#define SDEMMC_CRM_RX_CLK_CTRL		0x14
> +#define SDEMMC_CRM_TIMER_DIV_CTRL	0x0C
> +#define SDEMMC_CRM_VOL_CTRL			0x1C
> +#define REG_WR_PROTECT			0x88
> +#define REG_WR_PROTECT_KEY		0x1234abcd
> +#define DELAY_CHAIN_SEL			0x94
> +#define BST_VOL_STABLE_ON		BIT(7)
> +#define DEFAULT_MAX_FREQ		200000UL
> +
> +static u32 bst_crm_read(struct sdhci_pltfm_host *pltfm_host, u32 offset)
> +{
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	return ioread32(priv->crm_reg_base + offset);

Are ioread32() / iowrite32() actually needed instead of readl() / writel()?

> +}
> +
> +static void bst_crm_write(struct sdhci_pltfm_host *pltfm_host, u32 offset, u32 value)
> +{
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	iowrite32(value, priv->crm_reg_base + offset);
> +}
> +
> +static unsigned int bst_get_max_clock(struct sdhci_host *host)
> +{
> +	return host->mmc->f_max;
> +}
> +
> +static unsigned int bst_get_min_clock(struct sdhci_host *host)
> +{
> +	return host->mmc->f_min;

But what sets f_min?  Should make sure it has a value.

> +}
> +
> +struct rx_ctrl {

Looks like the intention is for this to be a union not a struct

> +	struct {
> +		u32 rx_revert:1;
> +		u32 rx_clk_sel_sec:1;
> +		u32 rx_clk_div:4;
> +		u32 rx_clk_phase_inner:2;
> +		u32 rx_clk_sel_first:1;
> +		u32 rx_clk_phase_out:2;
> +		u32 rx_clk_en:1;
> +		u32 res0:20;
> +	} bit;

It isn't necessary for the struct to have a name, so like:

union rx_ctrl {
	struct {
		u32 rx_revert:1,
		    rx_clk_sel_sec:1,
		    rx_clk_div:4,
		    rx_clk_phase_inner:2,
		    rx_clk_sel_first:1,
		    rx_clk_phase_out:2,
		    rx_clk_en:1,
		    res0:20;
	};
	u32 reg;
};

> +	u32 reg;
> +};
> +
> +struct sdmmc_iocfg {

Not used

> +	struct {
> +		u32 res0:16;
> +		u32 SC_SDMMC0_PVDD18POCSD0:2;
> +		u32 SC_SDMMC0_PVDD18POCSD1:2;
> +		u32 SC_SDMMC0_PVDD18POCSD2:2;
> +		u32 SC_SDMMC1_PVDD18POCSD0:2;
> +		u32 SC_SDMMC1_PVDD18POCSD1:2;
> +		u32 SC_SDMMC1_PVDD18POCSD2:2;
> +		u32 res1:4;
> +	} bit;
> +	u32 reg;
> +};
> +
> +static void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)

Function naming is a bit inconsistent.  Please try to have
a common prefix such as sdhci_bst, so for example

	sdhci_enable_bst_clk -> sdhci_bst_enable_clk

> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	unsigned int div;
> +	u32 val;
> +	struct rx_ctrl rx_reg;
> +
> +	pltfm_host = sdhci_priv(host);
> +	if (clk == 0) {
> +		div = clk;
> +	} else if (clk > DEFAULT_MAX_FREQ) {
> +		div = clk / 1000;
> +		div = DEFAULT_MAX_FREQ / div;
> +	} else if (clk < 1500) {
> +		div = clk;
> +	} else {
> +		div = DEFAULT_MAX_FREQ * 100;
> +		div = div / clk;
> +		div /= 100;
> +	}
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk &= ~SDHCI_CLOCK_PLL_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val &= ~BIT(8);
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val &= ~0xff;
> +	val |= 0x20;

BIT() and other special values should be #define'd
here and elsewhere

> +	bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val |= BIT(8);
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +	val &= ~BIT(11);
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +	rx_reg.reg = bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +
> +	rx_reg.bit.rx_revert = 0;
> +	rx_reg.bit.rx_clk_sel_sec = 1;
> +	rx_reg.bit.rx_clk_div = 4;
> +	rx_reg.bit.rx_clk_phase_inner = 2;
> +	rx_reg.bit.rx_clk_sel_first = 0;
> +	rx_reg.bit.rx_clk_phase_out = 2;
> +
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, rx_reg.reg);
> +
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +	val |= BIT(11);
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +	/* Disable clock first */
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val &= ~BIT(10);
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* Setup clock divider */
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val &= ~GENMASK(9, 0);
> +	val |= div;
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* Enable clock */
> +	val = bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val |= BIT(10);
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	sdhci_writew(host, (div & 0xff) << 8, SDHCI_CLOCK_CONTROL);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_PLL_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)

sdhci_bst_set_clock

> +{
> +	if (clock == 0)
> +		return;

The clock should be tuned off if it is 0.  If there is a
reason not to, then add a comment explaining.

> +	sdhci_enable_bst_clk(host, clock);
> +}
> +
> +/**
> + * sdhci_bst_reset - Reset the SDHCI host controller
> + * @host: SDHCI host controller
> + * @mask: Reset mask
> + *
> + * Performs a reset of the SDHCI host controller with special handling for eMMC.
> + */
> +static void sdhci_bst_reset(struct sdhci_host *host, u8 mask)
> +{
> +	u16 vendor_ptr, emmc_ctrl_reg;
> +
> +	if (host->mmc->caps2 & MMC_CAP2_NO_SD) {
> +		vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
> +		emmc_ctrl_reg = vendor_ptr + SDHC_EMMC_CTRL_R_OFFSET;
> +
> +		sdhci_writew(host,
> +			     sdhci_readw(host, emmc_ctrl_reg) & (~BIT(2)),
> +			     emmc_ctrl_reg);

Should #define BIT(2).  Also read, update, write seems
more readable e.g.

		reg = sdhci_readw(host, emmc_ctrl_reg);
		reg &= ~WHATEVER_IS_BIT_2;
		sdhci_writew(host, reg, emmc_ctrl_reg);

> +		sdhci_reset(host, mask);
> +		usleep_range(10, 20);
> +		sdhci_writew(host,
> +			     sdhci_readw(host, emmc_ctrl_reg) | BIT(2),
> +			     emmc_ctrl_reg);
> +	} else {
> +		sdhci_reset(host, mask);
> +	}
> +}
> +
> +/**
> + * sdhci_bst_timeout - Set timeout value for commands
> + * @host: SDHCI host controller
> + * @cmd: MMC command
> + *
> + * Sets the timeout control register to maximum value (0xE).
> + */
> +static void sdhci_bst_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
> +}
> +
> +/**
> + * sdhci_bst_set_power - Set power mode and voltage
> + * @host: SDHCI host controller
> + * @mode: Power mode to set
> + * @vdd: Voltage to set
> + *
> + * Sets power mode and voltage, also configures MBIU control register.
> + */
> +static void sdhci_bst_set_power(struct sdhci_host *host, unsigned char mode,
> +				unsigned short vdd)
> +{
> +	sdhci_set_power(host, mode, vdd);
> +	sdhci_writeb(host, 0xF, SDHCI_POWER_CONTROL);
> +	sdhci_writew(host,
> +		     (sdhci_readw(host, MBIU_CTRL) & (~0xf)) | BURST_EN,
> +		     MBIU_CTRL);

Doesn't look like it caters for mode == MMC_POWER_OFF

Also prefer read, update, write e.g.

	reg = sdhci_readw(host, MBIU_CTRL)
	reg &= ~BURST_MASK;
	reg |= BURST_EN;
	sdhci_writew(host, reg, MBIU_CTRL);

> +}
> +
> +/**
> + * bst_sdhci_execute_tuning - Execute tuning procedure
> + * @host: SDHCI host controller
> + * @opcode: Opcode to use for tuning
> + *
> + * Performs tuning procedure by trying different values and selecting the best one.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int bst_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)

sdhci_bst_execute_tuning

> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	unsigned int clk = 0, timeout;
> +	int ret = 0, error;
> +	int start0 = -1, end0 = -1, best = 0;
> +	int start1 = -1, end1 = -1, flag = 0;
> +	int i;
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	for (i = 0; i < SDHCI_TUNING_COUNT; i++) {
> +		/* Protected write */
> +		bst_crm_write(pltfm_host, REG_WR_PROTECT, REG_WR_PROTECT_KEY);
> +		/* Write tuning value */
> +		bst_crm_write(pltfm_host, DELAY_CHAIN_SEL, (1ul << i) - 1);
> +
> +		timeout = 20;
> +		while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
> +			SDHCI_CLOCK_INT_STABLE)) {
> +			if (timeout == 0) {
> +				dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> +				return -EBUSY;
> +			}
> +			timeout--;
> +			usleep_range(1000, 1100);
> +		}

As Ulf already mentioned, read_poll_timeout() can be used e.g.

	if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
			      1000, 1100, false, host, SDHCI_CLOCK_CONTROL)) {
		dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
		return -EBUSY;
	}

> +
> +		ret = mmc_send_tuning(host->mmc, opcode, &error);
> +		if (ret != 0) {
> +			flag = 1;
> +		} else {
> +			if (flag == 0) {
> +				if (start0 == -1)
> +					start0 = i;
> +				end0 = i;
> +			} else {
> +				if (start1 == -1)
> +					start1 = i;
> +				end1 = i;
> +			}
> +		}
> +	}
> +
> +	/* Calculate best tuning value */
> +	if (end0 - start0 >= end1 - start1)
> +		best = ((end0 - start0) >> 1) + start0;
> +	else
> +		best = ((end1 - start1) >> 1) + start1;
> +
> +	if (best < 0)
> +		best = 0;
> +
> +	bst_crm_write(pltfm_host, DELAY_CHAIN_SEL, (1ul << best) - 1);
> +	timeout = 20;
> +
> +	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
> +		SDHCI_CLOCK_INT_STABLE)) {
> +		if (timeout == 0) {
> +			dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> +			return -EBUSY;
> +		}
> +		timeout--;
> +		usleep_range(1000, 1100);
> +	}

Same code as above, maybe make it a separate function.

> +
> +	return 0;
> +}
> +
> +/**
> + * sdhci_bst_voltage_switch - Perform voltage switch
> + * @host: SDHCI host controller
> + *
> + * Enables voltage stable power.
> + */
> +static void sdhci_bst_voltage_switch(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	/* vol stable power on */
> +	bst_crm_write(pltfm_host, SDEMMC_CRM_VOL_CTRL, BST_VOL_STABLE_ON);
> +}
> +
> +static const struct sdhci_ops sdhci_dwcmshc_ops = {

sdhci_bst_ops

> +	.set_clock		= sdhci_set_bst_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.get_min_clock		= bst_get_min_clock,
> +	.get_max_clock		= bst_get_max_clock,
> +	.reset			= sdhci_bst_reset,
> +	.set_power		= sdhci_bst_set_power,
> +	.set_timeout		= sdhci_bst_timeout,
> +	.platform_execute_tuning = bst_sdhci_execute_tuning,
> +	.voltage_switch		= sdhci_bst_voltage_switch,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {

sdhci_bst_pdata

> +	.ops = &sdhci_dwcmshc_ops,
> +	.quirks = SDHCI_QUIRK_DELAY_AFTER_POWER |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> +	.quirks2 = SDHCI_QUIRK2_BROKEN_DDR50 |
> +		   SDHCI_QUIRK2_TUNING_WORK_AROUND |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +
> +static int bst_sdhci_reallocate_bounce_buffer(struct sdhci_host *host)

sdhci_bst_reallocate_bounce_buffer

> +{
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned int max_blocks;
> +	unsigned int bounce_size;
> +	int ret;
> +
> +	/*
> +	 * Cap the bounce buffer at 32KB. Using a bigger bounce buffer
> +	 * has diminishing returns, this is probably because SD/MMC
> +	 * cards are usually optimized to handle this size of requests.
> +	 */

That comment is copied from sdhci.c and makes less sense here.
Presumably the size is fixed by hardware.  Probably better
to leave out the comment.

> +	bounce_size = SZ_32K;
> +	/*
> +	 * Adjust downwards to maximum request size if this is less
> +	 * than our segment size, else hammer down the maximum
> +	 * request size to the maximum buffer size.
> +	 */
> +	if (mmc->max_req_size < bounce_size)
> +		bounce_size = mmc->max_req_size;

Similarly, 32K is your max request size, so there is no need
of that logic or comment.

> +	max_blocks = bounce_size / 512;
> +
> +	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
> +	if (ret) {
> +		dev_err(mmc_dev(mmc), "Failed to initialize reserved memory\n");
> +		return ret;
> +	}
> +
> +	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
> +						 &host->bounce_addr, GFP_KERNEL);
> +	if (!host->bounce_buffer)
> +		return -ENOMEM;
> +
> +	host->bounce_buffer_size = bounce_size;
> +
> +	/* Lie about this since we're bouncing */
> +	mmc->max_segs = max_blocks;
> +	mmc->max_seg_size = bounce_size;
> +	mmc->max_req_size = bounce_size;

If you make the change I suggest below to sdhci.c then
the above 4 lines won't be needed.

> +
> +	return 0;
> +}
> +
> +static int dwcmshc_probe(struct platform_device *pdev)

sdhci_bst_probe

> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct dwcmshc_priv *priv;
> +	int err;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> +				sizeof(struct dwcmshc_priv));

It is ok to use up to 100 columns, so line wrapping is not needed
here.

> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		goto err;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	/* Get CRM registers from the second reg entry */
> +	priv->crm_reg_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(priv->crm_reg_base)) {
> +		err = PTR_ERR(priv->crm_reg_base);
> +		goto err;
> +	}
> +
> +	err = sdhci_add_host(host);
> +	if (err)
> +		goto err;
> +
> +	/*
> +	 * Silicon constraints for BST C1200:
> +	 * - System RAM base is 0x800000000 (above 32-bit addressable range)
> +	 * - The eMMC controller DMA engine is limited to 32-bit addressing
> +	 * - SMMU cannot be used on this path due to hardware design flaws
> +	 * - These are fixed in silicon and cannot be changed in software
> +	 *
> +	 * Bus/controller mapping:
> +	 * - No registers are available to reprogram the address mapping
> +	 * - The 32-bit DMA limit is a hard constraint of the controller IP
> +	 *
> +	 * Given these constraints, an SRAM-based bounce buffer in the 32-bit
> +	 * address space is required to enable eMMC DMA on this platform.
> +	 */
> +	err = bst_sdhci_reallocate_bounce_buffer(host);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to allocate bounce buffer: %d\n", err);
> +		goto err_remove_host;
> +	}

This would normally need to be done after sdhci_setup_host() and
before __sdhci_add_host() because adding the host starts it.

However, I would prefer to alter sdhci.c to allow it to be done
before sdhci_add_host().

Please make a separate patch for the change below, and then do
the bounce buffer allocation before calling sdhci_add_host.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a17821efa5c..36d3a90cfe47 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4193,6 +4193,13 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	unsigned int bounce_size;
 	int ret;
 
+	/* Drivers may have already allocated the buffer */
+	if (host->bounce_buffer) {
+		bounce_size = host->bounce_buffer_size;
+		max_blocks = bounce_size / 512;
+		goto out;
+	}
+
 	/*
 	 * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
 	 * has diminishing returns, this is probably because SD/MMC
@@ -4240,7 +4247,7 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	}
 
 	host->bounce_buffer_size = bounce_size;
-
+out:
 	/* Lie about this since we're bouncing */
 	mmc->max_segs = max_blocks;
 	mmc->max_seg_size = bounce_size;


> +
> +	return 0;
> +
> +err_remove_host:
> +	sdhci_remove_host(host, 1);
> +err:
> +	sdhci_pltfm_free(pdev);

There is no sdhci_pltfm_free() anymore.

> +	return err;
> +}
> +
> +static void dwcmshc_remove(struct platform_device *pdev)

sdhci_bst_remove

> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	/* Free bounce buffer if allocated */
> +	if (host->bounce_buffer) {
> +		dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
> +				  host->bounce_buffer, host->bounce_addr);
> +		host->bounce_buffer = NULL;
> +	}
> +
> +	/* Release reserved memory */
> +	of_reserved_mem_device_release(mmc_dev(host->mmc));
> +
> +	sdhci_remove_host(host, 0);

Because sdhci_pltfm_init() was used, sdhci_pltfm_remove() shoud be
used here not sdhci_remove_host(host, 0) directly.

> +	sdhci_pltfm_free(pdev);
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {

sdhci_bst_ids

> +	{ .compatible = "bst,c1200-dwcmshc-sdhci" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> +
> +static struct platform_driver sdhci_dwcmshc_driver = {

sdhci_bst_driver

> +	.driver = {
> +		.name = "sdhci-dwcmshc",

"sdhci-dwcmshc" has been used.  Maybe "sdhci-bst"

> +		.of_match_table = sdhci_dwcmshc_dt_ids,
> +	},
> +	.probe = dwcmshc_probe,
> +	.remove = dwcmshc_remove,
> +};
> +module_platform_driver(sdhci_dwcmshc_driver);
> +
> +MODULE_DESCRIPTION("Black Sesame Technologies DWCMSHC SDHCI driver");
> +MODULE_AUTHOR("Black Sesame Technologies Co., Ltd.");
> +MODULE_LICENSE("GPL");

