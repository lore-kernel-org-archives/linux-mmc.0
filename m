Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391C2F28FC
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944980; cv=none; b=DzVygP4uX6wIHhVbPWnrhnLjy0+iThOK6rHKvPcBYu3xOZ+ADEflWaA5hcOXv5nvy9EPfTw+nqFVXfQbYWVZO+Re1j3Bge1KkIoYLU4fTMwoWL4+heTYrGD5VWt8InYACXHQm7S5OkTOTj7BtrgNtVs02wNlrwwSqzDVpnk8EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944980; c=relaxed/simple;
	bh=Oe3ZmUAj4a92bZrMwcXbmOJR7l6UIpNGk9xbqNITzLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pCmK7gudGYOM72u6fnuPIGpl+ozwUcytTlKJx+yzwDET+q19BVjt5q8c9lPO6O20wRmgfghudJJBnV/P7LujWWLoZ0+C22eIM4Lk0pbF3PyrIne0nsa/5eLtq4ob57kxKfE9CG1drB6XemSVwPppMV9k8yJtsLZ5Z1iufQ9zXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+Z9F2iY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+Z9F2iY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so11464295e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773944978; x=1774549778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYDQw1hTF+fOXyybZ3dFntkNILnHjdNKcBWC8c+CNxc=;
        b=l+Z9F2iYUYPy34QVgXCKKxfbS9BiQCYOWNa1L52S3/q/d+znQaZmkwU9huEjELYe0z
         SJJ+985ZWUlDts+cbdyrE46T4X9w1jqPGpt6cox/p4f2u6OI4PQNUtL1eb22lJyk0MP6
         cyoWjdsELPaawjpgx4AAxHidyrrqBp7VUbD5qM385d33fpufeHsbCP/wKfQgB1XB5M6E
         VkllhAsTBZ5Rqr0+YdA7HHnsxGf7Y8UJdvDXQ6TAij6RJgDOZLcUhD4PNyKS40MamiCf
         JeAOtDoRAmfwp5eqQ53cXszluwZfftwOSTWQ7unZT74r2cSIlni20m53gFk9ZQKGq29t
         v+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773944978; x=1774549778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYDQw1hTF+fOXyybZ3dFntkNILnHjdNKcBWC8c+CNxc=;
        b=q5UwTKxByuPBdFU/iIZ/siAgYpqr3NL/9cEsNhGjzPOulA5VsJ2KBdbnKEzp1JxiKO
         aAvTOBob/+pafKXl26llQdJCiDq66TEs8+wO3/Vt9MMd8yZmS8I7lJPazdHt/IY5zncX
         QvlIZ5HcnLX8ljo/zSxl131uhyxRPJpAPgDeNggrZ+NCSyEfce/V9n/P9OtiU3PDvRD5
         gTnchHlySHzsLfN/lYp6Oq3Pb5wjZ4Oso1n/G3EYfO2IAqYM4TFn9DH0G39orapUYtz2
         k3kFc6bFxzAJD80RW5cRn7dMfddfHGIOvK7sTFhgjBmF/3FnJBNepdbDkkVZkbkByRTl
         MeVg==
X-Gm-Message-State: AOJu0YwoI567IAe3HjwDw2OXMA/AC9zXVHm2/73X6wsBj9FN9KpF+kUF
	w+N1Jz5Z0C48N3/oHJkjIORmvjK5whxx9/mlRK6XzCRWri45EoCOmAjW
X-Gm-Gg: ATEYQzwKfPv1/uVzKrFBok6UATQvhc1jGs0EVMFbCOzFy9vTttTLkjQYRzAzQHRxcGp
	NInIr8r9wU7CLg1tqVmUV7NxKyeBs5OY4w//6xi6trLs1wGznUjS0LQNRiqOAt1Gf2m2JBtK7BL
	LUt6Pu2gEIoItPmNOWmqHkJubuaivuolizegF0AfeAoMp6dSbwNw2U8pzzVh6ro1d1XEUk1ayBF
	0aLzl7KMYKIEn8uluI6jke5FGWJhmVgELxArJi+adRkHBPfJ8e9wxyVW2w0SoFjS34maawqjqgh
	Zlguwx1Vgkkz8iq8dOuJ1vZ6gL5xbQMqhntvnEeGNMDZ0xzjNvjKQaGd/v1T2PJYChbyBnapfWg
	YTrrd5NFHBbxQcLy+Zvt0ASs3XIYziKaG5DSPY7jzo+R0tiY6Cr9sfxyFSNxnjGIwjRYRvQQhck
	ZbeZDIlAr02VeMOWviNZWjaadDKUejqEUJwg==
X-Received: by 2002:a05:600c:5299:b0:486:fe46:b647 with SMTP id 5b1f17b1804b1-486fedbfd67mr1884375e9.10.1773944977802;
        Thu, 19 Mar 2026 11:29:37 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e162e2sm42676745e9.34.2026.03.19.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:29:36 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v7 2/3] mmc: core: add Kingston CID to quirks
Date: Thu, 19 Mar 2026 19:29:30 +0100
Message-ID: <20260319182930.19470-1-adriangarciacasado42@gmail.com>
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
-- 
2.47.3

