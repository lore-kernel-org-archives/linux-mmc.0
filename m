Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334B3ACA77;
	Mon, 23 Mar 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272839; cv=fail; b=d0sODmW8b+MuE5NYXAsRb6tZGSoEkrLC81JKOHzii79dyBBulibS4D2stDWrTImRNhUQGeswH24UHs0tGFHmF78g+tnOlmbbM/ElJZyS3Q1owILFj9YrW3DmHoPxkfHz6etd8k9vgrCspeniisxWg1lAr1BVCp3ZN94TivO/tyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272839; c=relaxed/simple;
	bh=ygRXMPNI7Rjp3g8hLEoIc33cuV98oJZB2ImcFVnVV0A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JN5Aq9OpTQ3BwhbbhQuFXkzz0w4n6zYLCQ8gfbX5Zioh5T+0K+GoPxFKWoZq5hL8wVWdfoYikzmvL2c8Dz9DsVKxLcCJc/6vAEJ6eefxQzE1yIVOls0deDjVRXe7t3a44UB7/sr74ECoTuPPLsGaGxkVb8TktlbQnEmg0bYOxKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgyrNHXC; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgyrNHXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774272838; x=1805808838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygRXMPNI7Rjp3g8hLEoIc33cuV98oJZB2ImcFVnVV0A=;
  b=BgyrNHXC28dFqbcmQvO6WaKPt+lEmF8A/JvwDt86zfvT7zlOqFpusIFW
   4gNFqzLD5S7+O96Gl8STRKJ5MNmdJeWaoygVbMybixzqOF2RsI4lZHXNr
   uf5szQOo13LJ9Re+2lkHqYvpvFiKRxBgzp1MX+Tst/xQtOy3VZxXVmFhp
   ehQijems+mBkFDm9u+p0BvmoYuR6F/JOBY6itJsaa5/tkb3d11PmrHOl8
   2e9+9CF63PLc9Pqb9pX0IoyVJe7f5pBHb/nspJ/op0XM9niIFbgbQiuYo
   KJYe/O4hsqiuv1GMEvz4F9OD1hvdBkVsaODomvfjeKv7myYukz/l7t85Q
   w==;
