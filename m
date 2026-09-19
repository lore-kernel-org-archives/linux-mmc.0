Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0443C047
	for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789812272; cv=none; b=EsrA8h1Vu9TeCu1OkqHyuNOmeJroULLPAZEH/ZeL+YqGql6eB49V/rvBTHX7aTcZU06gcCYPJufsjhhw0im9yX5k8OaUNhHx7hDVD0ESrWSKo/HwFVadH1stm443wYS/g/nsYKeVjzkDZlq0T935ks2cLYdR8oSwBtY9hQvKc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789812272; c=relaxed/simple;
	bh=0EHaYA31AKMkwGKZxxnGPfk5inRyKwHFRdZ52h6KFJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAk8ehpi3FV9MvqpQjdgpA/DpKAS6fh1vXV8WCbGEyQA6M1o3iK//lQC82Hvb3y2mQivkdfSUx5pBcgoLNzDDu1Qnhb02EYNjPMdPMd4vTVnzIq9J1Widyc0UECWUW8gKcfZiAq3mrHdPs+UYFhVrMJBkuydez9MqMV7sSOslNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht7+6nHx; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht7+6nHx"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1164775a91.3
        for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789812256; x=1790417056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQH2rf6Bzcf6E6BADc6NPp0Qmbe39wDm40LygUzO/Os=;
        b=ht7+6nHxEVp78xrB0wgCKi3OhuSe+YeGfdWr6KpaGg9J9n7ZdXQGT7kW1JtAeu4UqH
         0Tuei5JETBDdlMaBF/rEwA0k3mpMSgtkoQKZJC7yCyrDqRDSiJnY5lszQvNiwq0uLIIy
         YWXcCSUMecRVs2tgf1bOS40bjm0yV7fB8bRz9oJgiTzOJKUnnPnaP7Apcn7d7CRWri0X
         ZWNg4Od3AQpx5USfwWK4p3CEf/RZEmHQtVD+S3UwVFTRD/XB6L3bkYBpKKdwCLZoe6JG
         inWFAYwUB1tzmYkbS0EeVu9IkPqI1PZJn8NqsMTU29rD5HJOJ65ZoP8UiKtGIev4TYLp
         Cs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789812256; x=1790417056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQH2rf6Bzcf6E6BADc6NPp0Qmbe39wDm40LygUzO/Os=;
        b=YBSWKyOMLeNxCab4mx5gRPmZOPGsAxQ+tdTMhL0FfEUep8Zv4zrn3DIN6JF076n1An
         GEj443yGh1wSYPpTmMLloNcH+nArhYCLQ5ezTiOygjpXYxH0gJ/CvhDFffLsFgqlwcXb
         NQCbYHVPC7qfvvBMePkUdgketCUYF4pYnKZ5+q9aBxFZCnWxYIJRkJJZiA/0vMU94TNH
         wQ17cpmBRaYxoWC/47uT1e3xJTwzoiNIKt9+H9/LjYUwRgN+fqTMQL+uiU23KkGWdT6d
         W4G3JKflqXpJ3hShyjxtA6d1frwTXOjk+Zspeiw/lRqoU+M+JtJkmCfJq8x2SZRSPV6h
         sBwA==
X-Gm-Message-State: AFuF++mi75jbFhBJo+50vjs5aymAYMMHtFpzudK7UFYpa+yjgnReIOOR
	P3zRHAfmG3aJqFuwgvEulYX2iWWPBk3zTM7Hl5GY9Bi0Q6csDianGv1V
X-Gm-Gg: AYBFou2e8Z9AEn/IDJ+evUC9I48Bow09JixmxmmIs6kpq+wW11D2LrrKqlzwao9Ezop
	3L0tq6712DY5GsZQNgbmK4geKb6HQ9RYY+GksFmrQvO26vWH3mxmpLcWheY7AFzLrjgDR03TDjf
	N4ULL+MqKNF2XCTXcG+yUm5Ch3paTiTOxtwO7Y55AW3xqSzDbd0nXjOf8fmL6bSCDEPwhK/J9hj
	1ftSx/w3SWn7O0tzetxuY0pBKGwL3/7PX79ytCOek+xLkUiTNRgIKOlB04KSv4AuBaDo8RelhhT
	OjzbRuOxSBe3N33XupRSCjGirrhWRcM+yMCJMVmDg1Ud0s4DgrqgJwP6bxWJoNM3MP/LH7019y2
	b5JjL2GlqqD+vlu+sHmpbaRIXrz4pTJZNnKN9z5Upi7ggtuK1CJFOw0Ub42pOtDUmv3DCT+RgW9
	wM01xLu9zdnOw5YzgP0Ls5KYIJArWxyTgbcephLg4Q/YR5B23AV3MEYwUWDU5hLgOCFUkJBHfN0
	9rTDfLvAhBC1EQCn5N3OFL1A80=
X-Received: by 2002:a17:90b:574f:b0:39e:6a81:f34f with SMTP id 98e67ed59e1d1-39e6a81fd3cmr4027760a91.41.1789812255651;
        Sat, 19 Sep 2026 03:04:15 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:814e:e9d3:767e:9a2a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm3843697a91.4.2026.09.19.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 03:04:14 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>
