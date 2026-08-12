Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68713364E9E
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533645; cv=none; b=X8fWsPEFs4Dcp0m/oNN8qtEh2Xcftm8jhMl/IcGY83UkQbmmkzQGMRMl/SRe5kzobtFBYzmiiuqoNQG4Ow6ARBWTgNLTyDaRce8iMWa8yD4xG9iiLa4yZFNEH8DyQ7UOjnph01Pv3a4ZFN18z1RqO64WhjxnfLHY4itt1nCKod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533645; c=relaxed/simple;
	bh=9KhDCsl8Bw1k2kTCEoSpdhXmXsRF25n9b6Rg8R7lRgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLjT719Ltzr8wnCazd0R/9pgcF9Y0sT9D6G0m4PzhFLO6/iGNf03Gh9+blLdrVEjL7EwwF6iuw3nStgu9qs/mqtZTAuSyomgQaIb41sdp2LWqXuJvyjqyKLAM2h1XkUcf4RREKuJAkwzfdKVjypaQjdE2hMyzCPARI5N5YGoHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnWD2xHu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnWD2xHu"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e08baf860so982946a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533644; x=1787138444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+zrfepUvONfB4EyAxMBrInEBGNeqXHZ4lQ9CmctDXA=;
        b=fnWD2xHuGRcsdqq0eh1TvtdH4LT9NIysdoHdsjZq4qC0M6rb37ulaAiYj31JVx1QSu
         NVXdLvsNdRPV6q9BdPOESfUzZwOT/tsWFbATzOCvCfwSX98iViuW3Stga5gCmooMzCWV
         GEod6c7FyAfMzVPEHllT0jj79g1gCgYRtdDiRJIRjFYe3DBfymVrkqeOhrA3hayEHUSN
         pVlmwUYmcoYrwJjG4yuY9hesbgT/xu20cR2aDJTL3TfNnnklXSIdB5bdX+Qpeu9W9Tjh
         alBLT1Wl+/Xs4Il3WQumXHBpw/XD+B/WBqUNEEOQUGIyGHYKuIryK+7K31juDQaw8I8e
         kTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533644; x=1787138444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+zrfepUvONfB4EyAxMBrInEBGNeqXHZ4lQ9CmctDXA=;
        b=LgjfwX5NzeJSJzh4ZyNEM85Ck38NqqGLX105EY7BozxW9y5dpCZ9g6TtXZ5IPzLRWl
         l8QZ1JJan1URxYkpzpG/kjuus9XMHBxZSiY7Fab/6V9gUP3eVliAHljp6kBDBB4zNO7D
         179NM6JsBt8gW/4NB+/xoEj0I2Zfxap3FgJlIEmct47mrJZTCUgjTlzOQiKaytHYNLSP
         drslVGIfS4Cz408TkjxL//Winp9q+qhG4LnoWMbHQVQb8pIj/QOzMtZfwiX7Jjho/hNs
         93UGLPZLfK8hFPvl3FHkAxXUEAUoZ1pnIHdP8zdUQXSpo+9Kql8m+6TJCsjVKttbGoPz
         d23w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6lMbQ6e4OuonfzEKRbVu+I68VNH1Y3DgH2IleqtPHKPISw5UXVZEObN4QD5nQ/O6IPiKrlk1FfuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNfCEvwYjAg7LSvwEtsn8gYTFmgCbuxMGTn8DAsLyWYYTjQSF
	fyrVikRU+iiegFQc45kxmLjtLom8qCzWgHf3u+cyE6hC9ehvlN3OLktt
X-Gm-Gg: AR+sD12Nw9AFN9kRfAn81vy2GJzdplvN9d1YEBHHx+mggeuD+/1kqYaOEro1gwXbjg+
	bLWi8F//biAWnZsf3rJ1UWuyxG1exLWEu0JDX3/5CDh8FykzlSDOxpD5EC2BKH9i4inNPWC0NOi
	NMF7dxwfTphmKEDXreYEQaRL808+KpK5wFiw5OYmYQBEhWigHJFgDCg6JHLycz4sx9bYejidGDL
	D0d7Qkf3xzv3RsPzmUrA16N6DYRmhE3tRncf1dnZGJyJhkq889OWpUp6+DAKzhSGfTjisDBm4Qk
	EhjbXhb6WmvmKs195zhdo1pRTrfbzmtAIPbsLtlBsQIp8XqdIQ90/Gzb6MSeucY1FKD0SGagpeV
	hxG90PgL2/ZVVDUX/foIQDd4j2lfOSj//kefZLXQRxq1qyNqPJreyqdzfnsyJdRokY64GLGnFa/
	z0SbmviV7ygsbcBNDZi1dqYW2ZIqCIbvgvZ/ZoD4pymP2W0c3T/BcpsKqEHj0gNyCGAkZSzhmio
	MbbmY8huv4dkNTGdeYGeJXp4C1bw4yK101z7ncSR0QtON3QGlTBT48fFaOkAm6LSYQBCyFt6hE9
	uxdq
X-Received: by 2002:a17:90b:28cf:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-393012af827mr4741095a91.8.1786533643641;
        Wed, 12 Aug 2026 04:20:43 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f5ecsm3193765a91.5.2026.08.12.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:20:43 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 0/3] mmc: Handle errors from optional IRQ lookup
Date: Wed, 12 Aug 2026 18:20:20 +0700
Message-ID: <20260812112023.42254-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series improves error handling for optional IRQ lookups in several
MMC drivers.

I noticed that mmc: litex_mmc handles the return value from
platform_get_irq_optional() correctly, distinguishing the case where an
optional IRQ is not available from other errors. This series follows the
same approach in the affected drivers.

Best regards,
Phuc

bui duc phuc (3):
  mmc: meson-gx: Handle errors from optional IRQ lookup
  mmc: davinci: Handle errors from optional IRQ lookup
  mmc: davinci: Handle optional IRQ return value correctly

 drivers/mmc/host/davinci_mmc.c  | 8 ++++++--
 drivers/mmc/host/meson-gx-mmc.c | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0

