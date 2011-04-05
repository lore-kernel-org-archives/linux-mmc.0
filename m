From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: quirks: wl1271 is MMC_QUIRK_NONSTD_FUNC_IF
Date: Tue, 05 Apr 2011 11:26:10 -0400
Message-ID: <m339lw67ot.fsf@pullcord.laptop.org>
References: <1302015015-8178-1-git-send-email-ohad@wizery.com>
	<1302015015-8178-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53121 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab1DEPUn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2011 11:20:43 -0400
In-Reply-To: <1302015015-8178-2-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 5 Apr 2011 17:50:15 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 05 2011, Ohad Ben-Cohen wrote:
> Tell SDIO core to ignore the standard SDIO function interface
> codes indicated by the wl1271. This is required because the
> wl1271 erroneously indicates its first function as a standard
> Bluetooth SDIO interface, and that drives btsdio mad.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/core/quirks.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index 11118b7..1957398 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -64,6 +64,8 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
>  		add_quirk_for_sdio_devices, MMC_QUIRK_BROKEN_CLK_GATING },
>  	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
>  		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
> +	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
> +		add_quirk, MMC_QUIRK_NONSTD_FUNC_IF },
>  	{ 0 }
>  };

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
