Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB570416D1D
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103402; cv=none; b=c+Xx8hkZhkHEfxIy605tq7bci7YApT5xBTKTDys5ieCkXkXVXj4p0uupmAC57AxYxtbKPupxIbt5Di7AoBefqhiEMxqhZtL4lgeuHSr6ByWdDtZOd93vyXYCWUhbaj1oOj3lg/dRRTWLNgmLYejHd2U++gLUTNVNfpGJJHdJVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103402; c=relaxed/simple;
	bh=qJiyqTiUqE2JsEygmzanUv913s8+5r0Gvkz8I4ZNj4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z6CTQKy4vZ4PFJRAj8nIdFjEE61L0nWbyEqibCZDNCQCtgWxJv78w5zWSVpZd8ILZ8Km3GJkVFi8fvV5J+1kO0XkppckY1Ht1ySsvLEL3eEggbMOXOADyWNO178QhASsQan4bVkixsCbL6JOeaw80QMQNJvJICsK7i7tuWWluvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+LyffbB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+LyffbB"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842848fd613so5769123b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781103400; x=1781708200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=je4HaFTs8UVFY8caIrZkNXgrHjfsHHR5Ao8SCT4Iyeo=;
        b=o+LyffbB2j/wf7t4Z0zG7QE16eJ5Q1BV/oP4MN+JG3C7NqsK3qGQ7KXlqSGQ0P0FPD
         l8QnVmL3xcyfd/aP9L6dJ7AfO2Etm3fxUoaTOOHOaKjoMhkio/yB5rlpfF+oJjkJbPKf
         FqKBNgL+EpCssqBuDs78/x7uJOW2eMh4G6o4IGBbz/oPCugfseUYcqF6FlxadjvvUQkU
         NCVhaEM3ZcIBRywDM1HNNOSC847UH73yI65tvfByVrkg3Zpm7DrghGhxiY1TbfqPSJs/
         /R6S3ZjkKuhMW2t1J/rEWEuqQto8raL5FyGqkLrfTXRIxrI2pv9bLc4RyA+vG6VUWoW8
         lt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781103400; x=1781708200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je4HaFTs8UVFY8caIrZkNXgrHjfsHHR5Ao8SCT4Iyeo=;
        b=QbZ5Lwu2WaYS3PyDBKw1lCAjs0eh5/hfpomMlpwNy5YT4uV/8ZlHGGVC4/4qs6gfrp
         jiMZAN7V4FEykFjTDHAwGquyA2xZ1qsum6AW2UE173bu0+hvBohhWVfZUaMZutg3Fh+R
         y9NYTIbJXF/9FB4kYheJY86cCU1b/bNtGf4BjAiOZTfanU1+PsSZIKwEjsj2CSX5GTIs
         Zjzr/pqpOkSuV0t1AGnVAmf8QN/qHMLwdMOkjOzc1a0e/Cdxje9b7QMEF4USiFHWSmDk
         3wsjfWPmhSCxqhVTbUkbnWrHu5LYUkIttz+3+XyF+xrVo/wAPBCREi7ZAl58vSQbLR6o
         GP0A==
X-Forwarded-Encrypted: i=1; AFNElJ/triHgEFMPKwv7drtBsA3AS/SyXX3ZLbQPW0KaVs3j++las7jv5bEoWbmmUhQ/X2sxl+rDXHNISxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjbAK6UBDKDaUSl1ZKYuCNsFW9ccnLE4VXZxE40LzU28Df+jm
	TmME1vzUcDVq5RS7Ol67S0bhS6Zs9ZvXPVMYeG6YkjAqSeQIMUBfHaob
