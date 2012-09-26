From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v4 01/15] mmc: sdhci: fix transfer mode setting bug for
 cmds w/o data transfer
Date: Wed, 26 Sep 2012 21:16:28 +0900
Message-ID: <CAGxe1ZEtz9O9-qSHOxXW88vKVhrSR-Aot80zWNE=1TCwpv8Mtw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-2-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34583 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2IZMQ3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 08:16:29 -0400
Received: by vcbfo13 with SMTP id fo13so517516vcb.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Sep 2012 05:16:28 -0700 (PDT)
In-Reply-To: <1348659527-4200-2-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Jialing Fu <jlfu@marvell.com>, Tim Wang <wangtt@marvell.com>

Reviewed By: Girish K S <girish.shivananjappa@linaro.org>

On 26 September 2012 20:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Commands without data transfer like cmd5/cmd7 will use previous
> transfer mode setting, which may lead to error since some bits
> may have been set unexpectedly.
> For example, cmd5 following cmd18/cmd25 will have timeout error
> since audo cmd23 has been enabled.
>
> Signed-off-by: Jialing Fu <jlfu@marvell.com>
> Signed-off-by: Tim Wang <wangtt@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e15c79..9be6a8c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -886,8 +886,21 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>         u16 mode;
>         struct mmc_data *data = cmd->data;
>
> -       if (data == NULL)
> +       if (!data) {
> +               if (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> +                       cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
> +                       /*
> +                        * The tuning block is sent by the card to the host
> +                        * controller. So we set the TRNS_READ bit in the
> +                        * Transfer Mode register. This also takes care of
> +                        * setting DMA Enable and Multi Block Select in the
> +                        * same register to 0.
> +                        */
> +                       sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
> +               else
> +                       sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
>                 return;
> +       }
>
>         WARN_ON(!host->data);
>
> @@ -1850,13 +1863,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                                      SDHCI_BLOCK_SIZE);
>                 }
>
> -               /*
> -                * The tuning block is sent by the card to the host controller.
> -                * So we set the TRNS_READ bit in the Transfer Mode register.
> -                * This also takes care of setting DMA Enable and Multi Block
> -                * Select in the same register to 0.
> -                */
> -               sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
>
>                 sdhci_send_command(host, &cmd);
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
