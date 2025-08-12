Received: from mail-m49224.qiye.163.com (mail-m49224.qiye.163.com [45.254.49.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1D7263E;
	Tue, 12 Aug 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001899; cv=none; b=uhaNW/KaRThx//GBO8cRhinc5cRf2j+pEIsjjKUXwbxMK1gNW957e7wW/Yl7TZSHq86AdQM9Wnqs7tL96K8gkb+l2TPmhLjpN5vy2dsBrj/hgq1G23uc0QBD11T1u62TK0N7XblBAknzJKUckAnavaQJBl8S/9ZaMqGCs2X8b9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001899; c=relaxed/simple;
	bh=ql4JLEFswFLo8mVN2RyAN2KXe+WfjO3HmdnzauwK2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zrr0Bi1VRTRc3S+umuSIqDr2cBi+/Yr8Mz4/bfyTNutdThavt/uoRZr1+yXS8MvBsoQp44VwjSsD8+tJTyYQIYCLgoZBU0lfvFfV8t3seL1lV9B56S056+QYslOX00/DvmGHctJJAA3ZQByZ/abgXisuyrm7sZqGR/zUFbuvO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=lADkWNuX; arc=none smtp.client-ip=45.254.49.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="lADkWNuX"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f211b6cb;
	Tue, 12 Aug 2025 20:31:26 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	adrian.hunter@intel.com,
	robin.murphy@arm.com,
	ding.wang@bst.ai,
	gordon.ge@bst.ai
Cc: bst-upstream@bstai.top,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v3 2/8] dt-bindings: arm: add Black Sesame Technologies (bst) SoC
Date: Tue, 12 Aug 2025 20:31:04 +0800
Message-ID: <20250812123110.2090460-3-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989e43969c09cckunm52c5de62844321
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE0aVk9MGBhDTkhMGU0YT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=lADkWNuXX4qQkO4/jkHrO3mxeTcnlnqRPL0FyIGU1cqO+5wB9P7IG9onma9SDIECZ/qc59RfQanmAcZgh0vfQoccZZ64vXjZInuhcxTxyqx2hTv9TvKX7yg9cu5Yuel68/l3JKXl7L2mF0BxdWHwFBbaaerAmU5Ptte3sPXQbDw=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=aJBsDwM35xGEHOWQiQCs6y3IgY32G8frXv2cxix0Nx0=;
	h=date:mime-version:subject:message-id:from;

Add device tree bindings for Black Sesame Technologies Arm SoC,
it consists several SoC models like C1200, etc.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Changes for v3:
- Add Signed-off-by: Ge Gordon

Changes for v2:
- Removed unnecessary pipe (`|`) in description
- Dropped invalid `compatible` entry for standalone SoC
- Removed root node (`$nodename: '/'`) definition
---
 .../devicetree/bindings/arm/bst.yaml          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bst.yaml

diff --git a/Documentation/devicetree/bindings/arm/bst.yaml b/Documentation/devicetree/bindings/arm/bst.yaml
new file mode 100644
index 000000000000..a3a7f424fd57
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bst.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BST platforms
+
+description:
+  Black Sesame Technologies (BST) is a semiconductor company that produces
+  automotive-grade system-on-chips (SoCs) for intelligent driving, focusing
+  on computer vision and AI capabilities. The BST C1200 family includes SoCs
+  for ADAS (Advanced Driver Assistance Systems) and autonomous driving
+  applications.
+
+maintainers:
+  - Ge Gordon <gordon.ge@bst.ai>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BST C1200 CDCU1.0 ADAS 4C2G board
+        items:
+          - const: bst,c1200-cdcu1.0-adas-4c2g
+          - const: bst,c1200
+
+additionalProperties: true
+
+...
-- 
2.43.0

