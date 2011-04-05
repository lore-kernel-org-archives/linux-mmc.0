From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: quirks: wl1271 is MMC_QUIRK_DISABLE_CD
Date: Tue, 05 Apr 2011 11:26:51 -0400
Message-ID: <m3tyec4t38.fsf@pullcord.laptop.org>
References: <1302015746-8414-1-git-send-email-ohad@wizery.com>
	<1302015746-8414-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53130 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab1DEPVY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Apr 2011 11:21:24 -0400
In-Reply-To: <1302015746-8414-2-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 5 Apr 2011 18:02:26 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 05 2011, Ohad Ben-Cohen wrote:
> The wl12xx device supports disconnecting the pull-up resistor on
> CD/DAT[3] (pin 1) of the card.
>
> Tell SDIO core to disconnect that resistor during card init,
> since we don't need it at that point (and anyway all
> hosts shall provide pull-up resistors on all data lines DAT[3:0]
> as described in section 6 of the SD physical specification).
>
> As a result, this may save some power, but it's also generally healthy
> since it prevents both ends from pulling up that pin, which
> results in undesirable asymmetric physical bus.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/core/quirks.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index 1957398..a4c42ed 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -66,6 +66,8 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
>  		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
>  	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
>  		add_quirk, MMC_QUIRK_NONSTD_FUNC_IF },
> +	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
> +		add_quirk, MMC_QUIRK_DISABLE_CD },
>  	{ 0 }
>  };

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
