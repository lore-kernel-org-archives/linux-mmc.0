Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935211C8FAB
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617702; cv=none; b=U5LIIeBuvBPsixn56YoH5/gGCJpqBoBek9i8PHQYjsWkh1jCNVQ7MSXoSpHSxvAqE2/U/k+9KPiTTA/VV1lgS+qQP48xzfEo7fQm5S4sM9EfdLRl047BotL1Sqg9sexPPbIUFbGgG7vVQVGmzHWtu/FBsQuzTBZIBP6kPqtFCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617702; c=relaxed/simple;
	bh=wbk5c3ZPDtOemUDTmxUQ41pcY+yxLgziWxiOC4juKNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bqEZIh20kIs3Kg/JS0Dobu/fRYlSixB10Ah5Y3PNSFOz5ATFLeb6SbD0ld03BR2P4gElcr61l8too6eNDqfFX70yJzrdpN2KRUF0j82gpO+u5RHo2aid4oPolDfOXt3gMHvFSFzi4Cju390qkKXyTnheJFcH0cyzAf+AY5q8GW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDachOhz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDachOhz"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53346132365so1977962e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2024 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725617699; x=1726222499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+RZ7CTOMIGwkZYZOKOaC4ouB8JKVAiXvcgnN4UjbbG0=;
        b=rDachOhzXRv70N1CZWdBhxckavGOXBLX8l60aCAKp293euM61EnxiEFbeDNOCxby22
         Ks09THjrYT8zbT8MeTZu+s9E2LHOMk77XhesSj35rSnT7p230lRT8xWUY+b4oyO1/BpJ
         AdUG1QJpBsAaWSmz4/Kn/oPtkBeBsVWlnUfZ5B1UcX1XNO5smk0Oe38rfCLfhkqX/RXf
         Wd3webpDcrK27ZPQex6swtbbvNW3R2qiZCnai5CgHP3Ad2gAk6idW/e76YyrQuOqdV4p
         s7TPBV5MSnQPDkSBTLPDp01u9cSJZTfpQ/88OOIca7tp744l7uxqUpM91nyRr3Iod6TF
         4uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617699; x=1726222499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RZ7CTOMIGwkZYZOKOaC4ouB8JKVAiXvcgnN4UjbbG0=;
        b=wDRMvZ/kiq9giV9iiKcowd0IqvJb1TQiRJ0KV3Kg/Ak7XemFEYyth1yRONUFM3EILS
         lpNLUSShEii8cnuAchm9EVw1Y2E5SOo1ew/A1SU6dvmuEwSm5cWqGO5KWBWDDQ3XaWWc
         NdOVPNfYdy+Pims4u01Ho2XOUyNiZmI0VySIB0DioIX7bPoJPgEc9qvev7Fmg3+MBy5X
         Yhrla8yxvnqh0JJkAq/YRyA+XuBElnxYC3tfnrjAylCV/4+xRxF1+aaFxkA3pxxi5gUy
         iIv5KgXaHzt0nxhgSxdGwcuzCjEjWRgZopisSPexoeugZXG+2+TzlAmkO48fl7eblmqr
         nFlg==
X-Forwarded-Encrypted: i=1; AJvYcCV0hqkX1nmFP45K7p7DZjIN0yViM31Q6BRNiFadofsyVBI30U48gNQvailMeT6gDb4iEABThzelZ7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrdt3SaPOSCqTQ0BUTA/V2YcRgr+YxEAOA5jZLa0xzW+hRIyfa
	+otoUjsweYj3ow4QPy1SQokDqTbH25xkPtWKXSFZrFU4cvgOPvf34RJ+Z0IPj/M=
X-Google-Smtp-Source: AGHT+IHfAyHUNM1NELI3OmTm0r5vomgEimByZFF2Y77yBcBHbIeBY4L/vPo3i7/vbYSpVqnm22Pzaw==
X-Received: by 2002:a05:6512:1599:b0:536:55a9:caf0 with SMTP id 2adb3069b0e04-5365856cc8amr1250895e87.0.1725617698306;
        Fri, 06 Sep 2024 03:14:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53652bd3dc3sm391663e87.29.2024.09.06.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:14:57 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.11-rc7
Date: Fri,  6 Sep 2024 12:14:56 +0200
Message-Id: <20240906101456.198887-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.11-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc5

for you to fetch changes up to aea62c744a9ae2a8247c54ec42138405216414da:

  mmc: cqhci: Fix checking of CQHCI_HALT state (2024-09-03 14:20:51 +0200)

----------------------------------------------------------------
MMC core:
 - Apply SD quirks earlier during probe so they become relevant

MMC host:
 - cqhci: Fix checking of CQHCI_HALT state
 - dw_mmc: Fix IDMAC operation with pages bigger than 4K
 - sdhci-of-aspeed: Fix module autoloading

----------------------------------------------------------------
Jonathan Bell (1):
      mmc: core: apply SD quirks earlier during probe

Liao Chen (1):
      mmc: sdhci-of-aspeed: fix module autoloading

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

 drivers/mmc/core/quirks.h          | 22 +++++++++++++---------
 drivers/mmc/core/sd.c              |  4 ++++
 drivers/mmc/host/cqhci-core.c      |  2 +-
 drivers/mmc/host/dw_mmc.c          |  4 ++--
 drivers/mmc/host/sdhci-of-aspeed.c |  1 +
 5 files changed, 21 insertions(+), 12 deletions(-)
