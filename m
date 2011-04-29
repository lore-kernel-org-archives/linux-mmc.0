From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 0/2] add call backs in sdhci-pxa.c
Date: Thu, 28 Apr 2011 23:52:45 -0400
Message-ID: <BANLkTimN6VcwAijjLLmZ1NOsOb9VvEWYmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58655 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1D2Dwq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 23:52:46 -0400
Received: by qyk7 with SMTP id 7so73829qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 20:52:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi, Chris

Could you help re-check these patches submitted before.

These two patches introduce several call backs in sdhci-pxa.c

patch 1: move sdhci_priv and sdhci_ops definition to
include/linux/mmc/sdhci.h from drivers/mmc/host/sdhci.h
1. platfrom could directly overwrite sdhci_ops with soc specific ops,
this case occurs at different controller share the same driver, while
different ops they may use, so move sdhci_ops definition to include
2. platform code will use sdhci_priv to access host->private

Patch 2: Introduce several call backs.
pxa955 may require external gpio to detect card insert and remove.
soc_set_ops is used to overwrite host ops directly from platfrom ops.
