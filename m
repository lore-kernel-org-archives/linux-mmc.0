Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8C2DC76A;
	Thu, 22 Jan 2026 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074702; cv=none; b=o2HKM4NTL0SQjSyiFvZMxeBN8d4oc59rTGzoCn79WdUD6peDSwzRU6jY1H8pdn6IJ+PSjkG929A/qcIWviR7/nBg6bZrPEnyX+aQc1KRBcxHpRgk0OqYF2u606l8Tv7SKqi0rJg9UFgaCbv1AxTqkUVDzNP6bN/7m71+bCaKYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074702; c=relaxed/simple;
	bh=nIbfvMqfmW7motctlbXKsHjUbk2WDNR6Ijbzum4nZr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/VPlUk1hXweO4xXUt/EY5blrBIbOwxOrcZ2XNiJcWwsY4Ymq4Mdd90WSUNX3KB9yUy+0/lQiejsXYb+hfbOF+XXoavuI6yO/AeA5gJEe58tnaYJChzuMpB2+JJYMtsALgkwRdx75J6g/xd7sjUWE4PrmsJaRvWyYg/HuMzeXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuBT1inl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuBT1inl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD08C116C6;
	Thu, 22 Jan 2026 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769074701;
	bh=nIbfvMqfmW7motctlbXKsHjUbk2WDNR6Ijbzum4nZr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RuBT1inlCDKEoDCXtVTycCjBg9EyPc7dfuUP3vr2b0h4504BcHeigee+0M2EGcBQJ
	 FbrxawD1ZuSFBtsALd7xVzgH5MhuDSl2t3+1u/gdDiY78roMtR+poZ2kEnogVG6JjW
	 5m7ZbwyAz5kMQGcDiZNk58/ucEhUVzjZfp10QuNboaIUuwSWKVVFHsZAJc/VgRT17S
	 7eoMeqvfBe/MNrrx+9bacL+yaKLHfwLHExRVdMhsIOClNg+qK8Kp4fh+CQLiUTJ3K3
	 MllVYq3t7YrDMJzCAwBUnwexhOdyIBo/z1c+Di/yeLAcd1QVn9IaGb9TxVREKW/pDU
	 IPE+Sa6dFqOCg==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 22 Jan 2026 17:37:30 +0800
Subject: [PATCH v2 1/2] dt-bindings: mmc: spacemit,sdhci: add support for
 K3 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-07-k3-mmc-v2-1-3c3ffef25e94@kernel.org>
References: <20260122-07-k3-mmc-v2-0-3c3ffef25e94@kernel.org>
In-Reply-To: <20260122-07-k3-mmc-v2-0-3c3ffef25e94@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Yixun Lan <dlan@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=dlan@kernel.org;
 h=from:subject:message-id; bh=nIbfvMqfmW7motctlbXKsHjUbk2WDNR6Ijbzum4nZr8=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpcfABMFEcQ6SMwIPAsrBITyzzDT9BT1q6hl3xg
 BABADt0FEGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaXHwARsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0I/Q//R8uM84F5AkvgGtmgwKi6mj37Sp7s4/D7JvEdumTp33fcTjODG99Ae
 44CY4vxINtFXu2MdZ/SuJWnRdCcYCi+zIbXskCwk480R05V/4zJw8K9i8G0BpiNbbNJKO1E+o6s
 wZnHyTGI2GQdnOVDQa/ES7LT1vN7W+bLfCKNoMRN1aZ0Eh+LObNLQomqvzeTP/9q47l+JFZeiOh
 dRrWs8LEyofP0FiuVP3xz5MTh8rldgU5m/DiugwRlbo7QBOYSg5rEIxiLizkUTxN9naDe+XUJm/
 KEswC1AmLNlftxGekaIPWCVwqfi1i8xJCkLNt2Bzre/ntz0C2BfqEx4Cbi6QTXKXTQKSCEo5lcI
 fdgD1mt/U8LkkyZjuG+O2WtA5ZCGyeLkoeoJXObPHENhH3rRLCCtnPIZqiM7iCs1FITlsEOt/QF
 St7kWg19YEieScb95vu7A27ck55uGekwGoUsvAAVQWOVrLdvE/olqhbPSig+CoFEHz5tZNq5nTH
 xCS7WnE7+9IoP5aX5wibwC5VOvoEmZ20GLG06yNrZiqh5Lafr1CtZtvv2l4HGT8bBsxAmFwzd/i
 tHaB6FJ3x1eC7XP2IxZViCphxoWSZL/YAWruVkNrwqrKu8kNEgcJzB1EM9zdIzUE5/R5cs/c5G4
 Xwn/4ojVTan2NAiUy4asdoWvzERa74=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SDHCI controller found on SpacemiT K3 SoC share the same IP with
K1 generation, while fixed the broken 64BIT DMA issue. Introduce a
compatible string to enable support for it.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

