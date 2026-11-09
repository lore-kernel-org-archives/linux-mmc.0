Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238521;
	b=sv1CiNFg1mUODHik08HIY8c52L5XEeqjMJFH2GUcoW6lG1FQIzCzOHS9IXG0cwtoYqag
	 2jkdkxrsC4DvaLeoSWmnY9PU/ZubjXDaYWZPWNnM22An6S9DkozAqZdWY8YfpyjnNYVUv
	 t3A0XSdQvTSgn6AE3o35WN7zPNXYEC4FCn/PQQevbO874ZiUVhmqrMF2NF18UI0sW0m9e
	 6smi/tW6iarE2Qm7FEmeBKUoETRVwE6FmABmirdktHbF0tEYLtGOkMF2hWF2VmoABBtQK
	 PCZtif6TnJGWRRJ5jUsl145DbwYtj2bOgL7IT2ofEiynozieNM13as0abCezt2AZJEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BFv8QKeFMEcn/AkR3HpsBBFhs/lrtsz/7GH+0grBKvw=;
	b=5UuivJylYd/oDxwDh3G5Y4MFFZq9+QtVsihGB0I/TLQLTppACQpbgb+1ii5JHYqKgvdW
	 bobAdnDmqYO5b9UByI+Nn/tCzz2HbR6DHGQWOQKga5ao7rdGb4hh5lYG9d3dejGlwfVEi
	 9AOmlyyEmRZi/SYqn77dAhZd+Lwz+GsWHYdofOI/3yMiTsV8nc8TWV0eWhJ4H5jhAIrfk
	 jtX+HAuv3VLT5UBEUoXSqifMMjEtF6Cp9O8aiHzgKfEcblBEtfC5M1Nuad5lKR7Fwmkb1
	 6wMInKuUIFTmE8AJMnsLjbZl/E3jCUHGeO6Z51+VFjstKQDzxT41+uDHgNgHpBbSAUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9yhyMmQ;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512E606A325
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 15:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8512E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9yhyMmQ
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d1114320so7571285ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 07:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238521; x=1794843321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFv8QKeFMEcn/AkR3HpsBBFhs/lrtsz/7GH+0grBKvw=;
        b=S9yhyMmQUkUJPTK2IsTCNrMVaZ6Gq5OhDXskouAZ6oTWtLutDCUs+sDP7Be9scSGl8
         5k1VkVLDDKl7yKZYBqVhx4C7SdUPvfSw3AmMfJd4wNWLpzmL0aClb2v9vGH70JVK/eUt
         yXNWfMLxyd45ab6dgeSaR1DkY4lh3+pZ+nM+oWYfJHDUu8D4xNSo5kXdDfkR4povdNAg
         D8EncdJ5VV1IGf1FrPWvjfxT3LDITuUAw4LY0/SA6fA93xewJuc2Cdp6jsmDEB0Vj36h
         y4XVzybyUDt80vfwM2TshniAboxbqMfUiNRylRMis53lJryIJg7N25nSAaaxCw7/0iVf
         CxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238521; x=1794843321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFv8QKeFMEcn/AkR3HpsBBFhs/lrtsz/7GH+0grBKvw=;
        b=M/TWvu2zgY+b9TRgECIf/kvo3JJNRZTna/ymMHtbqBeXkz5xu6ijDfYpXF9+c0j7ud
         Ja6bosJ6FmyuaHvvSYuY3idDeqE5fBe1V96m7necQdnUFRQXWNKbGB0jQ5j8ep7Kyb83
         S663R/i193MEi9ch3VZCAnhQsyxHmbCAyItQkZwYNToLOSCJsnnQ9hJXZzleIMzZYMqF
         eCPa1N1uKRSqMR2AoUFxTD2f/YRQfoHgwqIWa9v5QYmFVyoQ5HDiqPfArD182p54s3ag
         vHpswl6E2zJ7ZJyfCLx7Qm1ZhVj6mnT6QZV/k7v+CTwIdHAcDq8xK8lK7LbFGvObN4Ju
         yzig==
