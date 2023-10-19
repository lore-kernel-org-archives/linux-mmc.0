Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA3CDB465
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Oct 2023 11:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjJSLmA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Oct 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjJSLl7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Oct 2023 07:41:59 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69386131
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 04:41:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so9130770276.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697715716; x=1698320516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGiL/+7v3o1x68ttyGPtRHltt+XNK187tB89lDdG1nc=;
        b=jOm3/KhX7RqQ3CaiTLvHtdU2quhIqCQt41QY6lMDZQbdI4cAMhvsvqp2F9ghBSvx5i
         X0s16SVJ5zSAmQpz9BgkMlNJ34HLA/bn8khzzI0QO7i61svvwCiLTlSWcUuIhohxAj4v
         9cC2d1yzyX9mXZs98Trt0Ja9Ddf66Kc0qB/ObNunz1BTJ8qj3Dv1X+pYHHynrRZSRxnZ
         9Po3+5jWaVyI5uyyNRfHpENSc7yzgJwaKMRo7ZqrcKqYvbQaUmf8sI9+0vlSdH7hLktC
         /OLlrV8d6z+LypNRqM4WsPHOAsrhaRR7RztsX62b2wr/rgH2+LfKOU+YP1beVaQNgmU1
         8D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715716; x=1698320516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGiL/+7v3o1x68ttyGPtRHltt+XNK187tB89lDdG1nc=;
        b=lvTBOSxeLgLHMcx61TP+ZNwz3FcSDZBwfwQJ4Vaqifg5bJkclx1R4CUKp6udOgfJzS
         I578Dmi9yPfjX9nLNMBsPwk7Yt7Acob8BAcvvOcCZlAULLegEyqT70NkBesVk4XJcSK0
         48xiLj2sAkdbvbx+dhjTDOTaP5hrlk7D2+tJpnJqkrDviDX1AzHm92MDwnD9z1Zs7Fuo
         5ml64iq/HLJ9YtVy36jFkwZov7pq9O0pVj3+Iuq0GUVQX8Vna1WqDZhfCi9eXz9uRt66
         yAcnomvJ11PJMKG//Me4fnY6b5CguT9XQBfLAsAOScgP/d15g6FtBYITNmFlMNW4utSU
         F0Ig==
X-Gm-Message-State: AOJu0YwNk2TYtiNj1MxUFYvcFTiO0UwCbUtSlupvpWrLG095XBbYVyqX
        aS7kEhRbRLMKdrTDBT01tDGS9CdhlqL0ptbTDE8406rov11Bs1n9
X-Google-Smtp-Source: AGHT+IGlt7hzb+MeY42d0/BXzUGLA1J54UUaBUV7CnjW88OazHYdq5SUlmUQ758w0j6yMywc0mxbSPMhC1W9mneTaL8=
X-Received: by 2002:a5b:a8e:0:b0:d85:df88:a7c4 with SMTP id
 h14-20020a5b0a8e000000b00d85df88a7c4mr1937717ybq.18.1697715716577; Thu, 19
 Oct 2023 04:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <1143f3d4d26b4e7a8b3cc0d68caaa5ba@realtek.com>
In-Reply-To: <1143f3d4d26b4e7a8b3cc0d68caaa5ba@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 13:41:20 +0200
Message-ID: <CAPDyKFrmeDGvRMQ8CsueJhxPoFNWDLTEpx3OFRkWozrgT3tU1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: rtsx: add rts5264 to support sd express card
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Oct 2023 at 05:01, Ricky WU <ricky_wu@realtek.com> wrote:
>
> add rts5264 register setting when sd express card insert
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

I wasn't cc'd patch1 and not the mmc-list. Can you please resubmit so
we can see the complete series?

Kind regards
Uffe

> ---
> v3: split up mmc part from v2 patch
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 87d78432a1e0..7dfe7c4e0077 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -7,6 +7,7 @@
>   *   Wei WANG <wei_wang@realsil.com.cn>
>   */
>
> +#include <linux/pci.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/highmem.h>
> @@ -947,7 +948,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
>         /* send at least 74 clocks */
>         rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
>
> -       if (PCI_PID(pcr) == PID_5261) {
> +       if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
>                 /*
>                  * If test mode is set switch to SD Express mandatorily,
>                  * this is only for factory testing.
> @@ -1364,6 +1365,14 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>         struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>         struct rtsx_pcr *pcr = host->pcr;
>
> +       if (PCI_PID(pcr) == PID_5264) {
> +               pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL2,
> +                               PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_2_5GT);
> +               pci_write_config_byte(pcr->pci, 0x80e, 0x02);
> +               pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL2,
> +                               PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_5_0GT);
> +       }
> +
>         /* Set relink_time for changing to PCIe card */
>         relink_time = 0x8FFF;
>
> @@ -1379,6 +1388,12 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>         if (pcr->ops->disable_auto_blink)
>                 pcr->ops->disable_auto_blink(pcr);
>
> +       if (PCI_PID(pcr) == PID_5264) {
> +               rtsx_pci_write_register(pcr, RTS5264_AUTOLOAD_CFG2,
> +                       RTS5264_CHIP_RST_N_SEL, RTS5264_CHIP_RST_N_SEL);
> +               rtsx_pci_write_register(pcr, GPIO_CTL, 0x02, 0x00);
> +       }
> +
>         /* For PCIe/NVMe mode can't enter delink issue */
>         pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
>         rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
> --
> 2.25.1
