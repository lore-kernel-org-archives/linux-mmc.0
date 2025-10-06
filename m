Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE61E487
	for <linux-mmc@vger.kernel.org>; Mon,  6 Oct 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714636; cv=none; b=ufipPp5hE+5ou3Ygw2DNQG0AZ1QyItjNl9r1QZwQgPf0uyfqjQZFKPcfI+H/RKvIJ6SqqcU9Es0ev/7pyUoAXJWhG8brD7rT5tj6zXZCppG4XVS6aLCEmWqQWjsJcRAamNX/M7JTu9IdQ9rslyg2tzDbAH86vaxATgSpcfsO+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714636; c=relaxed/simple;
	bh=7XIF44/5gGwRTEbaMrNAG2gZYq540DK47LRgS+DB1rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkRJfkIzuC/zjwZFalJ8+DCDOzXuf06tNV2OxDje0imqQ+39HRNM04py6jn2VtK3BSiZyDmMS5Zv4nozb8X0j466+oTsaCskVq1voIAVnr9J3dSFOyOqMuFzjN9fZUOr42kSxZ3JIH5mX5z7lOD8KqBKn8LSnd2dSh9sJ4+5q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6S3rE6A; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6S3rE6A"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ad739e4ac0so710797a34.3
        for <linux-mmc@vger.kernel.org>; Sun, 05 Oct 2025 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759714634; x=1760319434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOD10Lgwrn8AWAzdnD6nabWHSwPb9bCgHWM6nHQ6wYk=;
        b=k6S3rE6AQJhd3JOyje/8TttYLxO/QrvfgsaFP03hYCiSutaLWrki9pI/pYNw9y+oxz
         4N6pV+LH3roXac+WUn5M37pVTJJ1RieVuPA3ETY7FPfqjS9oEx0xpOicJJuicqa9U4JY
         NzpZBEZF3xamASnDGe3yTDmIzLxIEz305e5cQv98tVAUVtj6WDbWW36hcEbl90jMWoty
         zAHqH7p7mwXxNA8equ/YePulwLK+q192tg9we6ngprcs8d5RUgtEP2DnfHvMxZ34k5Xy
         CYrag7qZF1UnhI27eLs3k1suzuYHoNsB/vYJx+qFH/05ioTpNEWG3Y2MTlKG0Rq0bF0M
         pIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759714634; x=1760319434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOD10Lgwrn8AWAzdnD6nabWHSwPb9bCgHWM6nHQ6wYk=;
        b=ataTP7PKfEL59VHhK0SatnvEsI1cW7BiHD1BjzVGy5W0uUC2WUuTW9r8PaG3QOH5Mk
         kBNZEjuNW6dEuEwgVfXQttpC3gdMNJPJ61wV06HVoNg7IUiHlF/82RtanUipXHiDpyvy
         Jvwv20BPnxqfmNM+dPzxIA9A0ZWWLEhoE6sjE3qOd2jKNyEXOC/uPWY+E08EmOjfZHvS
         dcu2Hyx/fFcYAmNd6Dldc8FvWmudN90L2aO38w+K2aSmzjVZDRiVqsZUu1PF4z3ZYzJS
         96I2tNpeI52J5dp3CsJlyeH1wfm9JQ8aTSvzMHHD9LTxFUbv349k9wmaCanDKyRZJwbK
         TO4w==
X-Gm-Message-State: AOJu0Yzx8zS94xvaITgGPCMsxEl5ATNsho2SVQsOjGi1s8Kl7n4kQXkx
	oMzPROTv/R7PCuA8JB3ybKqaEDO8iY7MxX4nn+rv4x9eQcqYxxyiINqH
X-Gm-Gg: ASbGncvTLxp9PvIfgFUsIucihI9rnf9R2bIpHDQ19Sy4WJ8h4MTuAGMrc5s1eosh+0b
	gwp88I3FYuzAm1xtSesF7mWnvnFEaibwniMRGpGEFHcklqCic3aaeUtJ2GeJI7a4AIlE9rm7WeL
	AX4MAJLO11if+SqkSTeLX93TqPkjOfDusEmJS6xgc38gkuANxXj6vOpMnYfLDv0Unf91ifwBf5Y
	R0S+Po9NW7eFasVCfO6pccNc2kLTOmV6+rFO2GF6WgMj9YniQFsyX1V91vwNvH70j1ImuLW7dFY
	Ffy5p20rD/NeHpzIbxgpPPmUk7XxUgKDWutrp+QyInYXMfawB0gT9dp6i9yHS+aHU2WXmh6hG1g
	Hru3QkRBNpVjaaaeKQWPAYsh8kpqXUbW5O9Y7rMxRUG31zQomPilBV+8Y3RwSRJZvby/b52YnGs
	NDInow9y0=
X-Google-Smtp-Source: AGHT+IGr16eJeablMekeTSudBMKT8PHWiuWpSA3M2BNrateERVo4Ff/ryPB4wByz57Z3USJjxjUSTg==
X-Received: by 2002:a05:6830:4108:b0:746:f391:9d4e with SMTP id 46e09a7af769-7bf7754a120mr2937393a34.6.1759714633799;
        Sun, 05 Oct 2025 18:37:13 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcfb69sm3462870a34.13.2025.10.05.18.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 18:37:12 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Garofalo <officialTechflashYT@gmail.com>
Subject: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
Date: Sun,  5 Oct 2025 18:36:58 -0700
Message-ID: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds a new bit to quirks2 for disabling the bounce
buffer.  On some hardware, this is required for proper operation.  An
example of such hardware is the SDHCI controller of the Nintendo Wii's
"Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
Wi-Fi fails to connect to any networks.

Patch 1 introduces the new quirk bit.
Patch 2 applies it to sdhci-of-hlwd.

Michael Garofalo (2):
  mmc: sdhci: add quirk to disable the bounce buffer
  mmc: sdhci-of-hlwd: disable bounce buffer usage

 drivers/mmc/host/sdhci-of-hlwd.c | 1 +
 drivers/mmc/host/sdhci.c         | 8 +++++---
 drivers/mmc/host/sdhci.h         | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.51.0

