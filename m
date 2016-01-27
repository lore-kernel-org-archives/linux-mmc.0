From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: Support assigned-clocks
Date: Wed, 27 Jan 2016 15:15:42 +0100
Message-ID: <CAPDyKFrdraY1hXfikELMr5V7hJRcQP7nOUaOjzKiGUGDSecp6A@mail.gmail.com>
References: <20160108095917.32335.11094.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36322 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581AbcA0OPn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:15:43 -0500
Received: by mail-yk0-f173.google.com with SMTP id v14so241610707ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:15:42 -0800 (PST)
In-Reply-To: <20160108095917.32335.11094.stgit@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

+ Srini

On 8 January 2016 at 10:59, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> The clock subsystem now allows clock rates and parents to be configured
> in the device tree.
>
> This requires calling of_clk_set_defaults() which is done automatically
> for platform, i2c, spi devices. Since pwrseq_simple does not fit into
> those catagories we must do it ourself.
>
> With this patch the standard assigned-clocks, assigned-clock-rates,
> assigned-clock-parents DT properties to be used in pwrseq_simple nodes.

I believe this should be solved when we have converted the each pwrseq
method to become a platform driver. This is being worked on by
Srinivas Kandagatla.
http://www.spinics.net/lists/arm-kernel/msg475605.html

Kind regards
Ulf Hansson

>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/mmc/core/pwrseq_simple.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 4d2962b..fd8f38e 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -8,6 +8,7 @@
>   *  Simple MMC power sequence management
>   */
>  #include <linux/clk.h>
> +#include <linux/clk/clk-conf.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
> @@ -108,6 +109,10 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>         if (!pwrseq)
>                 return ERR_PTR(-ENOMEM);
>
> +       ret = of_clk_set_defaults(dev->of_node, false);
> +       if (ret)
> +               goto free;
> +
>         pwrseq->ext_clk = clk_get(dev, "ext_clock");
>         if (IS_ERR(pwrseq->ext_clk) &&
>             PTR_ERR(pwrseq->ext_clk) != -ENOENT) {
>
