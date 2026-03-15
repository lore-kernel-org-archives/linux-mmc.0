Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C923375F65
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595024; cv=none; b=C5WJiaSwWN6s65nJ8DqHIiQ88yEPJ6/siccWCFgc6Ipt+gMXAwDh0vs0wkgo4YYdQmjUL5b/GD033yIdKNauvkyTSuUcSi2cteyr3gb/CD8AN3a8pDaNBVfS4H96h+eeRZby0crOw5fkfNY75ZUF8rginh8YIBqdjP7gjPNjG18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595024; c=relaxed/simple;
	bh=iKpFG0Av0hoqoOlPYCyOzyzjoAeTHTDVQHbGXDPimao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk2ffY6TQycVg7BC3KjQxzckFPhaZpGR8KnqsjHwRlcK11E1U4qeKgW74LAY6aScjkK69+pJ5/Ll0YYgxfg0oUzwKE+nETivXhx2FNGPgvkLaNURJn1gbIun3Byx7zhifaNc1olFK8jcLHhg6wTrVgHeiChRr+ZiHfWUnZ5qJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArBu8oJU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArBu8oJU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b6d9c981so2673003f8f.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595021; x=1774199821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBcY1jNO230ersIPOAT9WM1qbuR7iZiog4/B3vVvee0=;
        b=ArBu8oJUDEqbx6ubRa5lF3ZLeuJit//fOBLBhSwho5ZlzK2T+NoiV56GqNLs/wDk1X
         wFwOMS+HMJ9wTUcao8Fjdk3ArwEt0qNXw3vgDUT5u4AbV32v9mVJeCqKJrgfpJl85B+F
         myvJeqvd3DLVoWCTfoHq+eWvzmiZKdBx7YZ+6TIyaTcETv9t01yqqJ4RWq1SRvWa+pin
         b47SLEr0dtVMZCM/kE8jAZie43cFU2cI110Sv2Xj2c1wk3zB8PbwYGDe/1XF/SVjkcEu
         2/CvSRjSM87n4952zIBSFwIeVusVrUKFp+zpM4W8d2kBBwHw8PVnbn5F07glXX1pUV8T
         Eh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595021; x=1774199821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBcY1jNO230ersIPOAT9WM1qbuR7iZiog4/B3vVvee0=;
        b=HfVlM+av3qPTyqom7KTdmsuZ853fAJvW3EFP+nHCW3+v+2uN46QgbFnZ2Lg7PEjQY5
         2ugetwWMlqvq/H/hQmab/6aiSlAv/qKlY/PQJ3QtajlWY14Rf4G8+cpU9sNv8Hkx2rN3
         ereK8LbZMyU/NoKzoLHf7btdDIyJJBHq9GxfY2YhH6MQOuypf9XGdwl+Y4JtgF/2h/+g
         PkZLgvtQIFNCYn8uLVY4GCHJH4V7ZSirpaAAIJcI5XTJN88n1GQh5LM3nUaFQu52Rr0l
         HYjhQD0lTeDyaw4Du+CFXkcO+Q8IhuicfxkOVtW6XDXIRS966qcNR0u0G2lxacxO7pqt
         G7rg==
X-Forwarded-Encrypted: i=1; AJvYcCV0XUUnf+Z+JWxKxV89EcY6VAU38/TkshOSZRf565bVWuaTgaJCEKkl46Jc3Uo3jFT1I+IxIMxFkyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzANGgqXtuOizunv9x6ZRW1b85MpCzxXw675BCneGZ81VtHywX2
	ooZXBNsy4A064FCwDLoS2c6WKUaqajqVsGZrGqIjfAk9Z9V8Vyeqkjte
X-Gm-Gg: ATEYQzyxxoFgCXbfByeQL3eBeR0Di9JmmpkACSkfGR9cNSWWXSVAt/QaJpuEfEs45wU
	BKxI+HjEyTEqRQ4M15QEu/rY7gRH9x+9LM34bO+r8Uzdh/06L1mB8cipRZe1Jr/ZSKxrcivlXYN
	h3qG/oYzA3r4PTUNNtqAR8ZtQB54YOcSe7THWpkm1B64OTw9lcarWiUqn3XWetScS94OdCB5bpw
	s/4xt2ldaDjum8crFjIa0efwOIA1wMqeWPTyrz8gmRLy3QR2r6M1BDEjF2HqsnDUnVr0sce6vH9
	79FnIMWvGY+GwTxttFFYSW1wWwxTX8NXrNvsp7mp8009CIexysUcwW4yTWc1M653G5MXnXLMVK3
	0rIStmbSRjLfYal1+J3tv91uWBE58osS1yRkd9peau9d2r/h9MhNkH4pRkC1d48TLjYRUkNuXmx
	M6B+uNMeTcPWBwcOjpV/n9QtN8elKU9BFgcA==
X-Received: by 2002:a05:6000:40ce:b0:439:d74d:a686 with SMTP id ffacd0b85a97d-439fe1ae6b7mr26631100f8f.28.1773595020567;
        Sun, 15 Mar 2026 10:17:00 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm40536429f8f.27.2026.03.15.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:17:00 -0700 (PDT)
From: Adrian Garcia Cicuelo <adriangarciacasado42@gmail.com>
X-Google-Original-From: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 2/3] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Sun, 15 Mar 2026 18:16:51 +0100
Message-ID: <20260315171652.269020-3-adriangarciacicuelo@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
References: <20260315171652.269020-1-adriangarciacicuelo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Rust rnull driver to use Pin<KBox<QueueData>> for queue data
allocation. This aligns the driver with the latest PinInit zero-copy
initialization abstractions in kernel 7.0 and fixes a type mismatch
with GenDiskBuilder::build().

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
---
 drivers/block/rnull/rnull.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715fe..23df23936 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -54,7 +54,7 @@ fn new(
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 
-        let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
+        let queue_data = Box::pin_init(QueueData { irq_mode }, GFP_KERNEL)?;
 
         gen_disk::GenDiskBuilder::new()
             .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
@@ -65,16 +65,21 @@ fn new(
     }
 }
 
+#[pin_data]
 struct QueueData {
     irq_mode: IRQMode,
 }
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = KBox<QueueData>;
+    type QueueData = Pin<KBox<QueueData>>;
 
     #[inline(always)]
-    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+    fn queue_rq(
+        queue_data: Pin<&QueueData>,
+        rq: ARef<mq::Request<Self>>,
+        _is_last: bool,
+    ) -> Result {
         match queue_data.irq_mode {
             IRQMode::None => mq::Request::end_ok(rq)
                 .map_err(|_e| kernel::error::code::EIO)
@@ -87,7 +92,7 @@ fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool)
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: &QueueData) {}
+    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         mq::Request::end_ok(rq)
-- 
2.47.3

