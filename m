Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C83222595
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479254; cv=none; b=MPIgLH/SRQn9jepsOb4Jz5VKxg5zKPLBqKJu0K4pFnS9fJ7m4RctI2a+acsAKnNTDkyjg4ySs6wozW/vvQgROxRAG/jcWSN9oYUr0uYU5ZGNHUbWn0NhnbcWU+2/pBnNngcGwRl9wFJ+VgnJATJEyCkMcXZ9tc41xGydQfa1LfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479254; c=relaxed/simple;
	bh=TMAuU4onZ/cymJIqOhYHnqnXdS4duBL3QBe64ptE4WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBdkFghCi6lP6caszLrxrt0XaYXxnlxZ+z0/bZI3noNACZ8S448ZL2O3+NDTxb5E8y41v6kjYC/KKuWBSB4M8Z1aGNhmvPP5pfXVnikybMFRrcFs+tZIAJMFoN1g7hTvXO9aRVC/CMu3YPl6HPBFhTAeaNxNIPas6ubwmEXjDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q1lWHOCQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1lWHOCQ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so976161e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479250; x=1743084050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVzbvi3/XOkK9yO+8BTkmB73EOh3os+jpQOtKlsdsjI=;
        b=Q1lWHOCQY33Aa/+3B6BQRldaZyHpuImNA3g9jUhdE2SkBpLJedbp+kAVzwCR5DS1jg
         n0YgSQPkgMvDqmCEe3rULS6UKStWjWRugpgKfVSkjMAd57oKyvsB4HdGGoiYIXcC1KUr
         sUrlQ1MJKu2DEi4pgBCu0mBd26oE8WQIRKwcIBbnIS4iJfa50DFjk07lCCIHboGFktz0
         1D9ykGLkVyGk8mv04EXQPtnVfEcvqaHwL8URKhTLsGsULURNxT0Qh6vJZyrUMkgZUGR4
         PsC7bPowtMnF4W9eha7ONc7mUe5Sg7j7+dvtoLkBMUxrgAncZeZnWHCrXJSBazbrJBEo
         cihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479250; x=1743084050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVzbvi3/XOkK9yO+8BTkmB73EOh3os+jpQOtKlsdsjI=;
        b=gRC+/GOHJUoc8MdVmzt0iDMbxrchJHz2nrYRolEvCrPfMcSgi/KhldM3M0PSyQ7R4U
         bp8v7Xk/XYCDEfwi4mncjUdA3gD7rdUbzPasWuDv+mMoUlY5B/qqlS8GSnu959eSZ58K
         +UPhOE9twcs+XM47mfLW28YgftK76znOS37FVBRNhY5eBnqBbkKTCaNnD1GqUIethZaW
         LNWkLPKI/z1hCRFVsEQ3xJHSggfYOekeLOBHod8rc/9SnqWFmvS4yEiMXjcgPTBEAnfi
         /6ptZf+kE4+uy4ulm19qi3dipEjJXjWJvloEMKzvk0xKPZLB//LnjH5/pProzSTUPrxv
         WT4A==
X-Gm-Message-State: AOJu0YypaK5exv2BNQ6ueimv9H/XbyLawm2Mq8u0e4XUAeON3E6ymUuZ
	6MMf9J1qyWEOsqu5e5Utcut4ogdRQTDfJjfyqIRGiFGipbH6JcXmBRbg0DzNT7V04HTyt845Ovz
	/
X-Gm-Gg: ASbGncu0tXHUTHN3VSRQrDxgvJYl8qufXZpIyZ65+ep2K8V8QmMfa99JV/RQSw5gTaM
	pTqHBGCzjf+8q2WiPOM7NDeAaFiV/RBpStMgB6dUSmNf1CWgkufrD5y+EGIoC3L8ffu7Pn9b6ti
	cqYf/jIuuDqf+9Dul7tW49155faQ0oltbWL7jWXGi1plRNV0F6rrT7hS+BSELhej9z6OVMQX6+Y
	D8y85oW8WhrMvYqo6xj0Rh/ReQTZZpq1yjQXiqE8GNTjEwVBXl+hTNFJD8bdpvLJciykCvaukxq
	KOGG1nAizZn6+wCk8jtXx6seB1usj7gtaootdWIwWKA4k1aP7U+U6fNak+Ci15b2JjmyWcoFOea
	3+ZBlswFSkerhEcY0G/Q=
X-Google-Smtp-Source: AGHT+IFMYBU0DIXrF7R99VRRvNyaKksRIT+6rLXREKORT7TWKL6TEFXo8/nh8xP6GcxkGQSqzFY85g==
X-Received: by 2002:a05:6512:3191:b0:545:49d:5474 with SMTP id 2adb3069b0e04-54ad062a16cmr981532e87.20.1742479248474;
        Thu, 20 Mar 2025 07:00:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mmc: core: Add support for graceful host removal for eMMC/SD
Date: Thu, 20 Mar 2025 15:00:31 +0100
Message-ID: <20250320140040.162416-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by Wolfram Sang and already discussed at LKML [1] - an mmc host
driver may allow to unbind from its corresponding host device. If there is and
eMMC/SD card attached to the host, the mmc core will just try to cut the power
for it, without trying to make a graceful power-off, thus potentially we could
damage the card.

This series intends to fix this problem for eMMC/SD cards.

Please help to test and review!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20241007093447.33084-2-wsa+renesas@sang-engineering.com/

Ulf Hansson (5):
  mmc: core: Convert mmc_can_poweroff_notify() into a bool
  mmc: core: Further avoid re-storing power to the eMMC before a
    shutdown
  mmc: core: Convert into an enum for the poweroff-type for eMMC
  mmc: core: Add support for graceful host removal for eMMC
  mmc: core: Add support for graceful host removal for SD

 drivers/mmc/core/mmc.c | 66 +++++++++++++++++++++++++++++-------------
 drivers/mmc/core/sd.c  | 25 +++++++++-------
 2 files changed, 61 insertions(+), 30 deletions(-)

-- 
2.43.0

