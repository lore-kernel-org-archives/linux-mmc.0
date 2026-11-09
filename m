Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246886;
	b=kuvugf3QzqGvhJppRgbOPciu4hnrKRc3RxznCsU48Leku0+Up5ZNGRCtqu2HE8mfDEZc
	 vVBs+n6VB3aDEDFYEK4d05fQkO0JygJqxQGIxPaZY7lypu7S3MTEt2NEmBw08KjCRE3eF
	 1poFsIsIksoYfqNxJ34TIR+1QevGtgI92F/nrJxE6RM4U5Ec2F+mMjn1RWwrIZwhI8SFy
	 +M+/S2AbPOvQOkhniU7a0+YVtXQR0ttzg9BVvN+A+1ofuzZZzHXch5jl5sUr4vSvnedrr
	 HEpBk2uzWzhz6nynQUKWhaCcM4cQUDbOFkd7RgFVb6twZ3w+wUragwKJBhSiNvetbZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nwyR6TxIPEqjKF2oJPWcQncPlh2G58YufELbU9iyGxk=;
	b=oE6w/1JanqcBZrnwHvx6VDPIYD6mmJY4UFiTKNISijIBGA2923y9LMawuLKwKdqf6uzC
	 aOD4YwwyifWBWHCSQseuJ0ocI5oJ8dtMks+2+kZGBawNtLElQF5eFCEV4Bw0HPpYkeYTB
	 VfFxkZ2Bs5N3/VYBfGnjTx0N78j96fJEQta8ZadSBhH/qP5yHq7v2G/bBA7Do9SrA7kvJ
	 lYT1OXknLD51H3frSfnb/yDH1SEogVFWamcEUDu47JXdGMfxOJlfQ/8viCA2ncAKp7Y25
	 bPOtGuhA7Ud9bW4JtqEOOXApP7XG0o822kcdeY6Iki5xbYHduXhaBu921jR/ihJ1FpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U+TQMMhp;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACD606A31C
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBACD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U+TQMMhp
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ebdf1c2d1so12628466d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794246885; x=1794851685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwyR6TxIPEqjKF2oJPWcQncPlh2G58YufELbU9iyGxk=;
        b=U+TQMMhpJVS35K6a85oGim4U4eTQTREEagwjzk4kmED+5wpKqvfzZkSFCwScXXe1m4
         kjdAtGYjy8SWBwT2u4PHbhavJbmDDTqfK7TvfmeKgBZ/U5cXm/CvhuqkVZjLR69DDjcK
         ho/t4IQVJ+Wt7EC4rE614AObzpSuz0fekm0vpwow6ZKSvOv9zpVyuepIdyxK4Cvo+R3z
         dwGgOoGROo5XQvhH70PeS28gW3IsgdecGScnJ9I+bx07n43PTnQTZtjEYvWV5c92IpqK
         AkReWxURZWUE04Jeis82SRBOtWps2iyQjnl5+FSmC23cfuBn0lMvoNY4eYa/btQYyKRh
         zwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246885; x=1794851685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwyR6TxIPEqjKF2oJPWcQncPlh2G58YufELbU9iyGxk=;
        b=BFyxH7E5/jnaaypcecmUPzyFBJQoeugJr+fXmP20PJLpnEFNN6UOtMGwjx9JCnOJoz
         ASrfzX4gPmrujgFu6hKajLZON33ew0iKS51my6Ch5YYwjz1xa8pOWINgGwwf37H17Hsk
         OZnBmS6e/NPsby+LPEx6/Eq5RDiHC2Nyi0VkS/DFvytXYjy3trSGVkrwjQA6wRn9RU11
         Ri18FKg1SpvhhDYX9W9QHbwSiHCE3ngHe+gpbX4hCNG08/W22PE1XeFYl9KHBKOeaXAm
         Jsrcmb+bglhwnF4wiWtU/9zsn4YEgnxGUvPzJ6iHhi4bqrdg1Naet8ki+i31MXSKNHeP
         6sEQ==
X-Gm-Message-State: APuU4Z9pR6vRDXSUNOjM2+v2MpP/8IzUSIaTlz6Ju5TZiOBvctOvh+gO
	WkNDh52OJDNKS4vP672TGvU51QghBm5/X6SUCvyQBaqqY3kKvSyu7JuF
X-Gm-Gg: AYBFou1Lx5wNiqdJZqoEtY0xc8M13MatAvfw/rc/OUaUg3ojORcfP0BIYGdJOxCRmpK
	at9O1B/D8fCV3ad2rMQNwPt1Y3zVB4hjkX7xqFLJs59mne4pPxtj9YeJl8ZbjFlynYIBsWaDyLf
	sr5pcmfeSYyLTgtbk3aOtxCJ9Klt7NonHLvB7Fg4K8lqPV+Zr1aTl8XN8FEVgN2vXj9ClkWbJp8
	PnQed0nhSu7gTTE158O49vfKB9OFh5mgv8KO33j+0kP1thqTuU7WVRbuUd3NkVqL7jh9gy6PgwR
	VqrNskVBylQKt6zhHdLDk+2kYO9fLkZciy/1CS5Z86dAXp/M0iNI9Htb1G0hvi3t49LR3+i9uXF
	VXxnyzRhrIlYsITDmpuT5p0p+xRy2kiWrlJV1HPUAI5GKwVpv6o2mZKLJmKiYCYO/qad8jvg0g1
	utHrxSg94g+4UM1Gv12zBAu6heFJJq800+PNhTOjUrzzmVlhVGUZu8yE3KM5hITw2r/Ed1NtmE4
	sf3oUawmkM3cgxljxbkhxDyvFdYzR5ysoNWyEl3cdqe+Jo0jcTw3c9N24zDYJImOVzLMXJu3O1v
	xirKr4uy3DzpJYyXkg==
X-Received: by 2002:a05:620a:4509:b0:93e:fa30:f1da with SMTP id af79cd13be357-9479f33c0damr31442385a.45.1794246884777;
        Mon, 09 Nov 2026 09:54:44 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7dc398sm25843685a.35.2026.11.09.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:54:44 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] memstick: core: Remove the host ID after device_del()
Date: Mon,  9 Nov 2026 12:54:41 -0500
Message-ID: <20261109175441.1180468-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
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

memstick_remove_host() removes the host ID from memstick_host_idr
before device_del() removes the "memstick<N>" device. A host added in
between, for example by another card reader being probed, can get the
same ID, and its device_add() fails:

  sysfs: cannot create duplicate filename '/class/memstick_host/memstick0'

Remove the ID after device_del(), as the error path of
memstick_add_host() already does.

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Reproduced in QEMU (x86_64) with a test module that runs two kthreads
for 20 seconds. Each kthread allocates, adds, removes and frees a host
in a loop, under its own platform device as the parent. Without this
patch, device_add() failed with the error above 3713 to 4442 times per
run in three runs. With it, it never failed in three runs.
Not tested on MemoryStick hardware.

 drivers/memstick/core/memstick.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 0d15f48ef51d..98057ffa1bf7 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -562,10 +562,10 @@ void memstick_remove_host(struct memstick_host *host)
 	host->set_param(host, MEMSTICK_POWER, MEMSTICK_POWER_OFF);
 	mutex_unlock(&host->lock);
 
+	device_del(&host->dev);
 	spin_lock(&memstick_host_lock);
 	idr_remove(&memstick_host_idr, host->id);
 	spin_unlock(&memstick_host_lock);
-	device_del(&host->dev);
 }
 EXPORT_SYMBOL(memstick_remove_host);
 

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

