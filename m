Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD31172780
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jul 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795503; cv=none; b=kD7fN9116brQME6MHpfAIIzk8A93gw41751vquarjX3GrPErKO8KwY516G/wsL+6mmt4vf3koqTjejVdLTyZGTfGR8uCHDX0Cucq3tdb1TrB8y1tdknPC4i00uYam7wJ/wQGXq/z9un9vrDVLPw07E40H/enfumhJZ8fh1idD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795503; c=relaxed/simple;
	bh=+YtTtxGbBziQHCzvi1efpwobTUyygckgfzKma2ANla0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dV+HxVFT7MH5z583DtPsANIX8PSzcp8wr5oF10YOnkf6ndOkOA5OthsAYLACP/ClqqpayBSchQuv44K4+du+1f/UqM8yMHS9nWwpn91U4bZoR+EKhu8HYrZ3wuU+zBdMpt1sY2Smf1jHbKhL85OiqiTECRrrnef+H5Sf9ico63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=synOcHlc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="synOcHlc"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so3003730e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jul 2024 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720795500; x=1721400300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHPNyb/tJ1VWWeymMmdH4zoCwAXbQXpyF4Qjg1xHg1Q=;
        b=synOcHlcnT58Lgj4kLkkPAwdqnEZ4+c14qb0s41H+Pw7yVE9NqGUy+KFyNhvQcL/UD
         UHPTUSulAcv262xIu6NzRmk2ypx8jYUhYuTtunWAiLoRfNn6D5mXOSyC4odSpJtMUMnn
         qCGbi+FBQJALGpa4tzUeJ3lXvmUQFMiP2sHHCgZ3lwNAbv/4ZWRaeJnynHAyighvx+/T
         0t2tlPYT/9AaLFSfyofXfilRaOnP+2t+HzQZsTDj/OuO3AGFoVQCSdaxIYRyV/DFMdof
         PSlr9UR8I01QA9cQae/Rf09iKNG2z3/8uKiByWqSjRHD/Hc4gohUjgFdSmoNRilK+plU
         yd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795500; x=1721400300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHPNyb/tJ1VWWeymMmdH4zoCwAXbQXpyF4Qjg1xHg1Q=;
        b=hUlpCHkyu0o3tIi+8T2CChyWx0UTtpuA7kqmGrbxj9AphFzAaPzVPBFVU9lQc8j805
         4JZjK2vOsmK02v1yR+aybbDvj6lrB6nsWNmjS3UaMX+gLXK2ox8avb6d/MNXVWOgbvnI
         qNyp/Qf1LdNn/OhT7RjFe2VJPqIgS5lN8m2We3BiB4gQaqL7RNIY2Wr5Af0HTQpRWI3z
         2CPSUWq9JpzZzXC7O1UVpRUU2xw2qGs/0+Icpy2brSSHFEN2Q85u4yVsaj9LFFdcu1Os
         xQ4epwBmWg+53aoRuF0oIhuiGO0MAarb8iwZEtdpTgY+BFNM9WtRcH9aL0pHHwsyKE0w
         hKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBU6n4gCPRNwbyADyo5iMd2pgFWjttT/YTHzArrvD6LUgSzdYcLvzTFCq1QAatt+DOpiBwZwsa3JmEZf6IAu1UYK17CUcdhhLs
X-Gm-Message-State: AOJu0YzrDXoIEcvpUgRYLhmq/iBF1UKAvHGKg2o4U7JDVGfgeOLk0mBf
	PN535TbaBoH8O5LC9stQ8qYQyRx4ct4XJGEQ8wKMLfjC62Kb2+Wml5/IZqAVkDg=
X-Google-Smtp-Source: AGHT+IGzE/OcadTjDAGe2TP8Cuo9c94sqsqcU4eLkqtdPUECgrzsl+GfWxtdin0klh12Cy8BNzpK3Q==
X-Received: by 2002:ac2:46e5:0:b0:52e:7684:a385 with SMTP id 2adb3069b0e04-52eb99d3265mr6232252e87.52.1720795499568;
        Fri, 12 Jul 2024 07:44:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb906e739sm1293862e87.252.2024.07.12.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:44:59 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.10-rc8
Date: Fri, 12 Jul 2024 16:44:57 +0200
Message-Id: <20240712144457.169093-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.10-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ab069ce125965a5e282f7b53b86aee76ab32975c:

  mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro() (2024-06-20 16:42:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4-2

for you to fetch changes up to 16198eef11c1929374381d7f6271b4bf6aa44615:

  mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's length (2024-07-11 17:48:54 +0200)

----------------------------------------------------------------
MMC host:
 - davinci_mmc: Prevent transmitted data size from exceeding sgm's length
 - sdhci: Fix max_seg_size for 64KiB PAGE_SIZE

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE

Bastien Curutchet (1):
      mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's length

 drivers/mmc/host/davinci_mmc.c |  3 +++
 drivers/mmc/host/sdhci.c       | 15 +++++++++++++++
 2 files changed, 18 insertions(+)
