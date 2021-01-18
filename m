Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A5C433E9
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435D822472
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 11:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbhARL41 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 06:56:27 -0500
Received: from foss.arm.com ([217.140.110.172]:34146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390943AbhARL4X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Jan 2021 06:56:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABEB331B;
        Mon, 18 Jan 2021 03:55:35 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948B53F719;
        Mon, 18 Jan 2021 03:55:33 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:55:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "i A, Rashmi" <rashmi.a@intel.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Message-ID: <20210118115531.er5tih7k2faig5cr@bogus>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
 <20210114164811.GG4854@sirena.org.uk>
 <20210115185803.infufa4thlffagxk@bogus>
 <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB287679CF20BBC7C81B6E38F5B8A40@DM6PR11MB2876.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
> From mmc maintainer's perspective, I should use the common modelling either
> using regulator framework or pinctrl to perform voltage operation. Not just
> directly invoke  smccc call in the mmc driver. That is why I came up with
> this regulator driver to perform voltage operation.
>

That's correct. Since the platform uses SCMI and SCMI spec[1] supports Voltage
protocol and there is upstream driver[2] to support it, I see no point in
duplicating the support with another custom/non-standard solution.

> >>
> >
> >Indeed. Please switch to using the new voltage protocol added for this without
> >any extra code. You just need to wire up DT for this.
> 
> May I know even if I wire up the DT, how should I call this from the mmc driver
> For set/get voltage operation? Any example?
>

Mark has already pointed you to the binding document[3]

> >
> >Just for curiosity, where is SCMI platform firmware implemented ? On Cortex-
> >A, secure side or external processor. Does this platform run TF-A ?
> 
> The KMB SCMI framework is implemented in secure runtime firmware (TF-A BL31). 
> Hopefully I am answering your question.
>

Yes, it should be easy to extend the implementation and add support for
voltage protocol.

If you still face any issues, please ask any queries on the list cc-ing
me and Cristian Marussi(cc-ed)

--
Regards,
Sudeep

[1] https://developer.arm.com/documentation/den0056/latest
[2] drivers/firmware/arm_scmi/voltage.c + drivers/regulator/scmi-regulator.c
[3] Documentation/devicetree/bindings/arm/arm,scmi.txt

