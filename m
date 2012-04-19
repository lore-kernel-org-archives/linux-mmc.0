From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Thu, 19 Apr 2012 11:07:42 -0700
Message-ID: <20120419180741.GX21106@atomide.com>
References: <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418194224.GS25053@n2100.arm.linux.org.uk>
 <20120418200214.GP21106@atomide.com>
 <20120418202447.GT25053@n2100.arm.linux.org.uk>
 <20120418210142.GR21106@atomide.com>
 <20120418211606.GU25053@n2100.arm.linux.org.uk>
 <20120418213642.GV25053@n2100.arm.linux.org.uk>
 <20120419013914.GV21106@atomide.com>
 <20120419174332.GY25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22480 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab2DSSHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 14:07:46 -0400
Content-Disposition: inline
In-Reply-To: <20120419174332.GY25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120419 10:46]:
> On Wed, Apr 18, 2012 at 06:39:14PM -0700, Tony Lindgren wrote:
> > Cool, you almost got it. Got it working for n800 and 770 with the following
> > patch. Only extremely light testing done now so careful with this patch too..
> > 
> > Had to hack in support for the src_port and dst_port that's needed for
> > omap_set_dma_src/dest_params on omap1.
> 
> What's the relationship between these ports and the DMA request signal?
> Is there a document which describes this?

It's the source and destination addresses bus port, so it's more related
to the addresses than request signal. I guess routing of the DMA request
signal is what it really does.

I'm now wondering if it might be possible to set it automatically based on
source and destination address.

There's some information in the omap5912 trm on pages 717 and 718:

http://www.ti.com/litv/pdf/spru742

It says for CSDP source port "This field identifies the port originator of
the transfer."

Regards,

Tony
