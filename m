Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285023;
	b=I8rX2y7aaaMOPQ4QG0jsclWKEareq0hUOPkHZVDaDY7Gc5K9KMoyHyDgtp+OSWKC/YrQ
	 QZSQe4PH7LNVNBlbOftKx1mtymJtZJQNv21l/k9aTNHgIm7V/X8BniFv6ijNjIn8riQ6y
	 eZp/uQZIRNKQNtq5XLaEBBUb2Vv+yXBQHfz5JFlCPVpVV1fySEMAHrNmBqTCt5q0oEuJ3
	 USYuSI9kf7FYkls/tjGqoxBTnfQvM7uQfafHKytb9Jt/nexUOM9/ZB03gt3bxu8+5keUD
	 6nYCgkuQ+Xa/N/BG6FWcLPV/YB3uxvr/vWF4qOJrzMkPA+j1FQp7KWZazsNrbPhRECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gK3Zj5SmalpyUjC8K4zZ6GNOQeTZ+/I1kE1Ho+gmUJM=;
	b=kLzY44qkvzM94LkhoHucu6fpzlbZZRwwjGfmQ8YJ9VKIohd4KPkPmoRlw4uY/+J7o16b
	 3ZBxwYw48yUt1DXRtacQfOXIM+a+xkP1gSC5EmUXaK/JI+P/SeqjaxPwNPjbujdRGxPNK
	 LD4SpNSoLUGkXn4UGv/UZ/0N6OQ9Xfv5hPdWO82T60TDYW2v6tW6eDm2NOpjkafcuPaAL
	 hT2dqcNDyAdQHAziAfBnkzNQzbjUVKupXNpTAjNtpQpL9VqI+prF38jbCs5GrWMjWXF4/
	 v936C+mRJqlclVsoP1gxPNYzvcQfNEAqM1YAnfTMb3wvz6RA5GSNcT9N2dy2WpzdIzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vz0trkts;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6460A2631
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 04:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD6460A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vz0trkts
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c6ce60697so20296656d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 20:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285022; x=1794889822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gK3Zj5SmalpyUjC8K4zZ6GNOQeTZ+/I1kE1Ho+gmUJM=;
        b=vz0trktsq1aT9H/o832KAsK8TjpLXaB37e3Tbl5/h5ULmGLqz9U8OnzqTvfOMAXJpe
         aDmTxinoNBcv4jZMDsh1Ckzrxl2/Mz2/f13oLekQXxqgrwgZWsq6dSK2aIGcnxNUXCxh
         +PStX9QgrLyg85NMBP4C7yCwZ13POsurl1BPs+mI5WDaX/qfXccrc34aTDqsnF477jN2
         HIAgNkOveiV2sH+19CXrR0NjOfRqLbkSNynCSP3tZu47BZxV9FAh3mvzA/IAhn00z5Tm
         8RqVZUAOOX6UY5FdQMBYxHbNzB7hRlvIgSWlqoxv84CGMZ4NaWhAFVJLZGtQKpbRJBcs
         hXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285022; x=1794889822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gK3Zj5SmalpyUjC8K4zZ6GNOQeTZ+/I1kE1Ho+gmUJM=;
        b=mgGgbgZoeKcNyFQWK2mhr/7kTDuMI4XtirjNLGgZQh8zLvR0iPspZsdz5Mgz9t2eL5
         6ii+EybUNUq3cqNK0wq9CmHPsXPrbXaIFgwqygqYo9CvKeQrduTRepiZoYv/sZQleCGF
         kQyoGYQPCQmQ6eecMfdweMf5KlHshsG3WoJpAyztj3cfWmVNHmkSnnDanVJqWh9moqAR
         Zc9gWAs8fDOx2ze0T8cs8YFSkr5VVkhqo+AN3SmyVz0eSQHkUdQOD78mAdfBYnfstxAw
         pH8I32FrqHvPa4wKWVyqeakQHZ5Wu9I0rRWuCewIw+llzz6yIWDefBPmteS549luwCjT
         zm0A==
X-Gm-Message-State: APuU4Z+k4Wq0+Our5KYYzn+sJ9cmRTUKCZEnCQawBnpgYuRhTN3aKx1i
	MSdPGVULhCT2zvT7/fkhZD16QmygG3gTkrMeUJYGze7FcMIfOhA6CQI=
X-Gm-Gg: AYBFou1A6tE6KSQUO99nBkctQ3PtbYdWYwe4OObM/BVVizVKojj5SZYWxk8vC5A0IbR
	hJ2ySDo6pBcsWOXS6XfvpgMJ4r5vwF2rtkiAV5yYWWhudga4onnYqLbZdidVGKa3wxiCmKwTiJk
	SDEhtt1YTwbM4x3TjiNzxEg7DcbU1dt1U+XECFymnpxpuTJWerZtG5C88+cdzbliKkCDIwui+Fv
	iNSt+X+Z/KH/TSiujb+5jHPMBfM9VHDND2qQpQ1H81mmK4xD1/sBf9Ta2WPDwHD+dJRQSpTQ9jP
	K/Z5mZY6GIxNGvkoWWQjLBD6taf0FbdOF/2zN2SLlKmxUIpafgDMjEaVEbmEidjVxs6C/Skwz2z
	CyZ7cxt1aww/GWd8fxVz9TDD60YgQVQgsSzm4TeQm5WVVJLZFjYpOYlw7aEKbqVVqeqCdNqT8Hh
	TUdUdVJF3BbEaMY6gvrUfv8fYBreWnna/D+gp7D1El8B+7D8yADW+XfSRM2mP730/Rg+X+VPR0R
	xIqwLxTPRStkshiOXr52LL/iWDPxLSObjRKyYzCOi1cof/AsunhESV7iSW8lci0q3vvsKhJbve5
	24iGoxj+pXDtZ9Z67FVYK5LiJM0nzOfv9OwEgDy3wXQfmLKHvc/L186rXBaFKd+tWJNjafeHPkU
	nVjnP3qRX2R68DhMFfIu9vu1zQcdBg5siDRLHTzgY/aBx9zyN+jjV3o81O3JE74SJ7g==
X-Received: by 2002:ad4:574d:0:b0:91e:a16d:7a30 with SMTP id 6a1803df08f44-91eef808c9emr28829176d6.21.1794285022140;
        Mon, 09 Nov 2026 20:30:22 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef05493desm12012326d6.45.2026.11.09.20.30.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:21 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] memstick: rtsx_usb_ms: disable poll_card work on removal
Date: Mon,  9 Nov 2026 23:30:20 -0500
Message-ID: <20261110043020.57040-1-mhun512@gmail.com>
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

rtsx_usb_ms_drv_remove() sets host->eject and cancels poll_card, but a
concurrent rtsx_usb_ms_set_param() that already read eject as false
can queue the work after the cancel. Its callers, memstick_check() and
ms_block error recovery, are stopped only by the later
memstick_remove_host(). The delayed work can therefore run after
memstick_free_host() frees the host.

Use disable_delayed_work_sync() to drain the work and reject later
queueing. Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 4676741a3464 ("memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index d5b3a96fc609..85a681e4664b 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -820,7 +820,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	host->eject = true;
 	msh->removing = true;
 	flush_work(&host->handle_req);
-	cancel_delayed_work_sync(&host->poll_card);
+	disable_delayed_work_sync(&host->poll_card);
 
 	/* Balance possible unbalanced usage count
 	 * e.g. unconditional module removal

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

