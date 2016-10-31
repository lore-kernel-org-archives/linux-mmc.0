From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] mmc: dw_mmc: fix the wrong operation for reset controller
Date: Mon, 31 Oct 2016 11:49:40 +0900
Message-ID: <20161031024942.4415-1-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, john.stultz@linaro.org, guodong.xu@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the "reset-names" as reset controller for dwmmc controller.
Linaro guys had reported the issue about booting stuck.

Some SoCs are enabled the CONFIG_RESET_CONTROLLER.
then dwmmc controller are waiting for getting reset controller.
But if doesn't define "resets" property in device-tree, it should be stuck.

If use the reset-names as reset controller for dwmmc controller,
it's more stable than now.
This commit is related with the below commit.

Fixes: d6786fefe816 ("mmc: dw_mmc: add reset support to dwmmc host controller")

Jaehoon Chung (2):
  Documentation: synopsys-dw-mshc: add binding for reset-names
  mmc: dw_mmc: add the "reset" as name of reset controller

 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 +++++
 drivers/mmc/host/dw_mmc.c                                  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.10.1
