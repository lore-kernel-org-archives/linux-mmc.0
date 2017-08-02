From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: rk3288: mmcblk0: error -110 sending status command, retrying
Date: Wed, 2 Aug 2017 16:39:50 +0530
Message-ID: <CAD6G_RRgPB_FVTr0OUdtUXeViben6pSakEcskzwQXkqUeaT2kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35448 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdHBLJx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Aug 2017 07:09:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

Did anyone observing error -110 and -84 during boot on rk3288 target?
full log here[1] and used dts node is[2].

Proper card detection is done, once we insert after console came-up
# [   39.635614] mmc0: card 59b4 removed
[   40.645537] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req
400000Hz, actual 400000HZ div = 0)
[   41.004559] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot
req 50000000Hz, actual 50000000HZ div = 0)
[   41.015553] mmc0: new high speed SDXC card at address 59b4
[   41.022015] mmcblk0: mmc0:59b4 MS    59.1 GiB
[   41.028458]  mmcblk0: p1 p2

Any help?

[1] https://paste.ubuntu.com/25225486/
[2] https://paste.ubuntu.com/25225915/

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
