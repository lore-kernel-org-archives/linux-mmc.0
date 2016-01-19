From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Convert dw_mci_pltfm_prepare_command into a library call
Date: Tue, 19 Jan 2016 11:39:47 +0800
Message-ID: <1453174787-13536-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:38175 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbcASDoo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 22:44:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


This patchset expose dw_mci_pltfm_prepare_command towards to
library call and remove the redundant code from dw_mmc-rockchip.
Meanwhile we make dw_mmc-exynos to call it instead of changing cmdr
in its variant drivers.



Shawn Lin (3):
  mmc: dw_mmc: expose dw_mci_pltfm_prepare_command
  mmc: dw_mmc-rockchip: remove prepare_command hook
  mmc: dw_mmc-exynos: wrapper prepare_command

 drivers/mmc/host/dw_mmc-exynos.c   | 4 ++--
 drivers/mmc/host/dw_mmc-pltfm.c    | 3 ++-
 drivers/mmc/host/dw_mmc-pltfm.h    | 2 +-
 drivers/mmc/host/dw_mmc-rockchip.c | 9 ++-------
 4 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.3.7



