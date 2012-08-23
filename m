From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 5/5] mmc: dw-mmc: add the use_hold_reg in CMD register
Date: Thu, 23 Aug 2012 13:41:41 +0100
Message-ID: <CAFbHwiQkmb08dc53gHX6MMVEKMLoSAiqYsmcF4VKtYMLVWnadw@mail.gmail.com>
References: <503614A9.2020304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51758 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab2HWMlm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 08:41:42 -0400
Received: by qaas11 with SMTP id s11so443347qaa.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Aug 2012 05:41:41 -0700 (PDT)
In-Reply-To: <503614A9.2020304@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch is added the use_hold_reg bit in CMD register.
>
> In upper version than 2.40a, bit[29] of CMD register is used the use_hold_reg.
> Some SoC is affected by this bit.
> (This bit means whether use hold register when send data and cmd.
>  And related with cclk_in_drv phase)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   36 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h  |    1 +
>  include/linux/mmc/dw_mmc.h |    3 +++
>  3 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index feafa2d..426171f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -265,11 +265,45 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void dw_mci_start_command(struct dw_mci *host,
>                                  struct mmc_command *cmd, u32 cmd_flags)
>  {
> +       struct dw_mci_slot *slot = host->cur_slot;
> +       struct mmc_ios *ios = &slot->mmc->ios;
> +
>         host->cmd = cmd;
>         dev_vdbg(&host->dev,
>                  "start command: ARGR=0x%08x CMDR=0x%08x\n",
>                  cmd->arg, cmd_flags);
>
> +       if (host->quirks & DW_MCI_QUIRK_USE_CLKSEL_REG) {
> +               /*
> +                * If use HOLD register and SDR12/SDSR25,
> +                * CMD and DATA sent to card through HOLD register by default.
> +                * But if mode is SDR50/DDR50/SDR104,
> +                * only use the hold register when cclk_in_drv value is upper than 0.

"greater" might be better than "upper" here.

> +                */
> +               switch (ios->timing) {
> +               case MMC_TIMING_UHS_SDR50:
> +               case MMC_TIMING_UHS_DDR50:
> +                       if (host->pdata->get_clk_drv)
> +                               if ((host->pdata->get_clk_drv(host) &&
> +                                               host->use_hold_reg)) {

There's more brackets than necessary here in the second if, and the
two if conditions could probably be combined to make it neater.
