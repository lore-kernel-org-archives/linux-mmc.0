From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 17/21] dt-bindings: mfd: hi6421: Add hi6421v530 compatible string
Date: Wed, 14 Jun 2017 16:23:34 +0800
Message-ID: <20170614082338.15673-18-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Add compatible string for HiSilicon Hi6421v530 PMIC.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/devicetree/bindings/mfd/hi6421.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/hi6421.txt b/Documentation/devicetree/bindings/mfd/hi6421.txt
index 0d5a446..22da96d 100644
--- a/Documentation/devicetree/bindings/mfd/hi6421.txt
+++ b/Documentation/devicetree/bindings/mfd/hi6421.txt
@@ -1,7 +1,9 @@
 * HI6421 Multi-Functional Device (MFD), by HiSilicon Ltd.
 
 Required parent device properties:
-- compatible	: contains "hisilicon,hi6421-pmic";
+- compatible    : One of the following chip-specific strings:
+	"hisilicon,hi6421-pmic";
+	"hisilicon,hi6421v530-pmic";
 - reg		: register range space of hi6421;
 
 Supported Hi6421 sub-devices include:
-- 
2.10.2
