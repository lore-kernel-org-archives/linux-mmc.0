Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B4CCA47F
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiFOReC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358002AbiFORdr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524FEE025
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a29so20031547lfk.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Rr2/eFmxSAglu7fgH0ivcyA6RJfSroBIvj7zrPlOBU=;
        b=HFHHH4bG6XUFH+LKI17JGgJ8AKrAJBHUzfbDn3x4RDSDfoQY0M6TAKHWcCaT0yhnyg
         BG3C8lBlZbJzJ17vopxWHWk1LB8Vt42BDaGOM/UilOyXwiwtbRrQnl3pYnHkdxx8xeRr
         DWJGdvPU0pjyFq8ADPhI0Y8sXT3A6wygCnyZTaLtXGWsYBDzcAjnu7wLT+faXGXCbKAY
         1L2KMdzSUYHXjl1RpXVFrlbdFfTy/zJGW67Be8fZdcx3Qm5mDEMzHGtmgxvroQ9HkZwe
         yZKwx5oxqfqfh6AdAZR61io6dsb8hxhiaNBRs6PO04kG7GzuXvAvyg+lhxj/34I35f2I
         rndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Rr2/eFmxSAglu7fgH0ivcyA6RJfSroBIvj7zrPlOBU=;
        b=g4ob1mWVMK1AybqNBQKoKSokDxi4nb+cNt/r/dpNAOJZ8Z9H4M+CvZUTSR7OXxLhVR
         mTFWQgG0weo8Gfzaa7n5WsJ8hzNjwDYUzHJMsSzG3zmoUDNzhZLXJqCtJBaXn0aUXwep
         EZu5g7TKUhS/AASZ0KC4BEszIMDdo+qJUw4ndPmbhWAAOMKfJ0Iou6eQqeCYrBLqK9Bf
         KTTsH2muienmur+aGqm9wAWIhs79VK+VnwFbzQFFtjJgzDqgLumOtox8MNsGdjBvQ3ME
         P8n/yhaQqzgsCcESDFNFwh7q9HXkhao1UkpBMqU7wkaGhPaNjlB8QcClDbCsTvw8rWGp
         LZkg==
X-Gm-Message-State: AJIora8UWIixu60raFg44BnK86O2AsxXTk3C+3P6HPVeZtKrvXJajHuz
        yUrGvHf8jVprC+mTUijF01HaXJBfCNGZ/QAowBzs8S0wyFH+pw==
X-Google-Smtp-Source: AGRyM1vRuShCsbq4w/fiDCkBOJhXMwRtkt/9aZmNJtPKoMFMDk9OvBZz2yhq88m+xvY9yFgkiCk//6NZUCNC6p7TjJc=
X-Received: by 2002:ac2:54b9:0:b0:479:a29:c1ec with SMTP id
 w25-20020ac254b9000000b004790a29c1ecmr341871lfk.358.1655314425841; Wed, 15
 Jun 2022 10:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220614113905.1458715-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20220614113905.1458715-1-alexander.stein@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:33:08 -0700
Message-ID: <CAPDyKFpnYRCRbeY-cP3gH+tVTHMCkoxyBhb+xLHxjsg=kx2YWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: host: Do not evaluate HS400 capabilities if bus
 has no MMC capability
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Jun 2022 at 04:39, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> If 'no-mmc' is set but 'no-mmc-hs400' is not, this warning is raised.
> Specifying 'no-mmc' should be enough though.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2ed2b4d5e5a5..0fd91f749b3a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -599,7 +599,7 @@ static int mmc_validate_host_caps(struct mmc_host *host)
>         }
>
>         if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
> -           !(caps & MMC_CAP_8_BIT_DATA)) {
> +           !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
>                 dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
>                 host->caps2 = caps2 & ~MMC_CAP2_HS400_ES & ~MMC_CAP2_HS400;
>         }
> --
> 2.25.1
>
