Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214B5FDA7;
	Mon, 18 Aug 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501969; cv=fail; b=Te+OYX3YcPlXA7IPsEI8pI+zFAqsfPfh/F+jcpmzPLzA+wtCLa4vj6phyVniL2bxnzg5eGBk0XrOGdXflc9q6ouL84ujxNYGO/62JRQJ9f9ZflbM+9t4g8nQLSTLNsKb9E/DXZ4mJ0Cfo0Qbh2Ony4f6RYzOa8m7nsYOuJ1Sjvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501969; c=relaxed/simple;
	bh=/GK8T69fSK2wb5NU2UpolVebdu50hb8Zc4i6Anl+/yI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=liZ50H3kilCsnllpX8WdIspdSHD9256iFXD9194P8mFhzYsaR03Xv095rkCqd7r++8Yh15voMXoxAFJNJGlRCOXaISR/nLpLfEJbLEeqGvIqm0HY5sdcKBcXBBhtTSEN3VS7S7YKodpe2fAt9VIZVQE38S5RSBr4f4CMMRBlSF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZSh9vyO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZSh9vyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755501969; x=1787037969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/GK8T69fSK2wb5NU2UpolVebdu50hb8Zc4i6Anl+/yI=;
  b=iZSh9vyO7MEn6/suyjIeVPPOajjwHQkB1FescFdyBN3i8vnyYtgl/yVT
   enIAfTjtUk/qCApMRl6bgXWFlJqVRI5y2HEmodMz2UXtyuBDP0CcFhqMF
   OMxvIsBb2PHrNo7ly24SOiYEAO0rBMr5WsEwnPFmFnxmsQLwuUvhYPonn
   DDRjmue5d8e0I8BUkq8ChTHGT/yNUyoLtICRUQe6zsxSbj/1bt2Fpzc7z
   MMu9UOyP6aq7TYH3hNsvABlBGWY/ZfPqjdcvJCRZQhAu325Ny71xNXe8+
   D7XapRd4ZW9bRr2pj9SYxlIrdU0LuIuMjklAQj0ipJnIOqiVwHI6a8zlw
   Q==;
