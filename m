From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BACKPORT 4.4.y 01/25] mmc: pwrseq: constify mmc_pwrseq_ops
 structures
Date: Tue, 26 Mar 2019 10:08:31 +0900
Message-ID: <20190326010831.GA29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Tobin C. Harding" <me@tobin.cc>, Geert Uytterhoeven <geert+renesas@glider.be>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 22, 2019 at 04:43:52PM +0100, Arnd Bergmann wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The mmc_pwrseq_ops structures are never modified, so declare them as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit ffedbd2210f2f4cba490a9205adc11fd1b89a852)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/core/pwrseq.h        | 2 +-
>  drivers/mmc/core/pwrseq_emmc.c   | 2 +-
>  drivers/mmc/core/pwrseq_simple.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
> index 096da48c6a7e..133de0426687 100644
> --- a/drivers/mmc/core/pwrseq.h
> +++ b/drivers/mmc/core/pwrseq.h
> @@ -16,7 +16,7 @@ struct mmc_pwrseq_ops {
>  };
>  
>  struct mmc_pwrseq {
> -	struct mmc_pwrseq_ops *ops;
> +	const struct mmc_pwrseq_ops *ops;
>  };
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index ad4f94ec7e8d..4a82bc77fe49 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -51,7 +51,7 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
>  	kfree(pwrseq);
>  }
>  
> -static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
> +static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
>  	.post_power_on = mmc_pwrseq_emmc_reset,
>  	.free = mmc_pwrseq_emmc_free,
>  };
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index d10538bb5e07..2b16263458af 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -87,7 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>  	kfree(pwrseq);
>  }
>  
> -static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
> +static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>  	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
>  	.post_power_on = mmc_pwrseq_simple_post_power_on,
>  	.power_off = mmc_pwrseq_simple_power_off,

Why is this needed for a stable patch?  It doesn't fix a bug, it just
looks like it is a "nice thing" to have, right?  I don't think any later
patch in this series relies it it, or am I missing something?

thanks,

greg k-h
