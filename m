From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/7] mmc: consolidate sdhci_pltfm_data and sdhci_of_data
 into one
Date: Thu, 17 Mar 2011 14:29:30 -0600
Message-ID: <20110317202930.GG12824@angua.secretlab.ca>
References: <1300112759-3495-1-git-send-email-shawn.guo@linaro.org>
 <1300112759-3495-5-git-send-email-shawn.guo@linaro.org>
 <20110315195513.GA20845@angua.secretlab.ca>
 <20110317063319.GH11658@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43422 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab1CQU3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 16:29:34 -0400
Received: by iwn34 with SMTP id 34so3207189iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Mar 2011 13:29:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110317063319.GH11658@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, nicolas.pitre@linaro.org, devicetree-discuss@lists.ozlabs.org, linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org

[cc'ing linux-mmc@vger.kernel.org]

On Thu, Mar 17, 2011 at 02:33:20PM +0800, Shawn Guo wrote:
> On Tue, Mar 15, 2011 at 01:55:13PM -0600, Grant Likely wrote:
> > On Mon, Mar 14, 2011 at 10:25:56PM +0800, Shawn Guo wrote:
> > > This patch is motivated by the work of supporting sdhci-esdhc-imx as
> > > an OF device.  The sdhci-esdhc-imx driver was well designed to be
> > > able to work with either platform or OF bus, with a little effort to
> > > decouple the driver from sdhci_pltfm_data.
> > > 
> > > Like sdhci_ops works for both platform and OF sdhci driver, the patch
> > > demonstrates that sdhci_pltfm_data and sdhci_of_data can be
> > > consolidated into sdhci_data, which should work for both.  As one of
> > > the results, header linux/mmc/sdhci-pltfm.h can be deleted.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > I like the push to unify DT and non-DT usage with the SDHCI drivers,
> > but I'm not convinced on the approach.  Actually, that's more a
> > comment on the existing code than it is on the this patch.
> > 
> Yes, this patch is not supposed to mean that much.  It only intends
> to unify one data structure so that sdhci-esdhc-imx.c can work for
> both cases.
> 
> The topic you raised here is a bigger one which may involve debate
> with authors of both sdhci-pltfm.c and sdhci-of-core.c.  We can take
> it as the final goal, and this patch could be a first step to that
> goal.

I doubt very much that the sdhci-of-core.c users/developers will have
a problem with this.  There is a strong trend toward unifying DT and
non-DT code, and Linux has a strong pattern of each driver handling
its own registration.

I actually don't have an objection to this patch specifically, but
rather I want to see the overall direction be to eliminate
sdhci-of-core.c and sdhci-pltfm.c entirely instead of using it more..

On another note, this patch changes a number of names, both of 
structures and variables.  Specifically:

{sdhci_pltfm_data,sdhci_of_data} ==> sdhci_data and
pdata ==> data

However, it would be easier to review if the pdata==>data change was
dropped (the name of the local variable doesn't matter that much), and
if sdhci_of_data was renamed to sdhci_pltfm_data.  Doing so would make
the diff much smaller without changing the sanity of the resulting
code.

g.

> 
> -- 
> Regards,
> Shawn
> 
> > I don't like the way that sdhci-pltfm.c and sdhci-of-core.c each take
> > responsibility for the .probe hook on each of the implementations.
> > Doing it that way means that each implementation needs to add a set of
> > hooks into those core files protected by #ifdefs based on whether or
> > not the driver is enabled.  It also means that loading one driver
> > means that all the configured sdhci drivers get loaded into the
> > kernel.  This seems backwards.
> > 
> > From what I can see, sdhci-pltfm.c and sdhci-of-core.c both provide
> > useful common functions that would be used by all sdhci host drivers.
> > The interface would be a lot cleaner if those routines were exported
> > for use by other modules, and each driver registered its own probe
> > hook.  It would keep all the driver specific stuff out of
> > sdhci_pltfm_ids and I think it would result in a cleaner interface
> > overall.
> > 
> > Here is how I would do it:
> > 
> > 1) break the bulk of the sdhci_pltfm.c and sdhci_of_core.c .probe and
> > .remove hooks out into separate functions; callable by other modules
> > 2) for each driver, add its own probe and remove hooks which calls
> > into the new functions created in step 1.  This would eliminate the
> > need for the ->exit and ->init callbacks since they would get rolled
> > into the new .probe and .remove callbacks
> > 3) finally, when all drivers are removed; eliminate the driver
> > registration from sdhci_pltfm.c and sdhci_of_core.c because there
> > wouldn't be any users left.
> > 
> > drivers/mmc/host/sdhci-pxa.c appears to be a good example of how I
> > think sdhci platform_drivers should be structured.
> > 
> > At the same time, the functionality from sdhci_of_core.c could easily
> > be migrated into sdhci_pltfm.c.
> > 
> 
