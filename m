Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9480E8FDDA
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Oct 2023 08:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbjJDIgV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Oct 2023 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241711AbjJDIgT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2023 04:36:19 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CB83
        for <linux-mmc@vger.kernel.org>; Wed,  4 Oct 2023 01:36:16 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d77ad095f13so1901635276.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2023 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696408576; x=1697013376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNmmYgCjSxXxIRoxGSMK0QQqTDsrWAUVkTpb18p92u8=;
        b=qhgMlPjTsG/qdg+cZOh6it9C5GuaT/J0iHgc/KbxfdfDkWXjLIR4FXQ182YYbJbrbK
         ErIGvQAwckoL9pmglkNzFk8Bxj9BkLU9H36zZNmC05EOBYqHeyZYFATfQENK+7p/AkQD
         yyiCtOy1+8SvN0DSKrBaL75MBk954XaQkbfR6h9HP11EgFrf6dwwfhOx58C37Zcx7w7m
         OenuZtxSYMJQP32RJpezwwfV7xtz0GvWJlKpGjQqsV5n36Z/x+7M1bEoOTZL9hf7iVsT
         onaiWpADJJMxaawBdoojs8vi18l2DvJo+y/wwZZCaRMHqPwowvRme/DFkYc323/6oWlX
         ChLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408576; x=1697013376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNmmYgCjSxXxIRoxGSMK0QQqTDsrWAUVkTpb18p92u8=;
        b=xAfkt7ETxFfng/JTyOllMZo+O4Ymc2t0lCBf8D0I1p6gvbJdT42n03tiwFBYKVxavf
         ECMwHjBmOn7feHb/HzwiPa7SzWn+NHx6VHcPZm8lcDKTCGR6EN4JGf27mzRNAb+b1gjv
         2eOPyL3BJsKd6jStUZMYNIgSLLjlcPuPVtdaK96vMc+sfYk3rvzS57CkjTQUJV5eqIiN
         chOcHAEHaXrETHg89rHAJwr7tEvKMcbM7sL1KFqd7R2UCVyAnyW/FYtDlXaL1relHUHs
         cAHgC4MUSvHPBtmdOLN3+zkCnVs1kSEvvScqTtmOsTmcxIpJfXYvkl7apSWWn2fhh9W2
         wUAQ==
X-Gm-Message-State: AOJu0YxNPSHQoh6a+tXA6Yin14/QrGzYzO47h774BDkm3cTNCsfgyosM
        KqHqYfnACPa3PxCI1haMkHPcqmYTsm9O46M53a71iA==
X-Google-Smtp-Source: AGHT+IHioMNPp0e6TuU7XZzbtyJB2o5aREJwLeXKLMBBOK5IOj/DqlZbG27TG4p1nspDmkZElEP9rTFFyJA8aFcOgXs=
X-Received: by 2002:a5b:110:0:b0:d81:85c9:cea9 with SMTP id
 16-20020a5b0110000000b00d8185c9cea9mr1331920ybx.65.1696408575811; Wed, 04 Oct
 2023 01:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-11-victorshihgli@gmail.com> <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
 <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com> <CAPDyKFqidGZ242P-9xnxokSCeGxk8uziqR=AteWt=iQFz5fA9g@mail.gmail.com>
 <81bf38cd-b6a4-4a6f-a51d-bc916e3b8f96@intel.com>
