From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  0/5] mmc: mmci: add get_datactrl_cfg callback
Date: Mon, 4 Mar 2019 11:17:00 +0100
Message-ID: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com>
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

Ludovic Barre (5):
  mmc: mmci: add get_datactrl_cfg callback
  mmc: mmci: define get_dctrl_cfg for legacy variant
  mmc: mmci: qcom: define get_dctrl_cfg
  mmc: mmci: stm32: define get_dctrl_cfg
  mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback

 drivers/mmc/host/mmci.c             | 51 ++++++++++++++++++++++++-------------
 drivers/mmc/host/mmci.h             | 11 ++++----
 drivers/mmc/host/mmci_qcom_dml.c    |  8 ++++++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 21 +++++++++++++++
 4 files changed, 68 insertions(+), 23 deletions(-)

-- 
2.7.4
