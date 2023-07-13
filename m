Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CFC001DC
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjGMLGd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjGMLG3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:06:29 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD6E26BC
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso531595276.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246375; x=1691838375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M2M/lZh8JsEWuYVKsWWFjaGBRpyeEN+n2El8R2XDALY=;
        b=x+qDakDYU7SCaCRHYo8IHk3AXxJHIyHaxgle5KNxYtDxkFUfBKLDnILKAv5QsqyuyN
         wCLIDIFrJiI/ylaFEjiZbISdlg40BZmUjVk94y08GZiZ40v/oYKuezCwQFrcVKqa4PY8
         H6LqVAITrRATp43Yvje5zlxVmnDHPJQNhhnrZxd78bs7oPEBy+tmKglItVZusAEF7U1a
         nmzE+KFan4KvASFR4nYK3VZ0H1if9kptZ5lowJFTn0OKq4mmFgK129MfgzJYKhcl3WG1
         GjywAl32C0WEYrUL3Js2+WBHP3nSD7r5pkWL8qXCoJSBaqIbnFLKIUGek1ivJWCBci0A
         i+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246375; x=1691838375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2M/lZh8JsEWuYVKsWWFjaGBRpyeEN+n2El8R2XDALY=;
        b=gs8xnRJsBCi7HAIp5ltSPnRXIm8kfdhb3XcA3lx0+jPpVbOAN/+hatgpdwQsjGxQ9F
         KjuFmndgSbbVV7Hcm37SZTjxtlWNEfXcKKJoXNC8wm8+xCalYQGxMV8ewWXGSG6D3ez+
         aDY9vl33q2JLvsQ0MRVJU4ixpBWaJq1uGs6fLtDngf2e5c5e34g03jucSn4h4P+kBuYt
         Y3/lLWg+9/zc0Gg6wkvKnDofcIW3KTW2Yzl5o7t//QEIGSaoW1+ka0MqkdlgPpI7kA4T
         7whx2Hg+RmBz1exvC7zJ6YIQbJL026UeyhylVEp0nj04TaegAYveF+XDpineBu0oU1WB
         KgBw==
X-Gm-Message-State: ABy/qLZpZ1+sR1SmdB1SGv/E02ecmgX2Clh/cceEH1a3rBtvZ1j6QfUy
        Yvt9yAHE8kCJ6Uc28nVta7Le7qahpjEiej9nAMsGqg==
X-Google-Smtp-Source: APBJJlHObgT/444UyFbaYVnmaGs/mnlSqy9iy+e1wKBM+93VVPOHlLqTjqQYV6qyhEfqVkw0MP4O+5D4OjIUjdbyfXw=
X-Received: by 2002:a25:2f81:0:b0:c80:f701:7467 with SMTP id
 v123-20020a252f81000000b00c80f7017467mr831061ybv.45.1689246375257; Thu, 13
 Jul 2023 04:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230628191243.3632401-1-linus.walleij@linaro.org>
