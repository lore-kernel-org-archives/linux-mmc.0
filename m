From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: host: mxcmmc: Simplify a trivial if-return sequence
Date: Mon, 11 May 2015 12:30:57 +0200
Message-ID: <CAPDyKFrnozK8_PBNW-TjVX9BV2aR_eWJycd4NvHhmo1xZ6fbEA@mail.gmail.com>
References: <1431207891-21448-1-git-send-email-festevam@gmail.com>
	<1431207891-21448-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34761 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbbEKKa5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:30:57 -0400
Received: by qkgx75 with SMTP id x75so83531750qkg.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:30:57 -0700 (PDT)
In-Reply-To: <1431207891-21448-2-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 9 May 2015 at 23:44, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Simplify a trivial if-return sequence. Possibly combine with a
> preceding function call.
>
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/simple_return.cocci.
>
> More information about semantic patching is available at
> http://coccinelle.lip6.fr/
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, applied!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxcmmc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 317d709..d110f9e 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -605,11 +605,7 @@ static int mxcmci_push(struct mxcmci_host *host, void *_buf, int bytes)
>                 mxcmci_writel(host, cpu_to_le32(tmp), MMC_REG_BUFFER_ACCESS);
>         }
>
> -       stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
> -       if (stat)
> -               return stat;
> -
> -       return 0;
> +       return mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
>  }
>
>  static int mxcmci_transfer_data(struct mxcmci_host *host)
> --
> 1.9.1
>
