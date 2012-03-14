From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v1 5/5] ARM: mxs: add mxs dma dt support
Date: Wed, 14 Mar 2012 16:30:47 +0800
Message-ID: <20120314083046.GD1180@shlinux2.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-6-git-send-email-b29396@freescale.com>
 <4F604F9F.1070801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:5772
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159Ab2CNI24 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 04:28:56 -0400
Content-Disposition: inline
In-Reply-To: <4F604F9F.1070801@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Shijie-B32955 <B32955@freescale.com>
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, Guo Shawn-R65073 <r65073@freescale.com>

On Wed, Mar 14, 2012 at 03:58:23PM +0800, Huang Shijie-B32955 wrote:
> Hi,
> > +			dma-apbh@80004000 {
> > +				compatible = "fsl,mxs-dma-apbh";
> > +				reg =<0x80004000 2000>;
> > +			};
> > +
> Why you do not add the `interrupt` for the it?
> the gpmi-nand needs to parse the interrupt out.
> 
The non-dt way also does not have interrupt resource for dma device.
It seems the channel interrupt resource is handled in each client device.
I'm not familiar with gpmi-nand, but I guess you may need to handle
it in gpmi driver, just like mxs-mmc driver.

Regards
Dong Aisheng

