Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238763;
	b=yba5N0cTJjL96FiAC/L66/l5aIYzUiDsKZAggDAyJ9R3rkYyfyGBBwKuXlZEhxp3Gjls
	 4Kuc4xGK6oPA+541zsCQwHESpn3o4ULnRistyMPb949BAyohtvGRkHAcAXpwvQlXvRd9V
	 aUTKDwh9dMkbtCqFEHGx+r7ndYMohytjXd3U3cKktFM/OG6bEyf++gWdpsRjlfu28iNRt
	 WONr25QSyWJba569sZGiMh5+z6vMxs8oTrm6rMtL4kh3LwrEzRhDYx10Z0eJx1Unk95/l
	 wYp15KROn1NrViGcpMLGW6NcckkeJvfbmgRzeqMqJVP6eUGpUUnt84hi5B+kI7uwZ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nL0IF/YmuAg98DBAGyGyZcFLc0hJUD80Dr2gsrocgZo=;
	b=ox4PfA9lJS4ecn77lBKp6Gas+3s4i0uujc7HcRsn0z3Y9eLNYQRACXKZopH0cMuiOsND
	 /+SdsNVtwrvmcTfHIQ+A+8Hhq7U4+VebFSgpYQJW48sOdw27csVNTTwmBT2od6AFiDL7b
	 UYEd/T5EOHva5fkAL1RaoSYKqdM+zSRt6x2gvlOWtLDYwyCaHiTwPmGQ+e9omV6y6YpKK
	 JzpsgMZS5sOHD5j7Y/lhWhcQXR5yVo+7T8QcbFb0YsnO5iC04UiF/Y754DM8O+9oy9yJP
	 +3ys5r9RvphIoWd7jsLeHimamG/eWTQBLwUCQipFaL5viSLl6U1xqbKHIy8/T76Em5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdSDdijr;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22036606A337
	for <linux-mmc@vger.kernel.org>; Mon,  9 Nov 2026 15:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22036606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RdSDdijr
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so488903a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2026 07:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238762; x=1794843562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nL0IF/YmuAg98DBAGyGyZcFLc0hJUD80Dr2gsrocgZo=;
        b=RdSDdijrqnnbq00rXmYWS2nQclZ6+qsK7Tlab49IqOye5Ua9a4IsOT+wI4KPwGh5Rv
         LHc+JKi4Woj+R3KvYNsAG7U+UshdKFar6LKClaIptGVdojiB95Vt5gZGx78aclcTRavs
         mpBeTMd+Fl5qgRhKdrZ5R4/E18K9RGFJO+UyIHHUyR9WAgX1Exs/r2mS+VCfwt22hqsS
         0H7UWtQ/+zI6w4yd0/V3MBtj+G8M/SRiWOa2hgSfiTdgiVyProfNaiVW7IKvkM01Bs9l
         7L8EG+reC6uZPH+qN46R8C/X1FEkO/CtIpH6QIEKN9UKYKxmfLx10WTlWZxIVexoTrpe
         8gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238762; x=1794843562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nL0IF/YmuAg98DBAGyGyZcFLc0hJUD80Dr2gsrocgZo=;
        b=bEG6rS0j9EejVg5qk8G7zuLywt9j3sb7U/cdq4mzkIEkGbxwJxBcvW4LFXUnChc0nc
         pSanzrOqcIuauJFIvQ4eLRf7Y53QB/q4sVn4e/ThGyucvuv98GzoU5qpycuLusmFmZ9B
         /fqA5aX+eyVUJlG6V9iT8pu1tC6BNr1jRHL/S/xS0r3nWExG1ApUS3R5nOYemUKPf3yV
         2mjPhxHAwUhTiNNnTtp+rpNaxvOfmrgYrZrxUa4VW5eDyFnHGQxvbixUnB1uk91B5PeS
         eUGQPwYOZu8Z2hXeoQUrmxqfJPNGn4HnDdqhz4BWO1xtVzndgyVlk6PCygI4hDyUt+Tr
         OfvA==
X-Forwarded-Encrypted: i=1; AL+hErHgL/HuDHBMCqnVCxjViEe4pktJhp3T7yOrN2U7URPp92flFQk9SCx60ENvlvS83AAb+0zNfKkHNHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+x4iqjsjeOLvSbWDeDCfF/5egN6UderYQm8TOg4bY5XbG7PrTQ
	PYx3akEXheB0Oj4V2hzSQsIaNLQ4stmTFmaF2retX6r+hrpor/kmxeNB
X-Gm-Gg: AYBFou0tbBx3Z5XdOzmYV9Iq6Rf+924Z2k1jNxAdLeKp4C4QmqqxD45dp8lO4VTOPD9
	Wjoo60325dRVN4i0+RJYq9yloKrEVyDMWz6Hl2PxNL/QYINTB893bCgDIZWTG9HyObJDNJsPy01
	wCgzYMJ9utAU9QVd7veApQpZphlaSxAgffmtave/peZ2+N3guAkEQWgSZVlKhcXc1hZ4pCQh95A
	ddlIhoPHY3QBp9AXi+IOX2AFnyQUloiOGm/dMRn3McM7bqX3HB8LhaM1w4ZbxKNPAY2emsY6eoi
	xfOrS/I+z5mETvd/OKHYXvDhvbxQymQf/wBhQs8DTZRM9UGnBOk/UMXotqaYBTfpBGL4ucqPfH4
	WCDJNVVfUun4nqxd9FU0CexjqbNHffQo67v+D5y9l3wcXF2SG6j4rMSxw7JNXRpVfpYXBGJDSIU
	/5HUEzX/hPJLdd0LISljR5byd3PFcAKUGAQ8TVGv7Zn/eZrJB15oNOBqXxmnQGs1mR0hFp4jugL
	g2JSBUJq6qVwsqDxvXO8MgT1nXdc5aUkcj9LKNj9aAI4wXK2E7q5HdI6axNecLQ5Uy4Ly9u7okL
	EpqhV7HV8+VFg936z4IrlVum2KzsVMaFrDk1bYA1tAUcPn/A3dv+IVRSqXRX+VceU18fj/1Zz2n
	ql4p6gpNHm+cdSJfg4kh6A/9C
X-Received: by 2002:a17:90b:554f:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3b12d51f0b3mr4293568a91.48.1794238761542;
        Mon, 09 Nov 2026 07:39:21 -0800 (PST)
Received: from 0.0.4.7.1.0.4.2.ip6.arpa ([2401:7400:c804:b668:b272:9904:c32b:2ee5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm11062029a91.0.2026.11.09.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:39:21 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Yifei Gao <gyf161023@gmail.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] memstick: ms_block: add the missing newline to the parallel switch error
Date: Mon,  9 Nov 2026 23:38:04 +0800
Message-ID: <20261109153832.7377-5-hjf3108@gmail.com>
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

Allow printk to finalize the record immediately instead of waiting
for the next message with a newline.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/memstick/core/ms_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 66672235a4584..7237a6789e0ca 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -778,7 +778,7 @@ static int msb_switch_to_parallel(struct msb_data *msb)
 
 	error = msb_run_state_machine(msb, h_msb_parallel_switch);
 	if (error) {
-		pr_err("Switch to parallel failed");
+		pr_err("Switch to parallel failed\n");
 		msb->regs.param.system &= ~MEMSTICK_SYS_PAM;
 		msb_reset(msb, true);
 		return -EFAULT;
-- 
2.56.0

