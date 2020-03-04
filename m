Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA5C3F2D1
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC102465D
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xv6HyoXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCDPfF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:35:05 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46494 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgCDPfC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:35:02 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so1386586vso.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAKPYVBy5nTk/cPZ4EgDW5KETL/IwzTH9cPdf1LQtMM=;
        b=xv6HyoXW4FNIbl08dEeA8MQZNrPCSOQhUDCR3n6dBGwwJfdiRhQ4XIFPjARMMp1iw4
         MqPJxvA/xQ8kUk3C1TCAM1xV/O4jq072jV4HDJZ4RcLzPkdLD7yrbHi/o8VXJNVS2A8J
         8SFVUhR2PMCr8pa2B4cvp42EeuYq0a5cIKzFQGYSrPJArB20fNH22GA9FUSMBJgYVIsn
         u+/p225AAuoMfHp5CKqqO4KN6a6XM+4AH/rZRPtowviLQZDyP6HPI1nzijsAvBIeUXeQ
         AQkk0F2X9RvL00DSKP8KIm+v/4nE15edKZ2x4gAuPoXdFiF1bxgAeqbRXd/PuEeKmdYV
         KGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAKPYVBy5nTk/cPZ4EgDW5KETL/IwzTH9cPdf1LQtMM=;
        b=Wx9HwkWHk6CBTpAJIraBK8BlvQXnJsucT2ao82k2Z3c7fbcGsXq+7Vafu6ix0OZVJg
         n19E727Mle0LNgQ+NMAf3jGl1uFSwbOSz9up/9We/sYMaebsn+P1HVriehlXCIiGcEPM
         jBr/L4tLP4+wMWIF+1TfGsbPDQ8Y7/IllEfyIgaTghwdq2q4YCs7DOUs1p5/J04G7J1v
         Xpzymw5BCbQW+Z4WR77OUtQ5TtKbLsGNOStaHVtv+TqJBH6qUAEvCICiZfCXhxqoBazn
         5ane4qnK6shhM3mmWWUPNJu9uTf7nZUrLEiZCwmkMwYv6hlrH4hwLaRGGNZbXXfj5XMl
         4xmw==
X-Gm-Message-State: ANhLgQ31s5TypPiylUwZS7wsyCI8nFhiK0hbbvB62eXH+uOvVe+X7aH0
        rqiup8wxLTdRhN8MntKpSFn28XZ3YJPbfT0/Y9+jYk6N
X-Google-Smtp-Source: ADFU+vsYePhlDmldCNrVHiaTRXfzlF+dKqrIdGTwMyRel6BDOhduDMJ4zk2YAA2rpLdztl2kVGJbC+BAujM7T0swYDo=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr1987651vsa.35.1583336101613;
 Wed, 04 Mar 2020 07:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20200219210730.27640-1-jeff.dagenais@gmail.com>
In-Reply-To: <20200219210730.27640-1-jeff.dagenais@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:25 +0100
Message-ID: <CAPDyKFr41yuESMuoKF_KUSW4sP_cZxzjW4gKMv_0ShtoEOmS3A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: make sure SDHCI_CLOCK_CARD_EN bit sticks
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Feb 2020 at 22:07, Jean-Francois Dagenais
<jeff.dagenais@gmail.com> wrote:
>
> Regardless of the broken-cd quirk, when it silently doesn't stick,
> no clock is applied to the bus lines, yet the code continues to
> try to make CMDs and times out after 10 seconds for each. This
> process can take up to a minute as mmc_rescan_try_freq tries the
> different commands to discover the card.
>
> Short of changing sdhci_enable_clk's signature chain in all
> dependent drivers, at least provide a hint that this might be the
> problem. This will save tons of time for system integrators.
>
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

The change looks reasonable to me. However I would like to get an ack
by Adrian before applying, as I may not have thought of all the
consequences this change may have.

Kind regards
Uffe


> ---
> Changes in v2:
>  * removed redundant wmb()
> ---
>  drivers/mmc/host/sdhci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 63db84481dff..42a02d034fda 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1894,6 +1894,20 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>
>         clk |= SDHCI_CLOCK_CARD_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if (clk & SDHCI_CLOCK_CARD_EN)
> +               return;
> +
> +       /* The controller will clear this bit if card absent condition is
> +        * detected. If card is indeed present, check platform configuration for
> +        * how CD is reported to the SDHCI host controller. There may be an
> +        * "assume present" mechanism in the platform registers, or your pin mux
> +        * may be incorrect.
> +        */
> +       pr_err("%s: SDHCI_CLOCK_CARD_EN bit did not stick. Card absent?\n",
> +               mmc_hostname(host->mmc));
> +       sdhci_dumpregs(host);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_clk);
>
> --
> 2.25.0
>
