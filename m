Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED20C4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiK2MzC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiK2Myx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:54:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF612A734
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so17231990pjh.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEdmoDp0VwqZXuUooek7LxDrUyhO539Ub+QFdiSLPUI=;
        b=szOyF+SC2juc6vEk5e7CydMjs7NkatxTOucvKPzrOl2BTN0zYE0wQap0pduNfWv2f2
         rrrunCwk9VVGJ0+RGQH4n7+eC2izohPptpzSaPLvMwh9lMjEqKZgM0hqrsrs0nXSrdaS
         9wRBWjvEmVcMrMhimy0C1TFWpiP6XXAG6N1nVRpvQ7xl+DsVfr7DuszED1gZfXVnaK2D
         ZPf+3uLWNaV0FzKjUVHyJFl46FIU7k771JviOV28WWFmK1hvmgJuGyqZ0fOmgFKcZl4E
         3LWiN818a5Qye76/P+6J96nQtkxcDqJi/4RDZsoI4O5UNPdKg5JKxqmtAsASqVns+XNf
         r2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEdmoDp0VwqZXuUooek7LxDrUyhO539Ub+QFdiSLPUI=;
        b=vxPe6T/DqashlMsg0v5jdNRua155RdcQs7tE+mgFdhFIDHy14SIvJFuxJOWEMpILGU
         yyab+Rlc2qTEmEs7MGAefpZvBAnfzxiN1ddWKabzU4ruhlwq2bKyn+CnJ6zQR+Cqcghx
         W3Rrizw5yt442Mk7zgzuiNQycm35Gf+xvUD8v6cDS1Yecuhfpc1NbA9EjbSEc61Icv6n
         pd9aGLJiiw2N8GUE+E1v1kIMezrDqqyKOS470s9vwoENLI8tOjLSXc7Hx8gHKVMl3GKp
         7PquFKTltkqB5XyZJqLvLVbXdrEPdo/Ec+wnbkBYYYvcsl+zd07LLh5S4PmJW3VRjDBA
         hvvg==
X-Gm-Message-State: ANoB5plHKwiVWvOYjkSiA3n7rdhDWTgFOCmOJ954ad0g6mQMwTqCFsWV
        vucB0jMqSbxaokMff1L3IAV7HgnIyCVXanNaw7aWJw==
X-Google-Smtp-Source: AA0mqf5YI8m48IPFeflWGnlqYhZOk4qnNV1Z+9dLOe6ODAhDBlhMdQCMEG8e+mJoaqTWjS5VnoC2zGa2I52q4YrhB7Y=
X-Received: by 2002:a17:902:ee55:b0:189:69cf:9ea0 with SMTP id
 21-20020a170902ee5500b0018969cf9ea0mr20123417plo.37.1669726492035; Tue, 29
 Nov 2022 04:54:52 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221124080135epcas1p2b899bc272cfefb823453c2b0559f925a@epcas1p2.samsung.com>
 <20221124080031.14690-1-cw9316.lee@samsung.com>
In-Reply-To: <20221124080031.14690-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:16 +0100
Message-ID: <CAPDyKFqFhjrc0T7y5Sy1ayJO3Dt3pecsB1rziUroq1L+8wbWCg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Replace with the already declared define function(mmc_op_tuning)
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     jh80.chung@samsung.com, chaotian.jing@mediatek.com,
        matthias.bgg@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Nov 2022 at 09:01, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> Replace with the already declared define function.
