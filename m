Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF347C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Apr 2022 11:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiDDLzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Apr 2022 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiDDLzT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2022 07:55:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447733DA43
        for <linux-mmc@vger.kernel.org>; Mon,  4 Apr 2022 04:53:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 5so16816529lfp.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2022 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/prrTENUf6pzL4WCzSMy1jrFtdQ4Xcb5kDF2mfqB7zs=;
        b=PYFydnzxYQAlPMnClgqHFUDkvNDiEch29pfJ2qtwzNHKU6okojwI1RM1/DIWWwSMsc
         uE+v2Hb+ee4XPmbHHnrMZpmbSVsf7BRaFl2Nk01OcbSnFuOV+ZR2xKxO0NwVTLCADhko
         r9x262PyhrJEvkFS0R5KTdarUuGGUHaV27TtqyFYtErTn7Bz6AMGBEedb53QNgrm8/75
         hZcpPBNpGHZHTzkBKNHxxjWIk5SnrHJK3g5Y3ehEkhDnM+YopV8WM0Sk6aU/8BTPhoZl
         rUQwue/E9Yk4/yMb8fSZAP47k+JRHdExk/3eKHMEpKSPIf3DSf/cqoT8rDHVorN07Js2
         VOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/prrTENUf6pzL4WCzSMy1jrFtdQ4Xcb5kDF2mfqB7zs=;
        b=hRNefV6Sm/QdilPyQHv8NM6Yzty5WgsSZGePMc3nlE9Xfa1btr2uyhYbJlF/yWkVS5
         RraE5VwOyGv7RuGHsPsVnTTuQ2TOCDTPJAHQCBjiBU2BIEsvASPoJFfkNm79cfrOcy0+
         A/ZzIzcJJgYxnUQKYXF5SPJN5lCjJ7CzLSMTZ7NPrLLcYBpoCPZ/5vaQ+oBqfOEkud7E
         xpeCrKsDeTquphJAdH+qWpkX8lsNhV0v9cUjnB0fZGTe3J26txNe0lCV8ZxmhClQcpX/
         xR8aMFHF1g0SwDHEQ/gSSt3Al15Xs6NuMTvQHwuuecUv6R5dB8mS3UjEKufzTi2GZubT
         Cwpg==
X-Gm-Message-State: AOAM531xDIlsHPYMtWzz4OymSG2dk9dhV8eyVE0s5vL3nk7oq/zvEOe6
        WPCw7jNuZFeWuhWSmM5BxGaK9AA3FbZP3q86x5VwsQ==
X-Google-Smtp-Source: ABdhPJzW6vSwrioMRqk+1JgnalXH4WrypHHLHS9iQphGdQYJVekyA1LtqRSxNH7DUGi0rpWrvs2hIHtqdbIU10Nxebw=
X-Received: by 2002:a19:5012:0:b0:44a:a22d:2d49 with SMTP id
 e18-20020a195012000000b0044aa22d2d49mr22572934lfb.254.1649073201469; Mon, 04
 Apr 2022 04:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220404105831.5096-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220404105831.5096-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 13:52:45 +0200
Message-ID: <CAPDyKFrc_Rrm48Q6WM_OchTQvFX3fzGerQ5jY2HgW19uc7n+PQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: R-Car V3M also has no HS400
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Apr 2022 at 12:58, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Further digging in the datasheets revealed that R-Car V3M also has no
> HS400 support.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 9dd01c220e93..2cd81d22c3c3 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -235,6 +235,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77965_compatible = {
>
>  static const struct renesas_sdhi_of_data_with_quirks of_r8a77970_compatible = {
>         .of_data = &of_data_rcar_gen3_no_sdh_fallback,
> +       .quirks = &sdhi_quirks_nohs400,
>  };
>
>  static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
> --
> 2.30.2
>
