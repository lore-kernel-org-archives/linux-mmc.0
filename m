Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036FAC433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3432253A
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbhATASc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391720AbhASNpo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:45:44 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF139C0613D3
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:31 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id w187so10072135vsw.5
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTHQHqU0qhkolN2noyYVvQIfnQqsAqX/OkxGDVnDczg=;
        b=lMvP3hmORoGjFki5Mw/c9iRVt/gnrkbeBh3g9xc5AQZvG2FAgINcNJI9kyI/ucWXyf
         ZyzqgU0jSE5ffpLHsONVgjZ/9q9umFtsixU1wJbkI3S5XOmcWyMkZ77rFp8Gx395GpIi
         E1urx3oQLAoyBWHivI0ZqAmQ290EdVW0ZKNvI/NbPXDrqvDv5O+iBpw/mm3x3yvZ87sN
         ZkxPUaIkB2tBNpgYbMRPH8V2Jmr4GiIXuxzcdco/Eku+PkZ+9HPPgCAvU8UVNWxGT+dl
         I/QKhGZHlkS+cR1OALZlE6xUP8AhG60nEfAC6HQBqP28wIj0zD+ifI+XpiMAM3tLyHCr
         42Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTHQHqU0qhkolN2noyYVvQIfnQqsAqX/OkxGDVnDczg=;
        b=ZsZqsZwxZnxKUeVy14AO2gL/POUAf1zTFlCbtwVHX5twHoHenzGSV6H4n2iN5zP717
         1gXQVrwHVKukTlmwJgiHo9+J70oFlAOtsTVi5OgCaN9gibD6fDg8wYyJvBDAYAyu/C0V
         HmQ4ilvtOqJ2weMnWxpuJPtPpvdezLaab8SOOVwr46L2mUSNFJ8FRnIpSfVgN0ehhlv4
         CxRhfy/W/DnrHtO/9lp+m85j7pLZWjTJGHwaL6RYxTkS9wXTEoYg8w/+pLuTLDaK03oY
         jHHrXKHzvxxDJJtxVOs+b1VpbWda73Yb9S56SFUYbFzNC1dWIU1hYeoM4vts+Xt8Fidt
         0A1g==
X-Gm-Message-State: AOAM532n59jfkwKy8xtlH1bGzG5KaUHmBMHtvdEbfmeFkbZZ2L2aObz9
        f6OqPnaPcqeL/cb17Mtup9fCgseUnQbmHB+TADzw/w==
X-Google-Smtp-Source: ABdhPJxdfo5M6JQMC8opiCITaK/YZ64HskqUZ4WcV5+m2ZOkH2PxqKWWebmRR9gP5qzaZ6XUz4pArh9lHym4ct2B+rA=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr2544313vsd.55.1611063811106;
 Tue, 19 Jan 2021 05:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111082249.17092-1-reniuschengl@gmail.com>
In-Reply-To: <20210111082249.17092-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:42:55 +0100
Message-ID: <CAPDyKFqnLTas50enA32MoKyx6ivZiJ5H+X5HJLPzS=nQ_b-UFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Finetune HS400 RX delay for GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Jan 2021 at 09:22, Renius Chen <reniuschengl@gmail.com> wrote:
>
> To improve the compatibility of GL9763E with HS400 eMMC cards,
> finetune the RX delay of HS400 mode.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 2d13bfcbcacf..14d9154f3af1 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -95,6 +95,10 @@
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
>
> +#define PCIE_GLI_9763E_CLKRXDLY  0x934
> +#define   GLI_9763E_HS400_RXDLY    GENMASK(31, 28)
> +#define   GLI_9763E_HS400_RXDLY_5  0x5
> +
>  #define SDHCI_GLI_9763E_CQE_BASE_ADDR   0x200
>  #define GLI_9763E_CQE_TRNS_MODE           (SDHCI_TRNS_MULTI | \
>                                     SDHCI_TRNS_BLK_CNT_EN | \
> @@ -801,6 +805,11 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
> +       value &= ~GLI_9763E_HS400_RXDLY;
> +       value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.27.0
>
