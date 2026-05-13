Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D63947B5
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672421; cv=none; b=Vnylo4Q7eHs3sU9KzjGzZWVafD5OEXz3/ySJHp87ZQgTJZ5J0FCuawjAP/87jfhKGK4Wc6NDZBg4jc8WZGNEo6v0chBZs2GWujBOPnn0a4AAhVmeiMipq/K5qtKnIyhxFKWO/i14UXw9CjDiEbqbDwOMN3483VqlOQ+h0fWRdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672421; c=relaxed/simple;
	bh=Zo1bKwZlEZaICjjvIUgDqifzJHuTu0prbFdXHcd3FNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKG0DtbemFz641O5a24oh8mHdIv5vIpK5SGpILc9Be2YqbtbjU1ATl5k47AkLocfb0SE9zrJ0HSpncNSxH/U8foIUKBlPFADdj+Hzn3k9bRqqp8vAaRrG1XUnr718giCr5RuD+UtpXQMnq4zSgyipkJm3K+uiN9AfdfQTnbFqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=rqAJu54F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="rqAJu54F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so59555115e9.2
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1778672417; x=1779277217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fRyxJU14pJX/5AtyEOHNqc7Zwu4u8GCE+MLyPL2ieU=;
        b=rqAJu54FRTrpmGuLruV+gTNJJ5gAYFTpJWaWxHvKBjOC5UeJ+1srIe3wxOt676ty7Q
         zj4h4eZD9OytcJiO/+RNriMqRkfNSXoCva/2trzDr/a7g7N+rRcSfaYd35W7ltzVS6z8
         Pm+DVFULxI6dsWkSBLxewAiL4QqQYH1T1OnQncakKIS9IDjl8WeHSfNsMyOXWX3gYrKw
         gkm6c4J3DjbtfTV3m4axBeoIdZe0EDcF0Ce/FBZQIvY+NUSQSLJrxofNKrq/c5I7IsmC
         N9YaFZYjuSvom1dfCJlQiO0RCPV4sfROgNFQjXGWMWw7BPle1BPc1PrdbOSp6qB3lhAL
         2S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672417; x=1779277217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fRyxJU14pJX/5AtyEOHNqc7Zwu4u8GCE+MLyPL2ieU=;
        b=ANyipRk3d+S0nJDkaFr2DDFa0yjSNKp+JyhDhWkE7LCH7VEyIWU6knhJFk7eQaTAsj
         qtBCv8bCoKaJqgUJxZC6lmAOHaFEFtaTaeM7tKC2YKFYm0Tiiph9dA35p/QH6elE+OX1
         Fca+ipAhWjASW4OSIy303GwmLlOkLYD8Oe07sS4OW14u3ZqGiVGI53Z8rDK3qt+mt5On
         DSRdQ/3mZMQrwAQW61YVO5up4ZOU1U6VXuqxZZ/BUsc3nAci5MBgASYuDu/YYLvMwEJB
         p8KNQdP2o+3xQl46qeWWZQQxcQ3qX8TRxeVU9yLlRkMzhMXDY7wsbaKiPl5hyFYQabyX
         GxSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p9fS5241A2t2zcjBFzZZXaO4EAvNg4QFkqDxHVPNhqaJpYMoJCXbqVie74CcejYvr7cYDkX7ZOKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+CU/0hufUJ2hACaPqYcg/ALMHfODYolW+bUBnOKfWeDEOtMq
	/tPJT86wHoPsPXLUXHpaxhR4my2zjnhWKZSWTVA6bGC83jraVOJXgnK01X5IGcD0Tw==
X-Gm-Gg: Acq92OHdhT+eb9OfhYEkgj30va7UU9hEJETgt3oeL0YAKmj1vPok4LiLWQW2FJ4M0Bk
	qZjV5jIF7jxBZj+8iSUUTIdKdKx/PpFrtCxBlSLbbvEJoJ9ZSWplHecNJl6bx/raoeHSborNcXV
	XYlJz3M78zP7tYrGk15+3/9kmPmkPPTIxQCyYoGldalqDvIuVaEO6qcRgKIJmMONfRcIG5hOEDG
	HdUY51ECTRBvoNFRjive1px+npJ2Cz8Sc9I1qbiz/yicr8QAHAtXeKtygwsfsFT/XnHgDVmaNXD
	n5pig9J4Pjw24EM9uBZQMSRwOZTvgdCGC8912PhL8xhmSFLzVZBeBqVoebUZIlFHwyjKUXCan2/
	WFpdZDD3vS8AEpNUTZuqznEuXvvhIbRqTDex7ogXIXSf1pauqHojV6QAV164Y1iHG4HjpDM6qcm
	UfvT7G53TeIvSdRI94SzfBBt8NvaAb8plC9CaOZYrVOK1hCLhieNBRotA85FA7UYGlQZJU
