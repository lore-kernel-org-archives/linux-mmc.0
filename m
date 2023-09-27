Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3909E810C3
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 10:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjI0KlM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjI0KlF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 06:41:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3E3193
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 03:41:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so12300933276.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695811263; x=1696416063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2TfCQZsnh0ySphxADEFX5shF0ZakwOqKiQEzJJfwjao=;
        b=J3a5rKIyc3qQr96Og1x+bZmG/7XLa3qXBqEtNsHFX/PeM1H1kyOJUAsaZHO0zpLA4w
         +kih2eNEmkRMS+u8hL/fy/nQVj/koJcTGMcI2S9Y/LH0NiMYkFfxXP8a8kY/GFYDWx1q
         8ANDd1sSTLzE8WCMSLmviy+55n9//I9VDHL8hekYMaDIPx8RoztKy7bJjrUzkcqQ48pz
         Qu2jkdxNlrax4qgbUkNV5H3WQ3expYBcxlkhUCMNTCnd6op66K4SC0/sU74adUmXk+fo
         jH2Uot9aCgjVGanLDOmz2JNsCY+VFfoIWNEo7PyIWPGjirhFwiIenwe9oVaByeEU+NIk
         PhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695811263; x=1696416063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TfCQZsnh0ySphxADEFX5shF0ZakwOqKiQEzJJfwjao=;
        b=spxNnk5AB9eet9QxkHf3KYu3GEYhh9OPQADC5orF2UyXN1bZBBl4OGpyrSyiJsR2TH
         Lpx7q6HjiarLtkXO3YqOZgCpUurxAUwEjTQow8pDKGNSIynUE0V42kQNNjqDg4UOyXGV
         dGdCHXa3evimlBZNSJWvHN55dbxHbnzMeJAKvBuhr1emzJKpp1hjc5qLRWd4IMBOL48z
         RcMlC56KgpAJwnX3oWa3J8nHVcSWg7l9kRjQBUwq0QlAEo81JH4ScnDRV2RW9YuwxZQx
         ZHCqZi83be/aTePmt8J9FN0zmGOW7xxcxniwJ1hz5nsDtMRLWIguPXvAvcH3fJEn9lHI
         8+2A==
X-Gm-Message-State: AOJu0Yxko7TeL4vXE5JdX8YeNqvl26GeMqkmJIV0Rn3U0SKzPvFdarqF
        Q8vQYkf4LOKx2TM6yChvVGckfEy58v+VCT0QYpnmKCenKHzFOo+O
X-Google-Smtp-Source: AGHT+IFyMmVzJBGh1WTSI82sfENWHz6YtmJoSZXjxxhHza4LSBIxODX2BFzHgtXg4ninj58ZBLw4XsSxNcSnz1Uzem4=
X-Received: by 2002:a25:378c:0:b0:d7f:3f07:722d with SMTP id
 e134-20020a25378c000000b00d7f3f07722dmr1598572yba.3.1695811263390; Wed, 27
 Sep 2023 03:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230927071500.1791882-1-avri.altman@wdc.com>
In-Reply-To: <20230927071500.1791882-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 12:40:27 +0200
Message-ID: <CAPDyKFqnY-2QEwrjXm92spT4ETRcuuL-zCLnVqHGuipUecX7HQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: Capture correct oemid
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Alex Fetters <Alex.Fetters@garmin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Sept 2023 at 09:16, Avri Altman <avri.altman@wdc.com> wrote:
>
> The OEMID is an 8-bit binary number that identifies the Device OEM
> and/or the Device contents (when used as a distribution media either on
> ROM or FLASH Devices).  It occupies bits [111:104] in the CID register:
> see the eMMC spec JESD84-B51 paragraph 7.2.3.
>
> So it is 8 bits, and has been so since ever - this bug is so ancients I
> couldn't even find its source.  The furthest I could go is to commit
> 335eadf2ef6a (sd: initialize SD cards) but its already was wrong.  Could
> be because in SD its indeed 16 bits (a 2-characters ASCII string).
> Another option as pointed out by Alex (offlist), it seems like this
> comes from the legacy MMC specs (v3.31 and before).
>
> It is important to fix it because we are using it as one of our quirk's
> token, as well as other tools, e.g. the LVFS
> (https://github.com/fwupd/fwupd/).
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changelog:
>
> v1--v2:
> Add Alex's note of the possible origin of this bug.
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..4a4bab9aa726 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>         case 3: /* MMC v3.1 - v3.3 */
>         case 4: /* MMC v4 */
>                 card->cid.manfid        = UNSTUFF_BITS(resp, 120, 8);
> -               card->cid.oemid         = UNSTUFF_BITS(resp, 104, 16);
> +               card->cid.oemid         = UNSTUFF_BITS(resp, 104, 8);
>                 card->cid.prod_name[0]  = UNSTUFF_BITS(resp, 96, 8);
>                 card->cid.prod_name[1]  = UNSTUFF_BITS(resp, 88, 8);
>                 card->cid.prod_name[2]  = UNSTUFF_BITS(resp, 80, 8);
> --
> 2.42.0
>
