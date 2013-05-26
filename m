From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 01/22] mmc: android-goldfish: remove unnecessary platform_set_drvdata()
Date: Sun, 26 May 2013 14:05:52 -0400
Message-ID: <87y5b1k45b.fsf@octavius.laptop.org>
References: <004b01ce4a1f$b0dbcec0$12936c40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51271 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab3EZSF5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 14:05:57 -0400
In-Reply-To: <004b01ce4a1f$b0dbcec0$12936c40$@samsung.com> (Jingoo Han's
	message of "Mon, 06 May 2013 15:05:21 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi Jingoo,

On Mon, May 06 2013, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/android-goldfish.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index 7780c14..8b4e20a 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -546,8 +546,6 @@ static int goldfish_mmc_remove(struct platform_device *pdev)
>  {
>  	struct goldfish_mmc_host *host = platform_get_drvdata(pdev);
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	BUG_ON(host == NULL);
>  
>  	mmc_remove_host(host->mmc);

Thanks.  I squashed everything down into one patch, collated the ACKs
and added them, and pushed it to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
