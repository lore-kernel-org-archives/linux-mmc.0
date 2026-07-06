Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C061369D67
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352453; cv=none; b=kOu3PJ6nwv+9Qjh2aT9ZF3vvM82dqRXe/Vb/ebTfiDMSXu4LG9fRaYK5APj7bp01XhvveHl45vj/BCrd53CXQ2XS6MccfLf4xMLQrqnxd+di1ZTuZ5/1A1gx+slCYnCDAdsI0nEEVDohBJrbZzd/+rIwxLGqhzYhD6C3m+/naJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352453; c=relaxed/simple;
	bh=0qRk1Ccab5ppm6LnVQAgKi84nDRUH31GO4zylg0MdN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAQjsTPxha6KlLj/B1RjZgn+KVTC+vUQGT2Wo9sJXD9PxN/Jf+0TfHMiVweQal9Awnr4CauGLwS992/yZKLJWJ3c/neZndhVZLSrK+Sn3BA+Q9zvHUWaRuG/1xZMbxXrNVPr+sZhqv0BrAuQRp+JZzZjiw/53umHj0fDr5dzXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=Pu2vAdiq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="Pu2vAdiq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so35260055e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783352450; x=1783957250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VioRyPh/COYBs9Qbi6P5Dnn5InU0S/xx7A/WC4lgww8=;
        b=Pu2vAdiqPjKdxslSBc838vHybtpLHXwioLu3ISyJOa2PQ/CHSihULfh3aQB05O64Qa
         zTuSy9Jp5fUpad3G6hVKHCyCZQ5mqDMNURREm8TshcESQuiJYr15QVtwyfI/382iUpuF
         EcZi7W/JES+dd8n50KaZ93e9fvFSUYEG8jS7X8RwgBqhXJ9EVAbyN2M5qlOaallPXQWp
         tgXlqN9/Bt9Gs2bId5RmOT5UnZsQcONlmns3WWO1acgf63yTdTvodn38LogbDbp8mgUf
         Rr3woxina5YPP4knk2qvLjh9vn9zYjEaIsrP/AXCBM4ZtIjTWK3l7p+7i3NgLMokvJwa
         ceaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352450; x=1783957250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VioRyPh/COYBs9Qbi6P5Dnn5InU0S/xx7A/WC4lgww8=;
        b=MmAwRdrJtgyFwVwoM8oWEpMlDkR23vleuXzaAM9ivtvpDbxjFRR1qJ3G5h8nCZF7oL
         PP/RqvV7Tr7iMuCQd0bInguPbt7bnjqxzFFxWNGbJX/6vgpPpP45ylOjmTUF3lVNzmrF
         Y4RbauXzrqKBIu1HbM0aun9aqud1z4fK/QAaNoGm8KTadPQgHpBFnTu9XZiQWukoiwMt
         8G0NkTHhyPXA9pFOpdu2udR7zzEq1f9/GtjYQvALThR9aAxm9/JOx7KglqOzky5IOy7w
         biYh/vIIqblr6OaOYBsBHI6ixNbsGK0iIIlvyqcBLwDvt8HZiBSC4ak/xDdHhyb1iTUM
         rD3w==
X-Forwarded-Encrypted: i=1; AHgh+RqMkjm0SCzzKrnctY2cskHA9loYdJyNyrwkIq5ri99Q0SQ6V4O5cLamEzDlx9+E6/G2nOHP/psrwfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VvGc4iQAa598X81Sc3M+2ejah1pEd1C2yu9jMPt+K1HPkWN2
	gRrVZxe9mRtYJGQ+iv40+hVQzh0LbOvIHNkO3SRMBBEmbdfRDhPhyUL2ZiZEEANVZQ==
