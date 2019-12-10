Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F3C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E8920652
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="isvucb+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLJXiw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:38:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36924 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJXiw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 18:38:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so21862479lja.4
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 15:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n+VlOX89MUSGgTpFgiBaSEN28umMajlJqyHz8UtJac=;
        b=isvucb+NlPbykeWG5xL8usYYPDgvvdn44/d+1dYr937wTtHdZfLn9xutmQXzhumApi
         4Z7oZ00UBu9ssbNW+FW8axVC42+r12sH+xSqclVFfqAhNJiOuGmWurtg7EsgBrKdVZTC
         1S0pHi/XIAOgVwXnmXNT2n5opb4o4gdICPeJDvUBCaGef4EIBi3CHU2TknkTYh3tNA53
         WRi6gy7W3tAKG5dGIgvnMgewggbkCbyzz4eiDkECl9Uunsgnf/kich8+lwocALlNA92w
         TbEIREBb61IVkFBbnnCg4tDAvkq/th5csgLjhFYHyr2z1y9du999F08Bpe0Wg6vSDn/P
         qQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n+VlOX89MUSGgTpFgiBaSEN28umMajlJqyHz8UtJac=;
        b=dyScpVkKBC/hEjgte6dmaUL5uu7DEIe2QpPAbir6ya2FMcNbdpfIR8IZJ8WniAbt3w
         GSsGRUTLaJmRqhgYxdDsogY73hzdhh67YJ2aj7Xi7sQuD8rLMf7G9sNF5aDLHR0972PE
         00OWKM0ACKNBwG6PzeU1L4SeN3ev5DU8/1M3t+eDDehIj00AIatt+BaxhyDA6A3MFBFH
         Tl0wQXPO53FEQlkWhbMpxF3rOYsIL1IDQeNsLtxKurglUBKlSaHVFwCed+tFgkbAMA2g
         YwToOOZm1X+vdrVppVVL5+X+qBu4KtihHDPPNgSrh2dVDJuXcOC9nky7OUyFqGnO6P4v
         DD2Q==
X-Gm-Message-State: APjAAAU1eXRHwOZX2Ai9KvFQOLnCzPPSqWKHcJznJ5vFC9QMfya9o6/d
        YjodC82vJwqAz9zx3yXFmfSVsgpHs8TRUrFg0aQ1/w==
X-Google-Smtp-Source: APXvYqwmoKtEFkGRrXBV/A6sT23lbH2t8INvfhY27L+/wQMvcGjDZE3qXo4D5enLIvngyeV0m0+RGVlYbjr/5YVCLis=
X-Received: by 2002:a2e:8045:: with SMTP id p5mr22088308ljg.251.1576021130078;
 Tue, 10 Dec 2019 15:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20191203130120.11511-1-haibo.chen@nxp.com> <20191203130120.11511-11-haibo.chen@nxp.com>
In-Reply-To: <20191203130120.11511-11-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 00:38:38 +0100
Message-ID: <CACRpkdbm75KX3bBH0gaGhiPTd=zD996qgu7vSHr1H3u_uSRo=g@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] mmc: sdhci-esdhc-imx: handle 'sdhci,auto-cmd23-broken'
 from devicetree
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 3, 2019 at 1:54 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:

> Since L4.15, community involve the commit 105819c8a545 ("mmc: core: use mrq->sbc
> when sending CMD23 for RPMB"), let the usdhc to decide whether to use ACMD23 for
> RPMB. This CMD23 for RPMB need to set the bit 31 to its argument, if not, the
> RPMB write operation will return general fail.
>
> According to the sdhci logic, SDMA mode will disable the ACMD23, and only in
> ADMA mode, it will chose to use ACMD23 if the host support. But according to
> debug, and confirm with IC, the imx6qpdl/imx6sx/imx6sl/imx7d do not support
> the ACMD23 feature completely. These SoCs only use the 16 bit block count of
> the register 0x4 (BLOCK_ATT) as the CMD23's argument in ACMD23 mode, which
> means it will ignore the upper 16 bit of the CMD23's argument. This will block
> the reliable write operation in RPMB, because RPMB reliable write need to set
> the bit31 of the CMD23's argument. This is the hardware limitation. Due to
> imx6sl use SDMA, so for imx6qpdl/imx6sx/imx7d, it need to broke the ACMD23 for
> eMMC, SD card do not has this limitation, because SD card do not support reliable
> write.
>
> For imx6ul/imx6ull/imx6sll/imx7ulp/imx8, it support the ACMD23 completely, it
> change to use the 0x0 register (DS_ADDR) to put the CMD23's argument in ADMA mode.
>
> This patch handle 'sdhci,auto-cmd23-broken' from devicetree.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

So it does seem like this is a problem with the host controller, not
with the card?

> -       if (of_find_property(np, "no-1-8-v", NULL))
> -               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;

Why are you deleting this? Seems unrelated.

> +       /* call to generic sdhci_get_property to support additional capabilities */
> +       sdhci_get_property(pdev);

Or does it get set by this call?
(Then explain that change in the commit message.)

> +       if (device_property_present(dev, "sdhci,auto-cmd23-broken"))
> +               host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;

Even if this is a problem with the host controller I am not convinced.

Can't you just use the compatible-string of the host controller to
switch this flag?

They should be different compatibles because if this bug is present
in one version of the host controller and not another version then
by definition they are not compatible, right?

The idea with very specific compatible strings is to handle
exactly things like this.

Yours,
Linus Walleij
