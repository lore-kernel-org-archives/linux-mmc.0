Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEFBC43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E48218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/eZnyY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLROCE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:02:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45362 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfLROCE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:02:04 -0500
Received: by mail-vs1-f65.google.com with SMTP id b4so972971vsa.12
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbzvOAB9h8zPmYPnoKr818YJbnxD4Y4JMf6k4NJrTs4=;
        b=P/eZnyY6kzE0QPUrwXSTkAFwyqC+sw/d2uSUfcIdV6trKXr3TWDVAvmHDFgJ2zH0p1
         gOznHmJPSeXuU7Sp8H+miwvswqwphhMsqJoWVnBrXEsDDF6NJJ//YM+YTxxz+A+IUlX1
         yC2q19F3yAxPz2bYKO+34x+CoCgqEwkaUYu/34sNnCecXdOhWVDgWZFYSWEe9qWOCrgx
         z8PmGRuw9MPOIN+RdshMKInFxbQaksahyc2gtrCk6jlCjBCLOlkb33oL6QT5XWzws/OR
         N8ke64ZIkrnoMfzXa443GQZbFvxjLwjhH1NrkwkSeAY5sIV2+onMGghABuS/iCCIJYf3
         YxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbzvOAB9h8zPmYPnoKr818YJbnxD4Y4JMf6k4NJrTs4=;
        b=lg8irdb2diZ5iefJ611OldX06TlJjm600ZNqlNC2vDZKwKe2E5pejNy6EfsaQLkYp/
         ve+yacOeJ5TEBPsn4n1qG33t95gTvl3MJUhruWNQ9vZ5rruJtPhU8SIZZeLe02zVLd2h
         vhKk6LRwzKRyhDAH8d6W0tjGjk5iiai/1YLa7cAeb1xLkX2tVFv/rW9aRT05d+4fGFu6
         yqYVLJUwRxsmldXWzoDkZZhgF3rYllHzrSQzRbECNatDzhdiMFr9IiKsh2qtXdAErjXz
         jGOpNK8j9GXT/gQH0EKUusKwR0mxhgdIZTUur1wcwNJocsWNy3+wS03tU8AbOBolPr8A
         5Mtw==
X-Gm-Message-State: APjAAAVAJ9SSGqefS7MwvfhrMUivD9ZeGqPHW+JkiF6Hmq8ZUH5UuFC2
        WTlOHqLYVn40anw8RPvzmfQhBlvUrwlmE7t4iKAhCA==
X-Google-Smtp-Source: APXvYqxScyreBRYV+9Nc++M3+Voi1CbhmxmzpN5t+josPeSshD/Gi/DHw3r0wekBSzFFXOYxczxgB5UkCNo1A4Bb0xg=
X-Received: by 2002:a67:db8f:: with SMTP id f15mr1395917vsk.191.1576677723074;
 Wed, 18 Dec 2019 06:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20191216091911.14840-1-yangbo.lu@nxp.com>
In-Reply-To: <20191216091911.14840-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:27 +0100
Message-ID: <CAPDyKFqX+pqTPO4Omiy0htP=uWXV+fQ_ByS82WrQ3oO5-eq2rw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1088a
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Dec 2019 at 10:20, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The eSDHC on LS1088A platform uses 1/2 peripheral clock as base
> clock.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7f87a90..f43abcf 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1228,7 +1228,8 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>                  * 1/2 peripheral clock.
>                  */
>                 if (of_device_is_compatible(np, "fsl,ls1046a-esdhc") ||
> -                   of_device_is_compatible(np, "fsl,ls1028a-esdhc"))
> +                   of_device_is_compatible(np, "fsl,ls1028a-esdhc") ||
> +                   of_device_is_compatible(np, "fsl,ls1088a-esdhc"))
>                         esdhc->peripheral_clock = clk_get_rate(clk) / 2;
>                 else
>                         esdhc->peripheral_clock = clk_get_rate(clk);
> --
> 2.7.4
>
