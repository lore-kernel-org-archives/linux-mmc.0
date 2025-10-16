Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD427E066;
	Thu, 16 Oct 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600560; cv=fail; b=oN3myGkzsSDWf51lpfnJ5RK3KEmRmkpUcNd8G2ZSP/xaKW3OHBnHLxH+F4f25mBF+Zp0EbuvASFZlZc9aPmwBCl9PAmMzjHHGd5epRyZyt0oUOCLZW/HLFsehLvpXpqrrd3C8otSNTmipjoAODHDgQFSxfRDe6FaECaN70mjUaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600560; c=relaxed/simple;
	bh=Jynh6jp73KPZ04uHSF63L/iuzIEI5GVzyXiAhw5QOzg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PBM03QF3qjovvz/fZrb89ydkwE26sOC/EYMoYmKm/NdGaLDwozAgtStXAyrOzonhVmi/RenhFGljHIIUJSRZXCCgNF7S25Er3Z6lBdFD3PyAT0TsWyXxS6HUr2hipCAFsde29iV3pcdz16qR9XAoS7QlHh1S5HhE7ttYSggabHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AULopwSc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AULopwSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760600559; x=1792136559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jynh6jp73KPZ04uHSF63L/iuzIEI5GVzyXiAhw5QOzg=;
  b=AULopwScYNR3JY9hZBWUebPgjfi5QJLl4dbyfbOmysbury01SODbFkQ2
   7BsYkYUvbAmrQ9Uep4Vt5mZU7XHj4TXfJ0RnW9tms1Ig6PkN+Kh21Igc7
   bAw7YQXjgVRzBzlsM9PWQXuaYT+Tii3ghn3jZh8WlxBvxCLOVnQ3gXUbm
   FU2m4O1Cl8ZtktRFMLmHVc2Cf/0tgsGPMgZ4a0O0p4vINf2HFKrWzR4IQ
   wMG1bzyJ/o3eSKXKSgCkMEBDD1MMouvwR6SqJnrehyN1wbdgPZzon0a/K
   N+hemjcKRITcoG5Ikakw41mSN+Ro8e4ed+AuBl/ac9PEm47h/JpI7k/Pj
   Q==;
X-CSE-ConnectionGUID: cYVW37GAQ+upHLzentDssw==
X-CSE-MsgGUID: qZNEWHImR2uNgbpgbrHseg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62878628"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62878628"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:42:38 -0700
X-CSE-ConnectionGUID: D49PT9WQR5mF35Rl1Ido+Q==
X-CSE-MsgGUID: bODGak7uSD6sXP+qEwZiBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="219547879"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:42:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 00:42:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 00:42:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 00:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oC32Wwx/dKkuyBV71oI788ybg/AEu5/6vNgmbd8AFQ7IcEZ+72HgPqrGYlJRRHB3q/r08coGh+KIaNwAaE/VRZ7YBhuh2u4ar5mQQfrTf2XPI3K3lqaAB1t0WLSnPVxiaXKzNLwUadiayoV8hU2CH36qVzMotF9ZN2dpBuTfPzA7ibrwL1I/gF7g3AKvGUrBVaBIeIsxYvpYWx42dInLxIvqTWTlQoiQutrLw5L3iVdnRK3+1GQk9Kp4pY+z6ME8/IK7lnvYnhid/DzVgODgCmLsoGZebee1DmQBDifCGdxzAEQVz13Blzu8UIrZ4Mi1zLObAfvRGBarbcw2J9BaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsOEchmxu8GgNTX3qSbOmQlLO6C3rCEcTrAAxF+tfNc=;
 b=TlFKHBd+gisvwacn5Nn+qyi3Ipx5AsYaEXfMjcUYsrtR52XbpQjbdnXVWo0vUxnkEO+HrdlMzyC23d1+BnBaf5/s83ClDB+q3zQDDdFxkmBUmE1ObGlizc7dqUUQV7njKl2JKEXeB535lARryvIsAmi5gwrozUJgeTN5j0o6tD4kZoGuk795Bh3SBaBrNkMyzZnC9HLyDMb931xhPt54qVNV20zDxU4iPF4n+RiV9GeJ+ag95KS6BaKADvaHpcweyVqaevIvINrt7fTht84mAqqPuilJEvQr86g5FO2OgUbB1oFVj7F9DKjiELkdB6Jjl3FGPrVTKlXUKfJcJg2RtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ5PPF64191BB3C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 07:42:34 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 07:42:34 +0000
