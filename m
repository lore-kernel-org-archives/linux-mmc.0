From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/3] dmaengine: add per channel capabilities api
Date: Sun, 20 Jan 2013 04:37:34 -0800
Message-ID: <20130120123734.GC23398@intel.com>
References: <1357844826-30746-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4321 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab3ATNC1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Jan 2013 08:02:27 -0500
Content-Disposition: inline
In-Reply-To: <1357844826-30746-1-git-send-email-mporter@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Dan Williams <djbw@fb.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

On Thu, Jan 10, 2013 at 02:07:03PM -0500, Matt Porter wrote:
> The call is implemented as follows:
> 
> 	struct dmaengine_chan_caps
> 	*dma_get_channel_caps(struct dma_chan *chan,
> 			      enum dma_transfer_direction dir);
> 
> The dma transfer direction parameter may appear a bit out of place
> but it is necessary since the direction field in struct
> dma_slave_config was deprecated. In some cases, EDMA for one, it
> is necessary for the dmaengine driver to have the burst and address
> width slave configuration parameters available in order to compute
> the maximum segment size that can be handle. Due to this requirement,
> the calling order of this api is as follows:
Well you are passing direction as argument so even in EDMA it doesn't seem to
help you as you seem to need burst and width!. So why do you even need the
direction to compute the capablities

--
~Vinod
