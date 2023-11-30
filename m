Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNIagefW"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9DB10F0
	for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 02:45:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50abbb23122so1115615e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 02:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701341147; x=1701945947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtWv0itZumSAJwvDZo9xdAD+T/nfnYFJA3HUS+JmMAA=;
        b=qNIagefWhNpLTINBwn7chlwjHONm410v4xBoy1y2A/aTm6c1mnRjFpbGRMgHPWNy9C
         IkOIWdv59ySqtqKMFpCPajyyGodZjxQ59KqsKw6eAvVM3Z9UWIiFyXcCXYQdiw/Vhkwb
         nJwnSk5CHp4el1s+jBEpvtalBB/+EPVeMSnsyeE0tantpciEQApaPsxeeUt04UDXjS7x
         zOOvwwnzGA8QgtAbvanm1oEjo1hJqfKIBSD0y8aQbRN2Ub9xn6PKi3GiMRY2rkuiwhgA
         ers+FuyULQEzRTrbxo+6rbzIN4robrntPUgeiltUg098LJZPY4QV3Vq9Y3kpgOBoqpbX
         1bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341147; x=1701945947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtWv0itZumSAJwvDZo9xdAD+T/nfnYFJA3HUS+JmMAA=;
        b=SqpG5vH05i5+cRRMsNSZuREOjAB3aUU5xtJPp5yqw5shzE4V1rIJhVDnYabOCSDVvJ
         0D++oPQMtXEgCDCAnxaFRYjj3a7oV1AR+GtoXJQvdwBzUSkPQB11Nopgn+S33tKOukVb
         QD11OA//DcEyuTNzVz1ITFuq0k60ZHnW5IHDLalQQN5rc8jJenLGD3f1LVrhvF72GuzM
         iFABHYtdMPML5F/Jfvt2ayr71iYu3JC+XYWA1SFO32d3fpr0RyfeCZjXpdrkBD2xay69
         TsviC2SrOqOMkfFBZhzqQGvtmeM2ALnw3cnOpWyvnHoZoyin5hpNWM0sZ5WcfhVy4dLZ
         Iwuw==
X-Gm-Message-State: AOJu0YyD9EnwpPvE94JHY5XWJ7FS2c2avuaipsOxz33rCl9D1Ya56+kB
	D+tNB2NAUoKScX17lx0oTpwGnJO7Q7cHDzoyx2U=
X-Google-Smtp-Source: AGHT+IE1gCkG1CSEBCjfJabiMmOzvsKQZgyx1j49kHu7ZG7qan3nMaJboWZ/1JIvyX7uw69icW8Mag==
X-Received: by 2002:a05:6512:2350:b0:504:7cc6:1ad7 with SMTP id p16-20020a056512235000b005047cc61ad7mr13886759lfu.1.1701341147404;
        Thu, 30 Nov 2023 02:45:47 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id q19-20020a194313000000b0050bcaf09340sm133119lfa.99.2023.11.30.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:45:46 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.7-rc4
Date: Thu, 30 Nov 2023 11:45:45 +0100
Message-Id: <20231130104545.62755-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.7-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc1

for you to fetch changes up to 477865af60b2117ceaa1d558e03559108c15c78c:

  mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled (2023-11-23 18:04:17 +0100)

----------------------------------------------------------------
MMC core:
 - Fix CQE error recovery path

MMC host:
 - cqhci: Fix CQE error recovery path
 - sdhci-pci-gli: Fix initialization of LPM
 - sdhci-sprd: Fix enabling/disabling of the vqmmc regulator

----------------------------------------------------------------
Adrian Hunter (6):
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: cqhci: Increase recovery halt timeout
      mmc: block: Be sure to wait while busy in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery

Kornel Dulęba (1):
      mmc: sdhci-pci-gli: Disable LPM during initialization

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

 drivers/mmc/core/block.c         |  2 ++
 drivers/mmc/core/core.c          |  9 +++++--
 drivers/mmc/host/cqhci-core.c    | 44 ++++++++++++++++----------------
 drivers/mmc/host/sdhci-pci-gli.c | 54 +++++++++++++++++++++-------------------
 drivers/mmc/host/sdhci-sprd.c    | 25 +++++++++++++++++++
 5 files changed, 85 insertions(+), 49 deletions(-)
