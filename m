Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21CC11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232B861992
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 10:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhF3KVO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhF3KVN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 06:21:13 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042C7C061756
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 03:18:45 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y25so1373847vsj.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3TfIIYg3vn+J6tiH3SF2PxOwmaPFXWU1lVKNjspiEo=;
        b=nPTpTlG2Esh5Isy38dB1J04N81iGkRiZyMpUtkaYPF6If1GeDOZfrjjOBUJ6MVqm6h
         YbZK6kLK5acfVljbgFYprwG0Zo3SlTpbKeago+yWHKOZPxNO1uixQkmWzwmNPEDztC/O
         jyqaRkixaacB0cxyFRriIIb1SY9o/rZCivVsr0mzTQ13NyS7V1bVilPinmX+b5YMJx8P
         nD/lhDNFJWhaszF3T4h6KDoNFczKfijhOfuMAoZp54gdPxoXjoDFjIwhBPw6nyeMa76k
         9nfO/NuZMyx16HRFkNrgzofINotHUjWRAXBAWgjMz8FNdh2I8s1cwjbUn2pTTv9Myoq+
         XgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3TfIIYg3vn+J6tiH3SF2PxOwmaPFXWU1lVKNjspiEo=;
        b=taT1jc3Zm2/S6lsbqwQqC/lBKGNZFgwd4d8qsUZ/iLZgcNI355o5rz+GvUJyUJTI15
         xKNmWqykTxmbCLIO74YZQKyksY6FLANq1Lg72ZhN5dvC+x+P4fPdCHNMPcsn/+NRLGdC
         0Arl7O5SAOs8eBEbeo2PK6MIOrCq9lfrSnez2uLOlPIZ28AuiXsHMkGRtuFwrj4VG7mD
         X8psHrnOrf7he0fDvj65DTy9fEJhCyZYnHE2TDnfr1oTVu1RbTE+2JdEikdYQILk+85P
         2fCFK9Hk6nMgR1rMrRgeBK+oQ+Oa+CwS1jep6QiZeVTA6BWB7wXCk5xJUs0TZw5BE4cU
         wqQg==
X-Gm-Message-State: AOAM531rYyYcVLVhrnxDa1wJhhUik5PKofw/q5NA3iU2Qa2eCY6Egtbt
        vb/apg8ObFztYCkSeo0CdUpC/36whGTmoK8Km1Ircw==
X-Google-Smtp-Source: ABdhPJyut0pFO0GAe/8vE/9kxOBes/ux+Fuz6dSryyj4FD05bGbR5kHMIXDXkfbEJQWc3NagZE35WYJNno2RWMs8/78=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr21891455vsp.55.1625048324201;
 Wed, 30 Jun 2021 03:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210619225118.1862634-1-linus.walleij@linaro.org>
In-Reply-To: <20210619225118.1862634-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 12:18:08 +0200
Message-ID: <CAPDyKFpz77TJ2L5y4CQ6VAyuUdD_4sCmg4J8KTvG7H8QuPu8ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: mmci: De-assert reset on probe
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 20 Jun 2021 at 00:53, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we find a reset handle when probing the MMCI block,
> make sure the reset is de-asserted. It could happen that
> a hardware has reset asserted at boot.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 984d35055156..af2ed6013ef9 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2125,6 +2125,10 @@ static int mmci_probe(struct amba_device *dev,
>         if (IS_ERR(host->rst)) {
>                 ret = PTR_ERR(host->rst);
>                 goto clk_disable;
> +       } else {

You can skip this "else", as reset_control_deassert() copes with a
NULL pointer being passed to it.

> +               ret = reset_control_deassert(host->rst);
> +               if (ret)
> +                       dev_err(mmc_dev(mmc), "failed to de-assert reset\n");
>         }
>
>         /* Get regulators and the supported OCR mask */
> --
> 2.31.1
>

Kind regards
Uffe
