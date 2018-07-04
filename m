From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [v2] libertas: fix suspend and resume for SDIO connected cards
Date: Wed,  4 Jul 2018 15:13:49 +0000 (UTC)
Message-ID: <20180704151349.52E3C6028D@smtp.codeaurora.org>
References: <20180627185845.31799-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180627185845.31799-1-daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:

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
> Fixes: 573185cc7e64 ("mmc: core: Invoke sdio func driver's PM callbacks from the sdio bus")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
> Reviewed-by: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
> Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

7444a8092906 libertas: fix suspend and resume for SDIO connected cards

-- 
https://patchwork.kernel.org/patch/10492407/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
