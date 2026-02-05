Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022104.outbound.protection.outlook.com [52.101.53.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B262D4B40;
	Thu,  5 Feb 2026 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262701; cv=fail; b=T3FKBbULUcGi1e6Cxgl5VAKOJRiPOIsEk1Atod2Sz5zG+IeVhPLKcIBQSHLgNE1NWHCytY3RF6uz+kohq/0V8YateRmv1lVahxEPeS9ZmEUVFJI14LO0XGQWPMx9S//SaaarGfMfbky1N1d8soCNuY3XGEV/V4b4wtrP0b5daAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262701; c=relaxed/simple;
	bh=yaLOcLn2pbL9paIzypi541q3I7s8YqGZY4OPqQZVHZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n5lKM5fU5WvipFZhjTNmzknjtBNUfGos0W6bYDp7gRQDqscJpxHSoYJV3doLfRvkKIWDsgzDpATQMyJ5ISHl18DSHHxEdgkYpT2bvHikGAHYxGqQD5evKYolYxdZy2jtB9FWWOvutyXiq1zokmPnzOu3Q2T74cyRVxts+YbPmn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ALDnATp+; arc=fail smtp.client-ip=52.101.53.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ALDnATp+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skE6QFfaJXeT0Nbac8bj2ZbMxWxZOpkX1ShwKLjY3OEdQG5P1BgiwXE4PkkYCmwXVeIQ67KZc6ixBAJoeUtDziMT4KHocjLK54Wk4gwTJ19m9yeJtrLSTvbl1lLW2RKgPsiDV0cmc5BLe/THsoEoJWYtvC7Fyn7/dSXESRWrO0WMX52HLyYAyUuu63QPheivFLVX8g1xFe+jqJwEfJOsdqk9F0rj4GPrXJpHuf/zJFAQS489ONTDmbn2hjp3BZiAI2P5myHY5f31Ijpq0azXChZEdePxHBNCxBCAILRaBGzAbBdUFMQ7+uzDHV6hCQLKNgdFJ5x8f+CRoX+KcSIm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQPmuza4py+oLcC0ZII674CF2q8bOpQP6ySGIs+mKhk=;
 b=SgzdlENaFVoKzFD9GE1b6n/xch2lei0Aku4dC4T5PPo7x9zwJRS+xTAkcfZacu7DCkMVQpro6HCBonRhAWv6yAYsD4bzTZ4QgPt9o+tIhRydRVHPmU4Q11Oar5/8vt8iaBg9WrHMSwGd/Cl9yoZb+D6B/Os9FCqNNMd2/V5Duf3YM5z3CutMpQEKazZJQwvnRVZMCAd4fv2E8RsjuFvhqO2qIJ+XZP5FnVeuao0DBpSzHJUPUX/bwRSdTuakzbJOPhEPqG1Z4bt8yXpd3UsD7KGsvzX6YY6jwgwRSJza8wMFmSXW5Y5N9ipFWCtDWyahq+/ax2iT5AAd00TZ7AeHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQPmuza4py+oLcC0ZII674CF2q8bOpQP6ySGIs+mKhk=;
 b=ALDnATp+speljUC3RdzuWcAB0Fo0oLA76rs4Ir98NUlZHmVSvmTDNmCQgdxocNQAFAMulBMov7+mBd6/pJHm2ke30v3LGEE2TLoNxOA+5JER9J8VwflcBZPeVY5Bou3daCSqOQfrH35BPF+fhdI6dI3pYQsb7XEXgTn/mjlk2/6KkHDu4dbnBzgPbxhQQ5kNbhBd+Sa94qj18B7x3OsmYq9cMrZH3fPeSa2ELxoQsMTaktiqExrRy3IKQrK+cV7Cdj1NAa3sx9bjPZYhD1tzV1OQ3BvAO5sEN6VVmIiMTzH6dCp+QSycu0hQVGmxSfeZLAS8NRGdUZCBMlET7m8yZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SA3PR18MB5391.namprd18.prod.outlook.com (2603:10b6:806:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 03:38:19 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 03:38:19 +0000
Message-ID: <be71d1c9-3790-4c58-8c0a-5bd0d0803f24@axiado.com>
Date: Thu, 5 Feb 2026 11:38:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado
 eMMC PHY document
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>
 <20251223-nondescript-horned-mouflon-36ba75@quoll>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20251223-nondescript-horned-mouflon-36ba75@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To PH0PR18MB4558.namprd18.prod.outlook.com
 (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SA3PR18MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: cb31a59d-943c-44e0-860f-08de646800f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|42112799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGlQaFFETm45L1BOeHdobU9iZ29xQkFxcEY4aTUvRjdUOXpSVGpsVUhDUWE5?=
 =?utf-8?B?OG9GZnVVUU5YdXdsZWl5K004ZUpHRGltMmFjRUlhKzUzWGU2dUZuN0F4enF3?=
 =?utf-8?B?VDVkS2Z5eUR0d3FVQ05veHZ4ZWxsdFk2dmg2Vk5LcXU2ZDBJdnYwelBrNlNL?=
 =?utf-8?B?YlNvb21PcHpJWitxYjlqMFlLTWZSczdXMkViUnB6YlBrRUtMM1VpWE9SK1hU?=
 =?utf-8?B?d0gyODROdWtLaUR6aUplVHNNSUdIUm5VY2M3OStJT2oyUHNwazg5b3hRTXk4?=
 =?utf-8?B?SnQrdlpMUUxBMDJuc0laODQzKzdDeFVlVFVXaC9CNk5EWE5YNCt0aHROaXlU?=
 =?utf-8?B?c1U5SXFCZ1R1WE43V1Iwdkc0aFAyWE1vTDdpNXU2YmVFblRuVzhTdG9VMUdw?=
 =?utf-8?B?bm1rdDF4a2pFOGNMVUJsYmM0NjVFU1pFZURRQlU1N3ovYlhCMDRyRnVvMWxR?=
 =?utf-8?B?dkQ1aFZyYjRldW8xc0ZCK1gvSEx4L2Rjd0VMcDJYOFpJbzFVVzROYTV4aUtO?=
 =?utf-8?B?RzlBTEJJd1k3SXFBTTdFdXRRYkhwcmd2dk95UmZScWpvRFdNdDVVTTZkMnhE?=
 =?utf-8?B?QkdibjlCSTY4WXdJNlo1bDFETUlMMklLVkpGakswRTZrYzBjSUhVblovY2NN?=
 =?utf-8?B?K0VEUEwzMjVmVzlidmlXNjQ2MnhOYmtkQ2lBcjRWb0FhZ0dDVSt2U3ErT2FG?=
 =?utf-8?B?OGc3MnFndnFaY21ITGN0QTVJVjdZT2ZXKzkzQ3BtWGJkbGc2TW4rUmpyWUN5?=
 =?utf-8?B?d1k0SmU2MVB2aGdTNEtNL3FIQW1wY1RPL085eFdhT0I5YVFlQWV5OHk0RGt1?=
 =?utf-8?B?dlU0WHNxWG82UEl3UkwvUktka21mSEdvMnRqQllQT1VsVytSb2YyT29UdHp1?=
 =?utf-8?B?VTVBVkxQQ1VndUF2N2RyNEtpMzd6Q0dDc3hNVTFRaTlpL0VwOHpHR3hjNVhK?=
 =?utf-8?B?a3JqYWxleEJvWWkwL1lKOHFSOWFhYjFKNFZQdm1YLzNkV0hmYTZoUkN3Vnk5?=
 =?utf-8?B?eGZMTmJuV2lNL2pWZ09Gc1lBRTdSbWtuSXVoWFNBSnNKb1NXTHZlWDZraktK?=
 =?utf-8?B?dkRKTTMzN2o3bHJBYmFwWEtwYXFLZklrYTIra2g2YUNQai9raXJzLzI2Q0cv?=
 =?utf-8?B?R1JjcHd1UlIyQjRrRXNzQ3IvOTgwbTNTQkc3Kzh5NllOR1diczYwcUlKWXMw?=
 =?utf-8?B?MEp6RW5NRWdLNGJSMHVndk53RFZveGJGSW5WTnFhS0hZMEVxdTJMc0RXZzRZ?=
 =?utf-8?B?TEttZ3dCSk9YdkFEZnlRdzlRRFpwWDdMbnZNNzhzNFhySUowVnZTcThMVUh3?=
 =?utf-8?B?ZHRPYUVQb0xlMnlIQlNaR25vVXVuTFJaZ0lrZ2xjZUZLWStxNUNwUVZidjVG?=
 =?utf-8?B?TzZSbnFKTUpsVGczQitQYmRGeEh4Q0xtVDBhKzBMeElQd2RDNkt4clJmcFlI?=
 =?utf-8?B?ZjVmNko3SkNDU2R2K2lqV0dwQzlXZC9OckhpaW9PTEMxM0lIdDhER1B5eE1Q?=
 =?utf-8?B?TnlKdjVsaHY5NUZqeGgzelRTZGZrSEhJdWRJdjJaZUVrcG5Sd3VtaExIcnEr?=
 =?utf-8?B?YVMzU1RWbFVpVkxxWHhBREZGVnlYTlAvbTRJcFg5TEw0aEJSL3padDN5NEF4?=
 =?utf-8?B?MGE5ZGRHZnFlV0l2cVo4QVYzZkozRzhIMk0vQVJrMVR6MDZBSWZOa3BwenBr?=
 =?utf-8?B?QlpPRTB2YjN5dmlrNTRIY0NObHFCeVpINTFINVBYdGN4bFVHZVFCc3BsdEZh?=
 =?utf-8?B?eFk0c3UvMEhvdlFBcDZEOFlTM2l1ZVNBbFNVYkRGUlR0bzZjY085QzhzYWlX?=
 =?utf-8?B?alN3NlV6NytOVUszSEhqeG9oRHNyNFcxV29OUU1XZk9CWTcrejBmR040MUYr?=
 =?utf-8?B?MkZUSWc3RDNUOVllZXlPUHZ6UFNpUURLUFppakFPMGlzWXcvS2FGTjloUzZR?=
 =?utf-8?B?VXJDRXVMRzQ2bkdnNnRBVW1CcTg0bklacmhaVWM1V2hQd2pXRHdwWUNIUElx?=
 =?utf-8?B?ZVU4QThIaUVDQVZNdk94WEhSd1g4aGtKWU5zUDBoQlZ3MlhPYTk0YksxdURQ?=
 =?utf-8?B?ODhzSUx0bU5sMXAzckg0Rnk5WlV6UlhHZ3BnUnVvaTY2RldsUCs2dXJrQUdN?=
 =?utf-8?Q?iIfJ/DVnZozXKs+p7uI2gkD8k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmhUdDNUZFBCNEhCRy9KbE95R1JPWDVXNVZ6a2NXa21ab3hGWmFvaHY3ckkz?=
 =?utf-8?B?ek96TXBkWmoyaDJuSittK1l1SnEwOW5KSHozNnpNaCs5Y3RSUWQydkVIVzlH?=
 =?utf-8?B?NkNUNHkrVmlwTjNGZDNtUVRJMVpGbFovRDhqNm9Cem1ZME9yVGlaWmxzemxk?=
 =?utf-8?B?TEhZS2U0MXZVczAvVVAyYUNPZHJ5S3NpSmRFYzZvSDZsQWVBS3F6SFpYSDdN?=
 =?utf-8?B?RytwMkQwZ2pVQSt1Q2VRMFdGOHlEVUcrNFdHMzhmbnFMcS9NNTNDeXVRVFlw?=
 =?utf-8?B?b3pBRmJlSHU0WFZkK05Rc2hVL0VhcCtSVGFlT3h4d2I3UU5NaHVEbGNaeDd0?=
 =?utf-8?B?YndndEtkT3k5YUdnaEJuTnUvWmZ5OHdBeHJ2WnVVNkhsS3NkM0hTeThuS290?=
 =?utf-8?B?WkVYTkVGVlcvcitJdWZaZ01QWmErY1VjNmgxVFczNmkrMTIxMXg2MUtCS2Q5?=
 =?utf-8?B?dnkvUkt3Y0ozZ3NlazM0VUw1RGM4ek5lYUFHRk5XR2Y2TzJvUjVjTThZZmZT?=
 =?utf-8?B?UHYzUGhUNjl1Z3c4Yzg4K0dRM2UrNjE0b0lHYkRyK0cweEVDbmlvNklxdFE5?=
 =?utf-8?B?Qkw2SVZ0WU9sTzNaTFJQS1lYVlZPRTdmT1BPaWxVNXNQVmtDbjNhL25GVzZG?=
 =?utf-8?B?WHJKeVBBaVNKUWp5M1MvRHQzbkhRQjBPTU51bE9xaXhoUFNJVWpvYnZ1aEVj?=
 =?utf-8?B?MkFxQy83Qmlaa0Jxb3dGWXNUbkFrTkFYa3NhQzJVKzdkdWVTU0lkSHVPMks4?=
 =?utf-8?B?aE1rUE1mVzVzb3BmTndvNVNTZlNlUzRiaHdLNjNlY3ZGZkJEWFUwbzBuaG5W?=
 =?utf-8?B?ZEdubHJ0elU4ai92c3FuV1JxWHNmY0VMbFVBTTNBaFNBMFRiT1o0ekpJajAy?=
 =?utf-8?B?Q1FFMW1XbjFXMWxlUklWMVpIOTFwR2p3amxKRGNwclk5ZUJ3TTlDbXU5cFdH?=
 =?utf-8?B?TmtGUUI4VFRvOStocWhnUldlV1ZOWUR6ekJzeG5KdzIxL09OVS96RFdYVFdV?=
 =?utf-8?B?cGpPcG8ya3NNNVpoY0V6Wm8xSXZYNXdWbTdKOVEwRXNxTTlGbnRQRjl5dkdx?=
 =?utf-8?B?eDhWcmtDeHJCY0xUM3RGQXB5eTk5aVdTaVNqNlkvTGxUbk42d0QwekdRVDVJ?=
 =?utf-8?B?dXVINnUyUC9IV3ZhOVh6cE54QXFsY0NsRUN6K2FXQXpubVg3OGgzN0V2SW9w?=
 =?utf-8?B?RVBVUlgxd2dRNCt3UnhSa1p0ZVpDbUZOQlhqVHIvWW1uT2dwb0RQck9QZm94?=
 =?utf-8?B?R3R0dlB1UEFZbk1XdnFXekQ1czYyZ3JRRjc3UmhTS0dMYjgvZCtxZzlQUzNI?=
 =?utf-8?B?UithN2lsRktFV3RIOVZDNFF5NSs4aUhkbk0yUWtMOTlnTG9NckVNZ3N6eW1a?=
 =?utf-8?B?SUx6Y2tOYm9xZFhnMElUb09OQW81UmhOYXRTT3drSHYrUFgvMnJhd2dEYWtr?=
 =?utf-8?B?cElPcmdjWVk5M3psY2pHT0pyWGpFZ1gxcVYyOXBuNC9PeTZDZ1gxNDJSRzhN?=
 =?utf-8?B?c1lma1RPN0xwd21VMjNpRHloNlZSK0lpL25zb3VHQkNsSmFlZzc3OWFPUlJo?=
 =?utf-8?B?Y3BmTVgvRGhhdndpYVRkcmNOK0dOWVpXTGtHM0ZIeDY0STY3N3NXWTNKczdY?=
 =?utf-8?B?bHdQdkowZFdFVFZtR1J0MEVkSGVqWkovK1NOQzR6Wjlndm9RbFB6SnVjQUN0?=
 =?utf-8?B?QjR0TGdmZE5EKzFhMlV2bmVNVVRoYm1hem54QThLTEFSTDBrUVRZTHVaYmdz?=
 =?utf-8?B?VVJxaXJGdmh2N3hZakowMjJhWEZRRXJ1MlNBWWZWd2k3aEJ0T3hCZWM5U01m?=
 =?utf-8?B?V2VLOXNMejRnempoSkNETkVEVS81QXROd0FKZ05ndUt0Q0lZMC9GRTdIUHRy?=
 =?utf-8?B?K1ZFS0VxTzE5VkxZMGJqYlhSaUxXSEhUbzNoSk14bS9McHp6Z09SejdtQnNH?=
 =?utf-8?B?OFMxYmhScWhkYmQwaHpuMG8rZzVQczZCbEl0bE5RL2JBQUhlaHVNNmtlcWRp?=
 =?utf-8?B?ZVpIUTloRWtPd0lUUGJSZk45VTVaZndzNnUxZjRBbGxnOVNvTENDTWMzWTRF?=
 =?utf-8?B?YnYveWdxREhDU3F0OFA5amw3a2Z6dzhaRmN5aTBjWHhwQjREcytTTmQ2Q1R2?=
 =?utf-8?B?S3JQajNIeW43SUdzTE5abEcvTno4Nzl3Y0JWcnNuY2xLSEFickVYMmkvdU9i?=
 =?utf-8?B?LzNzOGRjamNKTWFodEFkdUM0d0d4U2JoSjdtU1Z2MTdVL0dXY1I3ejlSaW96?=
 =?utf-8?B?Wk4zSFpNeTJQcld1Z2F4aDB3SldBZlhlOEdFaGRZZHpacFo0cjlXaW0xdDVX?=
 =?utf-8?B?TmN6dW9QU0FFRVpRbzZaWENrNzJGSEZrRGFPWFZNVHpRWFpFUnpVUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb31a59d-943c-44e0-860f-08de646800f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 03:38:19.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ1FjKq/dU5hchlxH8Swk9XLn68gn0H13LtRbRCjixNEHPCPlAJSl6tmpEQedMAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5391

On 12/23/2025 10:23 PM, Krzysztof Kozlowski wrote:
> On Mon, Dec 22, 2025 at 04:45:00PM +0800, Tzu-Hao Wei wrote:
>> From: SriNavmani A <srinavmani@axiado.com>
>>
>> Add device tree bindings for the Axiado AX3000 eMMC PHY. The bindings
>> define the required properties for configuring the external Arasan
>> eMMC PHY, including register base addresses and clock references
>> needed for HS200 mode operation.
> 
> Do not say what the bindings are supposed to do. We can read the diff.
> Explain the hardware.
> 
Simplified the messages in the new patch.

>>
>> Signed-off-by: SriNavmani A <srinavmani@axiado.com>
>> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
>> ---
>>  .../bindings/phy/axiado,ax3000-emmc-phy.yaml       | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..f88941ce60cbd99a73e8c504e0bf36c626bbf674
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/axiado,ax3000-emmc-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Axiado AX3000 Arasan eMMC PHY
>> +
>> +maintainers:
>> +  - SriNavmani A <srinavmani@axiado.com>
>> +  - Tzu-Hao Wei <twei@axiado.com>
>> +  - Prasad Bolisetty <pbolisetty@axiado.com>
>> +
>> +description: |+
>> +  Bindings for eMMC PHY on Axiado AX3000 SoC.
> 
> Irrelevant
> 
Removed.

>> +
>> +  - compatible:         Should be one of the following:
>> +                        "axiado,ax3000-emmc-phy"
>> +  - reg:
>> +      maxItems: 1
> 
> Entire description is not correct. Do you see any file written like
> this/
> 
Revised. It can pass DT_SCHEMA_CHECK and CHECK_DTBS now.

>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - axiado,ax3000-emmc-phy
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - reg
> 
> Wrong order, use the same as in properties.
> 
Fixed.

>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    emmc_phy: emmc-phy@80801C00 {
> 
> Drop label and node is just phy@
> 
> Also, use lowercase hex everywhere.
> 
> Read DTS coding style - Axiado already received this feedback, so you
> should follow it in all your submissions.
> 
> Best regards,
> Krzysztof
> 
Dropped label, used lowercase hex.

Thanks for your feedback.
We will follow the style in the future.

Best regards,
TH

