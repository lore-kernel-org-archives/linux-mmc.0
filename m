Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D18274670
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142537; cv=none; b=h8+ww+0Pqc+z7l0ccU4mpv0m78H63LRlEG+z8KIw5KVWxwmeiJwL/a/jsO6PrrG5Yi/ic4zIYYjF9ssWiP3dLE88BHjCtk1dhvw7vrf8MBLdWMI7vl8omdVkWRMBLqppJyPYQHuSTiwU/ng/NYiERrnpVNTLPXaqqsd4WOKDk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142537; c=relaxed/simple;
	bh=nFktpdyeH9VET8soYQOLM99cpFGbj9PgEuXBzXIJveA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTcWhBJvyjlX5Rlkr9fAV9bzWv2/VV4/88UryIMMJWkfI3hIxbIVdu80F6NyOYRh9ZfZLXcSLJ2zCOjem7as+gmj+xKHsxjr8oBKdTRVKNsCu9jkFeGK8e0Y3xoXi1JKlDYhq7mM1SKDzqN83ARrQazmxid8Ia01u0MTzMjkJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EOujUL5L; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOujUL5L"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59431f57bf6so1764816e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766142534; x=1766747334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ge6zE3JAz3CFgRMhKd1XCILF/bEXU8TaiA9a/vhQqNI=;
        b=EOujUL5LHWr5tdui57yfRviAf6F3wZb+3EsQtfqopM53ZAbCu6tuQf8k6qYm88mlK7
         omgWLR+jXHPfvooOBUdpYNvq7mOmP6xSzhjp0tYNNCcRwjASlJnMwkjzrGFxrZKlUftZ
         iq/7klZwBq6MyDd/0YjbIdUQtyQflAdpdaRCN2Ep/nEXNE8C6NmOhQrgEhCTkgdUtVeh
         1XWlDYtjfCGNk+ZTBojkFRJRmpYqoigOGPugqYdfoOp48MTXx0V5EhTcC3hoOpN8gEEy
         cWs68G0hm6zvBfaCE75JFvcVERubciemzM/8az+x1dA2ZTgCVHKq0Uvsig9W5xqtky1l
         YgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766142534; x=1766747334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge6zE3JAz3CFgRMhKd1XCILF/bEXU8TaiA9a/vhQqNI=;
        b=kYM0LDx1uVMl2Ys8EuOeRuzKWJhxkTHtXmWaA0wuPQifQJLC9fxVSU1S63JtKOttzd
         QiIvK2rxyBz6rhe+lspZAP6gz3FFaoovhOClDHivtZPxzQG/kpb9QebyL51ld4oXDLTK
         PjKvQWZoq+affK3s6KU6tI4/Gamix5x94tz7phKKRT16gjiiUnfKjMd7CPgcN1EVWsAm
         2KsMiqS4sENUe/4mxCA8u+ljMMHa/hc9jHCJi4nATwe92f41HdLaOVgzCZFCDSxje487
         D/Tz0u+DZkkwZJFDb0WHwUonNRoz8CM20AKxJGfmqrcBFkgB/pAzq9Ei59QPbBlhC0r5
         l3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuuazXexjzA5bUiVH074Z5mSzRtOILhzDWdUlJbbrXi8PlxaWphutuQ9JJZPXoVqGXwQerwc3y+kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUE/QnGTUnR8cqKmZjsoox+DMIeflhWM+rvz47zEqIjeNvigc
	YqKcTGH6z/s1D1oaQHD5487KO0OtAns1RCepNf/TstDLEVvNvGsH56ZHt3B4bC56WwI=
X-Gm-Gg: AY/fxX7Jh6J6nA9iftW7ArcIKA71zH5Edyz3ffzceY8zWBTpIBFmxDjlvbK3SAJuatC
	91VxY7zoT7JDrUYoxc81O8tIRrpcZqYwRHFf5SQ7IjXqgNAot9YWLrWZhP3OZSTsJi2ryUY7NGE
	TMlZID/0lL8q1MFWVSL/iNehO5aqZpyxU8Ye/2eJv8wIiFNp4nzl7AllthAj4STSCFRriAfVAuc
	srUOzyJiQKvbvbUSlNdmhxIqyUq/SGtvlxISuGiuVs6ESL+o4g22MkcdPVEEOVr6AE2rRImU6nG
	4OnAhJ5CrZU7NTTnaoJGrhloVe0FmoFJ6nTyNHiEkh8Yr8uUL84ZUzubncV2lnozf5sa8oxhnOf
	YynPtVIs7KXJDb1JjaSwI+nXn3pyJLRR+6Hj2RxshYqklz7OFckF1gB9UjWPjHGl1rS+f7BxQMb
	/8BThUKUDxSatmliFhF0rLhVMV60gg7rqSDOWR0UUMaTR0ipMt76f21FmAmdsyLkwSd9VtAwM=
X-Google-Smtp-Source: AGHT+IEIK6UKCT3BKUKZVB1WzOBz52OsinKT7VQt7KANut6VA7PXMEYE4s4U/jecQ+vX1MElzZa9oA==
X-Received: by 2002:a05:6512:3e22:b0:595:8200:9f7e with SMTP id 2adb3069b0e04-59a17d1db16mr951294e87.20.1766142533564;
        Fri, 19 Dec 2025 03:08:53 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5eccsm625844e87.14.2025.12.19.03.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:08:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.17-rc2
Date: Fri, 19 Dec 2025 12:08:52 +0100
Message-ID: <20251219110852.55175-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v6.19-rc2.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19-rc1

for you to fetch changes up to d3ecb12e2e04ce53c95f933c462f2d8b150b965b:

  mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to Kconfig (2025-12-17 14:14:51 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-esdhc-imx: Fix build problem dependency
 - sdhci-of-arasan: Increase card-detect stable timeout to 2 seconds
 - sdhci-of-aspeed: Fix DT doc for missing properties

----------------------------------------------------------------
Andrew Jeffery (1):
      dt-bindings: mmc: sdhci-of-aspeed: Switch ref to sdhci-common.yaml

Jared Kangas (1):
      mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency to Kconfig

Sai Krishna Potthuri (1):
      mmc: sdhci-of-arasan: Increase CD stable timeout to 2 seconds

 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
 drivers/mmc/host/Kconfig                                | 4 ++--
 drivers/mmc/host/sdhci-of-arasan.c                      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
