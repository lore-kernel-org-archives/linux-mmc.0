Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238734;
	b=w9Z9adSaiHAx0VGaGhvF+zWfBAAXaHhCEPdy1vRHcrRPmYhkhw2Vz8Pid5rafFtkq8zw
	 /SMYHPmtW8XFk0MXL1omdeZMLoD1WupYlGKBc6g7nBlpdWrX5/11eoKZfgpZZ4WaLnkPk
	 pc9+RlnkQixHyvDIoC5yT5P+0nhVIfXWlZOlrslMnqKn+Zq6nhCFwAMCasK1fORGJ1N3F
	 x4dxhr9Llv7I3zwmZDlKBZem2uEvKC8oCCIXQMGGYFFfktT6lKyN0vHHeJ+diyz4rAuBO
	 wVrNT1A0lHQe8TbsoKFCOKXUeFfMOyb4mECIPbG0X0uKYq36eJ/jyihv4x17yGVoc9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4zWJW+JHe3yaJaSnmXKgn3EyBlFrMRC1zmkIqG37kkA=;
	b=4BrrWkXDlhHF0NDnwg0g+qIVO3QYgPOOoJyQah28gO/oQgaD4oXUYgA0hw6/jdM1MMtC
	 Djf0lhevpe49jVXxgfppz0hDVVrrJbubRn5kHl3XFJz+7FXqssCgN05syF2sBPgYO77ul
	 jDThjFhWhIjvkLM22/J+Xq5UC5GE8rid0r7wGT5jyfinfHoDFtVzpQOAyIrNjxlpzF1M4
	 KWwP0BLKM3NSDTY3SAhR6vnLkzQTT0Fw34S4GoRRW3yXD/5WubFMUdKui4/K9pU/ePeTq
	 UtBx2brDLscTTM7bS/7l3M4ljUW6/Woe8x2wVWEJ1wSQEoBZ1BB+Ul5PTlWvDxtk7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqgBKu3T;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D32606A326
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 15:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D32606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqgBKu3T
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso579499a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238733; x=1794843533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zWJW+JHe3yaJaSnmXKgn3EyBlFrMRC1zmkIqG37kkA=;
        b=KqgBKu3Tb23uNp8jd+Vv9KNds1thY4OJrPh+dnAaLkh/k5DcLOtw6DlIH65AWzmHKw
         jmXKX4luUsAAwFqoCAhRxL50o73KY2ZnpNL4kasKFznjor8Zjqt3sgoyZXU4Yi7mUCLV
         lREGLnvNTffgFz8uPNUJ13P/foqIV4/iHtrjuvXNZgdBQd3Ymr1SgMLuOk4934sbjeYN
         0I2x9YUXbasNrZZ8jF7Ojl4f6h6DaAM84xu5aSpAAGVp+DZc77hCosdHml3AQvQvKL92
         lQycN+NMOdDNyM4P9pU83zxV2QRdX02QM5+5rmYMg5tYagqdmBvp9k3VOBdYOctuVG3R
         9u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238733; x=1794843533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zWJW+JHe3yaJaSnmXKgn3EyBlFrMRC1zmkIqG37kkA=;
        b=2qaMUNgy8OdZq1be67d8OFK7vpfKMRnI2sU85m/VrTOfsuhcVx03yKO328vvIj2cqu
         MlZLLX6JLk/Rl9H9n9oupSVLokSSp5VydNIPv6wL+lIUXeu/f9SUT8624BhTdMwmEgTZ
         qISWoGtsv1peTRpet5XCrXnZnGXTu17IS7wtitNAJil17OVF83ZCsggJTzDo8HvDyhwO
         UpCAjjXsIoO0d+//VUq07tr3ryZN/jbRTP+hMi2fSj5n51GmC2rX2+/garzgWSmSeR2X
         6ts08aVmQrX2J7AQBwo4aFzQV38Okzu7Wq/Y3nPvcQY7I6+XylvlgotNwYd+5GTJJGg5
         0R6Q==
