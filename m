From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 20/25] dt-bindings: mmci: add optional reset property
Date: Tue, 2 Oct 2018 14:09:22 +0200
Message-ID: <1538482167-13819-21-git-send-email-ludovic.Barre@st.com>
References: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538482167-13819-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a optional reset management.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 03796cf..4e69b25 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -15,6 +15,7 @@ Required properties:
 Optional properties:
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
                            the ID provided by the HW
+- resets                 : phandle to internal reset line.
 - vqmmc-supply           : phandle to the regulator device tree node, mentioned
                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
 - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
-- 
2.7.4
