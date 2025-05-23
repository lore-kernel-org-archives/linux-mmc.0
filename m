Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8F2030A;
	Fri, 23 May 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996334; cv=none; b=Goftkp+AFJy31jZJcUw/UdCG2fqS6AIYhKCyRC7M78B6XzDG4zezLWqRhldta2AvlOYAzMr2u37HunYTlHGUXr+pTqIQW+eNbOEI5jxvcRvY0ujlvfFERKK40Eo48uoHwoBtN4+YB7y5sPkM/BUEd+pcFdEny8qixh4ublwyt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996334; c=relaxed/simple;
	bh=jIYh/6bc4wL9vcfvlEIvB9D5jxaJ78Mjtur15kqQS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvPN/8hWbdCqQflAJRF489/1trKjPQoxKMtToeDiqphSQ3FX7u7fqfa+2EbEvg7bUVFN1yvOpSIlDr1GgJsryufXp500GsXCdXwh7Km9aqZg7ASNgFJjLLCDHjnR5c8EAy4nF/eNoqgdnqoVqBgY/Os9XQXueq544zWKXrPKG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC2ZhyUF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC2ZhyUF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742af848148so5439871b3a.1;
        Fri, 23 May 2025 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747996332; x=1748601132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THc8iOaJlRsjCnvhYfuHbJ12u/7t2Oz03yFyxpoGts0=;
        b=TC2ZhyUFYDM+nMNH7MHI8K7qbPdMLB/+r90ke9Shso6fYoAUsq7b/n5FFje2YYGYWN
         HcaAJKhvaSAghhsjGoc+FsSj0o3zciRWS4cuXo0jd/4pys/yp/V7s+/VqHU+HztuQMR/
         a02yudq1Yt3dIEDcvUdqU4X1p9cW+l6UF45G8yRdGzMBGauOGfkDlJf6qFT++ze/pCEt
         Vt93dXV/eK59F6L86RbtbMeZInmZDyNA5wJax00Pj49f/lF6xy18rkjs5mtSQ0OVwXen
         119A6f4aF5udGZOO5wAS1nUDkTr8p9jDYTSYoQ2Hkpzr0iBZBdtB4lWkSkM5YcVd+qlB
         7dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747996332; x=1748601132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THc8iOaJlRsjCnvhYfuHbJ12u/7t2Oz03yFyxpoGts0=;
        b=wqlbGq4gqd1BL1EqDpv5ZJIqJ6yy2T16DubksWczixSJ1nzf5nvzjgzwZvsM1aYr2s
         fSX5VX1ZR++jg0CAoiOeGRd6aKE/yyCxmsvUGfY7h0vIi0RpO+3M3qMIl+SJ8eHovHMP
         OkfdxT/utR75T7bk4jq98Uzh73gxJ1tnIc7KBPfXC7qQMBO2TQBYl63zIc0FbhPe4CSG
         UqqQCOAdFKuBKkcA7CRZtx/P9yBtnLzw40sjDC4O1SWFwgO0/vzcGSTQ8ghgBuQeO0ZE
         mWDbyqEY0P2DhIcgIxJnGcUPbGDNyNWoWpeY5yd6tPyxztlD/FCP2HeGzgpMCX0OVaSR
         WdgA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtQKvZpaXsDqM6wpnOIdt05eXAz7fnWN6vEMhYi3mJxutbQikNVeWGYUU/cYnOMSEDdqkqU4+JKK4cVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBJmdV5pUrrbjpXvMnAeu50vxIed/K1DNwwm/vsS/ANQHzfDq
	hyw/96845uZUP+czL5AxfEvhkJ3mirJEEs+r1BZuVWjDJul+k2RXMAJbtI/MiA==
X-Gm-Gg: ASbGncv2JKQqpbrENbNYwFXNw7piTHbTSAgrII8nkKr2Qy0w6lxl7NUd7v7Kg47M426
	xZAl6mHuGOeLPiqadXYsK5fceLIZFcKKhVQeVJjrqjsmEVcNw/EDG7KUK40t5HZl0g55Df2WTW4
	PzQZqnbP35vikJDkZLHxx4yjEOHoVq9srta2C/t+05XFw4XtejCnHhaEZ9LpQmbRu2io18ZD4Xq
	PYJgj9rf7DLlT11y1TV4WwRsgw/kX9cISklBTE1azDd01pyQAJKGnMc0HterCBhTvehVzVoYYLr
	M4nUqf6q4o5uE5KaOTu9hAvRF/U79dnF37GfuiUNIaPoEMvcvNqHb5q0Xgc=
X-Google-Smtp-Source: AGHT+IGDZOYZ1jIZrHrn9ZVQHI6uGlPbZ1eT4Zz6ihDrB4t+V8r8iOO6IjES6v3dP1iNd719hH8ayA==
X-Received: by 2002:a05:6a00:3c86:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-745ed87cc07mr4164866b3a.12.1747996331847;
        Fri, 23 May 2025 03:32:11 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:c299:a1bd:2b60:56b8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c882sm13066424b3a.55.2025.05.23.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:32:11 -0700 (PDT)
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
Subject: [PATCH V2 0/2] Adjust some error messages for SD UHS-II initialization process
Date: Fri, 23 May 2025 18:31:50 +0800
Message-ID: <20250523103152.6210-1-victorshihgli@gmail.com>
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

 drivers/mmc/core/sd_uhs2.c    |  8 ++++++--
 drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
 drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.43.0

