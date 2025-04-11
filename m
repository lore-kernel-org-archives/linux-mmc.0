Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9D189B84;
	Fri, 11 Apr 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361464; cv=fail; b=Jpg//rpRXs7T/0NtLZ8eIbUSx7X+Hzxzwhc1Rvr5pYovVuBdwdAEjY0WxSe1hgh3MzU9rjOkScKTZoNmzGlK/H1MwDCmkiMpANs4AYjfvNwJ7r1kXkXKzOCenpJGIEC2iujditsVne96WmXqyZm6Mbd9aswshYv3vxb5Ns5mK6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361464; c=relaxed/simple;
	bh=5pR21+GkGLmoZW/Tm0QT4cLlC9tTdzKQR8iNjuFHTXA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5s6vl3ceeQt59OnKLMrADxSgT+1f6O1Ich2k3gGHu4x4K+ooMYjU/RreeGrv35ysEaZcP9OrhrHvXEWkU43nmkCz7gWb9dDe0hKY1VGIt5ivFLDpgrmoVQ5L/LXBrYC5w4dOQgIpjXdzSw+E+CQ+SqjO2T87bEV0jWIkrEytkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASfG1T/U; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASfG1T/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744361462; x=1775897462;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5pR21+GkGLmoZW/Tm0QT4cLlC9tTdzKQR8iNjuFHTXA=;
  b=ASfG1T/UOWeqr8mYnJnbgzqGZvkFMOu3/m4+tiA2ZDRxLIW9tBTn6N+Z
   uUdeNY7V1+M4xcJ8Mcd5MvBsIxMOaRu9ZpVjzyoZyDH6uORpm83WrZM3V
   fzxqxkZzyaLuLvk9YVJ7kpiKOZP2c0Qrqnw2QMtIdjq9eeeH+gZ13jwhf
   3TjgzAIIe1D6a+JX/3fFIvZJjsiBx3W32vRFhEW1nkLHsz4KIFFSqz/Nu
   TcwDzMWQfFClgg4Q6/XXat66c43RIJVEgkXK1Jq8/iy0AK00X5Hx5M4Kl
   /zEGzBajMKdKyZMqE19P6BOhmlzQWPRgsQ077bXW775k0FPjPVcIok/eZ
   A==;
X-CSE-ConnectionGUID: hQGFtyr/RTKCa6aad57sOg==
X-CSE-MsgGUID: kUD15qV/RWu3Lwf7C0o2Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45997822"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45997822"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 01:51:02 -0700
X-CSE-ConnectionGUID: BKNhLtiUSz+wu1UoZACueA==
X-CSE-MsgGUID: I12YbsFqQ72Ub1UO4UtwSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129983356"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 01:51:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 01:51:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 01:51:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 01:51:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZHUV49Rr8LGGaYLL/jSII31/wuMFoqzpS9Vf5/rlKKjvAThu7ycgBcl2TuLSH2DNTwEes56LLoyP4lAYiF4ebouhEm3MV49m8W3RKgfUV/srlOV7r2Dg7ACBdOcy7x+SXNrDQMzfZiBCt9/WHe/O2vpG4TX4wiFS38cG400+XLVsEkJOTIlfwfAmHAxFM/CT5pBlGCzijDE59wv8srgwn6bbmheF5483Oov28kO1eQuS2JmwEKVL00nKlS0uUCR9KWiog8QkhBoEQparwxdnEegfk0kPz45LQenEn1O3rCSGHyvS+9VmG4iKlPE7FzdEF2S6zYL5Paadz+SV777ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okh8MGTM3Jr+Bl9QAClt4uUnSuVU2UZ2k29nRXqB8OA=;
 b=MIo1K5TV4/K8k1W/088AxErVTnp5wom1i7NV537dcH488peYOjRlfnHVUj8hRllP5dk4HWFNWXt0B9cOzZHVXpPs4d70WXr+FndWyg09A3uTI0FnOwYT/huFNI524CHMgesrhT/nr2AwKw7m7yMuY9wht8/nwdPsbFsflBHTAFnpPM9j1TbDe+J7sAQObi2xL8ivvQ99uSoPxI05ASY7FPO6jJNY5uo+VjL1T0obka71YV9tH54qryIPvU3HXFcpS/BUK/8GyWFHURv09+HRnqYVGNm4gS1FZ1K1Tfr1OlST7I4UkGvYPNAfWDox7wcgrTmTXLM5rDj2FcomI91Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 08:50:31 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 08:50:30 +0000
