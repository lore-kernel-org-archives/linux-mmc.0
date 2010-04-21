From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: mmc: sdhci.h compile error
Date: Wed, 21 Apr 2010 19:43:32 +0800
Message-ID: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:60852 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab0DULnd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2010 07:43:33 -0400
Received: by yxe29 with SMTP id 29so3559462yxe.4
        for <linux-mmc@vger.kernel.org>; Wed, 21 Apr 2010 04:43:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: zhangfei.gao@gmail.com

Hi,

I have one compile issue about sdhci.h.

There is compile error when we enable CONFIG_MMC_SDHCI_IO_ACCESSORS,
and include header file #include "sdhci.h"
error: macro "writel" passed 3 arguments, but takes just 2

#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
{
        if (unlikely(host->ops->writel))
                host->ops->writel(host, val, reg);
        else
                writel(val, host->ioaddr + reg);
}

~~
#endif

The writel is treated as macro and it is already defined in ARM.
The workaround is modify the name of ops writel.

Is there anybody also see such issue, and my platform is ARM.

Thanks
