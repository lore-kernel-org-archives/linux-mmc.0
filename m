Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B7DC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 02:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA539223DB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 02:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbhASCjY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:39:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:18016 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387817AbhASCjW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Jan 2021 21:39:22 -0500
IronPort-SDR: RM9oXesCBXNco2PvXxvMwJv2kHpftyVuA62OvMxF26XUYGQg9p10p8qEzyFw9/unSMSDlxZLev
 wz0wXj3LeJGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="175366138"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="175366138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 18:38:41 -0800
IronPort-SDR: h/z6q3frNRISw5CWrdAgfHX51R7HuV1oa0lxByy2maGUu9OwasbvlBnLg9dt170Q8Daoll+EOd
 kEmLSEuOB+lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="426314292"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2021 18:38:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 18:38:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Jan 2021 18:38:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 18 Jan 2021 18:38:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY0QhSXNspeRnvpeTrxMHY0W3uWZcwwXGhoQkiRmKZ0tQd/SwEZyJEADOXbs2xWHoibuA/yzW6YC9Nul588CkVLC6ggHwWom03sJyBIJOMvE/1wnbS0rxw5Gm6XX8/kq61MKkOQ+NrFdi/TLwLMc3oQo2dTcVZnAdBBFPaJaBJzo1p4aQwh8Bf2gXRuqSIL0R8TkIDbUqoWlzZP1aidqd2/A2DEU2He/Y+JEt0RkrPy+iEzo7zZrzmz284GFjmQwjf7e1NLOIJsBSNYZT5zCNzYUQ7JLOR24YDp+GWLmntQbsDv3WtRiIMrOvs82L6s9yZCmFA3n2ZTYuTNuz9Vx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjiKvaRMo+KY3V2sJuuBBM9R35WiTWdSilM0EpPlW4Y=;
 b=PwdpjtGyRxEFyaPG6UYZtbFbDbIyyVr3oFQGYYzCZld+2RLusgdVrRPV5awd/QGinfBr9gouVA8hjLB56oEouCmndWJOOWjTQxXNWMMTPTMuuEdu5zkDm32TrwvG06F/Oak7mxKYdeRQ4nQmpE44Nn37PRfBP8KoXaejMlcAO6PpO/YyZyet4QbL6+s/MPpy05dzMNXGEa3bXJJ/hdiebEUvG6LlEKONSIHj9NZsoGiUHdI60aUK3OS8KrYrfHt0v3tRTTgYoOFpQnjG+2Zb/OB6nLMHxycmxcGOmErnQEdYcm+tIRcSGrLI1P0o8NR8kbPRegjLxPg/7qioDwi6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjiKvaRMo+KY3V2sJuuBBM9R35WiTWdSilM0EpPlW4Y=;
 b=h7C4N1VRKzN2qLhVrH7n/ByTrxNHx9egoTh/Zx56s5M7Ofpopk6YaSoqEmADx6XaNnPg3ZvHzp5RsZVGJMTT9PScZf4yu+BAgmtLLq9yVRjQX4EPjuKvP/5Tov+gsxLe78XGWadLN+zgjwRmeohJKXAjUerhK+saeZ4nukVZoCo=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2969.namprd11.prod.outlook.com (2603:10b6:5:70::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Tue, 19 Jan 2021 02:38:32 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:38:32 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
Subject: RE: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Thread-Topic: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Thread-Index: AQHW6on3PHcY+Li5xE+i3Wts6XzhC6onVQKAgAG2nYCABCYngIAAHHgAgADy9hA=
Date:   Tue, 19 Jan 2021 02:38:32 +0000
Message-ID: <DM6PR11MB2876FCA96049D398A899A930B8A30@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
 <20210114164811.GG4854@sirena.org.uk> <20210115185803.infufa4thlffagxk@bogus>
 <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
 <20210118120132.GC25035@e120937-lin>
In-Reply-To: <20210118120132.GC25035@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.165.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c046e231-b90b-41de-8874-08d8bc235030
x-ms-traffictypediagnostic: DM6PR11MB2969:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2969B9B56FB759E7BC9F40D2B8A30@DM6PR11MB2969.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pjydnz+KPeefwZV7KSDJLWc1bDp96R2FHF+a6mDvA5eVJPJ7wJBUFNZs4SrMDobqYTflN9fLki+zIU+3M07Um63ZnQ7tkDLH9h6pzkwf+q++MiGEBipzcVyKV8sTFqQtUdZspwvn5JpXdXNTmlaZEHn2tUW1iks63/DN9PHR0DmBfpivIGhxfwPBmnYLAGWU3Dpi+V5p9M2W3/mYDelcnH/K5ZUmR3RvNe0g+7PLWbF8yS0RYjgGE+tq7dP4VAsMCc1hRQNSrM+uCVf9Ffgjz9FpHcWDMv6TLudaaFEjiH44Q7XOEfjOunvTjEo7EC+nXZI6S11xMJHa54nU53Rbv/+nj3lzrCOk8ljSvaaZBP7uLaKvHFzSHjbV2DkTTulQ6bAq7Z0a3T19PLYE7LqVLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(316002)(8676002)(4326008)(54906003)(2906002)(76116006)(83380400001)(33656002)(66446008)(66946007)(26005)(66476007)(478600001)(52536014)(86362001)(9686003)(64756008)(7696005)(6916009)(186003)(66556008)(55016002)(71200400001)(8936002)(5660300002)(7416002)(6506007)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G0L7STHPJ3aCNfUdIy2o73n4txhscNogm2lHuDkLK7hG0+LNVZi64ocrbij6?=
 =?us-ascii?Q?yCOtJeJ1R4nPDPHuXsKmMo6b0+Rikf8ymnrmg58bjE4hPrqGvZUuq1hrMxK0?=
 =?us-ascii?Q?LgdKxq2xqMJ2HYPizRs8p5I/gjMCGZKl2l50kBY8DRfiw3KVpiXW8Et6RBBy?=
 =?us-ascii?Q?a5AwdgjJEhBXGavT7A/FA0Wp+PDWyIevsnKH4cxRggLNowCTX9wdzDlPihFn?=
 =?us-ascii?Q?thSpiKR+Dx5NRg6FYhqf0IfWdcGttin0rDNK6amOkQRwUJ+8PV3pbuTaIFbC?=
 =?us-ascii?Q?G0e+o9GBTqqDjEmW7Gk+RnAAABMTW3ZhYbGyonm8b3Q+ZPtpYA9C32KSCIcR?=
 =?us-ascii?Q?2Q/aNmx+AyN2qodJ1AlxdKZgTlAquY92wc5cR+z0OSH7KhKUHpHL3ESC3v4M?=
 =?us-ascii?Q?Nq4gYBNrS0HRYoxbZh+Fr6vtZdC7Qy2DYALmRVBKh+P/h5ZbQfZ8znELxezc?=
 =?us-ascii?Q?GfZtwPDU66fPuNW3noxMf44tNloh9SGpMJ8XySwo9a/+winMsEIUeHGAMaRc?=
 =?us-ascii?Q?il+hEl0nYtGn8AWvWjnkUkhIjI2wIy8L0onyJmDmrFEtrALAJBqkhM1PFvhX?=
 =?us-ascii?Q?wDr5RcTs1TZw6XLdzrBHt/rRQn1eCqXr7262u4v1uVmAh2cIxhCA+vO6hLX0?=
 =?us-ascii?Q?8UgExFrpjKjYWZA1FmH2X+G08vxVHbHrx658m2SIrERZE5D3iXZgS0aYKseE?=
 =?us-ascii?Q?ksG2sJ01eiTNRA4y7hhpvkLG2M/yvkB+77iXWzGz6SRM+SPgfTkkvZ7+KvpY?=
 =?us-ascii?Q?/Q1KLxXEARoldfREToCZMYqSDfE938zIeY5mP3g08JplryA8RXRIqdFdc18u?=
 =?us-ascii?Q?eAWiXQ3pzKEFwegMX5zHkqJBMXk7Pi/lrynmZtGUrcMLy3oSCN/ubZ1JoGZW?=
 =?us-ascii?Q?kNK5PJNOCGxY88qbc2i3ly7yR7pK+dChQbLDsVfz93npjdzdoRckx/BT2Afh?=
 =?us-ascii?Q?Qlk0xM6uFojsbMLTD1jRutOiekVGK2gACsCZuYlWV2k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c046e231-b90b-41de-8874-08d8bc235030
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 02:38:32.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRfdGrUeDMz7CbYHVaX8T3XsMcKa5jvM2AVQ5/SpZJRzeT3jX+YU9fbcq4MbMkZ0/JKwmDPb6UdzQlUbh9yusPLjLBhnh3PLYjPhe8msfHC5dyfwpm1q+6l7T1K43z2P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2969
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Cristian, Sudeep and Mark,

>-----Original Message-----
>From: Cristian Marussi <cristian.marussi@arm.com>
>Sent: Monday, January 18, 2021 8:02 PM
>To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>Cc: Sudeep Holla <sudeep.holla@arm.com>; Mark Brown
><broonie@kernel.org>; ulf.hansson@linaro.org; lgirdwood@gmail.com;
>robh+dt@kernel.org; devicetree@vger.kernel.org; Hunter, Adrian
><adrian.hunter@intel.com>; michal.simek@xilinx.com; linux-
>mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Shevchenko, Andriy
><andriy.shevchenko@intel.com>; A, Rashmi <rashmi.a@intel.com>; Vaidya,
>Mahesh R <mahesh.r.vaidya@intel.com>
>Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
>Firmware Service call
>
>Hi
>
>sorry I'm a bit late on this.
>
>On Mon, Jan 18, 2021 at 10:28:33AM +0000, Zulkifli, Muhammad Husaini
>wrote:
>> Hi Sudeep and Mark,
>>
>> Thanks for the review. I replied inline.
>>
>> >-----Original Message-----
>> >From: Sudeep Holla <sudeep.holla@arm.com>
>> >Sent: Saturday, January 16, 2021 2:58 AM
>> >To: Mark Brown <broonie@kernel.org>
>> >Cc: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
>> >ulf.hansson@linaro.org; lgirdwood@gmail.com; robh+dt@kernel.org;
>> >devicetree@vger.kernel.org; Hunter, Adrian <adrian.hunter@intel.com>;
>> >michal.simek@xilinx.com; linux-mmc@vger.kernel.org; linux-
>> >kernel@vger.kernel.org; Shevchenko, Andriy
>> ><andriy.shevchenko@intel.com>; A, Rashmi <rashmi.a@intel.com>;
>> >Vaidya, Mahesh R <mahesh.r.vaidya@intel.com>; Sudeep Holla
>> ><sudeep.holla@arm.com>
>> >Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for
>> >Trusted Firmware Service call
>> >
>> >On Thu, Jan 14, 2021 at 04:48:11PM +0000, Mark Brown wrote:
>> >> On Thu, Jan 14, 2021 at 11:26:56PM +0800, Muhammad Husaini Zulkifli
>> >wrote:
>> >> > Export inline function to encapsulate AON_CFG1 for controling the
>> >> > I/O Rail supplied voltage levels which communicate with Trusted
>Firmware.
>> >>
>> >> Adding Sudeep for the SMCCC bits, not deleting any context for his
>> >> benefit.
>> >>
>> >
>> >Thanks Mark for cc-ing me and joining the dots. I completely forgot
>> >about that fact that this platform was using SCMI using SMC as
>> >transport. Sorry for that and it is my fault. I did review the
>> >SCMI/SMC support for this platform sometime in June/July last year
>> >and forgot the fact it is same platform when voltage/regulator
>> >support patches for SD/MMC was posted sometime later last year. I
>concentrated on SMCCC conventions and other details.
>>
>> Yes Sudeep. I redesigned the way I handle the smccc call. Previously it =
was
>handled directly in mmc driver.
>> After few discussion, we conclude to create an abstraction using
>> regulator framework to encapsulate this smccc call during set voltage
>operation. Using standard abstraction will make things easier for the
>maintainer.
>>
>> >
>> >[...]
>> >
>> >> > +#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE
>	\
>> >> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,
>	\
>> >> > +			   ARM_SMCCC_SMC_32,		\
>> >> > +			   ARM_SMCCC_OWNER_SIP,		\
>> >> > +			   KEEMBAY_SET_SD_VOLTAGE_ID)
>> >> > +
>> >> > +#define ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE
>	\
>> >> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,
>	\
>> >> > +			   ARM_SMCCC_SMC_32,		\
>> >> > +			   ARM_SMCCC_OWNER_SIP,		\
>> >> > +			   KEEMBAY_GET_SD_VOLTAGE_ID)
>> >> > +
>> >> > +#define KEEMBAY_REG_NUM_CONSUMERS 2
>> >> > +
>> >> > +struct keembay_reg_supply {
>> >> > +	struct regulator *consumer;
>> >> > +};
>> >> > +
>> >> > +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
>> >> > +/*
>> >> > + * Voltage applied on the IO Rail is controlled from the Always
>> >> > +On Register using specific
>> >> > + * bits in AON_CGF1 register. This is a secure register. Keem
>> >> > +Bay SOC cannot exposed this
>> >> > + * register address to the outside world.
>> >> > + */
>> >> > +static inline int keembay_set_io_rail_supplied_voltage(int volt) {
>> >> > +	struct arm_smccc_res res;
>> >> > +
>> >> > +
>> >	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTA
>> >GE, volt,
>> >> > +&res);
>> >>
>> >> There is a SCMI voltage domain protocol intended for just this use
>> >> case of controlling regulators managed by the firmware, why are you
>> >> not using that for these systems?  See
>drivers/firmware/arm_scmi/voltage.c.
>>
>> From mmc maintainer's perspective, I should use the common modelling
>> either using regulator framework or pinctrl to perform voltage
>> operation. Not just directly invoke smccc call in the mmc driver. That
>> is why I came up with this regulator driver to perform voltage operation=
.
>>
>
>There is an SCMI regulator driver built on top of SCMIv3.0 Voltage Domain
>Protocol, so as long as your SCMI platform firmware support the new VD
>protocol you should be able to wire up a generic SCMI regulator in the DT
>(as described in the arm,scmi.txt bindings) and then just use the usual
>regulator framework ops with such SCMI regulator without the need to add
>a custom regulator using custom SMCCC calls).