> There are no functional differences.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c              | 3 +--
>  drivers/mmc/host/dw_mmc.c            | 3 +--
>  drivers/mmc/host/mtk-sd.c            | 8 ++------
>  drivers/mmc/host/sdhci-msm.c         | 3 +--
>  drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
>  drivers/mmc/host/sdhci-tegra.c       | 8 ++------
>  drivers/mmc/host/sdhci.c             | 9 ++-------
>  7 files changed, 10 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1bb70d438d6c..efa7178955f8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -142,8 +142,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>         int err = cmd->error;
>
>         /* Flag re-tuning needed on CRC errors */
> -       if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
> -           cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
> +       if (!mmc_op_tuning(cmd->opcode) &&
>             !host->retune_crc_disable &&
>             (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
>             (mrq->data && mrq->data->error == -EILSEQ) ||
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e4d09c439051..829af2c98a44 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -334,8 +334,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
>             cmdr == MMC_READ_MULTIPLE_BLOCK ||
>             cmdr == MMC_WRITE_BLOCK ||
>             cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
> -           cmdr == MMC_SEND_TUNING_BLOCK ||
> -           cmdr == MMC_SEND_TUNING_BLOCK_HS200 ||
> +           mmc_op_tuning(cmdr) ||
>             cmdr == MMC_GEN_CMD) {
>                 stop->opcode = MMC_STOP_TRANSMISSION;
>                 stop->arg = 0;
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 652a67f9b054..d3f24dbda49f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1224,9 +1224,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>
>         if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
>                 if (events & MSDC_INT_CMDTMO ||
> -                   (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
> -                    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
> -                    !host->hs400_tuning))
> +                   (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
>                         /*
>                          * should not clear fifo/interrupt as the tune data
>                          * may have alreay come when cmd19/cmd21 gets response
> @@ -1320,9 +1318,7 @@ static void msdc_cmd_next(struct msdc_host *host,
>  {
>         if ((cmd->error &&
>             !(cmd->error == -EILSEQ &&
> -             (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> -              cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200 ||
> -              host->hs400_tuning))) ||
> +             (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
>             (mrq->sbc && mrq->sbc->error))
>                 msdc_request_done(host, mrq);
>         else if (cmd == mrq->sbc)
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 03f76384ab3f..4ac8651d0b29 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2219,8 +2219,7 @@ static int __sdhci_msm_check_write(struct sdhci_host *host, u16 val, int reg)
>                 if (!msm_host->use_cdr)
>                         break;
>                 if ((msm_host->transfer_mode & SDHCI_TRNS_READ) &&
> -                   SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK_HS200 &&
> -                   SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK)
> +                   !mmc_op_tuning(SDHCI_GET_CMD(val)))
>                         sdhci_msm_set_cdr(host, true);
>                 else
>                         sdhci_msm_set_cdr(host, false);
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index bca1d095b759..98cadff47b2b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -326,8 +326,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 (host->timing != MMC_TIMING_UHS_SDR50))
>                 return sdhci_execute_tuning(mmc, opcode);
>
> -       if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> -                       (opcode != MMC_SEND_TUNING_BLOCK)))
> +       if (WARN_ON(!mmc_op_tuning(opcode)))
>                 return -EINVAL;
>
>         /* Force power mode enter L0 */
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index c71000a07656..9fc8a61eca54 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -268,13 +268,9 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>  {
>         bool is_tuning_cmd = 0;
>         bool clk_enabled;
> -       u8 cmd;
>
> -       if (reg == SDHCI_COMMAND) {
> -               cmd = SDHCI_GET_CMD(val);
> -               is_tuning_cmd = cmd == MMC_SEND_TUNING_BLOCK ||
> -                               cmd == MMC_SEND_TUNING_BLOCK_HS200;
> -       }
> +       if (reg == SDHCI_COMMAND)
> +               is_tuning_cmd = mmc_op_tuning(SDHCI_GET_CMD(val));
>
>         if (is_tuning_cmd)
>                 clk_enabled = tegra_sdhci_configure_card_clk(host, 0);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fb6e9a81f198..75437b0073e8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1692,8 +1692,7 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>                 flags |= SDHCI_CMD_INDEX;
>
>         /* CMD19 is special in that the Data Present Select should be set */
> -       if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> -           cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
> +       if (cmd->data || mmc_op_tuning(cmd->opcode))
>                 flags |= SDHCI_CMD_DATA;
>
>         timeout = jiffies;
> @@ -3329,8 +3328,6 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>
>  static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  {
> -       u32 command;
> -
>         /*
>          * CMD19 generates _only_ Buffer Read Ready interrupt if
>          * use sdhci_send_tuning.
> @@ -3339,9 +3336,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>          * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
>          */
>         if (intmask & SDHCI_INT_DATA_AVAIL && !host->data) {
> -               command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> -               if (command == MMC_SEND_TUNING_BLOCK ||
> -                   command == MMC_SEND_TUNING_BLOCK_HS200) {
> +               if (mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)))) {
>                         host->tuning_done = 1;
>                         wake_up(&host->buf_ready_int);
>                         return;
> --
> 2.29.0
>
