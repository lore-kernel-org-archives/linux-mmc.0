Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2D42641B;
	Thu, 24 Sep 2026 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232981; cv=fail; b=hyIJoStrxQWYNQjogV2bEHbsnPyoIeQoc0y7GMF1knr40rmOfvf9sxfz6KYj9oDMntJAo2BoDUs9VCYu9HteZjZG/F/Mtox9VbUdjpZUj+LLgJTsgDxnNOL3ezYvfECLwNUPqamH2ZTOrx1Mm4nAAm7D2lgfIgst0/a/vaasRg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232981; c=relaxed/simple;
	bh=Ue+UqxM+raNwDtIDdjpor+eVe0gN/XNPkIk0I0lstqo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gn2zG3fmfmDWyIKZISuQf2vQjHu/GelzGn2Fu7Y9pJG52zmhKpbZxTYSyw3/fRtAY0bRuXuq2bE1tGzPOn4sXhsyIhGYoHshiINb6J7Gvmf9MkbGMkQRBxJl6EPdCK/dDG47VdhD3gUWjKvdfNmb3d3U8j7nYpnNPxpMmH+/qNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpJ+0eMc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpJ+0eMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232968; x=1821768968;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Ue+UqxM+raNwDtIDdjpor+eVe0gN/XNPkIk0I0lstqo=;
  b=mpJ+0eMcY2lsynd+XfWcg9G0jQUFI50amh2VzFEo+vh3xqR05qrFF6YK
   k4kf8DVsaOyVJ3GAsJoonWrkCVMhkKpw7IP1n3nr75pbPySz9ApRXpWmV
   D6QyMFVq3o3u3tg/9MZcR2ROqN3s4s1c8S9nGoPNMIqzi4cofatrZwa6B
   6BpzwJYwlsqT0ab5TEr1e6rFRaCRfCSpXxb9ic6+hvlJF8bCKQDZ/ci1A
   slVY5BwScsEEdw82XfCwZSfKzdFnV277LbBNgflKTzuRoVKsoNGCuXHMp
   TmR6pA3mWv+g+HJNgNzSJQgbU2Pj1q0AofRoUT3gGKsQ81MsDdTStPwZe
   A==;
X-CSE-ConnectionGUID: 7+GpkXxMRxuxaL0+tmG5Gw==
X-CSE-MsgGUID: 93+mIc5iQPeaCj6LFv8iQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116515782"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="116515782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:55:56 -0700
X-CSE-ConnectionGUID: Tjvim21fSbuqqzx7Q7LsCA==
X-CSE-MsgGUID: ciyHRM8JT/yz2u7TXsOKZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277313360"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:55:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:55:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 23:55:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWgazVYp32Hjbqsj3Ce4BQhccdKkjXkCt4oOy0EULYybNA7cNniuOYqw1xcQ1li7FpKWP9wprVCN8SY//3XHpBCBKSRxzjKzehIhmctAQeDmZkChPbaK1oWh6y+WVXTOB8+EBxO6wvRzql+tWTyOTOxTuGsUhi94CUG+2h/pGhR2U3PTbLRE08Xff7iN/HW5PNfOsv/YasrnFvBFImVOojRAdTql6z1OKUh98UXcvDwcTYR+iWr+MNl99iuPKgZ2mLyouKkcH1ySaFhETPEXcG2t3AmlVl87t9XNZhs1i2Y0BRlJDqiertWFLNE3yNs5IDf9GGcqKpUrwrMCK2RISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLYAmDkYiu1mGpbKSCkeJRggFoOcm7UJC26gIZ5mClQ=;
 b=WoJjlh/6+NN3LbRBeEsUtwkm7/q3i/1q0gxa9nQJ+rXT1pt9ZANj3FRBlaOnX1yQU8TRR0cvCa5teMwZ6mHzOso0BM2AgmurxPRtR3upmpCV5+PlocvZyG0xD4CZ2lm3Q9e//yV1aDpDLjdUDNxMmO7Bq3e+bGKgB0/mgd1qWX2GmGI6qfwecRbTYCNw+KEcQj7kG3oYrkfG87eT8pt2DMVnkj/bQ29ngzcOFhfZrpTRob/iFZjeZ1IGZwInpmuaeTq7dE/raLP8ZqrxzLWQYfZG2GDjYJvv+WKaPcIduaGfD0IbvjtkxorLMaumdhwvLyT1/azVsecH4JChMnm1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 06:40:51 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 06:40:50 +0000
