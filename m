Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795154007;
	b=LlOHJ0Q+HE2SrRPGs5ygdjVNvOWkm5Wf1MnBF5n82goeqolgTl5xpl9pUCHq6QUSk9Sh
	 uhaLevEFILu4aYGew11c0A1VidZoWPiHu0K96b+WagHymEaYhc/pnsVxgpoUnDs8KhQFs
	 dXhmds8boo+wbibvnGUZr+JM6moy6VEl02HUV8ycJfj/jI+nJhEagk5yfUnXlpL3r6Mon
	 LKowN2hyRAKujaEe96R23CJ0UzDmzeJRZHH9s4I3fjvstDRYYORmbjbwPMqkq4syq48oX
	 fADLc9bamL8QAwRRZXRcjy+ZsOBonOEASvRv0PopVcAOGqCASIEK63xN3zzPiPw90/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154007;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8acJLKDDuAq49IKqU6CJftqIRFxZoq6oCQgLOqzp0Bg=;
	b=2WOur57y9fjVdsk+f1QE0ejwD1YtrYqr5v5oIBG05hactW2VWBnRvV4NtTTWZ2LFBQxp
	 M1nWS37LyIiRs2C1K7k8dPR6t2j9R+4B5PCHl+ZP+0sHrNbEBWgevADchaKWmDoItpWib
	 RSUKnjsIbmrZYdsqmrR2JVKtchnoSNMvwCrSRdY63KqpYUVUp6zNlO8ByRc1Ltiyo9WdB
	 iA6Bq3vElavIg+cQmneOzRSF6508dW/KQJTvIDgOjGPVzQw3RqTEmpb52tIjwmuDlFYOI
	 HYsoFutCkk/XFZxyC0H68NIhXvb/THi8Lcea+RYlgYw0DVhazUZbmqV9dGadhcznAkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iw0Bqh9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A94606A320;
	Fri, 20 Nov 2026 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iw0Bqh9w
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795154006;
	b=GGMHMyavf4fMZPselc4WIMbgQHp6NAY6UGC+wEo3CpN+ZrePegbuQE5fYfHpausDum5E
	 EmUaZ76NWwaj7N28SWnIB0dAvky8OnJLOmvEUrN4mcdi8Rwp2MayqQLD+A1ugo7lZc0fR
	 YG3MTCBk6zbPJm20BlOwHtHrMoFOVckR5RWozvdeRIW1zegKa9d0eVhtGC6Fm6qezVUrQ
	 DTHgAi9wI9OyJ0DNMjWgZJEFpANH8guEXIg80OHhi3cY/Vn9y9k3dM8uQgLWA5PioDI1h
	 OGqpx0rHtXeuQLsr2HLNZVR46UPW/tQrwqIrZ2dbtyPuahB3yJyW0UdvcMEP7z4i/cQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795154006;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8acJLKDDuAq49IKqU6CJftqIRFxZoq6oCQgLOqzp0Bg=;
	b=vlXBCw5qXAsAmYP7N59br6of32YNVRu0tdAmtXyqr6Yo+CLAGYg9lTEdGfe0AGtPaoUj
	 1EMsLYubS411468xlfi24vbFyEdfzI2TFA2QDllp85WXLI30vbAFnV5oUi/lbl3zzgWcd
	 UFUPKL2wRci0P1R3x5XbN46b+I5rN5g89Y1EUZYoIZB/MbSIRRa0WAcAqL2zC3eBklb7Z
	 eHW/jHSJ9dSaI6eJ6KIppzLGFnm48U6VFVmy63Zc9JtLB8p1EQceQgHiQS5GUez8Eg/g6
	 top6ra0ex7lVIEhNmI7fWuzrSXyrIUIN0QNu6ywKkR1t2/4OPJcQ6yNup5NqZM/u/Og==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5852F1F000C4;
	Fri, 20 Nov 2026 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154006;
	bh=8acJLKDDuAq49IKqU6CJftqIRFxZoq6oCQgLOqzp0Bg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=iw0Bqh9wb8tTOidAb/HlGTBIGtJX44CNzW5JojcVGgFeKn7k5Q+6rY0J89QcWrlYV
	 1w0b5p9MRswDBhqP4wGFUTwU5LOTtz0QMPpIHo/ou5k4hOKLnfYGNOpgOVj7PtxGJB
	 QAjo5dZv+yjwJekN6U1Ea0RygS+SfxU6kPNik+7Xh//McOmWnJQZZgCSKwf15Jar7r
	 HyZiD7p/2lNBK0bOmRGZpPN/qEyWrhytwzCIDdnFpbpPkt0f/7UH4ep6QT7naNoJ3Q
	 fXaKfcr2W0bw3FRX/RcmyTt3RO6qHv7XOp2MBXuoJjBTdsDsp90eMYez0eWarWCeOr
	 z6MFRRce4qMKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D93A0496E5;
	Fri, 20 Nov 2026 05:53:25 +0000 (UTC)
