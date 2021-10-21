Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BF5C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4960561251
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJUTvp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhJUTvp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 15:51:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A304C061764
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:49:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o11so119811ljg.10
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Opei2my2zsRhGEYmSTuquQHbuG/tOHt/W/ohA+sBkZU=;
        b=J56pn8v/zCspqN41ZGEwIT56+31lMkBdJrZdcQLtgO9PhvQz6MeiFi7kH1eEiMGXjo
         4b51gujd75zM4NgVtCt8cJ5xgwsmTIE/6D2iUJM9MNVLTr8A4FyqbCglFi5RlvB8sZ+x
         fGEo7bkxnv35B1qsE7FtZhmIUvXlDBjZmQqr3qrzG9yitRfUjRivRSX90/W5FksMs6FE
         dLjygk54GGFjoHNzPqjObnxCZCGCL1Ftj6shrlmL8I8gZ69aBFmdWuoC/n6QrJZVcOmT
         G36icUoXHyNCMLJN97Vkgz0JoMq5ITrHeTJWng356HwZHZqyw9dyhgtVoHJGSrWg5PTn
         XddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Opei2my2zsRhGEYmSTuquQHbuG/tOHt/W/ohA+sBkZU=;
        b=MYVRgCecBWHdX7EG+l0NNRswLMdNw5FibY/N2IdeYclxbi1phncLjs+z8wFuMk4lEN
         T/WoeWy1btP+J+qIwLKE0Xon+N6MCA2s3jzA5on5bF08D+pXTdtgbTGfhPP8a3Cmsiox
         ArMqOiFUkcHY78rveAFbVBxsPpMj3EUEMXt32BV+qD+vLH1wnuKlVw/uLsq0a/FwrXZx
         FhlJzOR7IGjZba3zBY1xHFUSIVWdcUHNizOO4k1Vsg1xq0gHONGFLcTx2IkjVhgxPi2V
         uqzriJdGsKvuE7G7wIOJ8A2U6ztEcAmM+rWp1h06Py1sHDIxKqXEinwvsfpfe66mGZrA
         dk5g==
X-Gm-Message-State: AOAM533BUrSktiQbxSzWvLwQgIvAf03nPkrwbaNKcCto8gu7G5Uxs0yy
        wfyf2Qm+qPlGKaqTPM884mw02KsIkwgiyavhhVT9XQ==
X-Google-Smtp-Source: ABdhPJzsohCOTx1G/FZllZ3uAchcRkiXF3/8ioX8Pv2kx2U1CnAV7vzxiVyXFXeanMWMJgtKKvvkklbYWWpHXH5LLpw=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr8206076ljj.4.1634845767028;
 Thu, 21 Oct 2021 12:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211020083902.3669769-1-geert@linux-m68k.org>
In-Reply-To: <20211020083902.3669769-1-geert@linux-m68k.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 21:48:50 +0200
Message-ID: <CAPDyKFouV9C2VrGwB1u5iQ5g5m2i9nmKBZMQg1z5m6t9QY5wAQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-omap: Remove forward declaration of sdhci_omap_context_save()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Oct 2021 at 11:05, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> If CONFIG_PM_SLEEP=3Dn:
>
>     drivers/mmc/host/sdhci-omap.c:1213:13: error: =E2=80=98sdhci_omap_con=
text_save=E2=80=99 declared =E2=80=98static=E2=80=99 but never defined [-We=
rror=3Dunused-function]
>      1213 | static void sdhci_omap_context_save(struct sdhci_omap_host *o=
map_host);
>           |             ^~~~~~~~~~~~~~~~~~~~~~~
>
> The referenced commit added an unrelated forward declaration of
> sdhci_omap_context_save(), which is unneeded in general, and unused when
> CONFIG_PM_SLEEP=3Dn.
>
> Fixes: f433e8aac6b94218 ("mmc: sdhci-omap: Implement PM runtime functions=
")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.=
c
> index 0dec2f849b81e242..a4a1734dcb84e9cf 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1210,8 +1210,6 @@ static const struct soc_device_attribute sdhci_omap=
_soc_devices[] =3D {
>         }
>  };
>
> -static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host);
> -
>  static int sdhci_omap_probe(struct platform_device *pdev)
>  {
>         int ret;
> --
> 2.25.1
>