Message-ID: <4aafce14-2be7-46a6-9d5b-8df35646dc0a@intel.com>
Date: Thu, 24 Sep 2026 09:40:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mmc: sdhci-cadence: read SD6HC DDR50 tuning from
 device tree
To: <tze.yee.ng@altera.com>, Ulf Hansson <ulfh@kernel.org>, Tanmay Kathpalia
	<tanmay.kathpalia@altera.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <9440b973966df50c9f6c79055ec83ef3b634335a.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <9440b973966df50c9f6c79055ec83ef3b634335a.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: e2efb37a-bd16-4f4a-f00e-08df1a06c60c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|3023799007|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: QgfuJZqa5ykepSPHLzyr4KHZru+3HHDiul8H9jIkha0MnAho7C+WMJ4aTjlBqvLrFaiPxvA2y+atq+/WtreHZSpyqdXPmdDWtQKnYd4JAxdPtapOynf2aQJrXKbkTEwGrhzw88fi2eM8SXLVU5vJO7bPZfIKn/Xq27QOYFA3WUTmmcccN6sUFYYYPVmbivo9ikGk3HhN8xWbyqgYTI2649bjQYmsEiohiCzX2Zsir11uY7MrdPzX1ciiSMOWpAiUyS4vxY4HLrLBsyV0Fz8wE+jg7NTdWzU2LlIOK+ezPV+L5HdW3hTkOv7+hDjz3opp2MTpxOGAl/TvGjHYylIioqoU9Jbh1YhndpbDENp6FoSlOv21AOvxpWj1uk57Aiwoop12HCD0BZl2Byhi8+Aq9gr43XExb7oqL3nqeUtB9LxYV14LtNB6nCto0EY/1MYulNvvuK/lnrr5hFxzLCyPJ+Q3nSEKJgVogG12V9B4BTzZAI92RFcleBq4qgURZ24H9J/uSuBknl/WUl82/FLSARUuwwXrDdYeKUaHC7our2VeAW+D55LFOHVJTC+XoaLrYQ/EZ3sDjlbkFFGDz+UADH0bCjKnA0ntyczldfw2AI5V5039dJf9+AEdvAIvYsKciYw1V5Uj6UZL3FO9N+Smq2GaPdxEqzyQu+QGZHzNZT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VZaTNXUTVkVERPOHE3VmY1TzZidnFyOUlRQWtlcjRWdWhkSHN6TU5SdGFC?=
 =?utf-8?B?d05pNmRHSnVzSWthQTk2ZDB0MGkrQ29BTkFiUXJ1aEJ2dDRLQmJCM1FDNnI5?=
 =?utf-8?B?OU5oMUlwcGtkL3lhbURvWFJNSUlGNDVCVnJSV2d4ZFRzSzBNN2hPSUxFcjNB?=
 =?utf-8?B?Sm5Mci9LSDdUZGlvY2FIMFA0eHlqMkxHRVJERXpsS3FqaGRaWkdmaThTOXVD?=
 =?utf-8?B?eUhiY2JQejUxdjU1eGh6T0FiTGcxUFI1T2thQVhVZ1hRNmlJTDZkL0QwbjVl?=
 =?utf-8?B?bzNFVnQ4eU5GVENOQU4ycytvRmsxWVBiQmM1U3I1cFpqNm9Ta0FLYWQvZXJy?=
 =?utf-8?B?YVpZNzh1WmdMK3lMZk9HaHpPNlVkM3d5ckgyUUlTQi9KVkRQOXRNQUxHMmpv?=
 =?utf-8?B?UWVnaDhvWUhOSmdSWm1qU2IxWTBYNW9xaDEyallxbHZWWjc4T1B0ZGViaGkr?=
 =?utf-8?B?SU1pbU9Pd2FXSTJWYlVuQ3docTVMSFNXR0xyRjVDV3YrTzl6aWoyWWY5eS81?=
 =?utf-8?B?R2twdDdsSis4dEhBRCtDc2d4ZkJQZlhwNG5hMkNoMGxManhjc2dhWjNLL09Z?=
 =?utf-8?B?T0orcm1KbUxrOGh2TXFIN1I0NlVUaGNIVGxRMXphZ2xRbUR3UlBQOHd6cXFZ?=
 =?utf-8?B?R1lGSFh6T2dFemd3VzVBSFdEbTVweTNubzUrWEhrMmhwV21pOXd4ZU8rS3pr?=
 =?utf-8?B?YU4rNzNpVjRhbWx6OG5pb3RwbGNPUzVkVThiSU96TUNBVytqQy9ML3Zhb05P?=
 =?utf-8?B?N2hBRVpmYUU5RmozTjBiMmhkUmlyOTNHamkyRzBuSHpjeVU0R0lIWHdmMEtD?=
 =?utf-8?B?dWRCV0NFQjVtalNnOGt1ZmZteFZCT25EWnB5b2xqek8vbi9rZThBUVFZN3ky?=
 =?utf-8?B?SWd4czBUaGQ2MEJkZjRyVTJoaWdvTjNvSU9acTMwa3hNbk5nSGZEMHJTMHpJ?=
 =?utf-8?B?YXJsZTBIYWc1cEhRaUh2S2d0Z0lGMkFzTWF5RklIQ04zZHZZZ25XVUtQZWV1?=
 =?utf-8?B?MkVkbFVUQnFjeWhlS3RKN1Z6V2RRMjZiQmFMOFFmSUh5VlY0VzdPaGdXa0NM?=
 =?utf-8?B?TjVLMXVuL05Zdmx3V1NmVDJFQ0VZT0NYYXlLbVl4bWQ4Vlc1Z0lMYmZ0YXFs?=
 =?utf-8?B?ZFNzWnF1UitScFNZUnQ3SUplZWJqaHRKcDZNVlJUbG5GV1ZQbXhvK1FWOTZq?=
 =?utf-8?B?enNSQVlJOGVmb2Q2eHhHcFVtajErQVhmOXB3cWZnbGpyR3VqK0QrS2lSd1Vm?=
 =?utf-8?B?NVhET25UVkpLMXJ2bmQ3UUI3bUJXeWdqRitXdStRTXNhc2gwUmlzQUhyeEx0?=
 =?utf-8?B?bDgrMG1SbmF0Ymg2UXhvZlVtRHdqRmh5eEVlYVllUUk4cUlncGlLRGRyNWpE?=
 =?utf-8?B?TENmQkJxMjRzWkZWU1ZrUm8yK2tSenZqMVZLY2hhNEhHSWdybGJzblVFTTgv?=
 =?utf-8?B?NGFvOXk1ZDRXQ1I4V01MM1dsSWd3OUV0RmdHcnl6ay9XUGE0NFZSL3BMQWdu?=
 =?utf-8?B?V3JORDR3STJWaWxtR1JOK2FSWjl3TzNtVTdpcWVQa0FreS9WaXkwbWM1KzJH?=
 =?utf-8?B?RlZoa0RhM29LWkNHc2Y5VUk0OGJROXlhMWVTK3YyL0pNRDVyL0E4RTk4VXVP?=
 =?utf-8?B?OHpnWm9kbXVYWGJ6YlY0QWRGUWI1cHdHYlVNYmVFT2FVRnlEQWpQaklyK0V1?=
 =?utf-8?B?ekc4azliVG5KRXRKTjEwTDZTVjAwamQ2bDV0T2U5dUwyWDZmSjkvYWFjVG5P?=
 =?utf-8?B?bXBHZXN1VlBwRnQ4Y1llWlVkWTV3N2xvUFQzZklEYnlMWmg5TTRnN2xNaE9r?=
 =?utf-8?B?VUVZcFVUT0YybDJMa2ZIRWxxMXNkby9DWjVmOFN2WDBuWHM5RFpmMEIvZW84?=
 =?utf-8?B?bzl5MU41TkFuMFlIbFhzMkJWT25jUzJRdUVqdGl6NmRJdVFGSi9LSFN2RFlT?=
 =?utf-8?B?K0FPOUM4b2h3aitpSXZJeDNaUjkwNC9FNmlDWkxlZ2JTd0YwYXVDMEtIejFF?=
 =?utf-8?B?K3h4MlJDc1ZwMTJhUFU3RHB6WjBndzhITXlvY3k4ZnB3NjBpZXJqQjBEQ1NF?=
 =?utf-8?B?RjBYbi82UWVVMzY1amdzUkR2K3RIY2FFc1U3NnZUTXBLN3NiU1Q2RlM5Y2dB?=
 =?utf-8?B?YzVneDcvZmFFeHdJK0twS0kxbXpwS0FiYWNJWUtNdHhFQWpLU2pvNndRVTB3?=
 =?utf-8?B?RGJwUHlwV2g4eUZKR21Oc3U5VVQ5VGhrQk9TK01BOHVUSjRUS0c3dTVpeDUx?=
 =?utf-8?B?TExyU3JoSktFaEw1Zmg0MVQvcm1ic0U3MVh4bFBJTFpIUktvUnljZTdxa2Nu?=
 =?utf-8?B?NkkxbUNPMndyTjk4aTJYcUswQmFPbDliaUlKeFVKQnFCVnlvQVltcGFzMGpr?=
 =?utf-8?Q?ez3tRPKzyDjX3y8E=3D?=
