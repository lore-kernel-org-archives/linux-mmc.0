Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956076;
	b=a70/LougaUG9ro9Fo7mJXPWpzJUu/q49qfEqvQhfXSCbLI37p9Xt09bnO/sxMuo4PME4
	 evFWOSqly6DSoMw7s85N4se42cE00em9I4h1hkL837pBhK3HDapbnKfMCQRqEsKSqimRy
	 6CeP3NNDBmMIYx1zK74RRSRNBhgMKnM7V8ho1Ug6YkgvUKE99uEx0Nm6+oOIxNovtrs8S
	 y5wwSQ8jtYHDdmq8HgOXsi5VuK9P4fv1RcEo5nfTdht2k4IJjjTpGmgIbdAApt+09tTJE
	 ngBZALEILUQmz0nMcE5BC2suFN1aG24Xc5YNLzdZVnIK2lV9HfbtTfc8GKLArzEjQAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956076;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=gPVDVkRJaq4Rb+X6fDN8QSB/oUifhBEsOEHySvrZXRo=;
	b=sPxVgDnixVudiu55Y0oAN3wprD8WK2Fr18IxJ/EnV5umJMXDBNhN3N2slps0E5fU9gO/
	 29XjM8PJ3yTCYuNN3Q4vFBPRBaAK4QwqD4x6F3mPDPzj6Inejvubc0l9gvtujuoQJFy83
	 soatImPzmFmzG/Z4y1uAiUvqFoVIPr8dZxvtZ2f+VTDnR7wtottyUqQ734HNDl0mz58EK
	 Lr8l67QWgSIdmXhAkRS4osluWIeivWKzEimutQYa/u/2IjPz2xXHozVs8sK/uBScfN4aS
	 XgtHqGNCydrU3HLt4DEIvwbdKCprkbJVz+oRjCTA8bgzoqS1+o1TRCEejD8Ed+6ME2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=p6TpQbUE;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14424606A325;
	Sun, 25 Oct 2026 19:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14424606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=p6TpQbUE
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJL1Gt515970
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:21:04 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJL1Gt515970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956065;
	bh=gPVDVkRJaq4Rb+X6fDN8QSB/oUifhBEsOEHySvrZXRo=;
	h=From:To:Cc:Subject:Date;
	b=p6TpQbUEPz5mfy4/LMfnjk1g0APkK4RYhQxSPjJmbRvDjPTva1D6zOd3wEDKhF9sP
	 JoyL8fmW4LKqXy5PU+ZfhqjhcAqE+d1yn5uOUX7f4oHsSrWEsSNOZscRN2P4vCH/qG
	 ubMmnhuMcaDGvwiedXDXCA+BR5zodwc9mfiO+m5w=
From: christian.koever-draxl@student.uibk.ac.at
To: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 0/2] mmc: meson-gx: make the core clock phase configurable
Date: Sun, 25 Oct 2026 20:20:57 +0100
Message-ID: <20261025192059.208792-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The core clock phase is fixed at 180 degrees. The SD slot of an S905W2
TV box fails with CRC errors at 50 MHz with that phase and works at 270
degrees, the value the vendor kernel programs. Add an optional DT
property for it and keep 180 degrees as the default.

Tool use (Documentation/process/generated-content.rst):
This work was done with the help of an AI coding assistant, Claude
(Anthropic), used through Claude Code over many sessions. It did a large
part of the hands-on work: it read the vendor kernel and the firmware
interfaces, probed registers on the board, drafted the code and the
changelogs, and ran the builds, checkpatch, dt_binding_check and the
tests on the hardware. I directed the work, reviewed every change and
the final patches, and take responsibility for them. There is no single
prompt to quote; the sessions were of the form "find out why X fails on
this board, fix it, test it on the box".

Tested on an Amediatech X98Q TV box (Amlogic S905W2, S4 family, 2 GiB),
vendor U-Boot and BL31/OP-TEE, Linux 7.3 plus this work.

Christian Stefan Kövér-Draxl (2):
  dt-bindings: mmc: amlogic,meson-gx-mmc: add amlogic,core-phase-degrees
  mmc: meson-gx: allow the core clock phase to be set from DT

 .../bindings/mmc/amlogic,meson-gx-mmc.yaml      |  9 +++++++++
 drivers/mmc/host/meson-gx-mmc.c                 | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)


base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

