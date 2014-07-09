From: Markus Niebel <list-09_linux-mmc@tqsc.de>
Subject: Re: [PATCH] mmc: implement driver stage register handling
Date: Wed, 9 Jul 2014 09:05:04 +0000 (UTC)
Message-ID: <loom.20140709T105052-24@post.gmane.org>
References: <1400852087-32442-1-git-send-email-s.hauer@pengutronix.de> <CAPDyKFotJr1UkKFs8vqaeh+=VqZvbxY6KmzDQ0HQKFkkr=07ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51597 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131AbaGIJkH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Jul 2014 05:40:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1X4oM8-0001M1-3w
	for linux-mmc@vger.kernel.org; Wed, 09 Jul 2014 11:40:04 +0200
Received: from 89.246.71.91 ([89.246.71.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2014 11:40:04 +0200
Received: from list-09_linux-mmc by 89.246.71.91 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2014 11:40:04 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson <at> linaro.org> writes:

> 
> On 23 May 2014 15:34, Sascha Hauer <s.hauer <at> pengutronix.de> wrote:
> > The eMMC and the SD-Card specifications describe the optional SET_DSR
command.
> > During measurements at our lab we found that some cards implementing
this feature
> > having really strong driver strengts per default. This can lead to
voltage peaks
> > above the specification of the host on signal edges for data sent from a
card to
> > the host.
> >
> > Since availability of a given card type may be shorter than the time a
certain
> > hardware will be produced it is useful to have support for this command
(Alternative
> > would be changing termination resistors and adapting the driver strength
of the
> > host to the used card.)
> >
> > As the value of the dsr register is board specific this adds a 'dsr'
devicetree
> > property which is handled in mmc_of_parse.
> >
> > Signed-off-by: Sascha Hauer <s.hauer <at> pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc.txt |  3 +++
> >  drivers/mmc/core/host.c                       |  3 +++
> >  drivers/mmc/core/mmc.c                        |  4 ++++
> >  drivers/mmc/core/mmc_ops.c                    | 17 +++++++++++++++++
> >  drivers/mmc/core/mmc_ops.h                    |  1 +
> >  include/linux/mmc/card.h                      |  3 ++-
> >  include/linux/mmc/host.h                      |  2 ++
> >  7 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
b/Documentation/devicetree/bindings/mmc/mmc.txt
> > index 9dce540..737203e 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> >  <at>  <at>  -38,6 +38,9  <at>  <at>  Optional properties:
> >  - mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
> >  - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
> >  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
> > +- dsr: Content of the optional driver stage register (DSR) as described
> > +  in JEDEC Standard No. 84-A44, 12.4: Programmable card output driver. Not
> > +  all MMC cards implement this register and the actual value is card
specific.
> 
> I get the impression of that this is (e)MMC specific, but this is
> relevant for SD cards as well, right!?
> 

Yes, the feature is optional for SD memory cards but not supported by SDIO.
(accordding to SDIO Simplified Specification Version 2.00)
On the other hand, I've not seen an SD card that implements this feature.

Just a second thought about the SD card side: as I read and understand the
specs the mapping between register values and physical driver stage value is
left over to the manufacturer. So the setting makes only sense for fix
mounted cards like eMMC - correct me if I'm wrong.

Markus

> I don't find the part's that should be implemented for sd/sdio, could
> we add that in this patch as well?
> 


