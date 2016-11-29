From: Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH v3 0/1] Hynix quirk on sleep notifcation
Date: Tue, 29 Nov 2016 15:24:47 +0100
Message-ID: <1480429488-22289-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757590AbcK2OY4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 09:24:56 -0500
Content-Transfert-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: bhthompson@chromium.org, linux-mmc@vger.kernel.org

Hi Ulf, Hi Shawn,

I added the cid device name and the oemid to the MMC_FIXUP macro call.
There is an issue in the CID product name: The 6th byte contains a non
printable character and I had to add it to the compared string. Please
tell me if this is ok for you.

Changes in v2:
- Add a few more details in the commit message

Changes in v3:
- Install the quirk only on HBG4e controller and 0x014a oemid

zhaojohn (1):
  mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP

 drivers/mmc/card/block.c | 8 ++++++++
 drivers/mmc/core/mmc.c   | 8 +++++++-
 include/linux/mmc/card.h | 2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.7.4

