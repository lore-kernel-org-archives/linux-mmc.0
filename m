Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426280;
	b=Kpz7c0ODURRL/TpqSB57zAVIpe+XPLb+9qxI1qzd1xsC9DqRnCriL0E9EbkzIDFFEqip
	 tYCNmQfXBtd3SvjJ2xX+VV46BajGuzssQLIS6B+yb9Lkxjali+nV83BDZh5AHrr0zeS6F
	 ciAdHUKnTjq48Er2pXZkCPQ7hVfdC+pW7nMm8uhv+li4a5rOxY3KmDUxV7acwwrU72Z0e
	 ule+W6Nf5QNPC1KAakQypOnl5UlOrkObgylhjad4iI2OwLdl7KopS85wu9Hwj/DUaAU3e
	 ILBTsve4ZQ9SxGsNc2IR43i0H2kD+MWldETngzH2uVkpQmzv/YfKj+SYlXpwRj4gi5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426280;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
	b=Iuy7PFVirfFX9EEeXCGEAj1Q6KnGfH1hx7C5z8/r9Pavs5wAgikTw4V3GRPPitIDaGhN
	 lVyVgY0j4iF0cXPWqiy1MPzuQDQQdobDWRyLK4Toivr/Loxg8WWaenTqm0WzBZaVxOoA0
	 VMpZwe2Xyzegq5LYY4FelTE0nFt7wJ3c7e5kpEIZQFPqo0hQZVP9FKhWZSjH0FcHwH9Ty
	 jSSwfwc+yeW4VGDerHL5KGJFLde/4O2CIiwFohGcQHteGezqAiZ0mzxi/XLLhXfLLZHsb
	 /Bwi6Oo4/K72W87r55+af47NuuVQ3OpPCQgpTQTANK4PD+sKHvs2TRl+9YF12MlAY6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HBFXkPmZ;
	arc=none smtp.remote-ip=74.125.224.99
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A41606A330
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A41606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HBFXkPmZ
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-67bef25eb92so282332d50.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426279; x=1795031079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
        b=qC6deoTRQvJ1wtzNio4awFlF13kUuWDEq6f0hUV5HOuGbGnfS/cQHEM42HEWTfWnH9
         9w3OFDETvb0xJF8npw4BULtlI49F6cWhgS4lS0qpT/DSWW6SKNvHEmBfYXElruG/nDc6
         yIQ7EJbkuOAM11Kys4ozgiYPKke8pa7Yh9CUqqfrOMK2+FADyaYhljgBa49GY8ffwSi0
         hNcfGVnUuQS1t/nCkqrAIFlv4s7EhPGtLwMTOxmQzJIAq0/eap9o2R27+Ky/EbRSfndR
         EpWUp+ec0KB8zFTCxjIQcZLyPDWZk6fhEsi1EVTwYqLQjNTL6bekbjSWLP9hfWop6QhP
         ajLA==
X-Gm-Message-State: APuU4Z+sUcSOGIUiGntf3V4NAXkgtaTjUmJ8NkEE3BBc26NHeYMq0Xn1
	4CPIJ5OHFVs+gZv8aQim8Z4HjhiQS/b4rNxmkfSEM5omZigYBz64cL4HhqdQIJpZJ/00qzG43JO
	XuEnOnHFn6KHCvRniGQRsecGiV0p5BJREcl+tviHs/xzfAxmcq+c9op9cZ42fpl9WSubXLOH26M
	+HePzk2K3UomKLv7PfEWrW4ZkNKUiSMAJnxGpkJtvvgiEEwNGWJRGqQxCYhXwTZlpH5yyzLWyV9
	boOYg3BtVXP
X-Gm-Gg: AYBFou3YFh+dksRZk68UGXjBEP5LFpIih0EyxQ1KBiGx1mxH7z9S/GrahAOuppm2P6W
	5DICe7/q08YLNvXPz6mIs+uF5odiinU8RPRzCiI/8/XwsM9aaNdLOqV53I6Jxb1Z9FjLNE8YdNN
	wGj3YYo6SRDjATNwp0TPa8JZJmhOQu8QFvXw/9ffe/ijI92lgI68Dg38bWTPWKr3eDoL84OIjh1
	ncrufryp3+szEuDVChtxWhi5d3xX0GjSqCbho1WDOB0DbI2CXs+YrUovKnfBW428WUV/ddLXPC+
	3q4cNpVAi8jz3u1It8su9QtLQpGqryea/7gtyqr+3seexlw5CoieMc9Wh1Y9shie52V5J/C3ynM
	/lOgs02wt+Rza4EO+lH2m49zPvHaLtsamIHzW22EZ7VMk1LVal2a4xBsUoR6Ni9BAs+pxHskM03
	7zWo9VfAwM727yP7pCeIsHbpDmLPqRERjv
X-Received: by 2002:a05:690e:4854:10b0:67c:2c2a:bb64 with SMTP id 956f58d0204a3-67c78cc7697mr201382d50.27.1794426278998;
        Wed, 11 Nov 2026 11:44:38 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67c58a327e6sm47984d50.34.2026.11.11.11.44.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:38 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3ae327c55so99402c88.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426277; x=1795031077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxDwlowRXj+Slu4vqivQluXlihnRgzelIMa72vyyFyg=;
        b=HBFXkPmZ4z1sEy4//jj5YWIesewdqhX+n5LKP/wpke704q2Gyb+J5Ss3tyU62FnDvS
         ypWo7OL1oRZ3oGk0rlKl928/jwonSgXWtf3lt0HKYILiwuq5wj4eIJA7VpUeF393Y9ii
         iHA9pImpAXWnuqACUONhgE3/CYVjivnn4wwMo=
X-Received: by 2002:a05:701b:2313:b0:13c:f65c:d5b5 with SMTP id a92af1059eb24-1b4f5ea8322mr355071c88.3.1794426277350;
        Wed, 11 Nov 2026 11:44:37 -0800 (PST)
X-Received: by 2002:a05:701b:2313:b0:13c:f65c:d5b5 with SMTP id a92af1059eb24-1b4f5ea8322mr355034c88.3.1794426276383;
        Wed, 11 Nov 2026 11:44:36 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:35 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v12 1/6] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Wed, 11 Nov 2026 14:44:21 -0500
Message-Id: <20261111194426.1652644-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
References: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 8b9b3b036129..2fc8e06d5ec9 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -301,7 +301,7 @@ properties:
   keep-power-in-suspend:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
+      Preserves card power during a suspend/resume cycle.
 
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
