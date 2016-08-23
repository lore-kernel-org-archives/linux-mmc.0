From: Joaquin Jimenez <jjimenez@twonav.com>
Subject: MMC -84 error.
Date: Tue, 23 Aug 2016 23:02:38 +0200
Message-ID: <CAEbvwU4Do=rqVZU-Jhme6EbkhR7foeNU-gWXeO9r+KuPBQpZCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33459 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755601AbcHWV0q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2016 17:26:46 -0400
Received: by mail-yw0-f170.google.com with SMTP id r9so80586024ywg.0
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2016 14:26:17 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I am trying to bring up a wifi driver (wl1837 from TI) with no success
on a custom kernel 3.18.10  (Exynos Odroid). The same driver
(backported from 3.17) works fine in another platform with a 3.14
Kernel. The problem seems to be the mmc not the wifi driver.
Everything works fine until it tries to send a CMD53 command:

[  545.724775] mmc1: req done (CMD52): 0: 00001004 00000000 00000000 00000000
[  545.724786] SDIO: Enabled device mmc1:0001:2
[  545.800123] mmc0: starting CMD13 arg 12340000 flags 00000195
[  545.800148] s3c-sdhci exynos4-sdhci.2: selected source 2, clock
50000000, delta 1111112
[  545.800175] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  545.800189] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  545.925214] mmc1: starting CMD53 arg a7ff8804 flags 000001b5
[  545.925266] mmc1:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms nsac 0
[  545.925369] s3c-sdhci exynos4-sdhci.3: selected source 2, clock
50000000, delta 1111112
[  545.925499] sdhci [sdhci_calc_timeout()]: mmc1: Too large timeout
0xf requested for CMD53!
[  545.925602] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00208003
[  545.925692] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  545.925726] mmc1:     0 bytes transferred: -84

It takes around 0.3 ms to catch the interrupt, compared to 7 ms in the
working platform.
I cannot figure out what the problem is. Please could you help me to
understand what's going on? Is it a known bug?

Thank you in advance.
