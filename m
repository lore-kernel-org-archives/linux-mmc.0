From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA segment len to 1 for bf518.
Date: Wed, 8 Aug 2012 11:23:09 +0800
Message-ID: <CAJxxZ0M9oReELfJ_ncu=eHd=Qy0Bpx=06Jv3MzvOPbRTh_h-jg@mail.gmail.com>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34981 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab2HHDXK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Aug 2012 23:23:10 -0400
Received: by eeil10 with SMTP id l10so67639eei.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Aug 2012 20:23:09 -0700 (PDT)
In-Reply-To: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi Chris,

Could you review this series of patches for Blackfin on-chip SD
controller? The head file and new BF60x machine code have been merged
upstream. These patches are necessary to get SD driver built on BF60x.

Thanks

Sonic Zhang


On Tue, Aug 7, 2012 at 11:10 AM, Sonic Zhang <sonic.adi@gmail.com> wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> bf518 RSI dma doesn't work in array mode.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/mmc/host/bfin_sdh.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
> index 0366617..fd25b0c 100644
> --- a/drivers/mmc/host/bfin_sdh.c
> +++ b/drivers/mmc/host/bfin_sdh.c
> @@ -469,7 +469,11 @@ static int __devinit sdh_probe(struct platform_device *pdev)
>         }
>
>         mmc->ops = &sdh_ops;
> +#if defined(CONFIG_BF54x)
>         mmc->max_segs = 32;
> +#elif defined(CONFIG_BF51x)
> +       mmc->max_segs = 1;
> +#endif
>         mmc->max_seg_size = 1 << 16;
>         mmc->max_blk_size = 1 << 11;
>         mmc->max_blk_count = 1 << 11;
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
