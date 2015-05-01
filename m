From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] dw_mmc-k3 support hi6220
Date: Fri,  1 May 2015 09:46:55 +0800
Message-ID: <1430444818-7740-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Zhangfei Gao (3):
  Document: dw_mmc-k3: add document of hi6220 mmc
  mmc: dw_mmc: add switch_voltage
  mmc: dw_mmc: k3: support hi6220

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |  50 ++++++++++
 drivers/mmc/host/dw_mmc-k3.c                       | 104 ++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.c                          |   6 ++
 drivers/mmc/host/dw_mmc.h                          |   2 +
 4 files changed, 160 insertions(+), 2 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
