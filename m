From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH V2 3/3] MAINTAINERS: mmc: Cleanup MMC/SD/SDIO section and SDHCI driver section
Date: Sun, 15 Mar 2015 21:15:13 +0000
Message-ID: <86k2yiq7xa.fsf@void.printf.net>
References: <1426258115-11801-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426258115-11801-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Fri, 13 Mar 2015 15:48:35 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 13 2015, Ulf Hansson wrote:
> As Chris Ball has moved on to other assignments, he's no longer able to
> help me maintain MMC. Let's remove him from the MMC sections in
> MAINTAINERS and add him to CREDIT file.
>
> This also affects the SDHCI DRIVER section, since its state now becomes
> orphan.
>
> Cc: Chris Ball <chris@printf.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 6 +-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index 96935df..843e176 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -187,6 +187,10 @@ N: Krishna Balasubramanian
>  E: balasub@cis.ohio-state.edu
>  D: Wrote SYS V IPC (part of standard kernel since 0.99.10)
>  
> +N: Chris Ball
> +E: chris@printf.net
> +D: Former maintainer of the MMC/SD/SDIO subsystem.
> +
>  N: Dario Ballabio
>  E: ballabio_dario@emc.com
>  E: dario.ballabio@tiscalinet.it
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 582b4b4..50479c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6547,10 +6547,8 @@ F:	drivers/mfd/
>  F:	include/linux/mfd/
>  
>  MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
> -M:	Chris Ball <chris@printf.net>
>  M:	Ulf Hansson <ulf.hansson@linaro.org>
>  L:	linux-mmc@vger.kernel.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>  T:	git git://git.linaro.org/people/ulf.hansson/mmc.git
>  S:	Maintained
>  F:	drivers/mmc/
> @@ -8650,10 +8648,8 @@ S:	Maintained
>  F:	drivers/mmc/host/sdricoh_cs.c
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
> -M:	Chris Ball <chris@printf.net>
>  L:	linux-mmc@vger.kernel.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/mmc/host/sdhci.*
>  F:	drivers/mmc/host/sdhci-pltfm.[ch]

Thanks Ulf:

Acked-by: Chris Ball <chris@printf.net>

I wonder what we should do about mmc-utils.  I could continue applying
patches since they're infrequent.  But perhaps few people would know
to send them to me -- any ideas?

- Chris.
-- 
Chris Ball   <http://printf.net/>
