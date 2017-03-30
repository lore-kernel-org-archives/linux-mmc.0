From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: meson-gx: factor out setting response
 configuration bits
Date: Thu, 30 Mar 2017 21:31:41 +0200
Message-ID: <CAPDyKFo7SDN+ncaJawDJ4=ZrspxnY2npGi7vwdSH19pj-qSjsw@mail.gmail.com>
References: <b9a9a85b-8975-abca-7901-b557ea7ccc13@gmail.com> <aeb1c108-59c9-664d-ad5d-c28d95176f36@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36125 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934926AbdC3Tbt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:31:49 -0400
Received: by mail-vk0-f47.google.com with SMTP id s68so67128194vke.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:31:48 -0700 (PDT)
In-Reply-To: <aeb1c108-59c9-664d-ad5d-c28d95176f36@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 27 March 2017 at 22:02, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Factor out setting the response configuration bits thus further reducing
> complexity of function meson_mmc_start_cmd.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>


Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 0de32008..0036680b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -456,6 +456,23 @@ static void meson_mmc_set_blksz(struct mmc_host *mmc, unsigned int blksz)
>         writel(cfg, host->regs + SD_EMMC_CFG);
>  }
>
> +static void meson_mmc_set_response_bits(struct mmc_command *cmd, u32 *cmd_cfg)
> +{
> +       if (cmd->flags & MMC_RSP_PRESENT) {
> +               if (cmd->flags & MMC_RSP_136)
> +                       *cmd_cfg |= CMD_CFG_RESP_128;
> +               *cmd_cfg |= CMD_CFG_RESP_NUM;
> +
> +               if (!(cmd->flags & MMC_RSP_CRC))
> +                       *cmd_cfg |= CMD_CFG_RESP_NOCRC;
> +
> +               if (cmd->flags & MMC_RSP_BUSY)
> +                       *cmd_cfg |= CMD_CFG_R1B;
> +       } else {
> +               *cmd_cfg |= CMD_CFG_NO_RESP;
> +       }
> +}
> +
>  static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>         struct meson_host *host = mmc_priv(mmc);
> @@ -469,20 +486,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>         cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>         cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>
> -       /* Response */
> -       if (cmd->flags & MMC_RSP_PRESENT) {
> -               if (cmd->flags & MMC_RSP_136)
> -                       cmd_cfg |= CMD_CFG_RESP_128;
> -               cmd_cfg |= CMD_CFG_RESP_NUM;
> -
> -               if (!(cmd->flags & MMC_RSP_CRC))
> -                       cmd_cfg |= CMD_CFG_RESP_NOCRC;
> -
> -               if (cmd->flags & MMC_RSP_BUSY)
> -                       cmd_cfg |= CMD_CFG_R1B;
> -       } else {
> -               cmd_cfg |= CMD_CFG_NO_RESP;
> -       }
> +       meson_mmc_set_response_bits(cmd, &cmd_cfg);
>
>         /* data? */
>         if (data) {
> --
> 2.12.1
>
>
