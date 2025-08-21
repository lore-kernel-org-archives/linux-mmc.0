Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D02367AE;
	Thu, 21 Aug 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775253; cv=none; b=cNzNne90XK9KXAEZJFYKAlQqTFRFTUTdTAkbZXQ47yV0eSymUXpLELxpWIOGTosqdHlvxzL3MmAfg+Z4bYhdp6ySsDkgS6UVxL8MOZYXPbAi71fJirwwSngC/LBd7uc2e3cImxyhvNqd4UuEZ2LQi7YSiZ7EkCaYdshxFhNmneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775253; c=relaxed/simple;
	bh=v7iuef6GPf6tu0R2yla7tAMIgPcdtUQT6XnIxy5KK94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMrAXlDCUsq6A3g2dmD3S0mYdQ8Bu/25HCbUgwJjA4H9hOOnmqFiVCNdx2CnihXKl9fW6sra4QXH0J/Rz1ieZezjtPgmFouBRShFcUiUH8SWG7fE5q4NqhZjMSmIPEfoSRnk6LBVy1hFr3TQbeXwBCgZblVguT5Flexak1YigNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=PgLKE6p2; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="PgLKE6p2"
DKIM-Signature: a=rsa-sha256; bh=9rNIDpDoTdLh2E6jhEYhac+912Izr531qbk98L0qxyM=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755775245; v=1; x=1756207245;
 b=PgLKE6p23+eJpEo1O7wM6plSrqI7O8LsjQBO1/jJ+dsXnqzewhuFtrbzIO8qDtmmZaPnMMmC
 pQvJdwwlddW6EMaw7a6XgxFzdpzJ60kp6ehC11YRsQ3IcNqh8RkFCbW5QQVWIHgwEQo18ZI7tbM
 JdWZc0PVm1N2f6BGiyvpjoIR2t2rrhLth1kPdblx4iQnvpWCzKaMYCudyqwt2Gx/Pb7AkQCKjbs
 0G10187Z4qdbvKl0t7cnHlccwqkOh1hSSSKcj7tvae5EKNvcARO28LnKiSZzVmOHH51pemCtyqW
 SqvI/AclLHFZrIsdu9TFLjMQIHvd/XQcM6GOy7xpd5mMw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 22348194; Thu, 21 Aug 2025 13:20:45 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Thu, 21 Aug 2025 13:20:35 +0200
Subject: [PATCH v4 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-pxav3-uhs-v4-1-bb588314f3c3@dujemihanovic.xyz>
References: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
In-Reply-To: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=v7iuef6GPf6tu0R2yla7tAMIgPcdtUQT6XnIxy5KK94=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBnLGbktWDVLP11Oiq+/feFsibuhi2DVZoeaGWtcr6d2v
 v0/c+XWjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZiI7V+G/z7qTSXGNoyaM2/M
 +mbKeK5pa+/vyZbPFF3m8i9TdjlTOY+R4TfLm5n/fe+2PZczf/j927e/RZ/zrwjH1ySJGx07bTT
 rICsA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

On the pxav3 controller, increasing the drive strength of the data pins
might be required to maintain stability on fast bus clocks (above 100
MHz). Add a state_uhs pinctrl to allow this.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v4:
- Rebase on v6.17-rc2 (That version has essentially had a part of this
  patch merged, causing the potentially weird diff. The end result is
  the same as in the previous versions of the series though.)

Changes in v2:
- Newlines between properties in if:
---
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
index e7c06032048a3a73eb3eb67a887e75db273ffa92..fba1cc50fdf07cc25d42f45512c385a9b8207b9b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -44,12 +44,27 @@ allOf:
           items:
             - const: default
             - const: state_cmd_gpio
-        pinctrl-0:
-          description:
-            Should contain default pinctrl.
+
         pinctrl-1:
           description:
             Should switch CMD pin to GPIO mode as a high output.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mrvl,pxav3-mmc
+    then:
+      properties:
+        pinctrl-names:
+          description:
+            Optional for increasing stability of the controller at fast bus clocks.
+          items:
+            - const: default
+            - const: state_uhs
+
+        pinctrl-1:
+          description:
+            Should switch the drive strength of the data pins to high.
 
 properties:
   compatible:
@@ -82,6 +97,14 @@ properties:
       - const: io
       - const: core
 
+  pinctrl-names: true
+
+  pinctrl-0:
+    description:
+      Should contain default pinctrl.
+
+  pinctrl-1: true
+
   mrvl,clk-delay-cycles:
     description: Specify a number of cycles to delay for tuning.
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.50.1