In-Reply-To: <81bf38cd-b6a4-4a6f-a51d-bc916e3b8f96@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Oct 2023 10:35:39 +0200
Message-ID: <CAPDyKFoc0phsXuX5W0PqFu2En57Lc9D-+MTGxAYtJhPpHcVZ2g@mail.gmail.com>
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Victor Shih <victorshihgli@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 3 Oct 2023 at 17:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/10/23 15:22, Ulf Hansson wrote:
> > On Tue, 3 Oct 2023 at 13:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 3/10/23 13:30, Ulf Hansson wrote:
> >>> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
> >>>>
> >>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>
> >>>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >>>>
> >>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>
> >>>> Updates in V8:
> >>>>  - Adjust the position of matching brackets.
> >>>>
> >>>> Updates in V6:
> >>>>  - Remove unnecessary functions and simplify code.
> >>>>
> >>>> ---
> >>>>
> >>>>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
> >>>>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
> >>>>  2 files changed, 47 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> >>>> index e339821d3504..dfc80a7f1bad 100644
> >>>> --- a/drivers/mmc/host/sdhci-uhs2.c
> >>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >>>> @@ -10,7 +10,9 @@
> >>>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>   */
> >>>>
> >>>> +#include <linux/delay.h>
> >>>>  #include <linux/module.h>
> >>>> +#include <linux/iopoll.h>
> >>>>
> >>>>  #include "sdhci.h"
> >>>>  #include "sdhci-uhs2.h"
> >>>> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >>>>
> >>>> +/*****************************************************************************\
> >>>> + *                                                                           *
> >>>> + * Low level functions                                                       *
> >>>> + *                                                                           *
> >>>> +\*****************************************************************************/
> >>>> +
> >>>> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> >>>> +{
> >>>> +       return host->mmc->flags & MMC_UHS2_SUPPORT;
> >>>
> >>> The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think we
> >>> should be using mmc->ios.timings, which already indicates whether we
> >>> are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we added
> >>> this.
> >>>
> >>> That said, I think we should drop the sdhci_uhs2_mode() function
> >>> altogether and instead use mmc_card_uhs2(), which means we should move
> >>> it to include/linux/mmc/host.h, so it becomes available for host
> >>> drivers.
> >>>
> >>
> >> UHS2 mode starts at UHS2 initialization and ends either when UHS2
> >> initialization fails, or the card is removed.
> >>
> >> So it includes re-initialization and reset when the transfer mode
> >> currently transitions through MMC_TIMING_LEGACY.
> >>
> >> So mmc_card_uhs2() won't work correctly for the host callbacks
> >> unless something is done about that.
> >
> > Right, thanks for clarifying!
> >
> > In that case I wonder if we couldn't change the way we update the
> > ->ios.timing for UHS2. It seems silly to have two (similar) ways to
> > indicate that we have moved to UHS2.
>
> Perhaps something like below:
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index aacefdd6bc9e..e39d63d46041 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -70,7 +70,8 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>
>         host->ios.vdd = 0;
>         host->ios.clock = 0;
> -       host->ios.timing = MMC_TIMING_LEGACY;
> +       /* Must set UHS2 timing to identify UHS2 mode */
> +       host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
>         host->ios.power_mode = MMC_POWER_OFF;
>         if (host->flags & MMC_UHS2_SD_TRAN)
>                 host->flags &= ~MMC_UHS2_SD_TRAN;
> @@ -1095,7 +1096,8 @@ static void sd_uhs2_detect(struct mmc_host *host)
>                 mmc_claim_host(host);
>                 mmc_detach_bus(host);
>                 sd_uhs2_power_off(host);
> -               host->flags &= ~MMC_UHS2_SUPPORT;
> +               /* Remove UHS2 timing to indicate the end of UHS2 mode */
> +               host->ios.timing = MMC_TIMING_LEGACY;
>                 mmc_release_host(host);
>         }
>  }
> @@ -1338,7 +1340,8 @@ static int sd_uhs2_attach(struct mmc_host *host)
>  err:
>         mmc_detach_bus(host);
>         sd_uhs2_power_off(host);
> -       host->flags &= ~MMC_UHS2_SUPPORT;
> +       /* Remove UHS2 timing to indicate the end of UHS2 mode */
> +       host->ios.timing = MMC_TIMING_LEGACY;
>         return err;
>  }

I wouldn't mind changing to the above. But, maybe an even better
option is to use the ->timing variable in the struct sdhci_host, as
it's there already to keep track of the current/previous timing state.
Would that work too?

>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 517c497112f4..d1f3318b7d3a 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -267,10 +267,11 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         /* UHS2 timing. Note, UHS2 timing is disabled when powering off */
>         ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -       if (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> -           ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> -           ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> -           ios->timing == MMC_TIMING_UHS2_SPEED_B_HD)
> +       if (ios->power_mode != MMC_POWER_OFF &&
> +           (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> +            ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +            ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> +            ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
>                 ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
>         else
>                 ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
>
>

Kind regards
Uffe
