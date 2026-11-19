Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110616;
	b=V0xI9Y2cuM66iawzO8ZVWzf+ntqSZzvkzdJD+/B+XZiXYn5xiPy77flzVRj12b2brI0q
	 BPADE/Xy+iXPOncb/Y2gIq80zd8EmPeZ+7tLnPfKp2WT9cftNZfW2cnvmsZCANfq1IoUW
	 BEUZ3tOPG2lKxz6tsUItuD/cdCYy72pQBdmGCufPcoj+6RYctd4C2Ye9nMxjJ0fNnVp+H
	 uZCpxwZ+WjtZyqbmw4eA6V5lvk0/IOwpA1Sg9YWn4AykzvmZAfCrHXhtTw8CpdYvlIn0X
	 w4QoAx7RmiiECEsS5Hho+FETrwACaT6XQdCPzW/Vc3DKG88KJikMcP8Wb8BqH0y8c2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=esT354LfgWAtzd0fzH7vF+hhVEnmCcI3/TAJZroHtbo=;
	b=rd3RovEdocv9dadx5uyuTYCtLuZquAKEIDPPGQ6GdPLN48pfGKOjqhnEtzUCXEhe8a8H
	 MOV8kwLXoYAaabLYwEx6xv9J2HOFBlgp/3AeeM25FpOwe+IlEoAUQ95WATJeKcJBPAuso
	 pXZ8NbV+SHK7ODJxnWrFgERDMc54fhqNlqj4W0rr1oFZhDh8ezU2MIcOROCAdOZL0PhN4
	 R7ceZL4tjO6GVFUvYOZ0e5WyiajQdWRlKOPRb6Qb3HyJ9D2mPTRTkRK3KhJ8UtxIq5I85
	 qbqZSg37j7pgFC95R4Fhr60fb/2VnrYY7Ym06gF59Je/KyV59ZFDcYkQXyIP3liqlJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HqIwrB7x;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01960A5BC5
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB01960A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HqIwrB7x
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a9be758734so731010f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110614; x=1795715414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esT354LfgWAtzd0fzH7vF+hhVEnmCcI3/TAJZroHtbo=;
        b=HqIwrB7x2+DpqqIgAt1fYw2X+S0cMj8zCUqo/TtX86KaS4qJ5mPzW9HLO8eqO2WDh4
         f+Khohjj9EDyDE4t1MOVwWqhBgN6AjH76sRgY4qojJCrR7L1gJ1A9Fdd2lpjkHyHD6lt
         5VNSXCEizYBZRgwGV32R+VJPHlhk9toLuBUl200ttN5SIS68yC4iCUGC0blpVJmbmYxL
         EKvoeT6aFBbexdCppiSSpaeeAcR++6QXZG3HB2r4kmmF95cLAX0hydKb9sIo3CnsQdCu
         vsuCknPexkSExhRu5B7HWAu4hRQ4egkHYCs+QC+l9Z2clQ4LZmhyI0afLUfzzFGEUIYF
         pdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110614; x=1795715414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=esT354LfgWAtzd0fzH7vF+hhVEnmCcI3/TAJZroHtbo=;
        b=2yyn84rmM8MCoFhBeVAdoZoyITzXyNJG7JdZeUJ9KlJUBCuNJrsp//LHqg3KAyLnU9
         ri1cCQ95fWdbZlcKnPgSsScZZ6czyyh6YwPJZCCJxREqIh7w31N9uagLHZZqv+IerYLJ
         91tfD316iMZaB+QrGKbZRxWEfTGijcA6G/NVZJ6lHjqqA15PQC1GzaTIttHJIV6gmK5G
         PfS1axXbydywNqgD10/v3xF3m6o20v5WKhyh98jbnuxX7YwQjezYlRUXk7N62+HAgnC3
         rcxuERfTQAJZJuEbBw3qo+75H/HWKy4Mbhf/uLsOOY7giCzGMSrq/UP4kcNheoRtKjPB
         OTIQ==
