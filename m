Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E065134AC;
	Tue, 22 Apr 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319229; cv=fail; b=C6kMM+orla3iJAyRC7Vgif3F4S6I017jiWju+OO168McJSyvp7/8nPzDk6ZZVpUmFeIkMP6DU3CzFCBhL4ntX130O/0F5xq/FrrJHvazwglx2HfT8TA4P62ga1XJJdiB0gQiqH9l84wARNwzBBjKg/iVz1ZkaHTPfYLgpOOWPeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319229; c=relaxed/simple;
	bh=InvuiUDbQzLtAhmSmssgEfbVqb+6udIrhscm4Mv7W6A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWbpaIMNaX77v0KdDD4C7mZIMoqlF3XHPqujN5OAqs0RXeeNOAjaxExF9+Ft355YXXGxuIDeSW2/Ca7J3r4jEnF4sraaS6SWxGEQSlwrAKvrj0FXxz7IR/pBpZ86cd9AIexPWYxehc/3mdaHR1fgQ1AF/AH4fJrWGN4gmG20wK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egFqFMHP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egFqFMHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745319227; x=1776855227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=InvuiUDbQzLtAhmSmssgEfbVqb+6udIrhscm4Mv7W6A=;
  b=egFqFMHP2ysKZADxTpN4DlreNUGyRP2zoWikzmXHrqmWB7JXuUcOXtuo
   txXvGje+VSldrBaEofhGxj8lsM9v663X3fAwLwvoUblWc9cwngo58PZ0b
   QmwMSOibSrr8+wvtZYlCTSFwovvY5t51B4MetVJ0mjEFvGUYv1hXlUjQV
   ZB1Ty46uawcasTYH/bBTq0o4AKy2TWiOVVFfFXupbSK2gPw6w/q75Ua1E
   Qfagopiw/M8srCs6a2HA+FiC8UEA87GTKNoT3RdA4zOOHk2M+I6Dl4J1p
   b0u1PYsi1eq3h2/8j+ees2fxP5xqTwvSCHZ9WsAZjiMvEcJlRPvrBkcCQ
   w==;
X-CSE-ConnectionGUID: HznbS741T5WA90xS7utqeg==
X-CSE-MsgGUID: sbGHdhJ3QlGsfQzyCay/gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46577843"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46577843"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:53:35 -0700
X-CSE-ConnectionGUID: WuVzv8SDTvSQlfqGC6u7bg==
X-CSE-MsgGUID: NKZ0xRqjRGy/G6hiqykgGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="137072690"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:53:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 03:53:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 03:53:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 03:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvUQmIAYp87VFORxsZbzHIcPNHk2X5eftjDLwsiqG19BoKEX4DmBAFSCWAdZReHy9LYDcSiT6p9sPdY0YGWNBDxl4rm+NZhdYo4YKZwGIVRDQ7bv+AUDIswwNT/igrF8XVDLFMSEMZdNcWyW0Hx5k4AA7a0VpkRuYc8QQfBvfo7jBCAx4enp6XLGvS6aSVjTk5oM2uqC2a5m2Rnx2aYpHjWxps4HTqfJq99dMDdMLpuWJAioYqL7maNnBKGgX9P7hbLXOjASbWJ3EBZMWujyMHd85IADgzWCURgXbE8d6dFRGqRLsWj2TX/BLVrnCsIzU3pj3rNvwnl5E+Lr+qAcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB1pQftrdr9RBGG3OIUU3VSZdYqgH7WmDsTG0oFkKQI=;
 b=Tu1WFlMeY5fdYjsyRhA7xPtCuwQMKPJXkOSYCO1YCOWF0Gg/K7KWksSkGukDPW7ltTLJ2Inc004N7Slyd3Sz1Q8lOEWYPFNWLWsb0NKqrhjVFMegYhCc3E8c/lUPrTs8vyduAASR6o2CPt513KiN7MNF9hK6wePeY0XTr5bkJSRduj0Pc6UmroAln4SgoCkdpgks4uci8KIkgoKC6JoHUKwy4+GvRUhkQc7PfGwmjl2BUYxwL/Fxa/YhhRq2kZrINHfPSB6cVgTWqH5RJJIx+du9ViWROu/iTPX19iDIdhMNz1R/MntM1Wy8B7uajlYHu/UwhwvqJuopTpqFF+bBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 10:53:26 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 10:53:26 +0000
