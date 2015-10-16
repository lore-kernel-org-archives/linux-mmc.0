From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: skip reclaiming host on mmc_add_card() error
Date: Fri, 16 Oct 2015 15:07:09 +0200
Message-ID: <CAPDyKFpJXC2M5e_L68UXWkjEiTkyMDBNDb6CY-LuFc9043LLTA@mail.gmail.com>
References: <4835546.qgzOJFlmY8@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37294 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbbJPNHL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 09:07:11 -0400
Received: by wijq8 with SMTP id q8so9968147wij.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 06:07:10 -0700 (PDT)
In-Reply-To: <4835546.qgzOJFlmY8@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 14 October 2015 at 22:53, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> There's little sense in releasing the host on mmc_add_card() error
> immediately after reclaiming  it, so  reclaim the host  only in case
> of success.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied patch 1 and patch 2 (squashed them) for next.

Kind regards
Uffe

>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.
>
>  drivers/mmc/core/mmc.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: mmc/drivers/mmc/core/mmc.c
> ===================================================================
> --- mmc.orig/drivers/mmc/core/mmc.c
> +++ mmc/drivers/mmc/core/mmc.c
> @@ -2009,14 +2009,13 @@ int mmc_attach_mmc(struct mmc_host *host
>
>         mmc_release_host(host);
>         err = mmc_add_card(host->card);
> -       mmc_claim_host(host);
>         if (err)
>                 goto remove_card;
>
> +       mmc_claim_host(host);
>         return 0;
>
>  remove_card:
> -       mmc_release_host(host);
>         mmc_remove_card(host->card);
>         mmc_claim_host(host);
>         host->card = NULL;
>
