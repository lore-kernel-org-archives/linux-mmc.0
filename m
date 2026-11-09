Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238755;
	b=Wwy5wgSDq43PlTDXxaoMG2j/u5ftd2VRPIRKqfMsZLAN3Cl5YtgPsGr/XEdIEoVG1IZD
	 kgyh6xIRo4h1fFS0WY7ydNulU37eiw0kCePsojFBzNc5turp41qdeP3K93vjFgaIm84RJ
	 L7B83Et0/eGqtDieR2IG+tiTTobG2uhuV51G+lSEWAV36gcvw/h8wr5bRLMu6u4cu7qGp
	 vpUh23bv/NuhuKc2A1xfyFlz7MnDxJ/PG/wIdZgK5BH0NeSYpnsQIcJ50AZaB8z0Jyrw6
	 AZVwTO+/dMYSFhp72eKnjq3zZtTCl/ke/+BNtIUZYFPkxWe9wYbRzXLrJD1B9M4pjgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ucJzEIuQhPLqhVZPFT3+82Rere1QwP99Naonf6q25LA=;
	b=JGipNxTqHtOoOXHkPqszJ/8YMmpyi5cwLtj6S56srQF8GUxGnJysR0Al4Xl4y2hNccac
	 HnAwAwTRG6NN9+cBcCJTShzW8vskXL+T5fzWKdEQs/z+DoWVpmM/3VcpJkE2Js+TGDfng
	 mZsCFvFPaa+lU7CWjOd9bTeARNvOindm/gQ3X2EXf15CIEqJCkMo5hVILiUxP/6XzqEy5
	 6jIj+ErE4T1YOgzi5+k3bZ07DTe+/h6pZm74S71qSyM/T4gDvKTy/YOV60kzHHPVr+2rZ
	 SnH8+pHsxe75RgHaPkpXH+PJ8I+BoeVv7z+esZ2p8a/0MVRV8veVdim7ox5KivLH2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s0w/Tzza";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C0606A325
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 15:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3C0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0w/Tzza
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so561235a91.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238754; x=1794843554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucJzEIuQhPLqhVZPFT3+82Rere1QwP99Naonf6q25LA=;
        b=s0w/Tzza1bQR1JXhoNZKQJP4sdFxLbY0G5ZMDIo+57yFdQVpmlSzpG4SBIHdSSv3N8
         +FAHwbA+++lAj6F3ee7KJENw/+mnyRqdMj7GYianIBpp55QAc6h2Eq6IjLYeE6zSaTxi
         9TwEomBhhFc606IfAunOO9sEyF96Hi6l0MS3DznSpQ3rEVZRkOxEKSeCefD4Do+fUmxW
         x7W6FAoeP6mA388pZ3EWoPTctbMLoXFUfcGpN5lJuKWd2b3p5FHQplur3wAt9iXeifHc
         N1e38OWZpHNT73nwJSBOAYWrws1EpXfmw7CnzYdLH8Rrv2n2U/dBVjyuH70tt0YL3xkh
         w+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238754; x=1794843554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucJzEIuQhPLqhVZPFT3+82Rere1QwP99Naonf6q25LA=;
        b=PlHgV8vnalGsow+CiNN7OSKUEtr299c96/iL1RIsjG6Uu9fQRaASoeMOl/KCuzbq53
         maIl5BuMtWmY8hhzI339asp55BZYHyLF7wQs6FOg4Kb/21K6JwBXEcSEmHqEiNJSwdXD
         JcJzTPY5pMPkXN5zwr+cobvp2W6jBWlSam7krVCxQ3m4qHoUdMpZYc+rMxBv1cSva8UK
         U9ghTDoXnURc7xt05vt1H1Al52Zl/O47sbNw9Sd19OOejupX5VGxTBfEsuxC+OIy0RAW
         NNQCMdIFnhV0EZi/ENaPmYTi7ArlSwzP1fvMyG7rJWi5hvFalR33xRJYPc1TvvDE4tJs
         kQcg==
X-Forwarded-Encrypted: i=1; AL+hErHp1C7jVwY7/qkvEGz7qv0utV6h9GDk2GtnyfuXZI3K2QjYuaf3xDvZAdFq2GAQp835pthxmJjMd44=@vger.kernel.org
X-Gm-Message-State: APuU4Z+N1my817UQVxpGYM4coBkLFPEbid0/S93NzuqXfMjoLMLvcPVh
	f5Qx2x33ia8TjXVP9KwI0oRD+YQReJiUXZ4EubPq55i9BEV+IYyAWsxq
X-Gm-Gg: AYBFou1joLYpEnBmFhr1bWZiOkpX7tzy1xqYAwXB1nL3ObSVIqFArXJ21VMKb6brgYB
	NU0KabvTLya3yIkbbZ0Bw2YcZTQ3zkHMsnBekSBHagubIfgDAwtkRpORRRFu/S0o7COc5K61ViV
	O3MO6+QtHdZ+l7aH+cmRPQ899utp2ZwaDT5MMQ+yUJY162C3z9LviUF8Flj2dYTb7eakL3TVKJ7
	2NcdVCICNkS14wHuHkUQpiJq/KGA5CKZV0VsgwpIM7CtV4nL+UcY0j8GyYe5RaJ/16x9ExMC+EA
	LOP38hhTqWbZ+YB7LLGsYquF85vFczW/HcKEQY7b8mRlEf6FcRo01qXmecgLezqgVjZeywwf6JE
	0Z7hVBMYcjDz485DSGx51uP7I8foZbNk2ELJVp7/33hG5cm1ts0pvU60hw+LUj3sAWGXJ+ljgKT
	abOUs34YygRrhK9bOdXXS7VnreOUvxM4UeGkfD8bno7zl3aRnePaoPdAGjG8Xbeu/10pQ9G2Zo2
	ictivIDnlp22y8aIjZw0SAvgT8qZEv3LHmG1n/KshT6S69pg+GA3VXv4ZrqGanqWYHHuScHsy3L
	+nAgivoYtLn3e/RNA5tHpNvp1looLqedaJJve6+4heLnYytqherI5vDpRGdIPW/7/R/YQq3fXHt
	6V08=
X-Received: by 2002:a17:90b:3ecd:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3b12d3e71d8mr4395338a91.42.1794238752545;
        Mon, 09 Nov 2026 07:39:12 -0800 (PST)
Received: from 0.0.4.7.1.0.4.2.ip6.arpa ([2401:7400:c804:b668:b272:9904:c32b:2ee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm11062029a91.0.2026.11.09.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:39:12 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Yifei Gao <gyf161023@gmail.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] memstick: ms_block: keep the power off during a full msb_reset()
Date: Mon,  9 Nov 2026 23:38:03 +0800
Message-ID: <20261109153832.7377-4-hjf3108@gmail.com>
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

Keep the power off for long enough so that the card properly
power cycles.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/memstick/core/ms_block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index e373eaf92530f..66672235a4584 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -740,6 +740,9 @@ static int msb_reset(struct msb_data *msb, bool full)
 
 		msb_invalidate_reg_window(msb);
 
+		/* Allow enough time for the card to fully power off */
+		msleep(20);
+
 		error = host->set_param(host,
 					MEMSTICK_POWER, MEMSTICK_POWER_ON);
 		if (error)
-- 
2.56.0

