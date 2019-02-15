From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2] Fix HS setting in mmc_hs400_to_hs200()
Date: Fri, 15 Feb 2019 13:59:33 +0800
Message-ID: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Chaotian Jing <chaotian.jing@mediatek.com>, Avri Altman <avri.altman@wdc.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Hongjie Fang <hongjiefang@asrmicro.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

Change vs v1:
  do not retry CMD6 in __mmc_switch()
  do not move the reduce clock operation after switch HS

Chaotian Jing (2):
  mmc: core: do not retry CMD6 in __mmc_switch()
  mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()

 drivers/mmc/core/mmc.c     | 21 +++++++++++++++++++--
 drivers/mmc/core/mmc_ops.c |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.8.1.1.dirty
