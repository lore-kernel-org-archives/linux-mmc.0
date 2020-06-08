Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0392CC433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EA120774
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 07:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbjzzPoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgFHH6D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFHH6C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 03:58:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811BC08C5C3
        for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2020 00:58:02 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id b10so4343087uaf.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usa2O3VnVimdZz2QFTyqirZyCnD9v7o6Y9XSy9l9BZQ=;
        b=jbjzzPoj1LdiFFNG5vJNANcVDGSPSpfEkRZwfsXF2gcUG29xQOQ5oBYLYDNYasI49I
         q12WRMFRu5cwpEFK6YLSextAJTw7PO/wRgSurkZ5iUZzifmeNrzA51kCfdysGz0G7Heb
         6I7agqBH1Om4sLhJZzpWfdS3ceapyJEhD3lNVh/OEO2jo9vN8CkycHhGu8lZYqCcRPSp
         yqVYPRA1T+1bvpK8KnO2w48bz388aSvitb4TdfKav/g+lHY4+PJnrPNBm+LeZOR9UDyr
         MZHh87ce+FVZZ/sF6gQgyZpgEbterGO0d3j5PTKNrwyyTe44yPaLu/h4SwgHuB4EDUW0
         m/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usa2O3VnVimdZz2QFTyqirZyCnD9v7o6Y9XSy9l9BZQ=;
        b=Ddob6WLrxHPsOgKLcbnZcS3syMRXhWPZCjXC2z/KmLfDGrxOjuU0zGNSv344vvxVzJ
         5KbCuiX9y9a9st14OBU8NbzNOoFAIphMpUTzHJQoD6AlMMtJpsorLRkWTFIRh6lnDtC6
         1LSXziwu07l9OMIKA2/O8VRB7VM6dYdHPLAx3lL1Sz2EgVmP3OhFUq1w64YIC50FjQ8W
         dhv/6PEcXgwqzfLJUTfmGf67ietcvi8RghfLaB8jZGOq8yZ2llwX48z9T690R8gGPK12
         m5KXHoecF+3OlTHOPIwoEXanedtKzTXCZ9j2tuUuS5MrgwlK5kUl+e6JRv5n1Bj+B3N9
         6vRg==
X-Gm-Message-State: AOAM530WNKI8c35w8fJVgoMpz1dCBJKwwC57B6PjFf27EAFMiOQSCd1R
        E567dW34n+5LoHrjh4sXDghXPLE+FYaJ5jCseXxYGQ==
X-Google-Smtp-Source: ABdhPJzHPVZcT9fOcq/5mnEdYXiSTcCK3xCGQDgTq7ZQjol8t3AS01de6pjkoygr26G7tmIC54OyjHigWPcFrcXu7tU=
X-Received: by 2002:ab0:186d:: with SMTP id j45mr15425936uag.104.1591603081439;
 Mon, 08 Jun 2020 00:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <1589887988-7362-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1589887988-7362-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jun 2020 09:57:24 +0200
Message-ID: <CAPDyKFq5yueXp4NW2fj3tvPRv0S_VDM1khAw51VeEHxG79qp+Q@mail.gmail.com>
Subject: Re: [PATCH/RFC] mmc: core: Issue power_off_notify for eMMC Suspend-to-RAM
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 13:33, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> The commit 432356793415 ("mmc: core: Enable power_off_notify for
> eMMC shutdown sequence") enabled the power off notification
> even if MMC_CAP2_POWEROFF_NOTIFY (MMC_CAP2_FULL_PWR_CYCLE now) is
> not set. However, the mmc core lacks to issue the power off
> notificaiton when Suspend-to-{RAM,Disk} happens on the system.

This isn't an entirely correct description, I think.

If the host supports MMC_CAP2_FULL_PWR_CYCLE (both vmmc and vqmmc can
be powered on/off), we use power-off-notification during system
suspend, in case the eMMC card also supports it. Otherwise we send the
sleep command.

This behaviour was decided on purpose and it's mainly because without
MMC_CAP2_FULL_PWR_CYCLE, we assume that vqmmc remains always-on. In
this case, it simply seemed better to use the sleep command, rather
than the power-off-notification, as we aren't really going to do a
full power off anyway.

Kind regards
Uffe

>
> So, add Suspend-to-RAM support at first because this is easy to
> check by using pm_suspend_target_state condition on _mmc_suspend().
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/mmc/core/mmc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4203303..4a23f83 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/suspend.h>
>  #include <linux/pm_runtime.h>
>
>  #include <linux/mmc/host.h>
> @@ -2027,6 +2028,12 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         int err = 0;
>         unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
>                                         EXT_CSD_POWER_OFF_LONG;
> +       bool s2ram = false;
> +
> +#ifdef CONFIG_PM_SLEEP
> +       if (pm_suspend_target_state == PM_SUSPEND_MEM)
> +               s2ram = true;
> +#endif
>
>         mmc_claim_host(host);
>
> @@ -2038,7 +2045,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>                 goto out;
>
>         if (mmc_can_poweroff_notify(host->card) &&
> -               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
> +           ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend || s2ram))
>                 err = mmc_poweroff_notify(host->card, notify_type);
>         else if (mmc_can_sleep(host->card))
>                 err = mmc_sleep(host);
> --
> 2.7.4
>
