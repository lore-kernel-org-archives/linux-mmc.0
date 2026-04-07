Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF37394498
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550366; cv=none; b=goSy3xfuEZgWf0iLs4HUeZ0mzmBW5Wv2Orp48ePzBKWnA/w2VSRtc6FiHZ1R8PEWhEN/Zv9J8VE0ikVUy7fRHFLS21RoJAD/3fYB4WqR57nBzchBVBSr4C17AaT3XiSQG0Cln6VX9G47smwiPBnrOfn3sHeUA1Qz2ROAQrkiSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550366; c=relaxed/simple;
	bh=Qk/MRdECLsEU42cJzI1xmlh9FrTNHcLigqTFDzeobEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AijElexhhPPEOPgcofh1nN/HtXGd1ivavbxXcM6kMxcAXL7surI4Dqd4/nBPavd3srK1DrMzQcacyksXS/EsUMqsT6Wbx0LtIgBcOIO23IC2LhKwEUd9qrs189zDFSYttdnVzUhqhJtWB+Heje4l+uK5DgtoOYt6decNLs30bX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWbsiufC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWbsiufC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso4044863f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550362; x=1776155162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpUyjvSyTbzy5QP1Zl/gUHmx4JmgzxN5EinAbVZD5Nw=;
        b=DWbsiufCJ5FY+lyfZO8kGLNIRjrc0p0zAI+BGoNDfc/UYembE7tArTUvJgzaLZSe8q
         FUVkWFiRiaHoF5gyCBKx/3sZaS4c7b66F/nDBX+XV/9rBmnNS1bdO5eAvpM6bmDNpi3a
         m4aYX22BXa8s0JxsNczEaFt0HJclqZu6hATUuCng902Qn3Dxs4BqNGSYB8XHkittFXnV
         EEEnSbINxp8B7NkqlPRhgsCCCydOs9SuSLjww2uiz5c2H7cWWMRoeIsjj4LnfZLV0gx3
         sknfqNyoL3yc59nlTjM955QFg2m+Ft7H3XQuNTrERKinbcjEfHzfcZOQwhGE3ZH5QdNr
         Hc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550362; x=1776155162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fpUyjvSyTbzy5QP1Zl/gUHmx4JmgzxN5EinAbVZD5Nw=;
        b=JC9Zna4OseKMcHJL2Do3UPwje8yW8+vcUrBuO7fHWws0RaUQCepLDG+QBXgR4I85fX
         aLRMW6a4sxJAkQZ9hUbkB41pqYgHmUb+G1GeN1wTp0e0tulpZrieHoC/a30IED8hK1p3
         pDhmn4cN3y/WILNNe58uc3gt89WHOTgDAL2P8Ph7uA72rg2GpajF8SQFC9wIbvrXRqWi
         VXL4O9W6nOTwUBiZLKlhFlmDw2a+BUryv2nowwJOozEmisu0FiCqqfkcQAPcG2bY5aDf
         HapVau3tMUPkKZsp3WY16uDgWmgUbA4AvX15we0kHFOa0iHeZGhiHmqHIx1TWRMEF4df
         8zSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOsxE+F9GFZ9APN0jgAD5FjR9Y/uPw/G24FCR9jaV6e5kbOvE+ZbzbFaTfJ7ylQxtAcl5c656EYAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUURz6Qx5zJkjlmXDHb3KHOuZk4jWYTyVx2qnn0Kp0JMgENBGF
	UZycP1NftodjxB/AYprAKa0IrV3hKDu3FyqTMZC9QvjEUhPJjuMRXP7G
X-Gm-Gg: AeBDieuoRPmIDZ0tCacVuRv7Zf49S4d50rBNblA9GA0l8DcUhWgrtY15RsPjbgZqWOY
	C4kR0ysDkvz9nHgYEns8ZSx7TBgmWKgaossyi5RHZgEfaBVOEagwIN3gFaNimtNmzEjabsCZXRI
	iJkWDpzBBRJ246HRLObeTlZUn6Qznagw9Gl2H+WUuoLYJO6DJPVsk/IHwRDBxNF48K/G8P+TPip
	g10eNBAZn9r+VM4Z89vrvoPalPIOzKMzrlDzV1kHuNYhFyBxIiVItZ+OrKj5cFyE8EtOtB6002W
	qJoQ1zvyJch30upUA8Uwqn6HDgJF6kR37BE7/GNhyZ0WgMPkStXYDzpqb/WEEC0GX1OG5aesnXA
	cF9FkrNNueYLT+apHkeM+r7zfbXnjAkw1F6tyO7W3BvYMxy4H0Ib8GMcvUZ4uOxgMLGH3Jdz6B5
	8RrBm7hplkQDAVDwtxoDNiYFQZPDRkdgRIirAPPmWvbKwsOhKn9b6/ojlIUCz+bhEH
X-Received: by 2002:a05:6000:61e:b0:43d:1bf6:927 with SMTP id ffacd0b85a97d-43d29295ffdmr22629143f8f.14.1775550362070;
        Tue, 07 Apr 2026 01:26:02 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:01 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 07 Apr 2026 10:25:21 +0200
Subject: [PATCH v6 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-orangepi-sd-card-uhs-v6-1-b5b8a1b2bfc8@gmail.com>
References: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
In-Reply-To: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

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
 .../devicetree/bindings/mmc/spacemit,sdhci.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 9a055d963a7f0cdba4741c1e3e7269688dcd5f45..932fccc609bf8dbaf3ecfe09d9e610852ac7afa0 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
 
 properties:
   compatible:
@@ -44,6 +45,18 @@ properties:
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
@@ -62,4 +75,7 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      pinctrl-names = "default", "uhs";
+      pinctrl-0 = <&sdhci_default_cfg>;
+      pinctrl-1 = <&sdhci_uhs_cfg>;
     };

-- 
2.53.0

