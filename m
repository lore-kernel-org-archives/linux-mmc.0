Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0249DC4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21C060551
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Aug 2021 08:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhHJIwR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:52:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:42948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235609AbhHJIwM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Aug 2021 04:52:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="300450411"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="300450411"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 01:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="503054896"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2021 01:51:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 10 Aug 2021 01:51:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 01:51:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 01:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R94sLDZ0qguoNgHwaqfchYYDRIEzkxDGzbhgEUveaOc3codkzSWpturVZerpNotXfoVhHdhSdms8sJmHo5C22AVy53C2X9cpnyK7mHOKVAdslSmFRenA+PdVWznpPuR7BBW3T8R3YBLpc6UKD5N4Vcpg9nINOAUW7V+CzS7R/3wRCs4mCVLfuigXMv6L38hYuwoglHPaZZinkBs/I59xw+Qr9ol0kYYjOVjzuwf7xOzcM6+w8/AfIw62rU/BlGMbYQ9OTXU6z96taVCqQrQ8kEIo14GzmvNgRuMDDSJe+ICt9ICVoghkjq9sPlpW1G9l5QD8Wf0quJUH9Pjby1dRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opcplViBRLmmvaUJuRpj0bWrelJisFN3RG96ouQNAOU=;
 b=UWXLfznSYIG2h9hIrVczGLfT/iNpBaubjcnhh7VZNZFcm645atYQgRAVPlYk22iHFyfXv8jcQRyT1Oy+JdSEVeqSz/aGKKAS5oo7aUM7jhQrkMOfEFPTuwHsDj3agmjNMnkKcbcoIlrLQE8NoT/rIiCuuULSU6nDt0ClzwbZRxuGuc3LC8HGp/XyT9gxJef/oGWG3Fn3d6FliGcoYmKTBFDNgS9mH//AlZA7WJOD8SmlMfjfBKsG7Q3jOlKL6/p5FpkZVjJSSx+pDSwzI1Fv8AgLnjlQixN00uUf65O2DabjPlDBB3ZeQ2KnJMK6Xb17jDuVO6DlLPZ1y2ox0D9WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opcplViBRLmmvaUJuRpj0bWrelJisFN3RG96ouQNAOU=;
 b=MTY2y/deKT17Qx5usVkgOg+wnYDimpu+sc2xh2dx1zjSgoBcxZNNo4g33v4Y8XJPPmIo1B/oAFKkWPnqVDTQ/YMR/H1CuGURjdjFk3/MpD7o4QZ0JSnkyGDeJWphpSSuxszr89bMr4rQWOgjRMavkVmZnw+mSeAXoKl36loctjw=
Received: from MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13)
 by MWHPR11MB1485.namprd11.prod.outlook.com (2603:10b6:301:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 08:51:41 +0000
Received: from MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3]) by MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 08:51:41 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "linux-drivers-review-request@eclists.intel.com" 
        <linux-drivers-review-request@eclists.intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: RE: [PATCH 3/3] phy: intel: Add Thunder Bay eMMC PHY support
Thread-Topic: [PATCH 3/3] phy: intel: Add Thunder Bay eMMC PHY support
Thread-Index: AQHXhQzXjwy/r1dxVUyvCxQxq0i4Z6tmdgyAgAYGjGA=
Date:   Tue, 10 Aug 2021 08:51:40 +0000
Message-ID: <MWHPR11MB1789393D5B868B0DBF6FC0A28CF79@MWHPR11MB1789.namprd11.prod.outlook.com>
References: <20210730063309.8194-1-rashmi.a@intel.com>
 <20210730063309.8194-4-rashmi.a@intel.com> <YQ0td9y5+RNFxWZs@matsya>
