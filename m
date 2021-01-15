Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98DC43332
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE123B86
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbhAOS6x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 13:58:53 -0500
Received: from foss.arm.com ([217.140.110.172]:51642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbhAOS6x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Jan 2021 13:58:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DE2ED1;
        Fri, 15 Jan 2021 10:58:07 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 984513F719;
        Fri, 15 Jan 2021 10:58:05 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:58:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        ulf.hansson@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 5/9] firmware: keembay: Add support for Trusted
 Firmware Service call
Message-ID: <20210115185803.infufa4thlffagxk@bogus>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
 <20210114164811.GG4854@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114164811.GG4854@sirena.org.uk>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 14, 2021 at 04:48:11PM +0000, Mark Brown wrote:
> On Thu, Jan 14, 2021 at 11:26:56PM +0800, Muhammad Husaini Zulkifli wrote:
> > Export inline function to encapsulate AON_CFG1 for controling the I/O Rail
> > supplied voltage levels which communicate with Trusted Firmware.
>
> Adding Sudeep for the SMCCC bits, not deleting any context for his
> benefit.
>

Thanks Mark for cc-ing me and joining the dots. I completely forgot about
that fact that this platform was using SCMI using SMC as transport. Sorry
for that and it is my fault. I did review the SCMI/SMC support for this
platform sometime in June/July last year and forgot the fact it is same
platform when voltage/regulator support patches for SD/MMC was posted
sometime later last year. I concentrated on SMCCC conventions and other
details.

[...]

> > +#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> > +			   ARM_SMCCC_SMC_32,		\
> > +			   ARM_SMCCC_OWNER_SIP,		\
> > +			   KEEMBAY_SET_SD_VOLTAGE_ID)
> > +
> > +#define ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE		\
> > +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> > +			   ARM_SMCCC_SMC_32,		\
> > +			   ARM_SMCCC_OWNER_SIP,		\
> > +			   KEEMBAY_GET_SD_VOLTAGE_ID)
> > +
> > +#define KEEMBAY_REG_NUM_CONSUMERS 2
> > +
> > +struct keembay_reg_supply {
> > +	struct regulator *consumer;
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
> > +/*
> > + * Voltage applied on the IO Rail is controlled from the Always On Register using specific
> > + * bits in AON_CGF1 register. This is a secure register. Keem Bay SOC cannot exposed this
> > + * register address to the outside world.
> > + */
> > +static inline int keembay_set_io_rail_supplied_voltage(int volt)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &res);
>
> There is a SCMI voltage domain protocol intended for just this use case
> of controlling regulators managed by the firmware, why are you not using
> that for these systems?  See drivers/firmware/arm_scmi/voltage.c.
>

Indeed. Please switch to using the new voltage protocol added for this without
any extra code. You just need to wire up DT for this.

Just for curiosity, where is SCMI platform firmware implemented ? On Cortex-A,
secure side or external processor. Does this platform run TF-A ?

--
Regards,
Sudeep