X-Gm-Gg: AfdE7cnglrWKIwOcrk+s8kYjf8kPP8UIb1rQgbc1sohKQe+SjxAjwpL0GGN3mhPh4N+
	xJ3/pqwGLK45aSXi5PFYG6Bu4c8B32RuLLb5eo07X0snPbHSNAXACI4n5ZWIhs/cC9rIVC/+hJ7
	DFAIasNZAUwuSBXfOzdQWCnnTtiYxE+fITvlqMXT4cOgrntJOWbY7AREt/DeVUuUYNXnqoeQ0nH
	GDLr/rRY80YMuKNvBs9P7jpnOsGRj9sTz6Lu9alz/5Qmfz1iqm47PhLIIaI9tL2VYrCsBVoYPnK
	uDBYndq1UvFQt4jQ2XsOybd7ey3WfwksRr8d9NMkIRfoTqkdc/hD/BLfrtcb/D6733EDGKmt9Hl
	dI6VrNlieMxCyFC87eHfBfo4A+naH/CQJBYsX8xyTt4XPlN9BcCTuL44t7nw53Jpk/FpsXLYbHz
	uqfD2xBDlcmw/s6klg5JW0dofYhfNwa5icdQkktGxPl3L6e5z6FA8LrQE=
X-Received: by 2002:a05:600c:4f81:b0:493:b8dd:9d68 with SMTP id 5b1f17b1804b1-493df041a17mr11863665e9.10.1783352449883;
        Mon, 06 Jul 2026 08:40:49 -0700 (PDT)
Received: from horizon.localdomain ([150.228.6.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce03fa1sm283699005e9.11.2026.07.06.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:40:49 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Sean Rhodes <sean@starlabs.systems>,
	Lee Jones <lee@kernel.org>,
	Roger Tseng <rogerable@realtek.com>,
	Dan Carpenter <error27@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mmc: rtsx_usb_sdmmc: suppress false CD after init timeout
Date: Mon,  6 Jul 2026 16:40:44 +0100
Message-ID: <1d6f22a3777e78d6232cbe7dc3aa17ded8fc32e2.1783352430.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783352430.git.sean@starlabs.systems>
References: <cover.1783352430.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Realtek USB SD readers with a tray keep raw SD_CD asserted
when an empty tray is inserted. The MMC core then repeatedly tries to
initialize non-existent media, sees command timeouts, calls ->get_cd()
again, and starts the same detect cycle over.

Do not qualify media by open-coding MMC commands in ->get_cd().
Instead, let the normal MMC rescan path probe the card. If an
initialization command times out before a card has been attached,
suppress the raw SD_CD signal so the host can settle and the USB
parent can autosuspend.

Clear the suppression only when raw SD_CD drops. On the affected tray
reader, changing media requires removing and reinserting the tray, so
a low CD transition is the signal that a new insertion attempt can be
trusted again.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 84674659a84d..bf37fab233cf 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -44,6 +44,7 @@ struct rtsx_usb_sdmmc {
 	bool			double_clk;
 	bool			host_removal;
 	bool			card_exist;
+	bool			suppress_cd;
 	bool			initial_mode;
 	bool			ddr_mode;
 
@@ -774,6 +775,7 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	struct rtsx_ucr *ucr = host->ucr;
 	int err;
 	u16 val;
+	bool cd;
 
 	if (host->host_removal)
 		return -ENOMEDIUM;
@@ -791,8 +793,14 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 
 	/* get OCP status */
 	host->ocp_stat = (val >> 4) & 0x03;
+	cd = val & SD_CD;
 
-	if (val & SD_CD) {
+	if (!cd) {
+		WRITE_ONCE(host->suppress_cd, false);
+		goto no_card;
+	}
+
+	if (!READ_ONCE(host->suppress_cd)) {
 		host->card_exist = true;
 		return 1;
 	}
@@ -874,6 +882,8 @@ static void sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 * detect card when fail to update card existence state and
 		 * speed up card removal when retry
 		 */
+		if (!mmc->card && cmd->error == -ETIMEDOUT)
+			WRITE_ONCE(host->suppress_cd, true);
 		sdmmc_get_cd(mmc);
 		dev_dbg(sdmmc_dev(host), "cmd->error = %d\n", cmd->error);
 	}
@@ -1359,6 +1369,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 
 	host->power_mode = MMC_POWER_OFF;
 	host->ocp_stat = 0;
+	host->suppress_cd = false;
 }
 
 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
