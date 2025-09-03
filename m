Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A52EA14A;
	Wed,  3 Sep 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896722; cv=none; b=CbZicAh34IWdPkRa0JLpoTcJFQQsrvOv1ZhPkDlIUxxkU66lEPIFGshqfr+16oGx+v1EY+5LJnk6WmS/F4xtqyCHmd/7DVEzKH57gTY1vhafKojfLuPOIfZB2WDdiKKbvD74vEiz1FejWHrSH65mQcTyvqA+J69k47b6RPpTGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896722; c=relaxed/simple;
	bh=hWym8Ap263GZ8e4z0xKA+SGAt1iKVrfDxtT/njgoYg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sT874OCKp/2g24hkoCfWUJKTny8jf7ahCuyWLUyD103XlxreJ1iS9ecYoklfVN1LYvJ2r4VIwhvZaA88VA/Frrl7Kn39YgHgEh0gslkW4gd9+2KLvLRydkA43HEV5dyXWOIHjZfd5ovHDB8qaz8ZvswrXDz+fMYRFt+xush8iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=kLQwdTEy; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="kLQwdTEy"
DKIM-Signature: a=rsa-sha256; bh=0on4xOX2K5ILgOCUPYmbuMMVUeGL2/VT+pvfoCLeTuY=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756896703; v=1; x=1757328703;
 b=kLQwdTEyesW782KMERVIzGVpibhXskQDqr1DqcwdF3qPHeieHaOYlzYO6CR6n5KGO7XaVAf8
 1DgaqvDacuZ6DTZ1H/GzbCjZBy4+CXf7agbg1LQhYJ+3LZ4gnoRBNgSre9opJ6gRHhN5pNRbPzG
 1BJcmp+CLMEG/4vQhdr5K5ryOKCYlvAxGxlpXXGFNnfSNjs/+/NpnIH2IvJXmf8eN4sMw4dW4NR
 uuRWgx/QKy5pJ2ZuZ4JT9De8RbYb3Ccmd/ZQx9veJ+JDKi5bhkbQCApko0GdPn2ihwbksY/+2q/
 c+LczYLubpdxxNeKyd+5EMZn7xUK2beyyuff+wuuo7vhw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 270f79bd; Wed, 03 Sep 2025 12:51:43 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 03 Sep 2025 12:51:39 +0200
Subject: [PATCH] dt-bindings: mmc: sdhci-pxa: Add minItems to pinctrl-names
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIALoduGgC/x2MMQqAMAwAvyKZDaQVB/2KONQaNYuWFkuh9O8Gx
 zu4q5A4CieYuwqRsyR5bgXTd+Avd5+MsiuDJTvSRAOG4vKA75XwkIKT3/yxW/a0GdAmRFb9/5a
 1tQ9jkY0MXwAAAA==
X-Change-ID: 20250903-pxav3-uhs-fix-9cbcfd2ec0b1
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=hWym8Ap263GZ8e4z0xKA+SGAt1iKVrfDxtT/njgoYg4=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBk7ZPevvnu7dHJb+9IN4ROVNqUdkxBay362+iL//Znzp
 /mpXJx1pqOUhUGMi0FWTJEl97/jNd7PIlu3Zy8zgJnDygQyhIGLUwAm8vIbI8OaO0pXX85JDd/+
 cfdB07mT83Y+f/NjGmM5T4W49YGAhfvyGf6HCzTabUz8b39rx46fpst+X7VVtHKed24W1621LWt
 je7ZxAwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Some older boards only require a default pinctrl. Add a minItems
property so these don't cause dt-validate warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509030625.PBgLIAwG-lkp@intel.com/
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index fba1cc50fdf07cc25d42f45512c385a9b8207b9b..186ce8ff4626a1eb07633e08aeb6322ae2eb25a8 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -44,6 +44,7 @@ allOf:
           items:
             - const: default
             - const: state_cmd_gpio
+          minItems: 1
 
         pinctrl-1:
           description:
@@ -61,6 +62,7 @@ allOf:
           items:
             - const: default
             - const: state_uhs
+          minItems: 1
 
         pinctrl-1:
           description:

---
base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
change-id: 20250903-pxav3-uhs-fix-9cbcfd2ec0b1

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

