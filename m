Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF260139CFA;
	Thu,  6 Mar 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271304; cv=fail; b=DVREKel2Cg4myA5R09AldBDrtdqPiePCp/xMYmLrAxafjrQSU495l4CDHo6SBuJJHFobEowY+ymomUD/1PQFBBoOc4IP/kyZ0hGcDh9HCs69nn63f1w3HvVqOFH4dkaLTuu48uz+NNUd2DZ+yU2rjKSwPWMqWsQxIBwfjzGtEc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271304; c=relaxed/simple;
	bh=pH9ytqMOMtRlpl9TNqS1WX6J6YwfyXKod1wq4t0xyQw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WzHvhlzxbi8/4szjCumsrtcE/04ovIIfaI7VfKuPgHfXXIa22hFj5BuzrAxDkDO4BVh/DAvvXFNXJN5ajxFUtVWA8tcoJbv5QZDhJIo6RbNitI/wCg+zKlx5wsoOZfNllvmdLRTP9Hr3Q4xurhUgpQ3sLe5TewkVKFPqxXjsIb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8HbfpWI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8HbfpWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741271303; x=1772807303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pH9ytqMOMtRlpl9TNqS1WX6J6YwfyXKod1wq4t0xyQw=;
  b=e8HbfpWIHSsszS1jLnnQ61JWrMD272S8m6hVTlgLrFZu7JFv+kgMmTUH
   HxQ+/KzlICmPOd866xs0cuAuI+vbi28vhFKZw0KM4j9l0XpHe4pFMaox9
   SSx72d/0nuSwPjk/0FRTLpuhyKhUAhELmVmxfqPAPOfSuKy7vZFMywGjO
   GXulRoh1ztn2p0QNZHwIOKVi1c/rMIwiXWD2ho5RrpPjkmeVXMg2EPWgq
   oGlgSuuF3Cw2DCQbgr/hnIPm1SNK9k8ph2iq9z1usdEyd738+62EgUSe6
   GeGazs6gdJR4ezNrLF0P1aN1vycu9Ruq8eapK0UHElcG5mTwaYPTqoRrb
   g==;
X-CSE-ConnectionGUID: MSvBJnfbT5ynsHcDBGZi2w==
X-CSE-MsgGUID: XhoisxVcRb+jEFYtCX85mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42141581"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42141581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 06:28:23 -0800
X-CSE-ConnectionGUID: QuOnebScQr2/IR5Ck19M3A==
X-CSE-MsgGUID: 9XTU6luZSZue+sg+Obg/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="118771065"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 06:28:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 06:28:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 06:28:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 06:28:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM4QZDpb6OGSCsqUv/wh786tuxyIYyZImpvyiN46fZTYGPhW9G4TeogeeIoYPOin/UvFMbpiK95B+2PFaud/yIvaVH1sPI5HimElnFCt/KkdTegJmFauIWxqALfaclsw/rLnavsdb8J6Tcepfyalv1K7bhZ3KWSSJ/y61ccUZ58jgHxjNoDDv6wTGzNir2DdYLH7sQxnqgUWes/Dt9STFccEx/eCxBba/zUWJmts9Z82BEhpiIZBH+B8j4yH04uG+Ha4MeInP41gsdor+nswgG8qGdM9R2qbUWY5MYOWBEk7vDWM+Hia1hpBTiGqVKmHiRwrdwyF9JlFIOw61WzFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG/BOhDsrL6wMhIV4oxnnPMOCGxzGmIJ9kdUeApZ+Ng=;
 b=Vl1g0IGot2+OIOWqNar2HLxuKIk8mc/Hocxmm7Fy/hyGPFfM34nOp0WDT5KExosSFfMUb8KyE/RT/3WXXyKh8AuaYsXE5m9UULIOT/XEdqAz45CdzVoy3sjq4Qk/KBYQDfamVG9fdDbQYKYmPkUlhoYHX47Rx57FCb/ibvz7ucrhDdUKzTAq+eAoXB7XAgJUHXofEuMR4Z0SzWVnEYhkJm4wq5sBwlTyVMTOgrNIbMlGKgwr+v++D4XWG2O3piGXZKipUh+ViEjpEdT+GQWYo4sQZQYjrSqRNw3CoWePfJQlqtb97owjYl23Ft/chEFvP12ZSNFItAlzmJ0p5GoPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:28:05 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 14:28:05 +0000