From: Rong Chen via B4 Relay <devnull+rong.chen.amlogic.com@kernel.org>
Date: Fri, 20 Nov 2026 13:53:23 +0800
Subject: [PATCH] mmc: meson-gx: Add reset for Response Mode Error Mask
 (RMEM)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-a4_mmc-v1-1-5a84cbcdcace@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAFLg/2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMD3UST+NzcZN2UFJMkyyRjs+QkAwMloOKCotS0zAqwQdGxtbUAKoW
 1klgAAAA=
X-Change-ID: 20261120-a4_mmc-dd4b9b36cb00
To: Ulf Hansson <ulfh@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rong Chen <rong.chen@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795154005; l=1328;
 i=rong.chen@amlogic.com; s=20261116; h=from:subject:message-id;
 bh=ldcBzSWY8qmDPf31J18ds1oMT+JS17QVuWgrGqm9XrQ=;
 b=vUz2tYdPH+vzuS5s+wTBf+hkZRqWYYUyOdbqg+YHDpmn5FeQ9cDaWszezykoMJ1UlbazSXAHf
 h8TBoKOe9beBd9UcK2PbvOvH2MvbmouhGCLdFdEwtpaXhSYmstq5V9C
X-Developer-Key: i=rong.chen@amlogic.com; a=ed25519;
 pk=vFtPE1jHKfpAuk10u/dq9u25ZzVsUM3t2Sew8vz0YWc=
X-Endpoint-Received: by B4 Relay for rong.chen@amlogic.com/20261116 with
 auth_id=1539
X-Original-From: Rong Chen <rong.chen@amlogic.com>
Reply-To: rong.chen@amlogic.com
Content-Transfer-Encoding: 7bit

From: Rong Chen <rong.chen@amlogic.com>

For T7 and older SoC families, the RMEM has no effect. Starting from
the SoC family A4, RMEM acts as an interrupt mask for the device status
field received in R1/R1b responses.

By setting RMEM to zero, the device status is ignored, thereby
preventing controller hangs caused by spurious IRQs under specific
device states.

Signed-off-by: Rong Chen <rong.chen@amlogic.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 49df33bbd8e5..9d9b00b199b6 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -113,6 +113,7 @@
 #define SD_EMMC_CMD_RSP1 0x60
 #define SD_EMMC_CMD_RSP2 0x64
 #define SD_EMMC_CMD_RSP3 0x68
+#define SD_EMMC_CMD_RMEM 0x150
 
 #define SD_EMMC_RXD 0x94
 #define SD_EMMC_TXD 0x94
@@ -1086,6 +1087,9 @@ static void meson_mmc_cfg_init(struct meson_host *host)
 	cfg |= CFG_ERR_ABORT;
 
 	writel(cfg, host->regs + SD_EMMC_CFG);
+
+	/* ignore status in response */
+	writel(0x0, host->regs + SD_EMMC_CMD_RMEM);
 }
 
 static int meson_mmc_card_busy(struct mmc_host *mmc)

---
base-commit: d2616724e01132376c78872b8324f38659af9f28
change-id: 20261120-a4_mmc-dd4b9b36cb00

Best regards,
-- 
Rong Chen <rong.chen@amlogic.com>


