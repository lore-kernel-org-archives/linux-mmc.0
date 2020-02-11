Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FACC3B188
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C54721D7D
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 15:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+5ascRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgBKPQ5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:16:57 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35835 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBKPQ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 10:16:57 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so6524762vsc.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2020 07:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WENS2WcOxHmXvDO2pe8ifXBhkcUA3hWBPLeNHKN8EoM=;
        b=C+5ascRqzPXGryltERKgpy4StkE4UDqzTw3z3ftMWMC3RwhZOcWM2KgPIGW6uTN7J7
         si3ykSCHDvO4YTBpTF+fg/HXJdnzBJLgkqSW3lD080sgfeb58FaWgAmjAjogA7/v1nbI
         DrBuwN/GHIMAMJgJzWS3GFcIdi24lIE8Tc0fYv2ERDU3MiUL0aAkHcyCKDepr/UU7usu
         NJfGsdAQuyeQ4cvjkorfm4XpVogPPGbMOVux0+WFsU9o3zKwerLaQ9weCyCtuEpxpl/O
         T05diV41zPXxkMmdYBtZObEYoxu5XCsB4ZgPd9WMT8MZE2bOaM/HNKk/BgefwQ9F1qHZ
         wrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WENS2WcOxHmXvDO2pe8ifXBhkcUA3hWBPLeNHKN8EoM=;
        b=V1BuHSOva+s1wXO+Q6V5DZ7XZ49w88a3kexSxSZxNEQ02Jl1zuxwB7/noUNM3VaPwN
         L8NZthOi1Ooy50HuA3Up3BY2v3+V+R6TdXheLbWIEFKuwlBch+duWBoyxZdPMByP1wxQ
         2TynmtokEhHNEG/tEPgG0pJmU6RUx431JA9nLzXn0kkN8pTZAAZN5yiPQcprWxWOTt7M
         TYLjAwnJtGPtdUFuOx+o3KBf/aBhXSrAJ3iNhmi9eAvxzZ3VFsaMrUh5xyOi7gKewqNl
         MjwmlqPEEf/8J2ipM7Mrln3ZxytJ/89g4Ln+Ka9/irTZLu6B2jQ7JBWzhmB7iW34eEje
         ngmg==
X-Gm-Message-State: APjAAAVae3Scaflm+59WfKSON3mpLSJ5OsfOlGHMsW/A4NJmgw92yS5z
        kvY+pmCTUCJTgofGpjIPDVQwDHS3YVyrx7NSKtiHpA==
X-Google-Smtp-Source: APXvYqxX+g30kIlrE7sS/CTlKwzqSp/4IyXR9L+m+r5akbnOHy+rmb/ItP0h3AjrD+kKmmUxf62c/e8ix4e9zhDSy+c=
X-Received: by 2002:a67:ee02:: with SMTP id f2mr9380622vsp.165.1581434215966;
 Tue, 11 Feb 2020 07:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20200128090636.13689-1-ludovic.barre@st.com> <0d4a3df8-fd1a-4839-116c-149f9e478f42@st.com>
In-Reply-To: <0d4a3df8-fd1a-4839-116c-149f9e478f42@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Feb 2020 16:16:20 +0100
Message-ID: <CAPDyKFpD9GS2FNt2DOsnELtopzhAmyKizU6xhBrP5_uokFFHTw@mail.gmail.com>
Subject: Re: [PATCH V2 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Feb 2020 at 15:47, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" on this series
> https://patchwork.kernel.org/project/linux-mmc/list/?series=3D234011

I will have a look later this week. The merge window closed yesterday
and normally I don't queue anything but fixes during the merge window.

Anyway, apologize for the delays.

Kind regards
Uffe

>
> Regards
> Ludo
>
> Le 1/28/20 =C3=A0 10:06 AM, Ludovic Barre a =C3=A9crit :
> > To support the sdr104 mode, sdmmc variant needs:
> > -Hardware delay block support for sdmmc variant
> >   with tuning procedure
> > -Voltage switch callbacks
> > -sdmmc revision 2.0
> >
> > V2:
> > -regroup host->mmc_ops & mmc->ops assignment
> > -add timeout define
> > -rename prep_volt_switch to pre_sig_volt_switch
> > -rename volt_switch to post_sig_volt_switch
> > -add 'why' comment for "mmc: mmci: add volt_switch callbacks"
> >
> > Ludovic Barre (9):
> >    mmc: mmci: sdmmc: replace sg_dma_xxx macros
> >    mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
> >    mmc: mmci: add a reference at mmc_host_ops in mmci struct
> >    mmc: mmci: add private pointer for variant
> >    dt-bindings: mmc: mmci: add delay block base register for sdmmc
> >    mmc: mmci: sdmmc: add execute tuning with delay block
> >    mmc: mmci: add volt_switch callbacks
> >    mmc: mmci: sdmmc: add voltage switch functions
> >    mmc: mmci: add sdmmc variant revision 2.0
> >
> >   .../devicetree/bindings/mmc/mmci.txt          |   2 +
> >   drivers/mmc/host/mmci.c                       |  42 +++-
> >   drivers/mmc/host/mmci.h                       |   8 +
> >   drivers/mmc/host/mmci_stm32_sdmmc.c           | 204 +++++++++++++++++=
-
> >   4 files changed, 248 insertions(+), 8 deletions(-)
> >
