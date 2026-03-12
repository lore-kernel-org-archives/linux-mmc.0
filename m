Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0427A123
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317768; cv=none; b=qaXhSSAs4/zmM9Yg3uBmY4X3ONTlVo2S3KpikNQ/u0GW1T2iHrs7XSX5xnX0cuHpBYzCLghq+3magNPRzUOq0hpFPzHq7zqC9/Qc6DGt0QySEugoHGgjijgjudCWq4mCRRKlc1ejff7He+juHZEYBGVMJtFfX5zcEMsqwIhIJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317768; c=relaxed/simple;
	bh=LBfQ3rOqSm5WGZv43CLh3v/nMRxEwVLYWWtHD73TqMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOfSe9QHkvhBG7IPXhvkXzIotVPSRbsYtGt6+2M13l1MRD1pjjbNBXmKKGp386ycYr7aSuDXD/1zzHurOkbINnQ7+0ma7cKCC8brRNGG6GBIaX90K+iUrrKu0KSx/g2tdR6AGgfJI85hr0AYun4N5PS552vh1aQWE6QVxEzPnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=vslEtMlh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="vslEtMlh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so8773665e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317762; x=1773922562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN6i/2lcvLmUr7kNhiSyLJxtx49LqD6S5w5FXgrMNOU=;
        b=vslEtMlhXHTZLPJTN98dGjGQkw1XE76DmudQk6XiMPVDmtMAIli/Lg5jMxb9TiTvY1
         7mokZqkqvZdV/o6TkFIqC3PAw90GxmjHq0YX/VNuv4f46cnzbK86SVzQ/0IDzG83tOC+
         DfzTCwqakDwzIdHj7J1isYQ8L1X3hJbEWQfmkNU7vkoHKIKzBelbxYrJjlQFMGvgRXdo
         opH8htowySHTLeRqLgv2GPy2XITfkro5jRoHkxXMb3uUNRbOMc5b2lCZW6rty784Ds/c
         vHdn1odM9CSLJDfkXmaGGgn+HEuTvIAK1jqdxb2wJry6NSWjwYCTA/p9wmZhmH3VR8m1
         41vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317762; x=1773922562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jN6i/2lcvLmUr7kNhiSyLJxtx49LqD6S5w5FXgrMNOU=;
        b=RDVlWm3lJGsxWwEy4/pv/aF2dqyemt6n/vlrItsvyFlSIHrNYQmAzaxgnmc6TZROg1
         qPzWB+mwyPFfwZT0cRhEUZYPDZ4HhwDaVYTpg/mM+lV+qiB5aa3ZrCgLl8ztSDowluD8
         9+W+jcO9b9i2lYQ22dFaVG1txhDnOPrXSEiJAJnQZ+DqDHQsyXNIsJSQ+AbGnP/v2KMx
         64MJmxXN2RGcaIYtZYCrChR16L9qR6WBcp6ndI5CoJIcnPNsFFPMKUl/g4t1OXhpk+je
         zJsNEY1xF2D1/UezeAjAm5TPNSass0c7YVojxH7IyqaCYUfSJU0zI1ZSXMEzpOHEdAs/
         RfuQ==
X-Gm-Message-State: AOJu0YwSwvy02cPL+D6OEXkHoFOw8y0RG6KttdyqJHdtyTfhYTwzChMC
	z/hzVrmQoMB6JbjhgloxHqvHnjlxxkOVmCJPeASfQjo1gcq99eLs9iXtWpZslkjaszsUtXKvdHz
	lYvyPEg==
