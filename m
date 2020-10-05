Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89165C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 08:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F0920781
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 08:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJEIou (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:44:50 -0400
Received: from foss.arm.com ([217.140.110.172]:41354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIou (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Oct 2020 04:44:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C23DC101E;
        Mon,  5 Oct 2020 01:44:49 -0700 (PDT)
Received: from bogus (unknown [10.57.48.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91DEE3F66B;
        Mon,  5 Oct 2020 01:44:47 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:44:41 +0100
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
Message-ID: <20201005084441.znou7licvvtomva4@bogus>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
 <20201002145115.GA6520@bogus>
 <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 05, 2020 at 08:37:13AM +0000, Zulkifli, Muhammad Husaini wrote:
> Hi Sudeep,
> 
> I am facing an error during sending yesterday.
> I response again to your feedback as below
> 
> >-----Original Message-----
> >From: Sudeep Holla <sudeep.holla@arm.com>
> >Sent: Friday, October 2, 2020 10:51 PM
> >To: Michal Simek <michal.simek@xilinx.com>
> >Cc: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
> >Hunter, Adrian <adrian.hunter@intel.com>; ulf.hansson@linaro.org; linux-
> >mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> >kernel@vger.kernel.org; Raja Subramanian, Lakshmi Bai
> ><lakshmi.bai.raja.subramanian@intel.com>; arnd@arndb.de; Sudeep Holla
> ><sudeep.holla@arm.com>; Wan Mohamad, Wan Ahmad Zainie
> ><wan.ahmad.zainie.wan.mohamad@intel.com>
> >Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
> >Firmware Service call
> >
> >Hi Michal,
> >
> >On Fri, Oct 02, 2020 at 03:53:33PM +0200, Michal Simek wrote:
> >> Hi Sudeep,
> >>
> >> On 02. 10. 20 12:58, Sudeep Holla wrote:
> >> > Hi Michal,
> >> >
> >> > On Fri, Oct 02, 2020 at 10:23:02AM +0200, Michal Simek wrote:
> >> >> Hi Sudeep,
> >> >>
> >> >> On 01. 10. 20 17:35, Sudeep Holla wrote:
> >> >
> >> > [...]
> >> >
> >> >>>
> >> >>> What are the other uses of this KEEMBAY_SIP_* ?
> >> >>> For now I tend to move this to the driver making use of it using
> >> >>> arm_smccc_1_1_invoke directly if possible. I don't see the need
> >> >>> for this to be separate driver. But do let us know the features
> >> >>> implemented in the firmware. If it is not v1.1+, reasons for not
> >> >>> upgrading as you need v1.1 for some CPU errata implementation.
> >> >>
> >> >> This driver has been created based on my request to move it out the
> >> >> mmc driver. It looks quite hacky to have arm_smccc_res and call
> >> >> arm_smccc_smc() also with some IDs where it is visible that the
> >> >> part of ID is just based on any spec.
> >> >
> >> > OK, driver is fine but no dt-bindings as it is discoverable. It can
> >> > also be just a wrapper library instead as it needs no explicit
> >> > initialisation like drivers to setup.
> >>
> >> I am fine with it. Do we have any example which we can point him to?
> >>
> >
> >You seem to have figured that out already with SOC_ID example.
> >That was quick I must say 😄.
> >
> >>
> >> >
> >> >> Also in v1 he is just calling SMC. But maybe there is going a need
> >> >> to call HVC instead which is something what device driver shouldn't
> >> >> decide that's why IMHO doing step via firmware driver is much better
> >approach.
> >> >
> >> > Agreed and one must use arm_smccc_get_conduit or something similar.
> >> > No additional bindings for each and ever platform and driver that
> >> > uses SMCCC please.
> >> >
> >> >> Of course if there is a better/cleaner way how this should be done
> >> >> I am happy to get more information about it.
> >> >>
> >> >
> >> > Let me know what you think about my thoughts stated above.
> >>
> >>
> >> I am fine with it. The key point is to have these sort it out because
> >> I see that a lot of drivers just simply call that SMCs from drivers
> >> which is IMHO wrong.
> >>
> >
> >Sure, sorry I didn't express my concern properly. I want to avoid dt bindings for
> >these and use the SMCCC discovery we have in place already if possible.
> >
> >If this driver had consumers in the DT and it needs to be represented in DT, it is
> >a different story and I agree for need for a driver there.
> >But I don't see one in this usecase.
> 
> 
> Does it ok if I do some checking in arasan controller driver as below and represented it in the DT of arasan,sdhci.yaml:
> This is to ensure that for Keem Bay SOC specific, the firmware driver must be consume.
> 
> 	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
> 		struct device_node *dn;
> 		struct gpio_desc *uhs;
> 
> 		dn = of_find_node_by_name(NULL, "keembay_firmware");

You have keembay_sd_voltage_selection function as Michal prefers, I have
no objections for that. But please no keembay_firmware node in DT.
You can implement this as a driver or simple smccc based function library
without DT node using SMCCC get_version. I hope the firmware gives error
for unimplemented FIDs, thereby eliminating the need for any DT node or
config option.

-- 
Regards,
Sudeep
