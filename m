Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEB2D9ECD;
	Thu, 23 Oct 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214405; cv=fail; b=iN/so4MVlxyTVcbjpctdFQcvqd2CIn5kyGednza2mbtXGbwFeVFux6lBN7OeYvwu766yo8bPGfh8WToeS3vxXHyabQ6PcbiGZXNCcP5ldxei1bSkMFRw0b28SIpRxbw8VimpIgLIuRdQr//0iKhDBrf47+c9dHooCENm5ATusew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214405; c=relaxed/simple;
	bh=dwbwGUK9eCQlnx38FkoiN7YuKzc8BewCWMYBCNB3rdQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ATkI2kXEXw2HoDZ4d+Ja5uoaknyrLv9aAQHptj3D2OZphfmCO20KUwMY1TYFamvcAvP2I0LwI7HfUzUg5k2l+MH5Dbfk8FKQWjMWDgz7ND+iHN5CmUhZd9QKeu8ugUyzpuvOHZB00vt+spqAvz1zlWltgBHLfvNXxXB37oXXSDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5f4IG/v; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5f4IG/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761214404; x=1792750404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dwbwGUK9eCQlnx38FkoiN7YuKzc8BewCWMYBCNB3rdQ=;
  b=Y5f4IG/vpZ5pujk9VzvWYpuUSD2oAgATlnMakd0kIyQ3A7i72hym3eWr
   EeQ2INMMuR+dJ8wWvWJ3F4ejqQDVGKhpGhRHA0kW37HvH6b3OwqbRtR3A
   ijnoXYSQe2PBp6gIQZDeZUioOb2FJjg3ZqO9dtfpfICCGbLYeMJyFb19+
   4oTju4WFWQPuw+nKtRRWGNrr2fVTZ6/Fxyu2GHOqNXfVDLeUKVl6WEpvd
   YT7O38lQshNvEtQB4vknyF3knptGE94MSQLOpl9F6JnYJ31yGHzbCpDHJ
   yuDsTDZg0TfJMlhql6W4lMcH4L5oAysK5DKoZklMGXJ7/5WbyDkup9+Xz
   Q==;
X-CSE-ConnectionGUID: lu59YzGLStem228c2VgrBQ==
X-CSE-MsgGUID: aeTW5FFrSSK39yRPz2J76w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65995427"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="65995427"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 03:13:23 -0700
X-CSE-ConnectionGUID: l5MeRoitQHKo1bh8OxOe5A==
X-CSE-MsgGUID: jKDuFmQbQgmu0ddmYpjMQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="214775212"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 03:13:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 03:13:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 03:13:22 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 03:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQholhKZW4zKCK8P0zlMwc3Mwy6TOBSaRyi2nPhf3Z+YNvj9jP8AiLyS5z+CEhA5DdnZPpIG/xF4KMRMsjXtEYEZmylDZG4ZHA+4tk+Pt2LkR6X3CHCa8q8x8/Q2nnrxsUsd6SufMV/N6PpzfnjhKwUVDtAcPy2b64fbovQYr17z2BDCXoUGsFJpUZz9XKcffbd8BrLzTN6sAMcyM1rJAo2cjHK7u+bjY2ogTqGCqbmJ3NjVO350eJu4+weRO1ggANE049RhKt3qpI6jXhr18w5D7iqTeOjpk+M94csbOOkj0YHc3jDF7QB7lZQ9PipBFJmuQLLdsJIKTGz/R06ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUEoG/8IfhcIT6E74yTmAW/99P27+4qOtR1/GSH9t9Q=;
 b=HQk5xQmxLiHSt864cLfFEvx+sTtwfMA4F/Uh5gB35wrzqnxWzxHBGvxjKJjcEIEkeVaseO7x2mshM8hoK+6VVSX+1A4t9jnsftIbO7h8uPd+Qz7nxBGDvuYi5SlrUe0fKXlsPe9B16DT89+LVfQkCgx/Sz1prE+rNFG4isZd5Zy6CfQZn83MPVNGQ5yhIe+ibqvpWptCPxHyVPY07IEgnz35p8RlHSkxg73sFL6tsHbrXqtP3OoWXVjNoGXI5VP1r/+L8mpmQHIJTfjRpfnPfnkyIXFq82lSdrnnuJmR4ZUTqugQC3EnxzaQe4vnOZLDSS2O27NqlrvBvHwwz7d9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 10:13:12 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9228.016; Thu, 23 Oct 2025
 10:13:12 +0000