In-Reply-To: <YQ0td9y5+RNFxWZs@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ff7391f-283e-4b42-cc34-08d95bdc128d
x-ms-traffictypediagnostic: MWHPR11MB1485:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1485DCB434E58C75DEF1CAC18CF79@MWHPR11MB1485.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAfytoKpvp33S7e5YqVDWGl4oNLavsa5WiUiyHxQP8Q4RhmC9cr1czIPfjGM6XPoLMkwO/oFYZ6kK/DOKtzeX3MXEGx+l2KVIVWAZ+lB8oetjQMzCKBw1wFiF1k/I7umkIjUD8h6O7+oD15di9qDNnHRqzlaKgGUsgyut4kxC/1n853K7ClGtHElGqEVyKDr3P3+b37FQtlxEwTgeLHDm6Ic+QG+FBpHDA+YJ4QgmtRvOK0aJ4kN/vBia9/7A8OcTHf6P99fqMsejn1f6RpnCxfKpg9ayy5lM0aEpA9xUB6hWKpRT2ibp6b3S5z95vfBSioZx9+ral/heQw/iUO5RxRXV9uo07yX77dwwdysSShL8j+GZWxp5FAMFD/T2yAx+Neio17wrNRf7roTglYoZge9C2QT+zf68ePSbSuM6cssxg/DD2CHDgwxupVsE6r6GyNczd75bnrvhIPPVZojqaKVpuD55hwvUVx0m80TVhlTvoJqJwmvno/4vvchrlHM7iCPO43V+phNmfkL83BTIhlUx5reznBiWdGpWu1DrXWnWRuBtiZvwNXLV7kabFuiVN2MlE353ScvoAdf4gR5IUXcYHBQWP3SaUDJuKd3rxLd/RgDG2nBSDwdHa2eRzU4u0QGBH37QzfU75I10NtgN7zvcW/aikVo4FET43rcsX/frvb5iVUC2U3qolkWWJVebBevj6zp78JavjRlgtb2tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(52536014)(6916009)(54906003)(38100700002)(316002)(478600001)(7696005)(8936002)(6506007)(53546011)(33656002)(8676002)(5660300002)(122000001)(66556008)(7416002)(186003)(2906002)(26005)(55016002)(9686003)(86362001)(4326008)(66946007)(76116006)(71200400001)(66476007)(38070700005)(83380400001)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ezDaDwZb8WBcwNrqezfAfgnhgQji7Qf6JtKEw7933bBn147MFj+UZGIkkkTc?=
 =?us-ascii?Q?7PZFbuF79xsJLJHCKetrUAbMOByzEJiS8u1bJaSq5WvVbXHA+Ao1c3ot5W7V?=
 =?us-ascii?Q?kYn/VgRpxTX/wz3FX9dGXT7RtlGSP8EgwFQRdGMF6gpEVXyCbH+E59ZKNs7M?=
 =?us-ascii?Q?TSd9GzVMByyRRQd2md0AehgD9wUuusNtra/BxZ050BtiRzU1m0u6vXEkhz+N?=
 =?us-ascii?Q?o0UjTWm00tFUwOgYUO5g9oxvbJ0FZ5HSSxLmN9NS7qENfcpvqXWumOYUikFI?=
 =?us-ascii?Q?eubEH34prR4QtqFa5Qb6FsuJL4s1Gm68qb4Yo/aavejlIN6xSj11UOVXIWFQ?=
 =?us-ascii?Q?QZp0KztpWewM2lo9HqfrEBjRCfsXjTVl4oD6iMbrPtOyRn0k2jXaPKfGwfhj?=
 =?us-ascii?Q?cCBZMPgJVx3N/yeWt1RkOSn1sS2x51ybh3Ny7bBejVYWJu5vOhIniCGiciVV?=
 =?us-ascii?Q?N41DvNnz1uVZKy+hL/Y0dztUhR5YJLxx+WeZfSnAjk22e+WTKD/ORW1Hdg8N?=
 =?us-ascii?Q?xypA/xVYfGq0KIVpidIN1ilrS1GXoMZrtjB3mm07/Fr4ydE2+AuGqZ5PsBOv?=
 =?us-ascii?Q?Zcm03IsPMAEKic8Cubp+0RIrpDNJ5ArYGiu5VnNp3CdTgmlsDUE5mMyYYw0e?=
 =?us-ascii?Q?cXnkUUOlnTyqH7+ZFqbG9Zsj6CfSnk0Fjmof4TAUpSvRd1/hI4aQ4VW20kLq?=
 =?us-ascii?Q?kZ+03bB2FcRwEyyQqYlR4YszxGtUR7mYeuc1zGsfHDMYA3+5noDzJewqUm3e?=
 =?us-ascii?Q?55Yre1mKiVHpR0fdLK+TN+VvOI0IMf6saVOtZEPhyO3V7DAU+IHtLvc3HG5B?=
 =?us-ascii?Q?nX5oBY0XW9xEKZZLHIMvmbIUxCfXrR515UIya9N2F5PDVGE+TAK2cuvNwyTX?=
 =?us-ascii?Q?9Nk8ZspnqBnAXB/EaedsgzGtoozpcrrLBJOYGPVWBb3IvFt8IDi/ubVjc0S4?=
 =?us-ascii?Q?yT7LAbU7V0XI/NlmBJ0I9gQ9L29h2AZhW9AnGvVYPyUjs3Gfqno/5uVoITCE?=
 =?us-ascii?Q?tSJEBZ1wYEvQibeA4NKK1ggXgnEFck8JGOSvB5oU3V7pFAASHw0QLXDYlUKW?=
 =?us-ascii?Q?vEBw0TkVBgx60L8XjmkF1F/1GnKX7Rz3KRu0OPKlaQ3dQCV6o5NU83m6pz6/?=
 =?us-ascii?Q?rEMohobjlmb5dMfLs3rjGD41/LYPP6buXFB03MGb51zHc5HHXp5rwjOSfLM9?=
 =?us-ascii?Q?LOtCyr8FfYY8oXp8qCbM97g0s2E0G1k0T3/YaNaeJWsr9X8q7mTl6dArxA6g?=
 =?us-ascii?Q?vW8UM//QOqlDkcNaui1KSqQe1ROqUI4wA9B82dcmN9x3rfZbWga5gibAtD0u?=
 =?us-ascii?Q?nQZn6XUZa0GhNMuvYRpPWTXn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff7391f-283e-4b42-cc34-08d95bdc128d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 08:51:40.7793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIw4xN1f0JMYJF1tbzzlPsdx2EJI12SXrgV2WsYwGiLXpLemdQ5Yam3c/r/L3CfpkT4ZzXn07f8H/b6d4YV79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1485
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, August 6, 2021 6:09 PM
> To: A, Rashmi <rashmi.a@intel.com>
> Cc: linux-drivers-review-request@eclists.intel.com; michal.simek@xilinx.c=
om;
> ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; kishon@ti.com;
> andriy.shevchenko@linux.intel.com; linux-phy@lists.infradead.org;
> mgross@linux.intel.com; kris.pan@linux.intel.com; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Hunter, Adrian
> <adrian.hunter@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; Srikandan, Nandhini
> <nandhini.srikandan@intel.com>; Demakkanavar, Kenchappa
> <kenchappa.demakkanavar@intel.com>
> Subject: Re: [PATCH 3/3] phy: intel: Add Thunder Bay eMMC PHY support
>=20
> On 30-07-21, 12:03, rashmi.a@intel.com wrote:
>=20
> > diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
> > index ac42bb2fb394..18a3cc5b98c0 100644
> > --- a/drivers/phy/intel/Kconfig
> > +++ b/drivers/phy/intel/Kconfig
> > @@ -46,3 +46,13 @@ config PHY_INTEL_LGM_EMMC
> >  	select GENERIC_PHY
> >  	help
> >  	  Enable this to support the Intel EMMC PHY
> > +
> > +config PHY_INTEL_THUNDERBAY_EMMC
>=20
> Alphabetical sort please
>=20
> > +        tristate "Intel Thunder Bay eMMC PHY driver"
> > +        depends on OF && (ARCH_THUNDERBAY || COMPILE_TEST)
> > +        select GENERIC_PHY
> > +        help
> > +	  This option enables support for Intel Thunder Bay SoC eMMC PHY.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called phy-intel-thunderbay-emmc.ko.
> > diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
> > index 14550981a707..6a4db3ee7393 100644
> > --- a/drivers/phy/intel/Makefile
> > +++ b/drivers/phy/intel/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_PHY_INTEL_KEEMBAY_EMMC)	+=3D phy-intel-
> keembay-emmc.o
> > +obj-$(CONFIG_PHY_INTEL_THUNDERBAY_EMMC)	+=3D phy-intel-
> thunderbay-emmc.o
>=20
> here as well
I will reorder the entry in Makefile. The Kconfig entries are in alphabetic=
al order. Let me know if I am missing something.

