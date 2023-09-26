Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF2E7E647
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjIZO63 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjIZO62 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 10:58:28 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F15116
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 07:58:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d84c24a810dso10403463276.2
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740301; x=1696345101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZbxtg1mBfCZMzNBoLIQJWtwMNJFStlqqB1T72xxhYg=;
        b=Zct6p4K4jaKU2HKVEyFQxeCtTa0fBC+SwDsPeA24OiADcX6oXsxkTLK5hLjbRZ6J6g
         z0zarWzdyXsorxODdfbw8NT2U5qE7h4f803RmCSI0NfGhWeXLhP8wGXe0YEvb/+ryvD1
         T/ZaQe1iGzo59j3gRb5MQfcQXhWyDk1v9NQkNdGR1V39jF4d68vTXPZY6V6S5xTOHLNC
         WD+JiyGW2io/AP4pWxqrzBbpMRQFRb2k0e27PF5DZSrMp5Nn7q4ElrNwO2V6lyktzjrx
         vQDJlscnnEHNGrE5nBTLHU6oWG/bz0ZEOEjQsNO8V/MBgMTjNmx73rF/hX/wdKxi0/TF
         u93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740301; x=1696345101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZbxtg1mBfCZMzNBoLIQJWtwMNJFStlqqB1T72xxhYg=;
        b=TSbhd2S2shAEEbSMyI18GWx4vyfzn3lp/EnJbkGTgoctc3eHi0tgV7UatWjX8V038S
         i0XU8vQT0ecaXQQiUNW4UiY5tBcxGijcnqfDnvZGCUU3mo/FHJwedYwRvxVY//KQ1QAi
         Qi0OkianRMZbYxncb5ojvjymV9bFS7TLSy0z60oKTUrw58vzJWnUFaIDiq60rFKbdSHt
         7n9jVDUOX1KwYUi7QxaVwvXoZ0FP1qcGaekm3nGXUx9UviK3QklF9YnehKTSbYyA5KNH
         tQ4f3QEMJ9sUXFCVZgIbblLcdVGTG3c02cTU8F+sU0RjFBZbEUUCUZ2JsCDr+NpLi/HO
         bGyQ==
X-Gm-Message-State: AOJu0Yzh7V4J1onC0195hZ5/DQsgDFyJU5fUsViCxLMU2tESDZBxG8gH
        m/vR2SFaDEVcuTX6YXO3Fa+7TN2DorpxsdKsNPvSRIKdgnYb9U1dhuQ=
X-Google-Smtp-Source: AGHT+IE1o1qWDkZEpF346JB3JDVb9LCnv531f0QxlOdNoUdij2dM8xqI+aDHSud58opOjtQcTrIsd4jaxIyH07e96j0=
X-Received: by 2002:a25:4409:0:b0:d62:b8f5:d745 with SMTP id
 r9-20020a254409000000b00d62b8f5d745mr7870619yba.52.1695740300815; Tue, 26 Sep
 2023 07:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230923173728.1781844-1-avri.altman@wdc.com>
In-Reply-To: <20230923173728.1781844-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 16:57:44 +0200
Message-ID: <CAPDyKFpkLaQJCw9VHcsxTC4XeVajpH+s5r8iztjrkKUXvUmyag@mail.gmail.com>
Subject: Re: [PATCH] mmc: Capture correct oemid
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Alex Fetters <Alex.Fetters@garmin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Alex

On Sat, 23 Sept 2023 at 19:38, Avri Altman <avri.altman@wdc.com> wrote:
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

As pointed out by Alex (offlist), it seems like this comes from the
legacy MMC specs (v3.31 and before). That probably doesn't matter as I
guess the oemid isn't that important to use for these old devices.

However, it would be nice if you could add some of this information to
the commit msg, to make this clear.

>
> It is important to fix it because we are using it as one of our quirk's
> token, as well as other tools, e.g. the LVFS
> (https://github.com/fwupd/fwupd/).
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Kind regards
Uffe

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
