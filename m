Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E524C213E71;
	Thu, 27 Feb 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642644; cv=fail; b=nE6BFJXbFlY7g9D6a0MheySrvn9V9kSjcbvJZQIiSdeKy1HexBPbT80ocm0wStB2OMkL69sBrpeG+M8Vr1ro0HTgIpyeQGGkwkmsuBDR8agZclwFOK2MGNVUW5te5VQG03OF5qz2k/Phc2kNMtXED40i4B70oRbnoTm7derys6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642644; c=relaxed/simple;
	bh=//Inah7UKe0puilghYtZMqxoC28Vyhxl3HOCGDJB31g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EyLYQYdmHSHERQROV4aBeexmyZegZib3D23c63DbbjaasG8Up9PykgUbrzo7gYGYicQ7iBUe5geIQfOytlV+uLUEfL5XsnkhIPXP5KGEbqpDYBWNBv5R2o39yDUnFw3XrNspUhG/oHd2qjv2/RUhc0pEUhOhwAz1HQH7x0BPX0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=ErXoKAOu; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="ErXoKAOu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1740642642; x=1772178642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=//Inah7UKe0puilghYtZMqxoC28Vyhxl3HOCGDJB31g=;
  b=ErXoKAOuoV3FupUQ9iXlx15zHBXXAnpHRvOowfitCwaT1cDHQVB2XMHi
   L4bQCN8T5HPtXtp5zcLWzhY1NZopQi4JdXl8oylS9yswwk0M/pP29Fi63
   ZdWvwKbTfzAbWp/XHS1Wh6gYSH1/2WkcEKUz5IluFQu6T7RtZ7yAdIZVn
   Y7jYpvf986429iDVupmCt8OP7lkDG9NqxCLSfBthCK+l46D+LMaHXqeEm
   E88gm1z8IMMoYzbNvLjtitBChFdSQderdVWm1ikGaHO7YtfccbdaR7Xtz
   SFbElmUziI4TleAFDFxSfA6JFwzDkltjnOckNzby0Yur3bN4EA318kaY3
   Q==;
X-CSE-ConnectionGUID: hVPNaeJcQ3qTLB3Gnm9Rnw==
X-CSE-MsgGUID: iVNIm1p+RfyOP1UCOKj0Og==
X-IronPort-AV: E=Sophos;i="6.13,319,1732550400"; 
   d="scan'208";a="40304942"
Received: from mail-bn7nam10lp2042.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.42])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2025 15:50:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx+cWLJJgpMAc2VgqS3VJ546AWwMWvPlTBgi21vr8dAzaisjV5wxeMrEFosDGTq2k/z28P36bbWKYpzklxH1el4M77/o/2L7VGwmX/tiQx/3qtfhYaI3nztlilHoN4p9keEsvONkN15wr6EY4/TPpLbLA+gKkQdllNpP0z61SSO9Ep92Qsw9pQVQubl/qIgu32cVorbChoMGmaCr2UkIhGQxvGGngAMptkwi6SVemLYvr0nZfAh6mTWBpmBANbK1K2p+V8EAII79aA6xPABH/LoGmmu9FLNsJSGa6q4nm37FUWVNe8fQuu0uWALHH4TRA+GIo0YcUaFiXOXmKqvqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbwbU9wSGEJ4GY6TJyJ6Cd3R7QIUYt9IER+ZoAO7nD0=;
 b=qPuqM07R+JumacQiMFEQAfDBEThRpLc+UKHansMGoK36mDW/yWVleI6YEK8meRofmuF8TQzRhR2zLs7Q8NrbjZ7vyawE2nJm4JXMcvMSHlXGfdylOzLEdOSxp8UhjnhJiFjWl5QpXwg0bM9znvpXJYgS9aBWjo8T8Bh/VcTLh90LufqqHVGhP1l+83jism9dhXsPkPPC5BdeQxdkZNo2aiHG2ONnDuGWVPVK6YuGjK6NHqpL9LqU8bZxu5jpL9rxb8xrgsb1PIeG6u9eO4mtXTc3pI77ktLVh0STL0j4LtTHOqGjm43yiM5GWiH9RJB7K7ecwpsLAVoMF6NQj9jACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CO6PR16MB4194.namprd16.prod.outlook.com (2603:10b6:303:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 07:50:38 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808%7]) with mapi id 15.20.8445.013; Thu, 27 Feb 2025
 07:50:38 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Guan Wang <guan.wang.jy@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Avri Altman <avri.altman@wdc.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jens
 Axboe <axboe@kernel.dk>, "guan.wang.jy@renesas.com"
	<guan.wang.jy@renesas.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Topic: [PATCH] mmc: block: add reset workaround for partition switch
 failures
