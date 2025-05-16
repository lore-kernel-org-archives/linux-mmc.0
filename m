Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179A1F4CB7;
	Fri, 16 May 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387651; cv=none; b=ef/FZGPkjIRPVpdIkwUZA1dI8MxQikPHvTukSd4U+o5P96bU+6XHiOF5a9j9d85bQ2D8gzHirgsXZPNB/qNXVYcWyt1nHy4lR8XTY3Sjz6fgKl3Tsk2ok+4SsidfqqlPBzElSmifZ0rQ9la0lw57PpRQAF5LJUAlFRnCem+Iklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387651; c=relaxed/simple;
	bh=0FalLZtJqVqZQ20QN+F9NvQUvPg5W7WqNoc4cnl7tUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJ44yOZQO3A+OInYX0Yb0bNGASKe3evaIw/z7XGXLQVwzfALMAtknN0lhZ607JRHTvfRnLFMgfAMJvkZGozDE7W+6A3gRwKj1eUeQOvr9amslMAEJqzEkdYWL2qkc56OOjsp734q/Chj2z7gdD6QfZpwfSiyVaNimf+ku+cmNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIrLetG2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIrLetG2"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26f5cd984cso40727a12.3;
        Fri, 16 May 2025 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747387649; x=1747992449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXza/PerGJpvSSZrvI2xi5TuRBFtzTjNS19vY+USC5U=;
        b=IIrLetG251GnCVdDfTiqK3vHMvRvCHYXY2T7EGDOWuqt0PI+2QSHgN/CgGvPLMTTJy
         d0Nzl2Lt/4h69Va8HOWZc+orIDEN3db6jv9Uz7k7pMqJEElvHbfWAYOnW1UDl3Ap2HMT
         YXo+K8AE5rB+8EZECdYr0pZ1mJ32OtUGjj5vvVQ58sR1P+JUkJ4OvtBvWPBS3Qymek84
         B9j2Wgc8frrXo4KyWYWZbSOf5yfjO9Fs5ZCXL4sHVC7PX4YP5bkru/ecf7/bAKwCburP
         dvf3/kBWzjmS6TPdm81zKk8HK/BbNC8k8KViac9sbmAnv6/N2zf2hdfhFkhdq2YhRUnr
         7Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747387649; x=1747992449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXza/PerGJpvSSZrvI2xi5TuRBFtzTjNS19vY+USC5U=;
        b=rbJ4VxIzpwFJIWosNABRWDAUJdW3fw67gYxDfX5gs7VnBzpbWcTYS+N8wU/JhjEjpB
         +/D4asfFe2/CdhyzYddp2/9wll07ax4UOmvsG2HjuEaUTzod0dreYHDEpUOYuzUWV4cI
         OIX1lv8F53bM7FzrENFbG7oZ04KPTc+KYm3Ejuk1LiPF18Y9SIdxZduRJsyY6aransHA
         8POrEh42ffY7BmhPHQGtO07gtMlRDQXjTeyBl8yEJvU7ImNBuf4tb4V80hsX/hAdJUqv
         7CZtke7PMnufA4VaNIL3izgYNWbqcXF04PJlIBK/UMgLnt5na2Bl3Sh0TNzWmN423vD3
         iD5A==
X-Forwarded-Encrypted: i=1; AJvYcCUEMxuhfK+DDk8hyd9w6QZmPmMplvadKSm6Dr14KpGHysHf8y94uk/m0Q9AIzigKFNv7tb1xed1ZTiM/Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFfIsFTZ55Xk9hj8nlU3Hhmz8bu/Arw0xL078sE3d7VYI15Zh
	bzf09HIghLrKZk/xRjbM8RShZGlR9Y9lJyFPwiVYbLwGCHeb9wjZjU6R
X-Gm-Gg: ASbGncuGc3KusGO3u6oHRZdT6f2Gc/Sje6EGjdtJp6BAoJYd9dr7VwQD6i2NcthJdGz
	fPbUVyDlL8Oqetd1uXs+jwqDZ3i2sdjPukD7Yg2a9acC2vpF4Lec7uwXcmQG0SZJ3Mu14D822BE
	5BuO++avSmx0CFS+4QH96pAVWPdtNtxogm+pT65eLdfPV4v88N5ZY21+QWB7krSaD3kS+SGOYTL
	KAr2VuNZA+zEW3+lsxnGkvp+n91Qh0CnrG3irm52PDhqiGkpskP0FTWa/sz8nj/bBN+hTTewTB0
	gmBqmXKcPupLYyvSGK/U9GRLQkTNUB2mdwDr/jQJVlcdFv7e8yHU4eV42YU=
X-Google-Smtp-Source: AGHT+IEaeIyyzCvXLEV5h02Dm584y4Mpj2so9UbjQ+L+jxdvBczUKvKSTrI5HHf+f4AxTBBrnQTItQ==
X-Received: by 2002:a05:6a21:3990:b0:215:da29:149f with SMTP id adf61e73a8af0-21621934da6mr4178730637.25.1747387648614;
        Fri, 16 May 2025 02:27:28 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:896b:66ce:fdf5:6801])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a229esm1097876b3a.161.2025.05.16.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:27:28 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1 0/2] Adjust some error messages for SD UHS-II initialization process
Date: Fri, 16 May 2025 17:27:14 +0800
Message-ID: <20250516092716.3918-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Summary
=======
It is normal that errors will occur when using non-UHS-II card to enter
the UHS-II card initialization process. We should not be producing error
messages and register dumps. Therefore, switch the error messages to debug
mode and register dumps to dynamic debug mode.

Patch structure
===============
patch#1: for core
patch#2: for sdhci

Changes in v1 (May. 16, 2025)
* Rebase on latest mmc/next.
* Patch#1: Adjust some error messages for SD UHS-II cards.
* Patch#2: Adjust some error messages and register dump for SD UHS-II card

Victor Shih (2):
  mmc: core: Adjust some error messages for SD UHS-II cards
  mmc: sdhci-uhs2: Adjust some error messages and register dump for SD
    UHS-II card

 drivers/mmc/core/sd_uhs2.c    |  8 ++++++--
 drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
 drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.43.0

