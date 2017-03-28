From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: add functions mmc_dma_(un)map_sg
Date: Tue, 28 Mar 2017 09:18:03 +0200
Message-ID: <CAPDyKFqDpLe5FgYEC90Pfk_LNy3jWos+_Dpqbi7bMM_60TUQ0Q@mail.gmail.com>
References: <11e5aed4-c3ca-0d04-484a-9387302eaff2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34004 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbdC1HSo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2017 03:18:44 -0400
Received: by mail-vk0-f46.google.com with SMTP id z204so78371759vkd.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2017 00:18:04 -0700 (PDT)
In-Reply-To: <11e5aed4-c3ca-0d04-484a-9387302eaff2@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 27 March 2017 at 20:25, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> After the recent introduction of mmc_get_dma_dir next step is to
> factor out the typical usage of dma_(un)map_sg to the core.
> Several host drivers use dma_(un)map_sg with these parameters:
> data->sg, data->sg_len, mmc_get_dma_dir(data)
> Therefore factor this out to the core and introduce
> mmc_dma_(un)map_sg.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/mmc/host.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 21385ac0..8d28a600 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -17,7 +17,7 @@
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/pm.h>
> -#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
>
>  struct mmc_ios {
>         unsigned int    clock;                  /* clock rate */
> @@ -505,6 +505,16 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>         return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  }
>
> +static inline int mmc_dma_map_sg(struct device *dev, struct mmc_data *data)
> +{
> +       return dma_map_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
> +}
> +
> +static inline void mmc_dma_unmap_sg(struct device *dev, struct mmc_data *data)
> +{
> +       dma_unmap_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
> +}

These seems a bit silly as they are just wrapper functions. To me this
doesn't improve the code, but rather makes it harder to understand
what goes on.

Kind regards
Uffe

> +
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
>
> --
> 2.12.1
>