Cc: linux-mmc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: core: reclaim the request before freeing a timed-out card
Date: Sat, 19 Sep 2026 17:04:08 +0700
Message-ID: <20260919100408.113979-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memstick_alloc_card() hands card->current_mrq to the host and waits 500 ms
for it. If the host is still busy, the wait times out, the card is freed,
but the host keeps its pointer to the freed request.

rtsx_usb_ms hits this easily: its handle_req work can block in USB
transfers for seconds. When it returns, it reads and writes the freed
request, including the retry path in memstick_next_req():

  BUG: KASAN: slab-use-after-free in rtsx_usb_ms_handle_req+0x17ff/0x1a00
  Read of size 1 by task kworker/1:3
  Workqueue: events rtsx_usb_ms_handle_req
  Allocated by task 1656:
   memstick_alloc_card
   memstick_check
  Freed by task 1656:
   memstick_alloc_card
   memstick_check

Add an optional host->cancel() hook that stops the host from using the
current request, and call it from a common wait helper on timeout, before
the request's owner can go away. rtsx_usb_ms implements it by draining its
work item. The helper also covers memstick_set_rw_addr() and both waits in
memstick_alloc_card().

Reported-by: syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee5da0319ca17ef1f4e
Fixes: 99451dceeb5f ("memstick: Add realtek USB memstick host driver")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Testing: no hardware. A raw-gadget emulation of an RTS5129 (0bda:0129) on
dummy_hcd delays every bulk-IN reply by 550 ms (above the core's 500 ms wait,
below the driver's 600 ms USB timeout). On a KASAN kernel the unpatched tree
reproduces the report (same offset and alloc/free stacks); the patched tree
takes the timeout+cancel path (~0.6 s) with no KASAN.

I first considered a second unbounded wait_for_completion() instead of a hook,
but rtsx_usb_ms_request() skips scheduling once host->eject is set and
memstick_remove_host() flushes the workqueue, so that can deadlock.

Known limit: cancel waits for the worker's remaining retries (a few seconds
with a device that never answers) while memstick_check() holds host->lock.
Other hosts leave ->cancel NULL, so their behaviour is unchanged.

 drivers/memstick/core/memstick.c    | 22 ++++++++++++++++------
 drivers/memstick/host/rtsx_usb_ms.c |  8 ++++++++
 include/linux/memstick.h            |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index e03989c4e99e..ea09a63286bb 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -359,6 +359,20 @@ static int h_memstick_set_rw_addr(struct memstick_dev *card,
 	}
 }
 
+/* On timeout the host may still hold current_mrq; make it let go first. */
+static void memstick_wait_req(struct memstick_dev *card)
+{
+	struct memstick_host *host = card->host;
+
+	if (wait_for_completion_timeout(&card->mrq_complete,
+					msecs_to_jiffies(500)))
+		return;
+
+	if (host->cancel)
+		host->cancel(host);
+	card->current_mrq.error = -ETIMEDOUT;
+}
+
 /**
  * memstick_set_rw_addr - issue SET_RW_REG_ADDR request and wait for it to
  *                        complete
@@ -370,9 +384,7 @@ int memstick_set_rw_addr(struct memstick_dev *card)
 {
 	card->next_request = h_memstick_set_rw_addr;
 	memstick_new_req(card->host);
-	if (!wait_for_completion_timeout(&card->mrq_complete,
-			msecs_to_jiffies(500)))
-		card->current_mrq.error = -ETIMEDOUT;
+	memstick_wait_req(card);
 
 	return card->current_mrq.error;
 }
@@ -405,9 +417,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
 
 		card->next_request = h_memstick_read_dev_id;
 		memstick_new_req(host);
-		if (!wait_for_completion_timeout(&card->mrq_complete,
-				msecs_to_jiffies(500)))
-			card->current_mrq.error = -ETIMEDOUT;
+		memstick_wait_req(card);
 
 		if (card->current_mrq.error)
 			goto err_out;
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index beadc389f15f..403144a39a53 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -551,6 +551,13 @@ static void rtsx_usb_ms_request(struct memstick_host *msh)
 		schedule_work(&host->handle_req);
 }
 
+static void rtsx_usb_ms_cancel(struct memstick_host *msh)
+{
+	struct rtsx_usb_ms *host = memstick_priv(msh);
+
+	cancel_work_sync(&host->handle_req);
+}
+
 static int rtsx_usb_ms_set_param(struct memstick_host *msh,
 		enum memstick_param param, int value)
 {
@@ -787,6 +794,7 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&host->poll_card, rtsx_usb_ms_poll_card);
 
 	msh->request = rtsx_usb_ms_request;
+	msh->cancel = rtsx_usb_ms_cancel;
 	msh->set_param = rtsx_usb_ms_set_param;
 	msh->caps = MEMSTICK_CAP_PAR4;
 
diff --git a/include/linux/memstick.h b/include/linux/memstick.h
index 107bdcbedf79..e86f7f6e3e4b 100644
--- a/include/linux/memstick.h
+++ b/include/linux/memstick.h
@@ -285,6 +285,8 @@ struct memstick_host {
 
 	/* Notify the host that some requests are pending. */
 	void                (*request)(struct memstick_host *host);
+	/* Stop using the current request; may sleep until the host is idle. */
+	void                (*cancel)(struct memstick_host *host);
 	/* Set host IO parameters (power, clock, etc).     */
 	int                 (*set_param)(struct memstick_host *host,
 					 enum memstick_param param,
-- 
2.43.0

