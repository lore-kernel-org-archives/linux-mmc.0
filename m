Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9523EC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C90610C8
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhKHPhP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbhKHPhO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 10:37:14 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3923DC061570
        for <linux-mmc@vger.kernel.org>; Mon,  8 Nov 2021 07:34:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id v15so23158343ljc.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2021 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cDX8QQKKuew+Ja0r9BHR27VcwBnv9KU+20lUo/z16s=;
        b=vTIb+xtH+3s+MEgysej6qyoxnPGY2brtJoQYxCc+bVniRkUxKGnhRSYHZB17wtiSJs
         u9nI/Ot0lCij1fZK3CD2GLJq80wHqDJd5zO1aI8+Vb6dcv1BhTE+T6VrnHvcuWe1ENz/
         T6Bd3+wI+qD3VSzBJlSwZP+ZDU3RV+IYaVQeZY2WJ7TSHEVdKSZIH/hjb3NjBs4AM/Ic
         8jm9NyL+YinBrCYe01bswYW5BLxQ+tWpbVNYNTNagbJk0Uhv25zjX4rhMA0T7m5EgFdQ
         mAXOw+Ua2Nu85Lr/+ejzJjiLx/FxkjkbhDREGW7EhXcIKF1Pq5jZO+M00TFE2TzVSl17
         4nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cDX8QQKKuew+Ja0r9BHR27VcwBnv9KU+20lUo/z16s=;
        b=NX3UvMuCmdGlzFSZX9jDHkVei7XtnkD2x0hXHTkhsPfAx2PxX65da0CiqbZGcy6qjB
         FQdM9oNHvVYzCewKNeETYKeGbi2yzrXQiFJYRszfzZ3VpEhpjw2SM6q1wezWyfnftu5u
         aphHILycE33JbrV5URyet40gB+W7F4B01WtAGkWpr/82uSyPi/J6REyMzbMi+/Rx1xhj
         7mSh8+qbNZMbqzspk0tpCcYO7uiRjFnvStrDKv5HQiRsf9wFFDkVcbGkFm41LVHOPAnW
         L/sttjLZ8S0QTRpmPirEEOgy3pcNC+yG+u013HcpLJl8WfEuNMZgw9qW6EM0DRakYriK
         fHow==
X-Gm-Message-State: AOAM530t3tefwLflfngHExdyXSN3QxYt0dvVtaRTKBBSLSA91/gfXdBx
        bJbP8aVOW8XcLDRFnGdEV8xvnW5+fK9K6VWMWuF8EA==
X-Google-Smtp-Source: ABdhPJxBiS1rbinnfjfB/9eJv3en2gWlCsLABdEuSnSjFOgI02JAw2OpEI67E5RX+kiIK3+bYe4b3wxA7zuIM2GVqMU=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr541754ljp.367.1636385668612;
 Mon, 08 Nov 2021 07:34:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636103151.git.hns@goldelico.com> <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
In-Reply-To: <3ca9a3099d86d631235b6c03ae260bc581cc8d60.1636103151.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Nov 2021 16:33:52 +0100
Message-ID: <CAPDyKFrH8f80cs5dbh=3ugjyEzoUYXhStpHQyhUSd6b9wD78vw@mail.gmail.com>
Subject: Re: [RFC v4 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 5 Nov 2021 at 10:06, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> The TiWi WL1251 WiFi chip needs special setup of the sdio
> interface before it can be probed.
>
> So far, this is done in omap_hsmmc_init_card() in omap_hsmmc.c
> which makes it useable only if connected to omap devices
> which use the omap_hsmmc. The OpenPandora is the most promient
> example.
>
> There are plans to switch to a newer sdhci-omap driver and
> retire omap_hsmmc. Hence this quirk must be reworked or moved
> somewhere else. Ideally to some location that is not dependent
> on the specific SoC mmc host driver.
>
> This is achieved by the new mmc_fixup_device() option introduced
> by ("mmc: allow to match the device tree to apply quirks") to match
> through device tree compatible string.
>
> This quirk will be called early right after where host->ops->init_card()
> and thus omap_hsmmc_init_card() was previously called.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/mmc/core/card.h   | 19 +++++++++++++++++++
>  drivers/mmc/core/quirks.h |  7 +++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 089ede71d3150..20c8dfd6831cf 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -168,6 +168,25 @@ static inline void __maybe_unused add_limit_rate_quirk(struct mmc_card *card,
>         card->quirk_max_rate = data;
>  }
>
> +static inline void __maybe_unused wl1251_quirk(struct mmc_card *card,
> +                                              int data)
> +{
> +       /*
> +        * We have TI wl1251 attached to this mmc. Pass this
> +        * information to the SDIO core because it can't be
> +        * probed by normal methods.
> +        */
> +
> +       dev_info(card->host->parent, "found wl1251\n");
> +       card->quirks |= MMC_QUIRK_NONSTD_SDIO;
> +       card->cccr.wide_bus = 1;
> +       card->cis.vendor = 0x104c;
> +       card->cis.device = 0x9066;
> +       card->cis.blksize = 512;
> +       card->cis.max_dtr = 24000000;
> +       card->ocr = 0x80;

In the past, we discussed a bit around why card->ocr needs to be set here.

The reason could very well be that the DTS file is specifying the
vmmc-supply with 1.8V fixed regulator, which seems wrong to me.

I would be very interested to know if we would change
"regulator-min|max-microvolt" of the regulator in the DTS, into
somewhere in between 2700000-3600000 (2.7-3.6V) - and see if that
allows us to drop the assignment of "card->ocr =  0x80;" above. Would
you mind doing some tests for this?

If that works, we should add some comments about it above, I think.

> +}
> +
>  /*
>   * Quirk add/remove for MMC products.
>   */
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 41c418527199c..e9813f1f8b23c 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -146,7 +146,14 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
>         END_FIXUP
>  };
>
> +static const char *__maybe_unused wl1251_compatible_list[] = {
> +       "ti,wl1251",
> +       NULL
> +};
> +
>  static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
> +       SDIO_FIXUP_COMPATIBLE(wl1251_compatible_list, wl1251_quirk, 0),
> +
>         END_FIXUP
>  };
>

Kind regards
Uffe