X-CSE-ConnectionGUID: ksdrtdDoTGWCjxGplEVtuQ==
X-CSE-MsgGUID: vUUU9WuwTLq+qXVZqf6D/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75240236"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75240236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:33:57 -0700
X-CSE-ConnectionGUID: xGZWNajCTrGzT46QpDaEZQ==
X-CSE-MsgGUID: 4EEBf3KeRZyCHvjTC2djJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224243220"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:33:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 06:33:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 06:33:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 06:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KANjVXkeg78sCXkXtXQ03Y7UzVrriLx2XW/1Ww8bgxlDbx6Mu6JNnMe+++nokgV66sXejJ689AT8NoTSu/Y3iRp1ERNM4a23cNMMqUknMH8zd/AWgrlI6xdYwTybgoxzKyyjmz4Owqi2UEdCz7qXL/YSnujbkdioZxd+w/65a860UEVnanVnOnH6PzZB7ik5sYiMoR1ReLos00A0153lcAgpq4jwAE3dCPIourSChPmxqaSnXGsH63Js40YnEDxvh0J++bCE14wn13zuoWAV1V+OV0O52u4zYp/y1VGWdZoUuKpGeUhO1rBxAMEksG+mSET1OYhCmh05OUJM0JghBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiFNqkbATrvOYmK6fhb4vVLx2Sf9B9YrcUlITHTmDS4=;
 b=hCmi3ZCUMCFGH/OBsR/tm8aV9WWmYwXFYhnvbcJ81jibfB+Rv+Og6pcLiN3sXZt8q9MIHzrCOqTrZ2ieCsaEzmT3AJA5VYkFCwU9ICSJmgg3wZpL2Lv+mIvy4lveDevFOISHStzwG7A4eXaaEiRjSQlOme7xk0MiZDkiIKQWl61s2QB2fK4P8MAJYir9EJOd1pFQVuZgZ99kz4cwKrOFxPUTYaNg+vrnBAo+dGftHajBFEBjaI0iezHNZjT7qkYN/Iz2gOhhvO+OdJ4zEtCvEFBQyYbiHYqLeMXPDS1X6zBOamPt0GR0tDTX86O6VFjcpTgltMyB1/BRjaFyF18Scw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW4PR11MB7008.namprd11.prod.outlook.com (2603:10b6:303:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 13:33:52 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:33:51 +0000
Message-ID: <3be1a7b7-751d-4c75-828d-62dd0c2bd180@intel.com>
Date: Mon, 23 Mar 2026 15:33:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-aspeed: Handle optional controller
 reset
To: Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ulf Hansson <ulf.hansson@linaro.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen
	<ryanchen.aspeed@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
 <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::25) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW4PR11MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5d96b7-7cbe-4af4-6bde-08de88e0d19a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fRdTnAP7+45Z56FRHip/kGCbvn9i+9xh47G+3Vuy4BYKshHIoY82JhXtLfuMqgTzw0ciQcR78JOjb2dS4bhOiIRxzc2dUbAYTX3hfNoD7oTtV0kTPzxWJt0qiEXN0BW9qjOkK5UDlZwM3Scn7L8a9+bjbo3TUPf9NCFQvhCO56TFG8uPnWe1vtjvzeIihinZy/SlOB1DaILp0swZfUAPgMX1R7ycWTih2q5UMZgsShYAJNkhXhGHhpvuZbd50kQItIR8fDzuR/wuJhFicylIhfSajRhXFh8EfP02Wf+iOXA5ZFrZT7u2kBKdjfD+nTgT+Qgs+77GfbhnF2bXFFT+T4tr6NaBqqtCWJNUt5Y0XY2fF8SxgaYI4KvIZJlHlqu1T04CWod7r9aKQ5wfocy3SjyOKCbE5QSoAzm8tlVbXaR0wBL3xHN4LLNtQWTrK/8nzCQCWcelnOpNXougxUBCtRGDB0yOOQcJtgRDpFebVWsCYfV0x39BtXiOkKIR57h6nzkJ3fRTgyUwPqCrRIvEtEkYdppeOp0iZYFPrtXu17B3WUzVv6sVAGS1q6Kz7sGvuIeZlWgODnftbhupO5FjBmY7q4NnEVPEyN0T9MkgdxiLka20uqlvNo06DR1IWkr+No/BiOfCMpOUtdT/LmqdVToXoOQKuhE/RBXbSGTBkL34/OAbhaeeIqr6bE0ojlFeUj4RGI3p1ZgsXEebvVxiSvIVPR+V3D2636aAJ7guxvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHlNOWxJOUlLOG1QU2pGMzN3QVdvNE4rRCsxck92OFlWM3JXTkx5b2RZWTlq?=
 =?utf-8?B?ZHBYaGNJQkJZVkRnQUQ2dldFRDltRTFoSXlMajEvOVhJbFV4QzRPb21kK0hk?=
 =?utf-8?B?OVRBZHFXaXYrR1hZcjNQKzdidlV6Q0ttYUYvQU50L1RuSkl4ZUFQc0tnTHUx?=
 =?utf-8?B?SWtNLzZCcGhHUjJGbiswZjZZOUxaWlozeWtMTll2WXdZTUJ6ZDZvSVllR1Ja?=
 =?utf-8?B?cnF0OVpVMGZaM25DRlhSRDRWa0k3aFRQRTl3WmVaSDcvdjdGWkE1alBvS1FV?=
 =?utf-8?B?Rm1Bc2J4eGxkcUNNbXExUE1nRzVpaVljdFBwVDdGYWNva09QM281NlppS1FT?=
 =?utf-8?B?YjVKdGpuQml3TGZ5NVhXR0NKUEV2WTAwdTlhb3p3KzR5QUVaT05rY3pPVVNo?=
 =?utf-8?B?aXlGVXZuMjdqKzhXaUxhb21iMDExMUNSeG9vcWRhR3VtSWZROXhOL1RCTzY5?=
 =?utf-8?B?ZUxiU2krbjVOU3QvRWF0NFhMUmdPd1hybDdncWpYM1lLdWdIRTBKU0Z1dGtH?=
 =?utf-8?B?U3IySXhXVmdIRmNqS0tvZzVtaW9NTStlVkxuUVNkQmV3TEVQTitidVpiSG5V?=
 =?utf-8?B?cktkY29tVElESG9vMWNnZHI4VStaQkdJQ3NvVFQzbWZ1MDBpcEFjRG9qT2Nx?=
 =?utf-8?B?SmE1V1Bwbmx0USt3czZsc3ZESFpoaXB2RDZEZUwrbzQxZ0JIa0p0U2VIMlVP?=
 =?utf-8?B?d0hqcDdzd2Yrd1F1Rzh3SHpTUmxncjYrZmwzNjhoY3pIWllLWWdvQUsvYmd4?=
 =?utf-8?B?Z1JTNTBhc0RnOWZiUURHMlB0VDlaaGE2eThzVWhwNEhnL0YxdThiVWlTNlRC?=
 =?utf-8?B?bWlqeEhMclhuVHFKNW4rYVIxMnpkdllrZGN1ZHFzd3lycSsrRlpONitQUEMv?=
 =?utf-8?B?OUV1ZG9rY2xtZjlGaEhmVlJwT3NDYlhyRVNtZGkvOS9xWFQvRk9ZcEFjY012?=
 =?utf-8?B?VURKcyt2TVF0VVdJb2o3L01jU2FCOWlZdUE1S3ZkT05jNjRvbFZvMHlXMmJh?=
 =?utf-8?B?NEtidlFaVGk0Ujl5NzdMZkp1N29KTFc0VFNaR0hhRm92L1lmZ0VPaG5yT0dN?=
 =?utf-8?B?ZVAxSjZUazBYSnJNdHFQem9sekVnYWpRT3BPM1puaExsb21mTElVTW95K2hD?=
 =?utf-8?B?K2ZVNVhBTC9GTEdQNkNXTUNFWlpKbjhZdjhhUVdWRWJqdXBCMXJxaGdBRFRy?=
 =?utf-8?B?MWdaZmhPRXpqUDFvQmtMQlk0RFBlU0dhWnRQbUFGMnQxbHgzcjZtY3FnZFZO?=
 =?utf-8?B?S05KSlFTVWdIU3hjcTJCd1FKWWNIWitLcnNOeFd0ZWM0Zzk1cjBBeTRPeHlO?=
 =?utf-8?B?b29tSnlwcHNEU2hPTFRuMzVra0NabUxHbHZzQy9VbkVCK09HUXpiVDVYL08r?=
 =?utf-8?B?aXB6b0tSYnVWcy9oYnJSdHF5dmtDOE5rUDB4OUxIcWhHUXRGeTVnbW90N3p5?=
 =?utf-8?B?SUVUQmxDejc5dzA0bXZvbGNzTUUzaVdITk5NYU9UdmwwcEduUDNiTHZUVjNo?=
 =?utf-8?B?eVhLSDIvay9TcXZueGFlUVpzbHU1ZEE2UjlhME9LbmZyTmpoV3NvZTNWaS9l?=
 =?utf-8?B?ZlRSTGt1QVZOUGdEbXBnWUp3em56WGE2TDJHakE2TzR3cEZMRVkzUlhDNjV1?=
 =?utf-8?B?bzRqSHY0cnFmSEl3ZVIzaWt1R0x6bHRHYjRGYnExNnJQUjJqQzZxRzJKWjBR?=
 =?utf-8?B?VUVWY2J1eElNNzliRkdlMUs2dzhKdjY2eWZNN1Y0QnVwRGUzWmNielFEUWtU?=
 =?utf-8?B?S29BY3ZFZ3U3cGxHZkRWL0JFSUVEWkFyTnVPa2RKUmRqS3kxbzFVY3ZqcmpU?=
 =?utf-8?B?RkJPMGwvcWQ1cHhqWHQ3VGxIVkU1czUrZWQzdFliR05Ka2E0ckFWYzFZaURi?=
 =?utf-8?B?aEtCcDc4OXlQcy92Zm85eTBkNHg4bnIxbENzYTRnd0ZZU0xpa2Y0VFZYWkVw?=
 =?utf-8?B?UlIzMUhmRGRKbCtIeFk5cmRlUG1OVXpIN3pFNkVoeW9OWXp1dTBnWXlTdzJt?=
 =?utf-8?B?M0tpTHBpSGl0WWJrTE9QU0tRTnExOUtCTjZadnJMclAwQ25JVDV2L1ZZRjM3?=
 =?utf-8?B?ekZmaDBoUDdUU0ZPeHUvRFFyVXVhUU1YK3JKbDlwNk5MWjgrRWlvV3Y1bVVO?=
 =?utf-8?B?TnZnMXVyVnFZbDVNcHZQWWxsTEFhdUZlUE0xbWMyTEFEUDU5UFhhN0FEMkMw?=
 =?utf-8?B?dk5OT0Q1d3JxZmFTYTRIelZpdzFxWFlXU2lMbzlsRFhkS0kvR1Zod3N2MWU2?=
 =?utf-8?B?OWoza3RTN2dDai8zdFdwUFU3NytkdzZSQUc3SDNtSmxYSzVuT3NrdldjR3cy?=
 =?utf-8?B?bVhhNjZCOTI2cG9HN3dPUDJFTVdqYmZ3bUFOdHlKWFRYLzRIbjRWUjlUNS82?=
 =?utf-8?Q?LGlZYmVTnRS3aOho=3D?=
