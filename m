Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7030B53C
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435115; cv=none; b=oTWbrMUryh+MGYN+exQVlNp6ZUGckzsXq+P9EY6sNXgNwt0i+A4bo8T6XuY9M+OWWUX4InfpDMj1q5f47gqJ5wYfL4zU+2FfncPeioYVCXbptg5ZiRWviGRMtofjtb/pWzcN/tVtgU1uZEyxBITwccQii93ihAJ2sdmwARzfOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435115; c=relaxed/simple;
	bh=GfEYTVpWRVpHrya4OgutdYGeq8Gd8iUlMyrxDimSuuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O147ziGDsobiUyiWZwFLsrfY9u+mAJYRLPluA4kUmqCYe1dxEkz9Qfo2HvwC8czsII0PnwdhfyPUvg3cVV/BRjwosH6a/at1WsNrOXYtUIeJoRzxAG9CZ5vLIWcNrXynzv19zadmrgIp0XRDkNmaem0rZwdkumg/Oh5JcLo88SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZc0F/+L; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZc0F/+L"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3939d2bd739so55741741fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779435113; x=1780039913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Tp8PbSEjPSejsiO2XtXHkhDECkiigP5kvwS+slQkgo=;
        b=UZc0F/+LljGZXjYu9GTFvqFz7Ai9p3WvpViibV/K5fCy+RAoFvdm2UYcMZ74mV7Q2h
         28NPw8A9OovQisIBW4kM++QQiN5HtRXfyk1Sp+ouC4zvh5v5hwj0hX0AVSGIH0NJAobY
         JOTZT5aMFNWCFlGf4bAlBGI85JljP5QJ07FMKKaHI/1BESmyY7kOQ2cntzZuyl8AcXn0
         kpDhLPriAHqtGZM9Z47lrjqAotkiuEEcctopYs7h2gBTn9+8FcsA9uqk1I5UeavmWnhp
         Nb4P2hHoY7lxtAYDeFJJZ5MlvLCc+2umfwFe2woGTEeOX4DpTRkADOzqKdYRnSL6KEc8
         ArZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435113; x=1780039913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tp8PbSEjPSejsiO2XtXHkhDECkiigP5kvwS+slQkgo=;
        b=nQQvR9IekP5M1GRsAT+caKzBQGg+Y5qI3x7FhkyzhZsFaXZjEyf5lSsJ1pZtNJ+/A+
         651pw3a6PUuN2XncdGkHfKy0/tzGK/RncPXLp5u3TK8J6hXu/mvjMlhamYGYsdOhGeeD
         65N+tPS0trYzfrEQLcHuu/o2DhD6BbEhbppaPPdZQBHHRLzVjzMleRKt1T7kyatF1Osy
         Wg+2gRrW66lX0X+67THCGuPIVk6xNYxciXGvxEXHaz+sCGdM+bS/+T7qyS3xS9MZdShj
         cacLi6JfUDrai4yvn63dmzx8w1vq+PWuk33OFAsWyVmMgA5JF5bzc8pl01Q+wfiRMSHP
         DCKA==
X-Forwarded-Encrypted: i=1; AFNElJ9OTUHwFdtHvw3FdntjIv5IsmIeJzaJhW64M3u7mKu3m7u7bzXzbyLOti0faAI/r4WJOm3yNkAoUNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIPhlNwidcUyCeCqhJ3Lg0Q/Wh5ud5S47kOSm2RD3xerSWXHt
	4DKQg802NS77Q7M3RUX2KbnsUE0xPbE9yPO/2brU0iVNEcqo24HNuCCm
X-Gm-Gg: Acq92OGmqt5hbLL+bjNiPtgIEAt+1GcX6N2XWVP38jU3H/SJ6kz5ZhJ8p8vP+M80Cfg
	q6WY1jhA6H7kQgJO1sN0UiVk6ofKQhrOMjAelECksLqtPECWwqRuSgGeobv6WvD4TkjlS/rzFFC
	H8VcrvSLpk3ho28OR8Le6STQKsoP1jvu4VvTj3MmW6ox89w4t59LLKTEAc4jhXcIZT889A63Y98
	+AS9kcsi6hTE1AvOj/l+rONlQdQCithQd7quGujjbTrsgjDELsADCUInaQF4nVWGtG9vr9x5j1X
	jo44OoOMjm+F6V5vUstV1eQVKUyQCrMISEBE5T1wim03paqHhK6+cva5v7TJctVHEeOWoP7OR6R
	mepUoPzeyOhhRG8t0MEOWKqxSYnMgp3lQGtPgeBs9ml2lA19PHyfAQGQ54eY/FDG222q0EH0p1S
	g1kQR1ifV1Rz4X1AVZmTgot+rU99miclLSh9zaf/owXSX18SZ8BcU=
X-Received: by 2002:a2e:b5b2:0:b0:393:71d3:d019 with SMTP id 38308e7fff4ca-395d8cca58bmr6188171fa.15.1779435112692;
        Fri, 22 May 2026 00:31:52 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc0a4e3sm1818751fa.22.2026.05.22.00.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 00:31:52 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mmc: sdhci-of-dwcmshc: minor cleanups
Date: Fri, 22 May 2026 10:31:30 +0300
Message-ID: <20260522073133.409844-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces two non-functional cleanups for the Synopsys
DWC MSHC driver.

Patch 1 removes redundant IS_ERR() checks for bus_clk in suspend/resume
paths where the called functions already have internal protection.

Patch 2 converts error handling in probe paths to use dev_err_probe()
macro for more compact code and better deferred probe debugging.

--
Best regards,
Artem
---
ChangeLog:
  v1: 
    * https://lore.kernel.org/all/20260518110034.142587-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * https://lore.kernel.org/all/20260521083506.356422-1-a.shimko.dev@gmail.com/T/#t
  v3:
    * Drop fsleep() patch to keep initial delay/sleep values

Artem Shimko (2):
  mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
  mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths

 drivers/mmc/host/sdhci-of-dwcmshc.c | 36 +++++++++++------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

-- 
2.43.0

