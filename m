Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18854C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 06:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA3261B27
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhKQGmB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 01:42:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:9625 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhKQGmB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Nov 2021 01:42:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="232613179"
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="232613179"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 22:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="567890929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2021 22:39:02 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 16 Nov 2021 22:39:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 16 Nov 2021 22:39:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 16 Nov 2021 22:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0XOwkjQgvDnjieIUTYtXv1ioN2sEbNSTYESbXy/YwZ/7mlvMCekaWQwjIctp9bqw1U2icgAWl75hhqAlymjbBelOb57zfjxZDqwpe5z7c62KvNoie7EWVHfWr2EgnWH69qh8YCn1p9V4ATohgOgNVstc0GFWd1fNXEyZTWlU7zFUn+DguBz3GV/WeS7QC7PXygwoxpB9sBK2jQAjYWzkki0kq0dRMIzik3BudTZSIsw4imYd0oeDEKHCZWIVvuqretWs7upHE+EuC6h5hak8Eq2g1Doa4lgxoDGAlFbiSpnuxFATrefQaQCzsh3Lh7rKR4r5BKU10zii1RAiDbcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R4d2gwEwzTtkdmSPcwNdLeFmnrN9Knz94GbctnvJy0=;
 b=gkn7d83dtQh1d2gQulrE0mtZxakoOV8O5ai+3FYBxSnvVS2Zw5nIja66P9kkcuzZcZjQep9KsOuW+wpRjhkd5LhoYPigBidlo1Kxe+RPcWBzf52iCKBg/RR3CP/KlnxpF3m9jOmFFZiCeZAfu3Q6BwWu6y9G33CgG8EHuvZJDCeO2M8ope3aEd6QYDfKRCWTGVMUuRcpd2f8/MiFUbgKvdyUu3BOtGsYDHys9QoKva9fyhXopiZZYOZtMf1yBkY/pffnw9sOHfZZ0W50NtAgsFRR2wVSKCrPy28SAEXdqxusQiOXQ3VDoNSrpDtxTTGQXxjjSgXuRRA5V6Y8k1JgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R4d2gwEwzTtkdmSPcwNdLeFmnrN9Knz94GbctnvJy0=;
 b=sCYKe4Si0xq/MSAOYX4h9oeZKsUHOoLkf2IIy7DAq/UccgAW+Htr6f3X5vdt8LUYKpURm3J0PZSp/h3udfTh1kotmP+1japsBg2p9NUUshaPtHTMIg93qkQ1BaN2DUdJwqqH9+rNc5N/MgNARPrkBlNiSacTkhL4OADpK1WKEqw=
Received: from DM6PR11MB3065.namprd11.prod.outlook.com (2603:10b6:5:72::15) by
 DM6PR11MB3514.namprd11.prod.outlook.com (2603:10b6:5:61::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Wed, 17 Nov 2021 06:38:59 +0000
Received: from DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::90de:8816:c93e:3d75]) by DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::90de:8816:c93e:3d75%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 06:38:59 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: RE: [RESEND PATCH v2 4/4] phy: intel: Add Thunder Bay eMMC PHY
 support
Thread-Topic: [RESEND PATCH v2 4/4] phy: intel: Add Thunder Bay eMMC PHY
 support
Thread-Index: AQHXyymXCea7MPcbhU6z+SzK95nwwawHYrRA
Date:   Wed, 17 Nov 2021 06:38:59 +0000
Message-ID: <DM6PR11MB3065C3329182A196C46DE5F68C9A9@DM6PR11MB3065.namprd11.prod.outlook.com>
References: <20211027115516.4475-1-rashmi.a@intel.com>
 <20211027115516.4475-5-rashmi.a@intel.com>
