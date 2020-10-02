Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3C9C4363D
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 11:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C496D20719
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 11:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgJBLBE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:01:04 -0400
Received: from foss.arm.com ([217.140.110.172]:60560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgJBLBE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Oct 2020 07:01:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2386E1042;
        Fri,  2 Oct 2020 04:01:03 -0700 (PDT)
Received: from bogus (unknown [10.57.48.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05B83F73B;
        Fri,  2 Oct 2020 04:01:00 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:00:57 +0100
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
        Sudeep Holla <sudeep.holla@arm.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201002110057.GF906@bogus>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <BYAPR11MB301522E94B9516558A23F758B8310@BYAPR11MB3015.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB301522E94B9516558A23F758B8310@BYAPR11MB3015.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 02, 2020 at 10:22:46AM +0000, Zulkifli, Muhammad Husaini wrote:
> Hi Sudeep,
> 
> >-----Original Message-----
> >From: Michal Simek <michal.simek@xilinx.com>
> >Sent: Friday, October 2, 2020 4:23 PM
> >To: Sudeep Holla <sudeep.holla@arm.com>; Zulkifli, Muhammad Husaini
> ><muhammad.husaini.zulkifli@intel.com>
> >Cc: Hunter, Adrian <adrian.hunter@intel.com>; michal.simek@xilinx.com;
> >ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-arm-
> >kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Raja Subramanian,
> >Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; arnd@arndb.de; Wan
> >Mohamad, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> >Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
> >Firmware Service call
> >
> >Hi Sudeep,
> >
> >On 01. 10. 20 17:35, Sudeep Holla wrote:
> >> On Thu, Oct 01, 2020 at 10:21:48PM +0800,
> >muhammad.husaini.zulkifli@intel.com wrote:
> >>> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >>>
> >>> Add generic firmware driver for Keem Bay SOC to support Arm Trusted
> >>> Firmware Services call.
> >>>
> >>> Signed-off-by: Muhammad Husaini Zulkifli
> >>> <muhammad.husaini.zulkifli@intel.com>
> >>> ---
> >>>  drivers/firmware/Kconfig                   |   1 +
> >>>  drivers/firmware/Makefile                  |   1 +
> >>>  drivers/firmware/intel/Kconfig             |  14 +++
> >>>  drivers/firmware/intel/Makefile            |   4 +
> >>>  drivers/firmware/intel/keembay_smc.c       | 119 +++++++++++++++++++++
> >>>  include/linux/firmware/intel/keembay_smc.h |  27 +++++
> >>>  6 files changed, 166 insertions(+)
> >>>  create mode 100644 drivers/firmware/intel/Kconfig  create mode
> >>> 100644 drivers/firmware/intel/Makefile  create mode 100644
> >>> drivers/firmware/intel/keembay_smc.c
> >>>  create mode 100644 include/linux/firmware/intel/keembay_smc.h
> >>>
> >>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> >>> index fbd785dd0513..41de77d2720e 100644
> >>> --- a/drivers/firmware/Kconfig
> >>> +++ b/drivers/firmware/Kconfig
> >>> @@ -305,5 +305,6 @@ source "drivers/firmware/psci/Kconfig"
> >>>  source "drivers/firmware/smccc/Kconfig"
> >>>  source "drivers/firmware/tegra/Kconfig"
> >>>  source "drivers/firmware/xilinx/Kconfig"
> >>> +source "drivers/firmware/intel/Kconfig"
> >>>
> >>>  endmenu
> >>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> >>> index 99510be9f5ed..00f295ab9860 100644
> >>> --- a/drivers/firmware/Makefile
> >>> +++ b/drivers/firmware/Makefile
> >>> @@ -33,3 +33,4 @@ obj-y				+= psci/
> >>>  obj-y				+= smccc/
> >>>  obj-y				+= tegra/
> >>>  obj-y				+= xilinx/
> >>> +obj-y				+= intel/
> >>> diff --git a/drivers/firmware/intel/Kconfig
> >>> b/drivers/firmware/intel/Kconfig new file mode 100644 index
> >>> 000000000000..b2b7a4e5410b
> >>> --- /dev/null
> >>> +++ b/drivers/firmware/intel/Kconfig
> >>> @@ -0,0 +1,14 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only menu "Intel Firmware
> >>> +Drivers"
> >>> +
> >>> +config KEEMBAY_FIRMWARE
> >>> +	bool "Enable Keem Bay firmware interface support"
> >>> +	depends on HAVE_ARM_SMCCC
> >>
> >> What is the version of SMCCC implemented ?
> Our current Arm Trusted Firmware framework supports v1.1.
> Does it mean I should use HAVE_ARM_SMCCC_DISCOVERY?

Yes, HAVE_ARM_SMCCC_DISCOVERY is right dependency and allows you to
get smccc version via arm_smccc_get_version which may be useful in
future.

> Not really clear about this. As for HAVE_ARM_SMCCC will include 
> support for the SMC and HVC.
>

Yes, but for sake of correctness I prefer HAVE_ARM_SMCCC_DISCOVERY.

-- 
Regards,
Sudeep