In-Reply-To: <20230628191243.3632401-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:05:39 +0200
Message-ID: <CAPDyKFofJQcFOYzD6TsfOL-ocU4viGnMUSumjnPeojkb0drF_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Improve ux500 debug prints
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Jun 2023 at 21:12, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> To conclude the ux500 busy timeout fixes, this improves the debug and
> error prints so we can see a bit what is going on. Here is a typical
> dmesg with these new debug messages enabled:
>
> [    2.648864] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4
>                at 0x80005000 irq 81,0 (pio)
> [    2.662750] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX dma0chan5
> [    3.480407] mmci-pl18x 80005000.mmc: no busy signalling in time CMD06
> [    3.487457] mmci-pl18x 80005000.mmc: no busy signalling in time CMD06
> [    3.998321] mmci-pl18x 80005000.mmc: timeout in state waiting for end IRQ
>                                         waiting for busy CMD06
> [    3.998535] mmc2: new DDR MMC card at address 0001
> [    4.000030] mmcblk2: mmc2:0001 M4G1YC 3.69 GiB
> [    4.008361]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15
>                          p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
> [    4.017700] mmcblk2boot0: mmc2:0001 M4G1YC 2.00 MiB
> [    4.020477] mmcblk2boot1: mmc2:0001 M4G1YC 2.00 MiB
> [    4.022125] mmcblk2rpmb: mmc2:0001 M4G1YC 128 KiB, chardev (246:0)
> [    5.791381] mmci-pl18x 80005000.mmc: no busy signalling in time CMD06
> [   10.938568] mmci-pl18x 80005000.mmc: timeout in state waiting for end IRQ
>                                         waiting for busy CMD06
> [   17.982849] mmci-pl18x 80005000.mmc: lost busy status when waiting for
>                                         busy start IRQ CMD06
> [   18.683563] mmci-pl18x 80005000.mmc: no busy signalling in time CMD06
> [   19.385437] mmci-pl18x 80005000.mmc: no busy signalling in time CMD06
> [   20.493652] mmci-pl18x 80005000.mmc: no busy signalling in time CMD06
>
> We see a lot of lost IRQs and the timeout always occur while waiting for
> the end IRQ, and then the busy status is *low* meaning the busy indication
> is already de-asserted.
>
> So busy signalling is missed in various ways for various reasons,
> sometimes it appears that IRQs are simply lost.
>
> One hypothesis is that this happens because the events happen so fast
> that they are transient, and since the MMCI state machine in effect is
> handling an edge trigger (rising or falling signal on DAT0) the
> internal logic will miss the event, because the state machine in the
> hardware is sampling the line, and will at times detect only the first
> event but miss the second, fireing only one IRQ.
>
> We print the second timeout error with dev_err() since it is pretty
> serious, the other events are so common and simple to handle that we
> can keep them at dev_dbg() level.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 4fd28eaadc07..5d05269a8567 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -734,7 +734,8 @@ static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
>                         }
>                         retries--;
>                 }
> -               dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
> +               dev_dbg(mmc_dev(host->mmc),
> +                       "no busy signalling in time CMD%02x\n", cmd->opcode);
>                 ux500_busy_clear_mask_done(host);
>                 break;
>
> @@ -756,7 +757,8 @@ static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
>                         host->busy_state = MMCI_BUSY_WAITING_FOR_END_IRQ;
>                 } else {
>                         dev_dbg(mmc_dev(host->mmc),
> -                               "lost busy status when waiting for busy start IRQ\n");
> +                               "lost busy status when waiting for busy start IRQ CMD%02x\n",
> +                               cmd->opcode);
>                         cancel_delayed_work(&host->ux500_busy_timeout_work);
>                         ux500_busy_clear_mask_done(host);
>                 }
> @@ -770,13 +772,14 @@ static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
>                         ux500_busy_clear_mask_done(host);
>                 } else {
>                         dev_dbg(mmc_dev(host->mmc),
> -                               "busy status still asserted when handling busy end IRQ - will keep waiting\n");
> +                               "busy status still asserted when handling busy end IRQ - will keep waiting CMD%02x\n",
> +                               cmd->opcode);
>                 }
>                 break;
>
>         default:
> -               dev_dbg(mmc_dev(host->mmc), "fell through on state %d\n",
> -                       host->busy_state);
> +               dev_sbg(mmc_dev(host->mmc), "fell through on state %d, CMD%02x\n",
> +                       host->busy_state, cmd->opcode);
>                 break;
>         }
>
> @@ -1503,6 +1506,20 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         }
>  }
>
> +static char *ux500_state_str(struct mmci_host *host)
> +{
> +       switch (host->busy_state) {
> +       case MMCI_BUSY_WAITING_FOR_START_IRQ:
> +               return "waiting for start IRQ";
> +       case MMCI_BUSY_WAITING_FOR_END_IRQ:
> +               return "waiting for end IRQ";
> +       case MMCI_BUSY_DONE:
> +               return "not waiting for IRQs";
> +       default:
> +               return "unknown";
> +       }
> +}
> +
>  /*
>   * This busy timeout worker is used to "kick" the command IRQ if a
>   * busy detect IRQ fails to appear in reasonable time. Only used on
> @@ -1522,9 +1539,15 @@ static void ux500_busy_timeout_work(struct work_struct *work)
>                 /* If we are still busy, let's tag on timeout error. */
>                 if (status & host->variant->busy_detect_flag) {
>                         status |= MCI_CMDTIMEOUT;
> -                       dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy\n");
> +                       dev_err(mmc_dev(host->mmc),
> +                               "timeout in state %s still busy with CMD%02x\n",
> +                               ux500_state_str(host),
> +                               host->cmd->opcode);
>                 } else {
> -                       dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
> +                       dev_err(mmc_dev(host->mmc),
> +                               "timeout in state %s waiting for busy CMD%02x\n",
> +                               ux500_state_str(host),
> +                               host->cmd->opcode);
>                 }
>
>                 mmci_cmd_irq(host, host->cmd, status);
> --
> 2.40.1
>
