Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F1C4708E
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLGMiN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLGMiJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 07:38:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D42D1CD
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 04:37:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 124so17353727pfy.0
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 04:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vJpWKzcufnxvrG4FDvIiDfDPCvOWzz7Bie3aByLyjGA=;
        b=EaZc+tV9EivblvWu0jwweYQvTfdciUyXndefS0cdFocY4gBgc8Qv242gf3JdqcfrOL
         Krox+LdAG9cvMfYydtq0V3SAKf+IP8XsKGITQfJAibIODttF4nx5eYwtNRsB92yk3+cZ
         vBt6kDbu1gXKAljaDFsiCbAPYVlN553sfZGwjB7+vGPuxr/Jh0uTqB6v3QHAPrk/l6VG
         14xq5x/5Qh06MNplKvI09yMXc6dPDIH7Zi3ETBtLAv6XZNG2ThgBGuZY6NejGc2VVZhK
         30bVwOIi0JCo1VD62AXrHm/jHmRAzsS+tpeaB4ajjrAyK5hzk/U8X2ETdjXXNlz3N/Sx
         TeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJpWKzcufnxvrG4FDvIiDfDPCvOWzz7Bie3aByLyjGA=;
        b=wFfEe55CmEBMQqyJR9SfKxQa5aVfx7KgHlSAbslBxtcil8jVCqZ2fOikhuzMNfeiAa
         GdhRJZADTPa5+rOgun3kULA+nC+9qSP2gBW2yCEC8Zyzw0ddfUlgu+Mh5WHP9JqgcoFW
         frpFnfAUbym5BwpBIsZajh0hh30wPqm2ytvK0egp4FSq1O++c0fOdMPe9lhiLqPXVGRr
         dU4qvraFRgwX8KnYI/mbMS9UbKpvVtMRNovvu85lTlHPwoL8T0AwfWGwVJYq1iRbVsYZ
         P+SAT/qHkYWbe/n8eBlIrXkUflOvlws3eX9y+X6H3MDJxdil9rIexA1eY5UvjCxotIFm
         TOlA==
X-Gm-Message-State: ANoB5plPlSkrPdxqnBq2kx35i3rnjN1N0+SpjbP1Czf0Pf/flg5rd3RO
        Vt9t0cF2Wy6dNTa6+v3LhekAPrkqGuuTgZSxS/cNnw==
X-Google-Smtp-Source: AA0mqf4F73nkDpLKoHQMfc2A7c1ijf/S4SR6XUOnX2+swfIccB2ewi2eg+kpxC/iknpspWWbVIxErOFl9wpExPNRWNU=
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id
 s20-20020a632154000000b00477b650494bmr62080305pgm.434.1670416679067; Wed, 07
 Dec 2022 04:37:59 -0800 (PST)
MIME-Version: 1.0
References: <202212021031575255977@zte.com.cn>
In-Reply-To: <202212021031575255977@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:22 +0100
Message-ID: <CAPDyKFoP8DBFg-HvWzZq28mdkTrbA_Jhmvio=DN7FQr8cgU6sg@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mmc: sdhci: Remove unneeded semicolon
To:     zhang.songyi@zte.com.cn
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Dec 2022 at 03:32, <zhang.songyi@zte.com.cn> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> The semicolon after the "}" is unneeded.
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42aaeabcad22..8413180a1039 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2289,7 +2289,7 @@ static bool sdhci_timing_has_preset(unsigned char timing)
>         case MMC_TIMING_UHS_DDR50:
>         case MMC_TIMING_MMC_DDR52:
>                 return true;
> -       };
> +       }
>         return false;
>  }
>
> --
> 2.15.2
