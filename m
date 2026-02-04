Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D082392C4D;
	Wed,  4 Feb 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193771; cv=none; b=Zm56E+rQFM66zzge/upyOmyRRcz/2XJ41MSKcNdyRmljbVaBFx9Ph6f3FPTBCNBMM6fRvOd3QrQnrSp8GWAyUDNUGBMkWaD1sb9CWbdkrcpnJmbtO+HUz/b3nrnpp6cBwsBE7aAGDjI9Lsp/SQdcIm4e4dd7SbRjSGeUIKym2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193771; c=relaxed/simple;
	bh=g5MZqIyooDfkWWOuCvYL2JaYtu1lwEiwNsTziSpldBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt4JCMIYjvD8v8/MvVCPWuUXQ0oFaPXfGzNlA1VAj7VHk/Pf23EGnMYuZWTzFoZXaGdvn5UpqKP3YwDTjZjsVj+tJ+jx/mRIvueHCrvOOr9cQFSoy4AZnZtZvrjSXIDfSxv3xdsj/FQ0gxH2b18SRNDyY1vyJXypIbq4cTj0Ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [223.160.207.2])
	by APP-01 (Coremail) with SMTP id qwCowADnjWlcA4NpYqgfBw--.6098S3;
	Wed, 04 Feb 2026 16:29:19 +0800 (CST)
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn,
	me@ziyao.cc,
	Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Subject: [PATCH 1/3] dt-bindings: mmc: Add sdhci support for Canaan k230
Date: Wed,  4 Feb 2026 16:29:06 +0800
Message-ID: <20260204082908.27501-2-jiayu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjWlcA4NpYqgfBw--.6098S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45Jr1UJw1fCF47ZFy5Arb_yoW8JFWUpF
	Z3AFZ3Gr1rKF13Z343t3Z7u3W3tr1vyr45tr1aqr1xWFs5t3WUG3yfK3Z8tr1xGF4xAaya
	9FWxWry5G3y2yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUjrHUDUUUUU==
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

The Canaan k230 uses the SDHCI from Synopsys. Add compatible strings
to the k230. The k230 has two controllers. MMC0 supports eMMC, while
MMC1 supports SDIO.

Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..cab33da3af7d 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -23,6 +23,8 @@ properties:
           - const: sophgo,sg2044-dwcmshc
           - const: sophgo,sg2042-dwcmshc
       - enum:
+          - canaan,k230-emmc
+          - canaan,k230-sdio
           - rockchip,rk3568-dwcmshc
           - rockchip,rk3588-dwcmshc
           - snps,dwcmshc-sdhci
@@ -87,6 +89,26 @@ required:
 allOf:
   - $ref: mmc-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - canaan,k230-emmc
+              - canaan,k230-sdio
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 5
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+            - const: axi
+            - const: block
+            - const: timer
+
   - if:
       properties:
         compatible:
-- 
2.52.0

