Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6894A3D2C
	for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2026 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282535; cv=none; b=ppftLntEnJjbc+cfgj5Mb1qlitcrbSlEW7qJOIIFTKcmyQe7YlToQjBng9UqjDJXjlqbDrCvYMAHCDkqDcx9AOfEtgrcrY5M5fdW3NfzltpmCJZ7r8wvIgT2mPbhsuYT/xhykL7cBvOdwQCxxPaob/qvxNKWX/NbGGTP/hB8+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282535; c=relaxed/simple;
	bh=OzqluZqRVfMingGFZl8Ew6dmAbmJFB15xftTLwFF31c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWFG0GdIq3tmTA1E+8/GSjEezX2kWAqlRoR1QkB1XqU5CTLnwocxJu5iXzVHR8vNkHXSw+ONCtIuSPUvnwkoHoIE+G8x/OPtv7g3x3cMvCJLw/GmL/gteCKOu5fYtSbd4kg3bU9H/oMkdxVNxLsQE0XeBLdVLtv/TjWa3U3LIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCmgC5CE; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCmgC5CE"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f089b1e3so223831c88.2
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2026 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790282529; x=1790887329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FULwkoFMwVo8tcQ8iB8waPMOVXDiej94ubxh80J+bpE=;
        b=tCmgC5CEVmYmI9p1E0BlNMnOOrtWt46Zsy5xh2nUMCCWGFkpAKMHU32hgdAti0Blhk
         ++3Iku1N4Z8RkiDJE44SWvAa5Yij1DFHOIyHiLZXW/F+rWvo2wUUDiazJs2qTd9IESRk
         ORMbXWCXRHePw2euUHmzJ5snZOCJPu8/pfZbZ21iwaWUeBmpBPwtymHd3STgtxP20Zt6
         DNU4lJUZq4KpjB1ZjFoo4eKkZaqpDUn+wQnfi73kkmvg0fme+nzvZ/qx4mQK8LvL7oJ0
         XMz1pRFSmFWuQju/WJvg9OgO0Y71d45flv6Vk8wTHP73kUYoUoMQbJcanuCNcsbcmoOj
         VMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282529; x=1790887329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FULwkoFMwVo8tcQ8iB8waPMOVXDiej94ubxh80J+bpE=;
        b=eF1+9repEDlgzTAPyQ4h/kqhJ7ys7mGSQ46SX6mhrstDv20AFkfYmyImIilFktZ13C
         qcgCqE6FQYQMtbFFDIce5wc9iqIGaJHRC8SmdySszsC6Jbu0xnlG9WmfWKZseMnT8i/9
         j5GoBYzurvQkEeXN/C8zowhCHGpCMm88wVc7XTE10lK8xlm06Uw9n1awcL3COdN3mIKg
         TW15MyhcURxzv0NfcoEjuTd6xSi+vQoO1Glwtu9PFBAnrltmI4Kg7U1LlBZyGGr79lSX
         xobL9yPJsEzVjXkojC/em4q/YMyUQXzmLz+h7dlpImOx4r/547Vggyktb8zuhrAiZWdG
         xwSw==
X-Forwarded-Encrypted: i=1; AKwUvBzZN5gACAKPZWxlk6aperpQmlrq4MlbHBf6tSPDTDQl/R/EZMvLwcxQRPX67M82JbxkJxSdXAt2Pik=@vger.kernel.org
X-Gm-Message-State: AFuF++lvG2IFagBe3e7kNZZ3Q/zoT9DxEpstEGVlzDkCGLQHi9qvD70d
	2OxJdT9WEHnehpXFyQ0V0wTWzCqgkqo+wEP0iJN7VSj3Fhj8ApWkL2Rr
X-Gm-Gg: AYBFou3ii6oJcyBZWbEQrqD6YLrSKQk8vucEv0ffT/6S/m8a40IZRUnO+1M99iYn3Uj
	5meK5MZBvIAx/ovXxzkORDalsiDNG57Pk6c8zEILCctG9W+JXUZ3dEBHUKwYOdOR0N3KEUZUaMf
	HAovwX0ZXgZSNVhpNGekeBCwZcayjAGhGd22ig/9sPnpFWJ1rkDStYvLc96pbpbpp05bcm42BY1
	GZPAB+TWUEbgfvQkrJGBsBrzYDwkCoPILc0X3I8cKzKbwiTOyrwnm3WRxGBnVhX3RU5/9hknEhI
	RXvl3ToG/opkClqMRGr4BVeejUU4VlMWOGq7xdcKAUf5OHdLnY94Cdc6k7hD3chPM4Ne/SKDsKs
	PKKxGFoIoSjiP+3ggY+s4fh2H/JwOMwMfEaiDds6nDWk4WPNEddNOuNmimIkv481Ng/lU/L1CPg
	nkp3RFfaiS/VHwY7CNjDupO5n3BJxBFmVvGtNUWMvQiQ+NwArHQQTYdzo/mUhGZ7eKtp5eu+lqv
	7C7jfJKGAHdpuNJd8KBr9KbWA==
