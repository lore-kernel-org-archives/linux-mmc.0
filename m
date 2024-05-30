Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8EE1761AC
	for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063916; cv=none; b=hCYpCF1eJ99ygO35T7qCkCszIDHNoFR+N4u4cHlrnIuWUrKLEA5xg5CsFu8DvpSYXCe3Nb662/9uw/x/n5l36oGEBdEjCcdXgATyY2CQQSZaXPlhk8M7DgQjUc8CXmy7w/GTbJ8wmckz4okA5ssYq+xWhZG0m3N26wVsNLnd+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063916; c=relaxed/simple;
	bh=9k25ZsPTf+WrTiK8qVLkskl+r232la4YhtO+5MWY/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6SIeOJKHmdziCayEXTUedg/TkX3+gIRrhjr7gHBa4g51vbB/a9FRlzBaxxxzcyTAt6pPzVC7ZS3rVqsfMAldC3oAZIz6hquUWwwPdHQpFGRU1Olrgl4IRdFnOZAmncx6BzcEH/F2lZj5PywoSM9WKaNBzRdrmx/gysBl306jg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T6kxHMix; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T6kxHMix"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a63359aaaa6so68036566b.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717063912; x=1717668712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=T6kxHMix00GpftiiKyv0VD52d6SEqvdtSVWywrdtzjb63fAvKoKt6orxpxBQgV9xva
         nhSCNE1HZP1fMTMKkbZySpOou3JqM0ffQslwjf/sHUuYgUORiAr0Ugsp7Apj8cg9UHhC
         XId+dw4kQSOIWRSfYFL7b6v4H9DbuZcG0ceLlCqVvfWDr38nTFaTs3/h+Nh9D5z0qbbb
         HmqVRw2Tbw4uO817Lcr3K8RL8U+Ah8/S71U/fKA+Sx8uUdcB0R3IhzCjFIbIw1674RIQ
         IVMclMlbQc77yetlHO22Jv120plLHVqCxKvUI05ztKudo3oHiaxkznJbgYTA/yi+/vfe
         Ioiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063912; x=1717668712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=d1vsTrMoBV9S6aglrlJ5qjsTXtXTTyyFHiwNMSd1Ryn2t1sS51Ec8FNe3YuYXXcx4w
         7/Z+9I2s3KtuwQZlKgK73ra6O2xe2F1GKNS7z6Tg+t+mtBjXIrjUyNA019orK8+eSl1H
         zbdlEy/x/ZZhAjIrKsld9T/Dp5pTS19i/Wb7lFvN2XZZTg9fKX47BBcj1Gib17GkNfg/
         gkwQrZXJaDDN6v8JPNBLsNShCCg53A07iw2IlrfJvlVq8zBipPUhWrgII7sErsvAKOPO
         pQCBG2oFTS0SKyhL8JXNH033JieI+YGwZBhdX1IESFi3fnDyHqvVlP/f/Ciks8v7nard
         LP4w==
X-Forwarded-Encrypted: i=1; AJvYcCWZIkKTHgt3+yFY5yZZL5PBeTrKeocz+z+jKQtkgSrQqg/F+67kpPjNjSEptjt4yomUsm4k1WOJ7Qp5VlJt3IlrhDr2l1kCq3MQ
X-Gm-Message-State: AOJu0YzZ1DCJbd/hE08JiKzFDDhzLYmbUyS41xo8we+OcH9L9/D/YaoP
	lzHgmKEZ6zNaL8a4Ii6SJ5avt5UqmF/GfTL3bjccBNh7UDYTIS4vQJjgB2YPd7k=
X-Google-Smtp-Source: AGHT+IG6vOKxmXv8nCgMHO2OvGUDB3hI/jUTu/PT7FJEt883f78DKzfcgjYenxqhkoix+4qZL8F/vg==
X-Received: by 2002:a17:906:40ce:b0:a62:d348:8df4 with SMTP id a640c23a62f3a-a65e8e5d49amr108103766b.30.1717063911753;
        Thu, 30 May 2024 03:11:51 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a63570e5d0esm217427966b.214.2024.05.30.03.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:11:50 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Thu, 30 May 2024 12:11:58 +0200
Message-ID: <cfc4db17981ef946a71d40d522118a560aa0f15b.1717061147.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
References: <cover.1717061147.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3

