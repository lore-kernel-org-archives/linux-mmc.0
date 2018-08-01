From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 00/14] mmc: mmci: prepare dma callbacks with mmci_host_ops
Date: Wed, 1 Aug 2018 11:36:47 +0200
Message-ID: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series prepares and adds callbacks for dma transfert at
mmci_host_ops. This series is composed of 3 parts:
-Internalize specific needs of legacy dmaengine.
-Create and setup dma_priv pointer
-Create generic callbacks  which share some features
(like cookie...) and call specific needs

This patch series must be applied on top of 
"mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml"

Ludovic Barre (14):
  mmc: mmci: fix qcom dma issue during mmci init with new dma_setup
    callback
  mmc: mmci: internalize dma map/unmap into mmci dma functions
  mmc: mmci: internalize dma_inprogress into mmci dma functions
  mmc: mmci: introduce dma_priv pointer to mmci_host
  mmc: mmci: move mmci next cookie to mci host
  mmc: mmci: merge prepare data functions
  mmc: mmci: add prepare/unprepare_data callbacks
  mmc: mmci: add get_next_data callback
  mmc: mmci: modify dma_setup callback
  mmc: mmci: add dma_release callback
  mmc: mmci: add dma_start callback
  mmc: mmci: add dma_finalize callback
  mmc: mmci: add dma_error callback
  mmc: mmci: add validate_data callback

 drivers/mmc/host/mmci.c          | 458 ++++++++++++++++++++++++---------------
 drivers/mmc/host/mmci.h          |  45 ++--
 drivers/mmc/host/mmci_qcom_dml.c |  15 +-
 3 files changed, 322 insertions(+), 196 deletions(-)

-- 
2.7.4
