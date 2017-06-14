From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 19/21] dt-bindings: mmc: dw_mmc-k3: add document of hi3660 mmc
Date: Wed, 14 Jun 2017 16:23:36 +0800
Message-ID: <20170614082338.15673-20-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>, Li Wei <liwei213@huawei.com>
List-Id: linux-mmc@vger.kernel.org

Add bindings for hi3660 mmc support

Signed-off-by: Li Wei <liwei213@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index df37058..8af1afc 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -12,6 +12,7 @@ extensions to the Synopsys Designware Mobile Storage Host Controller.
 Required Properties:
 
 * compatible: should be one of the following.
+  - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
   - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
   - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
 
-- 
2.10.2
