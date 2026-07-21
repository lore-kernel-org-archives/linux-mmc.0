Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321940B398;
	Tue, 21 Jul 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629300; cv=fail; b=VT8D2Xp1ukHJnq8tLQSW/MVNz1GWQvSTNBPHJ3H8HEil+7pU8cNAPws0WmBpNeCFTtXb5A//9/DDHgZC2Auu5XzcIVX2kM8a7bblxE/jDc0QgAx9AUDh+hnrrAUc2K4E/RKro3aOWhQfNDO1f2PTHfPare6hhWveYz1ABBC02VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629300; c=relaxed/simple;
	bh=Epc6NVxhLGrSZdHt2irC4SnMTEPyf7AOufeN8ovyVmw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nRAx26mjRwMCNto3xyL8KLPJJZHNetS10zNkkxXwiGdQPsQ/GJCQwlI0BXKiG7KkGh/DmcGai0ScAp43opPyb6jn/b0lp9uw8j4grWT4blgJF/QrgPdrUI+rnWRLZV701GCVRpBKEGIHsfqFHvcdMHceSDs7IE6156aUKpstLOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrcZmUS3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrcZmUS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629299; x=1816165299;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Epc6NVxhLGrSZdHt2irC4SnMTEPyf7AOufeN8ovyVmw=;
  b=SrcZmUS3UXfLLvrWgBmNJPnrUpyFJKG+85LlXJrrhgGu74EqafOXuOOD
   dd0J7Qs8hrL08SDj9HavHFjZF3V8HLJWOvS0gZD8iHe2zDurfyO1g8qTh
   b9AaR9PV/h8AXVpMffvCcY+MKQMpdzi4l0F/c8E66UuqtS1F3KTbCuyB/
   EZUMs3O5YuZV8UJKnFNMtbct7Wp9uX8rI7Q9uKFzIjsD/OA/0abzPI9FY
   JRIl/ne5iQ5FkAJ8wFMAg9VbK6wwdmSRibPCI/XzPGI+hubEXrYTvaZaW
   tdqSD6bT1MI/3WsJSRZbQC5h2+ndD9ZRpxvhQDYq86qbI0+Cgow83qNrZ
   g==;
