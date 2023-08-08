Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9466FC001B0
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 17:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHHRnu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHHRn2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 13:43:28 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F024ABD
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:19:19 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a426e70575so3326897b6e.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511522; x=1692116322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvQJ94JUmNmfWnFUJ3zsqGbPSkM92W/OFcGzXCWoFs4=;
        b=KspSbLSlU8zXclS/nJCPIqFEcucHG5nNNSh1h/T8/wzKvUCfsgur/vRDvR5m9X5sYS
         n2QwV0YlEs+VrLi9HxfCg7C9YTxgNWxrDTzf/aIlHpWXMPs5wY1NQY5HQsD4gbTUww6z
         wtnT/FU0HeU1bKCjAnKzHhzGWImncnjsivAVTJGqGDQG8Tng2OYZxMGTUY85kyfFs0UM
         yB9bJgffSMsQjwU2W5M0FJphR5oxgd+/kXfIERlkW2A1XTPLjeklzcI9GzLb4CevZ7U+
         GN1Cw+s+DD+rk34M88+3Zo26E1GxNomDHUtec9Mzs1eG3JhBsouHy8gn6HldsOJkfZhw
         8/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511522; x=1692116322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvQJ94JUmNmfWnFUJ3zsqGbPSkM92W/OFcGzXCWoFs4=;
        b=UBOnu1FieFwQedegT/ErYorL7MNtLgR70dhvYIeMNcyoezHyS5jUnxk6Z5Lko5Juzs
         /FACEOZwrbxseYwqABdLFvj/hehdSjJeI9gsyqZlsZfJLmqRpT8VYRtq3d3zlNP5ykYJ
         /O0bDxXWsYMdDW30NNgV7fwea81w4synIRPqKA/vqHwKqiHB1R/sa8aYnyW1gyDljO9K
         aWOMQDZ3WLMIfGHjoVndZOA36bpDTeIuYQgyxZN1MPxZjwwwjHjYp/BhMXMctwdC4bEV
         tKiPrI8tjJ7ky8hwIyWBBxkthOoi9ZG+Vs9vMKs4erOEEnk/T9sx4vwATM40jbibXST8
         DA/w==
X-Gm-Message-State: AOJu0YyHyxE2BiO3pLlU5kqljAwzjBN5vWCXRuU3MfDOXq100Z0qn0eJ
        IpE7HoHK19BO0rYhcv0iMttMrU1PPwm7XOGPeEej8m+hMFrYHgRu
X-Google-Smtp-Source: AGHT+IGcfGDHJOh3NFEhcurjPG+eORblU9sLlaVH023b0D+QUvpipgKZ7PJt4cDghdwhXu6F9+XQMTX5S+Eh8t4p7z0=
X-Received: by 2002:a25:690f:0:b0:d0e:9914:f5e1 with SMTP id
 e15-20020a25690f000000b00d0e9914f5e1mr9990126ybc.15.1691490316183; Tue, 08
 Aug 2023 03:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <20230721101349.12387-4-victorshihgli@gmail.com>
In-Reply-To: <20230721101349.12387-4-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:24:40 +0200
Message-ID: <CAPDyKFqFbp-rbRBZ7eYtR1HXJfYuhiCLbFM8bSv1a-9gtZd6vg@mail.gmail.com>
Subject: Re: [PATCH V9 03/23] mmc: core: Announce successful insertion of an
 SD UHS-II card
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>

Authorship?

>
> Update in previous version:

Please, drop the above.

> To inform the users about SD UHS-II cards, let's extend the print at card
> insertion with a "UHS-II" substring. Within this change, it seems
> reasonable to convert from using "ultra high speed" into "UHS-I speed", for
> the UHS-I type, as it should makes it more clear.
>
> Note that, the new print for UHS-II cards doesn't include the actual
> selected speed mode. Instead, this is going to be added from subsequent
> change.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V7:
>  - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
>    mmc_card_uhs2 function.
>
> Updates in V4:
>  - Make mmc_card_uhs2() take struct mmc_host* as in-param.
>
> ---
>
>  drivers/mmc/core/bus.c  | 4 +++-
>  drivers/mmc/core/host.h | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index cf32cf135781..d9a3b3d38d8b 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
>         if (mmc_card_hs(card))
>                 speed_mode = "high speed ";
>         else if (mmc_card_uhs(card))
> -               speed_mode = "ultra high speed ";
> +               speed_mode = "UHS-I speed ";
> +       else if (mmc_card_uhs2(card->host))
> +               speed_mode = "UHS-II speed ";
>         else if (mmc_card_ddr52(card))
>                 speed_mode = "high speed DDR ";
>         else if (mmc_card_hs200(card))
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 48c4952512a5..9f6e5e31dfea 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -89,5 +89,12 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
>                 host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
>  }
>
> +static inline bool mmc_card_uhs2(struct mmc_host *host)
> +{
> +       return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> +              host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
> +}
>  #endif
>

Kind regards
Uffe
