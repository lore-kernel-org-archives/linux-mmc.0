Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8833ACEEB
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859907; cv=none; b=kE+0gmqABMaWRkJKIRnVsEOWkTqb9pHCWGIKI8i+dUYjz6svFT05h1LobSdGPIVd+YTIprwHhkoctDELifNRip+581z+OG/DvYsfaUwEIUCZeQKRtdJtCiBJ8qL09SyvYWlLzMgeAw2m6Xzb3QI2Hx1TBaS3Z7xFRiApceoBJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859907; c=relaxed/simple;
	bh=ukJEaVdX4VDSTNRrPu2xDDLoME5kyYmNbMApJbbiz48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbC7TlLW5WPWysN3Xu4jxxiANUY/qxt7Y+MGf7QHdP/R84++6wTN6KEaRWa9VJXNyTrgxG4z9hhUip4O8wR6sUj9+Y7xfEHRQNyYcFrFmLOjtTXe34RiXZmljohjA+eiHoZmrk+Yriz2HGmgVeEQfVp64t/XK/esv2tgPQ4XDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9jnTNVe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9jnTNVe"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-487035181a7so27430535e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859905; x=1775464705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk1htAS4wrCqLvV0lbmjJX9VFRd6P5+nEK7bdtMsxTU=;
        b=C9jnTNVe+Lg+UKddtyIKxQuamj6gb1InuX2HHDWv/3auu5iEWXxqoAsCz0GwWG2Z2F
         WQmdxhRdOD1lj4IuHoz+5y0O4ZR/iG3S2NKq3vBSMFuZUcR50QLvpoEEGmdeamjK5E89
         KsL69CDNl4lISxWNLDm3fRRh4He/QLJJs+XWnR5BaH8Sl07d8zhH/wEeQjCeekTjsI22
         zhcU5kBt1g6bpoxCPz7rHqKuMZ7umg1adcDniBZa8iKPWp7HdtDTkg3zOyhmQUCn9uLS
         eRhxfwkO/O7sQyYyVvhq3sAYLdntTMGhHlt0vjgWY7JdXvWw2JVvjSCuvV4HkSETxA5L
         US7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859905; x=1775464705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bk1htAS4wrCqLvV0lbmjJX9VFRd6P5+nEK7bdtMsxTU=;
        b=GKIsK/KiI09U2AyS807uVuVOkhwFtbGkOun1Xa7F4meUgTmXD9FI19LnHp2s5OpdcF
         CNQpAAkpp6GFlq+XzeWqWr+KiBbcXmrpXwBOHJErXxGZu8NDsC3yz+0QNW0bjK/97aWX
         DfLFpW6HaZbzPLimmJdSCBDcFczyZ4zg3/k3rplfaUcaTynR8nSaT4Mh3M1wkStFH9FI
         kJCKdmlBFXZyXQxFJhWRw738uHEOljMixd29mzS6hPWkayNdgD1tXeR5D3rTqF3h/E2B
         Zot5QYotJfu6lBccboZGQ4WbkWy8sA6yY4IhY1cuqUFKR7xLETz18oqjJZ4tYfDeMovy
         KFbg==
X-Forwarded-Encrypted: i=1; AJvYcCUpLBzbLx9awP/aluwqrlrOEleSkumqejXtmw2DGJIrzA9OgxKo2ysouKahIZjGdRM+ehR3Twn0qcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2HPp78xdlzAk0WHTZMkoOImE4LfJDWxwVWEwR0itNIbG5+rE
	eLk657pb8synZlLvTuz5UbkQMIEk9fxwyfAEZXwV4+7bb0idTh+Q+8Mn
X-Gm-Gg: ATEYQzy2z77YnhMWTVCAvhJZeO7OaPVNGFhgq2U1RM+T6KhQ165iDes67i8Go20vFqu
	NlMmb6HGN6mAHfFWwQ0TWhMpqwAdDAHArL9TZY+fQothFoyVqgc4aFmzh8iqzu77F5jS6oe+oCy
	7AgI1q2MQoLt9xM0m0EuM4M0/EiCAcV83+Hgx9LujWVIQ35FSOhx67uulfFt9QTuRgaMsFE44fh
	PTHZOOSAxi9PVY0I5/y/iE8JKLtP6ywAsGXp7LVoIJ7UZC6K1hbb0HwP4keiyXFnQ09qVW1qJ2l
	pDfYQD4rFTpdnHzhmoxfUK7kBBQgnW1CYTY7EcNWgt7xlCsstkHtd/LKLL9siaMcKd9J4lYe47g
	rDXP2oC7XUCvGmQ+BtFFVcwnCOp2ZhVE435pkZBVt1f85U9Qznu1aczBCz3xe5CqaruafnBKSqg
	RhhSknKGnrCJJcIg1PwRfTQ1b5+RafiF3BxrPp+5jbm8X6VxIJ7HvtoI4nLyGWLFCe
X-Received: by 2002:a05:600c:46c5:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-48727ef0bcemr204913105e9.10.1774859904599;
        Mon, 30 Mar 2026 01:38:24 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:24 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 30 Mar 2026 10:38:02 +0200
Subject: [PATCH v5 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-orangepi-sd-card-uhs-v5-1-bd853604322d@gmail.com>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
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
 .../devicetree/bindings/mmc/spacemit,sdhci.yaml         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
index 9a055d963a7f0cdba4741c1e3e7269688dcd5f45..201ab97f0e88376a4680dcca7917e8b3172bd84a 100644
--- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
@@ -44,6 +44,20 @@ properties:
       - const: axi
       - const: sdh
 
+  pinctrl-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - default
+        - state_uhs
+
+  pinctrl-0:
+    description: Default pinctrl state for 3.3V operation
+
+  pinctrl-1:
+    description: Optional pinctrl state for 1.8V UHS operation
+
 required:
   - compatible
   - reg
@@ -62,4 +76,7 @@ examples:
       interrupt-parent = <&plic>;
       clocks = <&clk_apmu 10>, <&clk_apmu 13>;
       clock-names = "core", "io";
+      pinctrl-names = "default", "state_uhs";
+      pinctrl-0 = <&sdhci_default_cfg>;
+      pinctrl-1 = <&sdhci_uhs_cfg>;
     };

-- 
2.53.0

