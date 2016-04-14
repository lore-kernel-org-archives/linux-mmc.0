From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/3] mmc: pwrseq: convert to proper platform device
Date: Thu, 14 Apr 2016 11:33:11 +0200
Message-ID: <CAPDyKFr4rR3g_+TO2PzggVWAC0tKKYNNrAD+d+ywatX9vKpKzA@mail.gmail.com>
References: <1460570081-1679-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1460570081-1679-4-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36430 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbcDNJdS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 05:33:18 -0400
Received: by mail-wm0-f50.google.com with SMTP id v188so211546253wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2016 02:33:17 -0700 (PDT)
In-Reply-To: <1460570081-1679-4-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>

On 13 April 2016 at 19:54, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> simple-pwrseq and emmc-pwrseq drivers rely on platform_device
> structure from of_find_device_by_node(), this works mostly. But, as there
> is no driver associated with this devices, cases like default/init pinctrl
> setup would never be performed by pwrseq. This becomes problem when the
> gpios used in pwrseq require pinctrl setup.
>
> Currently most of the common pinctrl setup is done in
> drivers/base/pinctrl.c by pinctrl_bind_pins().
>
> There are two ways to solve this issue on either convert pwrseq drivers
> to a proper platform drivers or copy the exact code from
> pcintrl_bind_pins(). I prefer converting pwrseq to proper drivers so that
> other cases like setting up clks/parents from dt would also be possible.
>

[...]

>
>  int mmc_pwrseq_alloc(struct mmc_host *host)
>  {
> -       struct platform_device *pdev;
>         struct device_node *np;
> -       struct mmc_pwrseq_match *match;
> -       struct mmc_pwrseq *pwrseq;
> -       int ret = 0;
> +       struct mmc_pwrseq *p, *pwrseq = NULL;
>
>         np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
>         if (!np)
>                 return 0;
>
> -       pdev = of_find_device_by_node(np);
> -       if (!pdev) {
> -               ret = -ENODEV;
> -               goto err;
> +       mutex_lock(&pwrseq_list_mutex);
> +       list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
> +               if (p->dev->of_node == np) {
> +                       pwrseq = p;
> +                       try_module_get(pwrseq->owner);

This can fail, so please add error handling.

> +                       host->pwrseq = pwrseq;
> +                       break;
> +               }
>         }
>
> -       match = mmc_pwrseq_find(np);
> -       if (IS_ERR(match)) {
> -               ret = PTR_ERR(match);
> -               goto err;
> -       }
> +       of_node_put(np);
> +       mutex_unlock(&pwrseq_list_mutex);
>
> -       pwrseq = match->alloc(host, &pdev->dev);
> -       if (IS_ERR(pwrseq)) {
> -               ret = PTR_ERR(pwrseq);
> -               goto err;
> -       }
> +       if (!pwrseq)
> +               return -EPROBE_DEFER;
>
> -       host->pwrseq = pwrseq;
>         dev_info(host->parent, "allocated mmc-pwrseq\n");
>
> -err:
> -       of_node_put(np);
> -       return ret;
> +       return 0;
>  }
>

Besides the minor thing above, this looks good to me!

Kind regards
Uffe
