Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73714C4360C
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E464F45
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCSONc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhCSONR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:13:17 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C4C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:13:17 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id h25so3546458vso.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uafdnfiJzIvKurj0qcQE3+fQ0RdZsmqs2/6mKqo2E10=;
        b=al22ctb4JVkjksBULRPtWtQB/RI8XSnov+BpRGt1XvvVhFdqbpULM591LL6u9ZRpeF
         rUNEr+0L3lgpi5JoNtZkM7MJakqKutVYdLsFwMcvid8sVDblknXc8EXTE9KKxevzAxuV
         yWVQXHb3iiVNsygAqpmidHDLgbal0UQgfoSopzxKpRT7DHd2nrcYIF7WvDmsLr/wlmRt
         wKUDM6jDuCNVzu7uC7xrEcAxHfiMslMJ1N0330pBEJHELDc9uxdqQEH1iAJ+dxJNWiPR
         66Ro8AGPCkk037ACUY/e0jQzkKdpRu4J+qkOy2slKTdWS5ArHZBtWMEyhPmslnG10nGQ
         AIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uafdnfiJzIvKurj0qcQE3+fQ0RdZsmqs2/6mKqo2E10=;
        b=KAWGsGEoKCcMRMZRkX25RCE4xgzUw1GGqOpuH1fHM8a8K+x875NF1S6IwjBkyuTy2J
         ItZ8Z2JZ4D58Cu0rxSd+bqHrGST2yVGglWTa+K1FQGR1+E3CPAM4n1unuriAGCCxvdH5
         /S0W9QMha1GRcZPpmDtQhN/pTcc7FPLWNTL2x5nYXsDL4NApN7tLlMyig97d5ggFIe+O
         GoDl1o4Ph10NUxNMJBq1h7wMTuVfMYLYqGn+DoLo89xMKsHP5ey/03NQeUi1i0Q9nYFp
         Cl0Vi6zipWdvX5Fl6UuEGVgja7ur1ZsE+N0LBZh1h/M09BaN6q/+zns2gYWNiNtRPzHy
         YD6g==
X-Gm-Message-State: AOAM531AuQPsDhGEigvQo0sz8llvZbNxVCpfUq7yrnlltqzMfD50TesN
        itM2PmkDG4kNK8KPN3juy9hd+Wfbu9McQ/1qsyS1L9eJMfRYtw==
X-Google-Smtp-Source: ABdhPJwfsLNAHuqowqPMNFrPCjZtrqcKdtoUhzKvIy7PthSVSu8qU0872j6D9OWsCCC/CIBF1PuM00+mC3t0GO6YM9Q=
X-Received: by 2002:a67:6942:: with SMTP id e63mr2910540vsc.48.1616163196799;
 Fri, 19 Mar 2021 07:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210318124025.3002861-1-james@pocketfluff.org>
In-Reply-To: <20210318124025.3002861-1-james@pocketfluff.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:39 +0100
Message-ID: <CAPDyKFo69ap+XxTRx8sry=j4va=27zP1qxsDnLziUyFX3+=MAQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Add device ID for the AMDI0041 variant
 of the AMD eMMC controller.
To:     James Young <james@pocketfluff.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Mar 2021 at 13:42, James Young <james@pocketfluff.org> wrote:
>
> This variant is present on a Lenovo IdeaPad Slim 1, which uses an AMD Dali/Athlon Silver 3050e.
> The Windows AMD SD Host Controller driver also lists this as a valid device ID.
>
> Adding this device ID makes the internal eMMC storage on the Lenovo accessible.
> Consequently this makes Linux installable and usable on it as well.
>
> Signed-off-by: James Young <james@pocketfluff.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b6574e7fd26b..c3fbf8c825c4 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -772,6 +772,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>         { "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
>         { "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
>         { "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
> +       { "AMDI0041", NULL, &sdhci_acpi_slot_amd_emmc },
>         { },
>  };
>
> @@ -789,6 +790,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>         { "QCOM8051" },
>         { "QCOM8052" },
>         { "AMDI0040" },
> +       { "AMDI0041" },
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
> --
> 2.25.1
>
