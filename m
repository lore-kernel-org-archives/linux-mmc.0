Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16681248F73
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566503; cv=none; b=eWfy5qdN+5MUVcC1ZNi2g+it4mt/txHrh30W7VHtHc6xsSP70SKwKbsiJn4WYf+tjWYTpx5vOpFJoGQBspsf8ti0aXjYTCrd5ARCIurx6+7WZLt8ZlPVP0ph40MRHySaoxFwbrK9UWOgAAmvLeynfBCzu/h5T5TIZec9A7y6p8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566503; c=relaxed/simple;
	bh=9XUhj/aQhEbqF1QEgvqMf1sfpXb4ZTg9F7SIZs8KIjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Psfqqrt/xKLBHsqFUV7I5hlWhrsgVEGii3G7iJm2jCegVz41vxV/B2xRvxNkOF9pmo94zQQEJKOODbwj3IugjJShMbuMpc8YmB2opTgIrW4myDcuMat+1DYbRBB+prVBqFKVNVumRP126xXtwxvpJPcKVniUbcTp3d44maS3jM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbNofXeM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbNofXeM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2a68d01so3463175ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780566501; x=1781171301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=36+Jo+RZnwMrw4XLYpXyQIN+lhgu1dY7S7BmHTngUjs=;
        b=pbNofXeM6unGgEM3NgrfKAH0ILq/fKnVty6fQ7BDmkvk1pE8udDUuR3AwMkXnHGOo/
         y4kbUa+zuCl5YmKgQ8xtydx4I9Deq+o4ciXlYC6bXBIuZ6tqG9tW4/eLxzGrs+obDadM
         0k+I6YU8wsTTeRtmBi2eIEIq9ofvjRxBZLvFShRcCHA8Pr9M2uSJiYSVFsJEYAQTO3r7
         c3HEna70meNspskuAx2Fnd9d1XzgbHi984wwN0Df5R7nqv010vlVHJkfHHkgIPNsV3X1
         +NmZCJAKmfuB0iQ5bPFr/5Vk+vbS9iMElQf6hVy06voch5LGNoojBL1mplvDjjLzI9h6
         e4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780566501; x=1781171301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36+Jo+RZnwMrw4XLYpXyQIN+lhgu1dY7S7BmHTngUjs=;
        b=f6nm8X/3LfPQfi1p31Sq9pnYc32W1c+JHTDk6yu4fT88Pw+8As7l2imW2Th9fiJXc2
         vuOLTSTK07H92st/KGYxkDW6y7uyvePUmQhfk0OXztFVhGtDKjiGln2P78Wv0Z0VuSiT
         71Om7BxQoUS3vy5G/jgQv7U3AV8FSJ/T8I6Jzyj7ffw7aZQQJzhBOKcDsWIqDZSJU9Pl
         KLZFnCCk3wyi9w4xNkMBooH7/zqFWJq3KkWovF4ej41XTwbJA6MOEvFdtl8wjUOyKpXC
         5X2Nc8PVUpSACD0xVrvPPGmk10DeDr+DVLEXcJFuA0WgSFGTwLh9mnTc7CFzpMiZLC5z
         kJrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OJf6tnFg3YGmGtl0XZM58YrcicQVu+aCc8rcpNvW94Xiqc6ohB0cj39mFr/17PxGLo7WO8LP35Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Rfv9uIk6Z6Nm6Y8EFUTBVlKteoRmwzWzT6jAdu+BreO/5bVF
	/AK6hREcIYpjJaTy9riEuADHlE3/rrGH78kAVQdANCXUAKy+pztAT/MM
X-Gm-Gg: Acq92OHjdXc997qZ3IVBHRf8PeR+4rh+nbVTymfvUjGefZoeIG3LQ/bqAxufA+WIk2b
	2tKK45BJdGMwOUq3GdhfEiXVtm1WCgb1gFyuqmz9e0q24IPGvvwkOnMfdGqcGQ9qoVU64aX11Ox
	xtClw3r1e4E98E7J8p5xN6xyRFHQekTGTK58x83kwKDPM9ql9eiELqqJzmePQiWTej/ANi68La7
	2gFmNqSCsY1smipsAWAmFr28Ur71k+b0LPc6KoEaqMyJwEsxgeC7TSjwx6Q5TvKtJgxHVO16TBd
	YhBNFKhLDIcs/QxzD87a0Zrv57aQO9NKfC6/PveCqUQX/VswawfutRvpaQsMsrJKA274Yua7UyF
	LCXJXNS3qW48zqR36SgVedXivXV7RCBps08Ce7i9YTK007dZrWEuBIopUE4ql9puTI51f++ao3F
	wbMXbwQQcw73ymtE3taBkk4Shs4rQKI2D9nw==
X-Received: by 2002:a17:902:d4c7:b0:2bd:606d:b339 with SMTP id d9443c01a7336-2c1644a9b5fmr73325875ad.21.1780566501251;
        Thu, 04 Jun 2026 02:48:21 -0700 (PDT)
Received: from lgs.. ([101.36.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm50627395ad.32.2026.06.04.02.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:48:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: vub300: fix use-after-free on probe failure
Date: Thu,  4 Jun 2026 17:48:01 +0800
Message-ID: <20260604094801.1418367-1-lgs201920130244@gmail.com>
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
        add_timer(inactivity_timer)
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

timer_delete_sync() only waits for the timer callback itself. It does
not flush deadwork that the callback may already have queued. As a
result, queued deadwork can still hold a kref while the probe error path
directly frees the backing mmc host, including the vub300 storage.

Fix this by making the post-timer probe error path obey the kref lifetime
rules. After deleting the inactivity timer, drop both the timer reference
and the initial probe reference, and return without falling through to
err_free_host. If deadwork was queued, its reference keeps the object
alive until the work item drops it; otherwise the final kref_put() runs
vub300_delete() and releases the mmc host and USB resources.

Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Rebase on current mainline.
  - Correct the Fixes tag.
  - Add blank lines around the early return.
  - Reword the code comment.

 drivers/mmc/host/vub300.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6c3cb2f1c9d3..1b46bb87f39a 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2342,6 +2342,16 @@ static int vub300_probe(struct usb_interface *interface,
 
 err_delete_timer:
 	timer_delete_sync(&vub300->inactivity_timer);
+	/*
+	 * vub300 may have async references via queued deadwork. Drop the
+	 * timer and initial references and let the last kref put release the
+	 * host through the proper destructor.
+	 */
+	kref_put(&vub300->kref, vub300_delete);	/* timer's kref */
+	kref_put(&vub300->kref, vub300_delete);	/* init's kref */
+
+	return retval;
+
 err_free_host:
 	mmc_free_host(mmc);
 	/*
-- 
2.43.0

