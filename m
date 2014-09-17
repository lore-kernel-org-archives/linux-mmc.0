From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Remove unused function for !CONFIG_OF
Date: Thu, 18 Sep 2014 00:57:42 +0200
Message-ID: <CAPDyKFpdhrsxF-cocQT2nocDiG5ZoOSaYsRE=Jp2n=oBA1Y5WA@mail.gmail.com>
References: <1410854095-10460-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:46525 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119AbaIQW5n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Sep 2014 18:57:43 -0400
Received: by mail-qc0-f173.google.com with SMTP id i8so76176qcq.18
        for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2014 15:57:42 -0700 (PDT)
In-Reply-To: <1410854095-10460-1-git-send-email-tklauser@distanz.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 16 September 2014 09:54, Tobias Klauser <tklauser@distanz.ch> wrote:
> dw_mci_of_find_slot_node() is only used in dw_mci_of_get_slot_quirks(=
)
> if CONFIG_OF is defined, thus there is no need to have a !CONFIG_OF
> version of it. Fixes the following compile warning with !CONFIG_OF:
>
>   CC [M]  drivers/mmc/host/dw_mmc.o
> drivers/mmc/host/dw_mmc.c:2223:28: warning: =E2=80=98dw_mci_of_find_s=
lot_node=E2=80=99 defined but not used [-Wunused-function]
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 835e913..109fefe 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2220,10 +2220,6 @@ static int dw_mci_of_get_slot_quirks(struct de=
vice *dev, u8 slot)
>  {
>         return 0;
>  }
> -static struct device_node *dw_mci_of_find_slot_node(struct device *d=
ev, u8 slot)
> -{
> -       return NULL;
> -}
>  #endif /* CONFIG_OF */
>
>  static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> --
> 2.0.1
>
>
