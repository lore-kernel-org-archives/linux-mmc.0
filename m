Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793951203;
	b=H6K0CVPPe6EU+rNLPom3dUdUcWxAJTVLkbw5o9Tb3xpqI7R4ODegcWrt4Gkyw2BygG/5
	 0KCdGsCSaj0LwZmbVQqUbjFpkYRlejm6TTIbGu6WSeAq+PO+JNkx4gQro9k05hUi1SBK4
	 IylCKKbah7JticQRYU3bfK+UZvyNAMtGDA8DyvEebZUUjU4KX2Kyjx2yRXx2Nw9CLuyzf
	 UmGidDqZo1dUbOd+fY2s8aYRrZuB+Sp5v5TV0ieGnyBlM9XB6krX2zUA0JKZUIxr7UNHL
	 lpjwVvnV12FXbKHetSI2esJv9ExsoPNHbvssxoaSnplZhOYsSon+bGQXy+0OFq6xUuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=5779Vf0hSRd380hjVSI34JU34dPYDFqUghsVEK2v2EI=;
	b=KfqX2klMVBaYbAIHQqArHv2O0HkBSWnkgUVpy0Ktx86Gh4M2E8fIjD551JlSpdkvMO53
	 PtyGxz+i1YLNCIhLru/HAT+l9jZIBz3XplgKd3R8/1cF3XYATfwfGZN5Cpm6WK53LTbBW
	 5lEZ6J23dazqy7TKAXNIanPX/SWWU+rdykfP+FNQN6uOLMpyxR9hq+HdOZfxo/fYj4QkC
	 KDJUauTtJnGjlLP/mPXhEdjm3l/FVdOnSegnhqLpsvSDG1R5kIXg1NxQhT7eswC0bYjGR
	 J693YmtxOkQmRlmRdsin20D8sdCJvRdzz5Up3nM3avUs7bjur3V++tqFcjX0aYWajnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dyl7m+mV;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C1606A326;
	Fri,  6 Nov 2026 07:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 967C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dyl7m+mV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793951202; x=1825487202;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+2cM9F3zCIhk1K4K9egPWjgfS3DsuNq072vNnasuZsI=;
  b=Dyl7m+mVqokO0BeJKFjtnWocS3CLh/mvfOZ7rvoalHPuktmDfN+G16yn
   A2BeLUjBeC1zzuPdd9e/AcA8rIOMJdAl9xGq/5ukdeMDPiagebtR7nbeZ
   HYTv99EO2bwjGPY1ESaRz5j6aD+Iq9mGklx7yK12PsjlGszhUpDF9+Hf0
   H5xVHI0SS4OkhVPvs75xUXeKMLeHOeUkSwCJTTpPXoCJTs8LZNOXMVW+J
   c4eLvDaiTtAni09K/QfO6fThf9eNdrwHVtc1VrYeyJ0R9Fe4b3AZpB85A
   NjP+Nfk8dOaSvCSs/xhekocoXlw8Hle5GfXLuzJ7Kr+eNO2vgJaMeUW5f
   g==;
