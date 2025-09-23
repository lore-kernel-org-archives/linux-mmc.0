Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com [101.71.155.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C73BA34;
	Tue, 23 Sep 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616378; cv=none; b=eblCY8uC0GwOpvriQ0gEsyz48tL5kS6Q0+I2g4VYFHvbl/R38aHg4vD949HyM7fnWtdRGK3yafAPlKgt8LsE7XEftP1fVczoboIJiFd0JKMJQYIOyvwS4yqTQoD0fAw7G2K5BdcAbZaQAISDnUvMZeZcwpOb3u4zAp036BGG56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616378; c=relaxed/simple;
	bh=To99qns2zIXO51nztUpDVeLTKR/SUM5m6vG3Z0d9mV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hV+DxTnL4m9PgAxJW0JfxW1xap6W1Tq0KO5iCF1OqZZDtOoRo+9qPJwETaiZ0ZX2UTfIY7GSmcjkpz/MJVxGFz2A/AVEk5cDmOxAJfcHA6TRakIvQuNaKZx+qMOQGM1QNKkqK9xQlpuJ7q/7xzXy6/u4ThZRjfO4nuG1jd0b6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=SN/zKi+Y; arc=none smtp.client-ip=101.71.155.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="SN/zKi+Y"
Received: from [127.0.1.1] (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23bdebfc7;
	Tue, 23 Sep 2025 14:10:29 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
Date: Tue, 23 Sep 2025 14:10:07 +0800
Subject: [PATCH 1/9] dt-bindings: vendor-prefixes: Add Black Sesame
 Technologies Co., Ltd.
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-v4-patch-final-v1-1-2283ad7cbf88@thundersoft.com>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
In-Reply-To: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 soc@lists.linux.dev, Albert Yang <yangzh0906@thundersoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758607828; l=1195;
 i=yangzh0906@thundersoft.com; s=20250814; h=from:subject:message-id;
 bh=To99qns2zIXO51nztUpDVeLTKR/SUM5m6vG3Z0d9mV0=;
 b=n6u/4gLR0xKZcjrIKnlqsvmqSYP53mO5T6o2D3OTbvhgdVK5clLU23j27vcnVsi8ukoOplW+y
 C3gA5zsFROdCnEA/SuVHq/2Z03qIG8ST3G/CZg/HxfXnSyCuSyLCoo5
X-Developer-Key: i=yangzh0906@thundersoft.com; a=ed25519;
 pk=bEcgALL9KpUg/m7zH44r50xa/re91dI9SA0vGV1/bu4=
X-HM-Tid: 0a997531ea2509cckunmfc27e25b4e01f5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBpKVkxIHh1NTx5CTUkYQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SN/zKi+YVII4pB67yrsOXEVx+2yvQOtit8lh7jbXqQ4yWChJkN/YD2zn+eY3tAoAJ32L2pSq2h1GbWpaguP1S0Gs/TtC1nZffRQb5PEhZqthBy4CX8TrJnsLeLhH4Qsh2T+Xf55/qkVa2pcFlpGWxo9PepS8NzQPPJzfkIfw67Y=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=JDcHxGOvabpWrg24OH+LFpYkmiRSfnuaNCDEqWh+fbE=;
	h=date:mime-version:subject:message-id:from;

Black Sesame Technologies Co., Ltd.s a leading automotive-grade
computing SoC and SoC-based intelligent vehicle solution provider.
Link: https://bst.ai/.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>

---
Changes for v4:
- adjust ^bst to the correct order
- adjust Acked-by order
Changes for v3:
- No changes

Changes for v2:
- No changes
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad2fa53b2dca2ca06a63710771a600..084ba39016ae23150dd8f140da16f9b1cd55f4cf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -243,6 +243,8 @@ patternProperties:
     description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^bsh,.*":
     description: BSH Hausgeraete GmbH
+  "^bst,.*":
+    description: Black Sesame Technologies Co., Ltd.
   "^bticino,.*":
     description: Bticino International
   "^buffalo,.*":

-- 
2.43.0

