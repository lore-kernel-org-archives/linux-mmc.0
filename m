Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99D227EB6;
	Fri, 23 May 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747998126; cv=none; b=qkaWD2DDw2wqneVIs716kR8OD2xZzOGEhA79FPFu26Q+3rdjRsDT7Go747ITSHTDshqyMMZY43C0sojjAY3oYahodhXfyVg+ok/HySClMVmT3nCQG6vBGcb/YSptBPFEpLT1/GRix/2wAZ3lbAXzFmkysBPQ7BiZ2YgocPjBmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747998126; c=relaxed/simple;
	bh=oK8kcyBlYBz3ybHiQUytvQOgSWb057uepYfZ6CQj0OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtniRwx48uvNgUIfb8YxjUcaTTBFxENYS4wBN5mrQA3GtAi3dsDNfVth3pz6wUKepvkhB5XI5lbUF46bBCEHUA6eBpwkiAm2BVBi/ecbno3IL+qsYmfdf8QSD+yF/A40ut1fird6mYaKsHZrVT0pxCrw9DSDNEmrNi+H1GgTikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dulzH9vT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dulzH9vT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c9563fd9so5076375b3a.3;
        Fri, 23 May 2025 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747998123; x=1748602923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ2+mIs8uPzJ7ZsXLZYegrGTAurHwah/NGv9gjuYun0=;
        b=dulzH9vTbg/gLhNBMdf42/SJHOM1z0sKumrtKp1vFxmDqRZmxUYw7m/TmW98bGXPGu
         Wd1e49Fbp0AIY+oSuGdJDe8+AdDPYWea6nVyl0U+T3FzIIi85hbMbF+POoh6gRDbjhig
         AJTGnqhWNHAZVdQR/XvLhs7FxzJgjjwd1AgJBy7y2VW2YbxoEZoTRDqc6hcOagn2f3ig
         QQxwE4H+NLv8EDTjBEFSXLUP7GipcwAUxrVfk6aLKjyIXfp272q/7Cfeow8RQCQ3qsCY
         2WfugV6fOmOkckko8uGPVNy3seUfcKGUT/LCI/k6RYCCpL4s3tg7nnf6CxaKsdRozURw
         Ic6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747998123; x=1748602923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJ2+mIs8uPzJ7ZsXLZYegrGTAurHwah/NGv9gjuYun0=;
        b=auyUqQgvadH16VwhlIGe6ABvNME8yRmXj6bFR4yNOQAB5J1j6C9FYUBoDzd+e+Kk7v
         iZuCz3O1Uy7mID90KH211BBVzP+fmViQ3VGsC/XbqUah3asXfejx5wx1TsfVbY5NcWeq
         yS+qwJAOMRd+rpnvXdl7gg9FEbtEvCC8sBP31dxiRO2Sbgl1ePhAKo5FIq/JDuXvp8vq
         cyupB1JE3HUXQxfOZKk7TZ15XL5Ji7BHdnywQMXD/4cPPcEhEGVvSmweRnZxqLdeinB8
         hn+UWv3L7PWggR964DbiGGdHOse4DkfPJjStXqwCD6WII5Kj6LKp/i93SVYLkfXGgoyK
         egoA==
X-Forwarded-Encrypted: i=1; AJvYcCXakyZVW5U6nD5k/VUn2oVDWCLC6BO7cYft1pbuv8gGddfg3IK7NMR1CRiiGjxNVstT3VgzoCc5SycgaXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykgvBgRJQnXq12OngQlmr8CHUtbtmOR705B9fZdXFwcMdJj7Hv
	BTdrl6cUw8OOcWxtHcCIbzpChzEPNO8+H24NrJG+sgt0hbYkZDTDcHSv
X-Gm-Gg: ASbGncswAxZ58ldSrQRyLFdbpV1DDn1PORODfaXN813lE6zTrcn+TZCDLecEkIVG5TB
	7SPlZcDVcScac3thiu8PB4gPTl5fJ6gNnjW4HUusTwDUg3B6HcpaqAds0KwnzmX0rrmRuv6eBQy
	35h3r5tttMm5NXaiEQpzBKA7/wgYxY5ClT6T6TGIxMXKSK/n+YBv44vDk8ufiUjqvZCvKzI+iO1
	0mqbdX6nvBi5sIgvM0PLOE3fs4wpnH15Y+Do4C8mAlhsILiXiEtJ6DiFmca9zVtWKMminawyBLU
	jB4VsfkWiLe08/cwPu/Ra2Mc4SPLKVIiB7fP7+mC7yiQsd0O5+AKm40GclY=
X-Google-Smtp-Source: AGHT+IGAPTJSWRII+iOwA3h9vpYFt5Cymn+ioghVZ3DtFaExYF6sAPO/OH+7PGNS1gPe0dF3exc98A==
X-Received: by 2002:a05:6a20:432b:b0:215:cf53:6e6d with SMTP id adf61e73a8af0-2170ce19ec6mr44330010637.27.1747998122900;
        Fri, 23 May 2025 04:02:02 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:c299:a1bd:2b60:56b8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6dc3csm12541617a12.24.2025.05.23.04.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:02:02 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Ben.Chuang@genesyslogic.com.tw,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH RESEND V2 0/2] Adjust some error messages for SD UHS-II initialization process
Date: Fri, 23 May 2025 19:01:53 +0800
Message-ID: <20250523110155.10451-1-victorshihgli@gmail.com>
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

Changes in v2 (May. 23, 2025)
* Rebase on latest mmc/next.
* Patch#1: Drop the use of DBG macro and use pr_debug() instead.
* Patch#2: Drop the use of DBG macro in some function
           and use pr_debug() instead.

----------------- original cover letter from v1 -----------------
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

 drivers/mmc/core/sd_uhs2.c    |  4 ++--
 drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
 drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.43.0

