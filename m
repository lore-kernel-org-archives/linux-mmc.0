Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428BC4741F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 10:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3AA20708
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBK6p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 06:58:45 -0400
Received: from foss.arm.com ([217.140.110.172]:60494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBK6p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Oct 2020 06:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687C731B;
        Fri,  2 Oct 2020 03:58:44 -0700 (PDT)
Received: from bogus (unknown [10.57.48.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03A13F73B;
        Fri,  2 Oct 2020 03:58:42 -0700 (PDT)
Date:   Fri, 2 Oct 2020 11:58:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     muhammad.husaini.zulkifli@intel.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, arnd@arndb.de,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201002105840.GE906@bogus>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michal,

On Fri, Oct 02, 2020 at 10:23:02AM +0200, Michal Simek wrote:
> Hi Sudeep,
> 
> On 01. 10. 20 17:35, Sudeep Holla wrote:

[...]

> > 
> > What are the other uses of this KEEMBAY_SIP_* ?
> > For now I tend to move this to the driver making use of it using
> > arm_smccc_1_1_invoke directly if possible. I don't see the need for this
> > to be separate driver. But do let us know the features implemented in the
> > firmware. If it is not v1.1+, reasons for not upgrading as you need v1.1
> > for some CPU errata implementation.
> 
> This driver has been created based on my request to move it out the mmc
> driver. It looks quite hacky to have arm_smccc_res and call
> arm_smccc_smc() also with some IDs where it is visible that the part of
> ID is just based on any spec.

OK, driver is fine but no dt-bindings as it is discoverable. It can
also be just a wrapper library instead as it needs no explicit
initialisation like drivers to setup.

> Also in v1 he is just calling SMC. But maybe there is going a need to
> call HVC instead which is something what device driver shouldn't decide
> that's why IMHO doing step via firmware driver is much better approach.

Agreed and one must use arm_smccc_get_conduit or something similar. No
additional bindings for each and ever platform and driver that uses SMCCC
please.

> Of course if there is a better/cleaner way how this should be done I am
> happy to get more information about it.
> 

Let me know what you think about my thoughts stated above.

-- 
Regards,
Sudeep
