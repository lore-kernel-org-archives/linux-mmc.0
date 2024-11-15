Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE48192D8B
	for <linux-mmc@vger.kernel.org>; Fri, 15 Nov 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664854; cv=none; b=N5jcUTp0i6xljEPsQ4UsBeEJlIkHnerHxuA+Yw68AtsE75ImGwvOhzSv6NltevrUa1ToViaWnvRY2AQ9q1JaLhUBrzsn6+po7zg6/uT/nYHzvoo6Ad7g27M5tv44NcmBmlS3BOmBw5WSD874TA20AqfTL42j2ICAUEhpynFPZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664854; c=relaxed/simple;
	bh=Y0l6MYL9FxYgkAobyrV1dEFhx51cciq6fBBoBftTGmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OK7C470ZATrQyzycUzf8FtKLJBeycZnhjOfsJCrO85zE92m/P7DNKqVdL+jtmkC59wGG3g1rPqYCmBwC5xfvC3FP8BCi2WOuupak0TB627lmVvQqpk2Oc5U0GtasC2Muy/096J2HspjP8WK74kRu2uZCCFt6sG3R/g0/663p3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJIUcDUY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJIUcDUY"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53da24e9673so1655554e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 Nov 2024 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731664850; x=1732269650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJgKGB6f22K0gvP8aMMCcAaLzCd5tDQzwgfcDLV3EIs=;
        b=KJIUcDUYnDJmflc7cRSKo+CRHyffV+LmGgiwE9ochJCLgHzc+EEsDarqDZIbnI7TeQ
         qJBifzWJM8Xz1KhAbXEIWGTWAxvTSeWLuUMXM1VzmACzbhB7h6n7Grn0/5ymH8Siczo9
         1L1tzJfdGIkbZicFZ9xo51NI+53UrdEq+/wx+pJ3me1d5wh+JTOeQKmx9CdLmJADAY7m
         XtloV11IZdQW7ri3nwDGZeDb+FjU0BOAf6gvN95KVAEyaYwLAnJZRNODfAqSqeCNFFtg
         tPrsn313gf0AwQngc0yq8Rw9lIJk008Fw0GLYTPtf6vBlm171ulyhfJ1E4BMFJSImRrq
         SOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731664850; x=1732269650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJgKGB6f22K0gvP8aMMCcAaLzCd5tDQzwgfcDLV3EIs=;
        b=wuGPi2xSD69tU2ky8uYXdQGVr8QYQwfcIK1cMmTHBzlxzhEUYGCJjmntToyUhFtVOm
         tvpwozAcF+T9c7BUFCY3/rfPaXYBhsRfXrHg0nEyMOVgXiKSlnICR+P94YGuQqBfR1Qy
         gLE4AN+0Di+Q+pOaVpS8kbALY8qMTrdUcEjUzqOIe1wUSEwat17m67zzyyWR5tHuAs2R
         eFa4MZMF6DpI5s4EI6MtAdMjkGS/XG4GdRo7bhaJdyX8w8U8xLe+V61SQl1PXzUujOyD
         Faj1lqwO0hmk+hiIsVIkLq481iL2ll4P4rgi+Ht5Dsp+BKDJNQjUbOHQNnPly1JpqagR
         sPpw==
X-Forwarded-Encrypted: i=1; AJvYcCU2KIGzowGZrt8yxP5vlpHsnQHZxqR7f+sUNezEwrHgfiArTqvWbN9f1a25x8FwkrW4bKyx4Ya8nbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvnSAWat+z3+tmm7Ssfh671uB9bHWyuPLvAsKi16k2NoIzbGx
	KkuavbgrBaUBjSGksy313NS45FGogGNE49oUHoWH24TUjGbO8toXpEwqF3FPMVs=
X-Google-Smtp-Source: AGHT+IFjnu0mql1AWmnPV6lQab9zoQWnmE3byvz9cEBkk9nA7T4JGo1IHamARfz9EQEozoujyBSePA==
X-Received: by 2002:a05:6512:3c95:b0:53d:a9c1:f6d with SMTP id 2adb3069b0e04-53dab29ba46mr831016e87.13.1731664845746;
        Fri, 15 Nov 2024 02:00:45 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548c3csm500950e87.261.2024.11.15.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:00:44 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.12-rc8
Date: Fri, 15 Nov 2024 11:00:42 +0100
Message-ID: <20241115100042.116738-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.12-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c4dedaaeb3f78d3718e9c1b1e4d972a6b99073cd:

  mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process (2024-10-28 12:30:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3-2

for you to fetch changes up to 1635e407a4a64d08a8517ac59ca14ad4fc785e75:

  Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K" (2024-11-12 19:40:40 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc: Revert fix for IDMAC operation with pages bigger than 4K
 - sunxi-mmc: Fix A100 compatible description

----------------------------------------------------------------
Andre Przywara (1):
      mmc: sunxi-mmc: Fix A100 compatible description

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

 drivers/mmc/host/dw_mmc.c    | 4 ++--
 drivers/mmc/host/sunxi-mmc.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
