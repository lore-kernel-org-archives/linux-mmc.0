Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC3C4743D
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC56761249
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhFHNTA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhFHNS7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:18:59 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB0C061787
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 06:16:50 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 68so11541410uao.11
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sO61Fkn/5IZX7W/Hmal8+XrneLbVYOvRH8YqKEmick=;
        b=u5X7PMHHxL3yE7d6dDQP52QGHBPyUln/TF1+tYPm7hIJV5NS/siaFMa+EJvG5B6SUv
         9uWqqz1mLMoL9FiF0M8alQtkXuCYj7Ak4B2NjW8L2fZ5fthcJdI0alkX2JaQ8hpFBuCd
         roWb/7b6b5KtalM2aHBlCnUP1FjtpZmC6P4lfu8fOUKqmTZfCxGHCySaGXM6SLN9l1ov
         KY7RdtDwBuhsCYifz5RpCYX9ZA3cxGRvFdocWq971svs+ClMMn5A3kurizygj9cVYJME
         wcbdjgJ5cDNYoTZnyddLArCEAJ/k0jDU4lztqSKQPjnUH8hZ2Z9GdI7ZLNQD/hlvJ63c
         hR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sO61Fkn/5IZX7W/Hmal8+XrneLbVYOvRH8YqKEmick=;
        b=J6yLKO5pmiVLFcXV1v5cI8kQauPlbjrupaBM53BUrKQ/kSarGkxtHNWxFyMkgd8i7d
         ej4i85wfSb+4J/nQp7AsUeksMn4fpmFSKbuYa2+RKbXfQi3kLyo0ZO2dYQgjaFEELtqA
         ZSMlqcbK5RfZSMQDjV/ZEpglWAevbHmVbf8yTbPrV7mvGXA4/KBwoQziyHyOsxaWQZkS
         E4qyhGidL4KybYcWM9IbDBbxJFLHh389d+WjZPndbWasISk3VDZBRJu9E3MRYjj92J6+
         hfF23a+ZulylY1SJhg4TvvSJUR52/KMIRS89W+xYIaixG2SVLI8NIj1wjn0U3jORTmbB
         i/kw==
X-Gm-Message-State: AOAM532H+qKGIIkL8/m4YDJ1nXyJY19motf+3WwzyrFhdMroEsWL9ztF
        2fxLFFmV/PPjTjh0GyUCzTDpVKC1YB8LJUleLEso87kifl4nbg==
X-Google-Smtp-Source: ABdhPJxbw2jKLpHRrw+vUe65U9pKZtC9zHtDLfFBHJxqmwFLCCreieH+pOXs86lypO+JJcM7bCuwjtDO0H6EO9ZZjVU=
X-Received: by 2002:ab0:d8f:: with SMTP id i15mr12633857uak.104.1623158209542;
 Tue, 08 Jun 2021 06:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210602073435.5955-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210602073435.5955-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:12 +0200
Message-ID: <CAPDyKFo0jP-0yZd-89J7v4xdcBnH5H5yGa_s4a-hw=mkHxOrxg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: abort tuning when timeout detected
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Jun 2021 at 09:34, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> We have to bring the eMMC from sending-data state back to transfer state
> once we detected a CRC error (timeout) during tuning. So, send a stop
> command via mmc_abort_tuning().
>
> Fixes: 4f11997773b6 ("mmc: tmio: Add tuning support")
> Reported-by Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for fixes and by adding a stable tag, thanks!

> ---
>
> Ulf, I'd think that mmc_abort_tuning() should be named
> mmc_abort_tuning_cmd() instead. Because we don't actually abort the
> tuning as a whole in this function. What do you think? I can prepare a
> patch if you agree.

Good point.

I have no strong opinion, but perhaps mmc_send_abort_tuning() is more
consistent with other function names?

Kind regards
Uffe


>
>  drivers/mmc/host/renesas_sdhi_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 635bf31a6735..9029308c4a0f 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -692,14 +692,19 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         /* Issue CMD19 twice for each tap */
>         for (i = 0; i < 2 * priv->tap_num; i++) {
> +               int cmd_error;
> +
>                 /* Set sampling clock position */
>                 sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, i % priv->tap_num);
>
> -               if (mmc_send_tuning(mmc, opcode, NULL) == 0)
> +               if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
>                         set_bit(i, priv->taps);
>
>                 if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
>                         set_bit(i, priv->smpcmp);
> +
> +               if (cmd_error)
> +                       mmc_abort_tuning(mmc, opcode);
>         }
>
>         ret = renesas_sdhi_select_tuning(host);
> --
> 2.30.2
>
