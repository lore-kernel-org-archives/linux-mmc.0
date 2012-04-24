From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 3/8] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
Date: Tue, 24 Apr 2012 16:27:14 +0530
Message-ID: <4F96870A.5060303@nvidia.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk> <4F9681F1.2090408@nvidia.com> <20120424105045.GD25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10309 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab2DXK6a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 06:58:30 -0400
In-Reply-To: <20120424105045.GD25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Tuesday 24 April 2012 04:20 PM, Russell King - ARM Linux wrote:
>
>> For cyclic case, we will not like to call the  dma_cookie_complete() but
>> want to put the desc in callback list.
>> So can we have one more arg on this function which byspass the call of
>> dma_cookie_complete()
> See the discussion on what's supposed to happen with cyclic transfers.
> Cyclic transfers don't complete, so adding them to the completed list
> and marking them complete is the wrong thing to be doing.  So arguably
> calling this function is also the wrong thing to be doing because
> you're not completing the transfer.

OK, we will not call this function but still need to call the callback. 
So do you suggest to call callback directly from dma driver rather than 
the virt_chan?
> I'll be addressing the issue of cyclic transfers when I eventually get
> to sorting out the OMAP ASoC driver.

Here I am developing the dma driver for Tegra in cyclic and normal mode 
and what is your suggestion here?
Should I use your virt_chan now or I can go ahead with my first patch 
without virt_chan and once you are done with your virt_chan with all 
cyclic support then  port the tegra_dma to use virt chan and next 
enhanced patch?

In this way, my Tegra dma will be there in tree, all client will be move 
to dma engine based driver and then I will comeback to tegra_dma for 
using the virt_channel.






