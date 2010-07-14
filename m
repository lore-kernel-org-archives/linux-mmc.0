From: Kyungmin Park <kmpark@infradead.org>
Subject: s5pv210: Why don't use the FIFO for Tx/Rx at MMC
Date: Wed, 14 Jul 2010 17:11:40 +0900
Message-ID: <AANLkTilTnE4wDBgS5kxh_kosJjcVHwPKp-oye8aKPjmn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56352 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab0GNILp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 04:11:45 -0400
Received: by pzk26 with SMTP id 26so1546318pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jul 2010 01:11:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, arm-linux <linux-arm-kernel@lists.infradead.org>, Ben Dooks <ben-linux@fluff.org>, Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?B?7KCV7J6s

Hi,

In mmc card configuration it don't use the FIFO control for Tx/Rx. Can
you explain it?

In the spec it can support 512 bytes FIFO for data Tx/Rx.

void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
                                    void __iomem *r,
                                    struct mmc_ios *ios,
                                    struct mmc_card *card)
{
        u32 ctrl2, ctrl3;

        /* don't need to alter anything acording to card-type */

        writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r + S3C64XX_SDHCI_CONTROL4);

        ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
        ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
        ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
                  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
                  S3C_SDHCI_CTRL2_ENFBCLKRX |
                  S3C_SDHCI_CTRL2_DFCNT_NONE |
                  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);

        if (ios->clock < 25 * 1000000)
                ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
                         S3C_SDHCI_CTRL3_FCSEL2 |
                         S3C_SDHCI_CTRL3_FCSEL1 |
                         S3C_SDHCI_CTRL3_FCSEL0);
        else
                ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);

        writel(ctrl2, r + S3C_SDHCI_CONTROL2);
        writel(ctrl3, r + S3C_SDHCI_CONTROL3);
}

Thank you,
Kyungmin Park
