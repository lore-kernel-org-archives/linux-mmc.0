Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7335B63D
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352519; cv=none; b=a0nJ2+/+fOX19g4qRddkAxzQxx9B0xN7wcmsvMTi3SRXUdGB3TlRUkhkY1QVEa80QbF/i2aPKX531h8GuVMQGLtBisJCCdQ/JGHnz1sx56r1cRFI/A5S86YCgJRdl1J9+6Dcy2m37IWgnx6IjYWPoZLxhbp6lk13q6PSBCrpNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352519; c=relaxed/simple;
	bh=BjAGtuiyERsrnnd01vErI9QCyrDyM45is9k/KqcT+us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcptoy+JZQBtA88J5HmgurK/w/mXWG1gnduLIka/C2SIXSRbZHtyRcC0YdHS/BdVuK/ndP30x+gnQhy+vAiT0UGXvdiQnXamoHYk3UgABXFcg/LfO16JYSXKYBuHeFsbqr2IPVbzQ2uKEc+5wA7YQ8BmrcHmaBkbaFrYwW7qYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLilA6sb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLilA6sb"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e97e73234so52316671fa.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352513; x=1779957313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7zbCi9B1UroqVUd5aRR3oeDcUX6g7L2mRwm0vu4oxA=;
        b=tLilA6sbzKapvjVH3NsCPk5QGlzqfhDWrpqVq1zP26ceBzhZL5sFpRguxgHABetfuo
         3wgo72wkXns0+BkNtRO697fUkbmGgldMbL+D9CRQVGTr1hfOdk29JXX7jQqNM04882YO
         3wSOTkotnYPf7vvMxp7u93+iGpWvNeg3mdodVo9ZiGsrw+lm/WFbpUzZ6aHnFOdH7oh+
         9sqZTASEtmDf6XYM5fmVLDzczz0SpFwJe+ufREBXi23r1RxJYtS7KGXFaCqQtFcPlC++
         p6xTUN11uEpQQ+CmK3iWqUGDswpwu14tP3AGwNk0e4C6J8Anv/b2OtIygm8M+E0wK1Z2
         MDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352513; x=1779957313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7zbCi9B1UroqVUd5aRR3oeDcUX6g7L2mRwm0vu4oxA=;
        b=gZvwoXy4y2iIAnB0a3TqiwXbPgHiH7uTr0iFoQzRM15cGc6JMXFnXdiuTytXX85CTQ
         AKvEOZet9cPG+QybFh4xjCx70zCOYAxP7EJK6o+DeSeJg56H+XvcCuDWnjgfLr1CVeUG
         dsP7+Kb52yTr+Xo4KljcOJFc8fdW71EYLSUrlsCIkojYXIoMw1zGawISh/4APUDqRbxH
         m70Eh/w0p70Jf6tvmUVCEKo2B/HvQTMdil8IpNYZzRSkR87tlFhv1oagZz207R/Xl9Kj
         Xpq5I3TFhlb1RDC20W4jhpgowaUi20an8VHQOPTKDOJW9SXpVBgZty7rlUk2tLLOWZSh
         kqqA==
X-Forwarded-Encrypted: i=1; AFNElJ9bNeZW3JD/p2sn/MVOOE8L/bHiQdD+btFHYIwYOCliQ9l4nGzA/fOelnGKBpjBjIp72OcmRhvL1Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4nkrUA44HE2H7bjrUQ2VuQ8ezDh8yMX2+0y1tnXHQwBp58lt
	btv5kiDCvF4DGloSKYEYthojIH/bhGqR8P+9j188T4q0EAq1IFG2ATijELmFjg==
X-Gm-Gg: Acq92OFARbh+2+Ove6IyJKzBFac3hk22Qcs1Mlyp+sDBuT8E/qlaK1NxkUa+wPmZTc8
	rlSpO9nUpJdVTRyOCNmzVgRb1LYKFPKmfDgVkD9BsyuNNwWU2C/yAFjksgqfbGgc9KRu8TIz7ek
	2VzC36ktoIO4U1aJsVvGba13+XJ+YutuTaOqV7nCVKpH7j5hpD8zXpOwz5vJ8GfdRuYhGN1A8HD
	EKq7BuJT072RLl69ZmwYVsKrZ1dJyPt43chuL3SmfPWloJi7XRmfh5O0DJc+pf3R/FijXMmzdXO
	BJIKlnoRywu38Yg5CGLN36FZnyieXohGQK+S8xBTFvNixxJ0Mj1frH+FAv+SgH1gfK3jf4/waDL
	TAJRPONu6jLgfPiCF35imDiGYMvek2B2QbeSW1vKvYLXJjH4OA+PsfkMhnFAsu+NPPzIEkwILDj
	idU49oI7Nwc6KmsUTM1z80sfTt3Dv2HAIjPhbf8A++A/SwUH0XYzU=
X-Received: by 2002:a05:651c:222b:b0:394:2b4:ca36 with SMTP id 38308e7fff4ca-395ca5ee616mr7578951fa.30.1779352513202;
        Thu, 21 May 2026 01:35:13 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395d0b68afcsm917611fa.32.2026.05.21.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:35:12 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mmc: sdhci-of-dwcmshc: minor cleanups
Date: Thu, 21 May 2026 11:35:01 +0300
Message-ID: <20260521083506.356422-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series introduces three non-functional cleanups for the Synopsys
DWC MSHC driver.

Patch 1 replaces udelay and usleep_range with fsleep,
following the kernel documentation recommendation for delays in
non-atomic contexts.

Patch 2 removes redundant IS_ERR() checks for bus_clk in suspend/resume
paths where the called functions already have internal protection.

Patch 3 converts error handling in probe paths to use dev_err_probe()
macro for more compact code and better deferred probe debugging.
--
Best regards,
Artem

ChangeLog:
  v1: 
    * https://lore.kernel.org/all/20260518110034.142587-1-a.shimko.dev@gmail.com/T/#t
  v2:
    * Remove redundant "Error:" prefix from dev_err_probe() message
    * Put dev_err_probe() call on a single line
    * Replace usleep_range() with fsleep(midpoint) as primary change
    * Reword commit message to clarify the purpose

Artem Shimko (3):
  mmc: sdhci-of-dwcmshc: improve delay and sleep handling with fsleep()
  mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
  mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths

 drivers/mmc/host/sdhci-of-dwcmshc.c | 50 ++++++++++++-----------------
 1 file changed, 20 insertions(+), 30 deletions(-)

-- 
2.43.0