X-Gm-Gg: Acq92OFi2WjLWIv4TJHtLiSnktKPTYQDzZ+0/udUFMyst9ZLxQ4tAoCZCckhZ/rZKto
	Mz/uEWuR04ATIzFTitgBKcw72sXVBCO2fqTovMakhivYOJf6Tbp1h+jOJPMV1j6X+IXMSDmo+lS
	xGk05Szby6c2hapgH2h3znRgTJ6NulcAJsSr37Or+iy5AKZjm1JQSt2ZfMFE90ynTTtSQz2OPHa
	5B2SRrtfuE5f15TX1MtVhPFZEtstwJV3lD9SuP1HJPsVh3ggU2ylf7a9OjsRyM0+16OaH1VEYeM
	9tbBEuNhRWpbxnnw8lAn0fvLqb7drKsQB+yA5B9fUrAAGLUSURNLjoqNbSTGwSlm2SFJ6MVveCz
	4mwGsan4V5AUvhFnCSN4Yzzqg5LRjna8dWmx/8rC7asjRyVvqLTSx+eLxrJ7hlU/Odiru5Cw4FC
	oVXOOUmv3g2VUhtfhbIeNHVWc=
X-Received: by 2002:a05:6a00:1815:b0:842:2cda:7a9c with SMTP id d2e1a72fcca58-8430a70be0cmr9405477b3a.29.1781103400129;
        Wed, 10 Jun 2026 07:56:40 -0700 (PDT)
Received: from lgs.. ([118.193.39.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282880050sm24488651b3a.29.2026.06.10.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:56:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] mmc: vub300: fix use-after-free on probe failure
Date: Wed, 10 Jun 2026 22:56:30 +0800
Message-ID: <20260610145630.1788731-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vub300 driver lifetime-manages its controller state using
vub300->kref, with vub300_delete() freeing the mmc host when the last
reference is dropped. The probe error path after the inactivity timer has
been armed still bypasses that lifetime rule, however, and falls through
to mmc_free_host() directly if mmc_add_host() fails.

The race window is between arming the inactivity timer and reaching the
probe error unwind after mmc_add_host() fails:

        probe thread                     timer/workqueue
        ------------                     ---------------
        kref_init(&vub300->kref)         ref = 1
        kref_get(&vub300->kref)          ref = 2, timer ref
        add_timer(inactivity_timer)      fires after one second
        |
        |   race window
        |<---------------------------------------------------->
        |
        mmc_add_host(mmc)
                                         inactivity timer fires
                                         vub300_queue_dead_work()
                                           kref_get()          ref = 3
                                           queue_work(deadwork)
        mmc_add_host() fails
        timer_delete_sync()
        mmc_free_host(mmc)
          frees vub300
                                         deadwork runs
                                           use-after-free

The inactivity timeout is one second, so this would require
mmc_add_host() to both fail and take more than one second to do so. This
is unlikely to happen in practice, but the error path is still wrong.

timer_delete_sync() only waits for the timer callback itself. It does
not flush deadwork that the callback may already have queued. As a
result, queued deadwork can still hold a kref while the probe error path
directly frees the backing mmc host, including the vub300 storage.

Fix this by using the same lifetime mechanism as disconnect. Clear
vub300->interface so that the timer callback and any queued deadwork
return early and drop their references, then drop the initial probe
reference and return without falling through to err_free_host.

Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v4:
  - Fix the Fixes tag to point to the commit which added the
    mmc_add_host() failure unwind.
  - Add Johan's Reviewed-by tag.

v3:
  - Use the disconnect-style teardown by clearing vub300->interface.
  - Drop only the initial probe reference and let timer/deadwork drop their
    own references.
  - Mention the one-second inactivity timeout in the commit message.

v2:
  - Rebase on current mainline.
  - Correct the Fixes tag.
  - Add blank lines around the early return.
  - Reword the code comment.

 drivers/mmc/host/vub300.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6c3cb2f1c9d3..c1c21e95f5bf 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2336,12 +2336,16 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto err_delete_timer;
+		goto err_stop_io;
 
 	return 0;
 
-err_delete_timer:
-	timer_delete_sync(&vub300->inactivity_timer);
+err_stop_io:
+	vub300->interface = NULL;
+	kref_put(&vub300->kref, vub300_delete);
+
+	return retval;
+
 err_free_host:
 	mmc_free_host(mmc);
 	/*
-- 
2.43.0

