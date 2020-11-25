Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE1C63777
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727F620872
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFeJoVJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKYKEb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgKYKEb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 05:04:31 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91534C0613D6
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 02:04:18 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m6so369090vkl.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoCTnhDdmiyu7Di22E5w97TgLxSYJBtIV21K0S5sGl4=;
        b=qFeJoVJSvbS05seM+zDaJZKd+q2yG+sk6A8GszNHA9lE/OIq1Sj0FRC1VEN2jO7xID
         LiXX5TvRWjExYuw0naWrF/6M1mvy3CiiEdJRiG+DM3xlZ9mkt5GJ0dkc5WAvM4zTPOUo
         5CdaXlNxQgZ7LqA7tqwCU8BQoTdqadVxtD+xkhmvtZ3mbTB0AsyYqsMtYi0llg1vfVWt
         EiF67f9zL5t4nrzx8+PO7D0Jacg6rT+uN5hm/UDFd33Oc/6kwL1KCXOG02ewFxbxm4ej
         dvvMWGnzxvk25bPaozM0diZhm8w9lUTlT1Y1MdxlWqxZEXDed7yuwaKO/gwzN7286WJy
         k+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoCTnhDdmiyu7Di22E5w97TgLxSYJBtIV21K0S5sGl4=;
        b=BjhwV5/Oe3TZHDUrN/8ihdVvlSr8RgmZpjIZ1PnhK5pY1vOHLb7rRC687PFZsRjmkO
         VGNWzILSZm9oHkQBggTKxg9t8zGGDQxNKcV9RuPW2jMFo4nzdzeRo0wKptAhWF0N59zy
         CmkTPmePtK+QG2NGmzYhiqzoB/Sqs+RJW9ufbvz2qnE/xoq1UwduVytYhVTdMZY8Eg8I
         EOD4tNhrjLrywvsgWW5sMF83KguuYsM9mcduXnpsigjGhkOTU8g313CDkSmSV1nJPZ6F
         h6hE0CgpB4n1s985RzCEZXWYdWu/NZQQbHMjOtxmnLxmMwfmISMTKMXGQKxtzimfnDf/
         fMiA==
X-Gm-Message-State: AOAM530uL0Nke8urNZ46xzSTYB4MXvKHnH84P5dDQy52OMjIg7CxAV5w
        fKr2wKCBDc4WHX8zxBeC+KIKwEqWSHHyHXK6AWDgdRFUEbjeYg==
X-Google-Smtp-Source: ABdhPJwd3HM+w1CxiEdPo/CW5K0JMpnjXCgTmByiTgthqXSiBjUH6rZIRvwws3vZA6mdSE6uu9lNksyg9rnQeP9TzmM=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr1615929vks.6.1606298657728;
 Wed, 25 Nov 2020 02:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20201125100004.1288-1-benchuanggli@gmail.com>
In-Reply-To: <20201125100004.1288-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Nov 2020 11:03:40 +0100
Message-ID: <CAPDyKFp_3Vpq6ZRm5Qm1Zningz9tDqQLS_E78a8ChYHVbofB9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Nov 2020 at 10:59, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
> to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.
>
> Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")

Why a fixes tag? This patch looks like an improvement and not a fix, right?

Kind regards
Uffe

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9887485a4134..d45d7e529150 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -87,6 +87,9 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_MMC_CTRL  0x960
> +#define   GLI_9763E_HS400_SLOW     BIT(3)
> +
>  #define SDHCI_GLI_9763E_CQE_BASE_ADDR   0x200
>  #define GLI_9763E_CQE_TRNS_MODE           (SDHCI_TRNS_MULTI | \
>                                     SDHCI_TRNS_BLK_CNT_EN | \
> @@ -764,6 +767,10 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= GLI_9763E_SCR_AXI_REQ;
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, &value);
> +       value &= ~GLI_9763E_HS400_SLOW;
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.29.2
>
