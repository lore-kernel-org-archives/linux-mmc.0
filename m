Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E8C4363D
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 11:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F68A2078E
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 11:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFLNw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Oct 2020 07:13:52 -0400
Received: from foss.arm.com ([217.140.110.172]:44940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFLNw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Oct 2020 07:13:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA091435;
        Tue,  6 Oct 2020 04:13:52 -0700 (PDT)
Received: from bogus (unknown [10.57.54.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC94C3F66B;
        Tue,  6 Oct 2020 04:13:49 -0700 (PDT)
Date:   Tue, 6 Oct 2020 12:13:46 +0100
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
Message-ID: <20201006111346.fhowlesbi4hfaquf@bogus>
References: <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
 <20201002145115.GA6520@bogus>
 <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
 <20201005084441.znou7licvvtomva4@bogus>
 <BYAPR11MB3015F4E8FDF3CB1273A35EFAB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
 <20201005200744.robd42nkt6ahg52x@bogus>
 <BYAPR11MB301505B60397A083050E962EB80D0@BYAPR11MB3015.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB301505B60397A083050E962EB80D0@BYAPR11MB3015.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Oct 06, 2020 at 01:22:31AM +0000, Zulkifli, Muhammad Husaini wrote:
> HI Sudeep and Michal,
>
> Yeah I believe it can work. I will create one header file in include/linux/firmware/intel/Keembay_firmware.h
> To handle this func and arasan controller can call this func.
> Are you guys ok with this?
>

Sounds good to me. No change w.r.t arasan controller as it still needs
to call the same api(keembay_sd_voltage_selection), just w/o a firmware
driver for it.

--
Regards,
Sudeep
