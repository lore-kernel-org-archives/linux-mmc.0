Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6B4657C3;
	Wed, 21 Jan 2026 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980491; cv=none; b=t6H0+v/1Dw60ES2ppp8ChC/lQczI8sNtfY08nylHyoq24XB6wDzV9JuUTxe7Ct0LKs7ejZoLoHbrpOHLgvsBzMtmdctwYxM6kt883ZJI1xbR1Ur3X6qPYQHDSaK75BON8VCcQwOrz4fni6/xJYZrwwRfoXV9LkDFg8S7qWPI8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980491; c=relaxed/simple;
	bh=QeG4nnxg3Z51cpWjKcP61JzmFp2YGJm8LfLD4oaoy8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcwyWLt7dj0kkghZvVGLGkaeiEcBQGJG/9xg4hOdo2KgJWcojNBR+j9C8nym4AbtW0qY5PA207NT1mb72buQ/RoMu8lorOPVy5POx3CL6+wtjxSVTmAIXsi6ZsXMXaKoGKSTjM7rYRja6vHTp0BWG4zKr35EerY3tSx+fX7TXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFkOGEal; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFkOGEal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5937BC19422;
	Wed, 21 Jan 2026 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768980490;
	bh=QeG4nnxg3Z51cpWjKcP61JzmFp2YGJm8LfLD4oaoy8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iFkOGEalBip8wI2VzLFYM/E8GwHwKaeM/gCFpYtsExzrPGcxZZf3APVaozHgT1N3b
	 w2OTNd5OyGlfK092no+0aaC9jQmvQ0zTpbyIbnLLT5/yvKoEKKgeSyThM+BQq8q0fb
	 IJUyRHDqpFg1RLlaH7SMCZS7hUX4iA4IQJbtUx/EgZiXhd/s4p6UOMaVOF+D43tsAJ
	 SftIrIAuSwQkfHnqEWqemPv1y/6qaM64z80erQ2e5eiJBvVoYqDQGOOnBeE8XMQwET
	 u70L8ggOfpoUlB1KO9jzXYIPUwegebE1KiqWTIZQWCXkqdAejIhhWmqBi/8sjyrdhD
	 rnVPgw2Uc55+w==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 21 Jan 2026 15:27:35 +0800
Subject: [PATCH 1/2] dt-bindings: mmc: spacemit,sdhci: add support for K3
 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-07-k3-mmc-v1-1-ff77c07bfdf6@kernel.org>
References: <20260121-07-k3-mmc-v1-0-ff77c07bfdf6@kernel.org>
In-Reply-To: <20260121-07-k3-mmc-v1-0-ff77c07bfdf6@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Yixun Lan <dlan@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=dlan@kernel.org;
 h=from:subject:message-id; bh=QeG4nnxg3Z51cpWjKcP61JzmFp2YGJm8LfLD4oaoy8U=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpcH/96qp2jXu4fXgJ8Y6kFmPxqTwCqDVE42OWl
 x74C6WGSS+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaXB//RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2LPQ//ScM+Sc67IfaSp4iOiDDdA8oCud9EFwgJkD/DGkeNiRB+0fRIvjdGs
 4dK7dVm5y1tje7gL+q0SUH+tq3tJlGAQIkPTzmNE+TGizoO9keYWNoyuA58L5SqnqHxnziM2xZz
 TVLWMorOECa+AcBTnlNx/ShDQxxJFo7cdnsQLJ5YI2e83RuSI0ZAc9QPwtEfSXWE2yqHOOHplHF
 YZGV/oyaCCqjBqp0GOzS9m6AiwHzihIUeGZ1LWEtMhDMWGgGGnzJylJEGPCtCmQaZ9oNNAzBpVN
 T+626hIrDGofvgKHL229U7+8iVQ0mtJGGWLb2fchkaZ4hfvERapTnwPArBhAPck41049WiFijNV
 ajzs4R65t9dsU662l5jzyWCP0kEfMIk2lvtMOU7+LpNCv/vVeNRvuSU1reR6YFp1tm6jLyJUfxj
 qupXpeULsEPBX14sg+JoXIr4SujowjF+r5OGGLm5ukhBQ8H8p4r52Eknja1M+XjLNO0Z6Ye1l79
 uCDLZ+5t3aVLrNAAjg49lfJlzHC0QoS+I1uj7VNPtJCjTFjG4slUBxxTKOl5QXAzuYlNIBtomv5
 XJOUvr01JoGjF1tLwEtQnZy7iMnKFlFdAWk5DuQIekXzDP93IZIP4Wv7aTgHFfHpiToXEesCCPs
 TkSjqO2yYgBt5JlF64IvuMrs0dnK5U=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SDHCI controller found on SpacemiT K3 SoC share the same IP with
K1 generation, while fixed the broken 64BIT DMA issue. Introduce a
compatible string to enable support for it.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index de4e9efeb666..9a055d963a7f 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: spacemit,k1-sdhci
+    enum:
+      - spacemit,k1-sdhci
+      - spacemit,k3-sdhci
 
   reg:
     maxItems: 1

-- 
2.52.0