X-Forwarded-Encrypted: i=1; AL+hErFkAI9krjx0YRxTPJoFK+b25/WPOyLqavTJOzNhwASfuxv+BPXxsoxuMNRmzUmvWstotwG2+vUDZrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R+/hlrvUtSqDPQ7/x/1OLzoFT44e1t7KYqA4zZp+H/NOWu10H
	vMnC2PVqzkywXRYV/zG8/J3qcU4VLpFBXYqVQOMaQjTsw5BDWtX6VdAij0/udeS4+dY=
X-Gm-Gg: AZFdTZeQKuOy7Elud6HKRBnVph+W47XNYKxQO+yhlCR3f4nGoQkeOrXZSiEocCPUieh
	JPmP9E3nvZve1Hq264r00smshei3d/2ZLBzjNfVGfu9pkP/zvFqimaHf3L7KP+YrXjLZmxbWkEr
	P+uPwNEMkFPK0cmXw7eS8GQTCVx2SlS/9Nkwfi0pmj+T0HomTwletFj8kAhD6iTgRxEaR/aaW96
	yzRBQsnGZihTGP1LVlfH4vhkl/jG+nQ+DBrYHAqIhq6e7uM78OQr9op8g3DHjQEHu0j4kgB/ExR
	cpgdllE4XEyua2fap+mvNhRd3eOW7Mp2ws+nC34spzNMAlkYnNHXLEd/ygGc23Ta2HQjYWSCENH
	4VO3peHLewd88d/dalbD9Wo0VCXTIP7zDWPW2qIDLgiX53iupdv7wAcAenq132UN+4JlUD/fDdI
	M1nwZzzoFzsRN/3jtp5Nq7nwOdBvUa261xEr4vvq8sHmBFM67HFvdZyyZyhlGa56JT3vN4P1MDj
	On8TLueYNSyQK9VseKumVeeO3HfAthZfT+gNEpdPCcy3/8d/iNSjMQZLeoDMX66T+WxE99Dl25I
	YEkNCawpgvxmQ9o13hV+wW3GCip8tBsq8rEfIFaC+r3zIgzTmZH8VO/TEod6skd+Q4rm2gHBJcC
	aVfr1S9RnBrCM7QH68YCaFWFKzPta0wJs8P8zzZo92cF44SjfxeOmdmv1H+j4sYG4M+MzK/zrPc
	/bLIk=
X-Received: by 2002:a05:6000:4a0b:b0:4a7:4efc:11d0 with SMTP id ffacd0b85a97d-4abaf740155mr279928f8f.12.1795110613914;
        Thu, 19 Nov 2026 09:50:13 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm876032f8f.30.2026.11.19.09.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:13 -0800 (PST)
From: Arthur Heymans <arthur@aheymans.xyz>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH wireless-next 07/10] dt-bindings: net: wireless: add XRadio XR819
Date: Thu, 19 Nov 2026 18:49:59 +0100
Message-ID: <20261119175002.458988-8-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119175002.458988-1-arthur@aheymans.xyz>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
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

The XR819 exposes one SDIO function. Boards may provide a MAC address
and wire a GPIO interrupt instead of using the SDIO interrupt.

Prepared with OpenAI Codex.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 .../bindings/net/wireless/xradio,xr819.yaml   | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml b/Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
new file mode 100644
index 000000000000..4f6919b6bcbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/xradio,xr819.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: XRadio XR819 SDIO wireless controller
+
+maintainers:
+  - Arthur Heymans <arthur@aheymans.xyz>
+
+description:
+  The XR819 is a 2.4 GHz IEEE 802.11b/g/n controller connected to the host
+  through SDIO. Its out-of-band interrupt may be connected to a host GPIO.
+
+properties:
+  compatible:
+    const: xradio,xr819
+
+  reg:
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  local-mac-address: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@1 {
+            compatible = "xradio,xr819";
+            reg = <1>;
+            interrupt-parent = <&pio>;
+            interrupts = <10 IRQ_TYPE_EDGE_RISING>;
+            local-mac-address = [02 00 00 00 00 01];
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0cf311e6c4be..6e7b5f6beba4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7211,6 +7211,7 @@ F:	Documentation/process/cve.rst
 CW1200 WLAN driver
 S:	Orphan
 L:	linux-wireless@vger.kernel.org
+F:	Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
 F:	drivers/net/wireless/st/
 F:	include/linux/platform_data/net-cw1200.h
 
-- 
2.56.0