In-Reply-To: <20211027115516.4475-5-rashmi.a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0f6983-6bab-4328-1fda-08d9a994effc
x-ms-traffictypediagnostic: DM6PR11MB3514:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB3514F7E1609A01555A7B816D8C9A9@DM6PR11MB3514.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qI0B3/cBW7e+dadzVWI0/Xj6BUI6YjJDP3qjxPFYZi2v/3gOiJw2mWsuZzp1O4HQjOvodVpUADMc/y8o0U0e4UhkWX+Ekamvbq8iRAxkhHvBTprdjU7o8RZJFCi7fWfQDRftmruHXnkKXsnqqI6NP1b24iEIO5dpUBn/khaCfQZ/yC6a6zwvY1f+yz1xK2Mwid4rz/uKXvcuk9YNrcVx9/hJW5obHQZrfikLoz9ueXPJugxXTAbheUDKi4pY08t8QX4BXniR9j5mQH6bJ+6ougKC0sLsBKmo5cQWniQzJj13TyP7+RuuPZF6Eip2HNHsKvUYc+UDwj2wp88kq0ulBCld47UVJDvNSvUftdLQ3N39IjqygC+KQ1+INNTzRMoLnrWAZLsJNCvC+7Bs8Oed3Oq0m9vcG4ONdQV0tJ6Zwgpjy3rpIEt65Wul1ygM1NLC4i3q+Qpc1/2FjS0vkY5gp3uZl0gtFTSCBW7IsIKbLhayupGWuIoT4DdszQ4HYYIaRizYxzUeWP4ZluOjA1/nYSV9CtAcoAiLemEuJag4gUq4y4LnjvkUuZ44MIBPqt8o0gHVnVkl4kxrgx0QuHMK5v+ZtZO8g0Mze6y6UdPvMAWOCWZY58p8GpVvrCBwMg2Iv2nlwrsirvnIHgxeGK8f0pGMg/qOvGQgCoLvcVeQtbWVT2S4Y7u37ifA3Cav3Z4PCAbYfxGN4l65GI/tI3ugByAxhcjVR3rvvZLRbVWvDyQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3065.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(64756008)(66446008)(38070700005)(76116006)(66946007)(66556008)(66476007)(6506007)(53546011)(110136005)(2906002)(54906003)(33656002)(316002)(5660300002)(122000001)(38100700002)(83380400001)(82960400001)(508600001)(7416002)(19627235002)(71200400001)(52536014)(186003)(4326008)(30864003)(8676002)(86362001)(921005)(9686003)(8936002)(55016002)(26005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wu5kT8Lhk9Wt8NGl2kv68v+sbWTVch1o3oxY4IAmDtKcEWAzmvdcCq9CjVg3?=
 =?us-ascii?Q?DaDrh/77+qyBtjCRH8dxsuLRbqB4vHZJdoZN1saxpQR27cW236y8JcVPghwh?=
 =?us-ascii?Q?cyH+Kp9FcI2ZwPCNVOIbnX6R0uaGMahax5BCyzNmlvTeBS/elsU/9c6A2wDD?=
 =?us-ascii?Q?k2Cv7f4fN/yZt0m14bR+41s++/x+9ZMyaadAStBUW36hUFcni1xM6kMg7vYr?=
 =?us-ascii?Q?iwbHBM8xk8+oZpigRGmWFFSlOpWjqwgiLlJNpz88H340mnQuDPpKvZm7c5RS?=
 =?us-ascii?Q?zHnSCBoCY5Xtq9jKONYzV9s3Vupd4bJfwZN20LjgdRH6QFikDzF7lPSPf6QE?=
 =?us-ascii?Q?HU8tSOV6lUmLzP3G2jqcVXPvKJ94/BSZWz65NRq6Jbvdi8DQs9TQmsAzy93p?=
 =?us-ascii?Q?N5W9rJ9+DrcWQnwYZg9PDeAVHy/aoTFiUkDWUW2m2Dq4g/Jrv6P37Iv1GBXk?=
 =?us-ascii?Q?tmUuSP/sNWCnGt3PtNvf4dDX5yr1tDUwqOw/+py2ih5ZzEB33kuctqw82d+X?=
 =?us-ascii?Q?ggzreBgfc5b+oFx6E5adapUZVyZoDxRrDnfXY2C0Q2XdDK++dU0GAY3Ovkob?=
 =?us-ascii?Q?RCX3SfeuiVYESE2yUGmMBysUP7PeVS2N5BCKJvIq8m+S800SiQREL+jBxrXO?=
 =?us-ascii?Q?ND7ASxeTOsNnGP3C9zh0pKUXF9GyWFLZ/hm4/zigRrLqwsS0lphQEPoLMWhK?=
 =?us-ascii?Q?VC9Dra+hbStF8q421c/a8Vn5GQJkFIAwyUy7o/qDe/qQrJBZBsM7Q7ez1L3R?=
 =?us-ascii?Q?HQgpobSJdJ/4MbYQvW94v7282VkP/u5DecHjL0MpdSEe0vPYcCcjRTCYbGGf?=
 =?us-ascii?Q?9W4cDJY3iFr/NwFs6AgJotwKUwQNagUtAU3ocmuHtkecAKbabJSbYfJ6hNVw?=
 =?us-ascii?Q?G0WNJBii9aRpaLahNDwM6otI5G9kmsXZm/0WOySGbIf4h2yy5YmB30jG64r/?=
 =?us-ascii?Q?xP00qjPcDKISbggFGojr7Q++J5AeHgqJwzE//0NCjNNykbdEG4R+Nway1DMq?=
 =?us-ascii?Q?tSVDYbLiAiGcIG+ZpPSPG0WwKE1hE+546XSyh833uAc0i6+bLzv2z5erUEWI?=
 =?us-ascii?Q?JlY+ucLc+dQBRC8GYvm0bNV3S+/ZLAqQgQQeDWyiBnpRSM1zMOfDXcMfowKC?=
 =?us-ascii?Q?4jQMdmQK0BPn5yZXDhX0d6My8qkjrZVQInbxaq4tVFxKmWnM0SwN9thrCuSa?=
 =?us-ascii?Q?qqr+6cSjXCOuQ4UPurOa5tH8hrmH4imRG+SSVs7fLCnYn7vyGLZYNZnzhTaJ?=
 =?us-ascii?Q?paqUqu8gix+R4s5QnY2wrllUx6HHZfO8sW9u9LZUAY9tWTUOYtsSaxKN7bhg?=
 =?us-ascii?Q?9rV7UxPbbNavbzNijO1TP6ksbUdjKJhCDimUKrvPGzC0Ew4Dc7g6fr19Of5G?=
 =?us-ascii?Q?FskA74QDi3vB06djl4V+6AIqAv3Y8LMMZmrdxQJm5cowOODnNfTAB2+qBwJe?=
 =?us-ascii?Q?GZ6G/rPglNXNtPIewfqiHDhgNDobznbVUxMzAQ7Ibbiq0PzTOxnxKu9sSp8W?=
 =?us-ascii?Q?GmPLnZT9/kncRRrvcf8UD4YW0GvTeD3UvJeHJHmlBLLFiSpQbEaKR/qWnMjZ?=
 =?us-ascii?Q?J91ChW3pV7dkBbn+ij33N0UUOZDJodkY2aPB5LRR7whMKh8F3nqwoWt+8USl?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3065.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0f6983-6bab-4328-1fda-08d9a994effc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 06:38:59.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47daeHIUkwLg/d68clL6T+53ca9Kk6IhtiBGcMl+SZNlTyEiU9uHj1FecoJfa6yIuDsyTYBnn+/skMS/JfHaYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3514
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: A, Rashmi <rashmi.a@intel.com>
> Sent: Wednesday, October 27, 2021 5:25 PM
> To: michal.simek@xilinx.com; ulf.hansson@linaro.org; linux-
> mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> robh+dt@kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; kishon@ti.com; vkoul@kernel.org;
> andriy.shevchenko@linux.intel.com; linux-phy@lists.infradead.org
> Cc: mgross@linux.intel.com; kris.pan@linux.intel.com; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Hunter, Adrian
> <adrian.hunter@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; Srikandan, Nandhini
> <nandhini.srikandan@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: [RESEND PATCH v2 4/4] phy: intel: Add Thunder Bay eMMC PHY
> support
>=20
> From: Rashmi A <rashmi.a@intel.com>
>=20
> Add support of eMMC PHY for Intel Thunder Bay SoC, uses the Arasan eMMC
> phy
>=20
> Signed-off-by: Rashmi A <rashmi.a@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/phy/intel/Kconfig                     |  10 +
>  drivers/phy/intel/Makefile                    |   1 +
>  drivers/phy/intel/phy-intel-thunderbay-emmc.c | 511 ++++++++++++++++++
>  3 files changed, 522 insertions(+)
>  create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c
>=20
> diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig index
> ac42bb2fb394..18a3cc5b98c0 100644
> --- a/drivers/phy/intel/Kconfig
> +++ b/drivers/phy/intel/Kconfig
> @@ -46,3 +46,13 @@ config PHY_INTEL_LGM_EMMC
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the Intel EMMC PHY
> +
> +config PHY_INTEL_THUNDERBAY_EMMC
> +        tristate "Intel Thunder Bay eMMC PHY driver"
> +        depends on OF && (ARCH_THUNDERBAY || COMPILE_TEST)
> +        select GENERIC_PHY
> +        help
> +	  This option enables support for Intel Thunder Bay SoC eMMC PHY.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called phy-intel-thunderbay-emmc.ko.
> diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile inde=
x
> 14550981a707..b7321d56b0bb 100644
> --- a/drivers/phy/intel/Makefile
> +++ b/drivers/phy/intel/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_PHY_INTEL_KEEMBAY_EMMC)	+=3D
> phy-intel-keembay-emmc.o
>  obj-$(CONFIG_PHY_INTEL_KEEMBAY_USB)	+=3D phy-intel-keembay-usb.o
>  obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+=3D phy-intel-lgm-combo.o
>  obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+=3D phy-intel-lgm-emmc.o
> +obj-$(CONFIG_PHY_INTEL_THUNDERBAY_EMMC) +=3D phy-intel-thunderbay-
> emmc.o
> diff --git a/drivers/phy/intel/phy-intel-thunderbay-emmc.c
> b/drivers/phy/intel/phy-intel-thunderbay-emmc.c
> new file mode 100644
> index 000000000000..2d6ea84492f2
> --- /dev/null
> +++ b/drivers/phy/intel/phy-intel-thunderbay-emmc.c
> @@ -0,0 +1,511 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel ThunderBay eMMC PHY driver
> + *
> + * Copyright (C) 2021 Intel Corporation
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +/* eMMC/SD/SDIO core/phy configuration registers */
> +#define CTRL_CFG_0	0x00
> +#define CTRL_CFG_1	0x04
> +#define CTRL_PRESET_0	0x08
> +#define CTRL_PRESET_1	0x0c
> +#define CTRL_PRESET_2	0x10
> +#define CTRL_PRESET_3	0x14
> +#define CTRL_PRESET_4	0x18
> +#define CTRL_CFG_2	0x1c
> +#define CTRL_CFG_3	0x20
> +#define PHY_CFG_0	0x24
> +#define PHY_CFG_1	0x28
> +#define PHY_CFG_2	0x2c
> +#define PHYBIST_CTRL	0x30
> +#define SDHC_STAT3	0x34
> +#define PHY_STAT	0x38
> +#define PHYBIST_STAT_0	0x3c
> +#define PHYBIST_STAT_1	0x40
> +#define EMMC_AXI        0x44
> +
> +/* CTRL_PRESET_3 */
> +#define CTRL_PRESET3_MASK	GENMASK(31, 0)
> +#define CTRL_PRESET3_SHIFT	0
> +
> +/* CTRL_CFG_0 bit fields */
> +#define SUPPORT_HS_MASK		BIT(26)
> +#define SUPPORT_HS_SHIFT	26
> +
> +#define SUPPORT_8B_MASK		BIT(24)
> +#define SUPPORT_8B_SHIFT	24
> +
> +/* CTRL_CFG_1 bit fields */
> +#define SUPPORT_SDR50_MASK	BIT(28)
> +#define SUPPORT_SDR50_SHIFT	28
> +#define SLOT_TYPE_MASK		GENMASK(27, 26)
> +#define SLOT_TYPE_OFFSET	26
> +#define SUPPORT_64B_MASK	BIT(24)
> +#define SUPPORT_64B_SHIFT	24
> +#define SUPPORT_HS400_MASK	BIT(2)
> +#define SUPPORT_HS400_SHIFT	2
> +#define SUPPORT_DDR50_MASK	BIT(1)
> +#define SUPPORT_DDR50_SHIFT	1
> +#define SUPPORT_SDR104_MASK	BIT(0)
> +#define SUPPORT_SDR104_SHIFT	0
> +
> +/* PHY_CFG_0 bit fields */
> +#define SEL_DLY_TXCLK_MASK      BIT(29)
> +#define SEL_DLY_TXCLK_SHIFT	29
> +#define SEL_DLY_RXCLK_MASK      BIT(28)
> +#define SEL_DLY_RXCLK_SHIFT	28
> +
> +#define OTAP_DLY_ENA_MASK	BIT(27)
> +#define OTAP_DLY_ENA_SHIFT	27
> +#define OTAP_DLY_SEL_MASK	GENMASK(26, 23)
> +#define OTAP_DLY_SEL_SHIFT	23
> +#define ITAP_CHG_WIN_MASK	BIT(22)
> +#define ITAP_CHG_WIN_SHIFT	22
> +#define ITAP_DLY_ENA_MASK	BIT(21)
> +#define ITAP_DLY_ENA_SHIFT	21
> +#define ITAP_DLY_SEL_MASK	GENMASK(20, 16)
> +#define ITAP_DLY_SEL_SHIFT	16
> +#define RET_ENB_MASK		BIT(15)
> +#define RET_ENB_SHIFT		15
> +#define RET_EN_MASK		BIT(14)
> +#define RET_EN_SHIFT		14
> +#define DLL_IFF_MASK		GENMASK(13, 11)
> +#define DLL_IFF_SHIFT		11
> +#define DLL_EN_MASK		BIT(10)
> +#define DLL_EN_SHIFT		10
> +#define DLL_TRIM_ICP_MASK	GENMASK(9, 6)
> +#define DLL_TRIM_ICP_SHIFT	6
> +#define RETRIM_EN_MASK		BIT(5)
> +#define RETRIM_EN_SHIFT		5
> +#define RETRIM_MASK		BIT(4)
> +#define RETRIM_SHIFT		4
> +#define DR_TY_MASK		GENMASK(3, 1)
> +#define DR_TY_SHIFT		1
> +#define PWR_DOWN_MASK		BIT(0)
> +#define PWR_DOWN_SHIFT		0
> +
> +/* PHY_CFG_1 bit fields */
> +#define REN_DAT_MASK		GENMASK(19, 12)
> +#define REN_DAT_SHIFT		12
> +#define REN_CMD_MASK		BIT(11)
> +#define REN_CMD_SHIFT		11
> +#define REN_STRB_MASK		BIT(10)
> +#define REN_STRB_SHIFT		10
> +#define PU_STRB_MASK		BIT(20)
> +#define PU_STRB_SHIFT		20
> +
> +/* PHY_CFG_2 bit fields */
> +#define CLKBUF_MASK		GENMASK(24, 21)
> +#define CLKBUF_SHIFT		21
> +#define SEL_STRB_MASK		GENMASK(20, 13)
> +#define SEL_STRB_SHIFT		13
> +#define SEL_FREQ_MASK		GENMASK(12, 10)
> +#define SEL_FREQ_SHIFT		10
> +
> +/* PHY_STAT bit fields */
> +#define CAL_DONE		BIT(6)
> +#define DLL_RDY			BIT(5)
> +
> +#define OTAP_DLY		0x0
> +#define ITAP_DLY		0x0
> +#define STRB			0x33
> +
> +/* From ACS_eMMC51_16nFFC_RO1100_Userguide_v1p0.pdf p17 */
> +#define FREQSEL_200M_170M	0x0
> +#define FREQSEL_170M_140M	0x1
> +#define FREQSEL_140M_110M	0x2
> +#define FREQSEL_110M_80M	0x3
> +#define FREQSEL_80M_50M		0x4
> +#define FREQSEL_275M_250M	0x5
> +#define FREQSEL_250M_225M	0x6
> +#define FREQSEL_225M_200M	0x7
> +
> +/* Phy power status */
> +#define PHY_UNINITIALIZED	0
> +#define PHY_INITIALIZED		1
> +
> +/*
> + * During init(400KHz) phy_settings will be called with 200MHZ clock
> + * To avoid incorrectly setting the phy for init(400KHZ) "phy_power_sts"=
 is
> used.
> + * When actual clock is set always phy is powered off once and then
> powered on.
> + * (sdhci_arasan_set_clock). That feature will be used to identify
> +whether the
> + * settings are for init phy_power_on or actual clock phy_power_on
> + * 0 --> init settings
> + * 1 --> actual settings
> + */
> +
> +struct thunderbay_emmc_phy {
> +	void __iomem    *reg_base;
> +	struct clk      *emmcclk;
> +	int phy_power_sts;
> +};
> +
> +static inline void update_reg(struct thunderbay_emmc_phy *tbh_phy, u32
> offset,
> +			      u32 mask, u32 shift, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp =3D readl(tbh_phy->reg_base + offset);
> +	tmp &=3D ~mask;
> +	tmp |=3D val << shift;
> +	writel(tmp, tbh_phy->reg_base + offset); }
> +
> +static int thunderbay_emmc_phy_power(struct phy *phy, bool power_on) {
> +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> +	unsigned int freqsel =3D FREQSEL_200M_170M;
> +	unsigned long rate;
> +	static int lock;
> +	u32 val;
> +	int ret;
> +
> +	/* Disable DLL */
> +	rate =3D clk_get_rate(tbh_phy->emmcclk);
> +	switch (rate) {
> +	case 200000000:
> +		/* lock dll only when it is used, i.e only if
> SEL_DLY_TXCLK/RXCLK are 0 */
> +		update_reg(tbh_phy, PHY_CFG_0, DLL_EN_MASK,
> DLL_EN_SHIFT, 0x0);
> +		break;
> +
> +	/* dll lock not required for other frequencies */
> +	case 50000000 ... 52000000:
> +	case 400000:
> +	default:
> +		break;
> +	}
> +
> +	if (!power_on)
> +		return 0;
> +
> +	rate =3D clk_get_rate(tbh_phy->emmcclk);
> +	switch (rate) {
> +	case 170000001 ... 200000000:
> +		freqsel =3D FREQSEL_200M_170M;
> +		break;
> +
> +	case 140000001 ... 170000000:
> +		freqsel =3D FREQSEL_170M_140M;
> +		break;
> +
> +	case 110000001 ... 140000000:
> +		freqsel =3D FREQSEL_140M_110M;
> +		break;
> +
> +	case 80000001 ... 110000000:
> +		freqsel =3D FREQSEL_110M_80M;
> +		break;
> +
> +	case 50000000 ... 80000000:
> +		freqsel =3D FREQSEL_80M_50M;
> +		break;
> +
> +	case 250000001 ... 275000000:
> +		freqsel =3D FREQSEL_275M_250M;
> +		break;
> +
> +	case 225000001 ... 250000000:
> +		freqsel =3D FREQSEL_250M_225M;
> +		break;
> +
> +	case 200000001 ... 225000000:
> +		freqsel =3D FREQSEL_225M_200M;
> +		break;
> +	default:
> +		break;
> +	}
> +	/* Clock rate is checked against upper limit. It may fall low during in=
it
> */
> +	if (rate > 200000000)
> +		dev_warn(&phy->dev, "Unsupported rate: %lu\n", rate);
> +
> +	udelay(5);
> +
> +	if (lock =3D=3D 0) {
> +		/* PDB will be done only once per boot */
> +		update_reg(tbh_phy, PHY_CFG_0, PWR_DOWN_MASK,
> +			   PWR_DOWN_SHIFT, 0x1);
> +		lock =3D 1;
> +		/*
> +		 * According to the user manual, it asks driver to wait 5us for
> +		 * calpad busy trimming. However it is documented that this
> value is
> +		 * PVT(A.K.A. process, voltage and temperature) relevant, so
> some
> +		 * failure cases are found which indicates we should be more
> tolerant
> +		 * to calpad busy trimming.
> +		 */
> +		ret =3D readl_poll_timeout(tbh_phy->reg_base + PHY_STAT,
> +					 val, (val & CAL_DONE), 10, 50);
> +		if (ret) {
> +			dev_err(&phy->dev, "caldone failed, ret=3D%d\n", ret);
> +			return ret;
> +		}
> +	}
> +	rate =3D clk_get_rate(tbh_phy->emmcclk);
> +	switch (rate) {
> +	case 200000000:
> +		/* Set frequency of the DLL operation */
> +		update_reg(tbh_phy, PHY_CFG_2, SEL_FREQ_MASK,
> SEL_FREQ_SHIFT,
> +freqsel);
> +
> +		/* Enable DLL */
> +		update_reg(tbh_phy, PHY_CFG_0, DLL_EN_MASK,
> DLL_EN_SHIFT, 0x1);
> +
> +		/*
> +		 * After enabling analog DLL circuits docs say that we need
> 10.2 us if
> +		 * our source clock is at 50 MHz and that lock time scales
> linearly
> +		 * with clock speed. If we are powering on the PHY and the
> card clock
> +		 * is super slow (like 100kHz) this could take as long as 5.1 ms
> as
> +		 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) =3D> 5.1
> ms
> +		 * hopefully we won't be running at 100 kHz, but we should
> still make
> +		 * sure we wait long enough.
> +		 *
> +		 * NOTE: There appear to be corner cases where the DLL
> seems to take
> +		 * extra long to lock for reasons that aren't understood. In
> some
> +		 * extreme cases we've seen it take up to over 10ms (!). We'll
> be
> +		 * generous and give it 50ms.
> +		 */
> +		ret =3D readl_poll_timeout(tbh_phy->reg_base + PHY_STAT,
> +					 val, (val & DLL_RDY), 10, 50 *
> USEC_PER_MSEC);
> +		if (ret) {
> +			dev_err(&phy->dev, "dllrdy failed, ret=3D%d\n", ret);
> +			return ret;
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int thunderbay_emmc_phy_init(struct phy *phy) {
> +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> +
> +	tbh_phy->emmcclk =3D clk_get(&phy->dev, "emmcclk");
> +
> +	return PTR_ERR_OR_ZERO(tbh_phy->emmcclk);
> +}
> +
> +static int thunderbay_emmc_phy_exit(struct phy *phy) {
> +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> +
> +	clk_put(tbh_phy->emmcclk);
> +
> +	return 0;
> +}
> +
> +static int thunderbay_emmc_phy_power_on(struct phy *phy) {
> +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> +	unsigned long rate;
> +
> +	/* Overwrite capability bits configurable in bootloader */
> +	update_reg(tbh_phy, CTRL_CFG_0,
> +		   SUPPORT_HS_MASK, SUPPORT_HS_SHIFT, 0x1);
> +	update_reg(tbh_phy, CTRL_CFG_0,
> +		   SUPPORT_8B_MASK, SUPPORT_8B_SHIFT, 0x1);
> +	update_reg(tbh_phy, CTRL_CFG_1,
> +		   SUPPORT_SDR50_MASK, SUPPORT_SDR50_SHIFT, 0x1);
> +	update_reg(tbh_phy, CTRL_CFG_1,
> +		   SUPPORT_DDR50_MASK, SUPPORT_DDR50_SHIFT, 0x1);
> +	update_reg(tbh_phy, CTRL_CFG_1,
> +		   SUPPORT_SDR104_MASK, SUPPORT_SDR104_SHIFT, 0x1);
> +	update_reg(tbh_phy, CTRL_CFG_1,
> +		   SUPPORT_HS400_MASK, SUPPORT_HS400_SHIFT, 0x1);
> +	update_reg(tbh_phy, CTRL_CFG_1,
> +		   SUPPORT_64B_MASK, SUPPORT_64B_SHIFT, 0x1);
> +
> +	if (tbh_phy->phy_power_sts =3D=3D PHY_UNINITIALIZED) {
> +		/* Indicates initialization, settings for init, same as 400KHZ
> setting */
> +		update_reg(tbh_phy, PHY_CFG_0, SEL_DLY_TXCLK_MASK,
> SEL_DLY_TXCLK_SHIFT, 0x1);
> +		update_reg(tbh_phy, PHY_CFG_0, SEL_DLY_RXCLK_MASK,
> SEL_DLY_RXCLK_SHIFT, 0x1);
> +		update_reg(tbh_phy, PHY_CFG_0, ITAP_DLY_ENA_MASK,
> ITAP_DLY_ENA_SHIFT, 0x0);
> +		update_reg(tbh_phy, PHY_CFG_0, ITAP_DLY_SEL_MASK,
> ITAP_DLY_SEL_SHIFT, 0x0);
> +		update_reg(tbh_phy, PHY_CFG_0, OTAP_DLY_ENA_MASK,
> OTAP_DLY_ENA_SHIFT, 0x0);
> +		update_reg(tbh_phy, PHY_CFG_0, OTAP_DLY_SEL_MASK,
> OTAP_DLY_SEL_SHIFT, 0);
> +		update_reg(tbh_phy, PHY_CFG_0, DLL_TRIM_ICP_MASK,
> DLL_TRIM_ICP_SHIFT, 0);
> +		update_reg(tbh_phy, PHY_CFG_0, DR_TY_MASK,
> DR_TY_SHIFT, 0x1);
> +
> +	} else if (tbh_phy->phy_power_sts =3D=3D PHY_INITIALIZED) {
> +		/* Indicates actual clock setting */
> +		rate =3D clk_get_rate(tbh_phy->emmcclk);
> +		switch (rate) {
> +		case 200000000:
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_TXCLK_MASK,
> +				   SEL_DLY_TXCLK_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_RXCLK_MASK,
> +				   SEL_DLY_RXCLK_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_ENA_MASK,
> +				   ITAP_DLY_ENA_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_SEL_MASK,
> +				   ITAP_DLY_SEL_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_ENA_MASK,
> +				   OTAP_DLY_ENA_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_SEL_MASK,
> +				   OTAP_DLY_SEL_SHIFT, 2);
> +			update_reg(tbh_phy, PHY_CFG_0,
> DLL_TRIM_ICP_MASK,
> +				   DLL_TRIM_ICP_SHIFT, 0x8);
> +			update_reg(tbh_phy, PHY_CFG_0, DR_TY_MASK,
> +				   DR_TY_SHIFT, 0x1);
> +			/* For HS400 only */
> +			update_reg(tbh_phy, PHY_CFG_2, SEL_STRB_MASK,
> +				   SEL_STRB_SHIFT, STRB);
> +			break;
> +
> +		case 50000000 ... 52000000:
> +			/* For both HS and DDR52 this setting works */
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_TXCLK_MASK,
> +				   SEL_DLY_TXCLK_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_RXCLK_MASK,
> +				   SEL_DLY_RXCLK_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_ENA_MASK,
> +				   ITAP_DLY_ENA_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_SEL_MASK,
> +				   ITAP_DLY_SEL_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_ENA_MASK,
> +				   OTAP_DLY_ENA_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_SEL_MASK,
> +				   OTAP_DLY_SEL_SHIFT, 4);
> +			update_reg(tbh_phy, PHY_CFG_0,
> DLL_TRIM_ICP_MASK,
> +				   DLL_TRIM_ICP_SHIFT, 0x8);
> +			update_reg(tbh_phy, PHY_CFG_0,
> +				   DR_TY_MASK, DR_TY_SHIFT, 0x1);
> +			break;
> +
> +		case 400000:
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_TXCLK_MASK,
> +				   SEL_DLY_TXCLK_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_RXCLK_MASK,
> +				   SEL_DLY_RXCLK_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_ENA_MASK,
> +				   ITAP_DLY_ENA_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_SEL_MASK,
> +				   ITAP_DLY_SEL_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_ENA_MASK,
> +				   OTAP_DLY_ENA_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_SEL_MASK,
> +				   OTAP_DLY_SEL_SHIFT, 0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> DLL_TRIM_ICP_MASK,
> +				   DLL_TRIM_ICP_SHIFT, 0);
> +			update_reg(tbh_phy, PHY_CFG_0, DR_TY_MASK,
> DR_TY_SHIFT, 0x1);
> +			break;
> +
> +		default:
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_TXCLK_MASK,
> +				   SEL_DLY_TXCLK_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_RXCLK_MASK,
> +				   SEL_DLY_RXCLK_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_ENA_MASK,
> +				   ITAP_DLY_ENA_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_SEL_MASK,
> +				   ITAP_DLY_SEL_SHIFT, 0x0);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_ENA_MASK,
> +				   OTAP_DLY_ENA_SHIFT, 0x1);
> +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_SEL_MASK,
> +				   OTAP_DLY_SEL_SHIFT, 2);
> +			update_reg(tbh_phy, PHY_CFG_0,
> DLL_TRIM_ICP_MASK,
> +				   DLL_TRIM_ICP_SHIFT, 0x8);
> +			update_reg(tbh_phy, PHY_CFG_0, DR_TY_MASK,
> +				   DR_TY_SHIFT, 0x1);
> +			break;
> +		}
> +		/* Reset, init seq called without phy_power_off, this
> indicates init seq */
> +		tbh_phy->phy_power_sts =3D PHY_UNINITIALIZED;
> +	}
> +
> +	update_reg(tbh_phy, PHY_CFG_0, RETRIM_EN_MASK,
> RETRIM_EN_SHIFT, 0x1);
> +	update_reg(tbh_phy, PHY_CFG_0, RETRIM_MASK, RETRIM_SHIFT,
> 0x0);
> +
> +	return thunderbay_emmc_phy_power(phy, 1); }
> +
> +static int thunderbay_emmc_phy_power_off(struct phy *phy) {
> +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> +
> +	tbh_phy->phy_power_sts =3D PHY_INITIALIZED;
> +
> +	return thunderbay_emmc_phy_power(phy, 0); }
> +
> +static const struct phy_ops thunderbay_emmc_phy_ops =3D {
> +	.init		=3D thunderbay_emmc_phy_init,
> +	.exit		=3D thunderbay_emmc_phy_exit,
> +	.power_on	=3D thunderbay_emmc_phy_power_on,
> +	.power_off	=3D thunderbay_emmc_phy_power_off,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id thunderbay_emmc_phy_of_match[] =3D {
> +	{ .compatible =3D "intel,thunderbay-emmc-phy",
> +		(void *)&thunderbay_emmc_phy_ops },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, thunderbay_emmc_phy_of_match);
> +
> +static int thunderbay_emmc_phy_probe(struct platform_device *pdev) {
> +	struct thunderbay_emmc_phy *tbh_phy;
> +	struct phy_provider *phy_provider;
> +	struct device *dev =3D &pdev->dev;
> +	const struct of_device_id *id;
> +	struct phy *generic_phy;
> +	struct resource *res;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	tbh_phy =3D devm_kzalloc(dev, sizeof(*tbh_phy), GFP_KERNEL);
> +	if (!tbh_phy)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tbh_phy->reg_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(tbh_phy->reg_base)) {
> +		dev_err(&pdev->dev, "region map failed\n");
> +		return PTR_ERR(tbh_phy->reg_base);
> +	}
> +
> +	tbh_phy->phy_power_sts =3D PHY_UNINITIALIZED;
> +	id =3D of_match_node(thunderbay_emmc_phy_of_match, pdev-
> >dev.of_node);
> +	if (!id) {
> +		dev_err(dev, "failed to get match_node\n");
> +		return -EINVAL;
> +	}
> +
> +	generic_phy =3D devm_phy_create(dev, dev->of_node, id->data);
> +	if (IS_ERR(generic_phy)) {
> +		dev_err(dev, "failed to create PHY\n");
> +		return PTR_ERR(generic_phy);
> +	}
> +
> +	phy_set_drvdata(generic_phy, tbh_phy);
> +	phy_provider =3D devm_of_phy_provider_register(dev,
> +of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static struct platform_driver thunderbay_emmc_phy_driver =3D {
> +	.probe		 =3D thunderbay_emmc_phy_probe,
> +	.driver		 =3D {
> +		.name	 =3D "thunderbay-emmc-phy",
> +		.of_match_table =3D thunderbay_emmc_phy_of_match,
> +	},
> +};
> +module_platform_driver(thunderbay_emmc_phy_driver);
> +
> +MODULE_AUTHOR("Nandhini S <nandhini.srikandan@intel.com>");
> +MODULE_AUTHOR("Rashmi A <rashmi.a@intel.com>");
> +MODULE_DESCRIPTION("Intel Thunder Bay eMMC PHY driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1



Thank you Rob for the review of emmc dt-bindings.

Hi Vinod/Kishon,

Please let me know if there are any comments.
Looking forward for your acknowledgement for the patch, phy: intel: Add Thu=
nder Bay eMMC PHY support

-Rashmi

