From: Barry Song <21cnbao@gmail.com>
Subject: [RFC] MMC: CMD52 During Data Transfer support
Date: Mon, 9 Feb 2015 11:14:48 +0800
Message-ID: <CAGsJ_4xeWOXtav4HhpB_4XhkXHqS4+V81tSw4LGT3Yvtq79qxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43123 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759272AbbBIDPI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Feb 2015 22:15:08 -0500
Received: by pdev10 with SMTP id v10so5429157pde.10
        for <linux-mmc@vger.kernel.org>; Sun, 08 Feb 2015 19:15:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Yonghui.Zhang@csr.com, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, yongsheng.liu@csr.com

hi Chris, Ulf,
According to https://www.sdcard.org/downloads/pls/simplified_specs/archive/partE1_200.pdf
(section CMD52 During Data Transfer ),
A card may accept CMD52 during data transfer if it supports Direct
Commands (see SDC, Table 6-3). For both SD and SPI modes, if an error
occurs during data transfer the SDIO card shall accept CMD52 to allow
I/O abort and reset regardless of this bit value of the value of SDC.

But drivers/mmc/host/sdhci.c doesn't support this mode if i didn't
miss something:-) we need it now to improve he throughput of a high
speed Software Digital Radio SDIO card. so we'd like to add support
for it.

a simple idea is

1. we need to drop this WARN_ON:

1343 static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
1344 {
1345         struct sdhci_host *host;
1346         int present;
1347         unsigned long flags;
1348         u32 tuning_opcode;
1349
1350         host = mmc_priv(mmc);
1351
1352         sdhci_runtime_pm_get(host);
1353
1354         present = mmc_gpio_get_cd(host->mmc);
1355
1356         spin_lock_irqsave(&host->lock, flags);
1357
1358         WARN_ON(host->mrq != NULL);

2. we need to permit a new command to execute even when host->mrq is
not NULL and a CMD53 is ongoing.
this means we might add a new cmd52 request field in host struct to
buffer CMD52 request. and after the cmd52 finishes, we still need the
capability to wake up the blocking thread.

I'd like to know your suggestions on this feature.

-barry
