Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A22066DE
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007252; cv=none; b=mt5HhM6Ss3cn5c94XHOOrnYIcscqYiwYCR/TXqYNDM+cWpmNmhYRgtCcNkNJ1Jdnp5zpOG7TqIW2Ul+xv/oa4+oGnpKuZLYPRc9Ac7R3PqMQHsoH6O/r36VWGT4muQFtaE9mL3sxDG0J8VBXVVybG+9dHEYpPNGqV0pbbAMVAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007252; c=relaxed/simple;
	bh=qaQa3SSyJBlku56nJMC0whrRFkEaplidsQS8+eoNWW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWM2ddY636TJ4dRV/QhYpzFvDkMZJVRxtMRan9OI9iaDaLwXbTJtWhCzcukmA0AJl0gsdgDedIZdVmJtfzCjZmNNZy6LNEq4iQ2oGxdH4h26N2CNMVNYV7PDWEzrwyr58w0Ku6jV9ffniXZDXZlTG9907UlSA7m98UaHrOZzGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSpPf6v3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSpPf6v3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so39473105e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 17:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007250; x=1768612050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+ExvoWXyfk7B3PZ+QbuMC84j6wcYdimjvcwYA1OVjA=;
        b=dSpPf6v3zuomdrrH+evYW/74hNxToJ/lWShubu7tfvYFk3NoAhnmgkQ1U7XFQOrkxI
         aa2oskcW+Oh1adVzPaKpvPnvTfqDOWwKIzCt1jusB6wXlbo0mHyic1Rg00UadX/WzTUb
         XXHEk9BoUIrGpdbHQZBvvpRMOqYF70HVT4Cb9iBl7Qn4exuZLiTc0eeFmpKEyxk2IBho
         MPoUCz8B8ky2s7b0T/TcQZPsn00bHguTbliAtOtZrcg2sKx7dnm0YlDjWR0iVnBKA+wC
         Eq1c9RUyoBT4AVGPlnpGiV7IP7T7obeKMRyj/A4vE69zJ2HrN0LnTTNRR4u78ncNmQkb
         e//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007250; x=1768612050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+ExvoWXyfk7B3PZ+QbuMC84j6wcYdimjvcwYA1OVjA=;
        b=ILAID0Yw7RTHBQrfVVaCj5UhTCl+kvJ7ikJEZTH12XcK05K/OgCDDUkOhxpzn0TLAP
         RdXbgRsPA8O4NKr8vPP4cu22XkeAe5qS+1lqqyweMeFiENbQ+vEq2ctihZk71eO1nuXe
         BvAzdorsvxmQw2rCRq+O/+0qMn+zb8FqMveQhRb58EmE9aXnOeUi6y+P+SFEqiwknq0U
         eVTusOxELVT3+N4/5AU5BXEd8ZooU6FOE+DzM63j+TtzSBaNb1/8HPI1UmQxvqnd8SVN
         GQFY5D1x5hCISUwXnCsuR6dDC7jTn/hSsIf7pych6JDeZv+84PxgPqVe1PmFnbXy97pb
         LcJA==
X-Forwarded-Encrypted: i=1; AJvYcCV7H0cTdgLsHUS7zNb4aqtG4EmGKUS1E6eDvX2JB0MYFCBZPpXil6yyj8zO8JNSrYTYPKzcn5NlV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTz1e1ZOJwuLQMVVGV3Q0f4XUgdSoaORh5ek8ox8XDhiYTIDU
	ANyvE4veS2vn/RcfcU3tPfEGANLa48kZ4BaANNM9i1QXUnN+3eK61XjL
X-Gm-Gg: AY/fxX4Jn4IMJCoJt7JYjehTudfSDvBcFU9kG87cKEObnFyWOn28Cay2zmG72gIKuzM
	IdGt0PQWol8qB1HE4lVAKobMp5IvObescFoP2cwvUS7pOxq/fB2C1RCLnw2bOxfENk2j33/bZ/+
	R2L4ZjMvJVvbQVE1qz0wmiRrJfBn475IP/70/fP28Mrp+1yyTdwROqthNn+u7zCYcQeW6E3kBlE
	uKB8IVuo/YEcNTYW7Hk7uG0glDDuWj/78V3I2OOXY9W4DH2URlzxoelbXcgpd76DwCifJQM6Hl4
	JKnA2r+4tAYW4KSIxm1G/kKYOgI3x4Te59Aft25QGgjRMPioEURkqtYRBXYXO3Nqn1nOKSQgvs7
	W6VygDOqXSBgsyJnW2agKu7Xq8ExWKYjug9nV2p1cDAkjlMdSdkkPRWX2Af0RsU8ptfAUwvQ39I
	zNYn90S0c7ZLm20MyZG1Lj1P468UaCLDl41YBDMPe2LyA44eXqR1FhcwJWfMJ2CTeZd02x105Xv
	ZO/xDzRfKtHOul1cA==
X-Google-Smtp-Source: AGHT+IEelYoC/RfOsLxl9axtfdOf6Cg+r/5BA+2WK9IrH0gt6a4Cep6y3e1I+Dzf8IC+Aozsyrqvjg==
X-Received: by 2002:a05:600c:8b2c:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47d84b186b4mr120986455e9.7.1768007249488;
        Fri, 09 Jan 2026 17:07:29 -0800 (PST)
Received: from stor1.home.marco.cx (ip-178-202-227-016.um47.pools.vodafone-ip.de. [178.202.227.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm71779475e9.8.2026.01.09.17.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 17:07:28 -0800 (PST)
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: heiko@sntech.de,
	ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marco Schirrmeister <mschirrmeister@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: mmc: rockchip-dw-mshc: add rockchip,disable-runtime-pm
Date: Sat, 10 Jan 2026 02:07:13 +0100
Message-ID: <20260110010715.1610159-2-mschirrmeister@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110010715.1610159-1-mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new 'rockchip,disable-runtime-pm' property to allow boards to
inhibit runtime power management. This is required for boards like the
NanoPi R76S where the bus timing becomes unstable if the controller
is runtime-suspended during idle periods.

Signed-off-by: Marco Schirrmeister <mschirrmeister@gmail.com>
---
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index acb9fb9a92cd..41f2644ca2ef 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -100,6 +100,14 @@ properties:
       If not specified, the host will do tuning for 360 times,
       namely tuning for each degree.
 
+  rockchip,disable-runtime-pm:
+    type: boolean
+    description:
+      Inhibit runtime power management. This is required for boards
+      where the bus timing becomes unstable if the controller is
+      runtime-suspended.
+
+
 required:
   - compatible
   - reg
-- 
2.52.0