Message-ID: <70cca930-29ac-40a9-8e3d-fba1aace9156@intel.com>
Date: Thu, 16 Oct 2025 10:42:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-of-dwcmshc: Add command queue support for
 rockchip SOCs
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
	<heiko@sntech.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
	<kernel@collabora.com>, Yifeng Zhao <yifeng.zhao@rock-chips.com>
References: <20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com>
 <20251014-rockchip-emmc-cqe-support-v1-1-918f03de0cb1@collabora.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251014-rockchip-emmc-cqe-support-v1-1-918f03de0cb1@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0284.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::22) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ5PPF64191BB3C:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a52e12-4f0d-47ea-4090-08de0c8791c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDEzV1ExVk9MVWswK291czRINDROUFpFQXNKUjRTaUliS2lRMkVJVUJKVFJz?=
 =?utf-8?B?SzNxTllIdGxRMUNkdGRzNEtJaGRIT001aVM2UllWRjgrWEhXMkZsWTEraGJm?=
 =?utf-8?B?ZlZRTTNBNHNNK29WS3BzYjRxbTUzTEZVVjFta09aVlh0eFE2ZVhrcXcvaHNL?=
 =?utf-8?B?cXZPNk5TT2dxVDlZd1c3SjRhUXJ4bk9qVnVwY2Y0NkZ0NkJoMDBpNVczZWFu?=
 =?utf-8?B?akdPUHFWclNKSHl6NlJEZEpHaXdtRE8vNllVd1NmMEViK2M2TFdkaEtiK0ps?=
 =?utf-8?B?VGZUbDVqblFjb2xVeGRiS0N5OHIyU0hOcmZmdGxHR2FUSkJ4UXArN2tzTU5q?=
 =?utf-8?B?ckVOV0hZK1ZSSGVBcXdIZGRzbW1DRTdiMkw5K3YwY0UrcXhRZUxFRGpvNGgx?=
 =?utf-8?B?MkQ1WmN3cngzb3F2YmdxYnhxNGk0L3piMkFMOGZ2dTU1VzVUZWxQTkRZN3dG?=
 =?utf-8?B?TWZkaCtZdTZvK3ptYjFZVUQ0dVFWZ3NDRWg0MURORy85NFJjQVJTTnNKNEVk?=
 =?utf-8?B?c2VJeHVpVlNVbG0xY3Y2aHE4UFl5ZnZOYlAvN29vRkxBUFRYc1hjdVZSZlNy?=
 =?utf-8?B?S211N2MrTVV1UlhMbWZ5UWFjd1pVc1EzdWJsWExpc1F4UW5JR1g3M3RZb0Zm?=
 =?utf-8?B?OUZKMGxIUzIrZkpMenZSN0c2WVVKbW9RWEprODdHSktwTXcwQjh6dENvVVU2?=
 =?utf-8?B?ZC9iSXI3SEVGQzN1OVZJcU1Wc2dUSzVTckEvRDBKUHFWUU52QjJMU3EyODdq?=
 =?utf-8?B?ZHJraVEwL01SU21qN3FCa0o0ejhTZFNjZFd2aEZQR2hjSGF5aFBrL3VXNWxW?=
 =?utf-8?B?c01XaHV3aXVNbDdXVHVYQi91bW9TS1dkU21ydU15NWVjWmIrQ1Y0aEszWTBp?=
 =?utf-8?B?amxDMkRjbnJTY2czR0MrM2s5bWxZUGJ1NmdtNGl6dWdkTXZLSnRYeUtaRmpM?=
 =?utf-8?B?MVZTaHpuQ0tmMkJiUDBqRlkyRUlRRFVvMElnd01XMEJYTUJwd2p0SlBlc0Jq?=
 =?utf-8?B?THB5RDVDTXcrR2RZMUl5bjlPY083Z1ZLMlhkVzExcmNRSjFvZHpzV1VIbHh3?=
 =?utf-8?B?d05ZNktSY280Y1lDOGZuWmZqRDBJTjZmaG56aWxudkdIaWVBNS9acHNyVVZv?=
 =?utf-8?B?bXl4dzBQYld1TVZuSjBMN09nOHd0VjdCcTROT1NuNmxVM0txRHluWmhPeHpK?=
 =?utf-8?B?bkZudkVRNzB0eVZsaUxLeW8xb3htaFNyVE04OHVXU040NjhIZVFyUThJcngv?=
 =?utf-8?B?aGZJRGM1RGg3U1IyK0dLejdkZ1FheUxvMmY5OGd5ZVdlT1BNeEFHcFQvNHBp?=
 =?utf-8?B?Qy91NWtNVVkySWhhNHdxQk9zL1dwWWs1Z3VZNkR3SHNPKzBGYkcrOW01dng5?=
 =?utf-8?B?Sm1zSE9QeUU2S2IzVzRiM3hmbXpJUVg2dlVLN3dHQmJmSUpOUDRqaFZDQm1C?=
 =?utf-8?B?SDRWd3BUaWhLK1VXdGdHVjU1QlJSMUloa003OEpYOWNzTkEzM1I1b01RV0Fu?=
 =?utf-8?B?TTNOVStXTTkvWXNRMXZmbFJFS2dpazlnd3lMSzk5TFNza0oycEJRLzN0VU1N?=
 =?utf-8?B?VUVuK1JNd3RFdWlhMFBIS3hmSWsvSzBrV3dUek84K0NIVW5SV1YwM2ZGTG4w?=
 =?utf-8?B?ZkhmUDRMY1ZyTTFrZ3lsK0hSS3BkUHYrSWhEamw1Nk0vb3R5UUt1TDVZYTNl?=
 =?utf-8?B?WXdoMXVwVHVXckVQa2RvYXJXODlZQURRNHBiWmRyRnAxTjlPTTBTeVNSbi9F?=
 =?utf-8?B?R0x0cCs5Qk9INEU5eDNBaHF3TGhiVFAwaWZzZlVtemNmMGV0ZlJVQ1RmUHh5?=
 =?utf-8?B?K3hLajZjcUE2bHB3R0NTZDM0L1ZuZGFMYnVrOTdxa0VnazcrNHNKY0pteFdZ?=
 =?utf-8?B?Y2lVbEVBT0hpT24yV0VyblBJRHRIZDdxWll5VGh4YXBCTFVQQVBPZlN3Uldq?=
 =?utf-8?Q?EdXOPl9/Bp6yRfR1rlwqrkdZuaOj5URt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MktRay9FTC9vektIZEVmYWlUWEF4c0l2amU3Rm9Fc1RkV2VTQkRlTDZNNDhU?=
 =?utf-8?B?Q2hBaStDQnFrazk1T0dIdWM4dmZxM3NrSTVqS3dZWmladitjRjVVNzBxL09Z?=
 =?utf-8?B?M3J1bGdwaFhWZitRdnl2elZ3a29mV1N1VWFWOHA5VFZBSTdHSWIvekMzcTI1?=
 =?utf-8?B?bkJDV1F6Uk9pZzVLaTAwcVB2dERZWktHUXkyTTBlcG1xVkQ0bzR4NVNkTkU4?=
 =?utf-8?B?TThPWUhnVjNlUjlKdzVtVDJHSW9NdzFLcW5mMmxXN2U3NVpiZm10Zk54aXhj?=
 =?utf-8?B?QUliajhKNWZZNm10Q01QcFFlMlo4M0IrRmtiYnNyVEZPTU1JS3AwK2JtTEdl?=
 =?utf-8?B?eGdidkV1TlRUZkZtWTZ3NmdmNW5jNjlobHh5cm1jbFNjdWZJeTEzM3RzenNS?=
 =?utf-8?B?RTJUUXJEc0VQam5RY2pmQ0xmY2QrT056eWM0U1BkT3M2akJTYmVlU2VqNVZR?=
 =?utf-8?B?MzRnamJQWGpGaDM5WGlVUmg4Zzd2dkhlVGU2dXJXeUNaSUpiYUsxbW8ydTRl?=
 =?utf-8?B?aUF2aFNQckY0YW56QnVMdVBCd1RRVUp5RFVHclBacnNmWDZnUmZYYm9TYUFh?=
 =?utf-8?B?QWpmdTUxbXVORWFCbTZIR1Q3SEI3QmNpYmMxUFpGdnpNWE9sSDJydGlETWV2?=
 =?utf-8?B?Z0tHdDR3NXREaHQvZ1F5L0RVTGUyMDZMbHhvVjVqaFo5TnJOV1lRZHNGSDNQ?=
 =?utf-8?B?Nk9haVlUV1pPMW1hVG9jQjgzbHpwT3NheFNFbEtRTzJRKzI5enVzY2dLcS9K?=
 =?utf-8?B?bUk2SmtCdHRqdFFEb3pjVXRPZ3lqSExFL1U4ZWdaUHJrUkM2bi9YMHJQdjRV?=
 =?utf-8?B?Y09lTU53aFRtdHZ1M29WMEJCSkU5WVd5cHpFcENoRGRFdHpobW5rRnpGblVM?=
 =?utf-8?B?MkNTeVJPaCsrZ20vMlJFWGlsRTJReHE3TjFzRzdUUUhBSzF3NXhneExWT0py?=
 =?utf-8?B?b2JHbjNOM0xqZVZDcVVETHh3aTJnb1lXRzNFM2tIYzU4RndlT0F5S3JiWWd6?=
 =?utf-8?B?ejhhQjY1a2NZb0tnVWZyVW96VzFvRlRXY0dOREszS08wSFVsRnAybDRDWTU1?=
 =?utf-8?B?VVlOV1RBaUI1N0JXL2l4WFQ4ai9RSU1heVZzYlpYZDZWd2Jyd0dWS2x3cnhp?=
 =?utf-8?B?eFh5Y2lRWGRBSjJDc09meWpBLzQ0TkJicWM1TVN5ZlRBdURyNVlidnJFYmVB?=
 =?utf-8?B?OXk5OEFHWWk5dE94KyttdU14VGJoTExYM1pSUHZZU05GS01OY0hMNkdsZUhk?=
 =?utf-8?B?KzZ4TjlkYjJ2b0hsSmIxZTA2dFE2eno0aWw3V3RmUUpkUzhocytGSXJqMWlu?=
 =?utf-8?B?SExlWjJBbXRRM0FSVE1EWlJvRUwrcWpxQnVwZU5obVA3TnZ6VmZNYjI2WW95?=
 =?utf-8?B?RnFEWDh5U2ZJb1gzbkxRQXg1L3FETmlMQW1NbG44NE05TE1SMDMwZitpOWcy?=
 =?utf-8?B?VW1LcGNLa2pUUktuWWlTTDBCdzFOc2E0K3lTSytsWlhxY1pRVnpva0NoNmlG?=
 =?utf-8?B?YlRLeXNyaUlJNllwTml4NVJyeVB0SzFlaWs5UVlhMzg2N0twQ3lwVUdTQ0p6?=
 =?utf-8?B?c0p3WGI3TmJxeUpNejBEdC9Ya2c3V3IyVHBPdkRtVkxrZTFrK0xxZHlFUTl6?=
 =?utf-8?B?a3RUOTNRZ3Z5bktpZkhQUVY0RnNjTG5FdG83QUVpZXB2bFRlN0NHSDBmSnVm?=
 =?utf-8?B?YTJ2RXBWTUIyN0p3ZlBwdHJCNGhZdm81S29qK2hyREdjRG9IVTFmVVFyRjdD?=
 =?utf-8?B?akY5ZFp5djFFdkVEOWRyRlpYVXdqeU16ZGtScXVSZ0tjVEFNVkhpMkY0bVUx?=
 =?utf-8?B?M0FEM20rd3Y3bFZ5UitaRWp4WHNNYkZzOVlVOGMzMGwxNTYzRmdOMUthZm5h?=
 =?utf-8?B?bzVnVkNzRmFua3ZOamw3SGRHcDZzdmhScloxb3pnUHMvSnYxV0ROd2NoaXdP?=
 =?utf-8?B?N1ZqVkZMNnRlOFVjYitvbklaMmd6ZlU2QUllMmJUZXpWK1pjZDQxM3FhS3RG?=
 =?utf-8?B?dG1rNDZxZGJ5ZFljOWZNd0ZRN3RaejBWczZlNGc0SVNKRUtrZFp4WDlBOTRl?=
 =?utf-8?B?NDZnQ2VqNTVWVnNZNUplV0xwTGcrVzlpR0lTRllHUjE4UlhRWldFQ3hLRmhm?=
 =?utf-8?B?aVgrU2RLTHA1aXgzQUdzRzZORGMrSE9ZelF0N25ReFEyZnA0cUxDcVQ0Y0tv?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a52e12-4f0d-47ea-4090-08de0c8791c5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 07:42:34.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QpYdu2w/IaWIPna3MBWBld2A4U5jCaM+cp5KdHtt1nnpBed6FSU5BlMRBKDf7bDcsQVRoDiu2/Z8FTFIG4aAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF64191BB3C