X-Exchange-RoutingPolicyChecked: nOaKjv+NSOxzPf49K+p9Z/nZ7FJ6slGbYfkcMkukcCx8evM6Yt86DrYz5AKxlhBwB48U6DM2SRU7V4cBSc65Yh8/CDmfTyIQiTw98nKBfBsAheWD8thfR9nZ+jxXSuphDR5rVEnPiI74cg49M8oJ6CE2QNgHs2BsxYA22tiR8qwxdCIg5/1TFbapDnZ68tuFdV05GqVpkYw1VESRpx0ejCn/DlUFjPoJU3SHcnlV2bn9dcdaBtLyIyFX+slqUGd5cWoZywNXv6lJederJ4ZwdQ/5k8Vj34EjFFJ1I+sNkPgnEe9DByNPuwU0pykDpbdGelR/twEVxuVfaaCiwUjZCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2efb37a-bd16-4f4a-f00e-08df1a06c60c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 06:40:50.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkloXBKplcXbm86ln2Tuo0J15fgeJom9hJTAZa4E7quP491YF3sYWt4AW/r4AY6492rLkukXmIqNJdsKGOAkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com

On 22/09/2026 14:12, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
> settings that need board/SoC characterisation. Read the read-DQS delay,
> read-DQS source and phony DQS assertion timing from the new
> cdns,ddr50-read-dqs-delay, cdns,ddr50-use-lpbk-dqs and
> cdns,ddr50-phony-dqs-timing DT properties at PHY probe, range-check them,