-Rashmi
>=20
> > +static int thunderbay_emmc_phy_power(struct phy *phy, bool power_on)
> > +{
> > +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> > +	unsigned int freqsel =3D FREQSEL_200M_170M;
> > +	unsigned long rate;
> > +	static int lock;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* Disable DLL */
> > +	rate =3D clk_get_rate(tbh_phy->emmcclk);
> > +	switch (rate) {
> > +	case 200000000:
> > +	/* lock dll only when it is used, i.e only if SEL_DLY_TXCLK/RXCLK are=
 0
> */
> > +		update_reg(tbh_phy, PHY_CFG_0, DLL_EN_MASK,
> DLL_EN_SHIFT, 0x0);
>=20
> pls keep the same indent for comment and code!
Acknowledged

-Rashmi
>=20
> > +		break;
> > +	/* dll lock not required for other frequencies */
> > +	case 50000000 ... 52000000:
> > +	case 400000:
> > +	default:
> > +		break;
> > +	}
> > +
> > +	if (!power_on)
> > +		return 0;
>=20
> should this not be the first thing you check...
During phy power on/off condition, dll should be disabled first. So power_o=
n check is made after disabling dll.

-Rashmi
>=20
> > +
> > +	rate =3D clk_get_rate(tbh_phy->emmcclk);
> > +	switch (rate) {
> > +	case 170000001 ... 200000000:
> > +		freqsel =3D FREQSEL_200M_170M;
> > +		break;
> > +	case 140000001 ... 170000000:
> > +		freqsel =3D FREQSEL_170M_140M;
> > +		break;
> > +	case 110000001 ... 140000000:
> > +		freqsel =3D FREQSEL_140M_110M;
> > +		break;
> > +	case 80000001 ... 110000000:
> > +		freqsel =3D FREQSEL_110M_80M;
> > +		break;
> > +	case 50000000 ... 80000000:
> > +		freqsel =3D FREQSEL_80M_50M;
> > +		break;
> > +	case 250000001 ... 275000000:
> > +		freqsel =3D FREQSEL_275M_250M;
> > +		break;
> > +	case 225000001 ... 250000000:
> > +		freqsel =3D FREQSEL_250M_225M;
> > +		break;
> > +	case 200000001 ... 225000000:
> > +		freqsel =3D FREQSEL_225M_200M;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	if (rate > 200000000)
> > +	/* only the upper limit is considered as the clock rate may fall low
> during init */
> > +		dev_warn(&phy->dev, "Unsupported rate: %lu\n", rate);
>=20
> here as well! (checkpatch --strict should have told you so)
I will follow the proper alignment, though check-patch script didn't show a=
ny warnings.

-Rashmi
>=20
> > +static int thunderbay_emmc_phy_power_on(struct phy *phy) {
> > +	struct thunderbay_emmc_phy *tbh_phy =3D phy_get_drvdata(phy);
> > +	unsigned long rate;
> > +
> > +	/* Overwrite capability bits configurable in bootloader */
> > +	update_reg(tbh_phy, CTRL_CFG_0,
> > +		   SUPPORT_HS_MASK, SUPPORT_HS_SHIFT, 0x1);
> > +	update_reg(tbh_phy, CTRL_CFG_0,
> > +		   SUPPORT_8B_MASK, SUPPORT_8B_SHIFT, 0x1);
> > +	update_reg(tbh_phy, CTRL_CFG_1,
> > +		   SUPPORT_SDR50_MASK, SUPPORT_SDR50_SHIFT, 0x1);
> > +	update_reg(tbh_phy, CTRL_CFG_1,
> > +		   SUPPORT_DDR50_MASK, SUPPORT_DDR50_SHIFT, 0x1);
> > +	update_reg(tbh_phy, CTRL_CFG_1,
> > +		   SUPPORT_SDR104_MASK, SUPPORT_SDR104_SHIFT, 0x1);
> > +	update_reg(tbh_phy, CTRL_CFG_1,
> > +		   SUPPORT_HS400_MASK, SUPPORT_HS400_SHIFT, 0x1);
> > +	update_reg(tbh_phy, CTRL_CFG_1,
> > +		   SUPPORT_64B_MASK, SUPPORT_64B_SHIFT, 0x1);
> > +
> > +	if (tbh_phy->phy_power_sts =3D=3D PHY_UNINITIALIZED) {
> > +	/* Indicates initialization, so settings to be done for init , same a=
s
> 400KHZ setting */
> > +		update_reg(tbh_phy, PHY_CFG_0, SEL_DLY_TXCLK_MASK,
> > +SEL_DLY_TXCLK_SHIFT, 0x1);
>=20
> inconsistent indent here too!
>=20
> > +		update_reg(tbh_phy, PHY_CFG_0, SEL_DLY_RXCLK_MASK,
> SEL_DLY_RXCLK_SHIFT, 0x1);
> > +		update_reg(tbh_phy, PHY_CFG_0, ITAP_DLY_ENA_MASK,
> ITAP_DLY_ENA_SHIFT, 0x0);
> > +		update_reg(tbh_phy, PHY_CFG_0, ITAP_DLY_SEL_MASK,
> ITAP_DLY_SEL_SHIFT, 0x0);
> > +		update_reg(tbh_phy, PHY_CFG_0, OTAP_DLY_ENA_MASK,
> OTAP_DLY_ENA_SHIFT, 0x0);
> > +		update_reg(tbh_phy, PHY_CFG_0, OTAP_DLY_SEL_MASK,
> OTAP_DLY_SEL_SHIFT, 0);
> > +		update_reg(tbh_phy, PHY_CFG_0, DLL_TRIM_ICP_MASK,
> DLL_TRIM_ICP_SHIFT, 0);
> > +		update_reg(tbh_phy, PHY_CFG_0, DR_TY_MASK,
> DR_TY_SHIFT, 0x1);
> > +
> > +	} else if (tbh_phy->phy_power_sts =3D=3D PHY_INITIALIZED) {
> > +		/* Indicates actual clock setting */
> > +		rate =3D clk_get_rate(tbh_phy->emmcclk);
> > +		switch (rate) {
> > +		case 200000000:
> > +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_TXCLK_MASK,
> > +				   SEL_DLY_TXCLK_SHIFT, 0x0);
> > +			update_reg(tbh_phy, PHY_CFG_0,
> SEL_DLY_RXCLK_MASK,
> > +				   SEL_DLY_RXCLK_SHIFT, 0x0);
> > +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_ENA_MASK,
> > +				   ITAP_DLY_ENA_SHIFT, 0x0);
> > +			update_reg(tbh_phy, PHY_CFG_0,
> ITAP_DLY_SEL_MASK,
> > +				   ITAP_DLY_SEL_SHIFT, 0x0);
> > +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_ENA_MASK,
> > +				   OTAP_DLY_ENA_SHIFT, 0x1);
> > +			update_reg(tbh_phy, PHY_CFG_0,
> OTAP_DLY_SEL_MASK,
> > +				   OTAP_DLY_SEL_SHIFT, 2);
> > +			update_reg(tbh_phy, PHY_CFG_0,
> DLL_TRIM_ICP_MASK,
> > +				   DLL_TRIM_ICP_SHIFT, 0x8);
> > +			update_reg(tbh_phy, PHY_CFG_0, DR_TY_MASK,
> > +				   DR_TY_SHIFT, 0x1);
> > +			/* For HS400 only */
> > +			update_reg(tbh_phy, PHY_CFG_2, SEL_STRB_MASK,
> > +				   SEL_STRB_SHIFT, STRB);
> > +			break;
>=20
> pls give a empty line after break, helps to read the code
Acknowledged

-Rashmi
