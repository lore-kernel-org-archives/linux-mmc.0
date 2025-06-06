Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8D2874FA;
	Fri,  6 Jun 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207697; cv=none; b=c7CySq59S5maeQSVmT0hknvp5yAviQ5JHQ0cHoHxrCvsEk/yfWpaCs+THSrlgypqMFCDyHx9P8jT0+7jWv1r9wnJtSlsSYsDkQWbTGROdt4WBoSE4f9xuf4TR79Sm1nvGEepwqtBLbBz2COJI9imEMDbcnCnj/hu1BEhI2f2CdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207697; c=relaxed/simple;
	bh=wtVaYsNiDStfS5WGdGavVgrVpCSRq0G8BYhQB1jRh4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESdu0WVIs0J3JxWHxm5IxNxlC6fRLwy94K2NslcPS+Q9lusa6llRgbNs3msfu6or5LJQpjytOdNCZX+cXCQCpO3rETPGrud/S/NosjGRGfpnOpANLuWEbOWJs1IAMOrCwk1sozNK2gETYPVY1OWSeLnn75b32trjbDLszGTT0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWm0teif; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWm0teif"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2345c60507bso14177495ad.0;
        Fri, 06 Jun 2025 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749207695; x=1749812495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdNwp9She6Bw0OnAmilNUKwZ/IFh0LJcOPeTVLWMY00=;
        b=SWm0teif5kfPfiJ/+VV+nbWf7rZSrBlb8CtWmvQffkQ/5JIUqcdUDm1MKX9sFJUVkO
         023YN6mAekEEAQdgsw+qoDqdDtGn5ige66Ktm323hGq5iT3r3g8eJS2ptUK0HuLed/75
         mOXlfbLUy2Xa8aYwPsH6/UN9tjMw7SO7epnjtzEtbCpo+JhcheEYUZxZUIrbcromeitn
         GlBgbpfUrLoH5WU38U2y+sUTeTD9zYwjBH18mOghV8eBX7AbEsFZFGUo+gQP9Xzo7htx
         O7wtlYWMse2utE9SDQeiIv5NtGHIdI7LeAud2kJKhquk9RXb9InFNYiFazXaup+oIWwF
         coFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749207695; x=1749812495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdNwp9She6Bw0OnAmilNUKwZ/IFh0LJcOPeTVLWMY00=;
        b=TMxsJWwxfUQAJCilKP9h29URcmLZUEC9Y7dTMavSdJbKYp1HofYBExbrhf6NU2POyq
         HPpJdlXIT4B1ugc/BAY71dNT/RqMg5Ppeg+/7OTV5WALOEpzaSvXkFHYUO6ek7c+Jvkr
         e9q1I3cTjDFpgI8pCD7wI7gUMtxvKFFa/PQmspfZMpJ+FxQSO65vRxb6BCmDUsHphT1b
         kciSIcdcj6InHUpM+94RmiJ2hiyq3nkl+IzSYzszWnZmib4zVdTi57bKizjiYS5wv6mt
         KSnO9HD3inJELbPOtDRISPheJexO/pYXkh+FekaBNREYc4oyfrZxzYW0c9DTcqGKO0Q6
         GNGw==
X-Forwarded-Encrypted: i=1; AJvYcCXam+9OzjQ+HNDU0nlfWuz77Ojs4eF7jkfpmjZ1PR5haqZ38QxAM4proBDGPR9iwT9W6O6yChhMATh+j4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9GegErYIGoQJ2RzyajFF8nzGFY9Jdr3ygLhzoNsOBXHIcd0wd
	xm+VvkTTjzEyddiPQ/8WXEoNSfMzt1hFqnX+u2qxYzL2F5YoB9/eidzx
X-Gm-Gg: ASbGncspi2ksZzT83BE+ouGIxoie3yh+gvi2tMr4kP4SuhKaTQteL2yEDjKPrmK1Bx2
	1OJbXCsiZbKTYQIJ25CwVTgRiJQq17eI26DxOTE87Comr++JL/KAo1/yeSYfLnEJ6hZIxnusM4U
	FBaS1SRyIAmYL2mC22DDrXE/8HkhCNrdk4Xri+oDkj2nJbE/n/O0njSoQpgAde2j+YP+6Mb4mPS
	2X5QDrEz//2vZBAOY7TzKrGXgxbjyI+rSNVLRgjcNSJkPXWPDD/KPy3uHgHrRVabHPP6Sb39ynP
	kTjmDdIfajEAPzbBAn4UQiY2wY7I3yt8+rUV3MifjRwRv/D2cnIPuXozenk=
X-Google-Smtp-Source: AGHT+IH7IVs99gQj/i4GTnZdOMV0vK5KnUZifwyIB+LbN+eYfmSwFI3jY/mHycYlDB+MrahI/y0h2w==
X-Received: by 2002:a17:902:ce0f:b0:235:880:cf8a with SMTP id d9443c01a7336-23601d04110mr48586745ad.15.1749207694597;
        Fri, 06 Jun 2025 04:01:34 -0700 (PDT)
Received: from victorshih.. ([2402:7500:477:464b:b7fc:d546:e798:4fbc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603406aa9sm10095565ad.188.2025.06.06.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:01:33 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 1/3] mmc: core: Adjust some error messages for SD UHS-II cards
Date: Fri,  6 Jun 2025 19:01:19 +0800
Message-ID: <20250606110121.96314-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606110121.96314-1-victorshihgli@gmail.com>
References: <20250606110121.96314-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Adjust some error messages to debug mode to avoid causing
misunderstanding it is an error.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd_uhs2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 1c31d0dfa961..de17d1611290 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -91,8 +91,8 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
 
 	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
 	if (err) {
-		pr_err("%s: failed to initial phy for UHS-II!\n",
-		       mmc_hostname(host));
+		pr_debug("%s: failed to initial phy for UHS-II!\n",
+			 mmc_hostname(host));
 	}
 
 	return err;
-- 
2.43.0

