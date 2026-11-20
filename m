Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189935;
	b=i9lYLUm/ch3A9YTVNl+vWAtDzMkAxqCImwCskokzs/5+WgykqbqY/OO2/UQZBNybu9ZH
	 KsrkwnXPo1je8Wu4rOv957/5fuo4Ww1iW+lCxOHPOvQTlta9Vi6ihL9KhFbzdHLXzStHT
	 XA0GUeV3/qz/Ri5dR+R3HMLobrFPtuEDrV607oUVHzKNT8azfBfRf/Y3XWRGNm8fOP8PJ
	 D2XcVMxVlH7B3s3PyauFi05u+AEx8FlJc1m9pKG1/7GrRdiiqLPhBlkvEiEKRejnkhMbS
	 5/XuVySXGN7hbF7AEV4KkESaz28vq9Z+raRC1i2pYIkMV5A+MqjxCdJRyJ7gRLtmDMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o0nDPHjheNdO6zZdX+LgK+UkTDP3QtATTApjvPCGCnc=;
	b=2bDY23Hp56srM0rHzRpHn/63aZtMWvznI7BFXk2W/hoBQE/MGjxthSmAzHNk8YkMF2Ps
	 0Df7lyM8juDMkeI8aCMGXvJ0wsXHBKFi++0ZAd+YwDysF3Ywqitop4ssQsQyt/k1ntxYM
	 sWsc45J4Qs3bxJE+u1zXiu7HsJfde1ITXQ8e2Qcoym9vPoID/CzlSYQC5zu8YosZTARMp
	 Fin2pl3ibsdS/CdQ7rNcM09aYF0wdJhvJnNKpPlgSrnSgzA+VSDDixfaT0iVe2NYLGazi
	 i06UrYkbmMHuzDV0E0xqHr2vF6ORCVPrk+iaj/+W4K0XDk6TSezI0GgMEF7HM386E4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starlabs.systems;
	spf=pass smtp.mailfrom=starlabs.systems;
	dkim=pass header.d=starlabs-systems.20260707.gappssmtp.com header.i=@starlabs-systems.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WCwH1Rqf;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC84606A32C
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 15:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC84606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=starlabs-systems.20260707.gappssmtp.com header.i=@starlabs-systems.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WCwH1Rqf
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso7754765e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20260707.gappssmtp.com; s=20260707; t=1795189933; x=1795794733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0nDPHjheNdO6zZdX+LgK+UkTDP3QtATTApjvPCGCnc=;
        b=WCwH1RqfXcIScdHJy67+kfLKwT3+/hNO+QkRu5Opt0VR+buDe/ijfkc2usbr/6Z4kd
         Kw0ewx5QbspFC6o6hGcEPJXruFv4weYCFML7eC6321KZMFDuC3gl0eBCNwyqSDyoMcdj
         uNBOrPNI52NZEo9THh9toLwpC5yMpZDUSXSsyBXag5r1HY+cqsjBc2RnElr3X2yhZMFS
         cprvs3KfotLC2ZdIK+Kvzk11nPb8YlTM7DP4/SSvQ80DKoF6MdKBrCZINJzExS5VmyVB
         diCTjoIWZZQkLyMYcLu/7wCxoQX/ip/j/HvBUN+PoB+J1phxeEq2zy9SXxKLrTpyfPpr
         ltPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189933; x=1795794733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0nDPHjheNdO6zZdX+LgK+UkTDP3QtATTApjvPCGCnc=;
        b=yPYFs4ZFMKszk6hmEnlI/vtHnpmgYW1fPjKLRMCYQ2LfjSiPYJuwA87XSkDdPlSyvE
         IloWZjMzobF19IdSETbpPuSvSEW7lG27gofpATZL+P7j0WvSyFKe8S0+lcrYdeRiicHA
         WMCxVzB3jlgw3SHiloKrMsJMV+doOSs8hp/0XPep5pJ/CiCepHdtlCAUR25U7JDyQo23
         76EQmKWPFHbp69IHrfGDp7KIOmDZ5k/0u6Uc1S30B+TqK8HumOEdCFcPiekDnBk60his
         OF1jFO56xgxZTknoDifqOd0y6ah8tpwNNGGqQpZO8LZfedeO+G2ajd/HzUERm7um7NJr
         Eobw==
X-Forwarded-Encrypted: i=1; AL+hErFzZdIK+faDbO8pMb9u7kGJF049tLfHgi+GhYp/YkeIC3ICqCEX7QZkgQSlXTU9KN7e3Id5Oyb0YKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kvmKndE7JOdTM2s2c4uFx4CPg9p0PXr+XZqDOorSrjHYDVCnH
	4hIIK+3jAsyxVwQFH73gAPaBa3izwleq7lQHoBzteizl5As/fLYfGzZlu68KVsk4QQ==