Firmware values are expected to be correct, and so are not validated.

> and apply them only in DDR50. When a property is absent the existing
> driver default is kept - for the phony DQS timing, the derived
> REBAR_PULSE_CYCLES-1.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
>  drivers/mmc/host/sdhci-cadence-phy-v6.c | 72 ++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 84592ae42762..0f47fa62d894 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
>  	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
>  	u32 delay_element;
>  
> +	/* DDR read-path overrides (SoC-specific) */
> +	s32 ddr_read_dqs_delay;
> +	s32 ddr_use_lpbk_dqs;
> +	s32 ddr_phony_dqs_timing;
> +
>  	/* PHY_DLL_SLAVE_CTRL register fields */
>  	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
>  	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
> @@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
>  	/* PHY_DQS_TIMING register fields */
>  	bool cp_use_phony_dqs;		/* bit [20] */
>  	bool cp_use_phony_dqs_cmd;	/* bit [19] */
> +	bool cp_use_lpbk_dqs;		/* bit [21] */
>  
>  	/* PHY_CTRL register fields */
>  	u32 cp_phony_dqs_timing;
> @@ -523,6 +529,12 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>  	if (phy->mode == MMC_TIMING_MMC_HS200)
>  		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>  
> +	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_read_dqs_delay >= 0)
> +		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay &
> +			SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY;

