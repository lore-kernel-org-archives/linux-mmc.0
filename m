Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717794;
	b=wat81NVQ0+Sod/N7w+rF+6hgh0Sm2Xuv3MHCCYdCvmeAxex63kqOPsoyapipROQTqcKm
	 QnVxCm+HBVNfUseZUKFHUv1H08rGRoAKon88bAHvudw7Y2p5Aqm/y+afFj4et4x5fSbT7
	 1ikLkBX4KYKvi74IIn8Jh0362+FIEHr+eF54bZYoW1poHtISYfBQQCe7NHwhpAxrQYksY
	 G1UG/QFH41YhrekkNq6ax1dUc7NmAAS0iw89e9mtrBuRfiKRIYIUKMCSWBAv0YwuewM2V
	 gxa6Gn93I+0mSQwHQ6dzEE+k3DwL/a4EksyTxPQw+rVXZjEz4HTRUR6x/4JGoFehMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZacRs5JbXlxo/OQerWiYpTqRNCbFu2nOrkARU1a5+kk=;
	b=Osk34TmSxkOQwklSdfH5q58vh/Ku3jgl0araAkalztJaDaEmNJ3yNgm2vM5oKozRb1nW
	 j1T8icxc2aQ6VUZ36nSWZxRjTCcORgalfMKqZbTk7IBhsoB7FNmimsb51BFPb6+T7C8Ce
	 vEydM0wylKcwT3rsr3fNvculGd/7wMBnvEEvYpn2gqTyItCVdBA7EXR5dDnspVbzU7mds
	 vnzHlMoj07TpIrItvtAUQ45kjU3CkUeNu1prf3CTyfzVAWbg/lW+XVrNc/vrPXxFY6O5f
	 1EMukSR3R8ab4locOBaHs5GLG/Lf82npxEsnfeCED8DEn5ZhzF5MDcFu6lj2oxGm5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fc32uFlP;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AC606A689
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 18:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14AC606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fc32uFlP
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so4943658f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 10:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795717792; x=1796322592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZacRs5JbXlxo/OQerWiYpTqRNCbFu2nOrkARU1a5+kk=;
        b=fc32uFlP6VlCsTBDohgQ4H7elNIQnLDaShQ4dhgK5Fm5hjOo2YW1MQGGM0bYz0suEI
         3rVbyXDP8iFx/UtWAY9TOPaL1Yv1RvgadtTuIxrsO6m17QHCXEQuClKhc0HseDKqnEmD
         mtDyhYhRIjNLSzsQ6ghlNdfInk63QDYCQak2jzsubNl/hFI6R5IHb94/5jG3Xnz+8f1U
         JvR3zb4UUZewww6/UuJBhBMWrTFr40Sj7sb4PMKZ15bfqvo1dqyAB3cXK94ZqtHRg2JA
         xbcA9DPFom4OdJzDoPaPMFa33RlJr6DJQM8HssN9Su60yLjYhMX034WlX53cqhtTBvMC
         lbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795717792; x=1796322592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZacRs5JbXlxo/OQerWiYpTqRNCbFu2nOrkARU1a5+kk=;
        b=Op9PvgX6BrBo0YMnjKtL8PcoH5ZXPO5GIBHeXFqkbSa3wC71PwFqEGTqGJwo9WWiZB
         Pcj41vxad+Z4mY2CwF7ff7RisihQT7DOoS1xFVqnQjMu/p+8hk6rTD8bJefO8u26Kg5g
         rHd+dA2u8XdULVxpNHXOPpLjI4giXhlq3CffZgkqDT2MxmVGLczNtdfE39Gaz7JYYbtW
         s86Ofy+3/I6MG2RVHPq8HLa2ZTKWTYPKTHBz3fuVyGIskZVySVlpaFRZggo7nLqjbni8
         xVjoqBz2jx0V/ILxfm0HjW9n2ePcg+X/7+DpAXdQlrYLD/P9o/v/UGOugd8lnbZmUUoO
         Hmiw==
X-Forwarded-Encrypted: i=1; AL+hErEz/lQfIppzpwx5BwW2Pc/ypLE9Dm5uPPmBPk+bGDF7xDRbdPxNg8xVP3aNw4b0E7LIuz0p4uRq4lM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J3cOwEA+G/ZhApAY9nYSXYAZJ4+D8UWgVkV848a/MDPA5e2bL
	MxsWECFnDsinnja++22sTtY31sm9k7/K5wVfI9zMZxMtzhpljj8jjiR4
X-Gm-Gg: AZFdTZeozsAYQSOvRWM1PecN5kiQi3WupJxxyv+VvRwJvp+8yU0y/88AAHykp8PPPN5
	aOW6b8txu3z0ehImhExalGCZtWiuWepFGd6QgCZRVfUAgOizC7/kwik08AfQIrr4Lc0+CO+/hBs
	xq5wXOruER7bJegmY3Ro/UFbgQanydoGsZ393390xqN5/jqmJ3jjag+FSX/34nLa3Rga+iqPpMQ
	nwMChj85EuPmq4Obog3Vy7D1m6wca/xn2Y7AptnQ5yuE5CXir1RaaO1r07Wwa+r4FA1lMvdeNYS
	gvQcR7LLdjLk3s3EFU3vdHO7Kimg6WyGnmPJImEMbDVHXM5JzNEOO3cpmg6wRHFB/GoZO3lN8wi
	iNicC1zeYZQxduhiy+nTu+gub2bxmNt1/HChO1WXLvmGQKN/gbP9xZJL7I2nG8O7HZOCtiejRDj
	vQDiCdPb8WaTHcNcEe08b0hbolEG8Jp39+opMD2BwRRwB/qRoCdLuX4a9Z9v9Kw0cHJkzZ6GDt2
	n6i9Zg8otE4hacxaPEtYCxU1c7FdIiiEaIy0itIGLs0vx5Ku/uOy2AjoEuR2f6T9xn6OroNYjNs
	9YDWxwYrTI1YrCZ3oUFzwDo/XIGbUBC1IazckM3JGwvywMXah1pBeRMHQeSkYB4tGKPANBw3Z2c
	+gxS+SQeJwBLwvLs0J+kvvuW7Lcov4bLpmSNzrJ0Ol9MQpYlj0kbJlcMioGyTFPHvoERS01HhlL
	XpjuAABJ6KJBdl3xS6okXn9TUPu8Pe/S75uMoLTQCCEsZSVKmgM4etOJPUIeIJIYu2b6an9Siao
	ESWs+N9H//aczF7gDmx/znOfRunzJxVv6OsUhh0sg==
X-Received: by 2002:a05:6000:4284:b0:4a8:647c:f964 with SMTP id ffacd0b85a97d-4abb6d04d79mr46331265f8f.57.1795717792277;
        Thu, 26 Nov 2026 10:29:52 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm42382159f8f.41.2026.11.26.10.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:29:51 -0800 (PST)
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
Subject: [PATCH v2 3/3] mmc: sunxi: Distinguish CRC and timeout errors
Date: Thu, 26 Nov 2026 19:29:44 +0100
Message-ID: <20261126182944.3136900-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126182944.3136900-1-jernej.skrabec@gmail.com>
References: <20261126182944.3136900-1-jernej.skrabec@gmail.com>
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
index b862df26e192..c2e84c22d3fa 100644
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

