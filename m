From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 2/2] mmc: dw_mmc-k3: add sd support for hi3660
Date: Tue, 8 Aug 2017 13:03:46 +0200
Message-ID: <CAPDyKFom6yjj8+OU2B9cR+SaehtoZ_4JMtkETKfz5JWu4OkmZw@mail.gmail.com>
References: <20170802031742.60363-1-liwei213@huawei.com> <20170802031742.60363-2-liwei213@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34360 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdHHLDr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 07:03:47 -0400
Received: by mail-qt0-f180.google.com with SMTP id s6so17620935qtc.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 04:03:47 -0700 (PDT)
In-Reply-To: <20170802031742.60363-2-liwei213@huawei.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Li Wei <liwei213@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Heiner Kallweit <hkallweit1@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>

On 2 August 2017 at 05:17, Li Wei <liwei213@huawei.com> wrote:
> Add sd card support for hi3660 soc
>
> Signed-off-by: Li Wei <liwei213@huawei.com>
> Signed-off-by: Chen Jun <chenjun14@huawei.com>
>
> Major changes in v3:
>  - solve review comments from Heiner Kallweit.
>    *use the GENMASK and FIELD_PREP macros replace the bit shift operation.
>    *use usleep_range() replace udelay() and mdelay().
>
> Major changes in v4:
>  - solve review comments from Jaehoon Chung.
>    *move common register for dwmmc controller to dwmmc header file.
>    *modify definitions type of some register variables.
>    *get rid of the magic numbers.
>
> Major changes in v5:
>  - further improve coding style.
>
> Major changes in v6:
>  - solve review comments for Jaehoon Chung.
>    *modify dw_mci_hi3660_set_ios() to static.
>    *fix the comment style.
>
> Major changes in v7:
>  - solve review comments for John Stultz.
>    *remove reset code in dw_mmc-k3.c,use reset in core mmc.
>
> Major changes in v8:
>  - modify patch v7 name and dependency order.

Version history is really great information, however it doesn't belong
inside the change log itsefl. Instead add "---" and a newline here,
then put it all below that.

[...]

> +static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
> +                                       struct mmc_ios *ios)
> +{
> +       int ret;
> +       int min_uv = 0;
> +       int max_uv = 0;
> +       struct dw_mci_slot *slot = mmc_priv(mmc);
> +       struct k3_priv *priv;
> +       struct dw_mci *host;
> +
> +       host = slot->host;
> +       priv = host->priv;
> +
> +       if (!priv || !priv->reg)
> +               return 0;
> +
> +       if (priv->ctrl_id == DWMMC_SDIO_ID)
> +               return 0;
> +
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +               ret = dw_mci_set_sel18(host, 0);
> +               if (ret)
> +                       return ret;
> +               min_uv = 2950000;
> +               max_uv = 2950000;
> +       } else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +               ret = dw_mci_set_sel18(host, 1);
> +               if (ret)
> +                       return ret;
> +               min_uv = 1800000;
> +               max_uv = 1800000;
> +       }
> +
> +       if (IS_ERR_OR_NULL(mmc->supply.vqmmc))
> +               return 0;
> +
> +       ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);

We have an API, mmc_regulator_set_vqmmc(), that you probably should
use here instead.

> +       if (ret) {
> +               dev_err(host->dev, "Regulator set error %d: %d - %d\n",
> +                       ret, min_uv, max_uv);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static const struct dw_mci_drv_data hi3660_data = {
> +       .init = dw_mci_hi3660_init,
> +       .set_ios = dw_mci_hi3660_set_ios,
> +       .parse_dt = dw_mci_hi6220_parse_dt,
> +       .execute_tuning = dw_mci_hi3660_execute_tuning,
> +       .switch_voltage  = dw_mci_hi3660_switch_voltage,
> +};
> +
>  static const struct of_device_id dw_mci_k3_match[] = {
> +       { .compatible = "hisilicon,hi3660-dw-mshc", .data = &hi3660_data, },
>         { .compatible = "hisilicon,hi4511-dw-mshc", .data = &k3_drv_data, },
>         { .compatible = "hisilicon,hi6220-dw-mshc", .data = &hi6220_data, },
>         {},
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 75da3756955d..5403758bf621 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -314,6 +314,8 @@ struct dw_mci_board {
>  #define SDMMC_DSCADDR          0x094
>  #define SDMMC_BUFADDR          0x098
>  #define SDMMC_CDTHRCTL         0x100
> +#define SDMMC_UHS_REG_EXT      0x108
> +#define SDMMC_ENABLE_SHIFT     0x110
>  #define SDMMC_DATA(x)          (x)
>  /*
>  * Registers to support idmac 64-bit address mode
> --
> 2.11.0
>

Overall the code looks okay to me, however I am wondering about the
relationship with the original k3 driver code and hi6220 code. Almost
no code is being re-used between the different variants. Why is that?

Kind regards
Uffe