Message-ID: <8eec7ae4-c02f-4099-b5ec-065c8ea06f90@intel.com>
Date: Thu, 23 Oct 2025 13:13:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-of-dwcmshc: Add command queue support for
 rockchip SOCs
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rockchip@lists.infradead.org>, <kernel@collabora.com>, Yifeng Zhao
	<yifeng.zhao@rock-chips.com>
References: <20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com>
 <20251014-rockchip-emmc-cqe-support-v1-1-918f03de0cb1@collabora.com>
 <70cca930-29ac-40a9-8e3d-fba1aace9156@intel.com>
 <7bxs6nw5fnjq22p7gxrmjqjtw3g5nt6cacwpfjihxv5jk765si@ho3odkyxpi7m>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <7bxs6nw5fnjq22p7gxrmjqjtw3g5nt6cacwpfjihxv5jk765si@ho3odkyxpi7m>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6e27c0-9da9-4003-bdcd-08de121cc5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmwzNlJuZHl2R0I0ZGRlQWNQQzdWWFdPUUZmSWw5Zk5HczNQMTEwRVFGS0ZE?=
 =?utf-8?B?Y2IvY0ZSSmhPNHV1K2ZpS1JkN2h5U2tYNkk0YUZnaHJCV1dqUW1SNWNFUDRM?=
 =?utf-8?B?TnZmd2ozNnU0ZUQrbjV5dDBRcjdVSzBBYlliU0pLUDRHc21aRDR3dU11V0dS?=
 =?utf-8?B?OXB1MDVHeG05WnJVRFFxbEdieS96TldiUythZDVNVy9vY3BIT2IrdENpRVlS?=
 =?utf-8?B?SVdyalVVQzhDZ2IwMUE0cVp6a04rSGR6eXNCSWZiRHhQRGVBazU5d2tyVkNI?=
 =?utf-8?B?WDMybTFBTnJESU42bzVER3dLd2ZxNTRRUjd5THdRYTNSRGxFUkt2UTE1c00x?=
 =?utf-8?B?eFNndUJmM1NRbzR2SmxLRG5tdGsxbGJ3YXN6cmxEQWJ4ZjBqOWpOTU9RbVZ1?=
 =?utf-8?B?NForVTZRNDV2aWtUaElwUXZTV01qczhHekNEZXR6bXAyTlhKaVVOK1hRMkhW?=
 =?utf-8?B?RHhPb0ZkaG1FRkZ1eGRsVDdGWE5SQlJQRk9TUlBDY3lOVVd6czVza1dNMWhv?=
 =?utf-8?B?QXB4VEpGbEtFUXV0QmR6QXNkT2lPalNCWndONU02NGZQemJ0NWxlU242OUh2?=
 =?utf-8?B?Rlc2VHA5YTAwcTdqM0RUT2V1b2hqK0FVZ3V6UUJFSk1aaEMrZzBXWHNpQ2tX?=
 =?utf-8?B?VnhYcVRQZXcxVWpXU2ZLY0c4Q1NCeXpHUDk5T2IvbGF0SmdJeGZ3TlowbkVi?=
 =?utf-8?B?SXNlQWhKTStJRWEwMjVHMmlBd2VMM2d5RTNvM2pJUVFqVzA5ZTliR1hCNWVs?=
 =?utf-8?B?eElVaWNSdXZlRk1xK2ZuYzJjeG1oQ1JFczBzRzIrQWY2M2FRS3dmTXBZcWxR?=
 =?utf-8?B?OUpUVkt2TW44bFgweG1md3pMMWlBZ1VkUEdZN1JUWWdQcGZoSG04d2ZpcWxm?=
 =?utf-8?B?MEZPTEE5SnZaL3I2T3d1OURpTGpzS1Y2MVkzK0srRFJ3bTJqTHlhdTExWXVr?=
 =?utf-8?B?T0VaYWJ1UEN4YnA0NVpOUmpOUFpXeExDVzkrbzY2MUFONGMwcHFYUEZ0aDMv?=
 =?utf-8?B?eWFUanBjUkFPQlcvOHJXT1owckwzblh2N1dPYUtwUVJibytJZzNBL1p0OVpl?=
 =?utf-8?B?WCt3NWdoVHhLSitQVnAyNUQ0emJkOTFmdW9waU5CYmZURCs2aTlKWExSZC9n?=
 =?utf-8?B?YmtJODdFakdxOVM3TjVSa25hZ0dpOTQwekRKYlhNZXVlVkEvcXA3NFlMRU9W?=
 =?utf-8?B?MDdnZHMrci95cEI2ZTdYZHBiMFVxaTBHVWV6R1pPaTVXWkN5enFnRUVwRk9o?=
 =?utf-8?B?WTE0SnBYRUlRYWI1U1VDNEM1YlAzekhOejVXVytOaWx3ZHBsRkdIOEQ0ZzUx?=
 =?utf-8?B?SStMNnB0OEVWRXZHYndzM1VuSmUxVmVlVURvMGpTbnpYZWVlOTVINTFEakhO?=
 =?utf-8?B?Y2ZEaC96Q2swQ1VCRG92U2t2SVBDR2V0ODkxdExXV2ovNVFaa3JmUFh2YXRT?=
 =?utf-8?B?eUxlTVptSUQwNXZ3RGl6eVdPYktMTkFJbW9qY281QTVnM25UTW9hbDlnNUQw?=
 =?utf-8?B?a1hpQVVNTFFCeDNkNjFodEtyODAwN0hqOWdNT1pVM3o0VkVlcWdhSUp6MlpM?=
 =?utf-8?B?eFRORkNKdmUyV296eDdXRk1IQXVTN2xjWkR0VmlVM2VBckZNMkQreXcrZDFG?=
 =?utf-8?B?OFNlMGRYUy9xL3cwTzQ1SzN6UFB5azdJcXZOa3dqNVoxNUZvNDZTb2lVNFV3?=
 =?utf-8?B?ZUNPbVc3WUpjbGpSNXc4b0VlUEFGci9LSXFlVVRyTE83bzNaYUhScngrdjho?=
 =?utf-8?B?QWYvaHFPWXNNSXQwK2plU3QwbGVRdi91UUowaWJWWFluZFRzQWd1TTVkUEVq?=
 =?utf-8?B?cUxUVy83cGcxWFh6QWltdGpFUFl3THhzM3hyRnp6WWk0eGFXTUQvQlpzWEht?=
 =?utf-8?B?OWlxaXY0OGY5M1plbWhCZ1dTMUdDZ1hZano3YVc3ZVNhRXkyOVo3a0xRTkxL?=
 =?utf-8?Q?p66MKqTKnD+WUzUoe0DHevMsKfDvolTn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhCWTFmMVBob2h1V0hORzc3dzhZUHpNUnkvTnB4QVgxRVVpWUk4SUZ4cm5P?=
 =?utf-8?B?ZjlieEV2OXd3ODM4eTBsQkJYakQzamhVRUxqWTdyK2tnVEVSOG5Od3lwRktH?=
 =?utf-8?B?b2tsWWR3NFd4SWFZczdNUXdiUHZIZG02Qnh3bVk1bUYvYU9XWGJLM1Bmc203?=
 =?utf-8?B?NVEzdnpoc280L3EvOVNaeWVMYW9RMndVUzdDdUlRMmJLbU5oV3NZK2ljS2ZG?=
 =?utf-8?B?RkFlVi9vWlFaNXpwckpUR2JtMHdXWFBmUHU5cG9NajQ1bHZ6TzU4YlMxUzJC?=
 =?utf-8?B?QjRQb1dLLy9INXBUTEZ5NlV1Zk16MHdiTUpFaVd0K1JGOCtwMndVR2VwN2Q1?=
 =?utf-8?B?WUY5ZDJxdW5EUEJ1QlRIZ3lWVUhnaVd6dkc3cDAzdlVuU2VMaDlQelJ6c1Ew?=
 =?utf-8?B?cVY5ZGtUaGdtSFJjKzV6WkhtVWdqSlNyZkpXcXkwbUlUSTNPLzc2VXg4bytV?=
 =?utf-8?B?aXVCcWdkRjEyN2dkQlVZUk5UcGhRaGdFQ2J5M1d6dHZraEg3UERpTER6THpz?=
 =?utf-8?B?ZjNRN1JvZUlva2xtVjBLMkxIa0lEaHNueDlXMVI4Q1VIUHV3QkxNZHNqMVRH?=
 =?utf-8?B?S0xub1NrNitXdzZFTzFHMSszdW9kbWJCSDBMcGVaZWVjZDVvaHlvd09yT1Rh?=
 =?utf-8?B?UHBkUlVYeFJQN09GY0pZK2tnVlhpTmhnTnFrOGJQSDhqR2hObVg0ZmU3TGRT?=
 =?utf-8?B?Z2x1T3VFUGpZWkdpcDlWcEJzWnlTK3gzK2xpdGpFTlA0b25UdkFXczBrQk9v?=
 =?utf-8?B?NkRyaUxYNkJtQVpDbHE3UGNFRzN5aTdkcVB1MVRjRTZCVk5nZTVTMDNPK3Bp?=
 =?utf-8?B?WVVYbi9VL2pHNTltdThUckdTTnpDeUdEZC9NaWlMYnRaZjEvL3ZiUTEwMnl1?=
 =?utf-8?B?cFhSNzRSL0hESHBaczVzQ2NaU1VMeWJRaGhyaTZTRWNva3lSMWVhT0phWDRD?=
 =?utf-8?B?M0c5bkxjSDZOODFIOGRqOTJMaHF4OXAyRVdIM3RLWnBIb25aMURKUFpkYzMz?=
 =?utf-8?B?WVh6SFZBendJbGQwd2xBckE4cE1IZmpwR0lqZlA2VHQzbG5ZMmh2dnBqbXk1?=
 =?utf-8?B?OElFYSttdnd0eWkwNng5Z0NiajlFb3AvNXFSS3lNYUxXZnpJMUhxNVpoUGgv?=
 =?utf-8?B?QUJkeFM5ald2YU1lcUgwWWpVZXlWQjBDQ0I1TzJieDRVaHIybWhaYUdVd1I2?=
 =?utf-8?B?QlZEdzdJeW10R0xVWUVwejJXbFd3a0ZuZUg5OUxYekxkYU9xa1BpZ2MrTTcr?=
 =?utf-8?B?YUZBNXgvcVJJSktxTG82K2w3eld5eXZpR1hscmh3Q0NSS204NVFIb0ROZzNM?=
 =?utf-8?B?MFkwOGdkU3JFNTRrTm5lbE95dkVTbm5McFpFbXYzdlhaZVR2SUk0U3ltMDVl?=
 =?utf-8?B?c1g1NEJKZXBIU3Byc04zazdKT1ExQUNRa1ZnZ3R1MER5NENtR0FVbG85K1lE?=
 =?utf-8?B?eC8xL2hUbmQrQ3A1TTZvamRuUDErRUx6dmZjczBHNlVyRVlRN25oenRzTGZi?=
 =?utf-8?B?YU9JT00vUXBXLytKZm4zRlF0QTNuMW0zQVlmaCtxQU92SmR5VWY1R252RGJ1?=
 =?utf-8?B?SVlMbzNCNTJ2a0xjZEkzN3JQQ2x2dUhLNkxhSWdwMDlZZ29nT2EzdWdRWDll?=
 =?utf-8?B?dE1td3NoN1lQMkgyS2tXdi96Q3NOamh1bXpLWXlpZ3ZzSnlRQnFuQ05FaW45?=
 =?utf-8?B?OWtNcGtweWxuMVIzaVl5NkJxc1dOUm9WK3duUU5qbW9RbHhsNlNEdXRkNXN0?=
 =?utf-8?B?czZab1V0czZ1RlBZcUdMdWlwenFIRlo2R3pBUDMwS2JxSUU2elMrYjlSQXQv?=
 =?utf-8?B?S3BxVjJKWkJ6cXlUMTQrT1VtM1pycVZ4b25Ga20wSnhTb2xyQkRTa25IdnhB?=
 =?utf-8?B?QjU5TVRhY2RBZ3ptRmJLMFh6Q1pueTVRQ0RGNUg5Z04xd2FOV3MrNXM1eDAv?=
 =?utf-8?B?Y2NvUW9OV2dkVENrR1NZcSt1NFBhbXdxbjA1aXUyTzZRYi9sL3Q1SHpKSS9w?=
 =?utf-8?B?ZVVxZHV6NG9GZnA1R3NFdXp3enNLaGRxY29yTWFhQk80dlhROFFvZ094RjhI?=
 =?utf-8?B?cnk3N01SVlk4c09aRG5BemFMejNvdEZyVFZQckloMVpjS2NiOGpEaEwrWXJJ?=
 =?utf-8?B?K0xYSGtBL3QyZ1U4bHdpb2pBRGc5Q2swUDZoZktlcThhVkRvRVNLVkJjV3dz?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6e27c0-9da9-4003-bdcd-08de121cc5aa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 10:13:12.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcxglaL2XfPH8lxGQ5wtR7Qz0dPAu2V1Mac8WbO3zcRw9W0YxuFTlSTW6gYMWUGqk7D9D54y8/P80xQRzRFzXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