X-CSE-ConnectionGUID: 8GMeqCFvTu6B0/1XBafsLw==
X-CSE-MsgGUID: wk71EH/1S9W3ggA6Ei7FhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57865292"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57865292"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 00:26:05 -0700
X-CSE-ConnectionGUID: WhXZZ8MNQ+iOrIwZNPJ4eQ==
X-CSE-MsgGUID: P1AzUshRRJuk6zNNspIWAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167856837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 00:26:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 00:26:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 00:26:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 00:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGjJceH75fZ8Z8IdkfvYHWokmtcD5KrIwrsUqpA2geE/o3rVTlkckDhdN79eKyDNevv4vB1F1qQ07E4g7SC2x2Ul82kN67qTCXURYYxqpwvH7OovqtO76AiS8WvmLXxPmFV0/IrpSrhnYBQEuyjiKDO4zKJ4/XiqaoMv7kpIJn2RMBYw0qG/PJfpM1b4Ab4SiTY39h+m704fxlcnoW95bzsFH4qP/zTOldn5Z1K/1AnTkvNdemGzy84WKiMPtG+rLFEAize4FW0lLInkQpzmU+m9jGcGkQOUbo6dyZpzl6+75E/Pgrgt5fHpp/YimciueEeobFcchZYhZlqNmgyZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbpNj2zBzOTQXKrgfFVAWp6YssvxQSDkJEBdiQn093U=;
 b=cVyc8iz3Gv4VvF6Oahp9jNbCSuIJi8wJshpN33qUpFbJe7ATiXssoyHyaEQVT3XUPLK70I099pq7Gb36EtWlFo2V09L36NrZ0H5gcybhRgHaq+qfaG0vWLB9hpcTUtBFsQeSUa3mlTzc0t3ejTZ3DiEF2Sct0wilE1wckL3AVJBObxEABOMKUbcZdrDZkNevz42xAIigqEykSgDcMdM8a/z1/YpP+H8rGs/jd9fXZWEuiHxYbKXqx90h8bvgTD9vh1z0mI0Utx5ZSRCWJUKG7wFQhZH1wN7kSTBasQAwm4SghBjKlGHaWrLXfjUnnISrJEJ+vL/tURbNP9/8qtXRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH3PPFFA27DACA6.namprd11.prod.outlook.com (2603:10b6:518:1::d63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 07:26:01 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 07:26:01 +0000
Message-ID: <7bddc691-df7a-430a-b7e7-01ad85c27cbe@intel.com>
Date: Mon, 18 Aug 2025 10:25:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl setting
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <phone-devel@vger.kernel.org>,
	<~postmarketos/upstreaming@lists.sr.ht>
References: <20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz>
 <20250806-pxav3-uhs-v3-2-2f03fee380b0@dujemihanovic.xyz>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250806-pxav3-uhs-v3-2-2f03fee380b0@dujemihanovic.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0051.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH3PPFFA27DACA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fff7b8f-80d0-43b8-096e-08ddde287b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnNSNXp0UDl0VURTcGhjMUNXMEpSa3gyM1hOUko1Q1hJNmxDVWI4Yk9RYlN4?=
 =?utf-8?B?NHBXZDZVbU9iamhXbVVGc08vNHdyenU1Q0dJd05HT01OaTJ4ZXBLQmNSOUsx?=
 =?utf-8?B?S2oyNnZ6WHRMckttb1ZpNEFhMk5QTmFsRlg4aklJSkJiUldBd25Tdzh2VmNQ?=
 =?utf-8?B?WEt2WXU3a2MyMXJSZjI1dlhQbnFiUTYvRmpqb0NVVjFCaDBVeGN3NlZ3eVFX?=
 =?utf-8?B?UTZ6NENZOENsRW5aUzdLQ2ZXRTF2Z25IVXZ5cEpVc1BuK3g0RjBRblR4b3A3?=
 =?utf-8?B?LzZIaGZLNG9SQlBYbkk5R2M3b3ZHdUVCb3IvbWxqV0JQelRMNXZ3ZzFtcCtr?=
 =?utf-8?B?MlhOaFhGZ2k5aGpKRUpTNlN0WFMzMlVJeUYzQ0RTY2xyTnZqTW5qaWxkcEt6?=
 =?utf-8?B?NjRPQ3NYTFdMQTNvSVBRWWRkdjR4THdnRFUwZ0pvWW9LL3Jxb3NGTkRFZFA5?=
 =?utf-8?B?NHc3V1ZiUkh6b05JYUFTQ1JlREU2aTZlV3F2UHVnYWZMRjR1dHhQWVpBem5B?=
 =?utf-8?B?cFRTbXdtZjZZUjhwem0zR0FuSkJJZVg0d1dQakwrbkhSVE9wbWFQY0dBNXNw?=
 =?utf-8?B?aFJVeXVRSW5nbWN3bzA3eWo5NzNSUDZ4MVNxNTRIUlJpQkZxcnFVMDFYaDRz?=
 =?utf-8?B?eUVaVXhsYzhUK1h3REt3RDd6R3NjUmkrK0oxTVl1YUdHRngvOG1aelBHaG5U?=
 =?utf-8?B?VUFIOHdYN2tOa0tNaTRaZmdRT21GS051SjdIbWIvZ0RIeUppWXA3Qm9uOXIw?=
 =?utf-8?B?YjJGMHpvZzlpdXFwS1F6TGpmM1BkOHV6VzhYdWJDN0JDMEh0bnZKd3l3Y3M0?=
 =?utf-8?B?N0VPZ1NQR3c5S1pNUDUza2xidGNUUU1Uc0lRdHl2UmZCZi9KQkoyamo4ZXU4?=
 =?utf-8?B?QkovaWxHT3kyRjViaHBybGZzL1EyTEI4UFBYdCs0dU1iZktxWm56bmw3WFpO?=
 =?utf-8?B?SlVnL3UyaTdSeVpRTTlVQXB3aUhCcDZMdGgrZUZCTFJDMzVtNkkyOGw1QVhN?=
 =?utf-8?B?Rzd4SFlhQ2lTNEdWRDJYYWRsZHUwakFtd0JzbTMyWkhtV0dTa0R1Y3psblpW?=
 =?utf-8?B?cWVxZU1GMEdoN2NHL0hDUmMzNUQ1RzdCUDdMaDFveGwzemJiMUIwQ1oxMVd4?=
 =?utf-8?B?akt2OGh5VGtyWHd5NEFDN1FaTW4xQmRZRFZiVmsxeThMRVprakFKMERRQnJL?=
 =?utf-8?B?dFU0VVRyQWplN3NvaVYvbEowbUJZdmlScVVMSjVYeDd1b2F1YWNKYmczRUNW?=
 =?utf-8?B?b2lYNVRsdjlQb1lMOCs0Z1RMSkNSbWVQKy9ONTFWeGMrVnI2VW84d0x1Mk1O?=
 =?utf-8?B?dHJER1U2Z0g5OCtwNUFzQVF1NW5IdENRSWlMYW9XeUtqSjJzNkU2Y1g1N3py?=
 =?utf-8?B?eE1tWU11bVFVRnEyTjBUZ3Zna1A4eC81cXVxWTBpRE9jcEhyNlYvM0RVdFJx?=
 =?utf-8?B?Qlp6WUMwZ2JsNWFIb09EQThlajMvZGxLc2xKRExlK3lhOWsxM3Q2QnNDZGRT?=
 =?utf-8?B?VHRrYjNxcjEwZ09RVkt6RUlReDFFY2ZGempkQmpZeEZjaVhUQ09HVUhNM2tC?=
 =?utf-8?B?enp1ZkNYaVd4TUdjbjJlMnptY1k2c0dFc0VUSlMzbkFLcTFLM2tUYTFQM2JF?=
 =?utf-8?B?RU9zc2N1cHZhUzJIQThSanZnYkxoZFB2dnFWYVNKdzVKdHJCZjh6RnV0K3Nq?=
 =?utf-8?B?eFV1SzBJV0YxNVN5VFpGeW1OVTE2MWpZSDFodi9uVXJHem54cDFqN3ZYTVQ4?=
 =?utf-8?B?ZzlIcm56aE1nN1ppZkR1SEwrL2piMVNqSWtqUDJrb1FuOVBWSHI1K3JkcEVB?=
 =?utf-8?B?S2dtZnJ3Wm56NkFQSkdYUUpiVnF6TFJZUTM0SEtXWkcyTzV2dExKdlA3YW5L?=
 =?utf-8?B?VktLR3lQOGJlcTkwZ3B3RWN6Ti84aUpFTTNkTnROYTFHaFkwUE80NWw0VDRm?=
 =?utf-8?Q?Rd4A/WEhWWQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBrUjlKZEdYa2l4SGNiL1BUb0pNaEkyY0ZUNkVjVitYZkIycFVhMDd0MVV6?=
 =?utf-8?B?aHpuck1xNFFJQU1aWkJ6WklpVVlyTFNxZWJWbWZQRm1MYkZtbFc0WDdPVlRr?=
 =?utf-8?B?OW9La201RXJEd3lPNFVSMUI4bmU4Z1BmejhZdDhRVGpDbWNVTmpGTUQ2a2J3?=
 =?utf-8?B?dWIxQ09lMTBLVmpneDU0TG50N2sxYjB2bG5kUklKM1dvL2FLM2lBaUJWeUI2?=
 =?utf-8?B?RDdoZDBqcFBvR1BndkZka0ltVmJZRkNKTzFMVzVjODIyTTJKZXB1dFJuR3VH?=
 =?utf-8?B?cC9zSzcrMWN1WEs0Zll4bkRXUnJPMEIrRGxKbE9BT2NBVnRqNWxycnNldFlX?=
 =?utf-8?B?ZkJZUDRJNUxiRHE0SFBiakQyR3ExMnhMaVdFVHJCWkZ4ck8vUkxoYTZQNFd1?=
 =?utf-8?B?THJsaWJOMnViMnhka0lHdE9IRnpKTGV0ODg5ak91MmxoQjd1NzBOcVNsY0Vj?=
 =?utf-8?B?TWhEWHZVam1xekVrSjIxZjVsY1dkQmZ2SmNVc1dZRzhNTGZMMGpxeWFXZEx2?=
 =?utf-8?B?Q1YzK0FzR2JUalJPK2pCNGV6bCtwSnV1dlBmM2krcklvaWRjMmlVeUgzeWJw?=
 =?utf-8?B?QWJxU1g0T2Nvb2pjL3pBOGRzV05kSXNkejVvQ2NuUEx3RmRaZ2c3eFoxL1lU?=
 =?utf-8?B?czdIV3Vtd1I2bU16WVcrYi9Ea0p3bUpkV3ZLTGdoclpxWnN5akJCUW9TNXNB?=
 =?utf-8?B?N2x2N1Z4bTJBSUlReVprc3M1Nml4QWQ1V1FKZTdmaythSHBmcU5RNVlxWDdJ?=
 =?utf-8?B?MlAvdjFZTjR3RnNzM0RLbmZmSTdYdlppTFNTMS9tc2FlR3lQQmZjVWR4NUFo?=
 =?utf-8?B?TTJnUlY0a21DMWtaK2oyaWhYck9YRWlTOVZDSEhGMDR3Z0JvUVJ3REY2Rkt4?=
 =?utf-8?B?aDhIc3VZM0ZrTHkxZEJsWTE2QXpSWHY5MkpjN2ZhTzkrWU9zVnNOeE5LRTdh?=
 =?utf-8?B?VVoyNmo5SXVYM2h0NHdhRkVCTG1nZmFYcDd5TUduYXByZmtEUFduVHRFNWNB?=
 =?utf-8?B?bU9lWjRnTzE0U0FyWjB1SjB6RmNOa0ZMMTdjekFyTnp1RXpFWHdjZmtLY2Jr?=
 =?utf-8?B?STBBTGI5bHNSUzVxcTdjV1Q2UkNiR2t3VkttZ2FUd0Iwa25XeS85QUhJditS?=
 =?utf-8?B?TWcyeXB6S1htVUJFR0NMek9CUGZsaFk1cWZpM0prbUpWSVdZNWtRSk5TOVpV?=
 =?utf-8?B?bXo1ZEw5SVNBSDAraVd3UGtzRzdJTVdIRmVOa0MxZE8vTkY2d1BXOXMvZnhS?=
 =?utf-8?B?R1VvdjVYd29naHpzSjh6bmgxNUQ2QTVoS0FPVmJBb3gxb3NQTzQ0K3NaYkNy?=
 =?utf-8?B?K1ROd1VlZWhoUTVFejd6NytJZERYZ3ZQSnJUQjh5ZjZUa2d6K2ZraFZsSjlB?=
 =?utf-8?B?YWh5cnBnb21WSk9hWUhFbW9HbWxkMVVBQVZZQ1QyUW1CUUdtekhXNFQySzg1?=
 =?utf-8?B?MVV0OGF5dmNDQTgveUNwTkxVS2c2QnpsV3N1eFF3SDlXc2lMQWlGWk9nbVJw?=
 =?utf-8?B?Z3N3T3k5eXN1L1RpcytvWW5HbFIxc04vM2RHZ0VjMkR4ZGJnZEU4Qk5VdndW?=
 =?utf-8?B?OHFVZG5VbzdoRGp1aTVveHA2cFh6YVlna1BvMXF1ZDByUW5WNkVRb1dMVEk3?=
 =?utf-8?B?ZUpFZlhGbnJ5K2I4KzFXRkNRbkozV1owaTdrSHl2TlVyRGRRNFhGdkEwTXNo?=
 =?utf-8?B?cTVPODU1VHRQQ2JaYVVJQ0ZsY29iUGx5aXlqV0N5YlRLQlZlOFJpVHZCL2Vi?=
 =?utf-8?B?aUZibnVIS1FlZDJjTjQzdytEYi9PYTV2QVI0cStpRWlvYm5qL2ZTcjFVRWJE?=
 =?utf-8?B?TW5xTWFrMlhqTUh5OVVYM0VXanhsNnpqSWx0MDA2N3RpeFJ2b0YwWkdoUURI?=
 =?utf-8?B?NmJPdHZQeEpuSC8wODUrRURPbDJXcm01MkR1M3BFbU8rYTNyWUJqYm8wM1pC?=
 =?utf-8?B?TWhxSmhLdWNmUUR2R2xTN213blczd3dLU1o1VEJqc3BHWFYyR0FIWXR5NGJ0?=
 =?utf-8?B?cXRzYWdlVzJ3cWVQT3crWEhtSnJIRzRDQ2tnMC9jZjQzVi96d2NjUmx1c0xB?=
 =?utf-8?B?eGlkQ21RbGdGYU1TQUllOEFWN0FyM0VpY3hGalNmaDc0cE42UVBMRU1jS0VU?=
 =?utf-8?B?QXdCSEpNSWgreTUyWWhCTURsWEdkMDZ2UUZ3K2l2ZGZCQTZVRjJWZzkzRG5W?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff7b8f-80d0-43b8-096e-08ddde287b93
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:26:01.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqIsHCDf5rG3LwPa+fI4/QULLc3JcXRNps9Mzskz1EnJLmC+mLTn/qUc+IE9AEx3M45s+qC5JMJrExKZFmncsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFFA27DACA6
X-OriginatorOrg: intel.com

On 06/08/2025 12:43, Duje Mihanović wrote:
> Different bus clocks require different pinctrl states to remain stable.
> Add support for selecting between a default and UHS state according to
> the bus clock.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>

One minor cosmetic issue below.  Address that and add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v3:
> - Move pinctrl stuff out of platdata
> - Add helper for pinstate lookup
> - Thanks to Adrian for the suggestions
> 
> Changes in v2:
> - Don't attempt to lookup pinstates if getting pinctrl fails
> - Only select pinstates if both of them are valid
> - dev_warn() -> dev_dbg()
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3fb56face3d81259b693c8569682d05c95be2880..ceb06f1c18146eac296c6d20483a9f006567a978 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -20,9 +20,11 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mbus.h>
> +#include <linux/units.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -51,6 +53,9 @@ struct sdhci_pxa {
>  	struct clk *clk_io;
>  	u8	power_mode;
>  	void __iomem *sdio3_conf_reg;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_default;
> +	struct pinctrl_state *pins_uhs;
>  };
>  
>  /*
> @@ -313,8 +318,20 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  }
>  
> +static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *phost = sdhci_priv(host);
> +	struct sdhci_pxa *pxa = sdhci_pltfm_priv(phost);
> +	struct pinctrl_state *pins = clock < 100 * HZ_PER_MHZ ? pxa->pins_default : pxa->pins_uhs;
> +
> +	if (pins)
> +		pinctrl_select_state(pxa->pinctrl, pins);
> +
> +	sdhci_set_clock(host, clock);
> +}
> +
>  static const struct sdhci_ops pxav3_sdhci_ops = {
> -	.set_clock = sdhci_set_clock,
> +	.set_clock = pxav3_set_clock,
>  	.set_power = pxav3_set_power,
>  	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -366,6 +383,19 @@ static inline struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
>  }
>  #endif
>  
> +static struct pinctrl_state *pxav3_lookup_pinstate(struct device *dev, struct pinctrl *pinctrl,
> +						   const char *name)
> +{
> +	struct pinctrl_state *pins = pinctrl_lookup_state(pinctrl, name);
> +
> +	if (IS_ERR(pins)) {
> +		dev_dbg(dev, "could not get pinstate '%s': %ld\n", name, PTR_ERR(pins));
> +		return NULL;
> +	}
> +
> +	return pins;
> +}
> +
>  static int sdhci_pxav3_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -441,6 +471,14 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  			host->mmc->pm_caps |= pdata->pm_caps;
>  	}
>  
> +	pxa->pinctrl = devm_pinctrl_get(dev);
> +	if (!IS_ERR(pxa->pinctrl)) {
> +		pxa->pins_default = pxav3_lookup_pinstate(dev, pxa->pinctrl, "default");
> +		if (pxa->pins_default)
> +			pxa->pins_uhs = pxav3_lookup_pinstate(dev, pxa->pinctrl, "state_uhs");
> +	} else
> +		dev_dbg(dev, "could not get pinctrl handle: %ld\n", PTR_ERR(pxa->pinctrl));

Kernel style is to have braces here.  ./scripts/checkpatch.pl --strict
can tell about that kind of thing:

CHECK: braces {} should be used on all arms of this statement
#92: FILE: drivers/mmc/host/sdhci-pxav3.c:474:
+       if (!IS_ERR(pxa->pinctrl)) {
[...]
+       } else
[...]

CHECK: Unbalanced braces around else statement
#96: FILE: drivers/mmc/host/sdhci-pxav3.c:478:
+       } else


> +
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
> 

