Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63A274B43;
	Tue, 24 Feb 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925018; cv=none; b=EYy2PDoFMWqBP3VJixb1EFET1XgiSeCQuJAypbuUZ9Lg6oSmADDkx0GkKAFEqmjGuzbVyT9JvH8NpXq5+0Juhgy8hQDDwslGt73IRMWZHe6qGX9VHFQ7u/w2T1YuAPjDIg3qRNZpUYrNNc+u/UJQarB28sTA9i5QQUf9UbtDxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925018; c=relaxed/simple;
	bh=0RFfTAFGFD6Q0UES21xSuXBPo1gV4o0MexiWJ052qGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSOiGE81z8QyvA7LjIrHPMmOv7HcifykZoenAgLXvM41+j6eMBxSJ9KuKspG02s7fw/bBgbslEt1DI58z+hjWrSZflYaqg3q58ku6FuJXkwjms1GOSmC5R+g/077/Bq5JPRspQgmVbNJMfQvGb0Sx8pIQAadP1jNqz125xR9hhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app2 (Coremail) with SMTP id TQJkCgB3jaAJbp1pdBoDAA--.16789S2;
	Tue, 24 Feb 2026 17:23:23 +0800 (CST)
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
Subject: [PATCH v3] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array validation
Date: Tue, 24 Feb 2026 17:23:37 +0800
Message-Id: <20260224092337.312-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgB3jaAJbp1pdBoDAA--.16789S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13urWfuFy3Jw4kWr45ZFb_yoW8Aw1UpF
	Z3Ary7t3s3AFy3Ww40y3Wvy3W7XwnIkF17Kr17tFn2ga1DZF1jgrW3Kwn0qFy3XFWIqaya
	qaya9r13Aa42vr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Huan He <hehuan1@eswincomputing.com>

---
Changes in v3:
  - Add minItems: 5 in 'else' branch for non-eswin,eic7700-dwcmshc
    compatibles

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

