Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4C375F7D
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595676; cv=none; b=OrLjqEqt03Qp6MxsMZY9fJpyuim85+sbfO1j5VOLJKqMxNRssAT5NhPEcrWMTKL9nSXrMPuEYwT3HbLwq/BL1RI6D5Clw9JPq78m0AgBxw32/QSBzgaxQnOR1lM8KZvrqiXhqnj00eSRhrXjkcY1WGxQKaek4pzyXLr4NCOflvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595676; c=relaxed/simple;
	bh=t4IEjrlPC/zChObroSpygBEwzjH0OsQxo5JZHzvQ1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uojZ5ggG7hZ7zued4xIP5gQk80OziBtNxcM7At5uYqYC+1Ccwiej2dy6C/OwLpjBidPphn9BB6T1FS/b8hpVFx/hVoBFfrlLneOvs1w92M6ncN7W2cIRUmEoTiD7Uhkwg4sY3DxPiUOqkSn1YNu5SRgRh02IZMfq5tZvoWCJqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+m9ZiIW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+m9ZiIW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35274375e9.0
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595673; x=1774200473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=d+m9ZiIWprHELt1wMn6ikjKhjod+dOB77GCh7OzPVM0ARTDFsFvqVsb09lbEbU3Goi
         nwV+5DW/URuKiLqMIh+RKdRr3PA7Xw3Y2n2hXuKtLVwhQGfXfUhZOkmxJiEdHqorzGOs
         q2B2tQPvxY5QvYf1PvtHvuHNz66vsCVyw71wDv87vOWsuLHuopLCNGPtmc+4AihKpGKD
         iNC6or1IOq0zjABdxr76npW5Q+08I37BYj9qyVBpmAmKguKulBGaXDIStqrwNqedaxs7
         mVc5qov417XNiyaDj3e+kM2Gt3hVADduNgkjiy3xBvxdNiJgHlRiTOD2vtzF1I/KEUYV
         kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595673; x=1774200473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=mbgLPTpTIluJ94KKNx0B0/Yotbx81GqXEGfWb0uRJh+jkkI9HK/btFptnwjSHhTidE
         eEoQzG6bjbGqedvwunxMOYPcWHHr42elLpcGXinXpKB3uS6eg9/t9jOuldmyrE+udCsW
         Stit5xd6F1SHaXyK02Atv+TJlb682ZmFuxCuy3kHAyFUJICi2vnlke1ZwJCICVlukW86
         zlhzSgSKLsJ7h6iFdTMaT/lll83r0E+uEL5RNngtBOU2bs5X/bh/IUpxquRyA3rPBtkw
         FhrvARVBSDkk8YIL+MAGv/zDDKbbwngHH9g4FJ6R+rA8OUn/64DDbsJUY7myM2GPobe7
         DDfg==
X-Forwarded-Encrypted: i=1; AJvYcCVa+CrrqNXmi6+9jSavVHULL0bkTTGTuJBQHA7dDbAGtpBzD+4UUo+d/vklJUfKWMdQJqpalCV6F9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAWbTqIe/d7a++XCfHsQzRSOW0n1UVx9IbhQcIXZaYxWVtXbe
	H6jRG8JIgt8M8drENQI2jd3flL7wfjyxzJy81o1LiSKxp/i0R3d1x+m6
X-Gm-Gg: ATEYQzy0Pw9GjZwFWs88it+87lLmTcuEjz0Rjg2DukIXiG9TeU7xf4OHFY0GWtDMjwO
	7kxW+2Ggo7H/Ft6vFOn8hbJPVeFLkewjNxco6zGFIPh7H7/znHC1+slu0De9WP3FpKxnY91tx6d
	zYh1+oboxCxHFqL3/PuQrqdNehMakJKyC0DEuL3nCovZhMSJhFFHlwl0FLzdGdE6WdE+WPE6Vwf
	2UDkc7cN/4eEHSkEIq9lfeJg6d1JRMBjS1FLz1VFlpuGc9JzBkK9FfEWllw/a4dXVJiTV08EQAs
	FafYm4Td9KmbZ2xeITUcveMGV9+a26EwTk0uPAKimAM4bpt9MGpNUQdoHHwCiRTcKTlCJcFUXty
	kTSiCTUsG7j3vEa150cMdwKE2JlUqqOEtZ+70GmvtDcJTDCwoE26gU1TuQETcCtRqBrT/xMUTjr
	fBX8tMTI84Vn2Rx/EsV3cddss1Res5j2IAWoBi5MrmaQAhdw==
X-Received: by 2002:a05:600c:4594:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-48555acaddcmr154699455e9.8.1773595672220;
        Sun, 15 Mar 2026 10:27:52 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:51 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
Date: Sun, 15 Mar 2026 18:26:37 +0100
Message-ID: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series provides functional optimizations and alignments for 
multiple kernel components, specifically targeting MMC quirks, 
Rust block driver abstractions, and iwlwifi interrupt affinity.

These changes were previously submitted as a single monolithic patch 
but have now been split into logical, atomic commits as requested. 
The code style has been verified against checkpatch.pl.

Summary of changes:
1. MMC: Consolidate imx25/35 quirk data and add Kingston CID support.
2. Rust: Update rnull driver to use Pin<KBox<QueueData>> for alignment
   with kernel 7.0 zero-copy initialization.
3. iwlwifi: Optimize MSI-X interrupt affinity mapping by skipping 
   the boot core (CPU0) for high-rate RSS queues.

v1 -> v2:
- Split monolithic patch into logical commits.
- Updated author and email to Adrián García Casado <adriangarciacasado42@gmail.com>.
- Removed accidental addition of nested kernel repository.
- Fixed Rust code style (line wrapping).
- Fixed iwlwifi white space issue.
- Wrapped commit descriptions to 75 characters.

Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Adrián García Casado (3):
  wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
  rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
  mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID

 drivers/block/rnull/rnull.rs                         | 13 +++++++++----
 drivers/mmc/core/quirks.h                            |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                   | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.47.3
