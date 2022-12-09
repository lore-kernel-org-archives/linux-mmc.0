Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D85C4167B
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Dec 2022 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLIJbe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLIJbe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2022 04:31:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C95955A96
        for <linux-mmc@vger.kernel.org>; Fri,  9 Dec 2022 01:31:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so7516611pje.5
        for <linux-mmc@vger.kernel.org>; Fri, 09 Dec 2022 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FnCXrrIbp7jPgWc1kp96LfASpdYMLa403vqSppawnNo=;
        b=mFq5sb5mJpP5bHmwdYC+vWEPnlhNMXm1xU/q4p6bgHoHBfopVu00xljT5Nrrmhlio0
         702CHzUHXiJu2RXzgBD/C65kDPDgZKCawbXmhTRQYVUyV5+T4ItLqmCriCdeKbAdZPO0
         XF80NWWTM8QY68P3HjnS4C1p/OfJ17KPdMHw3IchAp+/H7p9e0gWHhh131DWenIRMhaX
         RM+6yg3eybX8LCEnx1ugt+y4PcJNHskWxcisrg0M0p05nqAOkxdIx3xc7oPRqjGyEnXY
         ufpquj++vwoYVxbJkg4LMlWqQQugm/98XhsvvoBfUxP7ISH09KP4ZTWXUoEb6XYO9mZm
         MyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnCXrrIbp7jPgWc1kp96LfASpdYMLa403vqSppawnNo=;
        b=hfE34VWLssH7Q8owC0rtcGXwiIJX566bbG4TAjbJnXuwNsTflQVkCtASI4Y1XH9obD
         Gp3EChlaldzW3+vZT9oTo2h19zlFauOOB+aa7xzIokWtrksK8lHTGawPW4jhQ719QRGn
         GcU+6demgL2hLlJ9GefKe9tg8fHu4Sf6h7oEVAs9F6rroOaDvrEczsxDvk9dsohkt3DH
         9EP6pwzz9vLKfAPHrf170L5u+9qq59MZXthrChIJ5FfU2ARoB4aZW39tSt2zjFOiCxat
         x8mEGgZKJ2g5OCnDkdh1uuwYZzg9Dvu9uzUj4psnSKE+2FlxbDmgH2itEMRDE9UMV8bQ
         FGSg==
X-Gm-Message-State: ANoB5pnOZ6v3nT48M5EwdQucxImDLw4mIH8/nn2JRKcTpCNZWMZVy0ai
        GsWGcTzY4bjaZvcwXUqgHeyMe4/ngKH3KA4XggqR7A==
X-Google-Smtp-Source: AA0mqf7H9hjPq6c0t0+6RxhdrNLF+NbMazljfHFsFnfFrWRbagm2uO+4AVR/HnNIMJ2i0V4+T5ysJUEr981Gvqvu0gY=
X-Received: by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with SMTP id
 r33-20020a17090a43a400b002191d0a34a6mr5804202pjg.1.1670578292579; Fri, 09 Dec
 2022 01:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221209034134.38477-1-jiapeng.chong@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Dec 2022 10:30:55 +0100
Message-ID: <CAPDyKFqtfnbx0vTVtiD7sbG0tOh8L0U0vOMjOvm_ERPNNBGYDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Modify mismatched function name
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Dec 2022 at 04:41, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/mmc/host/sdhci-of-esdhc.c:243: warning: expecting prototype for _fixup(). Prototype was for esdhc_writel_fixup() instead.
> drivers/mmc/host/sdhci-of-esdhc.c:117: warning: expecting prototype for _fixup(). Prototype was for esdhc_readl_fixup() instead.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3397
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 9d875bb531a8..4712adac7f7c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -98,7 +98,7 @@ struct sdhci_esdhc {
>  };
>
>  /**
> - * esdhc_read*_fixup - Fixup the value read from incompatible eSDHC register
> + * esdhc_readl_fixup - Fixup the value read from incompatible eSDHC register
>   *                    to make it compatible with SD spec.
>   *
>   * @host: pointer to sdhci_host
> @@ -223,7 +223,7 @@ static u8 esdhc_readb_fixup(struct sdhci_host *host,
>  }
>
>  /**
> - * esdhc_write*_fixup - Fixup the SD spec register value so that it could be
> + * esdhc_writel_fixup - Fixup the SD spec register value so that it could be
>   *                     written into eSDHC register.
>   *
>   * @host: pointer to sdhci_host
> --
> 2.20.1.7.g153144c
>
