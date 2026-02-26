Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2BB3A0E9F;
	Thu, 26 Feb 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097999; cv=none; b=ORlrZrlMSVbl1R8cGtVuJeB6yhWxYU2/aG2roR4frEbHvENA5rnKva5qCQ68+ML/fz84EIj0lEPWspe0E+INVuhrK9CSm4+3ALCYCHnjXQdTHA8tPQ68NljIlDFSr26XA8Qw3jIWbLq4Z6dE6vwapM8JXimJxb5N7etUWHt7tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097999; c=relaxed/simple;
	bh=SvrvibyOoFIVw35MXLQXXfyABImjf/FBqdJ2/V42bb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FHswv5tV3csyUG7cHzHCdCzwjG6vnMRrmHYL9n32V/tlDVDRAcWXm7JBFjuKMfBWrnLF5X16UgyGEcPTz3rubLvPEQp2dXWBtQ+eYnO19OUqV/FKRkLU9M/a0iZHhcODzM2gcnQ7Ku1yUREawJj8GV+2rifkA6wADaege0dqc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app2 (Coremail) with SMTP id TQJkCgD3DaG5EaBpxb0DAA--.20239S2;
	Thu, 26 Feb 2026 17:26:18 +0800 (CST)
From: hehuan1@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jszhang@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	Huan He <hehuan1@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: [PATCH v4] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array validation
Date: Thu, 26 Feb 2026 17:26:14 +0800
Message-Id: <20260226092614.435-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgD3DaG5EaBpxb0DAA--.20239S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13urWfuFy3Jw4kAr4fZrb_yoW8CFyfpF
	Z3JryUtwn3Ary3Gw40y3WkA3ZrXwnIy3W2gr12qrn2ga1DZFWjgrW3Kwn0qFy3XFWxtaya
	qa1a9r13A342vr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRMCJQUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

The binding defines tuple-style reset-names items for some
compatibles, which implicitly enforces a fixed array length
via JSON Schema.

Defining global maxItems for resets and reset-names causes these
constraints to be intersected via allOf, resulting in an effective
minItems equal to the global maxItems. This leads to dtbs_check
failures reporting reset arrays as too short, even when the DTS
provides the correct number of entries.

Fixes: 30009a21f257 ("dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700")
Co-developed-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Huan He <hehuan1@eswincomputing.com>

---
Changes in v4:
  - Add Co-developed-by tag for Pritesh Patel

Changes in v3:
  - Add minItems: 5 in 'else' branch for non-Eswin devices

Changes in v2:
  - Keep the global maxItems constraints and add minItems: 4 for both
    resets and reset-names properties
  - Update commit message

- Link to v1: https://lore.kernel.org/all/20260211094736.88-1-hehuan1@eswincomputing.com/
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..5cebe5eb1efb 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -50,9 +50,11 @@ properties:
     maxItems: 1
 
   resets:
+    minItems: 4
     maxItems: 5
 
   reset-names:
+    minItems: 4
     maxItems: 5
 
   rockchip,txclk-tapnum:
@@ -146,6 +148,7 @@ allOf:
     else:
       properties:
         resets:
+          minItems: 5
           maxItems: 5
         reset-names:
           items:
-- 
2.25.1