X-CSE-ConnectionGUID: otyZ83oGSlmOeVUEChbjmw==
X-CSE-MsgGUID: eDLgMwfvSU6NyxsoW/HJzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2848851"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2848851"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:46:41 -0800
X-CSE-ConnectionGUID: ILS0h4QpTAeaIrCP1bRpuQ==
X-CSE-MsgGUID: qR/SXJkYRCqvcsLuuQ4pyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8971324"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:46:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:46:40 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:46:40 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:46:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVpt2Ztyf3/maHFTvemboohewux0Jz9O1E8njabB/Hj3XPfQnbXV8rjtThElVBbqwgI3TXckJ31u5qwBkLfy7boHmvUrTYNmVOJXLMJ7TFwo+T0q0bySysh4RwqDgFy0CmjKsW0Q1tOyRmFF+1HxfTzZqw4pGXPa0xBOiuEJQA68nTBxkjMv2Zv+sul70lF0FaBlf6gwVI8r4zw0Ff7nqpgh4jICjNottJoXmmcTLfi20eJkuhNW1cbqmhWRlEHbOL6FQX1WvGVy/eMV0Z37KIp/SSh11nJ1G0kPAXwfeJPHyFj2ZlxQXaxCL6pj1DYQHtEMSru1NHc2EywkABO9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5779Vf0hSRd380hjVSI34JU34dPYDFqUghsVEK2v2EI=;
 b=b3f3Cf5A5QGDCYIEZKPtxgqUpE4BCXLkh3dstvJTJbCkDDvt7tAThBZWjret8wIl+iZZVTh7ioksQAzoAnw5zxSuSofBW65ilzFQo0IVATOXbD9SrtfhW9YePsN2OB/jvce6ffsMsvkusWHKIhUjnEsxXE57QWUYtGibICNRhJXmRHgSvy4g8qyu3xLXjYhiRNySmidqWVkMTbc/jeNkc5bBQPM+1H7tgeTlxwMBMRnQGFaoYIGnTPXt4LERRNxuEg5sHqhBNZvEup0mr6S1Nz+1uuKQLrWPbDRZbJnVqY/qEt7oaJND0K6tw+KThVOnS1UO7Ka94tjLVGnGivyFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY2PR11MB921967.namprd11.prod.outlook.com (2603:10b6:930:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 07:46:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 07:46:37 +0000
Message-ID: <aef60465-9eb5-40ba-ac9b-81c4a0fd3e66@intel.com>
Date: Fri, 6 Nov 2026 09:46:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Add support for setting command idle
 time in nanoseconds
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, "Ulf
 Hansson" <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
 <20261104112657.110536-2-changhuang.liang@starfivetech.com>
 <2e57a04a-71d6-416d-a49a-c7d78318ff79@intel.com>
 <ZQ4PR01MB120287B3692FE12B801C677CF2772@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <ZQ4PR01MB120287B3692FE12B801C677CF2772@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY2PR11MB921967:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba12ee6-e9e2-4544-a6ea-08df3bda162b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261026121527099003|261026140227099003|261102130727099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|56012099006|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: UDpxuBR5kRe/jYw2XvgdsFT0lBnQi/xHmTDx+utJYjGSPx1VqB+aMWva+B6iG4t94dGrtoZuUEZrrbLwXLuuJK735uiAapWOpcTJd7G9J0qumYbbjfyLk+54DQc8KFFK0Fvk0Z97xcp+KynGMwdeHOPeuA1XmtY8vbJDU5r56QX3i3K0RRf2M+FO4a74d00MbAF8GZSOrWsoCH+UT5C4Yxoyccww/blL4695flU/wQjTulH4oPx2c16XpnLauDV0zo7VJT5wk5oMP1LSSczCW5TeXfTLuqRNVkcqKJzeiKQ+HbDZejQQY4wiQ6unxSTNagq44LnbfqkYu5rxkI9VQkRddA78FMl5/akHkJIzzIcG7jYjQEJT8mhRDp/GpvQQet6lZjnqV7YXGptOyXbF5m5Zi93HvqINTMdnV8NcE+AhTnDOZsEWeM3hVv8kRj04Q5j91jYPdsl8z/7ckllSgrDJOwmkrSp4rioZp+SfjrRNZg7rjCePPe30aLnj8A7XMyxA5hdeX3/k+BVQr/+yyNIsmYOlyDSpUDwpp02/aFzBozp1cbcJlmfqVZAnGWHenWCZZPwbD8lIxLtiG1P+hM2o/VdjuOVRKTvnmxpPMsTfVEPiZibk8A44J9beb+ZbQQTYPGQ1RzSuQlqe3hNjWoylEMCv9WLPLI4oSbZtJR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261102130727099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(56012099006)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5BZUx4WmFnUG1URGIvR0Y4czRHK1VYUUlJV0tQQVhJdjEySyt2WkpCYkFC?=
 =?utf-8?B?Y1pEcW9Na3YybzEwamZCWGhndzM4SVBWQjZyS1BTazZhdVl4NWU4R1d0OTdU?=
 =?utf-8?B?QVhmMnBWYkxuSXZaVlRBS0xmVWt1RExCTFV0SVo2WEFyU2VpaU5uSjh2WUo1?=
 =?utf-8?B?ajRvbWZpOFBnT2NoSm5oUEFObTkzWWRUckJpUGc0RTRyWUZJUG04Tythd2RY?=
 =?utf-8?B?b0FtZThDaFdkWnNLc1dLM001MFpSOHNNOFFLbE5ySHY3S0w0eFMvMjNFdkxW?=
 =?utf-8?B?Mk54YnBSMG5DV2krc0RDLzQ0Nm52OVo3Ujl5dkkvQ25LbmdrWElOc3c5MGVE?=
 =?utf-8?B?STBVWTYyaGliSU9mcVI2QU9wOEFiWStZR1hMLzdTcUtWNnRVd0swTXRtQkVj?=
 =?utf-8?B?QVhqbEhSSkJMNUZxVHF6TzErN1Iyb29XTkNHa01CQS92VjZ2NHlxRDZYdkJq?=
 =?utf-8?B?VVVFRVN5eWYvSHNMSitUOWFQQks0V1JESERtUkQ5a0ZlRWtvY2NFNkhXTDFj?=
 =?utf-8?B?cmNOL3g5bG1TeUQ5YXFpYWk3WVJzTi9ZZTFHV0hjSXRzbkpXZnZMZkEzREZn?=
 =?utf-8?B?TS9FS3AvNWRQUjJoZGI1V28wYkVkV0lSd0hIT09WWTZRb09QUDF3bklQYmNT?=
 =?utf-8?B?aWU1d0xkbnZYWTU1djd1cUdQOGhuMGRYRkJFbW5xUGVwNkh6b2haSndjd05D?=
 =?utf-8?B?RDNsdkM5MnpmTXp5SGd4RXFqbys2RkZrZ2twK1BPNCs3bVRYRmRmcVJoQ3Ix?=
 =?utf-8?B?QTRtS1pJVXI2TFhOWmVSSEYzcXQrSWg2aDFyZ3UyMkRSaGQvYkZ0OU16cG5Q?=
 =?utf-8?B?Y0dpcWs3R1NTczR0WHNrVXJlQ1NPZXE4azdidCs4ZHhtOHE4ZjJFNGhPcmxr?=
 =?utf-8?B?U3FpNkFxM2E2Z2I0K2M4MFpiMEpGc0xDM2Q2MU5UQ09UcVBiaUFyeDFtQjB4?=
 =?utf-8?B?OHcvL3R6dzdmNDN6bXZydnRKQnRjYk5oYVNSbktpTGN1RW5OcHFDcS9ydmFK?=
 =?utf-8?B?dUs3dG5GZk8xUHFrYkZxcXlFd0R4ckswMmdwTmtSdjhHQ0lRc3AwUGpNcitI?=
 =?utf-8?B?NzBwZXlRSHlnQzNUVDJuWElxNW5hQWJjUXRHdldQUlBkSFEwdVB0NnVCN3A5?=
 =?utf-8?B?dUp3by9zMFVKREh0WU9UWlJyclcxKzgvT2puc3hQSzN1SnNqU3FERDVRWldD?=
 =?utf-8?B?NUc2RGhSbk9pcTRGb1lzQjkwU2hYZ2RyMjhMUnVlNWora3JjeEdhTVBZRGUr?=
 =?utf-8?B?UFlOYmFxZDJFaHV1RlNaYlZNYmxFdjV3U2dlaktNWU1oSDZHenQ5VFRZVHdG?=
 =?utf-8?B?djRQNk1YaW1lSEU2SkV4TDFONVZyYlQ4RndDVFgyWGpLNVZ6QTR4b3ZMb3dx?=
 =?utf-8?B?eGxjZ1NsM1dJK3plVDlaTWxxclg3UkNHRVRjaUxGZVhJS2sxdFJxS2E4UnAy?=
 =?utf-8?B?ZTN0ODdsZTh1QjFoM28xa2dZbit5UmJIYStmeTBFU1JiV0RVbUtjSmZjeXRi?=
 =?utf-8?B?TDFzamlESllRV1hTaEN0SXBvbGJLYXVFS2g3NkNjY2JJSGFybTByeVVITTJ3?=
 =?utf-8?B?c0VGemR3T3VLak1OV2I2RlF2dXg3WWMyL0UvVWdNVUF0MmNOQ3lSMEFBTjZ6?=
 =?utf-8?B?UVBJL25HS2R0MmswWmVJRHU1ZVlRNG51KzRCcjE2enVLTHhpV3QzazFXZE43?=
 =?utf-8?B?dGdubWttK3ZCOHlhUmJrSjNPMVhQTk9nMlFWdmRNY0JjTEFDNklrKzkxTWFK?=
 =?utf-8?B?NlluTnhDdnVtTTlwZkJNVTVNaDNpRWhxcW1tcFlxekVrNURTdHBFZHRTOEZj?=
 =?utf-8?B?bW5uUG9NblpFN2liNXRkWHlFRjk2WHpyMmNJcU5SUnNXblh5bW5XUGMvKzN1?=
 =?utf-8?B?RXVlbW5mSndpanpXWUYzYmY3UWtOWHVEL0JWdW1aTjNFQmdrazNOZEt0dUZJ?=
 =?utf-8?B?R3NmbG55dTQrK0pjL3ZjY1dIR2dFOGdkNFNPZVZOelc1aC9URUNtdWJsa0lm?=
 =?utf-8?B?VnNOdjJXc0RjeW4rYS9JbjJnaklVTU51bmFEeXJON244ZVRlTWlJbDVvNXI1?=
 =?utf-8?B?NkUyUXNJZTFBZm9BSzRWeXVSUTZsdnNXOGQ2OWFKdDd3UVY1MUY2SkN3Q1hE?=
 =?utf-8?B?OGlHVWc4bzNOL2RUSXdTMDYvbFhrenlvQ05oM01rdndLbzhqNm9pRUp6TFNQ?=
 =?utf-8?B?OVUrbzhsbXA3TjkwWFMyOFRJczFnalpLZThoV1hNUUpVWEtvd1VrK002U0Vj?=
 =?utf-8?B?VG5EcUE0cHpFSjk4VmYxWlFFeXpRVGY2cXZGOFJMMERLeG11alhWYkM0MmlY?=
 =?utf-8?B?QzJGcUY1NlN6Y2Q4am5hNHBYbHZVelQ3UFFEUjVhNzZ4SnU5MmIzSGhGV0ZR?=
 =?utf-8?Q?CFclTRPh65hPSTyA=3D?=
X-Exchange-RoutingPolicyChecked: RisjynMbzzGprObSUCHhzlAvi5pZPHi3wY5wg3oG860K4+yTYXaQHZSMIPlGiH1rceJBrIwAkznHiGuHTUAvvQshwtNBLgAwLWzFcIedpDswuCgPsfriuoTNM/QreU0CL4zmMBt8hKpJKnTx3fFHLSy2m9gq2jHFc59F09z2hVUXn+Bvo/AQ6SBeTrJD4YQ5E9isOQps2wB40LKtWDu/GwbtJeORRa9ZU+O37oLU8L1xZu+KTfHG/OdSkpHOCYUGerKp1ygTifOfbfaTZojgsg1DeEyTrhR1iqP/kv8cu8dIvYX8sAWWVaLi39Ce+4qcNUmM8o9hMXxFN82dCln9Ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba12ee6-e9e2-4544-a6ea-08df3bda162b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 07:46:37.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZVTX25HMbyhwioeNx2LJUDq7aX/7z4kcACX/1S/PADLeSgZUIE8d5YxmJr9eEq9466sMScpxHH1uriOaenspQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB921967
X-OriginatorOrg: intel.com

On 05/11/2026 12:04, Changhuang Liang wrote:
> Hi, Adrian
> 
> Thanks for the review.
> 
>> On 04/11/2026 13:26, Changhuang Liang wrote:
>>> Add a helper that derives the internal timer clock frequency (ITCF) of
>>> the CQE from the ITCFMUL and ITCFVAL fields of the CQHCI capabilities
>>> register, and export cqhci_set_cmd_idle_time() to let host drivers
>>> program the Send Status Command Idle Timer (CIT) in CQHCI_SSC1 using a
>>> value in nanoseconds.
>>>
>>> The CIT defines how long the bus has to be idle, in internal timer
>>> clock cycles, before the CQE issues CMD13 to poll the Queue Status
>> Register.
>>> Its reset value is controller specific and can be far from optimal, so
>>> host drivers may need to tune it for their platform. Doing the
>>> conversion in the core avoids every host driver re-implementing the
>>> ITCFMUL/ITCFVAL decoding.
>>
>> Should probably have asked this before, but why calculate it at runtime?  If
>> you know the hardware, then you already know what the value is going to be?
>>
> 
> For convenient unified use later, different SoCs may have different ITCFMUL and
> ITCFVAL values, which could lead to different platforms writing different CIT values 
> to CQHCI_SSC1—even though the CIT expressed in nanoseconds may be the same. 
> Once this has been validated on more platforms, it may be possible to unify on a 
> nanosecond-based CIT and thereby get rid of the .cqhci_cit_ns field in patch2.
> 
> Best Regards,
> Changhuang
> 
>>>
>>> The requested time is rounded up to whole clock cycles so that the
>>> programmed idle time is never shorter than requested. The helper
>>> returns -EOPNOTSUPP when the controller does not report a usable ITCF
>>> and -ERANGE when the result does not fit the 16-bit CIT field, so
>>> callers can report the failure instead of silently running with the
>>> reset default.
>>>
>>> Record the cit value in cqhci_set_cmd_idle_time(), and if cit is
>>> non-zero, program it into the register on every call to __cqhci_enable().
>>>
>>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>>> ---
>>>  drivers/mmc/host/cqhci-core.c | 64
>> +++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/cqhci.h      |  8 +++++
>>>  2 files changed, 72 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/cqhci-core.c
>>> b/drivers/mmc/host/cqhci-core.c index a466cd88b043..bfa5d8b79145
>>> 100644
>>> --- a/drivers/mmc/host/cqhci-core.c
>>> +++ b/drivers/mmc/host/cqhci-core.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/scatterlist.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/ktime.h>
>>> +#include <linux/units.h>
>>>
>>>  #include <linux/mmc/mmc.h>
>>>  #include <linux/mmc/host.h>
>>> @@ -279,6 +280,14 @@ static void __cqhci_enable(struct cqhci_host
>> *cq_host)
>>>  	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
>>>  		     CQHCI_TDLBAU);
>>>
>>> +	if (cq_host->cit) {
>>> +		u32 ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
>>> +
>>> +		ssc1 &= ~CQHCI_SSC1_CIT_MASK;
>>> +		ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cq_host->cit);
>>> +		cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
>>> +	}
>>> +
>>>  	cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
>>>
>>>  	cqhci_set_irqs(cq_host, 0);
>>> @@ -1163,6 +1172,59 @@ struct cqhci_host *cqhci_pltfm_init(struct
>>> platform_device *pdev)  }  EXPORT_SYMBOL(cqhci_pltfm_init);
>>>
>>> +static u64 cqhci_itcfmul_to_hz(u32 itcfmul) {
>>> +	/* CQHCI_CAP.ITCFMUL: 0 = 1 kHz, 1 = 10 kHz, ..., 4 = 10 MHz, others
>> reserved */
>>> +	if (itcfmul > 4)
>>> +		return 0;
>>> +
>>> +	return HZ_PER_KHZ * int_pow(10, itcfmul); }
>>> +
>>> +static void cqhci_itcf_init(struct cqhci_host *cq_host) {
>>> +	u32 cap = cqhci_readl(cq_host, CQHCI_CAP);
>>> +	u64 itcf;
>>> +
>>> +	itcf = cqhci_itcfmul_to_hz(CQHCI_ITCFMUL(cap)) * CQHCI_ITCFVAL(cap);
>>> +	if (!itcf || itcf > U32_MAX) {
>>> +		pr_debug("%s: cqhci: internal timer clock frequency not available
>> (CAP 0x%08x)\n",
>>> +			 mmc_hostname(cq_host->mmc), cap);
>>> +		return;
>>> +	}
>>> +
>>> +	cq_host->itcf_hz = itcf;
>>> +}
>>> +
>>> +/**
>>> + * cqhci_set_cmd_idle_time - program the Send Status Command Idle
>>> +Timer (CIT)
>>> + * @cq_host: CQHCI host
>>> + * @ns: idle time in nanoseconds
>>> + *
>>> + * Set the number of internal timer clock cycles the CQE waits on an
>>> +idle bus
>>> + * before issuing CMD13 to poll the Queue Status Register. The cycle
>>> +count is
>>> + * rounded up so that the resulting idle time is never shorter than @ns.
>>> + *
>>> + * Return: 0 on success, -EOPNOTSUPP if the controller does not
>>> +report its
>>> + * internal timer clock frequency, or -ERANGE if @ns does not fit the CIT
>> field.
>>> + */
>>> +int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns) {

Let's just add cit_ns (and cit) to struct cqhci_host and then
calculate cit during init if cit_ns != 0.  Users can just set
cit_ns or cit directly


>>> +	u64 cit;
>>> +
>>> +	if (!cq_host->itcf_hz)
>>> +		return -EOPNOTSUPP;

This can be pr_warn(), don't return an error.  Users are expected to know
their hardware, and it is not fatal.

>>> +
>>> +	cit = DIV_ROUND_UP_ULL((u64)cq_host->itcf_hz * ns, NSEC_PER_SEC);
>>> +	if (!cit || cit > FIELD_MAX(CQHCI_SSC1_CIT_MASK))
>>> +		return -ERANGE;

Ditto.

>>> +
>>> +	cq_host->cit = cit;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(cqhci_set_cmd_idle_time);
>>> +
>>>  static unsigned int cqhci_ver_major(struct cqhci_host *cq_host)  {
>>>  	return CQHCI_VER_MAJOR(cqhci_readl(cq_host, CQHCI_VER)); @@
>> -1207,6
>>> +1269,8 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host
>> *mmc,
>>>  		goto out_err;
>>>  	}
>>>
>>> +	cqhci_itcf_init(cq_host);

Calculate cit from cit_ns if cit_ns != 0.  No need to store itcf_hz.

>>> +
>>>  	spin_lock_init(&cq_host->lock);
>>>
>>>  	init_completion(&cq_host->halt_comp);
>>> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h index
>>> 8fbbc48c3f85..e6840a8f4798 100644
>>> --- a/drivers/mmc/host/cqhci.h
>>> +++ b/drivers/mmc/host/cqhci.h
>>> @@ -26,6 +26,8 @@
>>>  #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
>>>  #define CQHCI_CAP_ITCFMUL		GENMASK(15, 12)
>>>  #define CQHCI_ITCFMUL(x)		FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
>>> +#define CQHCI_CAP_ITCFVAL		GENMASK(9, 0)
>>> +#define CQHCI_ITCFVAL(x)		FIELD_GET(CQHCI_CAP_ITCFVAL, (x))
>>>
>>>  /* configuration */
>>>  #define CQHCI_CFG			0x08
>>> @@ -234,6 +236,11 @@ struct cqhci_host {
>>>  	int num_slots;
>>>  	int qcnt;
>>>
>>> +	/* Internal Timer Clock Frequency (Hz), 0 if not reported by CQHCI_CAP
>> */
>>> +	u32 itcf_hz;
>>> +	/* Send Status Command Idle Timer in ITCF cycles, 0 keeps the default */
>>> +	u16 cit;
>>> +
>>>  	u32 dcmd_slot;
>>>  	u32 caps;
>>>  #define CQHCI_TASK_DESC_SZ_128		0x1
>>> @@ -318,6 +325,7 @@ struct platform_device;  irqreturn_t
>>> cqhci_irq(struct mmc_host *mmc, int cmd_error, int data_error);  int
>>> cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool
>>> dma64);  struct cqhci_host *cqhci_pltfm_init(struct platform_device
>>> *pdev);
>>> +int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns);
>>>  int cqhci_deactivate(struct mmc_host *mmc);  void
>>> cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool
>>> dma64);  static inline int cqhci_suspend(struct mmc_host *mmc)
> 

