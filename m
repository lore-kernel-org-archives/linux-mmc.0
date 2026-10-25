Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956077;
	b=liM68I9xy6pwB6kcgyKkgdwj+V4z3uf/vY/GH1qJcaO3ywKgsg0TbgSPN9wrozvEyJIa
	 JkGMGWxFLJrFgpazTd6rz3DQMTSyxVMRwnilm3xAahog6N+tQZ8GLbXASs0UGpW5p8UWc
	 WV+HUwKOy5Wk9u65tl6mzw2ZcJMJunAsiENsfmgtmXZXckzGuVxgJOMrwJ021buLXm5XZ
	 l1fMyOfq1biy4PwV0Y7F1xDhZJyi+xmsETGcUKvUVlv8m0N8FIXPlEgI6bQijGyWR9hb6
	 cm9cV4+3KL7vHumfHQmbR7D/J05XCEiEe0dfwouyPNdQhrzQrixpzObMPOhxZuLGejA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956077;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=83TKF6OdDojPyY1KN+pzZOnG66a9l945Oy7xFtIvD9A=;
	b=0ak6GiXmi4jizcNwCsPcIK1VLMwU4fu9zg6eGUZlnJ/zHflw2Pv/opEXJ19vLsY23tUx
	 vO0XAmx0sinC1p2Z+bqyuRG4d4eKOo8gxQn9ftUjifWMDYSsdRbf3H5KydsyNDwWhsQWU
	 /FWenBLT6xhrGwmejR9LnlpZe46ATE62yeBeYza31N+v5NK3MQTydRe0GZsEdYHKAYK1p
	 bseGIGqDYkabwpiPU+iWx8EBEIjf0bqUkIbJUlAt6MHw61SzpRyK+5pLDZO/l9S9woMBZ
	 ZMBhaRDBES2YhZwOZvUd1srJZ4a7j5TkGNoeXNSFIukHayKJ6qGbpf5U5Ax9UCmibYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=BnEbK9UU;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1B606A322;
	Sun, 25 Oct 2026 19:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B1B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=BnEbK9UU
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJL1Gu515970
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:21:06 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJL1Gu515970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956067;
	bh=83TKF6OdDojPyY1KN+pzZOnG66a9l945Oy7xFtIvD9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnEbK9UU57qCvwyEN0pfU2mltlTqSviXEx7oX5BC7t5Mq0q9eQg6M72LE9D17Ancr
	 bdzMEHSo5XEBbJGYmuAMhsZ8rSa6PnZfI9JRa4xrxymlJ0l5Zj0X/27hsMTRY/gTL2
	 NtKgZ7U7h1dbThIOfrW89w162D67kc+2zcs2msfc=
From: christian.koever-draxl@student.uibk.ac.at
To: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 1/2] dt-bindings: mmc: amlogic,meson-gx-mmc: add amlogic,core-phase-degrees
Date: Sun, 25 Oct 2026 20:20:58 +0100
Message-ID: <20261025192059.208792-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192059.208792-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192059.208792-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -10.0 ALL_TRUSTED,DIPLOMAS1,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The controller samples with a core clock phase that is fixed at 180
degrees in the driver. Some boards need another phase to work at high
speed: an SD slot on an S905W2 TV box fails with CRC errors at 50 MHz
at 180 degrees but works reliably at 270 degrees, which is also what
the vendor kernel programs for it.

Add an optional property to describe the phase.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 .../devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index 976f36de2091..8123375a66e0 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -58,6 +58,15 @@ properties:
   power-domains:
     maxItems: 1
 
+  amlogic,core-phase-degrees:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Phase of the controller core clock relative to the card clock. Some
+      boards only sample reliably at high speed with a phase other than
+      the default.
+    enum: [0, 90, 180, 270]
+    default: 180
+
 required:
   - compatible
   - reg
-- 
2.56.0