X-Forwarded-Encrypted: i=1; AL+hErG0rAuFj04w02Fgr1hmam49zNfnG3C0zY7XUbnGvJ/x0nyYUq5YhMGOS4NKHrXlEeM9DbfUAGmj8LY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+HVQsRPRTx9rPTyx/2FgLMAuhSSXcZ4Z4vVR0vO8BP5kd2iUL
	NI08eQt5Mnc5VMmscBbAaJk5UVknA00Qrjb8y1P9HgJrI4AdB2k+NiWh
X-Gm-Gg: AYBFou3U2JgSH0YCmp+31BIA4OMkV5ySt31nahU41rLTQITwAENiRFfadtfgnv3wz/B
	6Kp0JnJSY5t/ck+byiLeqlAaMDTeChRsQ1P3kAB8bD19hP2Z1DlD1y0pNb0OdOvRuqUoCtruigL
	h1bXdHzF3/Bhribt2Z5fb+eKL/SBOFA8Wo2Xx3v2Ailp7GUYt9dj7qjP132SxKmXIFX+niLOod8
	9+yuW5JlJKaOw+E0Pl7A6OcKi0LHMU+FzXvZJTr3qJdPsi2LKa2QpVbAK9YTwt9L2M8lgj1kfum
	KvX0sYpLtMk3/ntJ9KBs/wfnG8OCYFn16pS+XOT4QaNoamZ7c+lgGNDjyADy8tul7S5hF2F2fD6
	8EJrq7AFuSV16zE2gQYUG2cfzO7X8tGWlPr+Cvx0xEpWCnRfVElp41WDRzQhAZcW3b5ebfueUsE
	FWwb5MT2dsK3TCjBiki7NSwi6mOpEbGoRato4btAyxWzbJOkuTJYu27WRfxo7cULhYRtQm67/l/
	OP16S/obqd+MI9hFYqBsBPYUhto9byAZobxjRuIEbKZYI3y4bRB5r7upTsBfaCgz3NnPPUtRh3v
	coNDlxX8FgLFZD4tOlKRLXIGuVTBW2iASRa+pDosFggQM+qcZdXfGbeR1RAEYVa+WLxTLmQFFb0
	yyhFROH3PbZHfM1UR6h2/PB/v
X-Received: by 2002:a17:90b:54c3:b0:3ac:c024:b275 with SMTP id 98e67ed59e1d1-3b166ae44eamr28170a91.9.1794238733346;
        Mon, 09 Nov 2026 07:38:53 -0800 (PST)
Received: from 0.0.4.7.1.0.4.2.ip6.arpa ([2401:7400:c804:b668:b272:9904:c32b:2ee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm11062029a91.0.2026.11.09.07.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:38:52 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH 2/5] memstick: mspro_block: wait for running dispatches in mspro_block_stop()
Date: Mon,  9 Nov 2026 23:38:01 +0800
Message-ID: <20261109153832.7377-2-hjf3108@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109153510.7161-1-hjf3108@gmail.com>
References: <20261109153510.7161-1-hjf3108@gmail.com>
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

mspro_block_stop() only calls blk_mq_stop_hw_queues() once it sees that
msb->block_req is NULL. That marks the queues stopped so that no new
dispatch starts, but does not wait for dispatches that are already
running. In this case, a request can start just after
mspro_block_stop() has returned, causing a race condition.

Stop the queues before checking msb->block_req, and use
blk_mq_wait_quiesce_done() to wait for running ->queue_rq() calls to
return. The existing loop then waits for the current request to finish
before mspro_block_stop() returns.

Fixes: d0be12274dad ("mspro_block: convert to blk-mq")
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/memstick/core/mspro_block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index fe38b42431219..215f4c3759c41 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -727,12 +727,13 @@ static void mspro_block_stop(struct memstick_dev *card)
 	int rc = 0;
 	unsigned long flags;
 
+	blk_mq_stop_hw_queues(msb->queue);
+	blk_mq_wait_quiesce_done(&msb->tag_set);
+
 	while (1) {
 		spin_lock_irqsave(&msb->q_lock, flags);
-		if (!msb->block_req) {
-			blk_mq_stop_hw_queues(msb->queue);
+		if (!msb->block_req)
 			rc = 1;
-		}
 		spin_unlock_irqrestore(&msb->q_lock, flags);
 
 		if (rc)
-- 
2.56.0

