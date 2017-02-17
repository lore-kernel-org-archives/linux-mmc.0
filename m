From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/7] Some cleanup for dwmmc
Date: Fri, 17 Feb 2017 10:56:38 +0800
Message-ID: <1487300205-202825-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:55372 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbdBQC7Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 21:59:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


Hi Jaehoon,

This is the first part of long term cleanup for dwmmc we need.
No functional changes here, but just to remove the unnecessary
function declare and improve the logic of dw_mci_reset for better
understood.



Shawn Lin (7):
  mmc: dw_mmc: improve the timeout polling code
  mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
  mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
  mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
  mmc: dw_mmc: remove declaration of dw_mci_card_busy
  mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
  mmc: dw_mmc: improve dw_mci_reset a bit

 drivers/mmc/host/dw_mmc.c | 383 ++++++++++++++++++++++------------------------
 1 file changed, 182 insertions(+), 201 deletions(-)

-- 
1.9.1


