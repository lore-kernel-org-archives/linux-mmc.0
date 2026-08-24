Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF217A586
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603975; cv=none; b=okbkKeSVCK42pTuW6VK+CmXYz29j3QicUFW5akSZ3Wg3awRxlYpg+Filk3MrbvQkGRuDIdt9z7VGky26/4sztc3NtVbLzbdBDs9JE6QxMqGatOMwBOMIzq/QPk2ZgvSpj43+OcGpZ/5igFNVG1SPZJRjLUDXvF8hFvcMieJP9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603975; c=relaxed/simple;
	bh=2cHyoTVL38zNjoAWUYdF0/iIR9zdRPhNwSF9aqQM8UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXCKZXb2aB+AvKCKXKzi/XkZOnyI0FNlI4ZFazmQVc7rRN5OnefrDW1lxbzrslKEevzgpwqHlRQ06VRkQll++5Fs0UbFUNLEMumkfbEFeCcoSnvN40jIJPfHwxQxYlh5xtNyP8XVxBjOBets0XTkKfMagf7LEytGHurB6iqVolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=gs/Jgp6P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="gs/Jgp6P"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954dff6536so28743285e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787603971; x=1788208771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eftbG+RbbUU0Nqfoz3kLIkQNJ4noM/Iq8sqwWhnuWt8=;
        b=gs/Jgp6PhOg39zVqOgk5Ph1dtVHN1ngpMVHy/O4Z4kjKjTKqgU0A+0hxvFDDE5VqYB
         WzPYNeXPjnmRTrwkntFfYqP4LL7/NOoxh/p/X6n+N2pqC8+Jl3jsdIWSqg4GelGot/S4
         Z+pwE7It6wRwj2GrHSS+q2+cVVzyqXwGEeAt52ya+8XDn1okkYycg7//fR4hKhlmuVrd
         SZNF2WWlp9Aye3l0aH2mOqWWtsAeLa3epV4V/6628frZqgxXKAxPkl3iJW71Alp5cMB3
         4UVIJds+eBraEUqcDvLdceldQct1Ph4oae6wIrEwPGeu4M/TbLc3yfEvmBKm1tlXGRqJ
         EhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787603971; x=1788208771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eftbG+RbbUU0Nqfoz3kLIkQNJ4noM/Iq8sqwWhnuWt8=;
        b=kOvnJrH06ouO7j2idCrZIiAp+79tNOJJnM293TSk9Pd7rY0aJeP2IenJm9J3a4TDOm
         k7jOPlK4DTWGKFGABt/qTNlxCNp3yVKok1Ar5RckqN2wyxKOhIYXWSURHkxcLFVqY2LG
         o7tRG0LgL4IXHHhe0NRyVwJuaH1i9JQJaURVgd/5ut5m6Wx//HKIMVyWZ84oaW+MfVkh
         sZiqsVS4rg7zugz4MRpNtNNVTwa8Nsz9jltjRrO0XCaJ1+N2c/zQ6eP5/zYbXaOkm6zl
         bUjlOg+z3dfqSaEiXHhHgTQ1RSLNuGXmEKk0qvueT2Jv5sabuOCEmi9eGWJGvt79tKam
         3zJQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro461p3igq2RTIZhsLUkL8qeXgXGHc6tVokPKmDoixjxoEU/inPOW6AgDrJsxd0vQdYHdUKevVs0Rg=@vger.kernel.org
X-Gm-Message-State: AFuF++kGqkAVGIYPnOXtPhGUkqMTNRTWBhtdVcRojN6J6BU+8KGbLbbd
	OJXDd360Xe2OlaajqqK7GIqbkPsIBh6eEcLu0i/OsKJTA3BUKgrF9Qw97hAV4+WluQ==
X-Gm-Gg: AR+sD13P19iTWsUri50OGOXBc6vmmCdKZecYADOABRl4j/tymA5/cfNl+radfeJWocN
	dfQKC/Nrc3bbVzFMlW8lvxTUY0YTRASqu132VLt7lG3v0nc3qkyGTpchtfXBVKC/xc16O+eFGp8
	Sb1ZNRRfpbyjvUb8GvmC4vKexcTiQDvxclw2KHWkJmYDk5n4iEaqlmIfWU4lo/eTHuHlmnv9Q+p
	aIg8zht3aoKKUIvdhN51/Oem8BrU2kM7ROMhrCwCUGU5vnnJE4NK4e8QaTrBTqirIx7rQgiXc+u
	KOg/pmaVxRTws5Ct2cBa6PJM/UwbeaCVDuGhc0K1RfNO1NdjfGreCEWVmd/uSJ4Jss5NV++jgh3
	4IOBHfHndaFlEXujLkZPp+ftxwYs5UniGo4lV2YZGPHTj8a8gfSay8QCFI8c6DKdQmwmRdie9te
	RJ+ohEyc2vJ7i7+oMLTCxh1G4mPXURBpuBP5JIYcM8uNg9h/AXMh1PYVJP5Q6qk+5FS/d3wJCWV
	sPfSnvNPG3tDw==
X-Received: by 2002:a05:600c:8506:b0:499:48bb:417e with SMTP id 5b1f17b1804b1-499d64f9113mr23805205e9.2.1787603971244;
        Mon, 24 Aug 2026 13:39:31 -0700 (PDT)
Received: from horizon ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d5d64ffdsm5914435e9.2.2026.08.24.13.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:39:30 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Sean Rhodes <sean@starlabs.systems>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
Date: Mon, 24 Aug 2026 21:39:29 +0100
Message-ID: <50fc5e8a29e3a5e9a64c64c5f775d758dce39b71.1787603965.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A UHS session can leave the SD pads and SD18 regulator configured for
1.8V. The power-off path disables card power and suspends the regulator,
but does not restore their voltage selection.

On the next power-up, this stale state remains until after the MMC core
requests its initial signal voltage. Restore the SD pads and SD18 regulator
to 3.3V before enabling card power, as the old rts5139 driver did.

Tested: StarLite ADL with an RTS5129 tray reader; repeated 1.8V UHS
        sessions, power cycles, and tray removal/reinsertion.
Tested: StarFighter MTL with an RTS5129 trayless reader; repeated 1.8V
        UHS sessions, power cycles, and card removal/reinsertion.
Tested: Both systems re-enumerated the card after every cycle.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index bf37fab233cf..d9b33aa79165 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -980,6 +980,11 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
 	}
 	dev_dbg(sdmmc_dev(host), "%s\n", __func__);
 	rtsx_usb_init_cmd(ucr);
+	/* Start SD init at 3.3V, like the old rts5139 driver. */
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PAD_CTL,
+			 SD_IO_USING_1V8, SD_IO_USING_3V3);
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, LDO_POWER_CFG,
+			 TUNE_SD18_MASK, TUNE_SD18_3V3);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SHARE_MODE,
 			CARD_SHARE_MASK, CARD_SHARE_SD);
