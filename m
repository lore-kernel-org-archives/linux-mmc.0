Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EAAC18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D76520736
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mB8Jwl7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgCQL7J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:59:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37390 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL7I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 07:59:08 -0400
Received: by mail-vs1-f67.google.com with SMTP id o3so3540732vsd.4
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2020 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9bHMOuvx27abdwzYWOEGBv7nIxV9f5Nh+cOq0zid0w=;
        b=mB8Jwl7WEOEQ+2esrOEMlwyq86iqSV0FuFbbWOqRCU9mWvkvVq0NaSWANLBeqqLpId
         WaCDosuUTjEGiFt4NPBsD2alWYioI3+sOpkVI7aXglLgy4E8zglGF9Y67itJDsKNzfEA
         LULaKG92RKMLoo5pwhq+zepMJ8khcuDIuLjk+yFN3keHPfjcnHo/3APusxscG+uBLxSY
         yL+hzXIGQGBVEFdqeXlhXE5HWFQ2CBtYicgQiyyg05JXXItmgjMu4FhFXU5lkf3OFeT5
         Cf+H5PWdRsdmyB7beTYF+yn1bCm8x74weke7kOw9x73sZniCyTEykluxGFq2dEGHkCZk
         aRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9bHMOuvx27abdwzYWOEGBv7nIxV9f5Nh+cOq0zid0w=;
        b=I8TJCi1B3HAm3I8k7dj7j4XalupV2JihPAijwwWEAAORFYHQ9sgQLucIsRsjiY8ut8
         o8veJgC3JxlFy9fcqYLtTe9fyJw8G5fbWmc12db2KlEnfCwOyxEQNaftXaS66UybbqnE
         gTw5GdU2ljw7L8ee8jRwNTYLAYt/73ubJ13ingzM0SqgwdJ6u5JbkytcxxrVQT8P7ltz
         DuQ1te8W/lPHQ7ltxNOwSZ5+p8JKhhTVXXXdq/011Fz7AdNXYPDmO403R0LinUlPyqXE
         dFFQtbpCGvA+j68m2rVu259xlfcIdiqVrQVBE8Un7ZA4R12pf3P0s4HLECMxaUsxZJUh
         WMrA==
X-Gm-Message-State: ANhLgQ1I4a6F8M9xRCOS+GJx5+VtZ4xsnUw/51VKMtagvV3usjLxWv/5
        L481XkTY/DMLuduI7+TLqvfvaCV54N+K6/J9QxL7mXHE
X-Google-Smtp-Source: ADFU+vsb2NsPcQ3TTFAth84bRZdfBCnAN99f2A7Nq2sBlhlCuotPoJz1n3VkceKwSrIjuhuWHA9Mzju7KWk+XT9rHHU=
X-Received: by 2002:a67:a81:: with SMTP id 123mr3189452vsk.191.1584446347903;
 Tue, 17 Mar 2020 04:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200316184753.393458-1-hdegoede@redhat.com> <20200316184753.393458-2-hdegoede@redhat.com>
In-Reply-To: <20200316184753.393458-2-hdegoede@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Mar 2020 12:58:31 +0100
Message-ID: <CAPDyKFruNOU_Q4Vk70sC2+uibkK=X7UKaLTY7BjPn_i9Cbve9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-acpi: Disable write protect detection
 on Acer Aspire Switch 10 (SW5-012)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Mar 2020 at 19:48, Hans de Goede <hdegoede@redhat.com> wrote:
>
> On the Acer Aspire Switch 10 (SW5-012) microSD slot always reports the card
> being write-protected even though microSD cards do not have a write-protect
> switch at all.
>
> Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk which when set sets
> the MMC_CAP2_NO_WRITE_PROTECT flag on the controller for the external SD
> slot; and add a DMI quirk table entry which selects this quirk for the
> Acer SW5-012.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Drop the module option to allow overridig the quirks
> ---
>  drivers/mmc/host/sdhci-acpi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b4c1b2367066..2a2173d953f5 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -80,6 +80,7 @@ struct sdhci_acpi_host {
>
>  enum {
>         DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP                  = BIT(0),
> +       DMI_QUIRK_SD_NO_WRITE_PROTECT                           = BIT(1),
>  };
>
>  static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
> @@ -671,6 +672,18 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
>                 },
>                 .driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
>         },
> +       {
> +               /*
> +                * The Acer Aspire Switch 10 (SW5-012) microSD slot always
> +                * reports the card being write-protected even though microSD
> +                * cards do not have a write-protect switch at all.
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
> +               },
> +               .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
> +       },
>         {} /* Terminating entry */
>  };
>
> @@ -795,6 +808,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>
>                 if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
>                         c->reset_signal_volt_on_suspend = true;
> +
> +               if (quirks & DMI_QUIRK_SD_NO_WRITE_PROTECT)
> +                       host->mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
>         }
>
>         err = sdhci_setup_host(host);
> --
> 2.25.1
>
