Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5C2F616A;
	Sat, 14 Feb 2026 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771050909; cv=none; b=Xq39ILgoFTSGkxRKZecGCGmR1UbxOUX+buDt1KD3uMfPRF8upTb29JEDdFqq3HEONqs6P9D+qjAAFzY51+jJxNhgHZK+HiMPy+tIpz/G3yAEz2QcqsUp4kRsBW8Af7m+7LhUwYJo5bwN6IPRh/jCvmYkH1TzBq9d4GkKyk3JdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771050909; c=relaxed/simple;
	bh=Pl7MDkENwbiNax6m2XR6GD2YXajjeG7Xn4BpXBBHCTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wj9WcD69Fq+gEmaEJirfi91hA8wF9S/MozqyXhB9iEPX6/g1jTqEUme1CVOpuTECo3C3vrcOHYibXqamu9HOwShKFk1H3eD6sT7+XSc8G/jRidAQCFQxrof0jU6Kb0JrHr7uPczG34WNpid62Cz7Ksn35ezdxk5unAbg4KU6L3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgDHXHGMF5BppIoAAA--.1656S2;
	Sat, 14 Feb 2026 14:34:54 +0800 (CST)
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
Subject: [PATCH v2] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array validation
Date: Sat, 14 Feb 2026 14:34:50 +0800
Message-Id: <20260214063450.198-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDHXHGMF5BppIoAAA--.1656S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13urWfuFy3Jw4kWr45ZFb_yoW8Wr43pF
	Zayry7t3s3AFy5Ww40y3WkC3W7Xwn8KF17Kr17tF1vgF4DZF12grW3Kwn0qFy3XF4xtaya
	qFWa9r45Aa42vr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRpVbPUUUUU==
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
Changes in v2:
  - Keep the global maxItems constraints and add minItems: 4 for both
    resets and reset-names properties
  - Update commit message

- Link to v1: https://lore.kernel.org/all/20260211094736.88-1-hehuan1@eswincomputing.com/
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..f268f3b6f153 100644
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
-- 
2.25.1

