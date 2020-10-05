Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7422C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765A221527
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 20:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgJEUH4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 16:07:56 -0400
Received: from foss.arm.com ([217.140.110.172]:57184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgJEUH4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Oct 2020 16:07:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888B211D4;
        Mon,  5 Oct 2020 13:07:55 -0700 (PDT)
Received: from bogus (unknown [10.57.48.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7923E3F70D;
        Mon,  5 Oct 2020 13:07:53 -0700 (PDT)
Date:   Mon, 5 Oct 2020 21:07:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201005200744.robd42nkt6ahg52x@bogus>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
 <20201002145115.GA6520@bogus>
 <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
 <20201005084441.znou7licvvtomva4@bogus>
 <BYAPR11MB3015F4E8FDF3CB1273A35EFAB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3015F4E8FDF3CB1273A35EFAB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 05, 2020 at 05:04:10PM +0000, Zulkifli, Muhammad Husaini wrote:

> To be clarify keembay_sd_voltage_selection function as Michal's prefers is
> actually using the firmware driver. This function located in firmware
> driver.

OK, it can be just one function place it in any file you think is more
appropriate need not be arasan controller driver. Any reasons why this
can't work ? Can even be in some header.

int keembay_sd_voltage_selection(int volt)
{
	int res;

	arm_smccc_1_1_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID, volt, &res)

	/* appropriate error check if needed here */

	return res;
}

> I will call this func during voltage switching from arasan controller. I
> believe this implementation require DT to specify the compatible name and
> method use either smc/hvc.

No, use the standard one as detected by arm_smccc_1_1_invoke
(It calls arm_smccc_get_conduit internally and use SMC/HVC based on that)

> 
> Are you saying that by using simple smcc based function library I should
> call below func() in arasan controller. For example
> 1) arm_smccc_get_version(void)
> 2) arm_smccc_version_init(arm_smccc_get_version(), SMCCC_CONDUIT_SMC);

Nope

> 3) arm_smccc_1_1_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID, voltage_value ,  &res);

Just this.

-- 
Regards,
Sudeep
