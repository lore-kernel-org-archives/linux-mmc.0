Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF7C77B77
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDQNYI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjDQNYH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 09:24:07 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597A5247
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 06:24:03 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-552fb3c2bb7so8633057b3.10
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681737843; x=1684329843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wJNyJPIUSDACJNhaYaxkNKlMJ6+KOJnTklHWTfRcUSc=;
        b=JazabgTFJ+Kl/tyHV0m4uvxo0dgvefjHFgd4Qm3zlxF67Ul+05N+zsE3lVeOiwWSQM
         /vFeRZ9w9+3liGCV/t5MSS8Pgq//i6FkxagdTxYzhnS6AxWxE7tey7HZ/AfEyp4siZkb
         kovypUxnbHJFC1HGeF8kZbQD57K/YWaxg8VIdEHaGoaqtX7StctEYDqAH86A9+OuN+kv
         0ULe0cWHoCvpg+TLVHkhMh3Yn9g85u6Y7p6w+qUw5TxQfeVZaKF3SewPkk7Kdgt0oeYq
         odHfHPgS/NVQDAWoPzTNl8E88F3r2ybQpLkWsnoBXEkC+Jk++p2kWP41zHXYQREXnCb7
         /LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737843; x=1684329843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJNyJPIUSDACJNhaYaxkNKlMJ6+KOJnTklHWTfRcUSc=;
        b=Pepd44NC2NwSOmZ0/W8PhGyn4DZVykzdbMgVAU4fg4FFrbh589pfLxkUh7iKh6V9vF
         7qqcltatDInRjyyv3kKFWKUE01H9oinVqP27ArKVfDCt2LaZDRkPgdIkBQ24m3vOJlLp
         RSRMynUXZduWTv3EJPuMCTUNKlC+ET9h+sExjQybaDIprXbh5C26s7AEy9/tgqBBz5qB
         dxGOwjpU7nHZasI3eaPWOLfHkkBz9XSRzqe9Kt/h0NtAXddFqwBSL1wUkgiYo0GhvRkF
         dHgxzeVM9nP2HYtwxsJMjur+ooJYFsIiC+z1FX1waOUMSJh+MGrftqXcb6JtUcnpe4cG
         jngw==
X-Gm-Message-State: AAQBX9fL/JREVlm7U0hrXq5l6V5ywPMUzrltznFVOwI9kvue6ed76jts
        fgBA3ICZrvlrqd9MwDS8u5Obn5AY9iXFvmSjSYSGSg==
X-Google-Smtp-Source: AKy350akHhPmT1SpV4BNvSOxnEib1lHDILTXdM8MTdKIigFYFej6SdgGNMuPOotcFSth7yw6bGwLlc1XsXt87XMgGdE=
X-Received: by 2002:a81:ad45:0:b0:546:63a:6e23 with SMTP id
 l5-20020a81ad45000000b00546063a6e23mr9408216ywk.0.1681737842732; Mon, 17 Apr
 2023 06:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org> <20230405-pl180-busydetect-fix-v2-4-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-4-eeb10323b546@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 15:23:26 +0200
Message-ID: <CAPDyKFpoboq68_ysEJXCWLV8k77+ULGpF6AzcnjvUqO96r5FHw@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] mmc: mmci: Break out error check in busy detect
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 9 Apr 2023 at 00:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The busy detect callback for Ux500 checks for an error
> in the status in the first if() clause. The only practical
> reason is that if an error occurs, the if()-clause is not
> executed, and the code falls through to the last
> if()-clause if (host->busy_status) which will clear and
> disable the irq. Make this explicit instead: it is easier
> to read.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - No changes
> ---
>  drivers/mmc/host/mmci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e742dedaca1a..7d42625f2356 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -665,6 +665,15 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>  {
>         void __iomem *base = host->base;
>
> +       if (status & err_msk) {
> +               /* Stop any ongoing busy detection if an error occurs */
> +               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +               writel(readl(base + MMCIMASK0) &
> +                      ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +               host->busy_status = 0;
> +               return true;

I agree that this makes the code more explicit, but unfortunately it
also means duplicating the code from the bottom of this function.

Can you instead add a helper function and call it from here and from
the part at the bottom?

> +       }
> +
>         /*
>          * Before unmasking for the busy end IRQ, confirm that the
>          * command was sent successfully. To keep track of having a
> @@ -678,7 +687,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * while, to allow it to be set, but tests indicates that it
>          * isn't needed.
>          */
> -       if (!host->busy_status && !(status & err_msk)) {
> +       if (!host->busy_status) {
>                 status = readl(base + MMCISTATUS);
>                 if (status & host->variant->busy_detect_flag) {
>                         writel(readl(base + MMCIMASK0) |
>

Kind regards
Uffe