Message-ID: <7fad9ddf-f113-4c07-965a-5c515f1def7b@intel.com>
Date: Thu, 6 Mar 2025 16:27:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V23 15/16] mmc: sdhci-pci-gli: enable UHS-II mode for
 GL9755
To: Ben Chuang <benchuanggli@gmail.com>
CC: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Lucas.Lai@genesyslogic.com.tw>, <HL.Liu@genesyslogic.com.tw>,
	<Greg.tu@genesyslogic.com.tw>, <dlunev@chromium.org>, Ben Chuang
	<ben.chuang@genesyslogic.com.tw>, AKASHI Takahiro
	<takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>,
	<asahi@lists.linux.dev>, Janne Grunau <j@jannau.net>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
 <20241018105333.4569-16-victorshihgli@gmail.com>
 <20250219213224.GA57799@robin.jannau.net>
 <CACT4zj9Xgah3Gp-=Ujp-z7hRCmHt_aGnLEchurN00M1LtbjSzQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CACT4zj9Xgah3Gp-=Ujp-z7hRCmHt_aGnLEchurN00M1LtbjSzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|MW3PR11MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 65772253-081c-4ad2-4dd3-08dd5cbb1b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yit4S0NOU1QzTmlia2YrT1VBM0pwTE1IZEJPTEQzVWx1U09BWTRzeFRWSGpq?=
 =?utf-8?B?U2Z3eEtkY0lPM3pGOFAwNEt6QWFHSHltajNxbEkvY3JBV3o4YllzcEwrTmwx?=
 =?utf-8?B?akpqVjhMTUt6aENoOEpkMlM3SzRxVUZQZTRsSTYrc0JZTEFiQnN2U01mVVph?=
 =?utf-8?B?YjJmK21JM1JRRWpyREEyc00zNjMxVGZRbzduakdYMnZkYWU3WVFkc29oL0gx?=
 =?utf-8?B?c1F3TGF6Q3piMGp0dzZ0TnF0SDA4cjFKN01UL3E3alNFb09QMEJnYnptV0kx?=
 =?utf-8?B?V3YvQzMvTytCamRLcVpsZEphY0ZRem01Kzl5Vk05eHVBcm5JRDR6K1JJTmFx?=
 =?utf-8?B?UUxZek5lSlNrcW5xaUQwVzUrcjRkV0dQdHlYZ2p1Tm12YTk5WkRuaXpMVUQy?=
 =?utf-8?B?VGIweTVGZ1E0b2lIOFdKblQ3bUNvOS9EeW91emM5YXY3K0NkWUNDOUtFa29j?=
 =?utf-8?B?UFVCdEZlRW1hRWxiZGZNVHZ0K1VpcS9OdE5yTEszYVRqOFhUWnE2dkpmaGdV?=
 =?utf-8?B?VEJjRlRVY2VIeDg4WXdQZGovWTdmUmVSOHNCL2FhbnNWcjBDTTZTWnZnV1FH?=
 =?utf-8?B?d1VhQVVBclRsQjEyK3pDcDhzelFNT2xNelF5SklJVXp6UHEyaHc5OGZUZDgr?=
 =?utf-8?B?MitDcnVIWmFQMXZnRVRVZjlGSXZkNVZsalJtZzBJdzdHYXVrL3hQRHVCUVBM?=
 =?utf-8?B?L210R0hMK2pWcnhOU2dvM3JXKzRUb3pXR1VwYXpNYldHYUt5MCt4NVBtL1Rk?=
 =?utf-8?B?Q25uWksyRE9IYzFqVWlLS1VqY0ZJVDBNVkN3U3NUalR1VEZoWTV3SThCSCs3?=
 =?utf-8?B?U0E4UUhzOW82MlZWblBXUkNhbW1DVUJpZzYwa0R1aUhPV0VvQzgyVGNLMUo2?=
 =?utf-8?B?d1RINUVQd05YK0YzZ09YN3dKWUk5UWpFNHBKaXMrTGVsQXArcklxR2lIS09m?=
 =?utf-8?B?NDk3RTJabTlBTFY0YUlXMFBudjcyVDhWV0FMK2hicUt1VWpna1didHE2cEJm?=
 =?utf-8?B?WUd2UUNPRWZpZXFTTlpDbXBNMEdHOTd3Y1RnZDdBUDZ4VU1UUW9MTGVLeUp6?=
 =?utf-8?B?Nkt2djI1cFdlK2NJUVpianAvbWlNR24rbUxEUURkelRqWEt1VEp4ZnZNZDND?=
 =?utf-8?B?NTZIT0VrWHhSSjl2cmJmWFV5N2F0WEdlUFBkWkJsK3hLQ293NER1bEt4S09L?=
 =?utf-8?B?SU5hRW42L2pRcUhIRG9tWVFLby9kOTZzWUhWQmNpTW1LbGxTTlNMN0hSTmlw?=
 =?utf-8?B?WlFxL3hPZ1BpZ012bjRSNjZBbGdvQ0tzQm5RRllMbmtWS3JlTWh6czd6Z3hu?=
 =?utf-8?B?VHZSQ1lyVW53TW5jRkhYV2x4YnBlSlp4Y0U5MGJCdDRuYXpSUTgvQzBzdjBJ?=
 =?utf-8?B?Z1psZXdwNWo0d2Z5aGtVNDdjemc0a2NTNW1YL3UyRzBqWEZwSExaamFXemxq?=
 =?utf-8?B?eVFNTTM2S0hiYUlGUnJHNGdPRy9DY2VMYlFmbVhLZXJtcEM1N3haa0lVZlZH?=
 =?utf-8?B?d2F5ZHVKOXNXZGZJWENpR1c1dlJUR3VYVDgvM3BCcG9BRU5rUkVHdS9iOUZ5?=
 =?utf-8?B?aUg4SkdlM0VCeEJnVjVtNzBTTEtLY2dMZHI5aUM3TnBuMXVUVDREV3JzdHdy?=
 =?utf-8?B?WlNtU1Q4N0YwN3pjcnU2Vjd3cWRVYUVBRFFWNXpRbXlxRmJLWkVOOTVrN0Ix?=
 =?utf-8?B?TTZndnVPanNRZHBrUVVpUlRYTURDdEhzdEtSNkMzVkRyaXpocXNjNmYvSjlo?=
 =?utf-8?B?SkxsaGhwTzA4M3ZlM2ZaSHNhQmJmdjErTmZoR0xDQi9PM0JIcVdOTm5pYy9v?=
 =?utf-8?B?bTJCVk5rWERHdXZaWFAzeEx0Z2J1NFBSS25WY0tWUWt1VUNnUmlSWUsvSmZX?=
 =?utf-8?Q?aY4vcEIrDzkru?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnRpbHE5cnNBTm8vTHhxZkRDRVFjVEtoUldLZllQTkpvc1pvbnVHZE1mMWtB?=
 =?utf-8?B?cTBwcS9CcHlZdTUyTjhlZnNSM2FoTzhzaE0wNk03TkVHWVFtcHpKRjExdDUr?=
 =?utf-8?B?ZlJJZ0w0aXlueHltSkJrWGc5UnJDUzR6a1RWZllvVW80SHhicDNYYzJJU2F5?=
 =?utf-8?B?alJSUXQ5cERzSnNvWjNVaEhhVWx2T0EvNXoxWjFnMkx3OGZqNXpYakZNWnp5?=
 =?utf-8?B?NlJnNXg2SC93d2kycTJ4ZTJxTnhwalZyZ2JCdEZ5Qi9hZTdpSWlMWUduMzFW?=
 =?utf-8?B?bWhGT2owaVNMS0ZoSUlnSDFKYllUQ0pTeHRxaUprWjIyQ3Z3YXdreVkxMVZM?=
 =?utf-8?B?ekp5REROdVczQmxUU0dCYUxoNnhWUmRHNC8xL1d2WEJ6eCs3YXZlK3dPRDRs?=
 =?utf-8?B?ZlNQeklqL3hlK2cwNHhPcXk1bTRTQmI4MGZKY3NZOHNKY0JDeVlFK2xiV3M4?=
 =?utf-8?B?Sm5vUzhTZnkyekdONnBVczdhWkg1TDJSY3VXSFZTK3lKM1NRRW1kcktPclhu?=
 =?utf-8?B?KzAzZ0V5NVhpMnZKZklaNlV1Z2pVS2E3bGR1TU9wRHl2RzR5aGVWQ2hPbEZl?=
 =?utf-8?B?YlgzTGFsbFpXRnVhWm1iRjJ2dnB0d0ZLbkVLbEtwN3pZK24xWldxMjR2OHZ4?=
 =?utf-8?B?ekFSQ1lZMEd5NWtKS0N4eTBLWUF5V0o4VnJtaTVNdTA0dkJvRnBnN1BDNExm?=
 =?utf-8?B?SFlVY1NSR0Z3d3JLeVk0VElsVE1uU2JKdHNsUEtFM1dRR2ZJUmlqa3RNOWFR?=
 =?utf-8?B?Qm13NXJwSkY1VnhLcmh0WlppdWIvY3YzZDNzb3dqTmF3RWJNa2dlL1EvQkE3?=
 =?utf-8?B?djcybm9SSGloL3JFUFhUUUJHc2s5TjZkSTJDZzdSRkJiWWdHTnNOZ0ZtT1dt?=
 =?utf-8?B?K09qR0dhdDhJenZJUnZPQnVRaEw1M1BhR2dRL2dBNERFMXlEeENUdHpPc3ph?=
 =?utf-8?B?MDM2azV1Y2ovbDdYNWRNejYvczVkb1lSMHJzbmRpc2MrcFJGcXlYMXhkQVhW?=
 =?utf-8?B?aG5BdW9PaEdPNjR3aFpXUkYyQmt3cU1nRVU2QjRkOVlLYkFKNGRMYWRsT2RM?=
 =?utf-8?B?TGptWHdpTFByUHNheWsvTVd0dTFKTlJqTGJ4OWQ5T1VJTm9qNzJwMGNEUTBi?=
 =?utf-8?B?NllJdmt5R3JJR21YeEU2c3BrK2VNcEN1RjFFQWl6eTBOVGxxejlrMzFQRFlK?=
 =?utf-8?B?WEJYZW91TG9iU3JSQlUrbjVESHZabDFBVjRidTVSSVZHUklpM2hxeU9aOFJT?=
 =?utf-8?B?VVRkQUdEaXhpNThLQ1IraDErclJndVN2dUYrQnF4ZXVXNFhjTmVUSExPZysw?=
 =?utf-8?B?VVFVQTFwcTRZNEpnTzNFRDM3V3JES2lTRUdiMXhBTlE3WGJwQ1g0NmovVnll?=
 =?utf-8?B?U1JmdTkwVW4rSk1ydkV4bGFOQ2YyQk1lQlA4NHFLTzQzZ2tjTU03TFQrMTBo?=
 =?utf-8?B?aDZJeUdPR2FUWWM5S2VCSXFuQ05SZ0p2eGVKcWV6SFRxRWRFeUxaTGhOS1Zs?=
 =?utf-8?B?U3ZGaWptZjNBZXd0SVlVSlduMzFGY0xrVllvdnNyNHhBeWcrdUQvSllabkZG?=
 =?utf-8?B?S1M4TGpJeXZQallBN1NMcnJMZ0NtTmVmYU45NThNdFhzYUtzT003Sm5CR01k?=
 =?utf-8?B?QUtTRFVHVkNhcmNmKzRCdGMvSy9KeVhmdEs2bk04OFhXVXVQQmhVRmp5Z1oy?=
 =?utf-8?B?SHZiUVF6eE5QZVozdnFTQTA5K1BxM0ZibkxRN0VuWFdFdWlOWXBvWXhVbDcx?=
 =?utf-8?B?ODREM2hOcW5jRHJxU2I4dE9RREVwOVVUWHRpcGlJQlVYQXZOeGlIQW83cmNW?=
 =?utf-8?B?bDlwMnM0S1NEdmlrczBhaG9GbkU1OTgxZHVLUXBGL3YyQWNicVpFTGd5R2Q3?=
 =?utf-8?B?R0Nzay9qamQrZjIxZDE2VzdBOE5VYmVoMmhqaS9GK3p6SmhUWERiQVo5WERV?=
 =?utf-8?B?STZCNUx4WjRqOWhjQ3JmQ1p6OENkZG1TQjA4WktpV0x3K2tNaTBONVRZM2xw?=
 =?utf-8?B?RGRNakE3MjBSbjJXSVJqS1BsdENXQVFxNkNZckxkZytWQnFkaEJSUGhaS2Y2?=
 =?utf-8?B?TjUvQVp4dnFnK1BRV2RiRlI3T2VNdG5nSHJrWUtMRU5Ha3J1MzJsM1U2K05Y?=
 =?utf-8?B?UHV6TWowYkZZTnBBSWZnUFBBTlR2akc2Q0FJUGkyWEN0UnBCSlRqV2JWRElh?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65772253-081c-4ad2-4dd3-08dd5cbb1b7e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:28:05.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr2ScT4q9DB90+CJD6SmdstbnTx7NDZRdCR9veskHs+80Il1sGk4F/6Al/l0jRSOTcinB6p1x4WIX98O9zOYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4764