I try to hook up the DT last night. Seems like the SCMI Protocol 17 is not =
implemented at ATF side.
Double check with ATF Team, currently we don't have SCMI voltage domain con=
trol in ARM Trusted Firmware yet
as of now, that is why even if I map the function to scmi, my call will be =
fail.

[    2.648989] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    2.656157] arm-scmi firmware:scmi: SCMI Protocol v1.0 'INTEL:KMB' Firmw=
are version 0x1
[    2.664513] arm-scmi firmware:scmi: SCMI protocol 23 not implemented
[    2.675898] arm-scmi firmware:scmi: SCMI protocol 17 not implemented

Any possibilities that for UHS patch we go with my current regulator driver=
 implementation?

>
>Thanks
>
>Cristian
>
>> >>
>> >
>> >Indeed. Please switch to using the new voltage protocol added for this
>without
>> >any extra code. You just need to wire up DT for this.
>>
>> May I know even if I wire up the DT, how should I call this from the mmc
>driver
>> For set/get voltage operation? Any example?
>>
>> >
>> >Just for curiosity, where is SCMI platform firmware implemented ? On
>Cortex-
>> >A, secure side or external processor. Does this platform run TF-A ?
>>
>> The KMB SCMI framework is implemented in secure runtime firmware (TF-A
>BL31).
>> Hopefully I am answering your question.
>>
>> >
>> >--
>> >Regards,
>> >Sudeep