Thread-Index: AQHbhnkI2Zb3iXnL20S8S3IGdxu6ELNaxv2w
Date: Thu, 27 Feb 2025 07:50:38 +0000
Message-ID:
 <PH7PR16MB6196112328A147FC59643B76E5CD2@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
In-Reply-To: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CO6PR16MB4194:EE_
x-ms-office365-filtering-correlation-id: ca895420-29b4-455d-e643-08dd57036d43
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?po5ZzDC6z0ebPSC85reDO+aycGgo5/GlMKOA+cpGwjigCIwJ3HjAV3m07aHd?=
 =?us-ascii?Q?B/XaMAjzKA4CIE/bvmelVO20MruwBRkCmm/yPbScJHdiWHcl/IOEbGF/sYmS?=
 =?us-ascii?Q?MAQ92n/i6q9iUmvTn6snJ5GEg0bWojW6rp+VzLIIzKoCbnv/B8PH59zHBonT?=
 =?us-ascii?Q?gRmYcKG/v2P3NlpcoqJByqM2xqjDsM1U2AZzlgKYSO10z4QLCQYr8VdmCjyX?=
 =?us-ascii?Q?4tdGXJpvBeoZr2kimMtFRDrNvMMdDtQCcNa2m9AN8DWD9jUYCMEq18Z/8Z8B?=
 =?us-ascii?Q?Rep1d+rdBMNxqO/LAHGAInTekR9P1xkcwr1Va4VAhbQ1fI+J87QP87cY1rOA?=
 =?us-ascii?Q?TBOiLlbl7NiXEnLC3YqzNg25vEnTTwFrbCabjBJ2Cum28bBxotLTNx9F/TRq?=
 =?us-ascii?Q?Ix0u0Lvz1jQyML55rXX/WUuf1d97XKPBINEGAcuExLODsDeMoGwz3IsKq1aS?=
 =?us-ascii?Q?4B0nkJarmnyn+8UbUmjuSO0ha6nEd+ivYmaRlxaW1F8RZ8t6wAJGEfLWdIR+?=
 =?us-ascii?Q?s+WEYqFbHbKJ3cojs4HLLyFUD/zfw5t5gJtNii3JrSwVY7rSTHgMmsMpUzIP?=
 =?us-ascii?Q?hO0zzPcoJ1X4skn18DKz7go+x0nOdvsXqXLTXkZ15yZUHMXl51oK7ukm+HY2?=
 =?us-ascii?Q?4oFnOS0drij0qftjnwTDN+ddHeINGPtuXPRHMacdhMjf+HVrDhl1cRWRf9jz?=
 =?us-ascii?Q?HjBz3W90OimZ5IkeSxNMgzzP0+iPYz9VJGzuOhnnl3WSKydyptToTm/eI0Ud?=
 =?us-ascii?Q?vER+FgEq8cj6TRTidgqbrxZMqHlCgXDIRMZD4BprE8hPthVczVpRHKoG+75t?=
 =?us-ascii?Q?xyDo8t+esCePd5Vr9OvBLvPkTX+p8/5UBgQIJPtyun289gaGCXYh/vUM5Bsm?=
 =?us-ascii?Q?561FIONBtQ9Cnp9IrSKq+ypbRvTTpuB7boZV/HHc/eYurj4zj9s9C9IV1OEb?=
 =?us-ascii?Q?uqQ5+dhYkZMc8AGD4chHmyC9+3tilsyTouAloAA77JK5cSRUt9UGkCFrBuvd?=
 =?us-ascii?Q?9SK9pRP2L61kjxPO8MbXEh3FDBwKEjzyyIffgqm2NU7JwCN09f9rB1NJtnJq?=
 =?us-ascii?Q?AIbcitJFnmEpLIOXSBW/+mox1xtOJv0EqCBL18hKlCC4O39R2evCDboYYYYU?=
 =?us-ascii?Q?GVT3WlRm8348yUjP/XCVsp0rV5yjhKzrDiGcjDL2oHaiS5KgAUab153LX5Ez?=
 =?us-ascii?Q?8qQ41CqeFrOAVwGn+ypXAMhNEhB0Do7OZKt67bu8qtHebaPPr0/QzgY1fqn5?=
 =?us-ascii?Q?/Hl8wHhZbr3egY5JvNJCWGNYASjZXbqFJdNUzD24GgmKNkQEToaP433lBM2B?=
 =?us-ascii?Q?OJutUCxh8vq/LFycGWQuMg0qhR0bJLrUu/J2dr5Ua48ZmVCh+LdzaNKqLnJ4?=
 =?us-ascii?Q?S5Skb6+LpEDrc4l5sH66atnHWzXaQ217iVH7zdQq414nFot7BEPjtQ9gN2xS?=
 =?us-ascii?Q?v9zkhabipvKkUk2E3QIMJig+d2ho2wpx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3JeaP+8OjrCDyQVl+3UySe67D3TjQRd5yDvFiSvv16b6/BFXyWjiSfJe0usg?=
 =?us-ascii?Q?trK8ZMlcAoZpP9zy9K9hXmckBzz/LWyhVo7/tUZjXbn9g1yOIuYTp2JCPrip?=
 =?us-ascii?Q?hhN6jx5tGhEvnRinjJZZpgAcI3TK22UiSI/WPvhgyvMG1kdXwl4sEcRV9WVs?=
 =?us-ascii?Q?F3kh2bICZemEeBYt6ISzEpeTAvj92DKmpd9QQnKtrTzF4X7iHC6iocy227Wv?=
 =?us-ascii?Q?KsG8n8EOwAY5Y8X4palREi68R193sptwpwVZY4QSiRS8FuNwp8yukK8/Bsc9?=
 =?us-ascii?Q?u4wmg8bN6eqXwnzUy/MdISvNND6GIOSXZIRmXvfrqbgw+h2X+Wv23rLqUzim?=
 =?us-ascii?Q?CF37cSNG9M7qkIz6l7da2gM6FOKDAeXxFR0MWfwBE/QlH7tSlZi0UK2dd4RP?=
 =?us-ascii?Q?Sds81naQZxeHfHf+9KJcrQEBZt4OxHSt+iPZBTQVDBfp1mT8/7Cv4FsG1gCo?=
 =?us-ascii?Q?amYBZSIdLwR2QTRRfYSB7o6gDyOKDAfuRN5pgLoe7kv/rjk1GtOq34t3mZz5?=
 =?us-ascii?Q?t8n66kFaMGPsespq/uyPRxRDnmJwJKQzNK7fpKe3JggxWNgNBMHF+f04JnAM?=
 =?us-ascii?Q?Sur8XuHYWrHz6dVn3XIkDsRNopPHNKUiUTznG0nVffAx9LcZiTvix2kf9qAA?=
 =?us-ascii?Q?Mmx11LuLJa6g5Rpguwi+/UxfySzHZqYUWNj2YFO17IXtIy20+4S/3heiIUbU?=
 =?us-ascii?Q?n4GyLacnTT8PvgF2dfJp1qC5T134XbtgKXPAOzgCzTruWA7dxu7wMIvoeii2?=
 =?us-ascii?Q?gM1NlQhGMjGIn0EF2ushJDyUXLUKVMqgZxD1bxgE/Fy1DWDtvsew90dUSl2s?=
 =?us-ascii?Q?nnNwiDG05ymIUbgYIEyscBXg0kgPSPiZ+sINjHMOrv1l0WtKDD/+VbmbkRWh?=
 =?us-ascii?Q?U7lGzat+sx6LkSRZhbWj9yTpp1/1eHkLBlYxfetI4lqoGKxv6oL2KHDGJ4pF?=
 =?us-ascii?Q?ntWMkkdnUai29T6k1wk5UJ4rrJoRHfIl/j6gsnvXO3WiOXJSxkwqL3nGuyBG?=
 =?us-ascii?Q?KXBXgvKNGBZD8Q9qa7RUdgy7aPLS901dEZAZc41QGmSR2PQ3ch3EgqwG2FUn?=
 =?us-ascii?Q?uOE9FmF8LySrklc4lihoJglB3yHU31HsTHyEqe5GJ4aGBWB8s9kqbOfSlrUg?=
 =?us-ascii?Q?P3Mbvmhc5TAVi8Skdzs294ys27vgZdgelel/xGI3fUvmN4dEzvuv41Y6n17X?=
 =?us-ascii?Q?rHlyuZmvmVfioUXfQJ8kjvoJHF05EaJZAAjMjuvwXRrLl4TBxB2u0fxIwttX?=
 =?us-ascii?Q?tTmd0wFOjiur4G31pN6uxgE5GUPk8MSwJMy3W19AGrwerxGSmG+CImxkaq9p?=
 =?us-ascii?Q?ZmH8Pva4GFsGl4uh2MKNmIKxDda1b807s/pr7Oxro4wV+yAJ9zQ1OqyixOOT?=
 =?us-ascii?Q?Tebr/6izXOtUyorKcpckaFqyvTuhoeyxwOF29wi/iahGuxc7GXVNaypKtmVG?=
 =?us-ascii?Q?RFJlIncwUNsps6TVNlM2u/s00bfpJF228LSEKW+n+E2853e0Ous2esIi/yF6?=
 =?us-ascii?Q?UqZhS4oH6uD0ffvn5CjbGfytLibAPPKXx5Dz/3OGsU1PTd4dY3pXB9ppzO2R?=
 =?us-ascii?Q?ICl8JqEmT4BHsNV6gxWkCnWUtenNzLWNp63sDaocstfLr9+/2K7MKwfKThje?=
 =?us-ascii?Q?YFBRKBbRgJMJPp3znKSmYTzmq0+bhBYCcrE+2PHNeYS7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	75w7KvWo/pg3F4U+weeuG4ZY6HIRF2e6ubQh/iWkW/1oxzld4SdUj6A8ebLe8yTDlpGrPPk4GPNS75qLeBfGnT0I/WwbMedy0QVbzqH4b1c2p+VihnzYuPT/dOtxrojE/F7FGMtPNyIUCo+fhXBh/Y/cehDWHQ/IzLIgOZddoPrWTLaGEMGmYZrQcfdlQ6FvkszQBVfHHHLYYwQw7Os9AOgbGmapMmdn6kk6y3TkKOwpdjfClCqHwYj7iNN1gRb9bbqaX9tbZHBqu5snPBF6yBuHDYUXpLpMSPD6/7nLOjn7QQlYD30M1lhnj8CZ0mdmC6S0qOlamBKGVzs438XSljft2hC1l30T0JJAp2bKlTYESiMDutGI1OWtpmcikKDVAjYkuNy5SOzqwFqnv/jJJYW9DcxIqICWqAeMt4gjQbwMPs/nX1XfSWBRif7IWfpVazE1HRQmoCO1aNaiXLb78dzNZJFCh5ajlELbCoYnP+tsDLnYEnHy8PrTn6rL9wYbdkzjrq8NuN7QOLpvHluZj2Po5zpuiCauNP8LV8decJbnaam78Ml9oAXe2x6mLeSW/6Vhiap5+aWITgBprAECB2fiFmmczJrFFFrdWTZ6IcYPjP86GWw3Mv9Z+9uZ13bis6HcYkHnqs0rMP0vF/z8BQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca895420-29b4-455d-e643-08dd57036d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 07:50:38.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5v3zVR38eHrMs6raPKvqnF7+U7TYeqH/S2LCeMVrpOT84aw9VDjnXZJnZzWLxvi557lTz+ND6p67ubYx9uMNWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4194

