Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBCBC33CB8
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726D421569
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsnB8D9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgATL02 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:26:28 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37915 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATL02 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 06:26:28 -0500
Received: by mail-vs1-f66.google.com with SMTP id v12so18728044vsv.5
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 03:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I7p0DYe3E0c2Sb2O38eIk7h2VsJf4W1B5fNXeVb4RU=;
        b=hsnB8D9bQesYBIDfXaf3zegOKSq50RI1ZKvwor+1gXR+cAw0WugFZC5IoeiSqTGWM5
         4OD7RBdlJvxZqGplbxnYUnBNoQCBErhk9nbVeGjaMxJiR8wSG/Sykw7feUMcQ3onRkfI
         JbGaLnPjZyN4/uf34q2O2wmjutExgB4axIYiGfYi8aEp0wvOZm7/T9Ay4KGSK2Jfct/0
         sXU1XlxayukjqHQsUY8dWbySA/SoT53ffhMPE+RsK6P9hFHwJ0dj1jf7G3IoTaZNZmig
         1YBpbgY294/wPaqTNmbzKRTwJ/CtiUTKdKQn398rGFoTz/eD2mEmtjbCbbPZIsFYda9e
         Bx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I7p0DYe3E0c2Sb2O38eIk7h2VsJf4W1B5fNXeVb4RU=;
        b=NmPky/j7GDfh7g03LZ/bcvPiX1vvSHka+Td7/kH6eo+TIJJMrvRf3plLXZgicnnbv+
         ekiLzB1/60NZRfMpAw5ZozAbZ1t7lLqJet8nSOpvZul7NU4BBK8JUkpzZSlaIJCgm4Ia
         nAhk27yhbptTxf9negl1Sm2B/xdnfxI3atk57IQHOXoTDaYYSyfHBeQJocA2sCVgOZVV
         yPtrll1aOoBtqg8IbTWmKnN3p/xJcZSWNRFiTNTtZFAbFnFXE5CBX1CuRDmxz1br6ZJX
         Y9Fc5sNu38yDy0lKv3unrFJ7wDFQKxhxkxJhZy58P2koDaZPnysXRxakUuM7vlnAOOzy
         pOng==
X-Gm-Message-State: APjAAAUrJLJGUiptS/wSGMAwamWymYrSW3FjMperIGOoiKJCzH1XAG6M
        lM9T9l5gfJ1E4OdYJZgHHpDJCNoSC0C8440cACb6lDrr
X-Google-Smtp-Source: APXvYqyHnxm1pa/shIOsEJ79faDatRSy6U6QXbX2srpmekxmDaXSgoQFzoSofg+n+6M3s+0MjXHITNuQ9v3BQMwC4lo=
X-Received: by 2002:a67:e9da:: with SMTP id q26mr12060879vso.34.1579519586942;
 Mon, 20 Jan 2020 03:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20200117063858.37296-1-yangbo.lu@nxp.com>
In-Reply-To: <20200117063858.37296-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:51 +0100
Message-ID: <CAPDyKFrgY5u7hU1Bueujh4DjS8X5Vbutn6dMo3gX2Dfq6r1wYQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fix transfer mode register reading
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Jan 2020 at 07:41, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The standard SD controller uses two 16-bit registers for
> command sending.
> 0xC: Transfer Mode Register
> 0xE: Command Register
>
> But the eSDHC controller uses one 32-bit register instead.
> 0xC: XFERTYPE
>
> For Transfer Mode Register and Command Register writing,
> the eSDHC driver will store Transfer Mode Register value in
> a variable first. When Command Register writing happens,
> driver will directly write a 32-bit value into XFERTYPE
> register.
>
> But for Transfer Mode Register reading, driver just returns
> a actual value. This may cause issue for some read-modify-write
> operations. We should make both reading and write on that variable
> for Transfer Mode Register.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8c06017..3ef4973 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -173,6 +173,9 @@ static u16 esdhc_readw_fixup(struct sdhci_host *host,
>         u16 ret;
>         int shift = (spec_reg & 0x2) * 8;
>
> +       if (spec_reg == SDHCI_TRANSFER_MODE)
> +               return pltfm_host->xfer_mode_shadow;
> +
>         if (spec_reg == SDHCI_HOST_VERSION)
>                 ret = value & 0xffff;
>         else
> --
> 2.7.4
>
