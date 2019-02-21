From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer mode
Date: Thu, 21 Feb 2019 11:10:49 +0100
Message-ID: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series introduces a bitmap of hardware quirks that require
some special action. This should reduce the number of boolean
into variant structure. 
And adds quirk bit to define sdmmc specific transfer modes.

Ludovic Barre (2):
  mmc: mmci: introduce a quirks property into variant struct
  mmc: mmci: add quirk property to add stm32 transfer mode

 drivers/mmc/host/mmci.c | 11 +++++++++++
 drivers/mmc/host/mmci.h |  9 +++++++++
 2 files changed, 20 insertions(+)

-- 
2.7.4
