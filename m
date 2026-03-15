Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E1377575
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595518; cv=none; b=E0FJ0njQVvppoUaBeQoGY3xvPx65DXtVIWWA68p2Za+mu5n/epW+wreme2YJ85a0lCqO70wmMtmQp4nzqtAm6nvgbOk6gYM0/b+quqaZQ7Ui33Drs6OsfVQ10CtG7QbunjWZxsdUzigqpG1AHRyyfPr+eGTHgPQbF1PRV/55Bmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595518; c=relaxed/simple;
	bh=t4IEjrlPC/zChObroSpygBEwzjH0OsQxo5JZHzvQ1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VV26TY3xIMoDnlBNKJvaNku8LvJkAXJd5lNveyrPr/qoWxXfay2RgzOGozBzc5IpjNe9p01Bq07fV7QXZt/6umYLmBBjFRdKuOSqQK13ejoIrmpYqIjOs5PmcqHAsUUhus6G4G0fcK3sm0kFqfpfe7NYW+DhU/IWbe0Qk82iX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xczyivlv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xczyivlv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852ff06541so42331295e9.2
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595513; x=1774200313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=Xczyivlvjttae8xk70FtJIdWbeRu0L11XiILQEiTARK8021W0z6zIMxf2ees+GVNxq
         XHsFdtlTlv6IQu1cXFF481BOvrtOzuUyMYcsZiZHFSPSVJmliCv0pUzEc31MocZzstmj
         ShKbByGawM+ZgERsrXi1/MdVmC9lPnsImGQWbcggpJ3GKWOVQffZu3nlRBq9CuRUWDU2
         nil2rZGkYHflBVwYQ1jtiJGlGPjjoiodLbB7FN2v14R8YmRIE8C0WyNH39Pxmao0s+nI
         BChPV7+qJFThzY/WtziZ/CjCwSRdzFNgMPgyZSIViSlrYnHdgz0+F+u0mQzOPyrgQfU/
         7skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595513; x=1774200313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwUo5hAkI8FkU3V+3kGLnu098RQoJ8LL+Qih0GJFD4o=;
        b=a5ky3gM6/vQZbLgvDbTv4XRTGEz2MjiswrxukjpWcxapKiIXSF0MrgRdvMwyqK0SnD
         oZd/6RMyodQl4oux0obFvSfj6wAMXFbwqVznqXgGk1MCXcNjuGfWNULIcxgyE95Gtcpc
         UHsY4PhWodUowxThrGwcAi7jjCKh3A6VST3om5tUHSJzDgJfHS01+ihrFxbQ+vq5A6Ky
         +nUXjRL83s9Dzib0w4rLXnuSkDIVxSIEAiyV7R5VumYjvVx1RLKtHVCBS77WpaOj2Qae
         RdpFFvzP7o2LsOmwkEzh/bg10iAXGvAaSaWaJ/0IW9zwIxYEdCvZvJva+o7frDJnsOi4
         ZVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb595ogu6ed8apNa7nU3s2hvwOXGuunAvu46WWcLPPEKd04A+uHOSuw4Ux5e0tdbtsHktvM6UW6cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxol6NTCPs6/uKbN9X39hZiNLWKyA1eE0M07oUmgokmUAGVAczJ
	t7hyLLZ5tSvXlN9bYAZdOTKhUFzYkxraVCDhNhoVJBLdnZAvUItRZeSq
X-Gm-Gg: ATEYQzxsaA50ru2SphrcBSP+2PyBhm5lwK4qb3tSPFkjYUH1FuXDR3krLgl6n87XiwC
	8D6p2Oy/xpdyFuV2L/GJ4u3OuixeidNTv/SwN2XNP02biDTo1qEehg7/ygFBXeG+yUw5Xo6lWv/
	A4r62iSzGStri4msfQ9JEZ5jegbglQ7uGSoUBo6OhuoeycNC4CjXgta9nuw59ORHUQdIdngQ68I
	tYLmNuHG43b/fS7+ab726+fNxe01A4i+adr/PbMAe7oCLfKjmRKAdF78k+MEN9KpNcJeJUGnJRP
	4O+jZAwcajtF8NG+rzw28LgwBZEYC6CRbyvhhe7MfNQdlZrirBNssm4DJkPHSYuGHWF8GHrdCnq
	O9E4ZTTzCl8IlDE5zlbhCJEMav9F0uJP8HcXZmfCEld8Av/Zn0n4YxhZX85ueEZI6pwKSXuPx3J
	O6HfIYwoLNNQ4AhGoDCn7OoxS1oHNqiZCUhKk=
X-Received: by 2002:a05:600c:45d5:b0:485:40a6:442e with SMTP id 5b1f17b1804b1-4855649c956mr173044125e9.0.1773595513423;
        Sun, 15 Mar 2026 10:25:13 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:11 -0700 (PDT)
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
Date: Sun, 15 Mar 2026 18:25:04 +0100
Message-ID: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
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
