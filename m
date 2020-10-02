Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EEDC4363D
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAC920708
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 14:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgJBOv0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:51:26 -0400
Received: from foss.arm.com ([217.140.110.172]:38184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJBOv0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Oct 2020 10:51:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0071FB;
        Fri,  2 Oct 2020 07:51:25 -0700 (PDT)
Received: from bogus (unknown [10.57.48.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BDAF3F73B;
        Fri,  2 Oct 2020 07:51:22 -0700 (PDT)
Date:   Fri, 2 Oct 2020 15:51:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     muhammad.husaini.zulkifli@intel.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, arnd@arndb.de,
        Sudeep Holla <sudeep.holla@arm.com>,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201002145115.GA6520@bogus>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michal,

On Fri, Oct 02, 2020 at 03:53:33PM +0200, Michal Simek wrote:
> Hi Sudeep,
>
> On 02. 10. 20 12:58, Sudeep Holla wrote:
> > Hi Michal,
> >
> > On Fri, Oct 02, 2020 at 10:23:02AM +0200, Michal Simek wrote:
> >> Hi Sudeep,
> >>
> >> On 01. 10. 20 17:35, Sudeep Holla wrote:
> >
> > [...]
> >
> >>>
> >>> What are the other uses of this KEEMBAY_SIP_* ?
> >>> For now I tend to move this to the driver making use of it using
> >>> arm_smccc_1_1_invoke directly if possible. I don't see the need for this
> >>> to be separate driver. But do let us know the features implemented in the
> >>> firmware. If it is not v1.1+, reasons for not upgrading as you need v1.1
> >>> for some CPU errata implementation.
> >>
> >> This driver has been created based on my request to move it out the mmc
> >> driver. It looks quite hacky to have arm_smccc_res and call
> >> arm_smccc_smc() also with some IDs where it is visible that the part of
> >> ID is just based on any spec.
> >
> > OK, driver is fine but no dt-bindings as it is discoverable. It can
> > also be just a wrapper library instead as it needs no explicit
> > initialisation like drivers to setup.
>
> I am fine with it. Do we have any example which we can point him to?
>

You seem to have figured that out already with SOC_ID example.
That was quick I must say 😄.

>
> >
> >> Also in v1 he is just calling SMC. But maybe there is going a need to
> >> call HVC instead which is something what device driver shouldn't decide
> >> that's why IMHO doing step via firmware driver is much better approach.
> >
> > Agreed and one must use arm_smccc_get_conduit or something similar. No
> > additional bindings for each and ever platform and driver that uses SMCCC
> > please.
> >
> >> Of course if there is a better/cleaner way how this should be done I am
> >> happy to get more information about it.
> >>
> >
> > Let me know what you think about my thoughts stated above.
>
>
> I am fine with it. The key point is to have these sort it out because I
> see that a lot of drivers just simply call that SMCs from drivers which
> is IMHO wrong.
>

Sure, sorry I didn't express my concern properly. I want to avoid dt bindings
for these and use the SMCCC discovery we have in place already if possible.

If this driver had consumers in the DT and it needs to be represented
in DT, it is a different story and I agree for need for a driver there.
But I don't see one in this usecase.

>
> BTW: I see you have added soc id reading which you are saying is the
> part of smcc v1.2 but I can't see any implementation in TF-A. Is this
> spec publicly available?
>

Spec is out[1], include/linux/arm-smccc.h points to the latest spec.
TF-A does have implementation as I tested with it and even reported
bug that I discovered when I tested with my patches that are now merged
upstream. Are you referring to master of TF-A or last release version ?
If latter, it had bug and may not be working. I may be wrong though, as
I am just telling what was told to me couple of months back and things
might have changed in TF-A land.

--
Regards,
Sudeep

[1] https://developer.arm.com/documentation/den0028/latest