X-OriginatorOrg: intel.com

On 5/03/25 02:56, Ben Chuang wrote:
> Hi Janne,
> 
> On Thu, Feb 20, 2025 at 5:32 AM Janne Grunau <j@jannau.net> wrote:
>>
>> Hej,
>>
>> On Fri, Oct 18, 2024 at 06:53:32PM +0800, Victor Shih wrote:
>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>
>>> Changes are:
>>>  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
>>>  * Enable the internal clock when do reset on UHS-II mode.
>>>  * Increase timeout value before detecting UHS-II interface.
>>>  * Add vendor settings fro UHS-II mode.
>>>  * Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl variable.
>>>  * Make a function sdhci_gli_wait_software_reset_done() for gl9755 reset.
>>>  * Remove unnecessary code from sdhci_gl9755_reset().
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
>>> ---
>>>
>>>  drivers/mmc/host/sdhci-pci-gli.c | 235 ++++++++++++++++++++++++++++++-
>>>  1 file changed, 234 insertions(+), 1 deletion(-)
>>
>> This change results in error messages / timeout about UHS2 followed by
>> register dumps with the GL9755 integrated in Apple silicon Macbook Pros
>> and Mac Studio systems. Non UHS-II function of controller does not seem
>> to be affected. Apple advertises the the SDXC slot as UHS-II capable.
>>
>> The only quirk we've experienced with gl9755 on this platform is that 8
>> and 16 bit MMIO reads do not work. Workaround added in commit
>> c064bb5c78c1b ("mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads
>> as 32-bit reads.").
>>
>> If you have ideas or patches to try I'm happy to do that. If not we can
>> look into what MacOS does.
>>
>> See kernel log and lspci output below
>>
>> Thanks,
>> Janne
>>
>> [   38.130033] kernel: sdhci: Secure Digital Host Controller Interface driver
>> [   38.130141] kernel: sdhci: Copyright(c) Pierre Ossman
>> [   38.133352] kernel: sdhci-pci 0000:02:00.0: Adding to iommu group 13
>> [   38.160551] kernel: sdhci-pci 0000:02:00.0: SDHCI controller found [17a0:9755] (rev 1)
>> [   38.160655] kernel: sdhci-pci 0000:02:00.0: enabling device (0000 -> 0002)
>> [   38.160750] kernel: mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA 64-bit
>> [   38.274617] kernel: mmc0: not detect UHS2 interface in 100ms.
>> [   38.274717] kernel: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   38.274782] kernel: mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
>> [   38.277391] kernel: mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>> [   38.277475] kernel: mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>> [   38.280125] kernel: mmc0: sdhci: Present:   0x20070000 | Host ctl: 0x00000000
>> [   38.280206] kernel: mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x00000000
>> [   38.284511] kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000032f
>> [   38.284592] kernel: mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x00000000
>> [   38.284636] kernel: mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
>> [   38.287200] kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [   38.287281] kernel: mmc0: sdhci: Caps:      0x396a3281 | Caps_1:   0x1803057f
>> [   38.291212] kernel: mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x000000c8
>> [   38.291292] kernel: mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>> [   38.291335] kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [   38.293513] kernel: mmc0: sdhci: Host ctl2: 0x00009107
>> [   38.293604] kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
>> [   38.297842] kernel: mmc0: sdhci_uhs2: ==================== UHS2 ==================
>> [   38.297923] kernel: mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:  0x00000000
>> [   38.297968] kernel: mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode: 0x00000000
>> [   38.300773] kernel: mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel : 0x00000000
>> [   38.300853] kernel: mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
>> [   38.304739] kernel: mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:    0x000000a7
>> [   38.304811] kernel: mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn: 0x00030000
>> [   38.304856] kernel: mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
>> [   38.307110] kernel: mmc0: sdhci: ============================================
>> [   38.307201] kernel: mmc0: cannot detect UHS2 interface.
>> [   38.310110] kernel: mmc0: failed to initial phy for UHS-II!
>> [   38.424645] kernel: mmc0: not detect UHS2 interface in 100ms.
>> [   38.424731] kernel: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [   38.424758] kernel: mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
>> [   38.424782] kernel: mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>> [   38.424840] kernel: mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>> [   38.427603] kernel: mmc0: sdhci: Present:   0x20070000 | Host ctl: 0x00000000
>> [   38.427659] kernel: mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x00000000
>> [   38.430579] kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000032f
>> [   38.430626] kernel: mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x00000000
>> [   38.433504] kernel: mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
>> [   38.433550] kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [   38.437596] kernel: mmc0: sdhci: Caps:      0x396a3281 | Caps_1:   0x1803057f
>> [   38.437641] kernel: mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x000000c8
>> [   38.437677] kernel: mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>> [   38.440318] kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> [   38.440345] kernel: mmc0: sdhci: Host ctl2: 0x00009107
>> [   38.444119] kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
>> [   38.444161] kernel: mmc0: sdhci_uhs2: ==================== UHS2 ==================
>> [   38.444184] kernel: mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:  0x00000000
>> [   38.446918] kernel: mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode: 0x00000000
>> [   38.446958] kernel: mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel : 0x00000000
>> [   38.450833] kernel: mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
>> [   38.450874] kernel: mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:    0x000000a7
>> [   38.450907] kernel: mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn: 0x00030000
>> [   38.454625] kernel: mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
>> [   38.454665] kernel: mmc0: sdhci: ============================================
>> [   38.454699] kernel: mmc0: cannot detect UHS2 interface.
>> [   38.456705] kernel: mmc0: failed to initial phy for UHS-II!
>>
> 
> On which UHS-II card does this message appear? Please share the card
> information.
> If it is a UHS-I card, this message is normal.

If it is normal, we should not be producing error messages
and register dumps.  Please change all these messages to be
debug only.  The register dump can go behind DYNAMIC_DEBUG_BRANCH().


