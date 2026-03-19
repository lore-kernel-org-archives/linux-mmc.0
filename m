Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730A38B157
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950988; cv=none; b=EKKnqdRX2imvvcOyVl21ziL+vvALFX7n03nmUAC5tK1rIYolXSAXbeMXWWLhOX0hA8zP/YpPMP00oRzmOd0JLl4QXNGfcj3KOBzSDTWtMO95TOqlSsx0ZlfAGolFwTJah11uxsyG90U0oUacDKADN4BHhUBox1d8CWuObYh/fK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950988; c=relaxed/simple;
	bh=014sjU+XdA/SuNquuHDFKzVFPp3enVj9IWnY/vHOZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhAeeYf5Sctw5DLIIg/RYAmROb+mbXMgMdg7gXSlNhZk2atpxw61E4Ub2GRsp0XxnKBjnYbF1WbfFba+bWVaaadLTyRWY8t18a0QEWLZ4H9UZB8+140NWEPrWEP4wXOvJEJrKHWmpGF7wNG3f6qNfwipHOBmk7hEMkGVWUurNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAWSar24; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAWSar24"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso991203f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773950985; x=1774555785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0xT1xYExTKZgM/fwlpabfSXPeemeC77Pfk/8l/5YTk=;
        b=NAWSar24dm0PhwrZZvo4GcRLYKp/QfAjTbW+CSnaI6dWKAJAYk6TjX0P2+TSuE50sF
         GV7KyXjT8/2uKaTKjTfbUzRyh/XizzGN02IVRMmfOQb7lTF0r5475YYcCdTe0v8uFAzS
         Abvj4HTPez8bNazbpLMv/sZsZRWVXZM86l8rwh9SXMu/nMx55oTPI7ht8/nBsyWvgGk5
         yjJJLXT1VEkHkB81Zgw58PutXbZXlcsy5EMN5K2dQmNsPkYkeXohMuwMcrwYYB1LBiZb
         EQxNyDWaWdnUfCfYFRn3i2hyjGTR3j6g51/jqZzhAdhnLD8UrmUon+nPEza38cUUBQg6
         Tkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773950985; x=1774555785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0xT1xYExTKZgM/fwlpabfSXPeemeC77Pfk/8l/5YTk=;
        b=AuAsJEwyrvxnlMFICzt9TneJP4os5xr23iGEp4p/tiM2QFuyeQyrvMKBAXDPZTraoH
         w/bDNRm++kBECLsg5YqR6n9p5jsMiaNmQ+UqBju3wSE4wDFXdvmPAPofHEYl0mw1Kp/5
         b0xaqbCV3skItGW3owaMWXEHNe9S5Wso0d2NvkoItIPdE601FeaJ/EJrzAYBUtBf6tCP
         0E3t1Px0wYJ7I3VvsOINpkuQ8JQAdHLK/ch11DzQzq3Lq5NiAgpxyWjRtPI4IywKYuK9
         UOVryFsRV8samzo3xMqMS1MwbAMxB41UHUIsFVk6UhLXcfzJPf0wr6wOJ8AauYB8FfPp
         2fIw==
X-Gm-Message-State: AOJu0Yw6LematamxWRfBfdJr90bQ0ml40A7zM+zNJLrdjOnYJz3wvUUS
	MBbKbL5v3Yy+Q5DnkgsuBCLa67XinMqA3oQyhbTlIu6/Richdjpmbq1e
X-Gm-Gg: ATEYQzzS66ivAyTgUMCx5Hez0lDH5wwo32kuWgFt5z/T2dYp85P3UjMC6F+KdpsISJL
	AfgmDJ+ppm5EbRmlRBNAYN8+MaymF0uw5hBmTmb0k3GX7JG+HDGHYvokHkpc165Qv1nlEbi7bmu
	4OTcoWg2DDW6+ZjI1I+ZySx3uI9ewtNVBksYe9fwqOLiwRnxAgO9jq1az0p5sMSYKUE1O7i1vLQ
	7eLrc4Xp4JPeGJCi+6faYHI7jH9YVxkiEe82Etp3yMxGiLOJgxZaia900mIhzEi7Yzz5NAgItnn
	xrE4aHhiXB1jPzafZXh3pFSrCsxspEuNAdqk+iIrQabfmHsOzPOfNoqXXpV+s68/dWFlyjaDdHc
	UJ2oIy3jVu8kOAwRsS53S7bEzsEqPQ58AqhznpsqzlH4mtFinx8MLZDzb/Hm+vJ9d/sEXMOX0JJ
	4QNH87Bf5INJnDka3PZ7IVHnXjSJ/F+wKktBO0738HShFj
X-Received: by 2002:a05:6000:2010:b0:43b:5022:804 with SMTP id ffacd0b85a97d-43b64262ff5mr1109910f8f.29.1773950985152;
        Thu, 19 Mar 2026 13:09:45 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm1061941f8f.2.2026.03.19.13.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:09:44 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v8 2/3] mmc: core: add Kingston CID to quirks
Date: Thu, 19 Mar 2026 21:09:40 +0100
Message-ID: <20260319200940.23289-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CID_MANFID_KINGSTON definition is required for centralized
management of microSD cards. This allows identifying Kingston cards
that require specific workarounds.

Add the CID_MANFID_KINGSTON definition and its association with the
known Kingston manufacturer ID.

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

