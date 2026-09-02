Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728533C8C77;
	Wed,  2 Sep 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332617; cv=none; b=skPL0Il+FEEh2F8gFZccNAvsrlR0Wd+DK2hJlytWQGnBIoMOC5m+FXnpDykcPgqYH4bzlCoi2qQuZlpNxIXJEHqWog/pNjJJ7VSFlix5Rx773oQ59dSku8/tMORFU7QBgIIOwlyiSV6xAbwh2yZaYle5Dtksbba4/54oybNkws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332617; c=relaxed/simple;
	bh=xh+jDtZb+F1rSKor4ynd2B/GftrqAkME5NTX9HEOTTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwCRaIHMZBslf968GgBTznW13zhyQKDcnV4pZTaluKSI2i8rY1vrVUQt33QRuVZ0vlTWjLPWVaw+u/x3sXTqlVZLiXnb2IkLvhdh2Sb50t5aHcIH56x6I0WJfZcnLKQ/28vkTjGJvmjZkgmLtllrETVkwrM63oAxVUvuhDDJlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDb8Hkeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDb8Hkeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA1D1F00A3A;
	Wed,  2 Sep 2026 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332616;
	bh=WZyEXHqrqaseoXVmYy3LcvGU81uk8IViuMFIaeZn8bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iDb8HkeoXvFrYa9Fxf7JboXclgGnS9WD6g/Usmqg0bQr3GGxKpwk0sZgiVu6bBLpd
	 yiGfd9+m14tMiyeS2VqizbgD4LxUdVWOPhEpG9NdNyceRb/f3umsLOeP77BsW1OAck
	 W8BNkrm65jA6py2op1ZzffjQ7i8zA8c5UbotPY92sydS7vIRJgUPc9wZdmksH6pLH3
	 lx0FNQuyEh+EAPIzSHtC7ckw6ckd/HKyP0V79cK2rWzFQgYzekQvKaeENaewjeJmwo
	 GRbWrYoEqbM19sX34wz65fq15u8Sew3LnOucqDeiNTFPwU9X0WDdXFCFTY59LKt5os
	 PYj6itKpL8Daw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 07:03:12 +0000
Subject: [PATCH 1/4] dt-bindings: mmc: spacemit-sdhci: Add clock-frequency
 property
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-dts-v1-1-4e7909cf4233@kernel.org>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=dlan@kernel.org;
 h=from:subject:message-id; bh=0s33+SIAIsSvRrJal5a7lf5iGDthVMJEuouJO+809F0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql8o2RCCXdV8uWXJPuCAhkAJ9KDdYto2E9X4qU
 74INxSxYsqJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfKNhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2oOQ//X0/Z5/emiJ1f33hhcm/usHUp48sRwGjB/fZNmOKhiyvrNaS7ISJy8
 eg3rIRUN414M9jtencsfJz/M7hb/7XwHf+12Yk5afXbyhOX8U3S2qAJ+eVFRWY7U5EJrc+0rQVa
 II7dxork7DCiB4lHlRju0bz/YrX8bWx9Cjh57921mm8lEPON17/9U41dXYc0vICDmjuImT99DuH
 hv9s1LHi9CkKkpKujwZlGf/EsICPQu4ISge+T3JC4/d2z15HiQ1vTFueWeUnZBiaeNS4EDVUSXd
 uipWCp3IDxo/bfFKooiS0pVFQwJyOcBYcYSEgihd7D4FLCn3k7+Nm2Qe9zkQXfPNOyshfOyD9dx
 6DJA0y08t2/2IUmymoOX//9zHGo2qRiElzsbJAcxOJlzpk+juwwyuPzeBsYvVj7ooydMa3AoVfP
 u7gX9seAT1GlpKEa+LIrMXPiyP1HHifTpK/nCAGzYM1bhw0xdeldh4zRHLYob6DXtdctpGMbcam
 PAVkpD5/NF5p9SHBB2OyxRELXThBt03Wx02S8wP2SUgBlBRiN+uoPd8L8OgJKvc6Q8ON592D3rQ
 YA/qcWUC0crlHgcL8MXzrPiHJzqJiNYPs2WCZf3XrAgu5VJfb3unc9X2qgrVIoK/sLfooZ8iLQT
 Etx8g1YXeuMgU1pZOogm6RWOvxPMOE=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Add a clock-frequency property to set the rate of io clock, according
to various host controller mode it require different initial clock
frequency, and also match to the board's layout actually validated at.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 34d202af909f..f35bf7ce08dd 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -29,6 +29,13 @@ properties:
       - description: core clock, used by internal controller
       - description: io clock, output for SD, SDIO, eMMC device
 
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Rate of the io clock in Hz. When present the io clock is programmed to
+      this rate, allowing a board to select the rate its layout was validated
+      at.
+
   clock-names:
     items:
       - const: core

-- 
2.55.0

