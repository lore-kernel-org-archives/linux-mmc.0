From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: fixes for 3.10
Date: Sun, 26 May 2013 14:23:53 -0400
Message-ID: <87mwrhk3ba.fsf@octavius.laptop.org>
References: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1368187955-13069-1-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Fri, 10 May 2013 17:42:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, May 10 2013, Balaji T K wrote:
> Fix to make wlan/sdio work with dt and to use dma binding from dt
>
> Matt Porter (1):
>   mmc: omap_hsmmc: convert to dma_request_slave_channel_compat
>
> Santosh Shilimkar (1):
>   mmc: omap_hsmmc: Skip platform_get_resource_byname() for dt case
>
> Tony Lindgren (1):
>   mmc: omap_hsmmc: Fix the DT pbias workaround for MMC controllers 2 to
>     5
>
>  drivers/mmc/host/omap_hsmmc.c |   51 +++++++++++++++++++++++++---------------
>  1 files changed, 32 insertions(+), 19 deletions(-)

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
