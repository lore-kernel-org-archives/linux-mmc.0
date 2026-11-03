Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730657;
	b=C9eocmAylwRKkfVvTuaZPFUOaD/jRVtJAdARe0l+9j503xOrWeDorLWcjxkIwxJBQb0R
	 hewbhVFflbYLz2QDuFeCES/IZGfcWuvEzCx8upJ5M5QZntBoazlEWHxgiabTODs2j35h2
	 NGrzXcuEoQ0vZcgc9mp3LunFxZOVs+wKFKyBYXFryj740wrM4vFz8JAhnTOrBUQe/DJ8/
	 QWzJ2cfrJF3YOUU25a/XMJXEMCAwAYNd7rgxEHMsUi9zV+rf+ADGe43LTzlexCtjS3vAB
	 34rp5zFOgjuIg4sa66iLErYKoPUPoLmA8FzTIOsgKuvFw22+aUtDri7CJfJljr6WOfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ub0WZcvYrfsAg+1QngeRQr7bchPe1sdav2r3oWVP5WQ=;
	b=T3Ep+SzkhqyumAClbDotMaIrWfXapn3KdYszM44ozT6+uzejsVLpE5sLb7yfei/kpmZ5
	 WIDUK1dX11zFYOSccSORJ0nz+GhqeLm8C1PYJoNYAKetKdAnLDxB93n+64yeJFYtDY+EO
	 QoRM4Y+K+bslS3UONaCeZF4w6msp8wymyGpXywYo9lfK0P1uh1LqP7ckz6wefPy/E9c9v
	 qh0KRoErMTynOTwxe4UCuQ/H2v7znQkCQ1Qw38AVhP/JwWyQryWeiOU/t/0ma36sD/TGt
	 kBdyUXH906gDiNjDNtlzJeTc42j8G0Vu3lLcOBTwi2+uINOytCtmggU2hoNG4j8ElYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nO469B1O;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61803606D812
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 18:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61803606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nO469B1O
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d05d51553so29962265e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730656; x=1794335456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ub0WZcvYrfsAg+1QngeRQr7bchPe1sdav2r3oWVP5WQ=;
        b=nO469B1OhySyj4Eq3Nr824UOlch/dqrL435H0TKCuf2FvOnVvu8I9qaLKZD9zd76qF
         LeeVBGkEZwM1ZYbn8e9Rpyri0LPSaYM1v9UqO0S2xwvYptXskLG9via+8qrndPv7pXd9
         pNRjfoNA9adhVvtd3Z5EVIcDEjI2ch9WReTvXjN0AgxLovj+xV24pmNTpndHoJGdXh9g
         KawRNwONalcv5OKl5Huu1pAwt5bjfKpa2FhG+zA+EXi7p09aOL5PdFkg7IXouQwHW52H
         zH11ASs/mY1l3ES9+W7S1S82AxjJA05gG7EiVbtmpEQjJSVHgu0phKbi9Dn+or9FRq2Z
         y/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730656; x=1794335456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ub0WZcvYrfsAg+1QngeRQr7bchPe1sdav2r3oWVP5WQ=;
        b=Ko3scZlStAZEaAs4TBm02N4fn1c2+vnC7TG+jXobEUhMsGNNWylj6rLhtuZq1je2/E
         A9dScOFxSFupCyP2RV+t+9fiUy8P5GoOm38oICRDbQSESPge+Q6eIUSVmOXP59vqQZhG
         e8esxs7E/igil4KCfzqWmF+84WQATjDGKBk1Yy6ksay+Qb/UpK3U47ymFrOjNncPHjOw
         exnHOd0u+AmTgJv6mFrHNXKZHdK4PdknzZR6rt0AitShnAYJUQkz+USHa4sVkuaeWaa5
         8OKozlbNmHkkdej2ZyYw+7EOdlCUt0f2BfpqddmTLqXiho195z6/ea0z7C6iRvxhqDDS
         Jr2Q==
X-Forwarded-Encrypted: i=1; AKwUvBy19QWQREp9LKELvIcPCmWaecHMbSu1PRWBVI1MA0TmjZ4WFy0TOfQ+naPzJ2mg69HHn8Yp6nakOWc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Sj/yGJOXqQgXbziiF89GfY8TYLbfWGhsR8tR9cHUC3Pb1BN8m
	NgABad48LCf3kRkQJyNUOjdbnaDY6V7mf/DtcjRFyH52ifOD8KrGslcz
