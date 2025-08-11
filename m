Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EF2E0905
	for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925490; cv=none; b=cs4RhKF1FUfFbzwtMwqxXrLn9DdcefY4mluz94QZaiip9BKr3pfaowhOZvgZT9OMdGyP+ZuJpc68KNio7IYriBBhuZlux0XSKb++QoDCxf5Lnq4sJVLS3RO1DdkdJbcu7+8rDhqse0kf6CXrwVWxWh3USGyYglVz+7gw3akUzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925490; c=relaxed/simple;
	bh=YvWvllehKsY0eU8l/4yDh9aRcQewZPW2zyG86okcjvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW1fOwdasyepB8TZqIuuTiHtJgUpuHQQfcGIz8d8gFx/qzWfK5naUPOdrl/VLUiZuBDZHCbztZO/jynEm/UZbraQ/cn/a6uNi7RG7M5rhJdQ8OIsuv78fFsIFyH5SLowRc8QkH1f+13oJoRMc5Yk1p2h0nSdaq2pvkQD90dTnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMqv0+yo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMqv0+yo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso6903550a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Aug 2025 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925486; x=1755530286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhh5zaRs2oIpYFCywf4aV1Gc4V+uvx/WgvPXoTIlm1k=;
        b=DMqv0+yobTAyM91z4NzN/4oh2hr/MAe7td/gR0I4zmjGfVpdx15GBl7cbemZexMUjU
         3wgobkmvDin6LXVZrIO7BYdbkh5G0QpioJJ+RThHorYkjCZirZ9phowRd8UkLV038sdG
         EM9SE82p1Hv+PwnNbTZw9xInsSR5Gz1aibVjzriem6zLdax4wm6akVZhBmSftmd1xLLL
         XsF2d0P+3CjuEWf2cuogzfT3XZ57FpC/kMwTFUzdcMckqafggJ7hLo80rssrn9QPyejN
         DzkRUL0r3Bu0BBTxTDG0u5Mk/N4CdubSXWzXSe8GVDeYNNlm2j4JDpIneNLVd27PU/4a
         MkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925486; x=1755530286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhh5zaRs2oIpYFCywf4aV1Gc4V+uvx/WgvPXoTIlm1k=;
        b=Mvpa/YS9x623+HpkY+TT1DUj0+lK7eEtQ++ItPjc22RjwmwpbRNGZpaZD/LkwP/oRz
         F3lAw+oBQf33wKhUhHMcmUy0UKmJGGfZVWmwasNnsPRQAIGR+9jMBDJXOUoFeVvovsHj
         jZhfunAYOOtVGrQn0mSElvZgXrf89wpkKw8JWGOhGKwEVk+5ZuISdrAZ7qhPtMA6OVjw
         upVcyb6aqqnFFmp2EsebhutVni8UXe1kQ/7JJaANpojVqXhCjZ2UtDZd+8KyCRAo0PL2
         R+N+tO00HJ3xC5SXxfIzF1+XfS9HxwakM+y3ZjO1X7V4B+wpyEHXuM37wjRJw54jGJN5
         G2IA==
X-Forwarded-Encrypted: i=1; AJvYcCX6oyv+wvq6Tse+LITP6QyhTIMUpmO60XhoG3hqUJ4iKR1E1dmlOw3n3eW6cOkRY5rZrKwbhmaZne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtX8onl/PBmrCGoKdr6ufR7XR/sXqeSXR5DYzN8XIjAE5TVOs
	TZ4VlfYpcZIzN7wDjRM5JhJEvCnO04RDSCmljV/1QpaQqZxKHo+Y+qZKE+IQ41L0SgY=
X-Gm-Gg: ASbGncsL6mK0FoWO6XC2vTEEC5qymMEAnWJJ13+k9rASMoLermLy+KcYt16IfjuY0Wf
	m88qaUcYTOiw/QZGDVtFfR7KI60cOI+Pfqhwx+y994uiAtCQkqn7cyENHzhHjt2UAJ3RIsMbBkn
	C6D9exvuots5oFP4bBovlHhwi05XTVgPAUqSahVCJT8fxjE2L1IGk7DRsMRgrj90cJL0v3mcJJs
	UTbjbt1lhYhqcvb9kC9EagGmsRrsM27ZjBv6yCle8foOHuGW0Fz2zDOXB1SfhHbv2cNKbdMbvrU
	W6+QL5SHZuRkJThzzK+srTternmjTHRxUTeL3ysYKCtezNw5/obpUM8ksS983mlxvV9fHatgtcm
	3uRXkvUhaAytle8MHT4mCxT8CusHDbcLYmYUKHv552g/r0Jw2d1XHByhnW9+KvLs6og==
X-Google-Smtp-Source: AGHT+IGNa3UAEq/Ce3/sswcy3A+j3yXj3Hu9QHzagv2xAwHzDuZRAXkuzsWUlKzyxvuIXzuGjI7OUQ==
X-Received: by 2002:a17:906:9f85:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-af9c6373614mr1374008766b.18.1754925486344;
        Mon, 11 Aug 2025 08:18:06 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a07659dsm2020105866b.21.2025.08.11.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:06 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 2/6] dt-bindings: serial: Add clock-frequency property as an alternative to clocks
Date: Mon, 11 Aug 2025 17:19:46 +0200
Message-ID: <419658ce1a1009c6f8b7af22a02b278cd695dab0.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754924348.git.andrea.porta@suse.com>
References: <cover.1754924348.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UARTA controller on BCM2712 connected to Bluetooth chip does not
mandiatorily ask for a clock connected to the high speed baud generator.
This is, in fact, an optional clock in the driver.

As an alternative, the call to uart_read_port_properties() ensures that
just a simple 'clock-frequency' property can be specified for the clock
value.

Amend the bindings to allow to either specify clocks or clock-frequency.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../bindings/serial/brcm,bcm7271-uart.yaml    | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
index 89c462653e2d..96697b1428bd 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -40,7 +40,15 @@ properties:
           - const: dma_tx
           - const: dma_intr2
 
+  clock-frequency:
+    description:
+      The input clock frequency for the UART, Either this or clocks must be
+      specified.
+
   clocks:
+    description:
+      High speed baud rate clock. Either this or clock-frequency must be
+      specified.
     minItems: 1
 
   clock-names:
@@ -61,11 +69,18 @@ required:
   - compatible
   - reg
   - reg-names
-  - clocks
-  - clock-names
   - interrupts
   - interrupt-names
 
+oneOf:
+  - allOf:
+      - required:
+          - clocks
+      - required:
+          - clock-names
+  - required:
+      - clock-frequency
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.3

