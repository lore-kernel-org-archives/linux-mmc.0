From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc_rescan: reduce verbosity
Date: Tue, 12 Oct 2010 16:08:50 +0100
Message-ID: <20101012150850.GA18009@void.printf.net>
References: <20101012060045.GA8252@pengutronix.de> <1286868577-7729-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52653 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab0JLPIv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 11:08:51 -0400
Content-Disposition: inline
In-Reply-To: <1286868577-7729-1-git-send-email-eric@eukrea.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

Hi Eric,

On Tue, Oct 12, 2010 at 09:29:37AM +0200, Eric B=E9nard wrote:
> since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
> includes a pr_info which prints 4 lines each second for hosts configu=
red
> with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
> This patch enable the log only if CONFIG_MMC_DEBUG is selected.
>=20
> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
> ---
> v2 : enable log only if CONFIG_MMC_DEBUG is selected
> v1 : use pr_debug instead of pr_info
>  drivers/mmc/core/core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c94565d..cda9d29 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1482,9 +1482,10 @@ void mmc_rescan(struct work_struct *work)
>  			mmc_release_host(host);
>  			goto out;
>  		}
> +#ifdef CONFIG_MMC_DEBUG
>  		pr_info("%s: %s: trying to init card at %u Hz\n",
>  			mmc_hostname(host), __func__, host->f_init);
> -
> +#endif
>  		mmc_power_up(host);
>  		sdio_reset(host);
>  		mmc_go_idle(host);
> --=20

Thanks, applied to mmc-next.

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
