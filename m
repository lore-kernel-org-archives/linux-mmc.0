From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5, 2/5] mmc: sdhci-of-esdhc: add support for signal voltage switch
Date: Thu, 20 Apr 2017 16:06:06 +0200
Message-ID: <CAPDyKFpcTGp2sfF0yvFVv7mntphjbHvk_ofZ9YjvTWVSOcS79Q@mail.gmail.com>
References: <1492676084-28218-1-git-send-email-yangbo.lu@nxp.com> <1492676084-28218-3-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33558 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032024AbdDTOGN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Apr 2017 10:06:13 -0400
Received: by mail-ua0-f182.google.com with SMTP id j59so7828864uad.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Apr 2017 07:06:13 -0700 (PDT)
In-Reply-To: <1492676084-28218-3-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

[...]

> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               val &= ~ESDHC_VOLT_SEL;
> +               sdhci_writel(host, val, ESDHC_PROCTL);
> +               return 0;
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               scfg_node = of_find_matching_node(NULL, scfg_device_ids);
> +               if (scfg_node)
> +                       scfg_base = of_iomap(scfg_node, 0);

Why don't you do this at probe time instead of every time you do the
voltage switch?

Never mind at this point, I have queued this up for 4.12, however feel
free to send a new patch on top.

> +               if (scfg_base) {
> +                       sdhciovselcr = SDHCIOVSELCR_TGLEN |
> +                                      SDHCIOVSELCR_VSELVAL;
> +                       iowrite32be(sdhciovselcr,
> +                               scfg_base + SCFG_SDHCIOVSELCR);
> +
> +                       val |= ESDHC_VOLT_SEL;
> +                       sdhci_writel(host, val, ESDHC_PROCTL);
> +                       mdelay(5);
> +
> +                       sdhciovselcr = SDHCIOVSELCR_TGLEN |
> +                                      SDHCIOVSELCR_SDHC_VS;
> +                       iowrite32be(sdhciovselcr,
> +                               scfg_base + SCFG_SDHCIOVSELCR);
> +                       iounmap(scfg_base);
> +               } else {
> +                       val |= ESDHC_VOLT_SEL;
> +                       sdhci_writel(host, val, ESDHC_PROCTL);
> +               }
> +               return 0;
> +       default:
> +               return 0;
> +       }
> +}

[...]

Kind regards
Uffe
