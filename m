Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3989328B4F
	for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335865; cv=none; b=Op4FKCbhKENmZSKaaezzJVZ93TWz67dLTdWDMjWLgvbwvwtVbRJsZ7Opa6e0fu6oYszw6200UcTX2QzQUQ0eZeVgrwlTN1G+k0l3aPhDPY6x4jvX5CSXXfHjPd7aghQ43lgO+FY1fSu91lE/pbbrJgqBr2VtNjm1EA0CCoG4vok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335865; c=relaxed/simple;
	bh=CClD3gGHgSE9WiDA5xgEvP3XjTxdhAYAb79FUhAJwJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGV+kYfRncUlXCf+aQZX6MqmFADL492vryKnMYiaj/E4AHh6AK8GBX7D07YF40/VNTXVse/KPncmBdIOgbDoZOAcqL8a0PcDomt9q+93B4dt7ueM8YOj0IGSQBB/0m3EOWRh9RLRyFiP1wN37cfibN77JnWJKgoSoln94ba9ynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfXIN+0j; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfXIN+0j"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957753e0efso2072388e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2025 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764335862; x=1764940662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+40pgLxTTbVKO2TMnT/1chEfgR69+grqtI4gZ5t6XY=;
        b=TfXIN+0jkB0vmhl82OYvpgCKnZRRtH31XAVFHZI9STADhZmB9jz/aaGXFYgbwSu0gV
         uCw3Sq9GB4Ki9wsvPGN6nz5sDI27xtsAj5aoaErHL4+OJvEH9snFzJT1HGq+Qnf5eZoi
         9TJoAOWrBPjn/D9HBgV6HFZ1YUxK/H3xQ0e6qOMpCm7f7Ra1KwIp9OIUE8gIoEvjD5Yv
         wFKWktxdGS0zzNjuIecvDpAk90fS7BPHkYVeUVQRFMpuPyDZFZ5jLsZ5HU/zWAvZHNjr
         cx6ISAOk6TkKpE3egI56MSVWAKOGv8BuJo39uoZyUi625tHLSiLDuK8v17uIk9zqnIky
         bmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335862; x=1764940662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+40pgLxTTbVKO2TMnT/1chEfgR69+grqtI4gZ5t6XY=;
        b=lq8uafGSHlRkrOcGmHSVtapWx9+CF/n7HPaKxg0yqB7jmN9QItinuqK3qphNR3t5kJ
         +kU+g4TNR5OfnWd6NxFyLtMFaPv/HW5V1N3honai1k04M9eI6o7bQLUgKuGr14pVeaKM
         DL9EcYM1NEOpVJxmUdjn0QShsflJa3LWOfbNFwEwJ5UQ+XB1Kh8nX9VKrTU0aD/3Fjco
         DlNVHFriEQDASn+787dLcrN+AOe78c6GuwvHeoIPCrSJy8JGj/AcOGKT7bRRfRglkMa3
         3PbhnZwoCB69HeH6EfzMJ9Fnh+JnAYXKvXv7s5yDeRR5w6BXlYW0zVR4NWsd2ijTdIGL
         xpuw==
X-Forwarded-Encrypted: i=1; AJvYcCU90eXDJaN0O1jZsRnG/uwYQFGh4JCu+g7lbYAtszn0Dx5h+ZSybfB2uPRzol6DNKTnnBQ6dBiTiIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCWrqLLj/r1ydgIt2VU+YtAvueHxHpOelmk+U8cgB1BCb/GHK
	G2Mzb8RPAQkL3U2Aci6xyphx8+S8Szxt8WIQx+GVhCC/1hYTraaqMmeU73cr+aomQnU=
X-Gm-Gg: ASbGncuxfrC5m1JbLab1WxZHQBYEr45PM9HVf2AynsZllA0RoiEq02NdTYzwLc9DZe+
	af3XY1ItZ9f9l2dPIPeAQVj0Iv3KfLs0K3g828AULDWqbZxHyF2X1ViaA4pJdW+IEvn9h9nfOBF
	1xTZeELGWeZY+VtUjKSIFe9OazsgPyPjZUGK4AzAe6Z9YtmqrchSAF2Bp6vALYTJE0ldJ/Ya9Zy
	bGkz2leZdRFadjPSKM9Tz6apwHDnn3gjIKsGCdWROS7d23u2oPX0u/6Qfilcj29ZcgU8VQAa8kv
	jDylVc9yKeAdke9Ya1WJdVKnpvM11am4KV8fleN1bJ6o9zuN7VJbj6Psor+HWIBxFCzSrwC4jaB
	cyGq1vgnBbaJCxrVTAPboCgC+wYvwIY67wNs7XKv6+rS48voIdFZcxSl8ZItP+ZpxHjUlwVW6wi
	Q/XpziUDiU1Mc3wp+5HEY=
X-Google-Smtp-Source: AGHT+IG+XnRDBLockRTRbyezoVbWbMMgFY2sdwGcU5LYHucdilHQB3DhrdPkHGHLPkUYYTdcVBYA0g==
X-Received: by 2002:a05:6512:682:b0:595:8052:111e with SMTP id 2adb3069b0e04-596a3eda534mr10191611e87.31.1764335861583;
        Fri, 28 Nov 2025 05:17:41 -0800 (PST)
Received: from uffe-tuxpro14.. ([2a02:1406:25e:19ec:960:b9ff:34c:57a6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43ea8sm1195842e87.51.2025.11.28.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:17:40 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.18-rc8
Date: Fri, 28 Nov 2025 14:17:38 +0100
Message-ID: <20251128131739.8150-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with an MMC fix intended for v6.18-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 739f04f4a46237536aff07ff223c231da53ed8ce:

  mmc: dw_mmc-rockchip: Fix wrong internal phase calculate (2025-11-11 17:47:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc2-2

for you to fetch changes up to 747528729c9b6733839f9c95f300d5bef95ee52c:

  mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling to ip level (2025-11-25 13:44:51 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-of-dwcmshc: Fix reset handling for some variants

----------------------------------------------------------------
Jisheng Zhang (1):
      mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling to ip level

 drivers/mmc/host/sdhci-of-dwcmshc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)
