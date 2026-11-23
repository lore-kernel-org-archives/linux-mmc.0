Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461435;
	b=lMLTt8Y+mjJVE/zNX1J64DT8uo+pDW3vbSBc7NjHz0WqsDFzYYGZKIOtO6Sz6pNuDg8Q
	 ZnpBWUrj9USSWAj8NbwXAVrO2+B22DAm+RqFQm005E1GCVGeLxIDC/r9RJyTKLKAAppJH
	 clEkfWoBpeT/9Xq4bQKUskiI9ELTcCOSzjwRbJxOCsXsJv1P7W+f8nIB3tOyRAmQkmqeh
	 2ZZDDSIMxScFeyNyFPAYnxpKvi0EQaCCPinTPpD1y9y7GOdT2ZgjmJn/LH9HHEq91pOkH
	 BA8ILTWn0NhpbEMNcWY0OQp/dZwi7okExDy++DozAcl+UoUh5ygIKeOrYEeol7JUYRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=93LY7kxfE4k6lRlMsqn9aMoZqt0mdV8mOF8QxYg6ZSM=;
	b=n4kBoMjK06/TAoWMUhniGWh/VW85RdXyU66Ek4Er3XljBRtmAvEaPFLXMDQNjUh8kg3F
	 5KXNmF20Aw/YZR3dU5xwnO/J3b6HvRnsHfjmEf/tiaLZSgSAk36vgBbujA3PzEigRGNaW
	 WvHC1xqE302xNjdchtWt8xmjNP+86T6RpqTIakijq+OVtX5PMeGvX9yckWsEyyDAO6W+q
	 pyfJknE3qeLrMQMEpF4TZTZMU+ceT1/hXGEmi+S8Ay43QZfqD1zgNb/p4BEzh3OQKxCUV
	 oNhljIDRXLVowg7Hgz40Z+vnFD8Iw8Ql0DiaiQXDRRptCZb3+jiZIMLzBXfJ41sAhbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXV77g+x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED3606A31A;
	Mon, 23 Nov 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXV77g+x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA881F000C4;
	Mon, 23 Nov 2026 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461434;
	bh=93LY7kxfE4k6lRlMsqn9aMoZqt0mdV8mOF8QxYg6ZSM=;
	h=From:To:Cc:Subject:Date;
	b=KXV77g+xEmHcy7JpHoLaeSS6FNFX59hjFuDeFdRUxf8bakm+MFK4B1tIxcAizka31
	 d/TYrffwOZ6eh2MYxzhBrE9U7xKPR5+FHseHQy3XVCEuumJvJPUtAspAB82Q6LKRcV
	 +o6jDteDq6bDsXTuRRHptp7IXtEnseEwH8XiKo1HADF54dAIvJi6/mXE3DU3W+rNYd
	 R8X9ukWTBJO7GV23deLPIpUYCKrTq3QNVJ0MEsYklQIkIINdoCFxejPEeZCuOl7VI+
	 42puN8d8vAQ5rB9YQ5J0VPQzofHnbk2b+w3U4zA8Rv2LuQfEh9+It5SOowCZK4UM5d
	 jxMn/yzINazhQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Al Cooper <alcooperx@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Allen Pais <allen.lkml@gmail.com>,
	Apelete Seketeli <apelete@seketeli.net>,
	Aubin Constans <aubin.constans@microchip.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Cavium Inc <support@cavium.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Georgi Djakov <djakov@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jan Glauber <jan.glauber@gmail.com>,
	Jarkko Lavinen <jarkko.lavinen@nokia.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Josua Mayer <josua@solid-run.com>,
	Juha Yrjola <juha.yrjola@nokia.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Phil Blundell <pb@handhelds.org>,
	Pierre Ossman <drzeus@drzeus.cx>,
	Pramod Gurav <pramod.gurav@linaro.org>,
	Ritesh Harjani <riteshh@codeaurora.org>,
	Robert Richter <rric@kernel.org>,
	Samuel Ortiz <sameo@openedhand.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Tony Lindgren <tony@atomide.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Date: Mon, 23 Nov 2026 19:15:44 +0000
Message-ID: <20261123191703.179283-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
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

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: "Niklas Söderlund" <niklas.soderlund+renesas@ragnatech.se>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Allen Pais <allen.lkml@gmail.com>
Cc: Apelete Seketeli <apelete@seketeli.net>
Cc: Aubin Constans <aubin.constans@microchip.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Cavium Inc <support@cavium.com>
Cc: Christian Loehle <christian.loehle@arm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Georgi Djakov <djakov@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jan Glauber <jan.glauber@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Josua Mayer <josua@solid-run.com>
Cc: Juha Yrjola <juha.yrjola@nokia.com>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Phil Blundell <pb@handhelds.org>
Cc: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pramod Gurav <pramod.gurav@linaro.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Samuel Ortiz <sameo@openedhand.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Lee Jones (13):
  mmc: cavium: Remove MMC slots before destroying slot platform devices
  mmc: cavium: Prevent slot_pdev[] out-of-bounds write during probe
  mmc: sdhci-msm: Resume runtime PM before accessing registers on remove
  mmc: meson-gx: Fail request when descriptor chain DMA mapping fails
  mmc: jz4740: Skip DMA cleanup in PIO mode during post_req
  mmc: renesas_sdhi: Guard host->cmd access in internal DMAC issue work
  mmc: tifm_sd: Synchronise timeout handler with request completion
  mmc: omap: Shut down cover timer before disabling cover BH work
  mmc: renesas_sdhi: Disable internal DMAC BH work items on release
  mmc: jz4740: Apply DMA max_seg_size limit to unified tx-rx channel
  mmc: dw_mmc: Disarm central watchdog when ending a request
  mmc: renesas_sdhi: Fix SDIO manual tap correction in SDR104 mode
  mmc: sdhci-brcmstb: Handle absent optional sdio_freq clock in probe

 drivers/mmc/host/cavium-octeon.c              | 17 +++++++++++++----
 drivers/mmc/host/cavium-thunderx.c            | 15 +++++++++++++--
 drivers/mmc/host/dw_mmc.c                     | 14 +++++++++++---
 drivers/mmc/host/jz4740_mmc.c                 |  6 +++++-
 drivers/mmc/host/meson-gx-mmc.c               |  7 +++++++
 drivers/mmc/host/omap.c                       |  8 ++++----
 drivers/mmc/host/renesas_sdhi_core.c          |  9 ++++-----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 13 +++++++++++++
 drivers/mmc/host/sdhci-brcmstb.c              |  6 ++++--
 drivers/mmc/host/sdhci-msm.c                  |  8 ++++----
 drivers/mmc/host/tifm_sd.c                    | 16 ++++++++++++++--
 11 files changed, 92 insertions(+), 27 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