So here is unnecessarily assuming DT is providing a bad value.  It could just be:

	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_read_dqs_delay >= 0)
		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay;

> +
> +	phy->cp_use_lpbk_dqs = 1;
> +
>  	if (phy->sdhc_extended_rd_mode &&
>  	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
>  	     phy->mode == MMC_TIMING_MMC_DDR52))
> @@ -530,6 +542,18 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>  	else
>  		phy->cp_phony_dqs_timing = 0;
>  
> +	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_use_lpbk_dqs >= 0)
> +		phy->cp_use_lpbk_dqs = phy->ddr_use_lpbk_dqs &
> +			FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS);

Ditto

> +
> +	/*
> +	 * The phony DQS timing derived above depends on the board's SD flight
> +	 * time, so allow a DT override to re-position the fabricated strobe.
> +	 */
> +	if (phy->mode == MMC_TIMING_UHS_DDR50 && phy->ddr_phony_dqs_timing >= 0)
> +		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing &
> +			FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING);

Ditto

> +
>  	if (strobe_dat) {
>  		/* dqs loopback input via IO cell */
>  		hcsdclkadj += phy->iocell_input_delay;
> @@ -693,10 +717,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>  	sdhci_cdns6_dll_reset(priv, true);
>  
>  	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>  	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
>  	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
>  	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
> -	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
>  	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
>  	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
>  	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
> @@ -881,6 +906,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_cdns6_phy *phy;
>  	unsigned long val;
> +	u32 prop;
>  	int ret;
>  
>  	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> @@ -919,6 +945,50 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>  
>  	phy->delay_element_org = phy->delay_element;
>  
> +	/*
> +	 * Optional DDR50 read-path tuning. These are board/card-characterised
> +	 * values with no CMD19 tuning in DDR50; absence keeps the driver
> +	 * default (-1 => not overridden).
> +	 */
> +	phy->ddr_read_dqs_delay = -1;
> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-read-dqs-delay",
> +				  &prop)) {
> +		if (prop > SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY) {
> +			dev_warn(dev,
> +				 "cdns,ddr50-read-dqs-delay %u out of range, clamping to %lu\n",
> +				 prop,
> +				 (unsigned long)SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY);
> +			prop = SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY;
> +		}
> +		phy->ddr_read_dqs_delay = prop;
> +	}

If the unnecessary validation is dropped:

	phy->ddr_read_dqs_delay = -1;
	of_property_read_u32(dev->of_node, "cdns,ddr50-read-dqs-delay", &phy->ddr_read_dqs_delay);

etc

> +
> +	phy->ddr_use_lpbk_dqs = -1;
> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-use-lpbk-dqs",
> +				  &prop)) {
> +		if (prop > FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS)) {
> +			dev_warn(dev,
> +				 "cdns,ddr50-use-lpbk-dqs %u out of range, clamping to %lu\n",
> +				 prop,
> +				 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS));
> +			prop = FIELD_MAX(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS);
> +		}
> +		phy->ddr_use_lpbk_dqs = prop;
> +	}
> +
> +	phy->ddr_phony_dqs_timing = -1;
> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr50-phony-dqs-timing",
> +				  &prop)) {
> +		if (prop > FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING)) {
> +			dev_warn(dev,
> +				 "cdns,ddr50-phony-dqs-timing %u out of range, clamping to %lu\n",
> +				 prop,
> +				 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING));
> +			prop = FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING);
> +		}
> +		phy->ddr_phony_dqs_timing = prop;
> +	}
> +
>  	priv->phy = phy;
>  
>  	return 0;

