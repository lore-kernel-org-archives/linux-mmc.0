From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] mmc: renesas_sdhi_internal_dmac: fix two issues for error path
Date: Fri, 29 Jun 2018 19:01:43 +0900
Message-ID: <1530266505-19953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch set is based on the mmc.git / fixes branch.

Changes from v1:
 - Add Reviewed-by Geert-san.
 - Add a new goto label for error path.

Yoshihiro Shimoda (2):
  mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
  mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
1.9.1
