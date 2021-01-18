Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2181DC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 10:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9042222F
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 10:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbhARKsy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 05:48:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:61697 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389927AbhARKbc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Jan 2021 05:31:32 -0500
IronPort-SDR: WaOMFXSVs31K/i8UE4eTnoqul+9r14p7fzbmUtZMn37X67CTlY4IHagNNeGXSSDKib78q/iyxd
 eo7ttmKBd6KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="197479718"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="197479718"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:28:40 -0800
IronPort-SDR: BXKQil4f5v3JOEnNq+MQcwqD3CDyal+22aDMyhEFPpxaCUxiZaaZU7c1LF7ULPjkawAyhCJm+5
 H4i5f4BKxFPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="466321208"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2021 02:28:40 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 02:28:40 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 02:28:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Jan 2021 02:28:38 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 18 Jan 2021 02:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wglm8iljAaqxymSh415NAYIlQLtR0RR7KIegDMCqKL0MIFeseVDeNbBZeiayu5FzCkFnnAauX2PC85K3b70o1vVd6oliy9rxmoAegjslNYEUboPs/yOwh38sPO0Nbcrj/7u4vD7Si/v6bPskTABUp/8DsNtu7Mq7eyJCJq7pQKFEdWJ1i/6vtj5dlZ5ws/Cmh7Re3jKLvL/2Q4OiWUV2r9B2zd9ybH2OAXVMjC5kuCu1GUrcDGNBVWEXpJeWYonBwlRBXBTyObRVbk9cDg3YlaQzgC4cvnypvDFcyrrdmnWHFaszDXCJrHNHyd5bZ94MSKwYI1T42FILg+12yntlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cOK0/a33ZiOF7GcvPIhwfqfAv6X5I+cItSWPTvOl0s=;
 b=cok4TgN7uk+QZY4cE4gLOeWUWtubtFp7KIZ0bRZhcwFyCvitZxP5AkoGCoXegJGWYJeisiE5vK6Mwm4qZKxefye4Szkb12SZQOYixhgz4ncGD0A8a6oEFa8H56F95rLBTMIv09fmEBup+urMsR4GzgXXutrXP1RHYPlHKzPIlwtvZwCFDG1e+w2+ARBbInSDKCNjz+rgwnMBJNuTGRxCTZn82mz3SKXF7F0oW6qZnHjU44wMklvpG3IN65AujlL5WMJ+OcbCwW/3xy753/wTUwwdu/lJ7EG4Q8UDlgB7VuNGGx7lABenypTxBz2sV5Dskhk97recaw21AOSeicHkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cOK0/a33ZiOF7GcvPIhwfqfAv6X5I+cItSWPTvOl0s=;
 b=O90Tv+2vKsL5K4i+ffmvIEQinKIQd/sGuX93SzxX81iaXkm7a5w4vE/15rxb/+LcUxeFLymNCBbpO1nzQeIVlvzlUYg1Oa9nPYseYKUR76xz8kc/s2DEMXgQZvVCcRu/xIDji7fYtVCPU+YU8jSsBJFl116a7Xk+oYkwXX0W8AQ=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM5PR11MB1498.namprd11.prod.outlook.com (2603:10b6:4:9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Mon, 18 Jan 2021 10:28:35 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 10:28:35 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
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
Thread-Index: AQHW6on3PHcY+Li5xE+i3Wts6XzhC6onVQKAgAG2nYCABCYngA==
Date:   Mon, 18 Jan 2021 10:28:33 +0000
Message-ID: <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
 <20210114164811.GG4854@sirena.org.uk> <20210115185803.infufa4thlffagxk@bogus>
In-Reply-To: <20210115185803.infufa4thlffagxk@bogus>
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
x-ms-office365-filtering-correlation-id: 78d45ea2-f4f9-40f0-fb86-08d8bb9bcfc9
x-ms-traffictypediagnostic: DM5PR11MB1498:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14989AEADDAD3A290ACB7910B8A40@DM5PR11MB1498.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yv+BoquGWfFXGN8x9hl7DX9QMGokgiwjcq70oGgP129IPWknKzNFEry1pF06iefMMt4ltHqeCqgG+1dRnQJE9m8Hm7EUVYu65YBX0adK6j3GGYn3MvQk3ma5B37K6Zx2CEkRDMGZIuJ41wcb2ypr0hU9YMsdyGUoeAo4YKiXcoMn677W+63VdHwGhxPaN1du5nQYajn258uQgJb1m04jA3tZiyHiSTcR//F3N9PkCr1NkLMeDu3djRFQ4ge3TdptviTOjZQ3zHr1UzFACMMEbIP8jp214Lf/0vildyy/3NP7iNUVPpSjSurdlTRXxNI4rT8+fC171lw1bXBbrl8S33IrRP3BxqIuZzKzKuh88YiTpDQrGXxxDO9tsRKMH9Y6e9hvARNKeZnVGf9gD68lF4hBQL9b2IqlXbfciGNnO6VhI2AiJEySE6I9u/2+oY8Eab+E98fLYCf2ZbzcFyglxXaf/7qkHQzFI0+c8uUNp4fTUaiOZON97yEkbgic8SQdiq6XS9jnDvzOlcW3mTSYMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(66446008)(8676002)(66946007)(66556008)(76116006)(66476007)(33656002)(64756008)(83380400001)(8936002)(107886003)(9686003)(55016002)(52536014)(71200400001)(4326008)(5660300002)(6506007)(26005)(54906003)(110136005)(86362001)(2906002)(316002)(478600001)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L9fZNiKkteUJoQ+/D40IRG7cqEcq3NM65skPUzZ3jYcsu69zTPgfmvmLRWcy?=
 =?us-ascii?Q?CY/XkyPqtOf8k8FQ2I3AedZugXtbm/hdHPFc595NEkDRLJ6qZJEK3kabGGpl?=
 =?us-ascii?Q?RpT1j9CCs1xf0UjfrduhxSOD/9xVsM62d/cL7LapS0+7nvYbcyZBpV89pbNX?=
 =?us-ascii?Q?ke9FudNhI2oM6lo0Kv2T0r1CCc/jXXh27lzSAfQ8Tp4UrqhiYWX+tZZgLk9a?=
 =?us-ascii?Q?ayr/OeeOJX4gr0E/VxrrSSH381kWwGeS75uUt5m/aO38J/l6bDFccl028HZP?=
 =?us-ascii?Q?GauRDNgoGxBGnZoKatElbab+m6hcWfdaXlneeqt5d/2zPAJsxSCMGBvWk4NF?=
 =?us-ascii?Q?Q9q1XQygel+L5ROcE9yV5x83p4dwzD5moKufYN9KoQXcJharzvDmZ9V59T+B?=
 =?us-ascii?Q?tM0Hg82GnfMBpiGbc3u2gyz5NoWRmbC6SjsZqWuQQoQEm+BthqpzoY3oBGf/?=
 =?us-ascii?Q?5H47eL+hiLDPzSsx1UM5v8pI9vO7kZ5scBI41exS/dbnXFK9Em3i7X30WYfA?=
 =?us-ascii?Q?TwFp1LzvtCZWON9OHdjNBRIKOISShJmeQ1zBTqEaFSNoSYJ0P5UzssTc+DgG?=
 =?us-ascii?Q?uYuK45eOqAh1Lh+EJOvHzm6806VQCkP/aWqEB9CVk/GsnPVXKs7Kx8F2Rut7?=
 =?us-ascii?Q?hnE60vDhcgiMANvlQeie3U7GEUmrKgGdCLpMmbNlKfxnXp7yUnNS7jOsXwvv?=
 =?us-ascii?Q?1SV1zS8cyHvjacHDhu4B60nIOtOSg0NB1dSOA9NPG1m4HoxQo/FipT91S/MC?=
 =?us-ascii?Q?qL6dT6Wnqi0YYLYoRWYRzCIbgOhlbqCh3k+As2BFVWAgW6BFZFfLvfzF2Ut9?=
 =?us-ascii?Q?xkZp0P2T4dYG5dLIJML0WP6PcYId5JNSBt5ukhbmFeII4nAvQ6GfwBzQAxF0?=
 =?us-ascii?Q?yxHbEksUfik7m7R706aVMCcHyKWYy0F/6EmEaS4VpkSpfQ0oOW7kJpICRxee?=
 =?us-ascii?Q?/yNKzQNzlKDG6dOgm8R59Igq7L3nHcWp7uNHEYhanVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d45ea2-f4f9-40f0-fb86-08d8bb9bcfc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 10:28:34.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aag9j0FXeHPxsT2ShPJbo1dDRvcG15ELKd+N3AfPepDsiwXf8eAKrsVHmzzWGpyoMZLU5RAq9+MprspjbC52yhqMl3GU3duC1y9UoeTPLM3BoAlPyxgfRrX6wwjn1oh2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1498
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sudeep and Mark,

Thanks for the review. I replied inline.

>-----Original Message-----
>From: Sudeep Holla <sudeep.holla@arm.com>
>Sent: Saturday, January 16, 2021 2:58 AM
>To: Mark Brown <broonie@kernel.org>
>Cc: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
>ulf.hansson@linaro.org; lgirdwood@gmail.com; robh+dt@kernel.org;
>devicetree@vger.kernel.org; Hunter, Adrian <adrian.hunter@intel.com>;
>michal.simek@xilinx.com; linux-mmc@vger.kernel.org; linux-
>kernel@vger.kernel.org; Shevchenko, Andriy
><andriy.shevchenko@intel.com>; A, Rashmi <rashmi.a@intel.com>; Vaidya,
>Mahesh R <mahesh.r.vaidya@intel.com>; Sudeep Holla
><sudeep.holla@arm.com>
>Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
>Firmware Service call
>
>On Thu, Jan 14, 2021 at 04:48:11PM +0000, Mark Brown wrote:
>> On Thu, Jan 14, 2021 at 11:26:56PM +0800, Muhammad Husaini Zulkifli
>wrote:
>> > Export inline function to encapsulate AON_CFG1 for controling the
>> > I/O Rail supplied voltage levels which communicate with Trusted Firmwa=
re.
>>
>> Adding Sudeep for the SMCCC bits, not deleting any context for his
>> benefit.
>>
>
>Thanks Mark for cc-ing me and joining the dots. I completely forgot about =
that
>fact that this platform was using SCMI using SMC as transport. Sorry for t=
hat and
>it is my fault. I did review the SCMI/SMC support for this platform someti=
me in
>June/July last year and forgot the fact it is same platform when
>voltage/regulator support patches for SD/MMC was posted sometime later las=
t
>year. I concentrated on SMCCC conventions and other details.

Yes Sudeep. I redesigned the way I handle the smccc call. Previously it was=
 handled directly in mmc driver.
After few discussion, we conclude to create an abstraction using regulator =
framework to encapsulate this smccc call
during set voltage operation. Using standard abstraction will make things e=
asier for the maintainer.

>
>[...]
>
>> > +#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
>> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
>> > +			   ARM_SMCCC_SMC_32,		\
>> > +			   ARM_SMCCC_OWNER_SIP,		\
>> > +			   KEEMBAY_SET_SD_VOLTAGE_ID)
>> > +
>> > +#define ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE		\
>> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
>> > +			   ARM_SMCCC_SMC_32,		\
>> > +			   ARM_SMCCC_OWNER_SIP,		\
>> > +			   KEEMBAY_GET_SD_VOLTAGE_ID)
>> > +
>> > +#define KEEMBAY_REG_NUM_CONSUMERS 2
>> > +
>> > +struct keembay_reg_supply {
>> > +	struct regulator *consumer;
>> > +};
>> > +
>> > +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
>> > +/*
>> > + * Voltage applied on the IO Rail is controlled from the Always On
>> > +Register using specific
>> > + * bits in AON_CGF1 register. This is a secure register. Keem Bay
>> > +SOC cannot exposed this
>> > + * register address to the outside world.
>> > + */
>> > +static inline int keembay_set_io_rail_supplied_voltage(int volt) {
>> > +	struct arm_smccc_res res;
>> > +
>> > +
>	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTA
>GE, volt,
>> > +&res);
>>
>> There is a SCMI voltage domain protocol intended for just this use
>> case of controlling regulators managed by the firmware, why are you
>> not using that for these systems?  See drivers/firmware/arm_scmi/voltage=
.c.

From mmc maintainer's perspective, I should use the common modelling either=
 using=20
regulator framework or pinctrl to perform voltage operation. Not just direc=
tly invoke=20
smccc call in the mmc driver. That is why I came up with this regulator dri=
ver to perform=20
voltage operation.=20

>>
>
>Indeed. Please switch to using the new voltage protocol added for this wit=
hout
>any extra code. You just need to wire up DT for this.

May I know even if I wire up the DT, how should I call this from the mmc dr=
iver
For set/get voltage operation? Any example?

>
>Just for curiosity, where is SCMI platform firmware implemented ? On Corte=
x-
>A, secure side or external processor. Does this platform run TF-A ?

The KMB SCMI framework is implemented in secure runtime firmware (TF-A BL31=
).=20
Hopefully I am answering your question.

>
>--
>Regards,
>Sudeep
