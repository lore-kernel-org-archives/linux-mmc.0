Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B29DC2BB1D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA8820575
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 14:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtJI4ofX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgCPORk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:17:40 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46130 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgCPORj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 10:17:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id z125so11334341vsb.13
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2020 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfpSr29ntUR/I/as2FQq9j0zRov447y/exMSEoJfydg=;
        b=wtJI4ofXmDD1A9SJtl2cHZNW4zEcI9mspR3pkgS9x6qsrxGVFTfgFNc+OslwPl0EWI
         FikZg4a0YBL5Teyixuzvvwrl1nqV/blw7wNZKa59V5JP6hAqdoKzN69X7ppg6xXgsSAZ
         VZwIL83qK9FxJp4n941qkyxBh9eA6Nxw+8Tk0XWB7I/0h5Qao0NVPVtQclnkOJ/pS1bH
         ls3PQHPNO+NtJmdiSr9WOmzLi9pMSziQCQLzqOMtSy/YJtyN+bN/U0sh7ICYIZHJZ2l3
         pZmNDlOS8FnYGKZM9CSrnM1rV4Unk++4zZL4iPsfpZOw+G3I5MNG+8VhYbvqbeqJHxTB
         FOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfpSr29ntUR/I/as2FQq9j0zRov447y/exMSEoJfydg=;
        b=URwcEGSHkWCsNvqDg4E+bxdB+6QXmZleBRVJKh9UGfMHlt776d6nCXa0kCRXCFqSHe
         6SETPNWk7+8guhLZuC0BpUxX4X+i5PF3I2lNx1XPpUNiRSv9ZNIWIqUAVwI1OPBNFrRL
         iNDIeXJSdtR4ycy0y4aDODilAEV1ylUIRDVARc6eJywHBjWjDKMKQCBIjBy6GFTrkDjF
         cXWlor9g2qlayF+0DYlWuCM8mQOn1zoUfQBci4UCqi8oXT5fymyTh6q5ZmdPmSgDwwMf
         2C1s4kINMSRHXFCwCoHRVuUIiAmsvCbkAQcAHGFASfgVW4dCuor2TTrdp7v90qzWowfL
         7DVg==
X-Gm-Message-State: ANhLgQ1tKcxjE5eyC2zuB40k4VQcADaYfHYl/f4VRdnDsgMo/4/jY1pT
        0fWKzYVXl9TvWRQBqVJdBNkyLovXMJhHFcVcDGD4Kg==
X-Google-Smtp-Source: ADFU+vsxkwXlJemW8aKdO41aOyBLa5RhNk7gSNyGUSH1YIJtaUWpgkkWDFYSXRhK6xqmc/5RnEQ6rEBKwKcHX3T5+bQ=
X-Received: by 2002:a67:646:: with SMTP id 67mr17046878vsg.34.1584368256722;
 Mon, 16 Mar 2020 07:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200316025232.1167-1-ricky_wu@realtek.com>
In-Reply-To: <20200316025232.1167-1-ricky_wu@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Mar 2020 15:16:59 +0100
Message-ID: <CAPDyKFrWedEmZ=0trPEG8Z-11nyFX6_OB3cx7+SAdB5VW_vzgQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Fixed TX/RX register and optimized TX parameter
To:     ricky_wu@realtek.com
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Mar 2020 at 03:52, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Fixed sd_change_phase TX/RX register
> Optimized rts522a rts524a rts525a rts5260 rts5261 TX initial parameter

I don't understand what this actually fixes. Can you try to elaborate
a bit on this, please?

Do you think this is needed for stable, then why?

Kind regards
Uffe

>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5227.c |  2 +-
>  drivers/misc/cardreader/rts5249.c |  2 ++
>  drivers/misc/cardreader/rts5260.c |  2 +-
>  drivers/misc/cardreader/rts5261.c |  2 +-
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 13 ++++++++-----
>  5 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
> index 4feed296a327..423fecc19fc4 100644
> --- a/drivers/misc/cardreader/rts5227.c
> +++ b/drivers/misc/cardreader/rts5227.c
> @@ -394,7 +394,7 @@ static const struct pcr_ops rts522a_pcr_ops = {
>  void rts522a_init_params(struct rtsx_pcr *pcr)
>  {
>         rts5227_init_params(pcr);
> -
> +       pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
>         pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
>
>         pcr->option.ocp_en = 1;
> diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> index db936e4d6e56..1a81cda948c1 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -618,6 +618,7 @@ static const struct pcr_ops rts524a_pcr_ops = {
>  void rts524a_init_params(struct rtsx_pcr *pcr)
>  {
>         rts5249_init_params(pcr);
> +       pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
>         pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
>         pcr->option.ltr_l1off_snooze_sspwrgate =
>                 LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF;
> @@ -733,6 +734,7 @@ static const struct pcr_ops rts525a_pcr_ops = {
>  void rts525a_init_params(struct rtsx_pcr *pcr)
>  {
>         rts5249_init_params(pcr);
> +       pcr->tx_initial_phase = SET_CLOCK_PHASE(25, 29, 11);
>         pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
>         pcr->option.ltr_l1off_snooze_sspwrgate =
>                 LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF;
> diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
> index 4214f02a17fd..711054ebad74 100644
> --- a/drivers/misc/cardreader/rts5260.c
> +++ b/drivers/misc/cardreader/rts5260.c
> @@ -662,7 +662,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
>         pcr->aspm_en = ASPM_L1_EN;
> -       pcr->tx_initial_phase = SET_CLOCK_PHASE(1, 29, 16);
> +       pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
>         pcr->ic_version = rts5260_get_ic_version(pcr);
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index bc4967a6efa1..78c3b1d424c3 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -764,7 +764,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
>         pcr->aspm_en = ASPM_L1_EN;
> -       pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 27, 16);
> +       pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 11);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
>         pcr->ic_version = rts5261_get_ic_version(pcr);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index bd50935dc37d..11087976ab19 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -606,19 +606,22 @@ static int sd_change_phase(struct realtek_pci_sdmmc *host,
>                 u8 sample_point, bool rx)
>  {
>         struct rtsx_pcr *pcr = host->pcr;
> -
> +       u16 SD_VP_CTL = 0;
>         dev_dbg(sdmmc_dev(host), "%s(%s): sample_point = %d\n",
>                         __func__, rx ? "RX" : "TX", sample_point);
>
>         rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, CHANGE_CLK);
> -       if (rx)
> +       if (rx) {
> +               SD_VP_CTL = SD_VPRX_CTL;
>                 rtsx_pci_write_register(pcr, SD_VPRX_CTL,
>                         PHASE_SELECT_MASK, sample_point);
> -       else
> +       } else {
> +               SD_VP_CTL = SD_VPTX_CTL;
>                 rtsx_pci_write_register(pcr, SD_VPTX_CTL,
>                         PHASE_SELECT_MASK, sample_point);
> -       rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET, 0);
> -       rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET,
> +       }
> +       rtsx_pci_write_register(pcr, SD_VP_CTL, PHASE_NOT_RESET, 0);
> +       rtsx_pci_write_register(pcr, SD_VP_CTL, PHASE_NOT_RESET,
>                                 PHASE_NOT_RESET);
>         rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, 0);
>         rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
> --
> 2.17.1
>