On 16/10/2025 20:09, Sebastian Reichel wrote:
> Hi,
> 
> I will fix the typo in the commit message in PATCHv2.
> 
> On Thu, Oct 16, 2025 at 10:42:29AM +0300, Adrian Hunter wrote:
>>> +static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>>> +	u32 reg;
>>> +
>>> +	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>>> +	reg |= CQHCI_ENABLE;
>>> +	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>>> +
>>> +	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
>>> +	while (reg & SDHCI_DATA_AVAILABLE) {
>>> +		sdhci_readl(host, SDHCI_BUFFER);
>>> +		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
>>> +	}
>>> +
>>> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>>> +
>>> +	sdhci_cqe_enable(mmc);
>>> +
>>> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
>>
>> Transfer mode was set already 2 lines up
> 
> Indeed. I was not sure if this is an intentional quirk from Yifeng
> Zhao and thus kept this dual write.
> 
>>> +}
>>> +
>>> +static void rk35xx_sdhci_cqe_disabled(struct mmc_host *mmc, bool recovery)
>>
>> As mentioned elsewhere "disabled" -> "disable"
> 
> Ack, will fix in PATCHv2.
> 
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>>> +	unsigned long flags;
>>> +	u32 ctrl;
>>> +
>>> +	mmc->cqe_ops->cqe_wait_for_idle(mmc);
>>
>> Is this necessary?  If so, it seems more like something that should be done by
>> cqhci itself.
> 
> The RK3588 TRM says that the software needs to verify that the eMMC
> controller is in idle state without any ongoing commands or data
> transfers before disabling the CQ_EN bit (CQHCI_ENABLE in the kernel).

Leave out cqe_wait_for_idle() but make use of ->pre_enable() and
->post_disable(), refer for example msdc_cqe_pre_enable() /
msdc_cqe_post_disable() or sdhci_tegra_cqe_pre_enable() /
sdhci_tegra_cqe_post_disable()

