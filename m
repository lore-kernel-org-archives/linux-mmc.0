Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED69C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 11:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhKYLWb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhKYLUb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 06:20:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280EC061574
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 03:13:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bi37so15413794lfb.5
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c7pv3lk/v/XxOqcblkhHM0Fv6juVYyeJis54FfJJJ0=;
        b=Spgx8gRrnJQabsSfsYpL2V3TJ6SMDzH2+uAYmqg7V4o/fJP2/z9RPUv8w1Pusvf7Vb
         NMYqNLdLzya6E8TR3s6RUzIoWwsoDJzOXi9QzjClny6e0UxsCqlxYEOoz3o9jqfsKR+w
         lH2f/yM+Te5VnYAPsUFGP+QpOJE6XhzOorbElB6kVgfH5dr0+r2VsWQ5eL/+hdUrUVGt
         XNicYDwsrVXeqrvXCQjyHZkKR0kJ3ye2TEhuwC8NPaqod1H6k/OXg5MP9kyaog3WI2X4
         a3zxQYD47pySVq4rSh1/Sb3KNztgDnrLj7HX/wo3ouvWeMIM3LSd2J3QCWvmq0K3y2lp
         FhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c7pv3lk/v/XxOqcblkhHM0Fv6juVYyeJis54FfJJJ0=;
        b=7W66zshbZ+HxbUDFP/kY6dLnK5Z3MBaIKccAwCyg2l28X8x/yKReCWhvwe4fIvX09s
         opDPnpIh92YsVPHqc5CHI1oi3Jc9j9Iz3rTtcIHXAixrL2jjud2iAYF5ztPohzd/e/Cz
         JC2SDvJQC4LdCzNqoFl+FyAuRbutVhon8dMXYUyFUYeWXvi8oGZvXUs2uI8X/Qf03Ndt
         xpIghdCH8l1CUQ2Gg8E7Sx84Zb7HsvgHvlmyyEtSjpLxHy7/pN/GPtvWczOFgffDGrFY
         HSDvFBRN6V5mXVg+/w+nNKq82XZiOtTdNV4mm6QrT7wlQz8R27R1pZeq7TA7fQX2CaFA
         quKQ==
X-Gm-Message-State: AOAM533M15+j5FfUf81ovcSckR1X7ecJhYX97ChAl148TkaJKkc1P/Bs
        Pxg4XnW74+DyVRaVUILw3iDicjhL3XxNjSe+40+dNQ==
X-Google-Smtp-Source: ABdhPJw2c1S1y6Kjvq0IaBVy77W/XbZBvp2Gyei6hzdxk7BLXof+v5OKUFfR4LpAO1ViPNPpdwkgoOomud9/Dd+VB7Q=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr22932741lfg.373.1637838814256;
 Thu, 25 Nov 2021 03:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20211124094850.1783220-1-adrian.hunter@intel.com>
In-Reply-To: <20211124094850.1783220-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Nov 2021 12:12:58 +0100
Message-ID: <CAPDyKFrAwo2aJRgsovzDbt8Herx48LfD9f0muBYQ8Z7q68VamQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add PCI ID for Intel ADL
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Nov 2021 at 10:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add PCI ID for Intel ADL eMMC host controller.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>  drivers/mmc/host/sdhci-pci.h      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 6f9877546830..ed53276f6ad9 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1866,6 +1866,7 @@ static const struct pci_device_id pci_ids[] = {
>         SDHCI_PCI_DEVICE(INTEL, JSL_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, LKF_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, LKF_SD,    intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, ADL_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(O2, 8120,     o2),
>         SDHCI_PCI_DEVICE(O2, 8220,     o2),
>         SDHCI_PCI_DEVICE(O2, 8221,     o2),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 5e3193278ff9..3661a224fb04 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -59,6 +59,7 @@
>  #define PCI_DEVICE_ID_INTEL_JSL_SD     0x4df8
>  #define PCI_DEVICE_ID_INTEL_LKF_EMMC   0x98c4
>  #define PCI_DEVICE_ID_INTEL_LKF_SD     0x98f8
> +#define PCI_DEVICE_ID_INTEL_ADL_EMMC   0x54c4
>
>  #define PCI_DEVICE_ID_SYSKONNECT_8000  0x8000
>  #define PCI_DEVICE_ID_VIA_95D0         0x95d0
> --
> 2.25.1
>
