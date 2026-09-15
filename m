Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5003D9DBF
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484612; cv=none; b=MryDgM6eQE61IIkEdidqC0gFH+1VgGqiUDiYAUd300HEB22EJ7TTMOShydXPE1BdS+lHcvG2DtyK7A3BLgIXrmnrdSwClPlbD4IzRL3KRNfRwmOVSMNz7IHuY662Iolbehl1jc4Q9XjLChe+Cnw7cCi0vZGmOpMmuZvBINXM8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484612; c=relaxed/simple;
	bh=ZxcOEZm2h5gq0oopxQGQnrU+9rOuzRx+cCXYve5p7C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/ZA52zYwWdq81ANRO7diJJbphSAE0ZaT7R5KUriJl+Vyu5lFwxAmtxE8fKMkzOyCgIfgLnBr7uNUIeXqc9QxcI/3ga+ngAHY/eXuf3bJdY6oI2hfyJreIxNyCJ7Llxg9klbF47xXNTMglbE1i1mVMQAU/vszoOmQxkgGv2lZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYhj57al; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYhj57al"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so3694996a91.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789484610; x=1790089410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnoFATftpooOx4JQEkcutKyMZ8fnscChHfdP4CjfQ0g=;
        b=bYhj57almlknnku1zHJDxN6L0ktJqknCYE2luWkbj0WtkZKfchZHnaWCFYtjSVjo84
         15mCIodT7vPcKb2OzRh/z/qAGUdGMwAUFMexLSiKQtDfatMjCO60qZQ1a0ntlVLGyoP9
         C5kw1icnocUtPun0vvZrv3wO3KoOMFc4ZpGhegm5/utFnqwqUohHZJXlt5q6XZRlVTHt
         wdI/hHfN/bKucntbbMtd5z9DOsJBUrB2Qidg1Bei/VIA5XP28npgMzKvN3T+Lxr/YvCM
         Sw4RxJW3yThVYVJvMuqjyybVWE0w6WjMz+hcki/HfDCTfBYsk1Jml9jl4jx4dgf9eM1O
         znog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789484610; x=1790089410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnoFATftpooOx4JQEkcutKyMZ8fnscChHfdP4CjfQ0g=;
        b=ym2EGeTczVhawern+SJXHnKwqFgx8Sr4ZJ6lVoLRXFk6q8L26v/j2x2TCZQNjjYteh
         eMtvuGI9ZIWq6aqRig0pJbnCdm4fhHlTnyGYGB4pBB/H/AKrBcb7iZoCRyQHjrLFjb2+
         eIjfQXOZOcsCa4AA+K50ZFXjMrJr19Eh8S7Pvd/RTrlN50j79U1oLK8Yf3+zzyqWmjZN
         QY4EIFsatJsHt6pph2di3YJhzGcQlFHKGZUoS1a3gHz7M4YXQeabRqh2A3DOu0abxsYK
         CuTqtafrJj0tJs9qRwtFB/7veTewFn6kSENc9zWT6/7mkkoIw3bVC4Vbbq6lxXmsn48a
         g+sw==
X-Forwarded-Encrypted: i=1; AKwUvBw9gM37MMcMmJY2QN+97gzkrCPTOEJViaQqkhIhboPjuYB25CwIJCgNMKLWxR5Hh5Np9W4xbibEliw=@vger.kernel.org
X-Gm-Message-State: AFuF++nwAuzTKNT3fGDHy6xurJkOOOldVyYWC3OSTHPj5pe3IhGtC7Mq
	qtvLPGqNFB/9qZfB1BBZtJZnnEHZK72V0079bFGmQXbOpAf2pQmQBF52
X-Gm-Gg: AYBFou2DIzBXx8lD2uEgfN06iRGWM26FzPS3YB+pQl6NbvjraxWnbHcFgQ0NJxQ5UXa
	W7qbtdnEogqvKdnIhtIWj4w8Awam0B0/cf8rnWO831NYSD/gmNUMJefieHOWs1swpZmjWKOoQ79
	eVviZM78jKiQxdVSu2ddhQKgoobdfw2tHX/6gXt9q9T5KWaTaSZY8njqC5GDS+Nysz1oR1dcfgj
	7vjUky90AI/3cfs8B3sYTAhL/IwWeDnHd9gNeUaFO6fxjVqr2VXyqtUjh+VHkw9kX6n2wt9Ae8c
	jiwvtyxueNXAA/Xg3DsrqjIatSBCmEAzmpUZjnRSWb6tebQ9RJsECocd6Ek0Y0Sf5wzBCMsmJUp
	8ufbu4AJHLwDPOaKSd8FwAcxFK7occfbl+PoVg8Q/f3qz/MTo2ICnsiY67b5nzlSLhtpCPpVYfL
	UtfCKbxWaAEkM9GBxqU+S9U1SG0/hCzX9TfkB/PZcGutaANL7RjDEzfe6JQ/2JnK2cyg==
X-Received: by 2002:a17:90b:2789:b0:39d:f2a1:2a with SMTP id 98e67ed59e1d1-39df2a103d6mr15547653a91.19.1789484610100;
        Tue, 15 Sep 2026 08:03:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda8bdf4sm6105716a91.12.2026.09.15.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:03:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
Date: Tue, 15 Sep 2026 23:03:17 +0800
Message-ID: <20260915150317.2444609-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msb_init_disk() allocates msb->io_queue with alloc_ordered_workqueue(),
while msb_remove() does not destroy the workqueue.

The probe failure path releases the workqueue with destroy_workqueue(),
but the normal removal path only flushes it through msb_stop(). Flushing
a workqueue does not release the workqueue itself, so each card
insert/remove cycle leaks the workqueue and its worker.

Destroy io_queue during removal after the outstanding work has been
drained.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
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

