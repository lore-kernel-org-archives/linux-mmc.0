From: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2] libertas: fix suspend and resume for SDIO connected
        cards
Date: Thu, 28 Jun 2018 00:13:42 +0100
Message-ID: <20180627231342.GA32539@void.printf.net>
References: <20180627185845.31799-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180627185845.31799-1-daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 27, 2018 at 08:58:45PM +0200, Daniel Mack wrote:
> Prior to commit 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM
> callbacks from the sdio bus"), the MMC core used to call into the power
> management functions of SDIO clients itself and removed the card if the
> return code was non-zero. IOW, the mmc handled errors gracefully and didn't
> upchain them to the pm core.
> 
> Since this change, the mmc core relies on generic power management
> functions which treat all errors as a reason to cancel the suspend
> immediately. This causes suspend attempts to fail when the libertas
> driver is loaded.
> 
> To fix this, power down the card explicitly in if_sdio_suspend() when we
> know we're about to lose power and return success. Also set a flag in these
> cases, and power up the card again in if_sdio_resume().
> 
> Signed-off-by: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>

Thanks, looks good.

Reviewed-by: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>

-- 
Chris Ball   <http://printf.net/>
