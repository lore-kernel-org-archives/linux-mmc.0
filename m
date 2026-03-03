Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57447ECED;
	Tue,  3 Mar 2026 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537278; cv=none; b=ByqH7Ba8z2Ey8ERP0nZrewJNF3EKveDhK+ww1OnodO7QHKsSXEkDrGpr/zEH5p03HcwDt57Odz0FCXDIixVJPnBlrWmNoeGQ+V92XQN/mr9WDqaK+aUYaGjIctBrhFtz+Mff+jPksURb8plmTEoxpRlQxoPQkJsTrYrHDACA1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537278; c=relaxed/simple;
	bh=JDpJSaBCMI72i1+dB+6tSJPdQTSoAzpCTjBKUnWXPNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pffonc/nC46BwoNUhNp2dV5anZIrBLRnwaW6Jr1wOXj94MwwgipPsSAD7shCE7VxerEZ6adE34neFxTOiFABlFXHaXDnUIrlgu09UWD7XkYsf7tJK5fcF02WIx6StBiDTApyxunGKo4Nh86HUJLYrdZFZUo4kwxg/rD6LOaPD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8DxPMO4xaZpSAEXAA--.3512S3;
	Tue, 03 Mar 2026 19:27:52 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJAxHMKzxaZpM59NAA--.14456S3;
	Tue, 03 Mar 2026 19:27:50 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 1/3] dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for Loongson-2K0300
Date: Tue,  3 Mar 2026 19:27:38 +0800
Message-ID: <5fd555050c62d1bd7dc4f7fc15f93dd48a8a40c3.1772529875.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772529875.git.zhoubinbin@loongson.cn>
References: <cover.1772529875.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKzxaZpM59NAA--.14456S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEPCGmmeEEIjAAAs1
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFWfArW5Kw47tw4kXw1UArc_yoWDArc_W3
	WIq3WkGrsxAFyag34UZr47Kry3X3s2k3W0k3WUJF18A3y0v345tFykGr98CFyxurs8uF13
	XFs7WryfZ347GosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Add "loongson,ls2k0300-mmc" dedicated compatible to represent the
eMMC/SD/SDIO controller interface of the Loongson-2K0300 chip.

Its hardware design is similar to that of the Loongson-2K2000, but it
suffers from hardware defects such as missing CMD48 interrupts.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml b/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
index c142421bc723..b3e8d3f13592 100644
--- a/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
@@ -22,6 +22,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - loongson,ls2k0300-mmc
       - loongson,ls2k0500-mmc
       - loongson,ls2k1000-mmc
       - loongson,ls2k2000-mmc
-- 
2.52.0

