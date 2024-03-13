Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB820313
	for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322257; cv=none; b=aJ38LyrgFeHDQSVE2bQB9ZATEW3eF7j+zyhamvTrs022nfndBqNDBOIImCFEB3sc+ZC1b6uPzs1dYf0j4mBf4kuhZBEZKVkn8jdzUiAIVLb6qqZwcybeBeI+amGEHRB/WvWanKv8E1iUaCRYnW7F4b1mEz4a+d+XLQYyML8dapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322257; c=relaxed/simple;
	bh=YF7fTtdvfzFITVVZ7CSzpov04FdfNLIQqExickCxZeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPAcs25CeadCRaLPws4+xhgMT9OpL3X9em3YJdWx+qGVTZ+ovf+nalKSKXfVh/BOV2exQCAu+nigFrPJuuNcSO13l04xSJZayy7AsFzzr6Nc8z1dNUJksZXMsVTXQf3uvOSc2keq6cdTW8IaDpjNFspjzLc0Z4TudjYeETLIIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RETG+2Ov; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RETG+2Ov"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e99b62e01so2325872f8f.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710322253; x=1710927053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iaQ6hYyfIjuTV/f0JHvHCFbfoBb3uN3YSYBT/944sI=;
        b=RETG+2Ovv1zAj9PIIkkOw5sRzu14cdI8VB2AIPUtjnjlay1wYb+w2gB5GYSr3ujWPl
         XXt4nmVXrgjwTtqsPi56MmocNydKDqQOmpeP4ldMLiT7dJz+tn6bDxyYEZrRdg63DApX
         IBOqpbv2eu2lkFwiPWIesFtM7P5qJ6RnSJ5g4tt++/UhQY5JufHzhEmRz/o/82hjsUXd
         tpC9Pm/0JdT5xnIORBITPwrkx4aLuZkffAuCFYkDHghtge0R04AbSL9+IR0VTChRJT7/
         dQZ5KsgMQpzbFbqxNsizT0NoNpWAdwzJxYpKHVMMzn+dC6/9iTmd44//QWse+zCIb/zj
         2fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710322253; x=1710927053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iaQ6hYyfIjuTV/f0JHvHCFbfoBb3uN3YSYBT/944sI=;
        b=C/bumarF8T+RUfJN6oJWhYtpHygjJk2t86vEMOKaB9RDbah7bUlbGPPD29l+B3gVWx
         fczCQo9DIULwhGHJwz9tUHnLuE6JjZeqN1++gZtta3ILohNHfwYoA+WYATqMtG38xUdn
         oc1TGSqCJSiaInUN4vlDgpk2i15xsHSVffcTBAbbYefAZ+YqELm5OOw4Dv/klRSngScB
         8fNXz9aYDzLbFfOkDsGdvbuzZEK/dIXevW7DYPzstgirlpA9wyPD1Y8Igtu0Kt9DtEWs
         McwhrX3S3DKxTSThXRHUb+hLMwnt2apvGpmj6bGEAzAJ6tk7mSn9zEmkKwl8er3e04Rn
         +U+Q==
X-Gm-Message-State: AOJu0Yy2V39a7eam2K7LOUH42eWXC+w4Brb7nJ4bNvcdHF6cqVkvLNrx
	fohsS0/dNTnCIUD43rSXq6hcMDkRYrygfrLl1NaQyQugZ/Vl/TG8Fi6shJPg8Oq4MBlci1sP66m
	J
X-Google-Smtp-Source: AGHT+IHOxW2fc6sifUNboDvsgW2TAK2bJxYdUATmykFu8/IURNo6dLiw5NA23jNocx0yffVbPmsmHw==
X-Received: by 2002:a5d:6189:0:b0:33d:269e:132a with SMTP id j9-20020a5d6189000000b0033d269e132amr1388116wru.15.1710322252904;
        Wed, 13 Mar 2024 02:30:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id q18-20020adf9dd2000000b0033e90e98886sm8630674wre.71.2024.03.13.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:30:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
Subject: [PATCH] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 13 Mar 2024 11:30:31 +0200
Message-Id: <20240313093031.3507979-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

For development purpose, renesas_sdhi_probe() could be called w/
dma_ops = NULL to force the usage of PIO mode. In this case the
renesas_sdhi_enable_dma() will not be called before transferring data.

If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
call from renesas_sdhi_probe() will configure SDBUF by calling the
renesas_sdhi_sdbuf_width() function, but then SDBUF will be reseted in
tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.

To fix this call again the renesas_sdhi_sdbuf_width(host, 16); in
renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
removed from renesas_sdhi_clk_enable() as the host->reset() is optional.

Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c675dec587ef..b51e04fa5445 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -589,6 +589,12 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			priv->needs_adjust_hs400 = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
+
+			/*
+			 * In case the controller works in PIO mode the SDBUF needs to be set as its
+			 * reset value is zero.
+			 */
+			renesas_sdhi_sdbuf_width(host, 16);
 		} else if (priv->scc_ctl) {
 			renesas_sdhi_scc_reset(host, priv);
 		}
-- 
2.39.2

