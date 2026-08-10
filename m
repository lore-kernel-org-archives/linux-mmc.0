Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF93C279D
	for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376101; cv=none; b=jXLEGeirCnf+HURMrY0dSA6auohwOpa2Dnm0L/dmsiZqXAVrhJblTOGAQIAUOymwrDuBrx/uajSgy7t2i79N7p7we8sLmbUfG10pQdU0tE6yVC6/knx0u96Md7c6eOPU194YvQ95rBYm8leLzd0ksUNOhmh/3fuOfokF/H+ObzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376101; c=relaxed/simple;
	bh=jpbFuHmO0SZB57FeVr7gwSU6RM7+NPbFwFI9j6uWAso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksmJZiYPEm9ydmi5++jnA2iTa7WB3662NLM043V3RPCpSg3Zp/PJ/XWeDDwNI4wq1yMV2D/QKyXYkEWJPtjTYjgkK0mSSsJe/KMj3F7VF41RxK7pxzHVDPxNbohHoftVpwV6TUP7SzAyyY8g1ObomsN1sRvG+Z17adfd2ggngHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di3H9f0B; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di3H9f0B"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so293092066b.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2026 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786376098; x=1786980898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF3ICS09soj+MNWTMhGpyCODdzLXtW9oh4LQfw8sHgM=;
        b=di3H9f0B4MVRqQpC161axo1RYra9IsG50btvv3GuSk9h/m+bDm5FMT9uCfnP643Ucy
         oNg540VS/9gjNjeiEZzIlReib5r5JlWYYCzUExu8FBeCRKDt8wjpBEdZFJ/vRnKEKEzu
         n60oZ+vibyYyhLVct2szWRaLmN7gQW3mpkimoqvmEw7937T7JRnBIEoTwYb7cD4032j+
         rbhj2QyiNmcus5NqZFsj1SOQSCFmuH401a1BQGlzN8QKm502mmHEgq1baRNK8023ZCwb
         uELjylkPSoCRwKz/5KHlqGkllYWiOlB/CZtEH/rdGvCzlldQARNfr7GseMo18vPKDDi0
         F1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376098; x=1786980898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF3ICS09soj+MNWTMhGpyCODdzLXtW9oh4LQfw8sHgM=;
        b=b0e60uz0RpSmOb6D8lSJngFEsHqJ/YG3uhrRpgDtm8mVQAtfSvULFSwTjSezYyDVZ0
         DaxcuEOx2+2/yX718OSPInEog8A2xfEnDNhgy2rJkaNXgXfNXfX5/lNZXwdlvgOHhxDL
         QC0nZ+ncySy0HLVgOamUgrH7+f/+ljquNOsL36ph5bEmMxVOI3DSSAKwbnPL3Yk5/tIw
         6vx8aUB0zVfIdTESfR1GsOYPTBEnMDQyVE2kZ/ehUTF6mCZtEPlo3hs3CVTRaYl+4m9O
         a3FXgLqLzWNyWT8koZwNe+dM0qTYY+0p4syM9g3JaydBOYWQ1srqYHqvQ9J24xIXB1fP
         humA==
X-Gm-Message-State: AOJu0Yw5l+jylEm6h4trNEGqPDXNbW3L8NnI7LQHMbTHuSoGYVBSIhSw
	lseQKQ6LRUUpr0CE4bpd2zQsToh+YnonvSN4MSUWfMEZQ+Zf1dUGO3pmHbtmUlCC
X-Gm-Gg: AR+sD12sI/MJnmAponW1wGNlOsxcARK2vKsRxWw1pGcYN176VWMGYTdibYOeOMkB6zG
	uKTlDI6pADkffVXTRBDWLPC9de5g0MzYZuJ7Gcag3BMOUjrQuV8ycwJiWL0915dT3+V56sAVt7A
	fKstQA3G0VtdTnrVZOlJ77N7zaFYts77oBTbfaYoPSuE+jV5UWl5E0uZhX/iriR4KR65XKtBe6L
	skOw2hzSqTjZYYjcUdkdF3lh4mNww0IpeHmXMMGkeZkFKz0Mn1YosG25rV5vsGYXQe/zO2K5qJd
	jIEPeRcY6JHf+XHWL9k0id/071OF9sXOO36C9ibIYgs2K/enrdAM0PQBLvld7ByKHPJ4H/tRzw8
	ljDz8F9O8AZPpqTkGBhnig+rs272kQt1BhIinIROddUcW8Sc8V23G0OOT2h7hZzPs8r4aH81GOP
	JbXFd3SvskmLxsJXc7M36oQ0stO5sgMxG+svkcWPGQQeJNysJqu6IH0j2Z7c4AymNhzyD2XdMHZ
	V9GOu0vL/AW
X-Received: by 2002:a17:907:3c83:b0:c12:67d2:3d6b with SMTP id a640c23a62f3a-c20c68f3e90mr157430666b.11.1786376097830;
        Mon, 10 Aug 2026 08:34:57 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:9fe:dfd2:946e:90f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080cc3bdfsm393966466b.48.2026.08.10.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:34:57 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v6 0/3] mmc-utils: lsmmc: add 'mmc list' command
Date: Mon, 10 Aug 2026 17:34:39 +0200
Message-ID: <20260810153442.132286-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a 'mmc list' command to lsmmc that scans
/sys/bus/mmc/devices/ and prints a one-line summary per MMC/SD device
(device name, /dev path, bus type, manufacturer, product, revision,
serial number, and manufacturing date), and teaches the existing
register-read commands to accept /dev and /sys/block paths directly
instead of only sysfs device directories.

Changes since v5:
- Patch 1 (Use external .ids files ...): carried forward the
  0x09 "ATP" sd_database entry from the mainline-only fix in
  d64cb08 ("mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
  database") into the new sdcard.ids, so the manufacturer ID isn't
  lost in the move to external ID files.
- Picked up Reviewed-by: Avri Altman <avri.altman@sandisk.com> on
  all three patches.

Torstein Eide (3):
  mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block
    paths
  mmc-utils: lsmmc: Factor out CID month/year helpers
  mmc-utils: lsmmc: Add mmc list command

 Makefile           |   8 +-
 docs/HOWTO.rst     |  71 ++++-
 lsmmc.c            | 649 ++++++++++++++++++++++++++-------------------
 mmc.c              |   6 +-
 mmc_cmds.h         |   1 +
 multimediacard.ids |  16 ++
 sdcard.ids         |  24 ++
 7 files changed, 486 insertions(+), 289 deletions(-)
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

--
2.53.0
