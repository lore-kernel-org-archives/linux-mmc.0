From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Thu, 23 Dec 2010 00:09:47 +0000
Message-ID: <20101223000947.GA29312@void.printf.net>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com> <20101221202408.GA12006@void.printf.net> <AANLkTikdA5Pbiwx+VdhtgShhMGcLkJLV0B5O_Yi+_aCx@mail.gmail.com> <4D11B5D6.3030805@csr.com> <AANLkTikmLaTXAxdfUtfoEKuASeJ-F=zLQYJC36sj4oT+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60024 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471Ab0LWAJw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 19:09:52 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikmLaTXAxdfUtfoEKuASeJ-F=zLQYJC36sj4oT+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: David Vrabel <david.vrabel@csr.com>, linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

Hi Linus,

On Wed, Dec 22, 2010 at 09:50:12AM +0100, Linus Walleij wrote:
> Sure! Chris do you prefer this one instead?
> 
> From: Linus Walleij <linus.walleij@stericsson.com>
> Date: Wed, 22 Dec 2010 09:49:04 +0100
> Subject: [PATCH] mmc: check for > 1 clk_requests
> 
> Since we make sure the clock is enabled in the mmc_host_clk_exit()
> function we should expect a reference counter of 1, not 0.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/mmc/core/host.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 92e3370..b3ac6c5 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -235,7 +235,8 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
>  		mmc_host_clk_gate_delayed(host);
>  	if (host->clk_gated)
>  		mmc_host_clk_ungate(host);
> -	BUG_ON(host->clk_requests > 0);
> +	/* There should be only one user now */
> +	WARN_ON(host->clk_requests > 1);
>  }
> 
>  #else

Thanks, both of you, have merged this to mmc-next now.  We'll do some
rebasing to fold it in later.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
