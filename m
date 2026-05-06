Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15767175A85
	for <linux-mmc@vger.kernel.org>; Wed,  6 May 2026 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094349; cv=none; b=q3Xl/KhkAWJQ1xhPKo2b/2VDZTECf+xqHqsHRvj2oIyMkkTqiWHUR0TnMzyNzlehIyYzXdtBJ0sxc4G9oUMDLkNfIssQ9qpClNFJWWCZMKGMuPPJBwZgHkitB/E09gerdbsnz+W2F318GO6xxjKSU+n0iGVRoM23R1GP/J6gOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094349; c=relaxed/simple;
	bh=aV7/ddYd8n/VEWp8goC8zoqNFJsPEIXQ1fyZbpIE3MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5Vjl1Spz56LwRhuESrj50P+llKNO3NqWQfdvy3fKqs8ygUCDELIJQR1jfCqKRYiTEan/M+PcZrldIxE3BcDpuJ/0/5V0eOUvfcGomYjZOxJs+gRW4PZotCWtT1IKr2oJV/2VFd/JbqAcWIsYAOrLOiJLUHKMzH8hxgpqr9HZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWKu5o3R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWKu5o3R"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso39305e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778094346; x=1778699146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWaGVwrz8dpWHB2wk2T9j8VY/b7+3Y4aZTgZzUxXD1Y=;
        b=gWKu5o3RyOAmPwD0Itg6JX/2tmc6Oyg8pNotuXzEjqnZgvJDPAwjmI430xHYDyeTv4
         W7DmYA3UpPUYxk/XVgwhRda8X8DQ1G4eqIaMUZMXn8DrSICvSS4BbDBwxma4h4KiYjfj
         id9VCj5qcf1pY5J8PeMZycuItc8vVaMNtEUCphPzVpZWEPstyzrK02QpBlseWIFkccbK
         eZuuZBoI2pTcxCt2o6D48k/4gmjkfXNo/1iXYxMqY/jDq05kjmPCizFwSwBCeGJMaCxo
         ZSE6D8hR0mB2ME1QPpmIRpOr/INtREV7sR/7cBgXRGzxKZEvPrdhnQTAmodvSIeKK801
         HS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778094346; x=1778699146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWaGVwrz8dpWHB2wk2T9j8VY/b7+3Y4aZTgZzUxXD1Y=;
        b=sZqka6CllxpbLqmgNByVx6oO5l49BoAiCTzxWBt60N5JJhzD0vz/FFEhADdJY0zFu/
         7TjFOnp65DnUQkxTCZR+Hjw6Bwi7zU8LxT7hagVTFLcEGcZSPzLMc2Q6jrvWI3CrVJen
         kfMBkjro+JYHM2EEpGFQjlKUDsfPhcQYPLRPVzoADrYZBNRa3+b6ymylSuqilpLHzbc3
         wmThmKEb68+mNJK++xaZlNLELlMQikgQ175mR/Qyey9HbMc67i4zAef+BzKjQ7lL08FY
         x1cAjfseTAWHesSlOoCywCxSpX6vhIf1qkQp/ATnAjk3BkAZUMxmWuEJGTbbYtSHJ4Ia
         a70w==
X-Forwarded-Encrypted: i=1; AFNElJ8pynjm/CBslKsR3t+Y0hntNpJqw9cMNKPpRiDSR206jhiDXuCj3g9z11esSmd6bNC7OIXw0u+Yj3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFT/utDRxT2GUhonvoG7/D/SNOjrSU67hfZ65O9EN4EKU5AfHx
	lZFPPLRav+BZorXPiC/vfM9NnfF8eWvsSD66OG2RTS72k+IV66Poc1Ob
X-Gm-Gg: AeBDiesOgjHq5MXy8uqDuSQOLmK1rGICSEVZpY2AUT7gsWFRqlynuEP1SMg0u2btwta
	J2eAadYFRMtKPEWP84iOWog7wDrjT/ZxC3AHZOYaCMqwqmojlmU+rZ9ic9rHJFZwjKyszNzG/sN
	4+fmnU2JOpF8lvvH7RkNKnGc035suPlc5txI26JBdEx/4voRaPjScU/AY9hG8ayQxi7PCUVEVti
	NA/e0TWMa4o3lDamxrrueMB5v3/PEMRyHE1nrABQVv9dCi93DUA78N13RB07iY63NvnqmWmk6Nz
	6+PHRWURDq3EbYZxV6R1k/1fYw8CgTi/f1e9H8k7PATPHtiLdNr8c4sjNU/oPWxYxfH9p6q8h/H
	lrgklZxFLBzqYumqS9iOwAmkiHZy74fF8WSJU2epoTp8ccwy769AS8087h1QFJNPrRaEJM2Y7gE
	s+smwnWoZN9UTpfEx0CrtemKjm8ZHY30fbnGZVMBWXfq6EWHHitPv9
X-Received: by 2002:a05:600c:4588:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48e52f1574emr36086805e9.0.1778094346183;
        Wed, 06 May 2026 12:05:46 -0700 (PDT)
Received: from LAPTOP-9UC0RPH4.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b212esm30832605e9.1.2026.05.06.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:05:45 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ulfh@kernel.org
Cc: brgl@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] mmc: davinci: avoid NULL deref of host->data in IRQ handler
Date: Thu,  7 May 2026 00:05:37 +0500
Message-ID: <20260506190538.596-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_davinci_irq() returns early only when both host->cmd and
host->data are NULL:

  if (host->cmd == NULL && host->data == NULL) {
          ...
          return IRQ_NONE;
  }

So we may legitimately reach the rest of the handler with
host->data == NULL (and therefore data == NULL). The DATDNE branch
already guards against this with an explicit "if (data != NULL)"
check, but the subsequent TOUTRD ("read data timeout") and
CRCWR/CRCRD ("data CRC error") branches dereference data
unconditionally:

  if (qstatus & MMCST0_TOUTRD) {
          data->error = -ETIMEDOUT;        <-- NULL deref
          ...
          davinci_abort_data(host, data);
  }

  if (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD)) {
          data->error = -EILSEQ;           <-- NULL deref
          ...
  }

If either bit is set in qstatus while host->data is NULL, the kernel
will crash inside the IRQ handler. smatch flags this:

  drivers/mmc/host/davinci_mmc.c:933 mmc_davinci_irq() error: we
    previously assumed 'data' could be null (see line 914)

Gate both branches on a non-NULL data, matching the existing pattern
used by the DATDNE branch.

No functional change for callers where data is non-NULL, which is
the only case in which these branches did meaningful work before
this change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 42b0118a4..42ad87aa4 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -928,7 +928,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 		}
 	}
 
-	if (qstatus & MMCST0_TOUTRD) {
+	if (data && (qstatus & MMCST0_TOUTRD)) {
 		/* Read data timeout */
 		data->error = -ETIMEDOUT;
 		end_transfer = 1;
@@ -940,7 +940,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 		davinci_abort_data(host, data);
 	}
 
-	if (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD)) {
+	if (data && (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD))) {
 		/* Data CRC error */
 		data->error = -EILSEQ;
 		end_transfer = 1;
-- 
2.43.0

