Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27611391E6D
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941918; cv=none; b=r+8LbD2jCsbTjb86/CXowYd8qRsLyVhYcHgA5OnVOSdHxsU1PVWIpeq4MLWwAPiAcfUYe6kKE+uZbhT25ZSu9q3KTSMpMVzJr7k6Nx5kmbaoVfSOtLkCe8ApA5Rd7YTBAmIYxmgjqURe2zw2gOb9eEfcAuwSEvQaBukrqjoBAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941918; c=relaxed/simple;
	bh=5w5snbL6EsBVEzPk4XhoDt3E1Nb1rrzKOXn0xAju6pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRFkaz+Na1VAmkduwUldBgkFTHpR0dDs7icaTO2pcvlGyBXo7p8T20cQmTHuA+gt9lUmHF+qEViZVl2hCg7LFX29+qbZ5OtsEh4MxaYSd3TnCzyCJzuOTEbUxVlWHuBvyflL/i9Tmd+DZvPAzNsnouYjX6CFy+ONHiS/V0smQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR/hmG8S; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR/hmG8S"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so9866925e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773941912; x=1774546712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfCxPOG3l4qrFoCjC93XCSfZd4Kmk+6vG3mDN893tDc=;
        b=FR/hmG8SF26jquYvr9u4/rttw90/DwYJ49kH7Kne/354+/Jdfasi4iumU93lq0lnAv
         CvlUgANGWMhHT0FoEKpnbXODuwecxPaJQ9OW1+VguOSux3YbrOb4WRA8KrfdPu8szlp4
         ZJDgP/JPRhMATPLK8fenTyGOoMQ9ZTj0feHDTGjxvKhVz4L+phQcudKSOmHykHslpllD
         rYVxuXDA2FCW/b4MvQcVOE3zTi2tKcQhOPUJmrWeq8zhYZco69V25Q9EQwKI4xqHhmOj
         jsMshnuMzxCQTIBTPsHGx9u/Ok6oYuYFioK2kbPcSmAU8Abku576UwnvKLWLoc3h2yyS
         U5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941912; x=1774546712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfCxPOG3l4qrFoCjC93XCSfZd4Kmk+6vG3mDN893tDc=;
        b=rmVKe/LnPuvs0TbERsJXyA3CWgc9VyoB5Bp50NJPIyezreuxTWvhTaW9JR1DIh9HbQ
         9bLwRH8lwyFrptDLPM1qO8MCYteaD+GPebuz6itKT+f/5w+Dwl5t2ajtRSJaT6MyqO78
         RZVGqJDR3kzrQWMgnqqORegOASpr4W5b4eJscf5M2vPk9J3ySz9/s13VWT5LSVV2UEwP
         3ChM9+Zoo1U7+ZdvgrLzYg0LSNC07pqB/5bzifd+vsOQm5Z2U/Gh/F3cw81rNrTu80+B
         0Tfkz24xhzlA6esyhfQSgqscFOH78fwnXlqJaJj7JCQGRFKtuBqlZb9vdkGIpZfb04Oi
         y2oA==
X-Gm-Message-State: AOJu0Yxe3wtD294Undmt3A9NBTwvRGUtfSugtFOMMwIpe7SnsYaMeJDQ
	9WT1JKzr3bZ6Cusn0n0EGWVAEB+FuOTmEj4N46Xr2vfSnlJZZ7JacFmi
X-Gm-Gg: ATEYQzywVimyOdp1XQvXIzQhfPYjsDuI70in18EPY8VrmIAxCxMs7BqyxDyTmvCWQLg
	WYfVKnFlKtVAhl0vbixYZ/lVLQNBzsL7DQvGqDSMNyDpoujLEijAQV46cCbMO6YdjZd+ugjr6pd
	n2XRIa+Ky5ROudjgg1MTZLrXBCV9ZUvCYMXECApqdVU+B6dUt+TcKhVdQnj1izBX9999d8mg8V6
	aGt2zMfZYDTf0SEh8TkY2sI5mBj5bmeJhHptdQRsDBW18fumsKVqjLERBHBjtPymDiVzi+vSobd
	56Z7T/kEJH0EX8+E5b4bUfvWG12yrJvKads5vLlK0bQV3TF1Z4YJ3aiPM4NoTj6//IE8WpIfp5N
	RnWs12X02UlZbaNR2LAk757LwwZTgdvY7pXQ08feWUNXkarSAU6N0lDcwYWHoljLEUNPrs1mz6l
	vZKBpKseolVtIBm2+Pthm820Emk0wlk0FJ7A==
X-Received: by 2002:a05:600c:3551:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486f456fe98mr140830115e9.29.1773941911866;
        Thu, 19 Mar 2026 10:38:31 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe82a030sm3669835e9.10.2026.03.19.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 10:38:31 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v6] mmc: core: add Kingston CID to quirks
Date: Thu, 19 Mar 2026 18:38:27 +0100
Message-ID: <20260319173827.15507-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the CID_MANFID_KINGSTON definition for centralized management of microSD cards. This allows identifying Kingston cards that require specific workarounds.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/mmc/core/quirks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c0576..d736bb4bedf7b 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
prerequisite-patch-id: bf56dcdce62cb97741b7aa11b04c7a9648fb2d6a
-- 
2.47.3

