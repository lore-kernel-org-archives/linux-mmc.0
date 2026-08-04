Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C638550C
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879316; cv=none; b=R8PD76mt/wNbgo7o2TKjnAMEe/hDS6JhPaQspRDG5Pu4N454BiwmZSs2RBwT4eHObzT/Xg9vPHdl6dg8yO/H45CvFw4vmETMyqMPXIwBY96ah9r0GJDC+qDhrtRHuBuahfnRDvQvjEQehrnwgAV8pXWPlv8NMPLut8k2EA5bDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879316; c=relaxed/simple;
	bh=bqg0NehwVXA1rTLhVpjps1ZsW0rmS/bRW52n0SrYjxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8eI8GvKMXMUkiYzc50btOo4BBNt1buKtaeCB9Z+gH7PDeV2xa3WLHo+6F1lG2IllNPPYiUw17exQm6puank2DGTEwSPdZYQh2faHW1OzBFK7Ht0I8Adn1mC0J4upGuIKczFvPlM1g+S7vyP3vZV05tY+qIT+LFYT9IfQWKAGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPnOX4E2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPnOX4E2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso3006905ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879314; x=1786484114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbbKhcHxWg4c2CE8Ge9QTVBenagHkPrYHIB1asS02ng=;
        b=IPnOX4E2+wbZkIwfsElv9Z18xfSgZJhELm7qCQZzOaVQjzJAIsAdlWFokKiW5eGFM7
         ibdbU6PGCYu0HM/+B/T5ePpuUJGfPa92F4evVITCeT0wEHqWj5tFAynXkzQls1CxgCk8
         zy6gkVa/cIHGhjxqNbJjArlo8s2x+1iJDgF47RlNPiLgcilz5R7KYKOV2Bhkh9KWRsVZ
         BIayLUzK/12b7xjQ1o3lUbfF8AMUMfb25xI5mQkynVPkU2wcteMUibQVJ17VNmb9vQkR
         tpAC3MjIFwgrrYnYfndqTiwIF5X16HtO68/AUeXT5Nch0ZGvJMpZQy2w0s/Mi4ZtDsx8
         TO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879314; x=1786484114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbbKhcHxWg4c2CE8Ge9QTVBenagHkPrYHIB1asS02ng=;
        b=EiD9Cazu3iOLw9gZe7bO428GTHIaPlBnZ1Ykefy+PwhGO9QokBye1FKH93PsROQIqn
         QV67GEhMeFuCncAf2aiV+vK3Qx14vQ59B1Qiq9L/HjkVOSUQL3Bji3yWPJHwtXlMgqpa
         36NjWBIUAXaCuBvNU29Lax/a6Jwp3I2/3u5vBIU2nJhHuo/SKbPYbyZENPgxVLws/J6G
         /3jWUJ384AdAUkWol5uxsFoUjoZhpaiXH+twMRVhAS0VodxeUdSiLRFm2bh7FwItpkDD
         irkgeen/d1d0cFFYHyXdCh6fv1TP2krPVg7YStgzY0OvOejKdacPYek5r9Y+x64fS/0k
         VQTg==
X-Forwarded-Encrypted: i=1; AHgh+RodatcJjD4W//IFKUqeGk7RSAvT168IHKrB0FS6fXMwFbzkUl+6zUTwmvN7hVL0LesaP4HMa8usm+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAX1yM8hy6RBvseJz7oqFTf2oEleZIM/NqxQnfH6pvAXbmmzC+
	f23yrkeExtIXoInHQDdvcuk5ibGjGXx22P83Tr95AEvYlhmMa5Qs6uMe
X-Gm-Gg: AR+sD12C6pbeZzYlN1PxK4rWcHb9RBi7HYj/hNJxRAGE5GkxLrfoijUxwLNdDaCMosw
	szrR5gJBNmDD2FK9/mcO7KQLuVKfGlcm2O61bS4HfLKsh8R/epJ0r8QShA3W7JvCp6yyrHA5lWQ
	2E0EcE0TW01WDIOIlEfGVquxPkmNjOw76r9iRZekD9KZHKUZ0dQZ1V127o5hnNLd0WokAFVQ3ic
	PO1dzgsKFqmMGKtxs8E248LgELiXdGSFiOQ5zrd71iovHc9pB1mGY7Ba+mn3RysjDhYLmHzSXig
	+fw3SE5EVBkXyzMdcfJN5id9p1EUpun5hWTKoS6wyUDgYnCE+7KxVo/JbbcQg0mmYQBhHXFgO57
	bd0E98RRHkfUmVZKg96/TgIeTvAYHu6RQZQjG69Zj7hIPGhXgsZarZG2n1qZAwc8UFHCIjHEdkI
	b8pv5kwDBAhcqZmQH2c90HPzOVq+JudeHvQk+3TRKke9bdRbJycPo+qQSxoOX6k9LzDuh2ySA5C
	N48ZQwBFeBKW3LK2jSGT3ale37jnV35qyi8SeDjkRo=
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3903c5c443dmr1316461a91.16.1785879314070;
        Tue, 04 Aug 2026 14:35:14 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm13069487eec.1.2026.08.04.14.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:35:13 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
Date: Tue,  4 Aug 2026 21:34:56 +0000
Message-ID: <20260804213458.3408662-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msb_init_disk() creates the per-card ordered workqueue msb->io_queue with
alloc_ordered_workqueue(). It is torn down with destroy_workqueue() only
on the init error path; msb_remove() never destroys it. msb_stop() merely
flushes the queue, and neither msb_data_clear() nor put_disk() free it. As
a result every card insert/remove cycle leaks the workqueue and its
kworker, exhausting kernel memory over repeated cycles.

Destroy the workqueue in msb_remove() after the disk has been removed and
the queue drained.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/memstick/core/ms_block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ce33907bfc24..65154e569a9e 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2204,6 +2204,8 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
+	destroy_workqueue(msb->io_queue);
+
 	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
-- 
2.43.0