X-Gm-Gg: ATEYQzzPfZhPnU8J1XiPdiG9x+LGf2+pSNhUH6JvUQqn3nLDOZ+ppILoJ0wZJq2LG90
	4srgOS5WSQpeBjgDdvlek3ow4sH0WqhpmFV7oYh2v0edfWgrMSwGxHdpQx1SljAOjjJnMTajOev
	Gj3jV9dlRDXmWIO0qpSYiKYHlsLdBkHAE7ia/QU/U/UXXXMCTWzh77C6wjl/9xmZCzHFzbyhgAD
	EDDyvRF0s90kZQcAa+Jy6nuEN3bS9NB7V9QODumTeSfqjRDYk6dc3rvQwmVfGBG21p5WoaikvVP
	9qPvOE8jXW0BGP1EaD97aD0ELBMcuLrJrBjdSiGBXSSilHbTayEUDxgNDTVWDrcY+yj8tg3+JTD
	2YS0wn9KbyKB9Lt00jQzvaLCBJ87GZCAzRbRFfu+Qvm9ItwP9RzJSLeuDQwYwhewDdbSNpFqi3+
	Fw4y65N2T57gjVAJ6gbj0pb1xSS5LYPf0j7Mtqd3llhb/QED9ILTO9dLW2ZxSYzpBvmp0WZQ==
X-Received: by 2002:a05:600c:45cb:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-4854b109d3fmr97388325e9.22.1773317762052;
        Thu, 12 Mar 2026 05:16:02 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:01 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 0/6] rtsx_usb_sdmmc: tray CD fix + UHS + runtime PM
Date: Thu, 12 Mar 2026 12:15:53 +0000
Message-ID: <20260312121559.19197-1-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305194052.5120-1-sean@starlabs.systems>
References: <20260305194052.5120-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some Realtek USB SD readers with a tray can assert SD_CD when only the
tray is inserted. This can lead to false card-detect, unnecessary card
initialization, and in the worst case suspend/shutdown failures when the
MMC core waits for a non-existent card.

This series hardens card detection by debouncing SD_CD and validating a
new insertion by probing for card responses before reporting it present.
It then brings rtsx_usb_sdmmc closer to the previously shipped Realtek
behaviour (excluding xD/CPRM) for power-up and UHS signalling, and fixes
runtime PM corner cases around USB transfers.

The insertion validation approach is intentionally conservative and is
aligned with the older Realtek rts5139 staging driver (drivers/staging/
rts5139), which was removed in:
  00d8521dcd236d1b8f664f54a0309e96bfdcb4f9
  ("staging: remove rts5139 driver code", 2014-05-23)

This is a resend as v2; the original standalone submission of patch 1
was sent on 2026-02-19 with Message-ID:
  <1ca7b488a11e03b3f107f1829a40cf2c92c7d5fd.1771533586.git.sean@starlabs.systems>

No changes since v2. Resending for visibility.

Testing (v6.18-rc4 based):
- Readers: Realtek RTS5129, Realtek RTS5170, Realtek
  RTS51379
- Tests (all readers): cold-boot detection (card present at power-on),
  hotplug insert/remove, and suspend pm_test=devices
- Tray behaviour (tray readers): tray inserted/no card does not create a
  phantom mmc device; insert/remove transitions are reported correctly
- Card modes/speeds: UHS-I SDXC cards negotiate UHS SDR104 (1.8V,
  208MHz) where supported by the reader/card; non-UHS cards fall back to
  SD High Speed (50MHz)

Thanks,
Sean Rhodes

Sean Rhodes (6):
  mmc: rtsx_usb_sdmmc: avoid false card-detect on tray readers
  mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
  mmc: rtsx_usb_sdmmc: advertise UHS SDR104 and DDR50
  mmc: rtsx_usb_sdmmc: program SD30 mode for UHS SDR12/SDR25
  rtsx_usb: hold runtime PM during transfers
  rtsx_usb: avoid USB I/O in runtime autosuspend

 drivers/misc/cardreader/rtsx_usb.c |  49 +++++++--
 drivers/mmc/host/rtsx_usb_sdmmc.c  | 167 +++++++++++++++++++++++++++--
 include/linux/rtsx_usb.h           |   3 +
 3 files changed, 199 insertions(+), 20 deletions(-)

-- 
2.51.0
