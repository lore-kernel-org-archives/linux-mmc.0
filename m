From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 0/5] mmc: cavium: bug fixes for 4.12
Date: Fri, 19 May 2017 12:42:59 +0200
Message-ID: <20170519104259.GA7638@hc>
References: <20170516093655.17746-1-jglauber@cavium.com>
 <CAPDyKFpaWvvxz3g_tq0WG=_O3e+0MSBnMqmud0Me=0Adf4NUrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0069.outbound.protection.outlook.com ([104.47.36.69]:48640
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754196AbdESKnP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 May 2017 06:43:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFpaWvvxz3g_tq0WG=_O3e+0MSBnMqmud0Me=0Adf4NUrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, May 19, 2017 at 10:30:22AM +0200, Ulf Hansson wrote:
> On 16 May 2017 at 11:36, Jan Glauber <jglauber@cavium.com> wrote:
> > Hi Ulf,
> >
> > here are some bug fixes for the new mmc driver. The only
> > non-trivial fix should be the platform thing in patch #4 and #5.
> >
> > Tested on OcteonTx and on various MIPS boxes.
> >
> > thanks,
> > Jan
> >
> > David Daney (2):
> >   mmc: cavium-octeon: Fix interrupt enable code
> >   mmc: cavium-octeon: Use proper GPIO name for power control
> >
> > Jan Glauber (3):
> >   mmc: cavium: Prevent crash with incomplete DT
> >   of/platform: Make of_platform_device_destroy globally visible
> >   mmc: cavium: Fix probing race with regulator
> >
> >  drivers/mmc/host/cavium-octeon.c   | 4 ++--
> >  drivers/mmc/host/cavium-thunderx.c | 4 +++-
> >  drivers/mmc/host/cavium.c          | 8 ++++++--
> >  drivers/of/platform.c              | 3 ++-
> >  include/linux/of_platform.h        | 1 +
> >  5 files changed, 14 insertions(+), 6 deletions(-)
> >
> > --
> > 2.9.0.rc0.21.g7777322
> >
> 
> I picked up patch1 and patch2 for fixes. The rest needs a re-spin.

I'll re-spin the other patches.

thanks,
Jan


> Thanks and kind regards
> Uffe
