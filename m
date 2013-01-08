From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 3/4] mmc: core: Break out start_signal_voltage_switch
Date: Tue, 8 Jan 2013 15:10:48 +0100
Message-ID: <CAPDyKFr4CtiOC+JXMLp6YQ8cG8pR+wRstvoUtwwCaV6U7kwMKA@mail.gmail.com>
References: <1357653962-10887-1-git-send-email-johan.rudholm@stericsson.com>
	<1357653962-10887-4-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33387 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab3AHOKu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 09:10:50 -0500
Received: by mail-la0-f47.google.com with SMTP id fh20so491984lab.34
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 06:10:49 -0800 (PST)
In-Reply-To: <1357653962-10887-4-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 8 January 2013 15:06, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
> Allow callers to access the start_signal_voltage_switch host_ops
> member without going through any cmd11 logic. This is mostly a
> preparation for the following signal voltage switch patch.
>
> Also, reset ios.signal_voltage to its original value if
> start_signal_voltage_switch fails.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
>  drivers/mmc/core/core.c |   35 +++++++++++++++++++++++------------
>  drivers/mmc/core/core.h |    4 ++--
>  drivers/mmc/core/mmc.c  |    8 ++++----
>  drivers/mmc/core/sd.c   |    2 +-
>  drivers/mmc/core/sdio.c |    3 +--
>  5 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 285f064..03db641 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1219,7 +1219,26 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>         return ocr;
>  }
>
> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11)
> +int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
> +{
> +       int err = 0;
> +       int old_signal_voltage = host->ios.signal_voltage;
> +
> +       host->ios.signal_voltage = signal_voltage;
> +       if (host->ops->start_signal_voltage_switch) {
> +               mmc_host_clk_hold(host);
> +               err = host->ops->start_signal_voltage_switch(host, &host->ios);
> +               mmc_host_clk_release(host);
> +       }
> +
> +       if (err)
> +               host->ios.signal_voltage = old_signal_voltage;
> +
> +       return err;
> +
> +}
> +
> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>  {
>         struct mmc_command cmd = {0};
>         int err = 0;
> @@ -1230,7 +1249,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>          * Send CMD11 only if the request is to switch the card to
>          * 1.8V signalling.
>          */
> -       if ((signal_voltage != MMC_SIGNAL_VOLTAGE_330) && cmd11) {
> +       if (signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
>                 cmd.opcode = SD_SWITCH_VOLTAGE;
>                 cmd.arg = 0;
>                 cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> @@ -1243,15 +1262,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>                         return -EIO;
>         }
>
> -       host->ios.signal_voltage = signal_voltage;
> -
> -       if (host->ops->start_signal_voltage_switch) {
> -               mmc_host_clk_hold(host);
> -               err = host->ops->start_signal_voltage_switch(host, &host->ios);
> -               mmc_host_clk_release(host);
> -       }
> -
> -       return err;
> +       return __mmc_set_signal_voltage(host, signal_voltage);
>  }
>
>  /*
> @@ -1314,7 +1325,7 @@ static void mmc_power_up(struct mmc_host *host)
>         mmc_set_ios(host);
>
>         /* Set signal voltage to 3.3V */
> -       mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, false);
> +       __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>
>         /*
>          * This delay should be sufficient to allow the power supply
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 4a90067..f2439d5 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -40,8 +40,8 @@ void mmc_set_ungated(struct mmc_host *host);
>  void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
>  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
> -                          bool cmd11);
> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
> +int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>  void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
>  void mmc_power_off(struct mmc_host *host);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e6e3911..bd86771 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -769,11 +769,11 @@ static int mmc_select_hs200(struct mmc_card *card)
>
>         if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
>                         host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
> -               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0);
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>
>         if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
>                         host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
> -               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 0);
> +               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>
>         /* If fails try again during next card power cycle */
>         if (err)
> @@ -1221,8 +1221,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                          * WARNING: eMMC rules are NOT the same as SD DDR
>                          */
>                         if (ddr == MMC_1_2V_DDR_MODE) {
> -                               err = mmc_set_signal_voltage(host,
> -                                       MMC_SIGNAL_VOLTAGE_120, 0);
> +                               err = __mmc_set_signal_voltage(host,
> +                                       MMC_SIGNAL_VOLTAGE_120);
>                                 if (err)
>                                         goto err;
>                         }
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 74972c2..0cc1b26 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -759,7 +759,7 @@ try_again:
>          */
>         if (!mmc_host_is_spi(host) && rocr &&
>            ((*rocr & 0x41000000) == 0x41000000)) {
> -               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
> +               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>                 if (err) {
>                         ocr &= ~SD_OCR_S18R;
>                         goto try_again;
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 2273ce6..0c84e0f 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -650,8 +650,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>                         (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
>                          MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
>                          MMC_CAP_UHS_DDR50))) {
> -               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
> -                               true);
> +               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>                 if (err) {
>                         ocr &= ~R4_18V_PRESENT;
>                         host->ocr &= ~R4_18V_PRESENT;
> --
> 1.7.10
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson
