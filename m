Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F36EEAA50
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbjINOsS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjINOsO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 10:48:14 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0001FD7
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:10 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d8162698f0dso1118805276.0
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702889; x=1695307689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAoj84R+cdt6r63oSpEd3ofgiXFXi8340REgdMcMGZQ=;
        b=pQyn1PtD0FhDPMsoXJ6ld6AEL/M7IdP3hyaKarKwYbWhT4h2bB1fHtARrwWf3DOiMJ
         +qvKPpU3AMROslYYb2B/uXND2jUUux4ikPM2aBu29eoRwrfUDKmDBD4T/Mq5XgxNNkkX
         5aaxf5UYfU77lcLu8RgGpkI9LprY3EWrZPsOXFfPDtbIIoT5lrFZB02peXeYu0Bjvt+7
         FxszvC9CNN9aT1H2ZqJoYIs9qKYH1qF8MpCKwlOqEIqUnO3e3Sc6fhBnK7PsVxhod6ay
         UWsr1GKsbWjEBtaxfACej8Qngp+DHCgoD6bIJTtYgE8MRDSulKHtZTuOVUXxk/CcjR2g
         4J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702889; x=1695307689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAoj84R+cdt6r63oSpEd3ofgiXFXi8340REgdMcMGZQ=;
        b=LiQ5ItwJWLpRagBlkUROikjEPzZL7Xtp48s2Veugdpfcf2AjbPivZO1wrcFiBbe4ru
         6SacJ1si6z4nJad/XhKfwrsPemzmgtWhg0K8koLD5Df2dh4ZvJSYeuReA80YdNzg/UTg
         Ecx55PiIfPb4fDkTw4tByVurjGPF38lik3MG9F44y43XlclfcOt0R6byEv8xuuJI65KM
         sS5EKtnWWTSLq286jWQeHD9pgev8O0Dy/s+X2L1yQm5WOITy7TQIT9z5mgtNWS1yUKED
         udJPxhyaWUsurxDv5qYv4LloUVzseiFTYSE8/KEueD1VsU3B5nXsqobYdzWIybrc7HZY
         uWiQ==
X-Gm-Message-State: AOJu0Yx0M4vpnt6vZP6PHUpO7UL9qjSRGq7xiVspaj7kNMuWQ/Tj6adO
        4iiDDvuZzj8T5ZivfkAnxo2pxaLQByCMM7hEGlaWPw==
X-Google-Smtp-Source: AGHT+IFvsc4Ea2G3pqJdL8LyxH3L0mP0pPNEevh9udmDSypx4IHG2mDMMHJ1a4jrYC+yt5OF3rwn+NH6F+ltbgPCs4E=
X-Received: by 2002:a25:26cf:0:b0:d81:b483:87c4 with SMTP id
 m198-20020a2526cf000000b00d81b48387c4mr705543ybm.33.1694702889427; Thu, 14
 Sep 2023 07:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com>
In-Reply-To: <2ce258f371234b1f8a1a470d5488d00e@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:47:33 +0200
Message-ID: <CAPDyKFoCHtN9jK3A9YkoQC+e_3XNKJNp7-w1WkNMFBp6n-PH=g@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix an error access Page fault
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 Sept 2023 at 10:03, Ricky WU <ricky_wu@realtek.com> wrote:
>
> an error occurs on insert SD7.0 card.
> The pci slot of rtsx_pci will Link Down when the SD7.0 card inserted,
> but the rtsx_pci not exit from runtime_idle at that time,
> then do the power_saving function to access the wrong resource
>
> Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management flow")
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for fixes, thanks!

Greg/Arnd, please let me know if you prefer to funnel this via your
trees instead.

Kind regards
Uffe


> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 14 ++++++++------
>  drivers/mmc/host/rtsx_pci_sdmmc.c  |  1 +
>  include/linux/rtsx_pci.h           |  1 +
>  3 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index a3f4b52bb159..536a3681fd5e 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1526,6 +1526,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>         pcr->host_sg_tbl_addr = pcr->rtsx_resv_buf_addr + HOST_CMDS_BUF_LEN;
>         pcr->card_inserted = 0;
>         pcr->card_removed = 0;
> +       pcr->is_sd_express = false;
>         INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
>
>         pcr->msi_en = msi_en;
> @@ -1735,12 +1736,13 @@ static int rtsx_pci_runtime_idle(struct device *device)
>
>         pcr->state = PDEV_STAT_IDLE;
>
> -       if (pcr->ops->disable_auto_blink)
> -               pcr->ops->disable_auto_blink(pcr);
> -       if (pcr->ops->turn_off_led)
> -               pcr->ops->turn_off_led(pcr);
> -
> -       rtsx_pm_power_saving(pcr);
> +       if (!pcr->is_sd_express) {
> +               if (pcr->ops->disable_auto_blink)
> +                       pcr->ops->disable_auto_blink(pcr);
> +               if (pcr->ops->turn_off_led)
> +                       pcr->ops->turn_off_led(pcr);
> +               rtsx_pm_power_saving(pcr);
> +       }
>
>         mutex_unlock(&pcr->pcr_mutex);
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 87d78432a1e0..80b2f2a31fdc 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1393,6 +1393,7 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>                 RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
>                 | RTS5261_DRIVER_ENABLE_FW,
>                 RTS5261_MCU_CLOCK_SEL_16M | RTS5261_DRIVER_ENABLE_FW);
> +       pcr->is_sd_express = true;
>         host->eject = true;
>         return 0;
>  }
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 534038d962e4..295e92224fd0 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -1262,6 +1262,7 @@ struct rtsx_pcr {
>         u8                      ocp_stat;
>         u8                      ocp_stat2;
>         u8                      rtd3_en;
> +       bool                    is_sd_express;
>  };
>
>  #define PID_524A       0x524A
> --
> 2.25.1
>
