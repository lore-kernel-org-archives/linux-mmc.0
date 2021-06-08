Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD2C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A496100A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhFHNS3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhFHNS2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:18:28 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5CC06178B
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 06:16:35 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c10so11559538uan.6
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=606SEYScY/4Dm3TG2zXGyFR6Ly8KOu4QIRdQzAVRtJ4=;
        b=Omj0OjhvQ++d98yJSdmaXOk1bHCbynHCXQlXQa4ETkUydcSD2yCZsQqwxh76dHd2EN
         NaWVtW1fj9h0vehRKFR5saruc/HSNNc/MPrxxWz/VBlEh3plbcCVVi7mLPc/cdtEMjy+
         E4WWkbPCIAG0+XNmMsGsEqTYJ8c3wLylpNI+N/iJb/Z5KHrVybXjVzqToRgJn3smF09b
         2HequXh1rPYIH1tSjlB9dVMVGB4wH39RIvNrK6DiaQSouBto3Qh+jBRfLayJKOyekeb8
         78E7x9hrCKxO4h4PJFuDyza3nuNy5exKSLnx8qPGVe4Glpd/4Qj0oQJR4JX72hBb4/lu
         rxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=606SEYScY/4Dm3TG2zXGyFR6Ly8KOu4QIRdQzAVRtJ4=;
        b=iwrAAf01DammpmCgIH9WlE1rJKJPgUgjgujLJq+JCt5SSC2jB+OqyoRIvSZ/lytTnn
         E/ARTzDPx42DMQA0pK9JUOPWWU7wwJPCh0pLztXWE/3Cnq22jL8Md5tG+cSmVGPue8R3
         UzbDtBJaZLSVTt56aED+uV0NFRuqhVZ0g7Zo48AWH+JmpnuIuF9mN2fywDqJw3pzVZPo
         ukYFnVYQSqSYl+yli/lclXsfZH4w93jFcR4ghoLNSaVeFUXaZEUn4FG7xeoF6rcZ1imY
         Znpz82DmnwNH9kA20xvwQCfDPTcyZ90s7OdpKhz+Nieyr4/0fmWX8ga/XatMEkSkwcV8
         /07Q==
X-Gm-Message-State: AOAM533qVtxUFOo2YMQ7jwPV2AY+6//ZMYj1yC3u8jGTIeWg/arFRp9W
        V1MnfAv7UD3sTzIwNFb93y9AYlj4JNEpdv+k16Z8Xg==
X-Google-Smtp-Source: ABdhPJz5aZwPNxnntAA8aRpvQS8xefc61/tur00rKpE7jf8yvD/K9Pq7D2dgwSTb802UwSLtR5tTYL3kwFEXhrF2Jjk=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr3216292uad.100.1623158194715;
 Tue, 08 Jun 2021 06:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210607013020.85885-1-andrew@aj.id.au>
In-Reply-To: <20210607013020.85885-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:15:57 +0200
Message-ID: <CAPDyKFrqKW9VwEga0bzY+H9Br57RbfXBnxJFP_-rWcfpic-0hA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Turn down a phase correction warning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Jun 2021 at 03:30, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The card timing and the bus frequency are not changed atomically with
> respect to calls to the set_clock() callback in the driver. The result
> is the driver sees a transient state where there's a mismatch between
> the two and thus the inputs to the phase correction calculation
> formula are garbage.
>
> Switch from dev_warn() to dev_dbg() to avoid noise in the normal case,
> though the change does make bad configurations less likely to be
> noticed.
>
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d001c51074a0..e4665a438ec5 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -150,7 +150,7 @@ static int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
>
>         tap = div_u64(phase_period_ps, prop_delay_ps);
>         if (tap > ASPEED_SDHCI_NR_TAPS) {
> -               dev_warn(dev,
> +               dev_dbg(dev,
>                          "Requested out of range phase tap %d for %d degrees of phase compensation at %luHz, clamping to tap %d\n",
>                          tap, phase_deg, rate_hz, ASPEED_SDHCI_NR_TAPS);
>                 tap = ASPEED_SDHCI_NR_TAPS;
> --
> 2.30.2
>