X-OriginatorOrg: intel.com

On 14/10/2025 18:41, Sebastian Reichel wrote:
> This adds CQE support for the Rockchip RK3588 and RK3576 platform. To
> be functional, the eMMC device-tree node must have a 'supports-cqe;'
> flag property.
> 
> As the RK3576 devicet-tree has been upstreamed with the 'supports-cqe;'

devicet-tree ?

> property set by default, the kernel already tried to use CQE, which
> results in system hang during suspend. This fixes the issue.
> 
> Co-developed-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 85 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..f533c98d5db1 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -24,6 +24,7 @@
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> +#include "sdhci-cqhci.h"
>  
>  #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
>  
> @@ -82,6 +83,8 @@
>  #define DWCMSHC_EMMC_DLL_TXCLK		0x808
>  #define DWCMSHC_EMMC_DLL_STRBIN		0x80c
>  #define DECMSHC_EMMC_DLL_CMDOUT		0x810
> +#define DECMSHC_EMMC_MISC_CON		0x81C
> +#define MISC_INTCLK_EN			BIT(1)
>  #define DWCMSHC_EMMC_DLL_STATUS0	0x840
>  #define DWCMSHC_EMMC_DLL_START		BIT(0)
>  #define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
> @@ -234,6 +237,7 @@ struct dwcmshc_priv {
>  
>  struct dwcmshc_pltfm_data {
>  	const struct sdhci_pltfm_data pdata;
> +	const struct cqhci_host_ops *cqhci_host_ops;
>  	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
> @@ -561,6 +565,61 @@ static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
>  	sdhci_dumpregs(mmc_priv(mmc));
>  }
>  
> +static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +	reg |= CQHCI_ENABLE;
> +	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +
> +	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	while (reg & SDHCI_DATA_AVAILABLE) {
> +		sdhci_readl(host, SDHCI_BUFFER);
> +		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	}
> +
> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
> +
> +	sdhci_cqe_enable(mmc);
> +
> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);

