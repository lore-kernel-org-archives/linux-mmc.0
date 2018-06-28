From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] mmc: renesas_sdhi_internal_dmac: fix two issues for error path
Date: Thu, 28 Jun 2018 19:29:03 +0900
Message-ID: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch set is based on the mmc.git / fixes branch.

Yoshihiro Shimoda (2):
  mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
  mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.1
