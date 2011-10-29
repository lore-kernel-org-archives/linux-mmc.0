From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] omap_hsmmc: fix missing parenthesis in pr_info
Date: Sat, 29 Oct 2011 16:04:16 -0400
Message-ID: <m239ebef9b.fsf@bob.laptop.org>
References: <1319917151-5626-1-git-send-email-J.Kilb@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40298 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab1J2UEY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 29 Oct 2011 16:04:24 -0400
In-Reply-To: <1319917151-5626-1-git-send-email-J.Kilb@phytec.de> (Juergen
	Kilb's message of "Sat, 29 Oct 2011 21:39:11 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Juergen Kilb <J.Kilb@phytec.de>
Cc: linux-mmc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, linux-omap@vger.kernel.org

Hi,

On Sat, Oct 29 2011, Juergen Kilb wrote:
> In commit a3c76eb9 (mmc: replace printk with appropriate
> display macro) the opening parenthesis of pr_info was missing.
>
> Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e8ff123..101cd31 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
>  		}
>  	} else {
>  		if (!host->protect_card) {
> -			pr_info"%s: cover is open, "
> +			pr_info("%s: cover is open, "
>  					 "card is now inaccessible\n",
>  					 mmc_hostname(host->mmc));
>  			host->protect_card = 1;

Oops.  Thank you; I've pushed this to mmc-next now, and will send the
fix to Linus.  I've checked for other errors in the original patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
