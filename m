Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F59374C2
	for <linux-mmc@vger.kernel.org>; Fri,  9 Feb 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482692; cv=none; b=KFU80Vyj/Lo3jdchgOb6pNk0VARg5TP6Tgz+7pfug0eXHyMOa5427T1jbbRZsW5uJPduLN96XdDB2blsFw//ziLisH5ysVmMvbVP8ORD04n1Rd97EI/Rgme/IvOrsovhI2XqifVsQ5AAs2XMqzvCop220LVw8EE0I0fkW8RktNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482692; c=relaxed/simple;
	bh=Zdpgu/KfxRW/07Y45zEAl0PX/DBgzD5q7Z0qNSPz3+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kq5+gyR/dadsxzS5q1XHJTXZZUSMgBHO0p0U/T8f87PWVEq4FGFuPx4bn39bonI+RHdo/U92tBMV9t4ulT9oZezvJ6Mwo5EHHSssyPgYITBZV+sNEy1PnlJLROIPui3YvZ7NwlYr+ySlENKl3/3UdGNnFVTatezGNhLO7Y1zzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWUzQ5tK; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWUzQ5tK"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5101cd91017so918504e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Feb 2024 04:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707482689; x=1708087489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TlEqgyi0OGXzcn1PwHtSqp8m9u5561K2msG1/ytYLNk=;
        b=dWUzQ5tKUY6zFv6xWxgW7dQnkdOrvuNrHT0GkJIxVlnVziVxWW12E3f4/5GsOlTnDH
         3ja2Dp1M8cr7uWLU1zwH1FL/hhw9AIL9qg3lheK320KduZ5F5zmcUbD1ZCubPso5JXgk
         sIVtz2VqBJKTFUdst5VSlMXlheauIMw1fEPaF/8bytNRyFhzPE+dM0N+CDtTbEOFysSO
         8/O+CnNSQIyZL5HsJcXOzIi0ba9WEoiqDTLjkaFgz0iumyOIoydYcQbt+U7lQpVtUVL7
         gsQKoXyGEkSjLwYgZKh8hUrl2jvuBSCdNfCO4YuqTBDD4N7HX7V0GqwRHIW5VsZsrifP
         +bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707482689; x=1708087489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlEqgyi0OGXzcn1PwHtSqp8m9u5561K2msG1/ytYLNk=;
        b=suyk7VX6+r1U7s4twtPskYpycGtb13z/r5DrGng7T3VTHViO/AnReiQHTruxAniB+u
         WgJflQ6Tqzs8aEF/03DK2a2u/2vqH1qhbzsSpDEr8pTImzsVNMIgb0uqvBU+JG9+U2R0
         FQyDcjA5H3KvW1u2PmuxRJXKLU7LTgkUuQQtFprOoV+RT6Z3TChMxA/Cglqljfih2v1o
         13E3+e86E3mEQxLsiJ24tvzRNoT2gOSoh97Azjhxv+WD92+sbDpuTqluSFBrTsDYwb4Y
         yjAqup2c9DWptOFg8TRS0V4cDSBXU/ZpKZ/9kIOhxsJEVUwZpiBP1xCYqO7RS7q90YB0
         pTVg==
X-Forwarded-Encrypted: i=1; AJvYcCUqfYK+Oq70cWt+Td7WBcs8O14nM9hpZBdRrgVjx6kuv8+klm2Jjw+taljMM93MMhiJrFb9s9vxQDyomRpJUQ8/oQPUbQeTbfJz
X-Gm-Message-State: AOJu0Yx0qr1B3UlgImz3f32n84FAa9e6TH8a71ikcyQ3mvOm4il1oyAC
	97cCNK/Hvg/XB3h/3zUYxZJHUuIhkO9Ms2Gn63R4ijWRBhQ4ODmL07DWhlM32i0=
X-Google-Smtp-Source: AGHT+IFK206dvWBZ/pbMve398dXTziFuzWXtfasSzN7iJszxOwj0uvEjvt+tue59nM1mTeheiwWY7A==
X-Received: by 2002:a05:6512:3e24:b0:511:5c98:acd2 with SMTP id i36-20020a0565123e2400b005115c98acd2mr1158246lfv.37.1707482689003;
        Fri, 09 Feb 2024 04:44:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCSvO/UY6dZqgxdq0Vr2KxSoAJISvhfUo+2FcqxKxV50TLR8Li5TLAaCIiYk0qK9qZ9YQ505/i+a+Hfaz7CFQYNWsP/tcw9OXOUz3yi5zJzeVKg2APXwW3fUeGn66kOuyjeocGJ7V6
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id o15-20020ac2434f000000b00511337cb46esm282528lfl.108.2024.02.09.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 04:44:48 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.8-rc4
Date: Fri,  9 Feb 2024 13:44:47 +0100
Message-Id: <20240209124447.768859-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.8-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8-rc2

for you to fetch changes up to cc9432c4fb159a3913e0ce3173b8218cd5bad2e0:

  mmc: slot-gpio: Allow non-sleeping GPIO ro (2024-02-06 12:35:44 +0100)

----------------------------------------------------------------
MMC core:
 - Allow non-sleeping read-only slot-gpio

MMC host:
 - sdhci-pci-o2micro: Fix a warm reboot BIOS issue

----------------------------------------------------------------
Alexander Stein (1):
      mmc: slot-gpio: Allow non-sleeping GPIO ro

Fred Ai (1):
      mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be detected by BIOS

 drivers/mmc/core/slot-gpio.c         |  6 +++++-
 drivers/mmc/host/sdhci-pci-o2micro.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)
