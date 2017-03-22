From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Wed, 22 Mar 2017 11:00:08 +0100
Message-ID: <20170322100008.GA2869@hardcore>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-5-jglauber@cavium.com>
 <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
 <6dc8a2a3-ca79-745a-c716-2188319b9378@caviumnetworks.com>
 <CAK8P3a2BX3-hbgGzYD_Oub1MR1pC9kLq73L+9gR5_gvYQyqqXA@mail.gmail.com>
 <67481a9f-f7b5-4ec0-22cc-f6e019dc131e@caviumnetworks.com>
 <CAK8P3a3PBx14CpGY5g7U9YHk3zkvVV=7gJHuSh50eOVKcfVAqA@mail.gmail.com>
 <79a1e294-797d-8b1f-0dcd-129df268c089@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:12736
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758632AbdCVKAZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Mar 2017 06:00:25 -0400
Content-Disposition: inline
In-Reply-To: <79a1e294-797d-8b1f-0dcd-129df268c089@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On Tue, Mar 21, 2017 at 01:22:05PM -0700, David Daney wrote:
> On 03/21/2017 12:49 PM, Arnd Bergmann wrote:
> >On Tue, Mar 21, 2017 at 4:19 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> >>On 03/21/2017 01:58 AM, Arnd Bergmann wrote:
> >>>
> >>>On Mon, Mar 20, 2017 at 9:45 PM, David Daney <ddaney@caviumnetworks.com>
> >>>wrote:
> >>>>
> >>>>On 03/17/2017 07:13 AM, Ulf Hansson wrote:
> >>>>>
> >>>>>My point is really that we should avoid exporting SoC specific APIs
> >>>>>which shall be called from drivers. This is old fashion.
> >>>>
> >>>>
> >>>>
> >>>>Some people find it objectionable to see 1-off architecture specific
> >>>>in-line
> >>>>asm in a driver file, but I agree that putting it as close to the user as
> >>>>possible makes sense.
> >>>
> >>>
> >>>The proper solution might be to create an architecture independent
> >>>interface
> >>>for it, what it is that the function does. Can you explain what the
> >>>purpose
> >>>of locking/unlocking the cache line for MMC is? Is this something that
> >>>could be done more generally in the dma_map_ops implementation?
> >>
> >>
> >>It is a 1-off erratum workaround that is only needed on fewer than five
> >>models/revisions of a mips64 based SoC family.  As such, creating a general
> >>purpose, architecture independent, framework is clearly not the proper
> >>approach.
> >
> >If this is just for maintaining coherency of the DMA operation inbetween,
> >then there is already a generic API for that, which the driver calls.
> >Adding the workaround into octeon_dma_map_sg() would be a way
> >to abstract the platform erratum from the driver.
> >
> 
> Either I am bad at explaining things, or you are not reading what I wrote.
> 
> These are two facts about the bug:
> 
> 1) The bug has nothing to do with coherency management, so hacking
> something into dma_map* is the wrong thing to do.
> 
> 2) The bug effects exactly one device, so hacking something into
> common code that is used by other devices is the wrong thing to do.
> 
> Suggesting that we use an alternate set of facts, although an
> interesting exercise, doesn't get us closer to answering the
> question of which source code file should contain the code.
> 
> This is one opinion about the bug:
> 
> 1) The bug is in the device, not the "platform", so putting the
> workaround code in the driver for the device may be the cleanest
> approach.

I've moved the code into the octeon driver
(drivers/mmc/host/cavium-octeon.c) and think this is the cleanest
way to do it.

--Jan

> David Daney