X-Gm-Gg: AYBFou1GT3hfit/HI3eLBt1TLxD03R1z9pV3WABVK0Xo51bqj2JmjQgplNo0GNOl8gc
	LvnioQCyb+Pb58sc1IH6R5nGnu5Vi9/z0fSrFyMhyvcdQHe7UpwuQhYgGHMKt1iu1Orksciqlbg
	RIKqB4p21qbytZ1zn+0g7p3zF/YKuP7LBb/ECD2himZKDnasagntokZqyIRnRld6c1S/e5Zgzgf
	C6vgKsU9JtLI7TUTZUrd50QThgr2yNx2kvaKyvD/FPii7SaWpzNTRRT5LIdwcoLRsijLDxFIEd3
	hAO2wkNuRw18u+pWn01dcGf3pWzIof4Us1yX+0H0jeW8zzk1UAvCK/TfS5L1eUTaAB8isREBWwE
	r3ybU7n0tNGQGLjJT4//9Zp1B1b6SNfiIIGI7fknLkTYmAdvYNRl9wOQU1oMtnKlR0ZBEsUwEHg
	jekAgGos+xTYQTLfQEPpvf6UEa4vAX4AqTsqMEAxnRY14+pyDs0XwoYiLEpb3Kx4EVg2AoHgNyD
	EWcnOPjXqHgBfaOfw2+TrY8TxPibj/VTQVckurGhngkNK1AN5xByR/SB8JL3TTnIrDJWwbOx+fj
	sHoxQTZOzAF6DA8kLXcADWwj5PQv7nOUuVLs7Kl8vDzyeKwtvKmsjxicLNrKOeFs9QcsewdVAhF
	UE9bIRUNtBYIoI+hnbJUCAbSFa04uDGCi+bEvAQ==
X-Received: by 2002:a05:600c:c09b:b0:4bb:665f:7e52 with SMTP id 5b1f17b1804b1-4bb8880995dmr59500055e9.10.1795189932934;
        Fri, 20 Nov 2026 07:52:12 -0800 (PST)
Received: from fighter ([2a02:8011:ef47:0:33c1:5cb4:17b2:3e17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm132029365e9.8.2026.11.20.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:52:12 -0800 (PST)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Philipp Jonas <pjjonas@web.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: rtsx_usb_sdmmc: allow legacy SD init after CMD8 timeout
Date: Fri, 20 Nov 2026 15:52:11 +0000
Message-ID: <20261120155211.2535908-1-sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
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

According to the rts5139 staging driver, SD 1.x cards do not respond
to SD_SEND_IF_COND. On an RTS5129, a preinserted 2 GB SD card times
out on that command and the driver then rejects CMD55 and subsequent
initialization requests with -ENOMEDIUM. This prevents MMC core from
trying the legacy SD path.

Do not suppress card detection on a timeout from a no-data CMD8.
MMC SEND_EXT_CSD uses the same opcode with a data transfer, so retain
the existing timeout handling for that command. Keep refreshing the
physical card state and retain suppression on other discovery timeouts
to stop repeated probes of an empty tray.

Fixes: 7185b6d33b17 ("mmc: rtsx_usb_sdmmc: suppress false CD after init timeout")
Reported-by: Philipp Jonas <pjjonas@web.de>
Closes: https://lore.kernel.org/r/523eb7d1cc0811df4a5e4c534538f3dd@web.de
Tested-by: Philipp Jonas <pjjonas@web.de>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index bf37fab233cf..55fb83f29328 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -879,10 +879,12 @@ static void sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 finish_detect_card:
 	if (cmd->error) {
 		/*
-		 * detect card when fail to update card existence state and
-		 * speed up card removal when retry
+		 * SD 1.x cards can time out on SEND_IF_COND. Leave card
+		 * detection enabled for the legacy initialization sequence.
+		 * MMC SEND_EXT_CSD shares the opcode but carries data.
 		 */
-		if (!mmc->card && cmd->error == -ETIMEDOUT)
+		if (!mmc->card && cmd->error == -ETIMEDOUT &&
+		    (cmd->opcode != SD_SEND_IF_COND || data))
 			WRITE_ONCE(host->suppress_cd, true);
 		sdmmc_get_cd(mmc);
 		dev_dbg(sdmmc_dev(host), "cmd->error = %d\n", cmd->error);
-- 
2.53.0

