Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CCC54FCB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A671215A4
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaYpQw6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDVQEf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgDVQEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 12:04:35 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FDDC03C1A9
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 09:04:35 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z16so2177219uae.11
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sm3XxUq0SE3ULIMiH8ecv1DgDDpL+3IsIH7cBnRdfDw=;
        b=RaYpQw6K16sM1hMTjoTxgA/RdcNH3WI3futdQv1kBuPYlDeG3bf7oPU0UGkzsQbORC
         hLDrOdIHi4vITeO87Vkb2QmEggKRt9/6z+l7E+OFnHoTQeXUn88RhAGb5ZSl5CTqyG//
         WF/dUD7QasJ30h3300F5juHcDIo9XoG1Buz72UTiPNde/amttJ+5lXuwM/yGQeSBwCQW
         XPJYriJvNOzlAzVM43WPgjDXkU8UcM0l4NN0bRlU3JjEbZQvx5rihNkgk4I9Qh/fCxmY
         dzkMHVHeAWqO2gYfSFKo5z1BRzE9CmmlNqVLUlTodD9iiGdf/btL1DsiiZL1IuLmjXbl
         xuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sm3XxUq0SE3ULIMiH8ecv1DgDDpL+3IsIH7cBnRdfDw=;
        b=nIk5Z2xgigrRwuqXnyOPh6XA/NJ2VVLYDnQH7lq9T3dV0RinA/Y/GOXUPYtCG97Qrn
         TAHOfWdaiZ/XRcvF5rEJO1fIh7jOILXQnSzfTdaazDCrR+Gu+gsQKuXtfNT70yWY//XE
         0X2W46S9SdlRreC/V22u9Qr6jW533yvbZ1FG1MA3Pqd3WPrNgfXPTR4gJQ9s0X34EbSS
         ZRrnGewPNFHG035/xX31lcsw+/HSh2T+AOUM5O2ZVnR5TmZXQdmFKIwsjbbyyNm3H6lt
         mIjZKe7RABFN1yf52FC4MyF63P5kM16ukdgS6nOAhYnqnZ3I6EFe/Ho6ZYlMwB4twTws
         Jltg==
X-Gm-Message-State: AGi0PuaSC/Rx6fz/JugQwgoLJDbfAKWVrgYd4FCnrseHGfVs2Mt3VCMJ
        3KwjqyCUOmFbjaeWAFnlWUqLkIDbJHOG7pzAkhxCCALp
X-Google-Smtp-Source: APiQypJc67HG6oXPbrCN10mQ7/ErePhM34gZdS/boaFiBMNoYSLHnVu6VxXxj7H30SHQmir0MEowkiWtSIzspTnFJFc=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr20429056vso.200.1587571474237;
 Wed, 22 Apr 2020 09:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200422111629.4899-1-adrian.hunter@intel.com>
In-Reply-To: <20200422111629.4899-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Apr 2020 18:03:58 +0200
Message-ID: <CAPDyKFrzgEyQHkE7KeaGvGzLRRDxJNZjZP-r9JtpyHxD9HVtPA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 22 Apr 2020 at 13:17, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> BIOS writers have begun the practice of setting 40 ohm eMMC driver strength
> even though the eMMC may not support it, on the assumption that the kernel
> will validate the value against the eMMC (Extended CSD DRIVER_STRENGTH
> [offset 197]) and revert to the default 50 ohm value if 40 ohm is invalid.
>
> This is done to avoid changing the value for different boards.
>
> Putting aside the merits of this approach, it is clear the eMMC's mask
> of supported driver strengths is more reliable than the value provided
> by BIOS. Add validation accordingly.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 51ced59cc02e ("mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices")
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index a98c9476bfc8..af736afb4b91 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -597,6 +597,9 @@ static int intel_select_drive_strength(struct mmc_card *card,
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
>         struct intel_host *intel_host = sdhci_pci_priv(slot);
>
> +       if (!(mmc_driver_type_mask(intel_host->drv_strength) & card_drv))
> +               return 0;
> +
>         return intel_host->drv_strength;
>  }
>
> --
> 2.17.1
>
