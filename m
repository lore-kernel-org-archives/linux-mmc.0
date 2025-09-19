Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF06239E61
	for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2025 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278467; cv=none; b=Zhd5Gg8HvPOwAXlK7WWP+7y0XlqTjQxpUKoyKx/8eIktwR0fIJGX17L/5Q9drR8bX0AgQwYeL6rW8f0HvukG8KbdaXmw6Bnn2R58bKMcSY9R0E5ptcNhK3PUa6UzPjESkFxEOLaRJqU0fFkTfDNV4dEmE9OCvlO2uWc/Pn50oDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278467; c=relaxed/simple;
	bh=O4U4VlGmeQDflUbvmKiPoEYfv23O3qBc1YY79tuQ1Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKc98NfXi+ZNaXY9KyiPMJ92knMyzvE3jCFrRtIR11SSiIXnE8ZnncDhwoQ4u0soJRW0KJwXMJOHA4OEZY0PpeBC2ZxwVZlcJWHGdh5kByk/1WQV76AItj3DhV2NK7pFMVjzMsanAt2haEArWxYDvyeO2soTDIF7bq3rdVgDSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSiP6ol6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSiP6ol6"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-579c95a2be2so1194341e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 19 Sep 2025 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758278460; x=1758883260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AKB/HyKquS5RzZKU+LsvHxhD8qHPGgJXS9wD2WqZfM=;
        b=WSiP6ol69onpYOC49Jm2hYYLfPeZWf2kjezbnLE/oCDPEQ8ttQ7mozvUhmP6/0uck1
         CYhNPX0FAHtvpkhsrDuL0zlQIrbD5VO3IuXvl/OBbDygz1NUM+yneMR5ZCzBeEHbd8SB
         pg8yIADk0FWK3jX2mNnUL9rj5jJS8+8eb4uGH9qYVN0+zY2I/QcaQoHy+MoyeuGGOf5u
         TOako44qae+oSCOj1rMYc3kBCLEs8g44Mjo+oYpsYVQi12Dj7tOtxYwVXXc5xva9tLa3
         b1L4VJCubh1SUwvL1ErQ9FQlv3kHmy92T7FhuXXusdmLsetjBuMvMQ1NwLed9zcJBWf3
         2Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758278460; x=1758883260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AKB/HyKquS5RzZKU+LsvHxhD8qHPGgJXS9wD2WqZfM=;
        b=QP1n5TDYrP/uJAwexjAn167z+xXHeAETWvLadCTFYUX9R7rUy/K0VjyfLa3rfXge5R
         /N/ahjuGctxb9KnvnPBB3+b53iDhosWT78x/lPHBgKCme2SnENSf9w68TiXkB/LWd2nK
         kbAN0D1PVICljsO7d26ZoWNlvRIwgvjU4SyIrycJspKgIVMYH/HG4VlCpRRmCUdQeKlw
         Xyvb9gQHWVe4H9t7ROG4ZfpsfwA5GaZ2t0G6i3pExrNtUOQYXiVvQ+axedhnBKv7H+Um
         mh7qv1YxoFESDYUsdzmJtazvhuKIaUpu2bnCHMgujj6Nr5VE7rD8uVzYt/Bwyj+0IcTw
         3Afw==
X-Forwarded-Encrypted: i=1; AJvYcCUEklSdt1wpYxuf8Re1ZTPDjdLZua4ppDjsLoqjnXBsdLW9xKjOSDZqaBPbhN2tgad9uhOMcEksDac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80WFXU+l0N8K6g9T4/vwBBg7dbUBX+Aan58cImzPRLLFEEbqa
	jo7olNa/JDPPxfdXgPSuYxP2XJtznU6Ol0RZECsdG9mctI29Qw0DWz0S14sOlyJE/8txLDwfkMH
	YVa7C
X-Gm-Gg: ASbGncuBbktwdJn0Jqy6osfOxg6E57QFnxtgNAqdchMHpv4rmQ6RdQ/+d++swUuMLJA
	POJzfKcTNBeK+TI+VTpMVDMw4I6/fyeBPNxwlkCcohQHIuEaEcDVcWTQMDcuiFQpvKTA1W1yEpb
	LV0ZiW1ncVfg2fsZi7LG/ED0bSp0QnNpynFs4zVXTJhDacf1zwhdnlrbP7Sxh4TgzlfLwHyICtk
	QenP7n3u3mADacrUk2fXW74UxjpRKskgAX4GAO52ZMEbJsu+f/pXixV+fOANmryZCSXFjlMWMpa
	vJfhzf354v7EDCZPSlxtIB6rfMmsFfoKfTzzXdHX1A+UjQQl4RWO+B13oH1jz8rfBVra5wqIAr/
	P+ID4nVoD/lbNIftGtrF4fhDWE4qobfB6bBWiSKU93+TZ1mIKExwETrg8+ydkydF97uOjBake
X-Google-Smtp-Source: AGHT+IHH8rwC585jNe+4c5sW4pKrJpLYKXDwih6aIu95+Sl/k7jJLYvDBjGYJrjUWOKrKvlS5ycnug==
X-Received: by 2002:a05:6512:3a81:b0:577:3ccf:cde1 with SMTP id 2adb3069b0e04-579e3d3a5ebmr797362e87.53.1758278460066;
        Fri, 19 Sep 2025 03:41:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f4482esm1316453e87.28.2025.09.19.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:40:59 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.17-rc7
Date: Fri, 19 Sep 2025 12:40:57 +0200
Message-ID: <20250919104057.152796-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v6.17-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d2d7a96b29ea6ab093973a1a37d26126db70c79f:

  mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1 (2025-08-21 11:07:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2-2

for you to fetch changes up to 77a436c93d10d68201bfd4941d1ca3230dfd1f40:

  mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on (2025-09-12 15:00:52 +0200)

----------------------------------------------------------------
MMC host:
 - mvsdio: Fix dma_unmap_sg() nents value
 - sdhci: Fix clock management for UHS-II
 - sdhci-pci-gli: Fix initialization of UHS-II for GL9767

----------------------------------------------------------------
Ben Chuang (3):
      mmc: sdhci: Move the code related to setting the clock from sdhci_set_ios_common() into sdhci_set_ios()
      mmc: sdhci-uhs2: Fix calling incorrect sdhci_set_clock() function
      mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on

Thomas Fourier (1):
      mmc: mvsdio: Fix dma_unmap_sg() nents value

 drivers/mmc/host/mvsdio.c        |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c | 68 +++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-uhs2.c    |  3 +-
 drivers/mmc/host/sdhci.c         | 34 ++++++++++----------
 4 files changed, 87 insertions(+), 20 deletions(-)