Message-ID: <5e50249f-5184-46af-8daf-90d88b0a094e@intel.com>
Date: Fri, 11 Apr 2025 11:50:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: esdhc-imx: convert to modern PM_OPS
To: Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>, "Arnd
 Bergmann" <arnd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Luke Wang
	<ziniu.wang_1@nxp.com>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
	Josua Mayer <josua@solid-run.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-mmc @ vger . kernel . org"
	<linux-mmc@vger.kernel.org>, NXP S32 Linux Team <S32@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20250410140921.849213-1-arnd@kernel.org>
 <DU0PR04MB9496EAB4A567BDA8948D434690B62@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <cda876c9-7dbf-4af1-9fc1-cbd9f379252d@app.fastmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cda876c9-7dbf-4af1-9fc1-cbd9f379252d@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bcee75-a2c4-4c39-dec2-08dd78d5e9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDhsU3lIVlJSTFVKVjQzaU5hVFBYSTFNbm5DRnFSV0J2WWRaYUlhaEpTMnFC?=
 =?utf-8?B?T3pKVVJkSjZSN0NMc01HS2Q2RitGNXhXaFFpMGRZQUZYSDJHWXJpaE1US0dL?=
 =?utf-8?B?MUtWR1V0clhiY0FnMlFTYTBRSE1kRDdiYVVla2Mzdk9vdHdSMFNZSWoyN0xC?=
 =?utf-8?B?eGN3QzRtL0R5MFdKQ2tvQXdOQVg5bmpCWm4rWms1UG1aaFRxVjd1bkJJUnkw?=
 =?utf-8?B?L3JtdHAyS0o3dkUvZHYrWTNNM1FHcUtxc2VxSThHcU00Zi9mY2R2Wng1a0hk?=
 =?utf-8?B?ZldXSFRkbmlWQ0hGeFR5eEpybEIrOWhGVkhCTmk1MGF0YWZuY2tmdEllWm9Q?=
 =?utf-8?B?SlE4cjlZekpON2NZWGRQdGllU0RvbG1UNElOMmZJTzJIOHcxTmZQeTRHVHFw?=
 =?utf-8?B?RTI5NWUrY2hQMkU3UjdOTURjam9rdGs2UzVraGRKcFNsM01UeWdhOWJwdlpC?=
 =?utf-8?B?ZWJxVDNjSkdRelp3K1B4ditPVWZaT3RnUVJFbndyUDVkbWZham8xQngweWdk?=
 =?utf-8?B?SEQ4bm8yTlZwZStpY0dHOEdOaFBLbkNjV2xBS0p3Y2w1R0hHcUF6R3lBQ21G?=
 =?utf-8?B?ZFpYZ0ZSbURERDB1TURKNldYbGRxOFd6N3FCUzArUmJBS25ocDc0bE5WMmpi?=
 =?utf-8?B?cm5jdGRMUjNqNUNITXhwM05pcGFZSkIxRitYT3JGcUwrQTJnUTB5bjNEZUJo?=
 =?utf-8?B?TllIMUNOY3VWY01YcFh3bEZBNHI3dGFrWE5FMTRSVUMvTFQ4ZUNpMXJRekFO?=
 =?utf-8?B?RXZ6WmcySy9ld1BUeldVUW43OFBFNFJvM0duSVIxUzVpcFlmM0w3bFpzRUNy?=
 =?utf-8?B?L2FtdVg5WUVOSU5UN2J1QnREVlhLWVorK1Q4bzFUdkhsOFNRMTVHUE01NUVk?=
 =?utf-8?B?QnczMmVKQzZtRDlTbkM0S2JwU3k3dk5FSmVoZjQvMzFZeTZ1akptSnQ0MEox?=
 =?utf-8?B?Z0JUbmdxdkNiSlVuUVUwVFRNWitBSnhjQkxHTVRXblpHM1RnNGx3LzNrdlVx?=
 =?utf-8?B?VmR4TFZ2bmdKWHNjYTA2a3hoNW5UV25uaS9KWHFRTWxkanYvb3k3Rm5Ba3FG?=
 =?utf-8?B?dC9pT21PdUcrRWpFN0pScEY5NStLNlBhSE1BY1dBcHJwZzlLeHBlTWhqRGpJ?=
 =?utf-8?B?YlNDTGJUaFpSRktNTVpRZVkzWWp3ZFdtd3B3Z1paVElNTGphSW1WUW5ZM0lF?=
 =?utf-8?B?RTFORWFjL0orMWZ4WndmdDJOb2tyUmc3N2Z2bFNxb2lxamNUT2JSdUh5cVg4?=
 =?utf-8?B?Yk12RXFuRDdMZk5UZXlKZFdTQzU1dUZxYjNkSTZhYnQrOUZRNmZyWUNpbnQr?=
 =?utf-8?B?REpQYWp0aEszY256M29qMFRQbjQrbHNxT2h3ZVVITXlXN1VHWVBWR3JQTWJy?=
 =?utf-8?B?WHZkY2VZN2Y1c0cvS2FmT2tWRE40a3lOb2IrRmFtTS9vSFlMdHRJTjZxVWFX?=
 =?utf-8?B?L0FBZXBwWmVDWjBFL21xMEVsb3lWV0dZSUV4cWxubDFaOGVZdHF4TDN6MndG?=
 =?utf-8?B?M2JmREdLRytBRHNlU0N4K3dNV0FUTVFIUmJ4bGU5bkwvazFScHRUNEQ0Vkxr?=
 =?utf-8?B?RVQxWWdXckU3MUNpUUQzR3pFUjBFYXErSENFRWQ2VWVKZ1h4U3EwbkR6bkNX?=
 =?utf-8?B?aGdsbWR3K0s2U21DeVp4ZlQwWHhiOHZKTlpGWG80QmQ4UXllK3BpLzVZTzRJ?=
 =?utf-8?B?YkRlNG5FUjM2YVlDblJjcE0yOHFveEhzLzRFclpmaEU2UlFoM3BjNHlTRDRD?=
 =?utf-8?B?S01SWkVOMVBBOWZoOU1VK1NNUzZwR0xiQldmWmhmSnd5ajZIRGNsRlhDM1BL?=
 =?utf-8?B?bVIraHZEbHVML2xSTkN6QXlZVzBORStqeElmMVBEdXNUZ3hQdlZXaHBrWWtR?=
 =?utf-8?B?Yi9hUHpTVjlRZFEzYnlRU1BNTGtCN29ZYVhHRGJjanA1SHVkWHVDWXF6K2VT?=
 =?utf-8?Q?f2LN9GGNOsM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWNKVG9JWHkyUUloanVFVk91Z0lCbmtnb21oLzl2Z0hGL0tCZG1TcEFHZ0JN?=
 =?utf-8?B?YmJKNkhhZ3JGeTVjY3pGSzJLSzhLNFZKM2VYZjJqZ3pmdFNMU0I2N3NHSGRu?=
 =?utf-8?B?enlMcDFrdUFrUWJpakR1dWdOQkhmZ05oVE9lYm92TDlvU2FHVktZUGljelZX?=
 =?utf-8?B?Mnc5YXZRZjFMSGZRV3RjK3FCNy8rdm1iVG41WktpMnF3UXYycndRWXMvR2xJ?=
 =?utf-8?B?QWVpaUJTRHQrK1Q0ZVFOQzFMV3JuQ3ZsNnY0SUx1RXlUMWp0dzZFaVRyL2Ex?=
 =?utf-8?B?Q2xPWXFSTEh3YUdVMkhiaW16TWlSd1hrOVhvd0dvaThaZG1GemVvN0NpR2Ir?=
 =?utf-8?B?eXpVc0tONWVCdnRDTm1jaEJaRFFsdzRWQUFiSnMxaU5DUFFIQis1SHp1cnV4?=
 =?utf-8?B?bHhMYUpKV3RFK1VrT3Y4ZXpkQTZaRUpOQTZmbHFLSnRPY2M1dk1qYkY5WG9X?=
 =?utf-8?B?YnhGL1paR3F4a3pkOWVVU1Fmdm1BRE9wQWtKMzM5czZ6WHNMdktYZUlyVUpL?=
 =?utf-8?B?aVE3L1d6TGl6QXNqRkNub0NVZ2p5ZXVFRDZYaUlkWWpSR2tWNWhzNThpdFVp?=
 =?utf-8?B?MUxhWm9iWDk0d2NqMWVpMUsycG85TEZ4eVRsbDlEVS9kdXZYK1J2TXpVZjRq?=
 =?utf-8?B?c0lGQUVLaTl5ZW9oTHhEWnVWUVhXZ1RLQUZ4OXIrekRkV0JCcmFMRm44WTdR?=
 =?utf-8?B?TVBWQ2NrcS9DOGpUOC9qWllEalNyMFVOYkc5VnF4bGVTdHdzZW5LT0ZwcW9H?=
 =?utf-8?B?SDhWTHowK1YzQVFKOElobnhsQVAxTWZaV3JLdXFYdHJTaklIbTMwemtCdE00?=
 =?utf-8?B?bGVWYkRLR3l2Tkl1bW9SMVFBTkV4ckxQYmxUckx2UUVqNitoMHg1b0xuVTVM?=
 =?utf-8?B?Q0tEN01vU3ZTMTB5TTJEQ3VzYWtVSnREcGJLeVJPUS9jVHRvQVdCcEd2ZFY5?=
 =?utf-8?B?TWR4VVNGL3FGa0RFZ2F1dlhJd3p1azFyaXMydFkzODVubExpZVMxTVhIbXNG?=
 =?utf-8?B?TDlScGNLTlZ1S0ZKZy9ERnovWWFoUUZSLzdqNEJqcU53dFJ1c1RGK0VoemdH?=
 =?utf-8?B?bURObHBJb0xiOGRTK1BKMVRjei93bTc5bWljaXJ1V05MODRveURYRjN4SlYy?=
 =?utf-8?B?d0dqOEJyNm9yb3FCMVg5MHZMTGYrQlBXT2FINkEvU3hBNE5jb3NscW5NTDZl?=
 =?utf-8?B?c2xacU5uVURQUkJxOXVjb2twQTdVM0J4NVN4VDl5TEdONkhmZTZKN2dFTUtG?=
 =?utf-8?B?dkk4NkFXUFFYaXZiTFRUc0VmVHJmVEkyUFk4QVhsdnh1bEVWbVRZeUNTSTZQ?=
 =?utf-8?B?amlYRXVFNDZiTkFVajdWSTR0Z0l0V0xDbW9jWHBpR1UxZkNhSnhBU3NBeGNa?=
 =?utf-8?B?dXYyeE14Q3RPekFQeHRjYkh5emtFTDlHQThZYXdwUGlYSVkxc3VYK0tlYjBE?=
 =?utf-8?B?Y1dzRWRyaTEybUtIeVM5WmJZMnFXVHdFOFYzOTlKM2FRZHl5S054anZDcmVt?=
 =?utf-8?B?L05wcWFnOGR1Tk14ZHlPNUVmUjJwbDVIVk5FempnVm05bXA1UXNVcGdMcHJ1?=
 =?utf-8?B?L05BWHEwc25iQzF6ay81UHc1Z3BIcyszNW9YZXFvWEpLN1RLdXpvVmIvUWJX?=
 =?utf-8?B?M2dTYkI0VkRQMjNlUk95V3ZJcDcxWjBUWkd4VXZBd1FVd2hFNTlqOWlSNVEz?=
 =?utf-8?B?L0VTeWMzeFY1RGxoalViVy9hMG9NUEREakZzUTR2MzJCTUpXMzc4REFHY0tX?=
 =?utf-8?B?VHZNNkFqZFIzVHFNaTJzVnJFSStXRFFOMzhJNWxtZGtac1NkZXhKbzZTZkc3?=
 =?utf-8?B?RTZqNFRUemV4T2xZdFc4Vml1LytUbkl4STJrOXJxRk13SktoL3dXYzdrTlpY?=
 =?utf-8?B?Q1RkMDlUWXB0b08vTnY5VXdaZ05Sc1Y4d0d5amJ0aXpqT1BMa2NGbXA5M0N2?=
 =?utf-8?B?SE9pczhHTXN1aHFUdGc5K1lxZzJUSmNOMGlOZnFHcjFEdnJBTktIc1JMVTk4?=
 =?utf-8?B?K2hac2RNNm9VWisrMXdqOXRUelBEVC9xRkQ1d21aV3lMZGdHa01RUFBzdEti?=
 =?utf-8?B?RlRxWlpMUmJqbGt6Qm5JSndsSThLUzNrenFoajFXekxDYjIwL0JaQWw4TnZm?=
 =?utf-8?B?RW1hb01uMzRpUmxWK0lab0N3SmhhR2RLWlY0dGVWOFlMTzA4dDlVaWp6Rm85?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bcee75-a2c4-4c39-dec2-08dd78d5e9dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:50:30.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEcUVkhwumApTEnvi1QtUyvLPV9nXnxyjupQVthnF5wPBZxVXNRwaJ7NInLFcI+fvbIzfGsz2kk4mq7lrn4JLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