Message-ID: <465c3e5a-8b6a-47e0-9777-a6ed15669964@intel.com>
Date: Tue, 22 Apr 2025 13:53:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mmc: sdhci-esdhc-imx: switch standard tuning to
 manual tuning
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
 <20250409075550.3413032-7-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250409075550.3413032-7-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:802:2::48) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4185c153-7720-4880-f503-08dd818be86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTBGSk5zZjlPWGRSanFMNG96dU9JV3ZVVnJsdTRnbFFqS216TXcyazZSbDNG?=
 =?utf-8?B?enp2ZUduR3M5L1RYS0h1SkFyOUdpYzB4Uncrb05HT2FXbDlrbVViY1VEeFlM?=
 =?utf-8?B?WURyaUV2WFlDYmRYN0FTQUE5cDdBY1loUFVTNW5YNjNSNkRHay92SlBna0Zr?=
 =?utf-8?B?WTlPRU54aUxaZnFtQlFoaXZRbTRPSU9nU01yL3Y5VlJIdFRIWW1hOXJzS0xU?=
 =?utf-8?B?ZzlqQStJQ0FUL0FEaGhnVFFoWHNsWDJ2cUJVVmZCU1I5L1dhZ3BvVForckx6?=
 =?utf-8?B?alJCL25JMHhlbEZIc2IxMlY1d0VnL2pUWkNSRDlQaVpDalgxTWJIV3B0QjBi?=
 =?utf-8?B?T3lidG50NWU0dDFQSDh1RlpmcUp4dE5hWjN6QURieCt5ZXlhQVVTNU1RTHcw?=
 =?utf-8?B?RmgrOEcySk5rRFlLeTBhZ3pJaVVCbVp0ckVpSDREeWtrMEZLbmh6NXpYZUxF?=
 =?utf-8?B?cXJLb2pKa0xwMDZhSkZ1L0NqSnlYZEp0Y3Uyb1ZqbGhTdEMwbUFzLzc4VGgx?=
 =?utf-8?B?WElqblJRYUNtbWNtU0MvSmNWaURhS0pxcE9mamtjYmxhaTdoYmVjVXFtRENk?=
 =?utf-8?B?VzBwNTVNdCtKKzFPK214L21BTnhmcGJWOTd4MG5oYlJ3Q3BhUzNzRnByRHpW?=
 =?utf-8?B?SG5xNGQ4RXN1L2drSXdFM2c0VnR0YklJMFhyWFVKeFBkd0NiL3hkTDZZZlVN?=
 =?utf-8?B?WjJxSmc1NklDRkxMLy9JK2lKVVFWRUpHQSs3WnFYRGNDWm52cC9vS0VXclQ0?=
 =?utf-8?B?WUZwSHRVbmE4dXNKTUdBeENrc21QalRDMFVnSDN2YVRUdTZSQ0tFb1RWazdR?=
 =?utf-8?B?NlhURkJvZFV3enNyeEhxb3hXSGQrb29LbC9XRzBZeS9ucWJjdEdWajFPZjJx?=
 =?utf-8?B?R0hDSUhmWE1GYzQ4Y2FOaDdRMkRCOVJBVDAyWDlPYXdDajE3bFhqYk1JR3B6?=
 =?utf-8?B?cnhqb2VIVGpKM3ZrUElQSHF1UlgyWU9rZ2d5dFhoUEF1QjAyRVVGMVJhV01z?=
 =?utf-8?B?Nis5eXJyblBkcDRJTlJtZXR1akV0QmxWVzdIbFNSR0Q4NmFOajRYTytVSVFD?=
 =?utf-8?B?R2RKTm1OVGtzUDkrZGhxUnR3MUx1Vk5UVG5xMjY2cmFmSjIycXJETS91dmd4?=
 =?utf-8?B?SEVGVEZiQmVqT3Vpa1BNdnp2TElUNG1WQ3o1Z2txaWtncjZWeTFvUm5Cbk1L?=
 =?utf-8?B?a1A0QzAyVTE5Q1c2VTc4d25LeTUrQnZ2eC9Qajk4TkRWTGVodVZIazFkQnFI?=
 =?utf-8?B?T0QyaTN5ejVNTGJlS28rUDNEQ0tXL0JYOFoxbUpXMEJTM2JuSVBaN2puaVlT?=
 =?utf-8?B?NHB1WEVOUFVud2h6blZwQis0bFdWcWplZHJaTDFJbVhqemNrZUp3RlcwWExh?=
 =?utf-8?B?QlRIWklNSFI1dUpQb01Vb0EvVXpaOWI3K0dLQTlqcm9yVldtaDl1ZHlMd0NI?=
 =?utf-8?B?ckhnaXdWMGs1MS8yZDhFQXVoWFUzQ0J6eEVabzJQWGNOaXBMMWxXc0NVb1Fz?=
 =?utf-8?B?ekYxRnpFeEFObmMwNzB3QjN5M3V3QjJYUWJpQy84QTIwMmpsUHAxMzltRTZi?=
 =?utf-8?B?ZG5sc2R2Z3FIY09jNDA2VU1sUkdHUUNuOEErdm11MGNlN3BsZWUrVU4rWUpX?=
 =?utf-8?B?NXd2anprWWNvZVJFcFJiQS94Z0Zqa0pRZEJWYTZPbFhQVXRlcmYxeGwzQVhm?=
 =?utf-8?B?VFdQSU1VaDBvWFBjb3B0N0tYK3BLM2RyN2l2cjUrUndjTVhFQys1NzhGbS9V?=
 =?utf-8?B?cGhIVDczZVFZL3kwMU1McThDWXdaMWxTdjJFQi9DdDVJbkx0d1hDeW9JS3gv?=
 =?utf-8?B?cHFKdzFrbEVGa1Y2SEpVOUVickJ6M3RsOHdvTkdLOVdkSisveVpCRVh4V0lQ?=
 =?utf-8?B?cHBkUU1ETnZzMko2bUtxdlNBLzlzNGl3YUNDa01wQXJWYmExMlVKM3FhTUlk?=
 =?utf-8?Q?P+ZNBhMZbIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJJY2s4aVoydVZaTzJlSk9IMm53RHpiWFoyQU5KWmRTSGdybXN2ZHhvSTEw?=
 =?utf-8?B?NWk0dmE2RGRvZmc2eXZjMVZRSnc0SWFPcUU4SXJ2bkZlVlFMWlBST1c3Mk5O?=
 =?utf-8?B?WjNWb01neVZXanAxUktENUxyMGhEeXVkRm1oMlFkZFA4MHM1ejNOckhBZjEv?=
 =?utf-8?B?dFdEZGFFSU1MTC9iTktaQVdRd3dxMnREZFVrT0tQNm9QR3ZxZ1orT1MwU05l?=
 =?utf-8?B?aktVQVlVbEJrR0trcHphUXVOOFBjY1o5cjhwdmxEeFRudTJXTjU0OHY2NCs3?=
 =?utf-8?B?Q0pRMGRybFQyVWZWR0lIbWRjK293eUpPMHRwY2E3Z1RReEZZY2ZwS2p6N05u?=
 =?utf-8?B?dWFYaEFxaHJ5SjRNeUQ0d3p0Tmh0SnB4Qysra2dSVC9FYXBqUXd1ZFUyT0dy?=
 =?utf-8?B?MjhWZEVjalFmUFFvNktaVFB3WndzTG5uTURQMnJLRUs2dTdTT1lkZkpiWlhL?=
 =?utf-8?B?ejljRFNubHhJQXpXVVN1bWpzQTZma296SFZkMFVsNGk5R3ZHZERtYzlzY0tY?=
 =?utf-8?B?WktLQ0xsWUJNTlAwVTVLbGwvRTFRY2gyQ2ZmaWpweUFiQzZZVTJCWUl2RU1i?=
 =?utf-8?B?OWZFa21ONnlyU1lFNjFDN29hbmo3dTZ0VENURGFVRFdaRDA1L2dTV3ZIR2cx?=
 =?utf-8?B?VWdEbUhyZk8xQTNPUVNPaUNCZkpJWWgxV2E0M2I2K010RzNTd0hIYVY4ckxq?=
 =?utf-8?B?VXdJblNBeUhoZ2NxTEZBZFBtWm1RRDR6V0NVVHdyeGJpbWJNdGttbWdWSGJR?=
 =?utf-8?B?MXlkS2drQ00vaVdDcmdMMFhTZm5JMmhDQWFtZk1qNFZ3dTJhZnN4c0JPd3Ns?=
 =?utf-8?B?SXp4dVdOUHhQVlhabEVBL2E1Q3hBUElsbzBUYWVoQldNWXFRamQ5Y29oVEds?=
 =?utf-8?B?K0t1TTRQUDNxSUJrOWk0WlowN295UVRHNE5RUDNveS9KUnM5NGJJcmd3Y2xG?=
 =?utf-8?B?ZnBNbjdTQWlMME5Dc1BNOTBLYUxCSCttOUhOUnppVHl1MitENkRTcHNtTjc3?=
 =?utf-8?B?TURkdWlNaWdZeDBCdEdDOW03OUNNVzFLdUxWUStsazB3c2pXc2g3NXg5UDlW?=
 =?utf-8?B?QkhaRjdNU2lGNnJzOXRtc3laSEdhUGtLMEU1cjAvbzU2d0FsYVRTOEcrNi9n?=
 =?utf-8?B?QVNIQkpKZ2dJWTVEYVIyZU1DWTZ2bVE1WCtpOGFtR043dTJQYnpjc0ZxNi9j?=
 =?utf-8?B?dGk3WjJzWVFSb3hLK0lRaS9xaEQvYVI0MXdzV1lqZGpXS3c5c0V0cDNLdm5U?=
 =?utf-8?B?NDd1TTRhWlM5Nlc0dHNKdHd0TjJvbFFyOEgyNjJ6OWh2VkdtSHUvdlAzU09x?=
 =?utf-8?B?MVo2YXdvcDJHZFR5cHBsLzNuak03ZlJhTVF1NUhndjhyckkyUzdtUVBjd3lw?=
 =?utf-8?B?ZEhGVkxySE9RWkFKZHljVWpJYUZVYTFTNjR0VlFOck9WUlgxVmQwRmxlaVov?=
 =?utf-8?B?dWRBQUdEdFptZW00RU8vb1lidUkyU3RVZzdIR0F2NWc2ckJhZzQ4VHdMU1Iy?=
 =?utf-8?B?TjhMTUJON2d0Z0JMbVU2T3dOU29FNVk5Nm9JaDM4Ym9WRWhDWmVlOWpuakls?=
 =?utf-8?B?NE1QRGp5bDB6aEwvZkcyeURPazFPdmw0SElzdDRoOUs4dVpEQTQ3UjdDaERT?=
 =?utf-8?B?M1ZBRlhtZjd2Mkw4R09EU1N5QUdROWt0dDNGRXJyU0haK2FBYlg3dnJHQzlD?=
 =?utf-8?B?ajBuS2ZoMUxLMU1mTHlPSDRwTjgvbEJFWmY3am1EOWYrZVRIN28zb2xMTlY3?=
 =?utf-8?B?U01yL2Y1MTFRRXpHSmk2di9EZ1AyRkpPdnFVbzNhSU00c0UwVUtEczJmb1Fz?=
 =?utf-8?B?bzBKUENSc3BBRGV4WmpFNmsxTnBhdXVRTVZCRTJTdlNnSDJKek9IaFlTZktu?=
 =?utf-8?B?Q1dwSXV1SEdqK2tqVFoyTFJkZzRWQ1BaOXR6R3c5NXZrL21SMGVoM2ZrUXRZ?=
 =?utf-8?B?amlWUUNSUm5PVU1Gc2d3V0FTV0QyY1JsNWRoWE01YmwyeGgzcG9TQzliWHV5?=
 =?utf-8?B?eHpoVUxxbFMyVjZPZWdUdVNzN0p1NUc5WkFoenNNdWlGdzhHNzhVdmRSaStp?=
 =?utf-8?B?NjYrQUtwS1RBTkFULzhFY1h5dTlBZkhHY0hraTFuYnh5THkxVnMyME5FbHps?=
 =?utf-8?B?YjZnaCszZWpIelBtL1ErbHF6MXBXcS9ESWludGxXTVJxR09xZFErRHpXamxR?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4185c153-7720-4880-f503-08dd818be86f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:53:25.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU0RlOTjxRWub+QpP7zfhjfH2PkxjMqx2/Sk9h5V5aV/O1mlHkagx60Z9+HD12MctxdJaWh6Sdq3zWoO/W2JzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com

