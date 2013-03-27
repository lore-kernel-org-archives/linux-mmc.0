From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Wed, 27 Mar 2013 09:31:45 -0400
Message-ID: <87d2ulezpa.fsf@octavius.laptop.org>
References: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58858 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab3C0Nb6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Mar 2013 09:31:58 -0400
In-Reply-To: <1362142035-8403-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Fri, 1 Mar 2013 13:47:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Kevin Liu <kliu5@marvell.com>, Seungwon Jeon <tgih.jun@samsung.com>, jh80.chung@samsung.com

Hi Maya, Kevin, Seungwon, Jaehoon,

On Fri, Mar 01 2013, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> SDIO has been using runtime pm for a while to handle runtime power save
> operations. This patchset is enabling the option to make the sd/mmc
> blockdevices to use runtime pm as well.
>
> The runtime pm implementation for the block device will make use of
> autosuspend to defer power save operation to after request inactivty for
> a certain time.
>
> To actually perform some power save operations the corresponding bus ops
> for mmc and sd shall be implemented. Typically it could make sense to do
> BKOPS for eMMC in here.
>
> Ulf Hansson (3):
>   mmc: core: Remove power_restore bus_ops for mmc and sd
>   mmc: core: Add bus_ops for runtime pm callbacks
>   mmc: block: Enable runtime pm for mmc blkdevice
>
>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>  drivers/mmc/core/bus.c   |   14 ++++++++++++--
>  drivers/mmc/core/core.h  |    2 ++
>  drivers/mmc/core/mmc.c   |   14 --------------
>  drivers/mmc/core/sd.c    |   14 --------------
>  drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
>  6 files changed, 60 insertions(+), 32 deletions(-)

This looks good to me, but I'd like to make sure the design works for
you before we decide to merge it.  Any concerns?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
