From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 0/2] mmc: add unstuck function if host is in deadlock state
Date: Fri, 11 Oct 2019 15:15:00 +0200
Message-ID: <20191011131502.29579-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

As discussed in this thread: https://patchwork.kernel.org/patch/10786421/
After a request, the host could be in deadlock state, and waiting
for a specific action to unstuck the hardware block before
resending a new command. This series adds mmc_hw_unstuck
callback (structure mmc_host_ops) before resending a new command
(call in mmc_blk_mq_rw_recovery, mmc_wait_for_req_done).

Ludovic Barre (2):
  mmc: add unstuck function if host is in deadlock state
  mmc: mmci: add unstuck feature

 drivers/mmc/core/block.c | 11 +++++++++++
 drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++--
 drivers/mmc/host/mmci.c  | 23 +++++++++++++++++++++--
 include/linux/mmc/core.h |  1 +
 include/linux/mmc/host.h |  7 +++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.17.1
