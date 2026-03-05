Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51D3043DD
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739659; cv=none; b=TOBe/HakJFExEh/KZBQ9PqYh68MW4QINZ8b1m5Q7r6I3N8BVd/pI0+gnOsUn3d647ZSYAudbK6gJDp+e0DrvWTvuTJIIqgrtxY21cx6H0iMCLxCurSdPWOCXPnWt41jdu3BBF5EsSOg5efW0UpczoyNQHKDbINjANRKCyCI1Bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739659; c=relaxed/simple;
	bh=m20zyPh9j0kootMidayNQ1oOQzrk/KoLdQEO5NKeekM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6CBdkJQnXryYs8j8O2AcO2K01ckkrpRWy75Tml8XbGCNh+YP1tfi4B+sQcBgl8m1NFOOZO4EEA1Ot/aRbThSiOFoHhD6KOOgHKraIDAUkXynOeTwwZGAeMvrdxHzDnXs3UcUYUsnKGknLKQC3rKrHXt8gMIQtKGwM9qihPY7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=IR7Wigny; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="IR7Wigny"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4837584120eso64639435e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1772739654; x=1773344454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0APM3Tj7oBoGfg9KCKIHOkr3C7tCvxi2WdbZ2UmZlhY=;
        b=IR7WignyJtmqxLg/vKwZUQaHiMjD2JUXTTJVAZ2FnXKn+A4yV082UZaHS+70oSXL/d
         ehhOA08aEf2OfIDeMXJsSrIvJeurTCxYXdNn8HBjgG/UvXbABJCdZYhwHV3LpFWVfoNU
         F7Kf/Ncqp85MW53EVlsH1tMWjWkpbHLUhGFlB6Y2ccI0umZQUpMt7lmFxIVeRa+PsaYQ
         rKBGVbuqni/736HGfq++fsPfo4dOyWikkHl+5VRxUHdSXepeI1lGpv/Y4s9n47O/iz5T
         04Rb0a4xwL57Hx4VpKqA3IJhsJPTR+cDFoznarjJDWsppUyX2nlaDvprnWGKcJ37oxoj
         BmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739654; x=1773344454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0APM3Tj7oBoGfg9KCKIHOkr3C7tCvxi2WdbZ2UmZlhY=;
        b=ZA6NQmLOHIg/A76W78XFijXX50/8pZT9kgSULTtGIAS6YF5G+ETzAoePrkFRaUS/0t
         MIo5zzT6qiSTaSx6/wvsg17uc8vOgyGFIaXuDTSobTh4l1B35bo4bf7RQ1UdARkZxEHQ
         tG0VFZjaMclxPlS+EdaWHXEimc4yYjgTKUXJ7onkKApgxm4PSRilNs3lW4ZyMcS+iECe
         JhjoIkqSBQqjgWF+76H5CPhOUp9NhlJn6nl5Rcv4ItmqDJXMa7XnH2q8iSRPHsCWr0us
         RxnnxVGn1ChfDmkBCxTNIYiht6qjWFHV7be44TLqBxjkOl6vJM+YHK1UbCqa1J0QQwzn
         qlIQ==
X-Gm-Message-State: AOJu0Yz+Apa/0u8aL1GDqJaQALAcmiIcskYVh84DL7xWNNWhwYIwz6We
	RoPP+90YJDIX3u3S+0CuTkwyLRdCKDcOG5N0zUtGMBl2ALx0dm+25asb9BIGm4Row2Hy0cROIWC
	0NfaCeg==
X-Gm-Gg: ATEYQzy5SCo4+AoWQ6B4+hDe0o8E3OwDkCLD1sUAqPYSaxO2I4XMgySWPcS0DiocN/i
	ddvONJUyJXwLjYq6DmTYuNn7NenQRgLlO1xe3KdCx+224N2s/icsPciFBxrcxyPY08iU8hWkqE1
	lzwT0e5xewFhQcnXbyTx7i4ODDaWVtrO3rrlD3VHrhToLLGJlHgI7du48kdFtwaRKZSjPnaxQB1
	qhIVBlb+vhI8tXzvnY0I76kVxE+wjVnmt7XPtWgkRQrwDtQnyx57t3dFzGk52jZnT1kt2mqCFni
	gs74PtfsH8ekoYOXdtdzsQM+tVr6RbOkI5i0u6KLZVIIYBXgYulFqY3DX1SDd/eUTnUKXcDOVnY
	CgLbz7P484541qVQ3GyZbpCPniOWuQlEaRmHH4SuRrEUOXJovXoQ6G1TsXpFvs6drlpG0HjIqp8
	f0WPWqXFvFabg82TQ+ei17ktjd4abJYJgY5TUGujLIoqt6kaPieSv6FYPtqbO21w==
X-Received: by 2002:a05:600c:828a:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-4851986f362mr133686845e9.19.1772739653915;
        Thu, 05 Mar 2026 11:40:53 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm3265e9.6.2026.03.05.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:40:53 -0800 (PST)
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
Subject: [PATCH v2 0/6] rtsx_usb_sdmmc: tray CD fix + UHS + runtime PM
Date: Thu,  5 Mar 2026 19:40:46 +0000
Message-ID: <20260305194052.5120-1-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <1ca7b488a11e03b3f107f1829a40cf2c92c7d5fd.1771533586.git.sean@starlabs.systems>
References: <1ca7b488a11e03b3f107f1829a40cf2c92c7d5fd.1771533586.git.sean@starlabs.systems>
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
