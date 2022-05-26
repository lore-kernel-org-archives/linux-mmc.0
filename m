Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0057C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiEZTHl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 May 2022 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348704AbiEZTHj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2022 15:07:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AFCDFF4D
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 12:07:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so4763236ejk.5
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNIw4K4CxcDx2n4fXHx4DRk4s8LAMOQ2dmQHF62cmnA=;
        b=Us8W3VP5CBaZxaM8fwocfPkBliHzPC/FPlpmDfGirUtUWLLZNrSPRNFe4+qoV7O4RH
         Qb1CbAZZ6SdrPuMDeFGGW50ImTKannVeA/3d2wiL1f8BBmXUqyNuem0ZmEbvA6R+TEja
         jqmtApwU56vC2cg0IWbeHSGLBPk0j4zTHi7SMPRPBjzGH3FR1GFZFoIEPWKO8nx9pbVL
         Kw7aHFjtsfaM22O6rRtGJCATonSPH2/JtLh2NbBaEzhcXhCD17Sm/IRDoUeRcBksUYeA
         RrzfhlMwsWU9jylf2i+oT1U4SCv2Yg23EwOpT+Ydv/sGO/CIdqoZf3KMPmEk3Xn4OF+5
         eVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNIw4K4CxcDx2n4fXHx4DRk4s8LAMOQ2dmQHF62cmnA=;
        b=d9Rhd7S46ZIEPC7JsKifoTGP3YRvP9QqgMnfKizjXPL8gj1zjnoKtRJ/acFvSoJJmr
         S4ZnRJ5Otx3/05H9Ud3nF/YoLpES724O7YThVtUWNn073MsbIZ8buZiK+wHCUdr05GS8
         +gq6qrpn/9lR86lsDWJK0BkHlrLc4OXHYCcyZRV34ad38kLlZdEo5jtqs7GZvmMO5FPK
         EJF9vfI2wZSvZK8yN1L3puf1MOJOKJf3Wwqf/T01AWnabzOkKrtqyNTW6w/tOFaDwMAR
         Zqfbpq7WvsqoKHvTJlQ4JEU72uBPbfO1LwVCj2zBx+IqFmQD3De/AzUDNCPxLd3K6IKB
         Ad4g==
X-Gm-Message-State: AOAM530PyWusU5COcn02SRCgcqDXzLBFKqqlSQEqDX1/ts6e8G91XRsZ
        QKWoKSfIZN8rAnVSi2hKycXkw+Utt6HEgCzHvls=
X-Google-Smtp-Source: ABdhPJxRvCgwfyu0ALK2uDL7P9Z9jOYERcFqw2O/IxiD7YySMnJVd7isnCcC8OH09H7zLhqJzuyneVxzFgQsTOIkyXM=
X-Received: by 2002:a17:906:6a0f:b0:6fe:ed1f:ff00 with SMTP id
 qw15-20020a1709066a0f00b006feed1fff00mr18359334ejc.652.1653592056529; Thu, 26
 May 2022 12:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
 <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 May 2022 16:07:28 -0300
Message-ID: <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com>
Subject: Re: imx7d: Timeout waiting for hardware interrupt.
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

On Wed, May 25, 2022 at 7:21 AM Bough Chen <haibo.chen@nxp.com> wrote:

> Hi Fabio,
>
> According to the log, ADMA Err:  0x00000007, seems meet ADMA length miss match issue, please double check whether the following patch is on your side:
> commit e30be063d6dbcc0f18b1eb25fa709fdef89201fb mmc: sdhci-esdhc-imx: correct the fix of ERR004536
>
> also please add the following patch for suspend/resume case
> commit a26a4f1baca55a05aecd8d7181802979a93e3d46 mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs

Both commits are present in 5.10 stable, thanks.

I am testing a devicetree change.

Thanks
