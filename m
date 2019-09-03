From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 101/167] dt-bindings: mmc: Add supports-cqe property
Date: Tue,  3 Sep 2019 12:24:13 -0400
Message-ID: <20190903162519.7136-101-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>, Thierry Reding <treding@nvidia.com>, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Sowjanya Komatineni <skomatineni@nvidia.com>

[ Upstream commit c7fddbd5db5cffd10ed4d18efa20e36803d1899f ]

Add supports-cqe optional property for MMC hosts.

This property is used to identify the specific host controller
supporting command queue.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index f5a0923b34ca1..cdbcfd3a4ff21 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -62,6 +62,8 @@ Optional properties:
   be referred to mmc-pwrseq-simple.txt. But now it's reused as a tunable delay
   waiting for I/O signalling and card power supply to be stable, regardless of
   whether pwrseq-simple is used. Default to 10ms if no available.
+- supports-cqe : The presence of this property indicates that the corresponding
+  MMC host controller supports HW command queue feature.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.20.1