On 11/04/25 08:45, Arnd Bergmann wrote:
> On Fri, Apr 11, 2025, at 04:45, Bough Chen wrote:
>>> From: Arnd Bergmann <arnd@kernel.org>
>>> drivers/mmc/host/sdhci-esdhc-imx.c:1586:13: error: unused function
>>> 'sdhc_esdhc_tuning_save' [-Werror,-Wunused-function]
>>>  1586 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
>>>       |             ^~~~~~~~~~~~~~~~~~~~~~
>>> drivers/mmc/host/sdhci-esdhc-imx.c:1608:13: error: unused function
>>> 'sdhc_esdhc_tuning_restore' [-Werror,-Wunused-function]
>>>  1608 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
>>>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Remove the #ifdef checks and instead use the better macros that silently drop
>>> the unused functions when PM is disabled.
>>
>> Thanks for this catching.
>>
>> How about add __maybe_unused to define this tuning_save/retore function?
> 
> That sounds counterproductive.
> 
> The new macros were introduced to allow removing all the pointless
> __maybe_unused annotations, I see no reason to stick with the
> legacy helpers here.
> 
> I did make a small mistake and ran into another warning later,
> but this fixup should address that:
> 
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2112,7 +2112,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
>                 .name   = "sdhci-esdhc-imx",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = imx_esdhc_dt_ids,
> -               .pm     = &sdhci_esdhc_pmops,
> +               .pm     = pm_ptr(&sdhci_esdhc_pmops),
>         },
>         .probe          = sdhci_esdhc_imx_probe,
>         .remove         = sdhci_esdhc_imx_remove,
> 

Can someone provide a Tested-by?