X-CSE-ConnectionGUID: Hbts0oGpSoat81Ku2R/13w==
X-CSE-MsgGUID: k44Dy/MBSDO07KdTGAmPGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87760910"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="87760910"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:21:38 -0700
X-CSE-ConnectionGUID: uuD0WukmStqdelnqcsFX2w==
X-CSE-MsgGUID: gX0PZmEoRTGxTPd2d/xQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259699205"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:21:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 03:21:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 03:21:37 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 03:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5bnLbTPBx0vwHbAfaU32u3WWP/311XCHt5IDU6Cbf99x88aXbqOJbGl16MTm0y5sFjxD9ggUk9c9Y4unXhxT5lMcmCUKbivAVSlLvr7/5b2OUk4htFt3hLy26smEJJMTC5i35qOFOjPBEUuxODfUN5oGMeNawjgtAjDoig3mRwoNxOAWWZYiHQvqF/tdUq29nVMhuYn9VaxupjWcaiYSapttVxd3fW6EacABLH8TUSGjtHczC/sGjQ++pKnI0DQStodZChHNgqGW3+8BVy6Hi5gvBZGpUE9a8hH8TFIbs9OVQ5mf15IisM/8gNPLOtXkxm+vI5EDkm1BgKFQb7nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3miXJImS058jRTaMQSSP4PafmV29mxMiNFxdmATXMs=;
 b=wv/HvjobxExiSKa1f8/JCYCAlJBLLSQseVGVNxfK3LX4mp9FQ0SmoZ6kQSfHX5cXMYDW4n2G2tXOgb2+0hYLcVcg7k+tV/yXK5OtPEkyESWtKTprHjn9XdcuQFQarGeOtt1zh6bxjRuSKigXqV7SRuW8MLLstrc7WQdsrjk2kgXURuvf4uXGrCyk1lFMJoctTRZnl90e6PGg6u0J3m9TJTshaS3RuHWRSBXun3oT3aJZDId7Uu7A615ULSRi52IGtCKNdWo5AOChRPti1xzyQshwbYAHLjpziv+6bnG5d9Epydg/v7jTl6z/UIcYIEO8ybQQuw445Kry46KEkf7Vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY8PR11MB7745.namprd11.prod.outlook.com (2603:10b6:930:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 10:21:32 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:21:32 +0000
Message-ID: <3f696a6a-c032-4c48-9230-90d9cb6003c2@intel.com>
Date: Tue, 21 Jul 2026 13:21:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: host: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>, Ulf Hansson <ulfh@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	"Kevin Hilman" <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	"Martin Blumenstingl" <martin.blumenstingl@googlemail.com>, Nicolas Pitre
	<nico@fluxnic.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Linus Walleij
	<linusw@kernel.org>, Thomas Fourier <fourier.thomas@gmail.com>, "Pedro
 Demarchi Gomes" <pedrodemargomes@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, "Takashi
 Sakamoto" <o-takashi@sakamocchi.jp>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL
 (SD) AND..." <linux-mmc@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "moderated list:ARM/Amlogic Meson SoC
 support" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Amlogic Meson
 SoC support" <linux-amlogic@lists.infradead.org>, "open list:OMAP HS MMC
 SUPPORT" <linux-omap@vger.kernel.org>, "moderated list:ARM/ACTIONS SEMI
 ARCHITECTURE" <linux-actions@lists.infradead.org>, "open list:ARM/QUALCOMM
 MAILING LIST" <linux-arm-msm@vger.kernel.org>
References: <20260717101508.635969-1-panchuang@vivo.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260717101508.635969-1-panchuang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY8PR11MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f582bc8-469f-4b69-6421-08dee711d5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: nIJgkuMf1v4AT+NkaeEvSFlyl5fhHP9SceaSnQSdhyKHIeRhswmPo8+webHtNF2Aw94AzCIa0RZmFcNNUrnlmloa49JKjAQNtVWuHuZYefJ0cF9GFEb6FJn42t9hP9iH4HLqOzWir40olAa63hOiTcc2mgNLZFztpKkMiMX1Y1BQ160ULY1fu6ahAmea+JKaUvmDWuX4C6PUgFTwdK7yYZ6vyImNXLTqfU3aRGblEFss1N8J9ssdzX2h8R0yesdHHTBblxPj8QXy/7tm3/ahakeQ4ZPFHSfPu5GxvdO49nXEu5ZcvX4HW7AYYdbPivvVq5Rd+MVK4qyidpbNzsGXAVUcA17Tdt4UxdySQq6rtnCmvT2o9bRUC0e2p+7b7tN0nEYgx8+AV45AgQKM9M2vATxNak4aBL2TN6VsS64btYysffWn1PK+mR1EUkNhOUoiv4uV806X87R/yCwCGMiT0IwJY/mY1AvtzYtVsuK1QqzZzoeQ2BeZCV35eNYfXF9vp0JAaQA2cQOc1iNArsrrCQy15+AjZkBkMsFUQHo176J8Q8845S6Y9+a6rn4z29H5Cp7VhSi/Qk+iTBZXoNi0hRzs3PmY/mY4/ggULvu8z4PlrlIcc7vHkBnjS+f9W/kMAiCojqemc523+tnZBSgLPOMEf/gkW5Vm4zh8S0asqc4CswSSCqM+eLEA05PqKlgw3Fhwgl22xk+iFqv7QEP4CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhiTTJlY0pOWkZmVmd4aDY3VXBpMjBWVFJNdVNMUDBORldPM3RQN0phTGpL?=
 =?utf-8?B?SUwwS1Zja0xRUzlidTFTMVFjYUN2ZDFqSysxTzFrbjUzbXdNVll6T3hNdkZK?=
 =?utf-8?B?a2RESWdsRWxIcGdVbHZWWnBhSlpTNGw5MFFuVkJuN3k4aGhXcExoeGEyR0dr?=
 =?utf-8?B?MXZKeHo5bW5QK2NqU3Ftb3BaYXlBRUhON0NnUDIrVHBhdjc0djdIYk5OMThQ?=
 =?utf-8?B?REE3ODJaRmZrZzlPVWNuY3JUQ2FvT0pwM2FYRjNuUCt1NGM5cHBhWWluUE5q?=
 =?utf-8?B?ZW1mWUpETElncHY5ZCthREowcG9qUFE4bjI3YW9JRHJhOGFxM2hWWnhJM2R4?=
 =?utf-8?B?aHRiN3hSRkYydlFLSVZlOFg3Nm83em5iNDFpeFN6VUQ3MERraTVveFljcFl5?=
 =?utf-8?B?VkhVbjhiY1lnK1ByeW5xUjVSZDdZcXFPTTNkQ0lJSm1kU0h1eTlDZHVTNzJr?=
 =?utf-8?B?RmVHTWppOGJ0cG90Y0d2QzVrRDlGZkpXbzljR2kxWGJHOURCajk3RWs1Z1k2?=
 =?utf-8?B?UjBjOGhwcldiY3pLZHRTSzc3My9GVFBZcktSMy9NZk1oRG1FdjlibktzK0VG?=
 =?utf-8?B?WnU3alBSWkxRdVUyeXlheHdFdkFBTkRMSFlXZ2xRM1k5ci9HMk1hcjgvQnFI?=
 =?utf-8?B?K2wwY2lmYitKbnU3VmoydzFWSTBZS2FhMk1NTjRmTjFicFArTW5PbHhBVVBM?=
 =?utf-8?B?T3dsdmFKTXF1bEFkMDEyc1ZhSHNtQ254b3hIZWw1MTZBVDA1bFEwaHNNb0FH?=
 =?utf-8?B?NnpYb0VDa0JpYW9QM1hpajRNVituYmhkWm1MN1RoejNDSHcydXp1akhqYkVB?=
 =?utf-8?B?UnhVMTJJNmJXWkF2dm51bUZabVY3cFc2OGlYSVhmSHVwL3N1T0ErSWphN3hC?=
 =?utf-8?B?cXB4eXkzYUpnM1Z5dFE5MXVrRjdObnFGeU5VU0JTK3cycVVmT3FtcTJSTEVi?=
 =?utf-8?B?a28xNEVBTzFMR3BMZGZ2Wk43RGUyN1kzNk1SR2ZhYUFVTnFjZXkwUjM2L1Vh?=
 =?utf-8?B?RXdKUWFKVENtMkdqaTVoZk1QUFdEeXhibDhYcTJoOFBMNkh4TmlRT1FLUTRq?=
 =?utf-8?B?dkFoTmF5dllpUEIyQ082TE9xZFNkaGJoemhJOGNRMGR2WHVPcmF2dDJVUWdR?=
 =?utf-8?B?SWk2cTVUSXZ4dXNOMzZxL1grZU03VjFQRXFUdTVoKzB2RVBLT3BZckdtdTcx?=
 =?utf-8?B?aTNnQ044cW5yb01NVEhNanV6SlJkQTZJYWgxbGc4c29CVnhmeW5SUU5pR1Uw?=
 =?utf-8?B?ajBaS2cxYk9QQW95VzJyajZxTnd4c0hrUDJjZktENVNSRlRKSUdKaXB2RGg4?=
 =?utf-8?B?NW5XcGJHeWl6d0lkWjZtODB2SldnWk1EV2xrK2k2NWtmb3p1TktyT3BtV21V?=
 =?utf-8?B?VHF2aSsrR3NORkl0d0s2Tm1Ua3d1aUhoaXJNQ1F5NElHWS93SE5GNkRCNkpT?=
 =?utf-8?B?dTZ1aDJxZC8wNzJ2bUR4R3NLSUhlWlMzV0hmd2dxN2ZSVnV5VGo3NCtYZG0x?=
 =?utf-8?B?TFBWb2VkWW44RDdxWXNrNXNrRVVIL0RpUHl1UTRKQlhMOThraXBCQjlySUdS?=
 =?utf-8?B?cGlGcG5iZjlkUGRXbDZNWlRtNXZoNEsycW9RWUN1NTJJZUpjWVJCZzRJbXdv?=
 =?utf-8?B?M3BlenBsbUY0K0xvbU1rcWk0VlVocmtTUjF3dzF2a1NETnA0WW1pb1lZSW1C?=
 =?utf-8?B?cTlwUWtTdG1HRGZLYWZBandUWEdIR2JnVW1PUStsNUc4ZUwwdWhjbkxHbWlj?=
 =?utf-8?B?bEV3MnRjUnRYcnYyMDJRbmVRQ3VpYkhnTmtSTGlvcE1VT1ovUm5yU3F5SUFC?=
 =?utf-8?B?b2Z6T0x3bmRob3AxUlUzV2dEM3Z4LzFBWkNqSkpxb1dsSHFtZWZhR2VrVml3?=
 =?utf-8?B?SnY1eHdvdGJWNlJWeGs4L1NxRUFueUp5WGlycURWV1RKL2FjeWpjS08rVUsx?=
 =?utf-8?B?QlhYTTRKb0h4NkoxU0pEZG91azd2RkhWQzg1NHhFWFNzbnpkam9IRUtuQVhp?=
 =?utf-8?B?L2RBeVl2b1liU2N4YWVXZ3VUVldZM2E0YUw4aHMyS2ZSSGJIZVc2NFVlcCsy?=
 =?utf-8?B?ZjI4M25MbWFqV0JuRE9IOTIvNEZmOTU2ckJQekg0amNXeEdkL0JqWHdvSm1Q?=
 =?utf-8?B?WVhic2hiWStCeW1BOWR2aXVQT3kwcjhVTE5RaDE2c0l0ZXlQalRxU1g1VHdN?=
 =?utf-8?B?R0dTem9wbC9MS0QraitSM3FvWnlTMkthdXVDOFFXU0ZhOWtIRTJBMG5ieDR0?=
 =?utf-8?B?aE84UnNCSmN0S0xCRkE4NWR4dGcraC84N3hHN2l0QXdteUVCejQ5UThrbzdI?=
 =?utf-8?B?Z3RTaC9jaTQ3OGhqSUZpWFFQUTVYQjRMYXQ5QllZb3RJSjZUc1NZcks3Q0Na?=
 =?utf-8?Q?PEaaMjtijiTpxF7A=3D?=
X-Exchange-RoutingPolicyChecked: DkC3IPktLmg+GRXS11Lfng7L72EnOjbOrEv7jL3bDiatcZsPQ3e8mYfh6m2/ML5yQj3FlADzUBb8jnIfgY5dPpE+d98NL1qio0nNwhbIGBY5Fxr1n/A0f+ZR9qBA5wy7ikunUu4QfyXIuBh3LMZlkCkTgBZH/I7/B/aCGLArBTRYxPmQqoARt8H4amQt9RW0icZuMr/xav8FZnUPztlrf2RubuIKWUrEos3NftA2ktOfq7OZkFGyhrVXGhl5bftUBnRsN8Fi5uWbMwrAfqaAYG0aC8O8Gdt4F5ZGiDWUs0DYblmccaD70XhyZ3pYKZ3bUwtl4X+97uetNPTfp9Ydsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f582bc8-469f-4b69-6421-08dee711d5bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:21:32.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svN5zsVP2VMuH0xYd4764PboGksRUTbVf0bVvoXYOzWpOWNcz9JF3gR2+VqwgXKrc4gvvnEvxaaYKO0R0RhYyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7745
X-OriginatorOrg: intel.com

On 17/07/2026 13:14, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
> automatically log detailed error messages on failure. Remove the
> now-redundant driver-specific dev_err() and dev_err_probe() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/alcor.c         |  3 +--
>  drivers/mmc/host/cavium-octeon.c | 10 ++--------
>  drivers/mmc/host/meson-mx-sdio.c |  5 +----
>  drivers/mmc/host/mvsdio.c        |  4 +---
>  drivers/mmc/host/omap_hsmmc.c    |  4 +---
>  drivers/mmc/host/owl-mmc.c       |  5 +----
>  drivers/mmc/host/sdhci-msm.c     |  4 +---
>  drivers/mmc/host/sh_mmcif.c      |  8 ++------
>  8 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index 721db54739c1..45528909a758 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -1103,8 +1103,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
>  			alcor_irq, alcor_irq_thread, IRQF_SHARED,
>  			DRV_NAME_ALCOR_PCI_SDMMC, host);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "Failed to get irq for data line\n");
> +		return ret;
>  
>  	mutex_init(&host->cmd_mutex);
>  	INIT_DELAYED_WORK(&host->timeout_work, alcor_timeout_timer);
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 8a0daddd9200..1bfc1a4f9fe9 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -240,21 +240,15 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>  			ret = devm_request_irq(&pdev->dev, mmc_irq[i],
>  					       cvm_mmc_interrupt,
>  					       0, cvm_mmc_irq_names[i], host);
> -			if (ret < 0) {
> -				dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
> -					mmc_irq[i]);
> +			if (ret < 0)
>  				return ret;
> -			}
>  		}
>  	} else {
>  		ret = devm_request_irq(&pdev->dev, mmc_irq[0],
>  				       cvm_mmc_interrupt, 0, KBUILD_MODNAME,
>  				       host);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
> -				mmc_irq[0]);
> +		if (ret < 0)
>  			return ret;
> -		}
>  	}
>  
>  	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev,
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 5921e2cb2180..bef5e843f449 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -683,11 +683,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
>  					meson_mx_mmc_irq,
>  					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
>  					NULL, host);
> -	if (ret) {
> -		dev_err_probe(host->controller_dev, ret,
> -			      "Failed to request IRQ\n");
> +	if (ret)
>  		goto error_unregister_slot_pdev;
> -	}
>  
>  	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
>  	if (IS_ERR(core_clk)) {
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 79df2fa89a3f..cf705b265e21 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -764,10 +764,8 @@ static int mvsd_probe(struct platform_device *pdev)
>  	mvsd_power_down(host);
>  
>  	ret = devm_request_irq(&pdev->dev, irq, mvsd_irq, 0, DRIVER_NAME, host);
> -	if (ret) {
> -		dev_err(&pdev->dev, "cannot assign irq %d\n", irq);
> +	if (ret)
>  		goto out;
> -	}
>  
>  	timer_setup(&host->timer, mvsd_timeout_timer, 0);
>  	platform_set_drvdata(pdev, mmc);
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 58c881f2725b..63a9fb970975 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1915,10 +1915,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	/* Request IRQ for MMC operations */
>  	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
>  			mmc_hostname(mmc), host);
> -	if (ret) {
> -		dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
> +	if (ret)
>  		goto err_irq;
> -	}
>  
>  	ret = omap_hsmmc_reg_get(host);
>  	if (ret)
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 349082d76a99..d5b8a110267b 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -635,11 +635,8 @@ static int owl_mmc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_irq(&pdev->dev, owl_host->irq, owl_irq_handler,
>  			       0, dev_name(&pdev->dev), owl_host);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request irq %d\n",
> -			owl_host->irq);
> +	if (ret)
>  		goto err_release_channel;
> -	}
>  
>  	ret = mmc_add_host(mmc);
>  	if (ret) {
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index ceed47ccfda8..4aff965f0e2e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2864,10 +2864,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
>  					sdhci_msm_pwr_irq, IRQF_ONESHOT,
>  					dev_name(&pdev->dev), host);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
> +	if (ret)
>  		goto clk_disable;
> -	}
>  
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>  
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 9831956de1c8..7706d01b149e 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1505,18 +1505,14 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>  	name = irq[1] < 0 ? dev_name(dev) : "sh_mmc:error";
>  	ret = devm_request_threaded_irq(dev, irq[0], sh_mmcif_intr,
>  					sh_mmcif_irqt, 0, name, host);
> -	if (ret) {
> -		dev_err(dev, "request_irq error (%s)\n", name);
> +	if (ret)
>  		goto err_clk;
> -	}
>  	if (irq[1] >= 0) {
>  		ret = devm_request_threaded_irq(dev, irq[1],
>  						sh_mmcif_intr, sh_mmcif_irqt,
>  						0, "sh_mmc:int", host);
> -		if (ret) {
> -			dev_err(dev, "request_irq error (sh_mmc:int)\n");
> +		if (ret)
>  			goto err_clk;
> -		}
>  	}
>  
>  	mutex_init(&host->thread_lock);

