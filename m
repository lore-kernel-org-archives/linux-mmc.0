Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933EAC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64300235F8
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 19:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbhAOTPR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:15:17 -0500
Received: from foss.arm.com ([217.140.110.172]:52484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388123AbhAOTPQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Jan 2021 14:15:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28C7ED1;
        Fri, 15 Jan 2021 11:14:30 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF393F719;
        Fri, 15 Jan 2021 11:14:28 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:14:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        ulf.hansson@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 8/9] regulator: keembay: Add regulator for Keem Bay SoC
Message-ID: <20210115191426.xf23pde2drtlujkg@bogus>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <20210114152700.21916-9-muhammad.husaini.zulkifli@intel.com>
 <20210114171434.GI4854@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114171434.GI4854@sirena.org.uk>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 14, 2021 at 05:14:34PM +0000, Mark Brown wrote:
> On Thu, Jan 14, 2021 at 11:26:59PM +0800, Muhammad Husaini Zulkifli wrote:
>
> > Keem Bay SD regulator driver module is added to encapsulate ARM
> > Secure Monitor Call Calling Convention (SMCCC) during set voltage
> > operations to control I/O Rail supplied voltage levels which communicate
> > with Trusted Firmware.
>
> Adding in Sudeep again for the SMCCC bits.  I just checked and am I
> right in thinking this might already be shipping in production?
>

OK you seem to have asked the most important question here directly.
I have asked for the details of platform firmware implementation in
the other email basically for the same reason(to check how feasible is
it to move to new SCMI voltage protocol). Some work in the firmware, but
if the implement is on the A-profile itself in TF-A or any other equivalent,
it should not be too difficult.

--
Regards,
Sudeep
