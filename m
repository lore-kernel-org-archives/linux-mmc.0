Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC830C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKPQSj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiKPQS2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C8D102
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z26so17935329pff.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MREtAUfxs6GCst+sbJtxXnuebNaO0we0LsQex+TRU2U=;
        b=YLKq9e4PxYelcy/1KPygzAiYgdw8nlP6lKihqNoi9Y17n80NqwrX7bnjGYO2n6+Pjc
         iWHbM0ZUxLweKn49DXFmxaF8aKK+qm8YxCudYVFC/dqTSnojRvz2jP7/HRtizz/9uWf4
         ysuDkob+2xwBSqVJ2VcUPqZvBOd0FDQXkeKzziytY7IiALjsVluv4I3TxhQ1cmjIo86k
         mzEhRsMkPd6gUeJ7NjUFkycMuvv6eqBelMc3dB2jhq8j6oftGq3/jzhnaQaHvePeUgyJ
         vJgHVceMUOkPMOt9+trpOgvpXDApYB7ZsoZU3W+51UqLBgsiJv9apXELI7BoAQwAvRm3
         gsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MREtAUfxs6GCst+sbJtxXnuebNaO0we0LsQex+TRU2U=;
        b=hOjuaXdydzCavjjTfguh8uPwgIRv70qpIlE5A15iJeS51Fip5OjUsCOvKoWhC5rb48
         tNSEmRVQnT8ES0hm83m34uJ5Lpqa8t7A6TZxNNr7YibnlNte5+2xtz8K5y7ugZ5xQcrK
         5kblI1c3wwm3fj8XD6Zt7EEXKwKAwq9nzzZKwW5WBh2+6UM8jJx158JHTmnxeCbKZc7J
         rpjoHoFGoDd2VPEjdRtCVLtCqV4GwFAaTY9xnr9BJq7YurQSaX3/virWnAlYei3+3ros
         AhVvVbZbCFHPxPUuZAvJ/QR2DFctbNzQijflDrAZBkqKiEeE08Od+V/iLP492tjg4Wf+
         R1nQ==
X-Gm-Message-State: ANoB5plXD4rbOUt1LJvFyg+1qaykxSebW7+P4jBH6bcongUXUbD9cNrd
        tKpt6LJK994HgROAIn/rp8svSnhe+SBygdXxoAzv0Q==
X-Google-Smtp-Source: AA0mqf4F0lyT1wk9YUOyeZAUc29cp7zNk2+3Hkto8+6/lrQNH0m8Wm2FixIImon1tq2RsUCoFACQ7np/rcGJJIGUEn4=
X-Received: by 2002:a62:b41a:0:b0:56e:ad31:b98b with SMTP id
 h26-20020a62b41a000000b0056ead31b98bmr23633887pfn.40.1668615506428; Wed, 16
 Nov 2022 08:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20221114083100.149200-1-wangxiongfeng2@huawei.com>
In-Reply-To: <20221114083100.149200-1-wangxiongfeng2@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:49 +0100
Message-ID: <CAPDyKFr0moQtkLyP06CYe8pNnhmL1wL=2odBQW_S0FQhhznxZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix possible memory leak caused by
 missing pci_dev_put()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     adrian.hunter@intel.com, ben@decadent.org.uk, treding@nvidia.com,
        linux-mmc@vger.kernel.org, yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Nov 2022 at 09:12, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
> pci_get_device() will increase the reference count for the returned
> pci_dev. We need to use pci_dev_put() to decrease the reference count
> before amd_probe() returns. There is no problem for the 'smbus_dev ==
> NULL' branch because pci_dev_put() can also handle the NULL input
> parameter case.
>
> Fixes: 659c9bc114a8 ("mmc: sdhci-pci: Build o2micro support in the same module")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 34ea1acbb3cc..28dc65023fa9 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1749,6 +1749,8 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>                 }
>         }
>
> +       pci_dev_put(smbus_dev);
> +
>         if (gen == AMD_CHIPSET_BEFORE_ML || gen == AMD_CHIPSET_CZ)
>                 chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
>
> --
> 2.20.1
>
