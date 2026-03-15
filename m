Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AB74BE1
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595020; cv=none; b=rjdmx960BrVow0/vRz+0W9WvBxFoPMRwL/sG1N2g++9r93nx1MwccHwotnAnp+8Cz+bMxsOsHfRGTPb9bhAkEWg2/lyDB3BZJlcOInIN1oXyL5hxGd9CL9+misPyRKgZ2KYDThi5/1prvsyNdnDdY02U40g8fu3ab8QIuECp0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595020; c=relaxed/simple;
	bh=Da/cK6OQrHU3pcAlgLxrLXJu8wvJOC9tkJMNybOwlek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIJLPkGWtxXFE6l0UFvCouq7L48LDDMZ4pxXLNQBl504uQYjd6G7X+p0W4WV1BEhhPZiJTPnJOTt0dQdudJ/WLcMKlq3/dqSsihVd0VvSKkksb3g0C8Aaf/pCCTeuK7GTytBZN9eH3PLRhCr2XShI189g9qjA4jawQFDXcpzez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbt4Z7J/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbt4Z7J/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35228675e9.0
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595017; x=1774199817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVyBXQRSzr9/lSeks120us8HXOhp+dnwI23FH9hEtAQ=;
        b=Hbt4Z7J/pTX/JBJKLFLkJhcHX8Te9jRBHsvSWNnUlQiuRHV3hP7fQZrm7OkUBSD1Gb
         J3QJhFaH4HXXRowOLMg71+jZcION16MfaioBo6ogIdcHvkjDQ3UsgTsi2eGVxWEWqQmS
         HLZxSm6wwatviSEX2YQHF3Hb7wgoWzj11ZNwc4H8W5wME2A0YrI+z8jIkeXLrt0vkP2+
         NeStjmEDeM1kzfwwi6sloXfvOc7UfLjjF9P1HQCyV0QkD+FSnsi35hKLwDg39V1JL6NL
         aQpf01uSQxxmO3PfSiCOLHBPAP+VTzxAYeaGBWNCgq2O287yZG9fg3Sj0v2phZcaEPdZ
         QCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595017; x=1774199817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVyBXQRSzr9/lSeks120us8HXOhp+dnwI23FH9hEtAQ=;
        b=A1qKaW+OG2DZT70xxaI2KxyoyInqNHG030uPPSba2hUnDmRSIj8jlB5SxLcJQ4xS5l
         Paobkc249pIWJTVdi1EUc1MS1x6ncOpJakQTxXOPHECK/wg3psYzvLCQe31eZ+ELZFck
         QuZegyKnj1YAqAkMP7ddpl0f4ruEn82thwT+tfCzFpe++fr4b+il22MIYx7mu4/yfSNb
         0OEajHRsi9LIdevv9j8/Tqa+TjDy5HgzUcvqagsaeAKVUHGF+uVPO9Qm4ClC3771cOK+
         PGTP7knL+/uz/imyMKpIZ7OIhBm46ttQjz/jw0Jx1HrW3ka9iGQ2osO0lZRDfVxLTk4O
         I68A==
X-Forwarded-Encrypted: i=1; AJvYcCU2JD3akGyLaPT4KkJGh/n6Djinv88hJlsDZHOHC4Ty8toWMEAIqNHXoEtJhgI1pIa2CVaxSleail4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zfg3EAqvFhayfZZceC3WTM44nIprGvWeErf1ivT5qOONNIcg
	HCDQSScL0zGq5q0wtWtXlL8EMuswV4EldUTDkWGyunitK2tF/e3mrHvo
X-Gm-Gg: ATEYQzw22fdPLIuOWGVO+AWsdHfTFaaJVJzL+jwSgtUjyja1EJ3w/JLlNWWm9XfFMGd
	NYafZdR9mAx525SLh+2k6InVPQT8md7R7smNU8mmJcq9Iw1y+/m3oxVFqRtWD9xB5h9GO2IEqx+
	W/lYlO9lf3D7sfwObkpIW9ll/sC6FIAwtNT6/A45Uu3e12SNtvl6fNCjkZyXMifCDHJW9h4q+Cm
	3GZN06g4rqKcBjo13J7iMakdB7pYVTvk9nDpsrjU+7Ay0MbM3GQj7XQbbJ/Ug7HqFEuDWq5DAHx
	yqBJgY+SJcKjJ159Nmje9MYDFPDNFEmXyIJSzIx8nxpodVCbl07TlH12i61infPgBzVqdr1qcLm
	mfEV3abCrsix3l1cuJ+aEjxX6DsnrKaBXH39aUJh3luj5t6/1NUZPQuM8Sr1F7IwjiHkz+5b+pj
	Afw66GpkVJfs2PBxQNGV8bNEBd/FsgVWmlew==
X-Received: by 2002:a05:600c:230c:b0:485:3a4f:8bfb with SMTP id 5b1f17b1804b1-4854f56bf7bmr178045195e9.6.1773595016983;
        Sun, 15 Mar 2026 10:16:56 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:16:56 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
Date: Sun, 15 Mar 2026 18:16:49 +0100
Message-ID: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Adrian Garcia Cicuelo (3):
  mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
  rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
  wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity

 drivers/block/rnull/rnull.rs                         | 13 +++++++++----
 drivers/mmc/core/quirks.h                            |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c                   | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.34.1