X-Received: by 2002:a05:600c:1547:b0:48e:8499:4bd7 with SMTP id 5b1f17b1804b1-48fce9eb099mr33828485e9.17.1778672416784;
        Wed, 13 May 2026 04:40:16 -0700 (PDT)
Received: from horizon.localdomain ([212.105.128.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fcdf64013sm53508475e9.2.2026.05.13.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:40:16 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Sean Rhodes <sean@starlabs.systems>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-mmc@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	rogerable@realtek.com,
	matthew.schwartz@linux.dev
Subject: [RFC PATCH 0/2] mmc: rtsx_usb_sdmmc: qualify card-detect on tray readers
Date: Wed, 13 May 2026 12:40:11 +0100
Message-ID: <cover.1778672403.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Uffe, USB/cardreader folks,

Uffe suggested sending this as an RFC and adding the USB/cardreader side,
because this may need input on where the media qualification should live.

I previously sent an RFC for the USB/cardreader runtime-PM side of this
problem. That did not get USB/cardreader-side guidance on the detect
layering question; the only substantive feedback was that the MMC child
should already own runtime PM for a real inserted card. I have since
retested that, and it is correct: with real media inserted,
rtsx_usb_sdmmc holds runtime_usage=1 and the USB parent remains active
through runtime_active_kids=1.

The remaining failure is narrower: empty tray only. Raw SD_CD remains
asserted, the MMC core repeatedly probes non-existent media, and the
runtime-PM hierarchy does not settle.

This is an RFC for the Realtek RTS5129 tray-reader false-detect issue.

Short version: on these machines, raw SD_CD is not a reliable "card is
present" signal. It is asserted when the tray is inserted, even if the tray
contains no SD card.

That means the current driver reports card-present to the MMC core for an
empty tray. The MMC core then does what it should do: it tries to initialize
a card. The commands time out, no mmcblk device is created, but because
SD_CD remains asserted the detect path is entered again. In practice this
keeps rtsx_usb_sdmmc runtime-active and prevents the USB parent from
autosuspending.

I retested this on an RTS5129 reader:

  - tray removed: no mmcblk device, rtsx_usb_sdmmc suspends, USB parent
    suspends
  - empty tray inserted: no mmcblk device, repeated CMD0/CMD8/CMD55/CMD1
    probe loop, rtsx_usb_sdmmc remains active, USB parent remains active
  - tray + SD card: mmcblk0 appears and reads correctly; the MMC child
    holds runtime PM as expected

The old Realtek rts5139 staging driver did not treat raw tray/CD state as
sufficient. It qualified insertion by checking whether media actually
responded before reporting a card present. That approach works on this
hardware, and avoids papering over the issue in runtime PM.

I know the previous version put the validation directly in ->get_cd(), and
the objection was that MMC command probing does not belong there. I'm not
trying to ignore that feedback. The question for this RFC is the layering:

  - if the only exposed hardware bit is "tray inserted", not "card present",
    where should the Realtek-specific media qualification live?
  - is an rts5139-style qualification acceptable in rtsx_usb_sdmmc if it is
    kept out of the generic MMC core?
  - or should the USB/cardreader parent expose a qualified media-present
    state to the SD/MMC child?

This is intentionally copied to linux-usb and the char/misc/cardreader
maintainers, not just linux-mmc, because one possible answer is that the
USB/cardreader parent should expose a qualified media-present state rather
than having rtsx_usb_sdmmc compensate for raw SD_CD.

Patch 2 keeps the validation path in a known initial electrical state by
starting SD power-up at 3.3V, matching the old Realtek rts5139 driver. It is
included because the validation sequence must not inherit a previous 1.8V
state.

I have deliberately left the SDR/UHS rate patches out of this RFC. They are
separate capability work and just make this harder to review. This series is
only about making tray card-detect correct and stopping the empty-tray detect
loop.

Thanks,
Sean

Sean Rhodes (2):
  mmc: rtsx_usb_sdmmc: avoid false card-detect on tray readers
  mmc: rtsx_usb_sdmmc: start card power-up at 3.3V

 drivers/mmc/host/rtsx_usb_sdmmc.c | 161 ++++++++++++++++++++++++++++--
 1 file changed, 153 insertions(+), 8 deletions(-)

