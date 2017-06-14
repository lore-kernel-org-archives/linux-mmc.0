From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 01/21] dt-bindings: arm: hisilicon: add bindings for HiKey960 board
Date: Wed, 14 Jun 2017 16:23:18 +0800
Message-ID: <20170614082338.15673-2-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Add bindings for HiKey960 Board.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 2e73215..7111fbc8 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -4,6 +4,10 @@ Hi3660 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3660";
 
+HiKey960 Board
+Required root node properties:
+	- compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
+
 Hi3798cv200 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi3798cv200";
-- 
2.10.2