On 9/04/25 10:55, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Current standard tuning has some limitations:
> 
> 1. Standard tuning only try 40 times to find first pass window, but this
> pass window maybe not the best pass window.
> 
> 2. Sometimes there are two tuning pass windows and the gap between
> those two windows may only have one cell. If tuning step > 1, the gap may
> just be skipped and host assumes those two windows as a continuous
> windows. This will cause a bad delay cell near the gap to be selected.
> 
> 3. Standard tuning logic need to detect at least one success and failure
> to pass the tuning. If all cells in the tuning window pass, the hardware
> will not set the SDHCI_CTRL_TUNED_CLK bit, causing tuning failed.
> 
> 4. Standard tuning logic only check the CRC, do not really compare the data
> pattern. If data pins are connected incorrectly, standard will not detect
> this kind of issue.
> 
> Switch to manual tuning to avoid those limitations

Is it necessary to have standard tuning at all then?

> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index fd0ad0ad1519..9b66e07ed8e7 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -275,35 +275,35 @@ static const struct esdhc_soc_data usdhc_imx6q_data = {
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6sl_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
>  			| ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6sll_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6sx_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
>  			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx6ull_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_ERR010450
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
>  static const struct esdhc_soc_data usdhc_imx7d_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> @@ -319,7 +319,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>  };
>  
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> @@ -332,7 +332,7 @@ static struct esdhc_soc_data usdhc_imxrt1050_data = {
>  };
>  
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> @@ -341,7 +341,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
>  };
>  
>  static struct esdhc_soc_data usdhc_imx8mm_data = {
> -	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,

