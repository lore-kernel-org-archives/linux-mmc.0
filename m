Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04323F9FB
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643598; cv=none; b=Q3/y7UhuOG1BdfkA4RQZSfW/HGpCkVTKqFaVvWI4eE9QwHCkgjeefWduEQSX/4whRNeg56Co54pfOTIYdN22GAe2LaOZMkEWtnZmXnZQ2zNi8gdO6+dRmhq71TOrwawAlogYpEJOp10wLj3nApvUHow8fa1pKIxZiOM5oMfXqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643598; c=relaxed/simple;
	bh=mktvsbnCgQB7SIyVywpazCEAaoTh++8TaCODy4U/W4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdJ9IbI1nGcIwHfZEupRsQEZ9Xcb50aXPc8TjN1m5E22CROILE4fpO+KEvGum6BBraCkoSGgZ+nX6CDvDt1GzHOP8rodTxU22KFTE/mM6Z1u+IqqqfhVZUDQTXnfqkmp/Bnf8FchifCO/okcv/60ekUKksDcEHjp+O/fToJuVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YrwdFD6/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YrwdFD6/"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3497888a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643595; x=1763248395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibTL9LFMoaISY8GQE81Db1c/RUt2bsWCzKF7aX8X54Q=;
        b=YrwdFD6/qKHTg4gnVS1bpz7IsDR2iJ2lhqOMz4GhWMirYMRGLmYDrgkseXccCHCndF
         d/CSpsm8kOoNwhHXOPuS0CgpmIbjPARKJ0ZDFu3F8Ggb5c0UI6oOPBj18iDT7zk9berG
         q2VUdk6lw9EuxSUEtWdCGM4Q7bLyoGsXCSLiDsmJhUcM5iOpltkK5fgAPvKpUi/BAFvo
         0HVaMvBq+4SkrEID1hE6tlmSNwgXJK7X3V1zVxK/NWOkEcyGgcJX10Fyg05yqHKqrXHm
         ZbLiHZjOKwT1Ezg5gHl+po5ARXT1SoCW1+jGrSgIExNOBQqqUXncIuqrhVUXXBGOP4M+
         MAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643595; x=1763248395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibTL9LFMoaISY8GQE81Db1c/RUt2bsWCzKF7aX8X54Q=;
        b=EoT7pAY6MksIjTDO2vz9aFB+aRbsTHajYX+KV80jxdXQ0e4OXyMZ7pCRpwjCsKTDno
         aGjUc2c57c3puzfkPGHKG2dcBPRNYSTv2vhuYQF1830ZDbZH+u/iqos/o+UEWtzWmwEU
         ukE7eu0QQPMnFDD/80mq/VHnJrlf6ISskftXUDMGOUEmqb3Gl+0sqqK2x5RRP7cy/DpC
         4zDUSHnz3x/sNmpv9kOAgsFAx06JBgvWx9BlXpgmK95kjnhleZGOpT9HHFC3DOIsW3HA
         1mEUJISY2BiSK7Wdh7/lKZzpuBv5jJh6e51ozX18WLbgsV34LZR85Cy0qXm1n1/P+xH/
         sHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaRnbsTlaxk5jnUE8Hu8OQ3qAG/Djb628ScPTrPr56tLMpbBDk2waUxQQR2AxIYraLF2yVrKqYhuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoxgxPZBN8L/FdrE4Il1uA4CU1cxSLfL+qSC2KNUvOZHnqa/7
	kUSxLcrMpou5+/3FAY7N4AtF5BPC8IWqaQp+abILo5G1FOuLgcgl4Jec
X-Gm-Gg: ASbGncvM5BKmZFUqm8TeBJgLWOgmaSLuoCEKTYUeOAUvxJ3wut5nCOpaj0ESavJC54x
	3mp5koVjlx86uODTHd25zMZIKE1FBBCxtDtiHnarlq2umj55grEGaCCE8OHhmFX0EzWTy4iRs82
	rZg3eyy2vjdbt98btGSMiYghwenlqvy6Fnb8h/bNc8IhxIZPy3JNTPxDDi4Hq0zr0ndTKq9WkrG
	+iMepDogkQirlgs98FgyGzTRoQEztcK6c4pfOJBuVM79TW02xVjNWAJnBJuEYNCJVY9UjnAyL1N
	ITprwlgmSlpBFeOhQ0aVSIbD2CZePqFRVYOXUePQa0N3PMCSh4FsZV6t7TmyPYA6f5d6ocREVm9
	eSNkfLtNkJ6gg9noA4LxGZlYTD8eab+xWrkK4P80iQdRBNa95Twmn9/S5gXEYsazeAOe+GzVGMy
	1SodwWaHiopp+dqy/gIvGry/yhnGYe8hP8Ln4SvPtO7twmJfz3sXzzPzY9O8GrV5b7bFYdgSxY1
	uMtIV4zHEt8TTHC3/PjFbr+rpAKnaBDjwZsEHthLt8=
X-Google-Smtp-Source: AGHT+IHojjSOYkU74h70pOz5Juc0qTwy5Qm9aBj39UgCLbnQKLDh8bnfGClMfrPjx5Lm9oFsJdZQ9g==
X-Received: by 2002:a05:6402:40d1:b0:640:bc0b:887d with SMTP id 4fb4d7f45d1cf-6415dc03146mr2946757a12.2.1762643594925;
        Sat, 08 Nov 2025 15:13:14 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:13 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/7] mmc: meson-mx-sdio: Various driver improvements
Date: Sun,  9 Nov 2025 00:12:46 +0100
Message-ID: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains patches to improve / simplify the code of the
meson-mx-sdio driver by:
- using regmap for simplifying register access (patch 1)
- switching to modern clock functions/helpers (patches 2, 3) and
  make the clock code not interfere when switching to
  devm_mmc_alloc_host() (patch 3)
- making use of the devm_mmc_alloc_host (patch 4)
- using modern dev_err_probe() for better error handling (patch 5)
- indentation fix (patch 6)
- ignoring disabled mmc-slot device-tree nodes to allow describing
  all slots in device-tree, even though the driver only uses the
  first enabled slot (patch 7)


Binbin Zhou (1):
  mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper

Martin Blumenstingl (6):
  mmc: meson-mx-sdio: Switch to regmap for register access
  mmc: meson-mx-sdio: Use devm_clk_get_enabled()
  mmc: meson-mx-sdio: Refactor internal clock initialization
  mmc: meson-mx-sdio: Use dev_err_probe() where appropriate
  mmc: meson-mx-sdio: Fix indentation in meson_mx_mmc_irq_thread()
  mmc: meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes

 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/meson-mx-sdio.c | 339 +++++++++++++++----------------
 2 files changed, 170 insertions(+), 170 deletions(-)

-- 
2.51.2

