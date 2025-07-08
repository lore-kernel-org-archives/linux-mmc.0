Received: from mx.olsak.net (unknown [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F32E5411;
	Tue,  8 Jul 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994710; cv=none; b=Pe51o6CrX/hUefSR1R2O6R0bdRJypbhvwuCKqTtZFiSXGlCoOAaUDBhtYA352asKMNTVzwI+2AjqvoEXwbIo+o4rd4YitZL/Zwe9uMVi0AVd3Wd2XG5pH66sxN1EgRC7lhCbC9ZNAARl0f02vwwvx5J8xBx/IGSiF85MJxVeVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994710; c=relaxed/simple;
	bh=ZyJeDMREaDBgVnlMLZh6vLVIemFrkTRCk7Pdr3JQPjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkFS9hRH8gjlWAEpcsdg/gFIU2t5CMCWpYew3fnQSF/JlNDbhpky98UBHuneAel5qc4CmXiz8NWG3NuIN4eg2ngBuCIgR3IHRJ3fHWu8Z320p1ASjgBoylDSNJWBBLcJXvkBuZEh7C8Mir3i/42f/jQfhuHou/ATIgglqVS+eeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=surX3g6t; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="surX3g6t"
DKIM-Signature: a=rsa-sha256; bh=ofIHb4pRR2eKr0nGrL6enBVnfUnnhPw1khTMmJlQkZ4=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1751994600; v=1; x=1752426600;
 b=surX3g6tk4GjKAj77zuA/VclmokR1Hl2O951+8kC3pxl6fPBLp5Af7YstOoY7wdDyeqKvmBB
 jNXPL8LRMLSlXqov6t0xRU4xqnluC7+0oAGTNhQ18De9qaVGsgdyM6iCPRSpPHhRpiJdgpm4JM+
 NJuYe7C7dpqvFmiLKSsRKYJFSRx23hj2mL8C61n5eY3ZwP8+Bv8+bC71c2KWeVCjK1CJHNPtMb6
 23yHSVv9k7TdRGleHe9lJU68ExGHEeB9OUsTduiHd10nr5MFNZt1rVHgSIHpP2eJas/g73F2SaU
 jt4SZpsDQuaM5ELyL2m9bKVkTxwDjNpBN79GJ8edbsBrQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 629382b2; Tue, 08 Jul 2025 19:10:00 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Tue, 08 Jul 2025 19:09:47 +0200
Subject: [PATCH v16 2/5] dt-bindings: marvell: Document PXA1908 SoC and
 samsung,coreprimevelte
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250708-pxa1908-lkml-v16-2-b4392c484180@dujemihanovic.xyz>
References: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
In-Reply-To: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 soc@lists.linux.dev, linux-mmc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=ZyJeDMREaDBgVnlMLZh6vLVIemFrkTRCk7Pdr3JQPjw=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm5AY+N6p+df68vtma9f6cA3/QX0Tz/2032yew7HfXjW
 cv3O+qHOkpZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAil9YzMnxq3W16+Fzwi4ID
 J+tPH7u/MP/V/Fnm4cezj5zj4uk2lBRm+B9yr6ule+m7q/MEZjXHfKvf5hmxVls3nNush2Xpo0/
 J3XwA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add dt bindings for the Marvell PXA1908 SoC and the Samsung Galaxy Core
Prime VE LTE phone (model number SM-G361F) using the SoC.

The SoC comes with 4 Cortex-A53 cores clocked up to ~1.2GHz and a
Vivante GC7000UL GPU. The phone also has a 4.5" 480x800 touchscreen, 8GB
eMMC and 1GB of LPDDR3 RAM.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
index 4c43eaf3632e4ec8e7d9aeac62f7204e2af4405a..f73bb8ec3a1a1b9594eb059b72d95dcbf8c87c6b 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -35,6 +35,11 @@ properties:
           - enum:
               - dell,wyse-ariel
           - const: marvell,mmp3
+      - description: PXA1908 based boards
+        items:
+          - enum:
+              - samsung,coreprimevelte
+          - const: marvell,pxa1908
 
 additionalProperties: true
 

-- 
2.50.0

