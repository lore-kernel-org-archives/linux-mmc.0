From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: meson-gx: work around broken SDIO with certain
 WiFi chips
Date: Mon, 12 Jun 2017 09:58:33 +0200
Message-ID: <CAPDyKFoHtjm5-e-CTG4BrWyzayRe3Yir-2Y-bJkLfkyotRgT+Q@mail.gmail.com>
References: <8ac1f97a-afbb-dde9-7e60-3e51396cb8ff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33935 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdFLH6f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2017 03:58:35 -0400
Received: by mail-qt0-f178.google.com with SMTP id c10so116861248qtd.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2017 00:58:34 -0700 (PDT)
In-Reply-To: <8ac1f97a-afbb-dde9-7e60-3e51396cb8ff@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10 June 2017 at 13:36, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> There have been reports about SDIO failing with certain WiFi chips in
> descriptor chain mode. SD / eMMC are working fine.
>
> So let's fall back to bounce buffer mode for command SD_IO_RW_EXTENDED.
> This was reported to fix the error.
>
> Fixes: 79ed05e329c3 "mmc: meson-gx: add support for descriptor chain mode"
> Cc: <stable@vger.kernel.org> # 4.12.x
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> v2:
> - fixed affected WiFi chip: actually it is AP6255
> - added tested-by
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 1842ed34..4cdbe3c0 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -210,6 +210,15 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         int i;
>         bool use_desc_chain_mode = true;
>
> +       /*
> +        * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
> +        * reported. For some strange reason this occurs in descriptor
> +        * chain mode only. So let's fall back to bounce buffer mode
> +        * for command SD_IO_RW_EXTENDED.
> +        */
> +       if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
> +               return;
> +
>         for_each_sg(data->sg, sg, data->sg_len, i)
>                 /* check for 8 byte alignment */
>                 if (sg->offset & 7) {
> --
> 2.13.0
>
