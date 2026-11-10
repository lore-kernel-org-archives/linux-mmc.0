Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285015;
	b=udC34llakPu2hh7XTCNE0sgPi35NCaAonrDa9l2TDvcNAN7kdBrrChZSS9HHT2rPfIoC
	 eFfZZPJUa3Mm2zkimOIC7rjU0bD6fKatrGX1QOpBb7yV93vZKW54m5ZOl5u34rw7AYTFN
	 WgGdEDTIQ06cHf2A180FZEOcwC0kFKOiFAs0oNjhkNvsU8uELevaTSjfGfuOXjm/Bv1s9
	 Ty3NBdRmdLRx13MzSmeUHR/ls+6j4d+KzHvRewNjV2jttpxdcBbvYWRI6sH8KTEAS/Gek
	 xSIj9bJHzNBou14l/jWjxzeWgd9r0RBgx6mP2wtnK/G5tFXc3BEVp0qq1U96FZ47cWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WsSLHGnK7HTgTyexFfYUW9M44U5fpvmPCQ/caosU9hE=;
	b=TtcWaNpCnWEWdVr6rJvz7u5ZYM/whgqlaFXCtAz+zgVk9QLbY1qd3O5Woe9Vbjvkq2b1
	 VPB8DC9SThocBIafozXhJLuKv8v7YNfPy4eEd3qYUr+GQzMChnXdCnRbHR/YN/e4kLRKf
	 fObLOVALOoTLFctKDjiQVKW6M3RfQOZSqhZRTeEPBCSepJOL5y54Hvu9HaKDbvcCVolX5
	 PT8Bod5dxa5wQ76O/yMc/KNZgpocqHIQPKtE6aUseRrkSz+HzSqrPsGD2eAkHOmTE8mtr
	 SoFN7pSfGpF4LjdJi54JSEw4bx/HgQRK4cMpz6Gu+sJSzRiHxbDsNl8qKgCr2o69l2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5+fZx9c;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA8606A33D
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 04:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFA8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5+fZx9c
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f30660e69so128281685a.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285013; x=1794889813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WsSLHGnK7HTgTyexFfYUW9M44U5fpvmPCQ/caosU9hE=;
        b=W5+fZx9cVh5JpgpRFqmhQ3HMG14XtDuE9pttcjkhvhpyLGfdTvvjVe9ADn40mNYN5M
         /X1XSBiKzsql9aat5AR+ALWaLb1dCSPz18Z4MPID0OP7uYSM0U9/18sYyJQuL8n01Hmq
         dOGAOtS0jOYDMd0OTCbolo2maKz1q+XEeFdWu5H7Fgi8XFHsxK+8xSjQc8TQ9rgzpdAU
         06L5ZczAJi+gfWAS+vaahQXdUzxXzO+YWRAg0DPK8PSD8t/Klclr3/qNjLXf45idqFpW
         4VGNIVn0K4YGF0YIKzGTp/Y0IQ69vwUvpKL7xelN+NdBkZ8OO8Rs/PO/ODxWfsFsZ6jY
         XixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285013; x=1794889813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsSLHGnK7HTgTyexFfYUW9M44U5fpvmPCQ/caosU9hE=;
        b=N81Xzz84F9booRDJ1TBqD/S4c3FFNPO3lO4fUY9IM9JpVYZ8sSgWK0bRVWXuegO3+i
         xtnBOCeozWn2PH/euYfV4v8//jz6IvPLEnrklqNATnDsAAq1tjbPDDDWdAdDKXSZgWER
         UvKYUQHhqhyO1MS4rpJaUm09ZwBicA/kTROk9Rh5frwIk8oZAkvFZJFSDx4kMtwiYKPi
         XxWUYe88RyFaa/s5z7/bMObFFPVLnoPY/runfVEmqP+gIxN+rKhPTlEiA+r0ZP3EnaPq
         fERK/FwfAxOvQUq2bU+1xkm7n4GdB9gWeDtB0Ka0B0xtEnm5jzncARQFPMj1Ou/bh583
         +qwg==
X-Gm-Message-State: APuU4Z++2VFenEIrG6aEt6kkx7alGgonydDV+ouAf0S6yb6tSuLjGJyy
	IOdT+yeMaLaIRDqeJ/mpsctjqXNnV/dli09CQxQsSaRExHFAMsYJ2II=
X-Gm-Gg: AYBFou0ZZJaVG7C564xVOgEaFQ6A2SzZiRfntxuFLWm/emID9e/vGCh6vnE+hqvWH6D
	lIlKsxd3RZMxlwEVL5xwxh6ovbztGNz5ep1OIM1IN1ggST2yJY/6ltZerjj0+CPr/FJ7bINEFFw
	Msqhg0FgUVeyFPG9QEz2ZuOEHKbQXnMyZycgjWhTrxjSi7chK3qsUfAYzpGVXTk8y4gt5uLTp6f
	4EH2UV2dPTV0+IBZp6GJsA615mlHFpjvDd9MZi3QXNcxXXEy94sQ+B1UFtLs+kZVSQGskrG+fmb
	8iFBX/0hf3IBTcO2RVFY3Dl4Nv3ujFiq8SQDChamDWSrwBh0wmFcrKejoeZK4WBaDK9zMaXcM9L
	3t5Dh54FMtnRvfZKJhft0m370b3JqcFq3FF8HAz6/w+XEF1TO7vy9YjsBFFUZM3GQjQFO2hwL2w
	BN87E9dPqIK8Ty5RnX5duKWuQb4AvtrAD5YJWzWItO+S4YWyMBpCp/k4nQQlj3J+pxEy2CGdUvC
	wP9PFsb4ag9Ry/KDsa+Pa07v1FmZyjhZMqfWcUtZzSOsfZoo14e8V/lRNT9rosbXvgkcS0VG0Fe
	Ov8COE8PY24eosxpCQhJOjFvBUGqr4bNWI7VJkmF+LiMPC8eLWqe4eB2YhnIzcfJThlnly7XGU0
	YN0FCtLC9hYM/Q6rjNz+J1F8MCZGctJfVv+WofBpA54C6Ex5yDYKuKlO7N+yanruF
X-Received: by 2002:a05:620a:6c84:b0:93a:14c:32ad with SMTP id af79cd13be357-9479f09bf6fmr258929185a.0.1794285013134;
        Mon, 09 Nov 2026 20:30:13 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e9b4bsm134049385a.39.2026.11.09.20.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:11 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] memstick: r592: shut down the detect timer on removal
Date: Mon,  9 Nov 2026 23:30:08 -0500
Message-ID: <20261110043008.56716-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

r592_remove() deletes detect_timer before freeing the interrupt.
A card insertion or removal interrupt can re-arm it in between,
allowing r592_detect_timer() to access unmapped registers and queue
media_checker work on the freed host.

Use timer_shutdown_sync() to wait for the callback and prevent
re-arming. Keep timer_delete_sync() in r592_suspend(), since the
timer is needed again after resume.

Found by a static analysis tool under development.

Fixes: 632644227850 ("memstick: r592: Fix UAF bug in r592_remove due to race condition")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/memstick/host/r592.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index dc3de63901be..399873a61d1b 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -827,7 +827,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-	timer_delete_sync(&dev->detect_timer);
+	timer_shutdown_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

