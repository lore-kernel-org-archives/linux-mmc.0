Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B76EEC8;
	Thu, 13 Jun 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242933; cv=none; b=IGlMvcdcTEi176vYDsuerWRCKPgK32O9klVZEBsqMkJQXFv/nvvMsoSnVLOaf/UVHm84Q6ni1W4ux+O8a4vWPbM5jEMDuSxwwqUrVPx8EQMiQ6LQLxfG+GVA8fMmqY2YhV4e4syGMUSbaXVMNLNYp1KYgucUqu9Hh5+hKnNvR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242933; c=relaxed/simple;
	bh=2EH0sQami9MW1NXrbuTBEUUdS+8DQ/rP5iEvbuNGQa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtkL78KvJ0kv87NLQSRqMj8gDxLVnq0QobFU8DifEVgBLUmuEfgHSiVLRzrLZuCN7FdwUa6ZA5OBpA4/8xEEyGbq0l9FsNDqqnATkVmxoTLhER8uD7vNm4gE2I1tFodRPjXx2UrlJkovHE7P/8aiU278UcOirH4QSqsSuhQEIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k84xrotk; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k84xrotk"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6fa11ac8695so269082a34.3;
        Wed, 12 Jun 2024 18:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242931; x=1718847731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUzAU/BrlHlfOD+rgZpVm4xqTlwKqA8+DOrVtmqF5SE=;
        b=k84xrotkgmHKENE6ZSONU6Yl9A6+yMsIqSsgudapsAsBTl0pFnGlDwFMsM2DTaEK5P
         ajJGYP6IxhkP3JFLDiv05K5DjkZ4OjkMGz+FTFb1pQo1E5hr2LEXJnhpxOO5XvrWyRQy
         D4UpcM4pg/WHIhHAxDlibfghQNx3I8kV4YGqbN0n+QFpvSQAnuum7CeFRsb9wPwz5dkH
         TgI7njCBAPiPlU6vZMgA8j1k62EFB9IuRXtHKI43/dPJN9P2si2/JRqejiMrb97irF89
         YLmvKZXhL/KS8B570YYdarcnUJhKb86qlIjTTNmtWrEspBQ3BaFmngf4t+aSQzbIWI4p
         ezKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242931; x=1718847731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUzAU/BrlHlfOD+rgZpVm4xqTlwKqA8+DOrVtmqF5SE=;
        b=s0oCEh9kG0ZLdCiYebDECwFMuHOhPOp727MlgfxCBmqWuNGuD1c3H8t6arS7mzXaEu
         iZ5jMNEHJZkTPwbGAmN54b0Az+odglCIvGPU/WBYwL1ZDa1zl04XaAHAUGUSOghRgSkB
         l/fj1VtEAHRV6Z/pgndT2BJmyo+f8H61gcSspQQJJRolRLuwymrRcEv2LdpjdDE9gjyX
         eKHpM7Tky3ABplG3ZV9jowjan9rIofKPWEr0hGxlFVZNxvIboi4sdPr3FbHKOH3GDQpP
         YNZvQRyX+C3RAtvKZPz0pSTAT4mkJMTvFsqI5wM0vWRpPEicu0ST6NSbHIP5yu+KXvJy
         Qzpw==
X-Forwarded-Encrypted: i=1; AJvYcCXfKngDwff2JZ2alpbDhIZ50iIIvfMjfVdVy5W2c+VR8S6FXcMXnJilhUhn4dSSGBd2MC5k8PE67LDTAG711rVlzxrMKESmXU/fFXKkND9rFxp8lGlAPLXCvwvie2RyF75nm7TyWE9bLneFSctoV487WF1WvydxEOclMY7bw9t+D86ynw==
X-Gm-Message-State: AOJu0YyqBJRqwQhibzXAUyBklza250s45BTY7DGAqfLkRaA30b6pcTfp
	BvznGLuq3Fw8ejSL+RHI5u6NOs/6k0jh8iWWqjRyZ7ks3rmCe8i2
X-Google-Smtp-Source: AGHT+IH5dSdRTznyVmwyCJU6VsLfIEgceO5LXu8jpS8i2aLwTKp7FX33AhMu/ZrDJE6B9QzAm1l/eA==
X-Received: by 2002:a05:6830:2044:b0:6f9:3a42:b8a1 with SMTP id 46e09a7af769-6fa1be31d29mr3410321a34.6.1718242931124;
        Wed, 12 Jun 2024 18:42:11 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b755c2bsm75040a34.69.2024.06.12.18.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:42:10 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 0/4] mmc: sdhci-of-dwcmshc: enhance framework
Date: Thu, 13 Jun 2024 09:42:03 +0800
Message-Id: <cover.1718241495.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
existing driver code could be optimized to facilitate expansion for
the new soc. You can see another patch [sg2042-dwcmshc], which I am
working on to add SG2042 to sdhci-of-dwcmshc.

By the way, although I believe this patch only optimizes the framework
of the code and does not change the specific logic, simple verification
is certainly better. Since I don't have rk35xx/th1520 related hardware,
it would be greatly appreciated if someone could help verify it.

---

Changes in v3:
  
  The patch series is based on latest 'next' branch of [mmc-git].

  Improved the dirvier code as per comments from Adrian Hunter.
  Define new structure for dwcmshc platform data/ops. In addition, I organized
  the code and classified the helper functions.

  Since the file changes were relatively large (though the functional logic did
  not change much), I split the original patch into four for the convenience of
  review.

Changes in v2:

  Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
  patches at the link [2].

Changes in v1:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-mmc/cover.1713258948.git.unicorn_wang@outlook.com/ [sg2042-dwcmshc]
Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]

---

Chen Wang (4):
  mmc: sdhci-of-dwcmshc: adjust positions of helper routines
  mmc: sdhci-of-dwcmshc: unify the naming of soc helper functions
  mmc: sdhci-of-dwcmshc: extract init function for rk35xx/th1520
  mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc

 drivers/mmc/host/sdhci-of-dwcmshc.c | 598 ++++++++++++++++------------
 1 file changed, 339 insertions(+), 259 deletions(-)


base-commit: d6cd1206ffaaa890e81f5d1134856d9edd406ec6
-- 
2.25.1

