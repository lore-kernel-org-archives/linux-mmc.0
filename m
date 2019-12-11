Return-Path: <SRS0=rVnL=2B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFCBC43603
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 08:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFEC2077B
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 08:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi/+WlL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfLKIsZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:48:25 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36783 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKIsZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2019 03:48:25 -0500
Received: by mail-vs1-f68.google.com with SMTP id m5so15199529vsj.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2019 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pslFpG5vsGoElkgucdRbWyXrZQ6BVNx548Fu4FrKHrA=;
        b=Oi/+WlL6KMeqP7UP9SWleWuXD4+cecwgf9U2pBD23L1p/NTChv84gmrl6llpCW35UL
         /JlP9M6V0St1agk+DNgbisOZjBdW66ClIj6N7erTqM6Rdj4T5HXXzPxtzrG8bx/SrT+D
         eAtOLsuLe2rA5uXWcCb7IMnYq+NRYAzsHylSyEipwh5oZWD9PMkyHCKhcMVDcvlB4YcL
         ukz9ZiEeFdSlQEPOcp9oAgQbjvUtm5Uzhmrlb9g32yH/ZTSIAvWayc4X/93wKv+tdgy0
         fxdZ2PJ34Cmbydvq2WAK9fYsrXCWfF/2tm3mb9A4rVi6RWmMDMQ+tcsX2sTqAH0pBjrf
         MGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pslFpG5vsGoElkgucdRbWyXrZQ6BVNx548Fu4FrKHrA=;
        b=QDneluqK/DIhRJH/c5nW41MZa2rsVGTvbOeiPq4endYj7bH7u4VpQHcreOM+BJn0UI
         sm1xRiR3p8eEu6ZN7i354NGDqDwU7wLWS43T4jlB6apDs4UMk5uSbss/abA5YHer66yf
         9S2FRfTq1U3Ej/GtkvJ3BcAz6lq7kmUpkT+VGXORO1zphiCu4tXg2LTS152QuVF03mZp
         tK5ze7ZAovMFDeMz8GzGb9hQV1ecFeyOzuDLI9lAIVgetEAohrT0juVwmIYfor0gn8Mt
         C5VO3U4Yc/tqJpjMZaapEs/q+QujZjXhtF2L1R2NwtjmLvluq3uH2oRMcnp0h3in7wVC
         rUzw==
X-Gm-Message-State: APjAAAXmLaiVJxTwRzG+1lUcUD1+9jZhEbhiPxlUOO/ow6aqAjXDpN3A
        kGC9frMkl5ZFFYkY8djiO06Moltb5XdtoIXdlnKUokoTBV0=
X-Google-Smtp-Source: APXvYqw35Fy+Z5+GKqekVw6q2EzXkqmtSRV8yx2Y3gi6DGjPggYpPSzTVzEHZwvdkH4MNsFx99zNeOBH9Vo9lZeLo+g=
X-Received: by 2002:a67:ff82:: with SMTP id v2mr1491258vsq.35.1576054104174;
 Wed, 11 Dec 2019 00:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20191202222853.28783-1-linus.walleij@linaro.org>
In-Reply-To: <20191202222853.28783-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Dec 2019 09:47:47 +0100
Message-ID: <CAPDyKFrt8+NJSDzYuMjVdeo2xi45+=q8NU=6VLc1isvLxchckw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: mmci: Support odd block sizes for ux500v2 and
 qcom variant
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 Dec 2019 at 23:28, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> For the ux500v2 variant of the PL18x block, odd block sizes
> are supported. This is necessary to support some SDIO
> transfers. This also affects the QCOM MMCI variant and the
> ST micro variant.
>
> For Ux500 an additional quirk only allowing DMA on blocks
> that are a power of two is needed. This might be a bug in
> the DMA engine (DMA40) or the MMCI or in the interconnect,
> but the most likely is the MMCI, as transfers of these
> sizes work fine for other devices using the same DMA
> engine. DMA works fine also with SDIO as long as the
> blocksize is a power of 2.
>
> This patch has proven necessary for enabling SDIO for WLAN on
> PostmarketOS-based Ux500 platforms.
>
> What we managed to test in practice is Broadcom WiFi over
> SDIO on the Ux500 based Samsung GT-I8190 and GT-S7710.
> This WiFi chip, BCM4334 works fine after the patch.
>
> Before this patch:
>
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4334-sdio
>           for chip BCM4334/3
> mmci-pl18x 80118000.sdi1_per2: unsupported block size (60 bytes)
> brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> brcmfmac: brcmf_sdio_download_code_file: error -22 on writing
>           434236 membytes at 0x00000000
> brcmfmac: brcmf_sdio_download_firmware: dongle image file download
>           failed
>
> After this patch:
>
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4334/3 wl0:
>           Nov 21 2012 00:21:28 version 6.10.58.813 (B2) FWID 01-0
>
> Bringing up networks, discovering networks with "iw dev wlan0 scan"
> and connecting works fine from this point.
>
> This patch is inspired by Ulf Hansson's patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
>
> As the DMA engines on these platforms may now get block sizes
> they were not used to before, make sure to also respect if
> the DMA engine says "no" to a transfer.
>
> Make a drive-by fix for datactrl_blocksz, misspelled.

Alright, I think this approach makes sense.

Especially, trying to make some changes in mmci_pio_read|write() that
we can trigger/test doesn't make sense.

A few nitpicks below.

>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Rewrite the patch to accept odd packages but only
>   let power of two packages pass on to the DMA.
> - Drop the patches disallowing DMA not divisible by 4:
>   this doesn't work. Instead just push the whole
>   power of two criteria down to the DMA submission
>   phase.
> - Drop the patch handling odd sglist offsets and
>   passing of page boundaries in SG buffers when
>   using PIO: it just doesn't happen in practice, we
>   don't know why, but likely because all packets are
>   small.
> ChangeLog v2->v3:
> - Repost with the inclusion of other patches.
> ChangeLog v1->v2:
> - Specify odd blocksize field to 1 bit (:1)
> - Specify that STMMC supports odd block sizes
> - Collect Stephan's test tag
> ---

[...]

> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 833236ecb31e..37d02f147b4f 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -278,7 +278,11 @@ struct mmci_host;
>   * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
>   * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
>   * @datactrl_mask_sdio: SDIO enable mask in datactrl register
> - * @datactrl_blksz: block size in power of two
> + * @datactrl_blocksz: block size in power of two
> + * @datactrl_odd_blocksz: true if block any block sizes are accepted by
> + *               hardware, such as with some SDIO traffic that send
> + *               odd packets.
> + * @only_pow_2_dma: DMA only works with blocks that are a power of 2.
>   * @datactrl_first: true if data must be setup before send command
>   * @datacnt_useless: true if you could not use datacnt register to read
>   *                  remaining data
> @@ -323,6 +327,8 @@ struct variant_data {
>         unsigned int            datactrl_mask_ddrmode;
>         unsigned int            datactrl_mask_sdio;
>         unsigned int            datactrl_blocksz;
> +       u8                      datactrl_odd_blocksz:1;

How about renaming this to datactrl_any_blocksz? As I think that
better explains its purpose.

> +       u8                      only_pow_2_dma:1;

and rename this to dma_power_of_2

>         u8                      datactrl_first:1;
>         u8                      datacnt_useless:1;
>         u8                      st_sdio:1;
> --
> 2.21.0
>

Kind regards
Uffe
