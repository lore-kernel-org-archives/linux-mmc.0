Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB53264F1;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343733; cv=none; b=mkBEfIZhevJaUvwbL6qzPreVEEsyP7/vaShfMm4TBHhbA+sZx+0nR7VeH9LKA5lpHZA6ZdMaJZV9kEJdE61R8PeKhzaUnrg48O62mylM1JvQ3VvQos+WeP3iGEcMYibw7ls7WitoV9VNm4CqHZJ1c0or6PZ/n0ec+M5gMxOZHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343733; c=relaxed/simple;
	bh=hP2JkIrZctPbTnRpe+Zy7+t9wd8M+gb11xmJHpExrYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCIdGTQKaRzf/8ojJMO7A9GkUDNBxIMQDcOdLzKsci5v6kIGt9CGIDgHQ8zcxpws53NRFuT1/ptC6R37IOuj6/BXZhB1bDPNN6VfZej/EDQyr6a7sa+SWr3xMiojYyP7HeIfBSyOFDJTxDy73yu/4rNCdXn4MFkAJUGqVVI0Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw6+l6Fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw6+l6Fp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 574B5C2BCB7;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781343733;
	bh=hP2JkIrZctPbTnRpe+Zy7+t9wd8M+gb11xmJHpExrYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aw6+l6FppVdYNcjSfW/E4tviNWPc6zVdUKDNs2KfRPTmoiEvr00UsbgRj9V6V+aut
	 4w1CJR0+Va00Y+htR+5bQ1pBuh60tO6FP1yCSrujO2Dyo42V4OR6PK3NnzslAFc9gO
	 Y9rXFOi4bO5vemqWHP8aDmFgrUbbK2Zt3EJVyc6+2Q5VMVvL2ZrE0Q2lKGL69W/rs7
	 C2eT34pJ0VIsQPXhqxrx/HAdkY85m3ynm2TXRFVms2OmutLv9GsrRHiSbsvLzwz8Cv
	 kV/x3uJM/yK7ILUEvlM+sv+3yIAO8/oUgor6SYQ0ERpRT56+gSs0uzBAzs4T1Nrk59
	 t+cpvoUSYlQbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44216CD8CA8;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
From: Enzo Adriano via B4 Relay <devnull+enzo.adriano.code.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 05:42:13 -0400
Subject: [PATCH 1/4] dt-bindings: arm: sunxi: add Radxa Cubie A7S
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-a733-dts-v1-public-ready-v1-1-7787c94681db@gmail.com>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343732; l=870;
 i=enzo.adriano.code@gmail.com; s=a733-cubie-a7s;
 h=from:subject:message-id;
 bh=i6WAYnG2+hwZK3Eb/pK94tZG5A16TibjSeWXfvrfG5Q=;
 b=5BARvAPMpbKPU18jBrRxIKm7WodlM6Gk6MSwlfRJ27A2ff7vIgRd1LEXPKA4Y2YrCF8MS/5C9
 EJzXnC/1/kBBJVnh2a/D4waItyqVfHitw2Wm55132Zfn98+LESXjRpj
X-Developer-Key: i=enzo.adriano.code@gmail.com; a=ed25519;
 pk=5S3Wmdqa4XfCdeZF/HfeYqnQF8GN9JGt3SE1cxqSX8E=
X-Endpoint-Received: by B4 Relay for
 enzo.adriano.code@gmail.com/a733-cubie-a7s with auth_id=820
X-Original-From: Enzo Adriano <enzo.adriano.code@gmail.com>
Reply-To: enzo.adriano.code@gmail.com

From: Enzo Adriano <enzo.adriano.code@gmail.com>

Document the Radxa Cubie A7S board compatible for the Allwinner A733 SoC.

Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index e6443c266fa1..9f603681c78e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -850,6 +850,11 @@ properties:
           - const: radxa,cubie-a5e
           - const: allwinner,sun55i-a527
 
+      - description: Radxa Cubie A7S
+        items:
+          - const: radxa,cubie-a7s
+          - const: allwinner,sun60i-a733
+
       - description: Remix Mini PC
         items:
           - const: jide,remix-mini-pc

-- 
2.53.0