X-Gm-Gg: AYBFou2AIpaZxSPisG9E3KVGY6E5xFwlme1ft16TqK4ADNOuWzrx6NjE+t+7KzEJcR+
	69FlAt9VRu+5/KJwexBbnRtliblj74bI9Km4LTdV5XRvNmyLfqCwtCgdLUKH/TEJ31PqbwTSNG/
	TqiNTeojQ0KPphCX3Bw/nm/aLRbryXaMfIOFG06LAqjhFb44mW6x+GKk4dPX4rym9ACFB3dsjdl
	k65DkVVWCSJJGsGcEdSnN1DHn397r5Ec3pp3AMM6e1a9JWKzeSq58rypjKmY/zbawNf9CJemU8Y
	eShr1oOQdD4AZPMe8s9Kv+/aliL5X0qPuMeWCj3peLZ+ycmkpEURxr5Hc7Jqdt/IzA6b5w0Ng6P
	n5Ixevbt7n6fmZsSHZHZjhh1kIUhH6PhurkitYXW8tInRXXspVNlRPoNa2+vmW3DqE8b21NRNLh
	3r/HtUY43IbIWfFmCqb9zxHWkhlZ14FNU0dXkjOvg7y1L9L2t8gHygK9S0oW/1+mMRZXCRtHQnp
	9+ElC5SfEZtypsmb5wsOG0yWO8N4FXmmqWQi6FtSYkewLy4+/4kg2AwyOAPzHb0ccEbdctSOVCM
	tVFOxPcX499YUGkGI6rDLlo0D2SDQIze9nM/Eme4XZkObPaa9dcbzLEyddcLUBZM3Zc1PbBlVe0
	oZvFaz/wjQ27fwDGqz4jI+3NC8TbFNeHgmdU0wZRLoRFukrGv/sBMK4x3MHNrMu7uX0tfZ3ibjV
	kaCW7En+sLdyKDhoDQvYHMM3YdrqegZ2IRcEoeJjiJ7/T6RGPmS9z5GmNlwhzKoiz2No976QCts
	7Fu6C3zEORypkjvLomWcjl+KuCoL5kiX11HLimd623DCINdhg==
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ac187a80bfmr329609245e9.30.1793730655752;
        Tue, 03 Nov 2026 10:30:55 -0800 (PST)
Received: from jernej-laptop (194-152-27-116.dynamic.telemach.net. [194.152.27.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm146339785e9.14.2026.11.03.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:30:55 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 4/4] mmc: sunxi: Distinguish CRC and timeout errors
Date: Tue,  3 Nov 2026 19:30:30 +0100
Message-ID: <20261103183030.81078-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103183030.81078-1-jernej.skrabec@gmail.com>
References: <20261103183030.81078-1-jernej.skrabec@gmail.com>
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

The driver reports every command and data error as -ETIMEDOUT. The MMC
core however relies on -EILSEQ to recognize CRC errors, which mean
that the sampling point drifted, and flags the host for retuning when
it sees one. With every error reported as a timeout, retuning is never
triggered.

Report response and data CRC, start bit and end bit errors as -EILSEQ
and keep reporting timeouts as -ETIMEDOUT, attributed to the command or
data phase that actually failed. Report any other error as -EIO.

Currently supported SoCs don't implement tuning, so this doesn't change
much for them, but it is needed for the upcoming A523 delay-chain
tuning support.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b875ef4c2b79..eb1b7883a715 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -537,13 +537,29 @@ static irqreturn_t sunxi_mmc_finalize_request(struct sunxi_mmc_host *host)
 
 	if (host->int_sum & SDXC_INTERRUPT_ERROR_BIT) {
 		sunxi_mmc_dump_errinfo(host);
-		mrq->cmd->error = -ETIMEDOUT;
+
+		if (host->int_sum &
+		    (SDXC_RESP_ERROR | SDXC_RESP_CRC_ERROR))
+			mrq->cmd->error = -EILSEQ;
+		else if (host->int_sum & SDXC_RESP_TIMEOUT)
+			mrq->cmd->error = -ETIMEDOUT;
 
 		if (data) {
-			data->error = -ETIMEDOUT;
+			if (host->int_sum &
+			    (SDXC_DATA_CRC_ERROR | SDXC_START_BIT_ERROR |
+			     SDXC_END_BIT_ERROR))
+				data->error = -EILSEQ;
+			else if (host->int_sum &
+				 (SDXC_DATA_TIMEOUT | SDXC_FIFO_RUN_ERROR |
+				  SDXC_HARD_WARE_LOCKED))
+				data->error = -ETIMEDOUT;
+
 			host->manual_stop_mrq = mrq;
 		}
 
+		if (!mrq->cmd->error && (!data || !data->error))
+			mrq->cmd->error = -EIO;
+
 		if (mrq->stop)
 			mrq->stop->error = -ETIMEDOUT;
 	} else {
-- 
2.43.0