Transfer mode was set already 2 lines up

> +}
> +
> +static void rk35xx_sdhci_cqe_disabled(struct mmc_host *mmc, bool recovery)

As mentioned elsewhere "disabled" -> "disable"

> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long flags;
> +	u32 ctrl;
> +
> +	mmc->cqe_ops->cqe_wait_for_idle(mmc);

Is this necessary?  If so, it seems more like something that should be done by
cqhci itself.

> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	/*
> +	 * During CQE command transfers, command complete bit gets latched.
> +	 * So s/w should clear command complete interrupt status when CQE is
> +	 * either halted or disabled. Otherwise unexpected SDCHI legacy
> +	 * interrupt gets triggered when CQE is halted/disabled.
> +	 */
> +	ctrl = sdhci_readl(host, SDHCI_INT_ENABLE);
> +	ctrl |= SDHCI_INT_RESPONSE;
> +	sdhci_writel(host,  ctrl, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	sdhci_cqe_disable(mmc, recovery);
> +
> +	ctrl = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +	ctrl &= ~CQHCI_ENABLE;
> +	sdhci_writel(host, ctrl, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
> +}
> +
>  static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -679,6 +738,10 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	u32 extra = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
> +
> +	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
> +		cqhci_deactivate(host->mmc);
>  
>  	if (mask & SDHCI_RESET_ALL && priv->reset) {
>  		reset_control_assert(priv->reset);
> @@ -687,6 +750,9 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	}
>  
>  	sdhci_reset(host, mask);
> +
> +	/* Enable INTERNAL CLOCK */
> +	sdhci_writel(host, MISC_INTCLK_EN | extra, DECMSHC_EMMC_MISC_CON);
>  }
>  
>  static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> @@ -1188,6 +1254,13 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>  };
>  #endif
>  
> +static const struct cqhci_host_ops rk35xx_cqhci_ops = {
> +	.enable		= rk35xx_sdhci_cqe_enable,
> +	.disable	= rk35xx_sdhci_cqe_disabled,
> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
> +	.set_tran_desc	= dwcmshc_set_tran_desc,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_rk35xx_ops,
> @@ -1196,6 +1269,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  	},
> +	.cqhci_host_ops = &rk35xx_cqhci_ops,
>  	.init = dwcmshc_rk35xx_init,
>  	.postinit = dwcmshc_rk35xx_postinit,
>  };
> @@ -1245,7 +1319,9 @@ static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.set_tran_desc	= dwcmshc_set_tran_desc,
>  };
>  
> -static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
> +static void dwcmshc_cqhci_init(struct sdhci_host *host,
> +			       struct platform_device *pdev,
> +			       const struct dwcmshc_pltfm_data *pltfm_data)
>  {
>  	struct cqhci_host *cq_host;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1275,7 +1351,10 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  	}
>  
>  	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
> -	cq_host->ops = &dwcmshc_cqhci_ops;
> +	if (pltfm_data->cqhci_host_ops)
> +		cq_host->ops = pltfm_data->cqhci_host_ops;
> +	else
> +		cq_host->ops = &dwcmshc_cqhci_ops;
>  
>  	/* Enable using of 128-bit task descriptors */
>  	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> @@ -1443,7 +1522,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		priv->vendor_specific_area2 =
>  			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>  
> -		dwcmshc_cqhci_init(host, pdev);
> +		dwcmshc_cqhci_init(host, pdev, pltfm_data);
>  	}
>  
>  	if (pltfm_data->postinit)
> 

