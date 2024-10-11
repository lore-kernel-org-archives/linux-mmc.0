Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A48210C09
	for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641590; cv=none; b=W0Lf/QB2Mvuty17Qi/PpH9agDsHWEKjKdtApI69TxnL68MDgqu/6sYU2Jrtoz4pDwkw88zVFzU/cbzhxT0Pg8VpcbghcP7YKgh9Rw4fJqpnpBn2gPMyKaA4KcdnWHvkdOvb+DPP/nkY2wTwmZMttYD2bS3p6ucc7teorW0ClYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641590; c=relaxed/simple;
	bh=kcnA+lJ+aED0FPTgu05sVKZQIiywRp5LBxECVCaFgyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDicWD5L8wch0qQNSPTMk5BBYpFqxfIfaoW+WGdeCpfBYTp1ZjhzQR/iyXD1uhwnCP8yTdQvKezi+vmtnsHTMPooSczTvkCjNYtwnvjWKAKYFqoOierIo0K2IYobS7xYtT+vlroaSs8vVylpIi7GVBCaOATsQ2VpFqmXyhHuAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/o0ESiZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/o0ESiZ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso20899091fa.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2024 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728641587; x=1729246387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlRQDo3NSY0Ejfdzg7RFuUGaPHv10z4kkCQEfGKMOKg=;
        b=Q/o0ESiZ6QkMAGOYZZH0EKYTz5xrmE2qOOSSsmAHMsN3+GcYPU0dGoSs2LM4H2Ke4+
         HhWdpkdYpFr/1Xx8GeKVfqJU4YRbVx03wqudPApUiN6Z9IdaWts2Xu5ue6oJ+4GV3LsC
         cgTSpNFulFjQyYA6cC3fP/8bmZyXZwS4ZCDbOqjpUnMF3QReqMdMusYQsL0vBQV1zdxt
         DFgQbpk9W+QXitdFS/PgP4T4hUB45gSue+onszBINQJ5Jau0KmnvVgfFKBUIMOFiZ/aA
         yaMWeD1bZ6Tl94OqflIptkCFnXKqGgmQ1TZKHlLUmPPFMQMpkGxCeRnZ9SS4vbznKrCo
         Pkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641587; x=1729246387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlRQDo3NSY0Ejfdzg7RFuUGaPHv10z4kkCQEfGKMOKg=;
        b=b0hPDP8cOYMmZ/V8AJG/dhxyNKCg3rTD+rncd17tSPAqkoV0KlYlMbRexey72bvshD
         kbKSUjr5QyJARHVoe+mRUdxagTBqFXXZybgcBRoOM/cP+zfD0m9wsKJas/kpPWMWZvB4
         rMhb9VAN4X86YObTzqt1DaLbN1OrlnnlNKbmdvKmkP7BLbFWtimS/JF7eluFPXEVxofO
         oun/+FAKBXN/ZYmKAxaMlr2yRVuHxjy/cJ4MjrdOtmcsaC8ppIuGM6k9Mwg/191F6TiM
         aUaYryGDgmxInIxbZHKhHxYW6G7mobSUCCWGWj5LJYuUCrHZFvfROzAE8S80N6HXADXV
         izQg==
X-Forwarded-Encrypted: i=1; AJvYcCWQNEiYFaaXxwsyfB1JMMSWWgCj2ZzBwsluIqD4z5eVsproKPZUcgfNRfGJPasCUAWPCqFn5y3tXRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9hf0iWynb79U2URjMaMKDT88K0vT1HGEeQI52zMLhdak+bCB
	MFcvkbCmi9noTiIlLjnowZ7T/puQ1gyQX4LGqIHBRw0SfC+X9aHLoSGusUcKqG4=
X-Google-Smtp-Source: AGHT+IEjLlAyAvkH+ZwqQtjV2KOqUe2i7VmEel+KM5Q0gI+oLtcapwh8o6jwOXBkmeWgr9myKTi57w==
X-Received: by 2002:a05:6512:2386:b0:539:9645:97ab with SMTP id 2adb3069b0e04-539da4e26e4mr1112438e87.33.1728641586933;
        Fri, 11 Oct 2024 03:13:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c8c38sm559107e87.106.2024.10.11.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:13:06 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.12-rc3
Date: Fri, 11 Oct 2024 12:13:05 +0200
Message-Id: <20241011101305.476157-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.12-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc1

for you to fetch changes up to 27e8fe0da3b75520edfba9cee0030aeb5aef1505:

  mmc: sdhci-of-dwcmshc: Prevent stale command interrupt handling (2024-10-10 13:30:48 +0200)

----------------------------------------------------------------
MMC core:
 - Prevent splat from warning when setting maximum DMA segment

MMC host:
 - mvsdio: Drop sg_miter support for PIO as it didn't work
 - sdhci-of-dwcmshc: Prevent stale interrupt for the T-Head 1520 variant

----------------------------------------------------------------
Guenter Roeck (1):
      mmc: core: Only set maximum DMA segment size if DMA is supported

Linus Walleij (1):
      Revert "mmc: mvsdio: Use sg_miter for PIO"

Michal Wilczynski (1):
      mmc: sdhci-of-dwcmshc: Prevent stale command interrupt handling

 drivers/mmc/core/queue.c            |  3 +-
 drivers/mmc/host/mvsdio.c           | 71 ++++++++++---------------------------
 drivers/mmc/host/sdhci-of-dwcmshc.c |  8 +++++
 3 files changed, 28 insertions(+), 54 deletions(-)
