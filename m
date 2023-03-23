Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B6C7619A
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCWMOj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCWMOL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:14:11 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218CB26872
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s67so7674611ybi.5
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ifEL+T7wZRA+Rvojd9hiAI6QKDMb26Hf1IrrKjc65U=;
        b=tl9aKPK5SB5v5UM1uaXt+2jUSBBG46g2NS/gdbhgaFMGiA3oI5URTVH9pepZvnv56O
         BPRvTSpaN0fuxfUGKiPWiBhu8uRmHfbWSaMtDgdDAbLEYcCKsL0diZh24g1THTkb9Ze0
         Bq7oJW4BHuoNvNw7awBHnI8B6UWNMtt1D4kWTE6sNrwqjnewOt/QgjW3eRdvmS3Qk/r5
         ompQuAZMavLYdg5dq2rU7h/n/kb0YqstObNKasuHEXAfU9bIuz/Eb9mOqR7ydBmBE0xK
         2HTbwBdlGiImRXygfGNb5H3tCi7+OtEquUCbXMYbC63waRQwP/ZHaJYfS92+KosaXBB/
         dpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ifEL+T7wZRA+Rvojd9hiAI6QKDMb26Hf1IrrKjc65U=;
        b=DwNFfRTit1Z35H/wXlBXNVOidVgBqjgV32dqO6tMvskQymnk+W1nFyhnhdKeqlT+tp
         8Op2nyBfZmRcVr4zWelaXRuoPU05vlloy+j1cWSiyDWsaVUU580/4c9T6zfwhSxkad0H
         dPUDVQVJ43Hk5PgIUKbavbrJDISsfA7ajd0X8ZtAAFA7n70r5Q5onY/HyFRUG0mKLfxH
         UcBo59F5LpLn8jGq14xg9asgTdwGx6UvpunKOaTYVVZylZdkh7rOFF3kXnyJoYyAfVVX
         bwmPwE/a9/X8Vq68HPdFENi+wPm8xBEt0UBWIpolwLTDkkQcx7wsEhdiENMJw6sZPJUZ
         H51g==
X-Gm-Message-State: AAQBX9ec7ChMxTy+xI/NATk1WH/e/2bpsXHJisdIlHjTYrMlTc74qcQ4
        fBra9IGvSnDd2FvHOTOpFAbDgiBSpmMq+Ll+e6UklA==
X-Google-Smtp-Source: AKy350b2z2Vy4gi04lpRmmrwo4jQa0c3vsloleDOPC0rx19EBqNS80Sa6UQSgApURx9cw/db8YGdLs70HbiJfGwiEl8=
X-Received: by 2002:a05:6902:1895:b0:b69:bf76:2243 with SMTP id
 cj21-20020a056902189500b00b69bf762243mr2100275ybb.3.1679573629323; Thu, 23
 Mar 2023 05:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230317092711.660897-1-b-kapoor@ti.com>
In-Reply-To: <20230317092711.660897-1-b-kapoor@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:13 +0100
Message-ID: <CAPDyKFr96FG7=+AbbDs5Z6jvoE+MDjYs5O_K-FcR=JzNbsw+mQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Set HIGH_SPEED_ENA for SDR12 and SDR25
To:     Bhavya Kapoor <b-kapoor@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Mar 2023 at 10:28, Bhavya Kapoor <b-kapoor@ti.com> wrote:
>
> Timing Information in Datasheet assumes that HIGH_SPEED_ENA=1 should be
> set for SDR12 and SDR25 modes. But sdhci_am654 driver clears
> HIGH_SPEED_ENA register. Thus, Modify sdhci_am654 to not clear
> HIGH_SPEED_ENA (HOST_CONTROL[2]) bit for SDR12 and SDR25 speed modes.
>
> Fixes: e374e87538f4 ("mmc: sdhci_am654: Clear HISPD_ENA in some lower speed modes")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> Changelog v1->v2:
>  - Corrected Names of speed modes in commit message
>
> Link to v1: https://lore.kernel.org/all/20230316080451.475020-1-b-kapoor@ti.com/
>
>  drivers/mmc/host/sdhci_am654.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 7ef828942df3..ac90e86bb0a0 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -351,8 +351,6 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>                  */
>                 case MMC_TIMING_SD_HS:
>                 case MMC_TIMING_MMC_HS:
> -               case MMC_TIMING_UHS_SDR12:
> -               case MMC_TIMING_UHS_SDR25:
>                         val &= ~SDHCI_CTRL_HISPD;
>                 }
>         }
> --
> 2.34.1
>
