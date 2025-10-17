Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99755215043
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691917; cv=none; b=RuYsDxPvX/eBrnGfkKYUBIPdCzVuk4IkDdkdbccXY2ITEQXuiPL3hdl2ECe2IF39AyyVoBJTV2ONAieO9QxTElMup5VfDL8z4VeAGhWOoWMUEvdOUzufEQacH1BzyFc204LM2m62mNkOxmLOkEKIG/cO6KKsu9+cLJLYFzO1yUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691917; c=relaxed/simple;
	bh=zMs/mIehTFFTGYenlsWc/vYS2ZTq9wvDlsNcyl4uvK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzCyj5brneBwM7EmbetpY7aJ7EXHgqHAPfMDTqUx+fqoGXkNyuXOAYTZVG3wu2YZ1QxucZ31qBVvJDVJVm8SiWN+WEAT/kRb1ASyeodXh1hohr0ONdoOa6PSlqPK/QFveJmZwx14Il+8iVaHacs+RSnQUwLs+fLS5XJK3118p9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqjwpDQ6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqjwpDQ6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1939350e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691914; x=1761296714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvEYPMJTqteoPb0SvAUiCzFuqyHNEnMlHD+3V0pCfZ8=;
        b=RqjwpDQ6bJ9hLbWrV6ciOjNBDf0vGpx7tCD/eO5Pw291CDkR3G0BeTUbYIAvniKWZG
         txNTsGHtHndtFY2YpVp6o0Etp1ucjjTRsjb2Y3cQb0BNkMwraDQd6C1G4Ygw2Pc+rMRp
         7ZTgarB6njAV1d+JWzKjoJh7pX5YTndSD94NsSijG7H4zDrQDf7kPXAbIHzffq+BDgF3
         2rZedGRycL0AuRpnYJSUiSoN5z4lcEGZ70aThyoZEnYb/lHQ25c35om8pR97CpOd6jpO
         PPa/3N6s/IU5yXoCCydxVdlprD9ITjxh+6acOOi4+YvDClSl+DSbSxd0A64DJ0fnbopj
         AsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691914; x=1761296714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvEYPMJTqteoPb0SvAUiCzFuqyHNEnMlHD+3V0pCfZ8=;
        b=smqZYlF+yThHbE/TZl5qtWshg0FSPyeKiIv27JhrwxsB7PnC5KARQEaZxyrOJwgEet
         Zly02VWMcd30C+0h6Ao8ltgcc+iGVbyzGe3UxRAzYuyhm1L5Q8tfJle3cKikisQnhfaW
         yPsF2umw4ukrKlSdonm2IMqsN7F9TRZy6cnNKofHUI/nd9pjOAGUz2XvUtioCpQZeVu7
         cv7McEBen+ISx6/JXejugwelLFie5xhMqnvxqv4ChjUK9aShg1pq8OoYpzyiaAD2G2NY
         TzCOS4NksptH3IBwDUsP0IHvMUHSYItdafnX0hI40wVRTX5OUMLEi2aRWw+uYVrrb/dN
         vAug==
X-Forwarded-Encrypted: i=1; AJvYcCXRmyINKQDJF/hP1n/NUVINtNvbc2axpWSUuNphRbzXa7Wt9/ZV8boeaWe9wPg3wRSVXF5ZwktPlG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPbkWsoB4/P3oax8glVepU2AvRVVcZpsu4hEPpOkrbLMg75XC
	px52O47Tw5UGKSOpjaiNG7Nd1nQWegSE60G117Vk8J8btREO2uk+7GXjSGYMboziv3ygLzMaNfu
	Rtwgk
X-Gm-Gg: ASbGncv2lVnyJNSq0Yexb4ePJUjMdTiRMtg4QAAakcaNmK8VEZUHTxMNl4pZBT5F9tT
	aQr8euj0ly+ZbekiqPmtKhyLQhlr1JxV2RmdlvIlEHuzuK1O14gIJjY7SEZ3y1SUd2NfHjb1raE
	PDK/SE73jaXUNC8FufixEfkB9yXFQKFH0U5vmAUyotWlZMRH+lzeixCNx2bcsySqu4ROCmdmDLy
	+n//digTiL3Bh+oFop/6nzXukFCJC5AOay1tC2DTTA+cB01fVqvs06FD7sV888tJYtCUHuZgtGo
	dclk6F+NcxhB463vPzZwtoBnU4oTwkFyhkxCMOLlIHf5c997mGEASRF68oCBnV7DbjqIhzN1M4/
	FlwyLI6jcN22y8F+n1+SMTUejZOCZwsBrcO88DNTYoTOKBYF8vdJBXu0oYHXg+adoukorv2sxfv
	nKy7YxOMqLi8eKcxjUIGIo8wxeORG0yyJb0vkmN0zxY6xP7r1D5g==
X-Google-Smtp-Source: AGHT+IHCKSBIJLwVNLbjb9Qu7KQoZY5S2lKEGkPSQ4sD+VQWJFaZm3oKS+GT8xzA9169PzxaV15SCQ==
X-Received: by 2002:a05:6512:b95:b0:57f:6da2:69ec with SMTP id 2adb3069b0e04-591d8384334mr1048629e87.3.1760691910151;
        Fri, 17 Oct 2025 02:05:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59092ed98c1sm6922128e87.26.2025.10.17.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:05:09 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.18-rc2
Date: Fri, 17 Oct 2025 11:05:07 +0200
Message-ID: <20251017090508.78726-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with an MMC patch intended for v6.18-rc2. Note that, this
isn't a fix for a regression, but instead helps us to avoid sharing an immutable
branch between our git trees. I was planning to send it before rc1, but I didn't
make it.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc1

for you to fetch changes up to 7e8242405b94ceac6db820de7d4fd9318cbc1219:

  rpmb: move rpmb_frame struct and constants to common header (2025-10-13 13:18:03 +0200)

----------------------------------------------------------------
MMC core:
 - Move rpmb_frame struct and constants to rpmb common header

----------------------------------------------------------------
Bean Huo (1):
      rpmb: move rpmb_frame struct and constants to common header

 drivers/mmc/core/block.c | 42 ------------------------------------------
 include/linux/rpmb.h     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 42 deletions(-)
