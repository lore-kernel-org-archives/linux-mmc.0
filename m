Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B9AC4363C
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D3220B1F
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 10:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJGKKs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 06:10:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgJGKKs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 06:10:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37806113E;
        Wed,  7 Oct 2020 03:10:47 -0700 (PDT)
Received: from bogus (unknown [10.57.54.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938913F71F;
        Wed,  7 Oct 2020 03:10:44 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:10:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     muhammad.husaini.zulkifli@intel.com, adrian.hunter@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com, arnd@arndb.de
Subject: Re: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201007101038.ec7ymdhiaf7rhyrm@bogus>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
 <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 07, 2020 at 10:20:21AM +0200, Michal Simek wrote:
> Hi,
> 
> 1. Keem Bay: in subject is wrong. Tools are working with it and you
> should just use keembay: instead.
> 
> 2. This should come first before actual change to keep the tree bisectable.
> 
> On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:
> > From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> > 
> > Add header file to handle API function for device driver to communicate
> > with Arm Trusted Firmware.
> > 
> > Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> > ---
> >  .../linux/firmware/intel/keembay_firmware.h   | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 include/linux/firmware/intel/keembay_firmware.h
> > 
> > diff --git a/include/linux/firmware/intel/keembay_firmware.h b/include/linux/firmware/intel/keembay_firmware.h
> > new file mode 100644
> > index 000000000000..9adb8c87b788
> > --- /dev/null
> > +++ b/include/linux/firmware/intel/keembay_firmware.h
> > @@ -0,0 +1,46 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + *  Intel Keembay SOC Firmware API Layer
> > + *
> > + *  Copyright (C) 2020-2021, Intel Corporation
> > + *
> > + *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
> > + */
> > +
> > +#ifndef __FIRMWARE_KEEMBAY_SMC_H__
> > +#define __FIRMWARE_KEEMBAY_SMC_H__
> > +
> > +#include <linux/arm-smccc.h>
> > +
> > +/**
> 
> This is not a kernel doc comment. Just use /*
> 
> > + * This file defines API function that can be called by device driver in order to
> > + * communicate with Arm Trusted Firmware.
> > + */
> > +
> > +/* Setting for Keem Bay IO Pad Line Voltage Selection */
> > +#define KEEMBAY_SET_SD_VOLTAGE_FUNC_ID	0x8200ff26
> 
> Sudeep: Don't we have any macros for composing these IDs?
> nit: IMHO composing these IDs from macros would make more sense to me.
> 

Yes we do. Refer include/linux/arm-smccc.h
I expect something like below, which also indicated you are using wrong
OWNER space. You can't be 0 which is reserved for CPU ARCH. You need to
be SIP(0x2)

#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE          \
        ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,       \
                           ARM_SMCCC_SMC_32,          \
                           ARM_SMCCC_OWNER_SIP,       \
                           0xFF26)


-- 
Regards,
Sudeep