X-Forwarded-Encrypted: i=1; AL+hErHU0RI8L+b13J0i17187Vyhb2TBSCeASoTxj3s02L9+4MMHJM/ivJhHLLkEwG4sNA1fcDQvo84yWpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Nqfejg3Gex6LAHkE1x3DWt6TGYxSU/V7k08TvzdA1cOjLWr0t
	eenr0TJBhPJsBQop21bbLhAQKRKWsXwm+3/GAgMZ/+5dPsotQ19fEL2H+2034gbSUIHRUg==
X-Gm-Gg: AYBFou3QLt1+MPxOeBMAdcoVD4uhhnAyGWZxN00Eh9TKEPVSBglHNa8mqkb7ocOakeh
	9FykykEfK3Vwhaip9AGD7K7/O0RWNfQJn0hsqwfIbCAj+pB80PHxTs7R7Jaj3TgXdh3njpL1w2D
	p8xCBgsitQoa9ZRKSs+Hj66+Fapat3dxdYfqC7O2k1Jm0uUHeeQvYetGOlKFQeTElkDImeETwnw
	TbTo+5eUZXYDIEPm1/dhT7UZRQwm6jqbuql8rGCRzvCd0Og5uDlZgckJg2lcE4IVRY0SUeMmdOm
	sJLfSpvFrHokNX5xDfqbsuq6TEjU/odbEA5GPV+UHrImv0tzXE6eOexFbyrC+5nYx/kv8y6JKnP
	XxCJYo0WrflLWK12NVN3gPb7ucSa21ACgYCksmvAPt9Uxsc1ws/iklRzuMUk6s9Gx2Lb0Czx6N2
	GB0S77tuhYTTWvZYYybefM8J61Yd+0C6xDQGcwc+UQVoVGhr09aaO3iVS0fxP3PSOlm5lXayx9n
	owMvJtsnLfaukLr4jGu8uO5xl1z8+jPcP4ZFpJtcvbFoCnIfK+JLP3+Juw4MB3P91ere780ypxH
	VPg12Li6vsUOxe6B65w271eecNKJngt+Aq69z6TuT6ayg/BDIpdq3+9AOykT+dnPDQXBTlHgK7r
	enqY=
X-Received: by 2002:a17:902:e88e:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2ed837d54dbmr42983955ad.33.1794238520706;
        Mon, 09 Nov 2026 07:35:20 -0800 (PST)
Received: from 0.0.4.7.1.0.4.2.ip6.arpa ([2401:7400:c804:b668:b272:9904:c32b:2ee5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81708c35sm12640135ad.40.2026.11.09.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:35:20 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>
Subject: [PATCH 0/5] memstick: fixes for mspro_block and ms_block
Date: Mon,  9 Nov 2026 23:34:40 +0800
Message-ID: <20261109153510.7161-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This series fixes bugs that I found in the memstick core while writing
the bcm577x5_ms host driver for the Broadcom BCM57765/57785 card reader.

Some of these bugs were really rare, so I used Claude to automatically
fuzz access patterns/events to reproduce some of these issues.

Should I put this with Cc: stable?

Ho Jie Feng (5):
  memstick: mspro_block: don't hand a finished request back to the host
  memstick: mspro_block: wait for running dispatches in
    mspro_block_stop()
  memstick: ms_block: don't erase the old block of an unmapped LBA
  memstick: ms_block: keep the power off during a full msb_reset()
  memstick: ms_block: add the missing newline to the parallel switch
    error

 drivers/memstick/core/ms_block.c    | 11 ++++++++---
 drivers/memstick/core/mspro_block.c |  9 ++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)


base-commit: 461294b587f6fa5bb17d5856e4404b67d666086d
-- 
2.56.0

