Return-Path: <SRS0=rVnL=2B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40793C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AC922464
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itSLkAue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfLKItW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:49:22 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43859 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfLKItV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2019 03:49:21 -0500
Received: by mail-vs1-f68.google.com with SMTP id x4so15174384vsx.10
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2019 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ozb1AXUQbSxxmXr/qW2iWv6krsEgASVQKk8kJLaIj6I=;
        b=itSLkAuepLnnXfXT3q4sqUphN7IVDBuCIFOOJktfIYvQ6qbcEYsoYgUP6xTut12JV4
         fM5MUNeMyYHgBaRNQ8jpsldbdNd/V0ZfT8Q2fCdIm/zfd67fBhZXA1P6MXV5OQ5c7nuk
         coLkTiY1s1eII5GaAAJHGT5wR4pAV8ns4PEgLOVoLROLcpclSTFOcCZNNyjyJYzpdm+W
         L71sWmfcnv+K6obBIkRIA4B+K8Xs/CgYrj+zKxPcUZNQ/I7CjSa0Q2B+Sq3yrPpHFP1w
         rYvB1/9kHam8y1bdsukyqqh64LRrw55hKdGyriuakB4uVX/Mn6xl1IwMkWkFeUpj+uGr
         ej/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ozb1AXUQbSxxmXr/qW2iWv6krsEgASVQKk8kJLaIj6I=;
        b=mgAskWuOR+vR9l4MA/e6OnW0uGoi+TwGQEN1HzRu4Amhc3VFqg806KvUWiLn/0sq/N
         lAfaBAeUHY7/hr0JzQ8vAusW9VYnAwDNXObVp2JSD5TDLff0+TZVsFuaJEVVAwocJlmL
         pvA1BNgdCITZBLGmI/2kkos1HBLvSOzpbBs9q6D47Oo428cRqfwdTSEK5oHG8mq1vGl+
         1CwQ57myIyol329KkBW1Hw+JLavqqsHEJ7avOygWKdn/a7CYtoBonNW4i1Lac/b8l3Ow
         8A4aKaezOPjBE4dw2QtrcOh1OboQchS8f0OKMtO67Fv0VBkFhZ+zQ5CIHrB0C1YuPGFY
         f7DQ==
X-Gm-Message-State: APjAAAXIpr3E2asqebvrJDlwNfitllvMXJ355nHPQLSUsFp5m+GW3S0m
        SKe9xJ9vD96zo2vKJ3lkYmAnFBNheDDMHcHrTzlNhQ==
X-Google-Smtp-Source: APXvYqyY1AGsQYlb3OCcajmL+tUEyHfP+9OR0ha/5jNG4MURWI9aZtpoUad6e4Zvvrr5fz3z/iRUkZaPPOQHpCLCBVg=
X-Received: by 2002:a67:b649:: with SMTP id e9mr1525437vsm.34.1576054160719;
 Wed, 11 Dec 2019 00:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20191202222853.28783-1-linus.walleij@linaro.org> <CAPDyKFrt8+NJSDzYuMjVdeo2xi45+=q8NU=6VLc1isvLxchckw@mail.gmail.com>
In-Reply-To: <CAPDyKFrt8+NJSDzYuMjVdeo2xi45+=q8NU=6VLc1isvLxchckw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Dec 2019 09:48:44 +0100
Message-ID: <CAPDyKFpSrQY_0V0DM24Bamte5_8XqtAL_8J6SkwBC1-B2aNuvA@mail.gmail.com>
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

On Wed, 11 Dec 2019 at 09:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 2 Dec 2019 at 23:28, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > For the ux500v2 variant of the PL18x block, odd block sizes
> > are supported. This is necessary to support some SDIO
> > transfers. This also affects the QCOM MMCI variant and the
> > ST micro variant.
> >
> > For Ux500 an additional quirk only allowing DMA on blocks
> > that are a power of two is needed. This might be a bug in
> > the DMA engine (DMA40) or the MMCI or in the interconnect,
> > but the most likely is the MMCI, as transfers of these
> > sizes work fine for other devices using the same DMA
> > engine. DMA works fine also with SDIO as long as the
> > blocksize is a power of 2.
> >
> > This patch has proven necessary for enabling SDIO for WLAN on
> > PostmarketOS-based Ux500 platforms.
> >
> > What we managed to test in practice is Broadcom WiFi over
> > SDIO on the Ux500 based Samsung GT-I8190 and GT-S7710.
> > This WiFi chip, BCM4334 works fine after the patch.
> >
> > Before this patch:
> >
> > brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4334-sdio
> >           for chip BCM4334/3
> > mmci-pl18x 80118000.sdi1_per2: unsupported block size (60 bytes)
> > brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
> > brcmfmac: brcmf_sdio_download_code_file: error -22 on writing
> >           434236 membytes at 0x00000000
> > brcmfmac: brcmf_sdio_download_firmware: dongle image file download
> >           failed
> >
> > After this patch:
> >
> > brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4334/3 wl0:
> >           Nov 21 2012 00:21:28 version 6.10.58.813 (B2) FWID 01-0
> >
> > Bringing up networks, discovering networks with "iw dev wlan0 scan"
> > and connecting works fine from this point.
> >
> > This patch is inspired by Ulf Hansson's patch
> > http://www.spinics.net/lists/linux-mmc/msg12160.html
> >
> > As the DMA engines on these platforms may now get block sizes
> > they were not used to before, make sure to also respect if
> > the DMA engine says "no" to a transfer.
> >
> > Make a drive-by fix for datactrl_blocksz, misspelled.
>
> Alright, I think this approach makes sense.
>
> Especially, trying to make some changes in mmci_pio_read|write() that
> we can trigger/test doesn't make sense.

/s/can/can't

[...]

Kind regards
Uffe
