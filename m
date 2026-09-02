Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3C3D411A;
	Wed,  2 Sep 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332621; cv=none; b=RIT5NxtsPJVpq665PkftvvL6RF5fIgEcgv8YHXis7OV72vejt2JtgUdVtFG2jBNh4xIVLieumEcTuEuh+PUYmhmOLSKx3i21H5iO1fLo49itRzLJNv8GdZwTye1Pn3Qxo1iyFtR6Yb4Yw3ytDa/fBgVBJSHDJwLW2uynQM54g18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332621; c=relaxed/simple;
	bh=UlPuyeu94UyM29/6tBi6TPYapfESbDa6UB/FugcBTgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXacFItDMwpKv4flHvatSH7QcATJeQPV/9lRFISDEJRNOFoRegSmX+FkyVX8h4geowkM8zhCUS1609CrSayDs9QxSo+d4TWP3gigy1Yd13CKqs0rhHeevgdYcG8Sew1pigicHxZJURJtbshMCkHTrgykf+4QDLW8fFrAnJXplus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiVvmcVW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiVvmcVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792FE1F00A3D;
	Wed,  2 Sep 2026 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332619;
	bh=ADWDnrTMdSyIzp5BL5L3Cq8dXeGxwG3/LxsyTlSUayI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UiVvmcVW37V2AEY+lW/6cB2m+DZQe/ityzpRDUakEHWKYsLKWLowcwJSxtwXvLwV8
	 iqXowvMTcWVz9dXQN2yD09FfAfpTbcE6vE45KS5VUw/UTZnt/MKwJssAhuYtdPesBG
	 /LN2iEjdIbrym7gj6YAVM7BIw8lusYowPU/SR2/XoVkz+8dEqKLvL8RBauWtC3BeVV
	 Jc32ZMP8I8gkH1KRg48jwfiVusX+xY23vTrmAFmXUH6ADhkfnbM0n9O+xotNE8HmJi
	 dkEsHjzftr1ZklYT+3uT+dOic9d2RuHQ9UTxDqE/DqRa8bFck7c/4c0dKC01LvroOd
	 c7oCWOVcIPjWQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 07:03:13 +0000
Subject: [PATCH 2/4] dt-bindings: mmc: spacemit,sdhci: Add tx delay
 property
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-dts-v1-2-4e7909cf4233@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=dlan@kernel.org;
 h=from:subject:message-id; bh=tKK/nlQHRnas6UGu8eqQ6yK4XJJKgs+znczKLewdiy0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql8o50i812oFbAhr2Jofm+9kGBHm6vbVkx1dUT
 F5oz5CiGSuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfKORsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+14fA//QuSck89nvcqi/+KpW02jct5qiKpEAQzlBc+h7N9JWR1fExF1+OAbs
 IOguEw+LXb2/6/V7DidmNaGHX7XbkUtXWIUt8ES6HAJOLvSLLueblKjVMWrm8RxgS0yh3o5RatM
 wYzX9917qeu841xafn3OGjE/Z+2QZiHrbAJo6/WDDAb1ngkNCsDyuI1HTkQqzfyUtekqH0WAJsH
 d0/yt8Ln+9pHqg/WX4H6LGqoTg81CiE4B3FrIUHb0PTu5OdT666G7QOHdGC4nksGYKuOBYpcL2A
 cp+/I2IqVZAhEExvWJXLGPOOZpo688Z2aOCw8gKYErbA116Yenv7S5Ks8fa0E9igshDRSqlD9zA
 Mo+f57OWCpVAibsMI2hH8i8yEtPsg9v+GBGV3mPR7eQk4/DVZJ/OKIIJZz9J2aWdvi9eyVB/jiK
 YGQhdf+0BnG5nU2ofbBehFAtoSzx/SzWTQdA4sKuM+rDzGiaeCRZ4ltZEPgcc5bHMbp3+tMajPl
 M7F2ifQKmBG2NgtL6D+pejatp2MsLYMWWEzlxqJW3WCUiUs2SBousnoP08+ADPWuG1dF1TL8R/J
 lHnSf9dY1dqAvvfzcmFwawWoPcCv3uSD996INPlWW8Uzkzg80LZ2s86V+pqORtvAAdCM2Txr7g2
 gKyvJ7bFy3SD6YVd3dQxVohYgdKypE=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Introduce a vendor specific property to configure the step count of TX
delay line which should be applied before RX tuning, compensating for
board level trace differences. The TX delay line result comes from test
out of real board which vary from different hardware layout.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index f35bf7ce08dd..3399a2d076dc 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -63,6 +63,16 @@ properties:
   pinctrl-1:
     description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
 
+  spacemit,tx-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+    description:
+      TX delay line setting applied before RX tuning, compensating for
+      board level trace differences. This is a delay line step count with
+      no fixed time-per-step conversion; determined empirically per board
+      specific, used on SD/SDIO hosts.
+
 required:
   - compatible
   - reg

-- 
2.55.0

