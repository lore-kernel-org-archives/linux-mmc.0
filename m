From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: Remove bogus un-initialization in tmio_mmc_host_free()
Date: Thu, 5 Mar 2015 14:41:13 +0100
Message-ID: <CAPDyKFpEOo3Wx3nKiiULNy0aX-zX-UJw0h3uDihtmDkQmUQMOg@mail.gmail.com>
References: <1424277299-24964-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:42686 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbbCENlO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:41:14 -0500
Received: by qgfi50 with SMTP id i50so5103351qgf.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 05:41:14 -0800 (PST)
In-Reply-To: <1424277299-24964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 18 February 2015 at 17:34, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If CONFIG_DEBUG_SLAB=y:
>
>     sh_mobile_sdhi ee100000.sd: Got CD GPIO
>     sh_mobile_sdhi ee100000.sd: Got WP GPIO
>     platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
>     ...
>     Slab corruption (Not tainted): kmalloc-1024 start=ed8b3c00, len=1024
>     2d0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  ....kkkkkkkkkkkk
>     Prev obj: start=ed8b3800, len=1024
>     000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>     010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>
> Struct tmio_mmc_host is embedded inside struct mmc_host, and thus is
> freed by the call to mmc_free_host(). Hence it must not be written to
> afterwards, as that will corrupt freed (and perhaps already reused)
> memory.
>
> Fixes: 94b110aff8679b14 ("mmc: tmio: add tmio_mmc_host_alloc/free()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index a31c3573d386f8c6..dba7e1c19dd758e7 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1073,8 +1073,6 @@ EXPORT_SYMBOL(tmio_mmc_host_alloc);
>  void tmio_mmc_host_free(struct tmio_mmc_host *host)
>  {
>         mmc_free_host(host->mmc);
> -
> -       host->mmc = NULL;
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_free);
>
> --
> 1.9.1
>
