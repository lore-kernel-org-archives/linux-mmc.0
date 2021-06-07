Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564AC47082
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 04:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5BF60FE7
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Jun 2021 04:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFGEOb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Jun 2021 00:14:31 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40949 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGEOb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2021 00:14:31 -0400
Received: by mail-qk1-f179.google.com with SMTP id u30so15440480qke.7;
        Sun, 06 Jun 2021 21:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbR25Ey1jYTS5sXaXKkm7NsaVYIVVD2EtITwUZt+jv4=;
        b=eKsNiSwDdQrxODDTUtuA3Uy1ZOpjV0TNA6OQVCt8it1vcmDzH4pXSHCslNNVdqQs6H
         gtXvbWVWqX3fhQ1IQVbXQICfR06Wd1oOm/RbPoR3y5haOeOC1BV0Wc7q6mzp77VZxTyJ
         G/XG14v1FeXw9YdIv+tixboAv/PzlMASCV8FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbR25Ey1jYTS5sXaXKkm7NsaVYIVVD2EtITwUZt+jv4=;
        b=h1ayn6HKQOF5BTD6K8n3PgO93OHaSuob51uUPCueVbB0mcIfMbDNoQqanDD3Ukzsh2
         VVgkg0iuVZWBuNisWOM4fOnL3TQQoLg/2TY1dralCwz2JOiGZTcTNnXntAa5Ms+5zZs7
         h5tloEh6zDKamE7c2pkGnh6FE/7EAjl6d0a8n/ZLj1SKQwX17YM2y7pAdtmxuukzIUE0
         CmFW2QRE4WtJar9Hphz658paLKiiEOQxibRwxrtLRTDouY5WCw0wzmmHnmuTKdA2pOKb
         NvgfZEB8OkreWstmhEAw8958wXgqDzTmoeZ20kD2I3FoV7eDWU0KTatC3ADbRy6Sacr2
         JKdQ==
X-Gm-Message-State: AOAM530rMyJ3/NVOVJdOOeQ2lFi3fePJ3InRsDb9oG4aO+TjRpcLl/c6
        dsBZwKM1ET+dDqxcTqa3iqx/Bolk+yrNpqacYIY9fkfd
X-Google-Smtp-Source: ABdhPJww3/VFgYyaDmLGX7xYSKpphZ34RO5B4B8KHOZzHIN6EN/Za5WTmJybfY+OvXChMMKumHsWj9EEfDRLcB/9Xp0=
X-Received: by 2002:a37:b404:: with SMTP id d4mr3459096qkf.465.1623039100241;
 Sun, 06 Jun 2021 21:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210607013020.85885-1-andrew@aj.id.au>
In-Reply-To: <20210607013020.85885-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 7 Jun 2021 04:11:28 +0000
Message-ID: <CACPK8Xc1hKarizpPAWNmx1sHrPTuak0hhwZ4ZO09+iMSR+cmiA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Turn down a phase correction warning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Lee <steven_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Jun 2021 at 01:30, Andrew Jeffery <andrew@aj.id.au> wrote:
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

Reviewed-by: Joel Stanley <joel@jms.id.au>

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
