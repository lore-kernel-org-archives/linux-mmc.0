From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 06/11] mmc: usdhi6rol0: fix error return code
Date: Tue, 25 Aug 2015 17:26:57 +0200
Message-ID: <CAPDyKFq06+rb12D1N59dKbojm1N+1WwbXUFrvRvktzDFjSV_TQ@mail.gmail.com>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
	<1440288682-12732-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38542 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbHYP06 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 11:26:58 -0400
Received: by igfj19 with SMTP id j19so13878768igf.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 08:26:57 -0700 (PDT)
In-Reply-To: <1440288682-12732-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 23 August 2015 at 02:11, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> Propagate error code on failure.
>
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, applied for next!

Kind regards
Uffe


>
> ---
>  drivers/mmc/host/usdhi6rol0.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 54b082b..99f894c 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1734,8 +1734,10 @@ static int usdhi6_probe(struct platform_device *pdev)
>         }
>
>         host->clk = devm_clk_get(dev, NULL);
> -       if (IS_ERR(host->clk))
> +       if (IS_ERR(host->clk)) {
> +               ret = PTR_ERR(host->clk);
>                 goto e_free_mmc;
> +       }
>
>         host->imclk = clk_get_rate(host->clk);
>
>
