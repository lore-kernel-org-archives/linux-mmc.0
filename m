Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E4C433E3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49E22087D
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tyi4ZHVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgHXJwG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgHXJv3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:29 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4CC061573
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:28 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id o2so1826699vkn.9
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hW+1aw5Oeh6pgOwck0y4yo/HRz1hOBxqvF5QhQOhfA=;
        b=Tyi4ZHVVjVzwqW9yZS2CGb5VIFwkQ4QTO47BzShFY9qAaUl7/0Tb/z8UOLqYQYxFQ3
         NWKzwyU9iDMKu2lo8rVy0o23kY2MFRYzaoJv6WiIjd6o2psu24GN82nPCBKWX/tWJMRO
         PpKGMTl72L8ogYEtjkL0Z+eH1qfs3L6BbIBcSX7k8w3NLAtN7iFmn0ST2BMMqZ0uuBpr
         SkVRJ9fDkNYyzC6d5Kb9eqkxzXzZvVHtU7tpelDyM15z2+mqHUUf6wmbt7WNy7DDhoNj
         FIYA9Irkgdb7oUWHK+I5dDAh7OTjagIIkHR9dcYWKDkVkmxGA2eEldPw0KGgJKBDN9du
         gYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hW+1aw5Oeh6pgOwck0y4yo/HRz1hOBxqvF5QhQOhfA=;
        b=rpOUI9LTw+JICCkIvC4kYwPSnDsvDq1Vkyp/H3Yblnh3osZw7r9d1Ec+LFP78UAEc2
         G1yo0dCE9PFK2XAh6gmNFLTlr057wDQrRzgTQbLqfU73lD8ZZNEVru0t0W0AOGdUFbr7
         38cEbCFuJfx5vEhxahvCha4d81ObATw8gYHS+t5Jbe1rAQQXo7fH4Gr0hptadex2tOeP
         uUrPXIc7BBX/WdWPaWpHmLasUpkXOTcqhVbvm1wTbLwtrcSA7MKtuTfE50Pr25hv80EB
         ZTDiEMzPJ5M2xRxixcrGb4Gjb/f0eLHS0lEutF17tvhcXPy2NeR03qkvuA9F8XGP036r
         p0VA==
X-Gm-Message-State: AOAM533s9DULOZY53VtUHHU/6VsPk/ffp13eb7unPXYKQqGKSxU7GxMA
        guqwXyKIy0VAgX7fjBjiSUsK+n8wK8JU8M9HE+u0fBByYOZVuw==
X-Google-Smtp-Source: ABdhPJwXWApawg9i+eOmnZgucXcp/gc+rjQ1KDPLPjawInjvQEnTiAThjuEQkek7/NLrzTZjrx+U7ZCQM0btQNcqieI=
X-Received: by 2002:a1f:9d85:: with SMTP id g127mr1986688vke.101.1598262687548;
 Mon, 24 Aug 2020 02:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200814185011.3252020-1-t.schramm@manjaro.org>
In-Reply-To: <20200814185011.3252020-1-t.schramm@manjaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:50:51 +0200
Message-ID: <CAPDyKFoLV1bKSmEfthoLsJR76Mdb2dbdGC2y6vNYAKE2u6YAaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: fix timeout calculation
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Aug 2020 at 20:50, Tobias Schramm <t.schramm@manjaro.org> wrote:
>
> Previously the cycle timeout was converted to a microsecond value but
> then incorrectly treated as a nanosecond timeout. This patch changes
> the code to convert both the nanosecond timeout and the cycle timeout
> to a microsecond value and use that directly.
>
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 39bb1e30c2d7..f85e0ad896a9 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -882,9 +882,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         else
>                 clock_rate = spi->max_speed_hz;
>
> -       timeout = data->timeout_ns +
> +       timeout = data->timeout_ns / 1000 +
>                   data->timeout_clks * 1000000 / clock_rate;
> -       timeout = usecs_to_jiffies((unsigned int)(timeout / 1000)) + 1;
> +       timeout = usecs_to_jiffies((unsigned int)timeout) + 1;
>
>         /* Handle scatterlist segments one at a time, with synch for
>          * each 512-byte block
> --
> 2.28.0
>
