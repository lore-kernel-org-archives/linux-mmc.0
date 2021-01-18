Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D701C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 12:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DE1224B8
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 12:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbhARMCi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 07:02:38 -0500
Received: from foss.arm.com ([217.140.110.172]:34258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403824AbhARMCe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Jan 2021 07:02:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E77A31B;
        Mon, 18 Jan 2021 04:01:37 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39A3F3F719;
        Mon, 18 Jan 2021 04:01:35 -0800 (PST)
Date:   Mon, 18 Jan 2021 12:01:32 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Message-ID: <20210118120132.GC25035@e120937-lin>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
 <20210114164811.GG4854@sirena.org.uk>
 <20210115185803.infufa4thlffagxk@bogus>
 <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi 

sorry I'm a bit late on this.

On Mon, Jan 18, 2021 at 10:28:33AM +0000, Zulkifli, Muhammad Husaini wrote:
> Hi Sudeep and Mark,
> 
> Thanks for the review. I replied inline.
> 
> >-----Original Message-----
> >From: Sudeep Holla <sudeep.holla@arm.com>
> >Sent: Saturday, January 16, 2021 2:58 AM
> >To: Mark Brown <broonie@kernel.org>
> >Cc: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
> >ulf.hansson@linaro.org; lgirdwood@gmail.com; robh+dt@kernel.org;
> >devicetree@vger.kernel.org; Hunter, Adrian <adrian.hunter@intel.com>;
> >michal.simek@xilinx.com; linux-mmc@vger.kernel.org; linux-
> >kernel@vger.kernel.org; Shevchenko, Andriy
> ><andriy.shevchenko@intel.com>; A, Rashmi <rashmi.a@intel.com>; Vaidya,
> >Mahesh R <mahesh.r.vaidya@intel.com>; Sudeep Holla
> ><sudeep.holla@arm.com>
> >Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
> >Firmware Service call
> >
> >On Thu, Jan 14, 2021 at 04:48:11PM +0000, Mark Brown wrote:
> >> On Thu, Jan 14, 2021 at 11:26:56PM +0800, Muhammad Husaini Zulkifli
> >wrote:
> >> > Export inline function to encapsulate AON_CFG1 for controling the
> >> > I/O Rail supplied voltage levels which communicate with Trusted Firmware.
> >>
> >> Adding Sudeep for the SMCCC bits, not deleting any context for his
> >> benefit.
> >>
> >
> >Thanks Mark for cc-ing me and joining the dots. I completely forgot about that
> >fact that this platform was using SCMI using SMC as transport. Sorry for that and
> >it is my fault. I did review the SCMI/SMC support for this platform sometime in
> >June/July last year and forgot the fact it is same platform when
> >voltage/regulator support patches for SD/MMC was posted sometime later last
> >year. I concentrated on SMCCC conventions and other details.
> 
> Yes Sudeep. I redesigned the way I handle the smccc call. Previously it was handled directly in mmc driver.
> After few discussion, we conclude to create an abstraction using regulator framework to encapsulate this smccc call
> during set voltage operation. Using standard abstraction will make things easier for the maintainer.
> 
> >
> >[...]
> >
> >> > +#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
> >> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> >> > +			   ARM_SMCCC_SMC_32,		\
> >> > +			   ARM_SMCCC_OWNER_SIP,		\
> >> > +			   KEEMBAY_SET_SD_VOLTAGE_ID)
> >> > +
> >> > +#define ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE		\
> >> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> >> > +			   ARM_SMCCC_SMC_32,		\
> >> > +			   ARM_SMCCC_OWNER_SIP,		\
> >> > +			   KEEMBAY_GET_SD_VOLTAGE_ID)
> >> > +
> >> > +#define KEEMBAY_REG_NUM_CONSUMERS 2
> >> > +
> >> > +struct keembay_reg_supply {
> >> > +	struct regulator *consumer;
> >> > +};
> >> > +
> >> > +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
> >> > +/*
> >> > + * Voltage applied on the IO Rail is controlled from the Always On
> >> > +Register using specific
> >> > + * bits in AON_CGF1 register. This is a secure register. Keem Bay
> >> > +SOC cannot exposed this
> >> > + * register address to the outside world.
> >> > + */
> >> > +static inline int keembay_set_io_rail_supplied_voltage(int volt) {
> >> > +	struct arm_smccc_res res;
> >> > +
> >> > +
> >	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTA
> >GE, volt,
> >> > +&res);
> >>
> >> There is a SCMI voltage domain protocol intended for just this use
> >> case of controlling regulators managed by the firmware, why are you
> >> not using that for these systems?  See drivers/firmware/arm_scmi/voltage.c.
> 
> From mmc maintainer's perspective, I should use the common modelling either using 
> regulator framework or pinctrl to perform voltage operation. Not just directly invoke 
> smccc call in the mmc driver. That is why I came up with this regulator driver to perform 
> voltage operation. 
> 

There is an SCMI regulator driver built on top of SCMIv3.0 Voltage Domain
Protocol, so as long as your SCMI platform firmware support the new VD
protocol you should be able to wire up a generic SCMI regulator in the DT
(as described in the arm,scmi.txt bindings) and then just use the usual
regulator framework ops with such SCMI regulator without the need to add
a custom regulator using custom SMCCC calls).

Thanks

Cristian

> >>
> >
> >Indeed. Please switch to using the new voltage protocol added for this without
> >any extra code. You just need to wire up DT for this.
> 
> May I know even if I wire up the DT, how should I call this from the mmc driver
> For set/get voltage operation? Any example?
> 
> >
> >Just for curiosity, where is SCMI platform firmware implemented ? On Cortex-
> >A, secure side or external processor. Does this platform run TF-A ?
> 
> The KMB SCMI framework is implemented in secure runtime firmware (TF-A BL31). 
> Hopefully I am answering your question.
> 
> >
> >--
> >Regards,
> >Sudeep
