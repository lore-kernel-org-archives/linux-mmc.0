Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CCCC468C0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BF920706
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbhASRWk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:22:40 -0500
Received: from foss.arm.com ([217.140.110.172]:41292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390373AbhASRVb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 Jan 2021 12:21:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4745111D4;
        Tue, 19 Jan 2021 09:20:33 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918BD3F66E;
        Tue, 19 Jan 2021 09:20:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:20:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
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
Message-ID: <20210119172028.577x72bxv2khmg76@bogus>
References: <20210118120132.GC25035@e120937-lin>
 <DM6PR11MB2876FCA96049D398A899A930B8A30@DM6PR11MB2876.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2876FCA96049D398A899A930B8A30@DM6PR11MB2876.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 19, 2021 at 02:38:32AM +0000, Zulkifli, Muhammad Husaini wrote:

[...]

> 
> I try to hook up the DT last night. Seems like the SCMI Protocol 17 is not
> implemented at ATF side.

I had guessed that.

> Double check with ATF Team, currently we don't have SCMI voltage domain
> control in ARM Trusted Firmware yet as of now, that is why even if I map the
> function to scmi, my call will be fail.

Correct, but if you already have this custom SMCCC for voltage already
implemented in TF-A, I don't see it is a big deal to support voltage
protocol there.

> 
> [    2.648989] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
> [    2.656157] arm-scmi firmware:scmi: SCMI Protocol v1.0 'INTEL:KMB' Firmware version 0x1
> [    2.664513] arm-scmi firmware:scmi: SCMI protocol 23 not implemented
> [    2.675898] arm-scmi firmware:scmi: SCMI protocol 17 not implemented
> 
> Any possibilities that for UHS patch we go with my current regulator driver
> implementation?

Sorry absolutely no. If this platform was not using SCMI, I wouldn't have
pushed back hard on this custom SMCCC. Please update TF-A to add this support.
There is no point in having custom interface just for this when everything
else is already using SCMI on this platform.

-- 
Regards,
Sudeep