Hi,
> Some eMMC devices (e.g., BGSD4R and AIM20F) may enter an unresponsive
> state
> after encountering CRC errors during RPMB writes (CMD25). This prevents t=
he
> device from switching back to the main partition via CMD6, blocking furth=
er
> I/O operations.
Different cards on the same platform?
Can you share which platform, and few lines from the log supporting your an=
alysis?

>=20
> The root cause is suspected to be a firmware/hardware issue in specific
> eMMC models. A workaround is to perform a hardware reset via
> mmc_hw_reset()
> when the partition switch fails, followed by a retry.
Same fw bug in 2 different products?

Why do we need to fix it here?
The ioctl will eventually return an error, and reset is needed anyway.
If the eMMC is the primary storage,  the platform is rebooting without bein=
g aware what went wrong.

Thanks,
Avri

>=20
> Add a workaround that:
> 1. If initial partition switch fails after rpmb access
> 2. Performs mmc card reset using mmc_hw_reset()
> 3. Retries switching to main partition
> This helps resolve cases where the device becomes unresponsive after
> RPMB operations.
>=20
> Signed-off-by: Guan Wang <guan.wang.jy@renesas.com>
> ---
>  drivers/mmc/core/block.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4830628510e6..29388786624c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1174,8 +1174,24 @@ static void mmc_blk_issue_drv_op(struct
> mmc_queue *mq, struct request *req)
>  				break;
>  		}
>  		/* Always switch back to main area after RPMB access */
> -		if (rpmb_ioctl)
> -			mmc_blk_part_switch(card, 0);
> +		if (rpmb_ioctl) {
> +			if (mmc_blk_part_switch(card, 0)) {
> +				pr_warn("%s: failed to switch back to main
> area, will reset and switch again\n",
> +						md->disk->disk_name);
> +
> +				/*
> +				 * Reset eMMC device if partition switch fails.
> +				 * Some eMMC devices may get stuck by write
> CRC error in RPMB,
> +				 * preventing switch back to main partition.
> This workaround
> +				 * helps recover from this error state.
> +				 */
> +				mmc_hw_reset(card);
> +
> +				if (mmc_blk_part_switch(card, 0))
> +					pr_err("%s: failed to switch back to
> main area even after reset\n",
> +						   md->disk->disk_name);
> +			}
> +		}
>  		else if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
>  			mmc_cmdq_enable(card);
>  		break;
> --
> 2.25.1

