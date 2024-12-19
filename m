Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBFC14A630
	for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615707; cv=none; b=tWquIBX1T1B7hmLZyKelsYVirNue7PSwsZG2unRcWv+KYi1uSw7/X50JbVvCJ7v1A5ZhLF7OK86j1sQLU57sNxrtETTRJpdSnx3fs7sCria76kxMseb7P+3dhER0PUSUZOEcEE8Ss911O0PuzRW4RXmMDWWN4QsgEfiErnBGbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615707; c=relaxed/simple;
	bh=zBevTMZcErbzran0HqmE2I5ExR8ZfWM8hjjBTM6O5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nv4AlT6pFUNF5/lx1tyNQjc1jSFMRb6+ZzRu2HukmjXveV7BDwngYP4cofZlt1OngDPvxnSDArO80DFwxbpGzhE/KbJcXI3occqP/SofYKbOFfFzb/4JvZMi3mgxXaJL06ZuxvaS8pidHq8KS3cEc9zkEAdkTl9Kpf4n1d+K4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e02mTZbD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e02mTZbD"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30039432861so8217741fa.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734615704; x=1735220504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHfksmUwM69wv4qk5ucZi0cziGHoXJDwoRaaHBsXhfQ=;
        b=e02mTZbDCFaon2A/oWl/bn8L19/TeO6vpUb/Aslm3MI8L01f/xZ6gd+7vOGshxX1sU
         B+I/3g2NzRV2lZtg3vxPbgbGSCz5jlU8I23WH7sLXE/LXtBdxIHw78CPl0n9b5fCGy3F
         zpIP8y3obetn/F/SH84bQWGsasMzNJDaIAEukdsoI0F27MBVywCsSHtEfLH7EDGSCWrY
         a2Xi/0NdniJYXebf1UOSuOtrvA48OzMyj4S0EKb6C0FaFW8emx0wrxpUqaeOjSoeLo4K
         0PNOD45KHVvULckqhLeKhXVngIgqoQGEv0DM9EnB/cHak5vkd7NpVNTSuiksnrvpXUHg
         7SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734615704; x=1735220504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHfksmUwM69wv4qk5ucZi0cziGHoXJDwoRaaHBsXhfQ=;
        b=oaikkI898etMQF80H8dEiCk9JlrzhrgeS9+G6Lg0jxdBE7FUlycczuFgTBKGg8+/yf
         0C+2OXXjEMjq0FRO6lV2J0aLxAx62CC05kQi6HJsj9W9cqlBMKQ1GEKafOXNdkWmZkQ1
         TlHib6NGHeP2Wtk8ZXAhBOs72L4Bfq0OOXUJqKExSkpdSm0ZOQVsZGqJBb4pyLkr7S4r
         Ac91yMrU+kYxi59731vSOCOT5zY8fNDOqkVLd6WSXzQIVMXARF8ONJaQxiBHxq/hEk4B
         Kow0qGuZ1QWi+f7FmHkAnXV3z2zh773KhwmnWI0yLZQYT8K8Lg8aB8m4OkRWzJb1OymK
         szRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3WiP4Daopgce8VWsk40pDqpjMpXylwseOJO5SWlpJ4HtbfTV3qSCJpunlE9xG0IvL2IVAcC6zspQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPI67fDYROtFDm9SUfhCEeKfPCc7uyap3LWD6R6bIyq0piemkY
	9c4dAsQ7PiSlBErykWKKq6nz3jF4dfsWgfO6bvrbGZ3pUAHCab9hsbN4GDn870o=
X-Gm-Gg: ASbGncsYOacKXYNIJTCUrI8RLMDfe4cuS/eDTQ4ckpf6KMcTNRHTvw/hQdtUeTxmvtn
	c//b8PEmb3TOfQLXMS9gsH8VXwgy7HoMuOahiaJCt8UJOCA+KOay13Sgf0PUNsxShFXARpUBeCc
	OZx9lkVibWlXIyp3oNMIayM6XRiG5UTUGDwJE2XF4M46XexfYWP4XTTW2d5YDlpLF24tGBcrKMD
	jX0v5NxQ7cpQIco/Bm0hylD5PuQg1tGFC/O/zaVEDZ94roR68fglVScR7Xb2+/y3d3IS3Sa4mT2
	DfTipLIxyssMDDFDPfyS5d8/uP0Ec3U=
X-Google-Smtp-Source: AGHT+IFLpNUNlMCfPtlpqGwwpT/8GMyjd56lxG69KASSJ8WxqqVuXOSZ/tCrHWeZLPIa3Qbf1dsIWA==
X-Received: by 2002:ac2:4e08:0:b0:540:353a:dfa3 with SMTP id 2adb3069b0e04-541e673bf38mr2569255e87.11.1734615704017;
        Thu, 19 Dec 2024 05:41:44 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238301casm179356e87.240.2024.12.19.05.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 05:41:43 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.13-rc4
Date: Thu, 19 Dec 2024 14:41:42 +0100
Message-ID: <20241219134142.48554-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a few MMC fixes intended for v6.13-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc2

for you to fetch changes up to f3d87abe11ed04d1b23a474a212f0e5deeb50892:

  mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe() (2024-12-10 16:02:34 +0100)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Cleanup the wakeup configuration in error/remove-path
 - sdhci-tegra: Correct quirk for ADMA2 length

----------------------------------------------------------------
Joe Hattori (1):
      mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe()

Prathamesh Shete (1):
      mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

 drivers/mmc/host/mtk-sd.c      | 2 ++
 drivers/mmc/host/sdhci-tegra.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)
