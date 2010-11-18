From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH v2 0/1]mmc: check SDIO card wake up during suspending
Date: Thu, 18 Nov 2010 10:18:48 +0800
Message-ID: <AANLkTikP7o=H6MC9LYVm=TKMZtj2Y=o7DAq3NEHXx8o+@mail.gmail.com>
References: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37553 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab0KRCSw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 21:18:52 -0500
Received: by iwn35 with SMTP id 35so2867058iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2010 18:18:52 -0800 (PST)
In-Reply-To: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Michal Miroslaw <mirqus@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Change against v1:

Minor fix: add check return value in sdhci_suspend_host.
               Fix checkpatch.pl warning




    mmc: check SDIO card wake up during suspending

    It is possible that SDIO card send card interrupt to wake up
    system just after SDIO func driver and SDIO card firmware commit
    suspend state, while system is still in suspending process and
    mmc interrupt is not release yet.

    Interrupt storm may happen if func driver does not notify firmware
    to clear the wake up source. If func driver issue SDIO bus transaction
    to have firmware clear the source and driver continue to handle the
    wake up event, system may enter suspend before all transaction done.
    In this case, SDIO card will not enter lower power mode never. But
    system can not be wake up for only card insert/remove/interrupt irq are
    listed in wake up source in SD spec. Data/command done irq can
    not wake up system.

    This patch check SDIO card interrupt and stop system suspend if there
    are card interrupt after func driver suspend.
