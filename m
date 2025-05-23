Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30913D539;
	Fri, 23 May 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006493; cv=none; b=eiAZAdl+mnEBNizRYu4HOjlwGS9SmmvBOgdUrg5UUZzkuxzDIrLroFWaoUS4YnxhgmveZPUPFCnGNQsJWhs5e0uB82SJLsBg8HKYPwAcnKPaWIv1/mA3O1wVLx9uLQxsHWDbkfzd4hSRvEzvIuyAbJsvCIhsr9Q+nV7ZMMauwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006493; c=relaxed/simple;
	bh=/uUt2+APUt4s0Nz60O85gXCqiHDW+NUda7bgTQ9s4zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qk1hJeGyLXZpQq4+OtFTMfURy7XpqMD1QF7fL1mT7JV9bfipXNHzNSsgxYoKSlvwIU0wxW7wFnE0EYoYO1/je0mBqdcaT/kSl0PueJf34aqtvGSsIiRSC86lfPmFRW1+21x5a6PvbN3/4Od73AhC6SFkXXykVhCWDUVzjFwp0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2C661341214;
	Fri, 23 May 2025 13:21:24 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 23 May 2025 21:21:04 +0800
Subject: [PATCH] riscv: dts: spacemit: enable eMMC for K1 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-22-k1-sdhci-v1-1-6e0adddf7494@gentoo.org>
X-B4-Tracking: v=1; b=H4sIAD92MGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyMjXSDKNtQtTslIztS1NE02N7VMtDA3SzJVAuooKEpNy6wAmxYdW1s
 LAKTyPGldAAAA
X-Change-ID: 20250522-22-k1-sdhci-95c759a876b5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=/uUt2+APUt4s0Nz60O85gXCqiHDW+NUda7bgTQ9s4zA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoMHZRXIKtowFCnagfr9Rq++0L2B169bs0Js09E
 u79NhUnKKWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaDB2UV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277agqEACEg1JERuzP6GAAfe
 +/iOIQofq6ZZHkvXp8Ex5h4rWrCz5Qc+PeSiVr86NAaueGn/eCdbOu2HOxmR2EbfDCXeRBSRwv5
 ygzktFwRVDpy5cHa3mtBKUWJLGQWrAYafFeS63cfDctwCf/NzRKxO6rr9zVZzMHZPcgD3zdbw4w
 PTE91toi733KC5fClm7+KXm+uBX3+aP9sGD5T985J1RoOjseWmk6O4ubX35ID3YEMvZV67aBYjK
 N2fPaAL6F8jweW4uZg+hBCnskT8oZLtjFZC3WKF7KM/6HBorSRvSWnAQ4YZvKtKZIlyW36aQjE0
 wxCz6DZfoncaiki0kvqEhfrQ5pRh5Tk1blFWS1gChSKBXODBTUAmiyPPFinOhTPm/Cj3hO55XYe
 VFEycSiwa/lUlSGiyP7CC9YYm/2F6kaGLvNnfm/I5TGZj+0wfpxTPCeio6lZQiEqwsIgOjmWQBK
 2tez2ZGxANDjNVbxJ+l1gSZuG2VQFM7IVuSzrgRoId70cc0GKIL56A0r9uV/T8Fv+gwAhN36Kfz
 cECmBNH59D8iKh+7tMuXGsYTFy4sFokiSoB/qMhnxoNWFvQke+iZvd3DFy4zZ1SPXjOUir0bJHV
 IC0l/FaS5t9bPPjkq5Q6ymq3puIBw3FUwsHzQoLsHvQcsqdB6uzJAwhiggi2XvW+raNw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Enable eMMC support for SpacemiT K1 SoC, successfully tested on
Bananapi-F3 board which shipped with a 16GB eMMC chip - KLMAG1JETD-B041.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Adjust DTS to enable eMMC support for K1 SoC, tested on Bananapi-F3
board.

This patch is currently based on SpacemiT SoC tree[1] for-next branch.

Link: https://github.com/spacemit-com/linux/ [1]
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 10 ++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 816ef1bc358ec490aff184d5915d680dbd9f00cb..fe22c747c5012fe56d42ac8a7efdbbdb694f31b6 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -30,6 +30,16 @@ led1 {
 	};
 };
 
+&emmc {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index c0f8c5fca975d73b6ea6886da13fcf55289cb16c..14097f1f6f447bd33ff3aaa07382d27ca8e59a48 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -511,6 +511,15 @@ pll: clock-controller@d4090000 {
 			#clock-cells = <1>;
 		};
 
+		emmc: mmc@d4281000 {
+			compatible = "spacemit,k1-sdhci";
+			reg = <0x0 0xd4281000 0x0 0x200>;
+			clocks = <&syscon_apmu CLK_SDH_AXI>, <&syscon_apmu CLK_SDH2>;
+			clock-names = "core", "io";
+			interrupts = <101>;
+			status = "disabled";
+		};
+
 		syscon_apmu: system-controller@d4282800 {
 			compatible = "spacemit,k1-syscon-apmu";
 			reg = <0x0 0xd4282800 0x0 0x400>;

---
base-commit: 3aa64cd126b4fd298ba5d28227ea3f82cd6f541c
change-id: 20250522-22-k1-sdhci-95c759a876b5

Best regards,
-- 
Yixun Lan