X-Exchange-RoutingPolicyChecked: DGMp9MP9bASr472y19GSpXozbpn7gUds1cYMad0pd6zgDqY/573/CnDl7PF6QGaHv/09qRbLPZeF+tMr8pFJNsvp3cksXnyERcc0ka1sbuf0IuUzbP8Lucp8GW6nxHiaQk5WPltJmFNeZJ6cQ47FLSBrXWPJUoxRZIaOERdZsVg9h/9MQhziwUrvnJ3r7g9mwwlrOnY232AgwpmxVd6uri457g3TrFEDc48qVWnTQDs0h417/KzuqkN9U4AZDWOHiWua0KaUfQFCFkWmx9iEdb41LMjKejWWiN8st9BmGh4DTFIQIpFCsN3xj/r6jsTHysFmk0Wl82WLnMdLCGWr7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5d96b7-7cbe-4af4-6bde-08de88e0d19a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:33:50.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bVMXG9vQ0kwKWSKtZvrfc/a3dPR858A8mgXWusQ1Ezxd7d1hNDPUlQ2SVT0nsUjB4wa0OFE+SVlN7iciSJ6NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com

On 23/03/2026 04:07, Ryan Chen wrote:
> Get the optional reset line for the ASPEED SD controller during probe by
> using devm_reset_control_get_optional_exclusive_deasserted().
> 
> This allows platforms such as AST2700, which require the SD controller
> to be taken out of reset before use, to work with the existing driver.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

No longer applies to 'next' branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

Fix that and add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - use devm_reset_control_get_optional_exclusive_deasserted replace
>   reset_control_get_optional_exclusive.
> - add include reset.h
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ca97b01996b1..8f638ffb55ae 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/spinlock.h>
>  
>  #include "sdhci-pltfm.h"
> @@ -520,6 +521,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  {
>  	struct device_node *parent, *child;
> +	struct reset_control *reset;
>  	struct aspeed_sdc *sdc;
>  	int ret;
>  
> @@ -529,6 +531,10 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&sdc->lock);
>  
> +	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(reset), "unable to acquire reset\n");
> +
>  	sdc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(sdc->clk))
>  		return PTR_ERR(sdc->clk);
> 

