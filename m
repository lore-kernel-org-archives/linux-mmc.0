Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21FFC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C716128C
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhEKK63 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhEKK6R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:58:17 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2FC06174A
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:11 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id s15so7141939vsi.4
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojLzUpP6F+Lkt3eqb6PEiJPewxNNPw/DbAO6AffxN7Q=;
        b=KrU081NfAptCNrbrWUx78l1oOfIjCpGIS1ZxXaxKWRfbVKo33BsO//YaRbJ7T0bHOB
         k7nCASHflgnd7JckNq6jz54unMJhyWEHI8NtR8IEgwgGUbe0ShHDbhc86PBEwaCIFAhU
         HoEjbGTC83hdQENRy0EShqo5clFQrICDDIwu8RoQYgRHkqYao2GUTuKgjMln0E7uR/Sn
         8Luq0NktXRsIflsmSJyyNm1yl5fPUSf29d8NVPcYhIXpciFFc9MVMvG5X6Gvpx6AgO/z
         2yLAARhdDiogEXFlqYx/gkrkae2jyeY9CtbZ2zpOcKsBhhkX09c5wTX8pFUL/PrAzDNT
         cAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojLzUpP6F+Lkt3eqb6PEiJPewxNNPw/DbAO6AffxN7Q=;
        b=hM84YntWoDLkm0qpbuk5wBUOdHD+DvTx4vy8nmFk6nIrjtIxBccq6MVuWmxa/tbBRS
         MIhWkw15y+dLpGvEEd4N8oRmm5rVn6+M9iLodeegyoaUmEsTTZjQroMS2MBXUjeJJyRA
         gOtkPBZFmNiadrvt5pVs+mtFM1FZnyw4kOdxlhUroJefFRffrxZdYB8t6dGXuj3fxNqD
         c8pzeLS+NjLo58qH85nATND8lv47RR75V+APkisB+KsaYmGHFZfF3jCTpgF628Y+omKd
         xemB+D4CjaORcoVawqZNzG2HZ04vfwioXoN89H+HlKTJf86SAXR5+XahKg++Nl6HCte2
         GbLQ==
X-Gm-Message-State: AOAM533ZHcTWhnjsfxpfd52kWTHFE+Uyxw9ZY4+zH9ntSh4VIO2qmZnY
        ifVDGJAHn4xpW7R0QHfaTXT45NRwTPwWqNytSdKVbQ==
X-Google-Smtp-Source: ABdhPJyN6CpwxDdnej+v959iqJCgLgyjBS8Ht01Ocwh5gsCH3FP+0wTEx3rSG/aUXiQCN60cyPMdg3wOIdajtn6xEV8=
X-Received: by 2002:a67:64c5:: with SMTP id y188mr23398053vsb.19.1620730630938;
 Tue, 11 May 2021 03:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210503092157.5689-1-hdegoede@redhat.com>
In-Reply-To: <20210503092157.5689-1-hdegoede@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:33 +0200
Message-ID: <CAPDyKFq2+SgWE7XAMWAQsC4Ud5YNx0E-CCsMgeDzN3b_wvwL-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Disable write protect detection on
 Toshiba Encore 2 WT8-B
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 3 May 2021 at 11:22, Hans de Goede <hdegoede@redhat.com> wrote:
>
> On the Toshiba Encore 2 WT8-B the  microSD slot always reports the card
> being write-protected even though microSD cards do not have a write-protect
> switch at all.
>
> Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk entry to sdhci-acpi.c's
> DMI quirk table for this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied for next, thanks!

Should we tag this for stable?

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b6574e7fd26b..9e4358d7a0a6 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -820,6 +820,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
>                 },
>                 .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
>         },
> +       {
> +               /*
> +                * The Toshiba WT8-B's microSD slot always reports the card being
> +                * write-protected.
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA ENCORE 2 WT8-B"),
> +               },
> +               .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
> +       },
>         {} /* Terminating entry */
>  };
>
> --
> 2.31.1
>
