Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5C3932E4
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065123; cv=none; b=XqMQ01hWqtw4pwtKIgpUeUu6EWh4HLDVz2SaecbHcQ4nEZCkuWkykl+rPwIN5rjjC++FljCCjCZ4ruan+U6++pIqD2H/XXdGGeBo9XtawR599/eYoSjuw5DjYH4E/xSQAVTMHzCkyUk5H2nzAzFmGeVKHoa17IlsdjWn3oovkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065123; c=relaxed/simple;
	bh=VLqXlHYEYj6QD9rr227aPs6s/WneA13bYBUQMaGOG6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLijeuWzINDFa439pNdj5H9uriAW2Hx27Vb/ndK/D5DhtyuuTYowo9rdGdLzCjLAKXdAIGCwqKIGSrERzs1XcWW/vvyJdZ8l/ibJXTfz4ydF/9T2A7pP/chZfEAsjge/ycpn03p+ZSedWPa3vFAm9NfAGRH/MRBL/4gUnQCSXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUZWHaNz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUZWHaNz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2701527f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065120; x=1776669920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luHrHS8xuRmiKOe/fYmQbUMhMu1rL/RwOqTb1rEgANA=;
        b=qUZWHaNzOYCo9S3gJJOnPw1JKkCD10LMnQwp20dAy9KClNv9LqKw4kyAg+MQKrlFnd
         gxiEmXLuM9CnLTXwCmJECf6Etu5+YV7zbqIRqB+f7BOjPl9zuv+71Ec8x/nsaUuvU6jg
         WT/7YfemV/GfmCKqhWFFwofM3C0ZzwX+sD7fVBM5M6NGfmH0XvPpczi95KNSMBcf7KRE
         Z038rZ7ymo3s5ddLCQQ1h3n0z5wWQ1v/VloVgTS9wCsK29PYXBJbiqddzA9euKX19y6F
         d0Co/qWqmGsbYu457XRlSSlg8+bxPNwgXdLcSBtkjBz223u9X7OBOoRgobugLrQ4/S7u
         08KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065120; x=1776669920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=luHrHS8xuRmiKOe/fYmQbUMhMu1rL/RwOqTb1rEgANA=;
        b=ipDtbm2E5WdHwWeDypFfeU66NBcHrq8I99KR//gQAJxtAHrSBtkpk1zvpoIjkqwdFe
         W01N2apCps6hzuT342EhjomEcAVUlhtazp3ChaTboX8J+5Vok6P9SxFu/8C5otaecqvY
         Wp9nU2k62WLi+grDZZpeAMG4f2DVn7YEY7V9AbTm43nFgKMABvP/D6Y3aALp7c52IVXY
         DHtCTATrqk1Dzvg1TJKpdGLeDx9SklcKOS4hCUFVHyelV61QtN23IO7LANmh03psfdll
         Zr+d6U6FY1SFg3uQ84CF5wEQ8AwyDD+hcrVyieoblQje7Y03IQytqoJWKDU1KhW4g+li
         Ksrw==
X-Forwarded-Encrypted: i=1; AFNElJ+8AEhHsVvD6zzU5lLxtFGHaDue+nQ1p3SAU+7fCv6VqQ9x+lKKrC34qBjaMl/JvWkoD0ho2seyQY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytV0haPCLAGwlUAZZnLrV0cfbfOyakV6iplqEX1d2rGWoPzyyV
	+OgPhTUdb/gr2Tqet+037x2QjaFv3tPWyfhF6TXaexT8sHIxKt0e3PI8
X-Gm-Gg: AeBDiesXp4h/j3qBQBe+BE38O7+VaJioXwzLzo7RaAEnF+sUTSEsyw2T1bCFp+XJJT8
	Q9Fbcg/o7kh6ByKH+YmvRLqiri5f+icVgoI62ynlQsvlgGwtpNCFZXOugoCyQgD9TVGd2WYklLq
	WF0Am9rMutweM7N33p7dUMehlFjr22mfiS0vDAkOfQEgPctll0l80gXtsZSa7SxoevslT4jC35V
	fae2Y53di0nkcW3EEKiewy7g3Z4tZuOkgWs+6lNQDRTg1Xtcl20GSB5ZRQv6Ht2toaNOBj7yUpU
	Fk/3ELbjtBtnlieDTL8jlfKVRz6vVRoJhZ71UA2rrmLTuw4zLT3Nkv+bNI3ysblSP8HYbzp08MC
	zU1HBjNXAZ/AXPcdIQPt4aPnBhKT43mOFFl3wWY90XgHkvPwjsZrZpXekkVL1vlG2rwUt3KyuzX
	ktCDh/T30krfZXwVfnAFo00cXYmOfhSF620v4U0b3EOllCm703YsCSDxbzcKpa64vw
X-Received: by 2002:a05:6000:24c3:b0:43d:762e:76c6 with SMTP id ffacd0b85a97d-43d762e7865mr5391556f8f.7.1776065120340;
        Mon, 13 Apr 2026 00:25:20 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7d5812dcsm330441f8f.32.2026.04.13.00.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:25:19 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl support for voltage switching
Date: Mon, 13 Apr 2026 09:24:43 +0200
Message-ID: <20260413-orangepi-sd-card-uhs-v7-1-16650f49c022@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit

Document pinctrl properties to support voltage-dependent pin
configuration switching for UHS-I SD card modes.

Add optional pinctrl-names property with two states:
- "default": For 3.3V operation with standard drive strength
- "state_uhs": For 1.8V operation with optimized drive strength

These pinctrl states allow the SDHCI driver to coordinate voltage
switching with pin configuration changes, ensuring proper signal
integrity during UHS-I mode transitions.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 9a055d963a7f..34d202af909f 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -44,6 +44,18 @@ properties:
       - const: axi
       - const: sdh
 
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: uhs
+
+  pinctrl-0:
+    description: Default pinctrl state for 3.3V operation
+
+  pinctrl-1:
+    description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
+
 required:
   - compatible
   - reg
@@ -62,4 +74,7 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      pinctrl-names = "default", "uhs";
+      pinctrl-0 = <&sdhci_default_cfg>;
+      pinctrl-1 = <&sdhci_uhs_cfg>;
     };

-- 
2.53.0

