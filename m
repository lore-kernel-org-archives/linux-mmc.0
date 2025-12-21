Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED522356BA;
	Sun, 21 Dec 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766305276; cv=none; b=ezsYnF63W5CPTuDiRFKO5gXSp+doVKuVJLv80KJ2X7oQ2u2QPz8v0K6hBcSKfEBs14OdXbiB5SEP/SQyYAPc5RN3nPce3hbta+DBuYRu4uZlZm8qQqXLQ+3MpoX7wffTvZ5P6py9yg5yZGlOGp2jfdKivRZJCoGaX+GfBRgE5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766305276; c=relaxed/simple;
	bh=WfOYufxvp5VMhrnMCPsjsrXQPRkHTzjLxnD+Xz6ivlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msgwpY23x6YEorHq4RYdWZ6H7gLILvTvmbgUXxHqZ9Ulj+h8S1KyA3CWFORioX5WdtxkFxprnCi5cYx7usXPl6h7dnZzHjUNZzWgGt58vTIaCGfw1+Cii5pMp5jsruyzU5Qx8WXYCkgQqJAzAbXiS2mU5dXHuvKrOXVgxPuugdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 265E2340FEC;
	Sun, 21 Dec 2025 08:21:08 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 21 Dec 2025 16:20:28 +0800
Subject: [PATCH 3/3] riscv: dts: spacemit: sdhci: add reset support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-07-k1-sdhci-reset-v1-3-6780af7fa6e7@gentoo.org>
References: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
In-Reply-To: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=752; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=WfOYufxvp5VMhrnMCPsjsrXQPRkHTzjLxnD+Xz6ivlk=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpR63dK1KxNfkTA25fu5p1T+xCzN4qwfXwAe4J7
 WMogOHwkvuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUet3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3Zcg/+KvNt0xHyrpBNAUg57mCtQIGMt6rXzLXPjeoPurkxcNkzFOei4SoOs
 VnUaqbZD6CNGvuAFcJKYRd18DVFC6mUyXg7gc6m+QLKeBOvt/q/kpBBdKhb3l1JofDqdcQwGFNy
 q+FOmDfD6Jc9DVco5mQrDNZdrPqBbqbJVISXwY6PD0uFtZ1bn6krrQfyQ27pgq9SiYDmBDzfeIz
 VJIaQBFwu6D5ywPo0256sxC3ge2H+uc3LixzaiDCTR3qVWCkMVSF31Q62O4jvLWV5gjVn7ftf3c
 F/RCTxKkzXYbRW43laemjgTvYZSMYYQhrUabakrznVhGwpGVqeLyDxIRRJR+BaaA/6HEytccX9A
 4FXKC1Q4YL13uVtTupne6Mhm70WeR8xbf9Rh1h37MDZU75fTYwqRUZ33zVfH2VoM4ryhrMoTF2/
 WEl2Sg/+/DuSgElappnPcG5Zx+rrm3VqfOPlJaa6N6jg6lCx2G+ircMvpC/45GLgcnsnXqGcVtD
 MaNboQbYzc8J1KAzX3fpKjPxTzAXRESHiNzubrrjzk1MLTq/N8nMflikmt7lGGsy2VUuom6aK1R
 zhT403/ONYUY5PqnNbh2IK0RYV8PvCcI2WG+miBieWGhDv96Sc2a4a+N+/Q7qdP3pPqWendVxt6
 NNM4VuMeF7RxFp1x4TlK0+p60fvazg=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Request two reset line explicitly for SDHCI controller.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 7818ca4979b6..7dd41d6dcb85 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -984,6 +984,9 @@ emmc: mmc@d4281000 {
 				clocks = <&syscon_apmu CLK_SDH_AXI>,
 					 <&syscon_apmu CLK_SDH2>;
 				clock-names = "core", "io";
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH2>;
+				reset-names = "axi", "sdh";
 				interrupts = <101>;
 				status = "disabled";
 			};

-- 
2.52.0

