Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D83DEFFD
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748089; cv=none; b=J3pg3zLF4oxfhEA4Lpt6Cfg81jJvy/YsB9C5ut8MtSfNiFwJSgxFaKz1UPwlkyWHgLR/rjrzpdMd+tTnzQ36/oFwHrmtZ+4BSJoAXXLr6Ze3YFxAtP1/+n31qOoMRHk1kHdLbZuog6fkCCZgmcvEr+P5E/xMP3f/VnWBd0Rox00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748089; c=relaxed/simple;
	bh=HAGU8XIjKZpqrG+yUMlS5ZcuGjQVQscOF38SnYSswc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hexUA6gSiqe4HYphhDsnoFyitFybE+UoIlBK383tlq99OZh0zXBjgvB4fD7zuLy/sWaEEdFUrkSkMqOBHv8ECFhP7QgdN/Zx8d+EXGFIGkJepp8WKY62+ylrFIYNSqTAUizT7GHTIY94FgTpwHjEBXLIqxuWbpYS5bxWzdhKcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MS1Fl2WD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MS1Fl2WD"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a1307438ddso975650e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775748086; x=1776352886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5Fb3B93TUsT/DugnNHfZQK2kqf+0U9caFnlnmSAsVY=;
        b=MS1Fl2WD64dLcoyeEJWdEA4GVyBXp4IJfdfz3qSWZbMtNPXh0dnYSz1awADoRfzB5i
         P8ipZtKzYX39c38JEYgVznSB4ae27WwXmPyRlD5C1ukS9paUmpxOo3VvZuAH+CxhAN7N
         6/Dinx/ZmikGHxyiyArsxFsWlvQNc0ekD+I9fAev/s0cLvGsJ2sAhAIviwOWU2DQSi1t
         wyRelTiclBH1IzN4kf6Xep8u9aXXZ1xsBh54OHCmyHEE5jcjy3uDuJ1TwznyDSDyo4FY
         2i0Sq8qnKpYX+6tl1P09UkjqAsH8EcztBnWKaKoKVHQmc/1D7JbYSMI1SQh0x0W+iakj
         ws+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748086; x=1776352886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Fb3B93TUsT/DugnNHfZQK2kqf+0U9caFnlnmSAsVY=;
        b=DruPTpkrOH1nn2pEArEvnDDfqxTq8mJExeY2xCjJTmWBLvpv/5w/aFed8LaeBONno8
         was0QClyjBm//kKKJYBG04wKCGQDx4RVRK0B+uwYo9t8zP0Va025wVQg4tRUpHpdbW1C
         xUFFkJ6A5O87aVsvJtLqNGsscPWiAXE9ySMgYsjodQsW4PS/QzKhEO6W/3XqGtLokwR4
         esniGn54xCObz5bSf3YRrbwRZuvy010aeLy+C57CzCsE3xN80fIVgD34/+G1I6YECY02
         IZZWeBjWmSyXlRP9LqVhP5wnqB3LlHhLKYR+yIbfK2qO0WOW8X/sE+RdMvi1AhtPvGo+
         vK3A==
X-Forwarded-Encrypted: i=1; AJvYcCX0wrEMv55U4V2iFze4DhSENUjGulvn7BOtz109vGeXgISYOHGEjcOxufzqS7nuad8FirolMsANw70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQTM0o9cVsptyPbH4GK78pnUugask2VnDQEIhj21RE13v6Gcr
	KksMVICYzX/WuPeL/L7l4nJJD6VOc7pcyv4Y3HQNv1ggyUqJALNt/FhXPUd2oL6Xvtc=
X-Gm-Gg: AeBDietHAP3ddDGRH+OC6xYP1x09dhk9Bi6YL3opBDfuDw7TNa2peiSCEZPlAS75Nyg
	KrNB6pZcCQo8SDax7Dj6rGAx95vzz0pBcUts2ZznOy2/HcubjZiMH4ikDA6+kEbR2mj5iAt/C2l
	PSwKYUgLolVMhSsRZoYd0nipNnbCVbK/8aWqUXkX+61QghyGtMdyzNKACJdp2qBiL6jCVgGCDtU
	OfCByhaFCLciVyPoyEYLT7AtCYKzKWK0v1n9lgEOe6ll26MlAh6KYqs1Udy81sd14z6CJE/UZCb
	f/5uVCCAVTbd+iz7TA7z4761YKjPpn7JLUnXYCFd79qrAJhsP3J8MnMYwqs9cbsurm4DVOoxYZx
	PsQMXpvatE+H3skkItyN6ZiGgLw1h6zRF8qcC1NI3E9zmzEXKtfTHcuL46XJA9rcTKvTup5HGqf
	ldQ+UslcRaSidNflomKatOJyANPhr33mbZi4t09vTtClONDysZ1P6ylbldi8jjdF+pKuL+y0JC
X-Received: by 2002:a05:6512:3c9b:b0:5a2:b379:22db with SMTP id 2adb3069b0e04-5a3e7a26473mr1409422e87.18.1775748085574;
        Thu, 09 Apr 2026 08:21:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccc83sm5507378e87.65.2026.04.09.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:21:25 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v7.0-rc8
Date: Thu,  9 Apr 2026 17:21:24 +0200
Message-ID: <20260409152124.29346-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of MMC fixes intended for v7.0-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5e3486e64094c28a526543f1e8aa0d5964b7f02d:

  mmc: sdhci: fix timing selection for 1-bit bus width (2026-03-16 16:08:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1-3

for you to fetch changes up to 8f4d20a710225ec7a565f6a0459862d3b1f32330:

  mmc: vub300: fix use-after-free on disconnect (2026-03-31 13:11:20 +0200)

----------------------------------------------------------------
MMC host:
 - vub300: Fix use-after-free and NULL-deref on disconnect

----------------------------------------------------------------
Johan Hovold (2):
      mmc: vub300: fix NULL-deref on disconnect
      mmc: vub300: fix use-after-free on disconnect

 drivers/mmc/host/vub300.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)
