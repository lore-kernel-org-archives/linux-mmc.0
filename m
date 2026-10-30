Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363813;
	b=1tN9vH5h2maphVmArLXtyT4F+WJ1sp9s7mXeSV31iNvvGPyWm0qPbjp2K7sWUWm73l2Z
	 bDErH0Xl8D4Gnv5XJe124SWlzbHWlkEAMkBkR9rKvxmckaFAthZ1qMWEDUNkpCQjJ3B6N
	 PY/nI23stu7lFF9XIk6mZ2sBs8F48VGqFz1bhTl0ihTvRt9xIiANTNVkSiNXr7p+7nDHE
	 s/esBVOFwch2jLnrQ2kkRuMmsORIc1pFHlOnfavZ1rH8aSmboiGTvwG+20PR2L0iWhLKI
	 76OBkxYf5d0pnUQI/HBOX9KovKDX4iCXvyiqvExgZ+4O+iK1Dwu4JXONoVBYHMx0APw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nK1hzdrqWbwHzyd6WzVscvUMgy8BAnwRp/DeubL9foY=;
	b=tf4OjpDeAnTxZ7kxi2n4CrjrMt8UyT/q/uIMa767O9m6bC9jMcmjncwLoioCSuA0WmOP
	 4b4v0aCHcVEGo23ida09JuT0P2SBza5m2UYiZd7oHNcxZIBvE1nb8b7hOwvA96UQAd96C
	 Q48OQitudK9v+4FVog7qq+qNdzoPCg9QCF031UTNrEwTFVMzfjW3uv99YPam3tN3kbSc0
	 HGsXpgdZqd4A3I2wy0Uo6raONp70Ml3DE7mhp6HeZrOvSFMCTUP/a77D1e9BJpQnzwpsg
	 dhtZ3MLihNDniKwP6s4QRlXQFxPcmtG8oMqGiFFleFa13CkHVN36733aYU3+Ol0POSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itXUZYaB;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBB606A31E
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 12:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DBB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itXUZYaB
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0728so169692f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363811; x=1793968611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nK1hzdrqWbwHzyd6WzVscvUMgy8BAnwRp/DeubL9foY=;
        b=itXUZYaB23SNEJBFGa83mQJ1QxVbDAtdEpAm+he6uriB122kbFUHBZuM2lN/ZWYkck
         9xcM2z7nj3NyejMpRmHml9c6Qe7YhU+gM1VTgKcqWpzwdb0GrVqa03/zfh0pO2KbT0KQ
         3yqJxnOHVVlyLd/hz+7pYjYldmGxhslFaCLoSrTtROxzZYhLtoNCHH+mS3qlprRvEqIm
         xR+5Hm+vkXyqyGVS4NIe15ag5a5NX5hK+QYL+tlIqTzEEb20pLWtApT+cUNWL/m3Mr8Q
         WtuMDwLM/HrCGSeODIMsm4DOANp5NxJSkev98Fv1aFBhVEYQvXsrTTXb2JH3ZDi5DYfv
         0U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363811; x=1793968611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nK1hzdrqWbwHzyd6WzVscvUMgy8BAnwRp/DeubL9foY=;
        b=NJSGKHtAfVATYh+ZRWQaDgIv1fS0Jnc1cjedF94CIaJnQRG3bQleD/FNa9NVQ8ETLb
         WJ9Y767nBvIS2HBbeJqhsb9iC5z7bY7v3MxCg3JWbqW5V2HhLidmOTfNxeYpX7eUdtZr
         5nmR5ilVTicQqnPd+vQzb6KNGQFV+X24Oras1UajcDMg5K8lqh5CM6SVwuWaZvFTml9s
         PglMn1IcK5GFYkoxebHL/Lsdz4SwWgi3xNLVzuAKDVbPVBKt+1PCwcrQz/CN3D0yExW1
         jEjmHRd/FjAe0kOWRx9GiiIYdpP+6roh+3zaRbV1Y3uTMd/fCcKi/qxiwHe1W6IoyHYp
         ezmg==
X-Forwarded-Encrypted: i=1; AKwUvByxjxfjYjt2opISZ8ulfcYjuWq/bb4qeoCglu6IRQd1CUDqaOOwwIBoDjoF9WNQfbGtWbgkcZ3Z5kc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLC+IRWvRi9RYwyKNEluqq9LP+or7aQIVumsPbe1LQ74NfEE2pU
	o2sDH16GIl9RF2L+k2Yd7k9DSJIAwg59NUBapJm9Q8aPn/4xVmxuEi5w
X-Gm-Gg: AYBFou3S/cp3tMSWfurstI6l2BezEKFnRB9hT38OEqA3y2y3Qne3Q33GSJt9qAXSH8m
	D+GSduPnJsdLhW1RILzNM55KFOrwwDotQYP8ZCeHBTcTWTCB2i9SkBzrIOUnCwq/x/gh4OjP137
	rxYJ923QfQFeGOcpUpTaMitL0nRgMVPMQxT5oKth4mLbRPR/vknXGOG0fQ67Rmi0vJg8yWxCjWQ
	rBWcWbiNPksTr5HijkXS6uSBsXCTC4fAShUC5MLe9ZL8NfYCZ3LK1Avkf+a8EpjFs+oq3AbJbrw
	kvOo7TsolL19AD7BZwI4mJ5XuDeg5TZYsiZdNpm2Tz3LrY14feSoJ8Yz3NdjMuQ3qG8Lu61V42H
	JY6OxvG2BVdsqDOjCZ5OkKdgSIkcNv4pCnVFVynjBRuPGZycnhOzojIIxn9vEOWoOCGtmXNUEfT
	AwyWqukO6t/DN7qglD0eV2z8g0FCLCPYPBGwS0or40vldNURt37hlwnZw4H66vPHTG1Es1v+3+/
	A2KmP7wkHyoGQ5oMfIoQsxgGQkeRAHitXQCUnxgjRE0vCnnWSC5bAjKxwtp3uf3K7fFGL1WubUo
	kSbNuj93EwkxrK+SpX6vLUCGvzxpYJrWOt7NMsg9WHVSrg==
X-Received: by 2002:a05:6000:1785:b0:48e:3767:d885 with SMTP id ffacd0b85a97d-48e6e4f8c42mr5742675f8f.53.1793363811249;
        Fri, 30 Oct 2026 05:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:5a44:fb2c:3845:1154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a84esm3218339f8f.39.2026.10.30.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:36:50 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] memstick: tifm_ms: use the correct DMA direction on removal
Date: Fri, 30 Oct 2026 14:36:48 +0200
Message-ID: <20261030123647.2356647-2-thnkslprpt@gmail.com>
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

tifm_ms_issue_cmd() maps READ requests with DMA_FROM_DEVICE and
WRITE requests with DMA_TO_DEVICE. When a request is active during
removal, tifm_ms_remove() unmaps it using the opposite direction.

Use the original mapping direction when unmapping an active
request, matching the normal completion path.

Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick support")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/memstick/host/tifm_ms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index 0a54586aa54e8..171aadd4ec71a 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -606,8 +606,8 @@ static void tifm_ms_remove(struct tifm_dev *sock)
 		if (host->use_dma)
 			tifm_unmap_sg(sock, &host->req->sg, 1,
 				      host->req->data_dir == READ
-				      ? DMA_TO_DEVICE
-				      : DMA_FROM_DEVICE);
+				      ? DMA_FROM_DEVICE
+				      : DMA_TO_DEVICE);
 		host->req->error = -ETIME;
 
 		do {

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.43.0

