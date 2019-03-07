From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 0/6] mmc: mmci: add get_datactrl_cfg callback
Date: Thu, 7 Mar 2019 17:38:56 +0100
Message-ID: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds get_datactrl_cfg callback in mmci_host_ops
to allow to get datactrl configuration specific at variant.

change V2:
-This V2 has been rebased on
"mmc: mmci: Cleanup some variant related code" series
-add helpers functions to define default datactrl value,
each variant could use these helpers to define datactrl
and adds their specific bits.
-use static in qcom and stm32
-regroup mmci_(ux500v2)variant_init in header file
to avoid checkpatch warning:
"WARNING: externs should be avoided in .c files"
-remove unused variant properties:
 "datactrl_dpsm_enable"
 "blksz_datactrl16"
 "blksz_datactrl4"

Ludovic Barre (6):
  mmc: mmci: add get_datactrl_cfg callback
  mmc: mmci: add helper functions to define datactrl value for variants
  mmc: mmci: define get_dctrl_cfg for legacy variant
  mmc: mmci: qcom: define get_dctrl_cfg
  mmc: mmci: stm32: define get_dctrl_cfg
  mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback

 drivers/mmc/host/mmci.c             | 100 ++++++++++++++++++++++--------------
 drivers/mmc/host/mmci.h             |  21 +++++---
 drivers/mmc/host/mmci_qcom_dml.c    |  13 +++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |  19 +++++++
 4 files changed, 108 insertions(+), 45 deletions(-)

-- 
2.7.4