X-Received: by 2002:a05:701b:205b:10b0:144:eab0:8373 with SMTP id a92af1059eb24-14503f6a391mr2766998c88.13.1790282529002;
        Thu, 24 Sep 2026 13:42:09 -0700 (PDT)
Received: from localhost.localdomain ([103.77.186.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414485a9cdsm946902eec.16.2026.09.24.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:42:07 -0700 (PDT)
From: Raj Ojha <rajojha047@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Raj Ojha <rajojha047@gmail.com>,
	syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] memstick: core: wait for request completion before freeing card
Date: Fri, 25 Sep 2026 02:11:42 +0530
Message-ID: <20260924204142.607-1-rajojha047@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In memstick_alloc_card() and memstick_set_rw_addr(),
wait_for_completion_timeout() is used to wait for device identification
and address configuration requests to complete.

The memstick subsystem does not provide an abort or cancellation
callback in struct memstick_host for in-flight requests. If
wait_for_completion_timeout() expires (for instance, when a USB transfer
or command retry is delayed), memstick_alloc_card() returns an error and
frees the memstick_dev structure via kfree(card).

However, the host controller driver (such as rtsx_usb_ms) is still
running the request asynchronously in worker context. When the transfer
eventually finishes, the driver writes into host->req->data, which
points to memory inside the already freed card structure. This leads to
a KASAN slab-use-after-free write:

  BUG: KASAN: slab-use-after-free in ms_read_bytes+0x8fe/0x990
  Write of size 1 at addr ffff88813c188079 by task kworker/1:5/5239
  Workqueue: events rtsx_usb_ms_handle_req
  Call Trace:
   ms_read_bytes+0x8fe/0x990 drivers/memstick/host/rtsx_usb_ms.c:450
   rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:477 [inline]
   rtsx_usb_ms_handle_req+0x557/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:531
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
   kthread+0x373/0x450 kernel/kthread.c:436

  Allocated by task 1662:
   memstick_alloc_card drivers/memstick/core/memstick.c:383 [inline]
   memstick_check+0x2c1/0x10d0 drivers/memstick/core/memstick.c:452
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396

  Freed by task 1662:
   kfree+0x20c/0x650 mm/slub.c:6792
   memstick_alloc_card drivers/memstick/core/memstick.c:420 [inline]
   memstick_check+0x72b/0x10d0 drivers/memstick/core/memstick.c:452
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396

Host controller drivers (rtsx_usb_ms, jmb38x_ms, tifm_ms, r592) already
implement their own hardware and bus timeouts, and callers in
mspro_block and ms_block already rely on wait_for_completion()
unconditionally.

Replace wait_for_completion_timeout() with wait_for_completion() in
memstick_set_rw_addr() and memstick_alloc_card() so that the card
structure is never freed while an asynchronous request is in flight.

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Reported-by: syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ccffdf05833ebdaeae70
Cc: stable@vger.kernel.org
Signed-off-by: Raj Ojha <rajojha047@gmail.com>
---
 drivers/memstick/core/memstick.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 7f3f47db4c98..1a2b3c4d5e6f 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -378,9 +378,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
 {
 	card->next_request = h_memstick_set_rw_addr;
 	memstick_new_req(card->host);
-	if (!wait_for_completion_timeout(&card->mrq_complete,
-			msecs_to_jiffies(500)))
-		card->current_mrq.error = -ETIMEDOUT;
+	wait_for_completion(&card->mrq_complete);
 
 	return card->current_mrq.error;
 }
@@ -413,9 +411,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
 			goto err_out;
 
 		card->next_request = h_memstick_read_dev_id;
 		memstick_new_req(host);
-		if (!wait_for_completion_timeout(&card->mrq_complete,
-				msecs_to_jiffies(500)))
-			card->current_mrq.error = -ETIMEDOUT;
+		wait_for_completion(&card->mrq_complete);
 
 		if (card->current_mrq.error)
 			goto err_out;
-- 
2.47.0.windows.1
