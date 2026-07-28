Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67F472528
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265413; cv=none; b=KwB/zveHqYT5xfK6aMICBMkNTe+9JdsJug8tuC3uUuekVH/ePPyRvQ5CrQZ2/4Clv2Vcc4Lf0idsmH2O0SeQbcRWwYZ9BarRnvro3VVQ6GUbUmcHVIxEG/tgdwwaplI8SBQgSTTglQSRizsK6SdEU+9TZMnIPjaOmrguCskrGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265413; c=relaxed/simple;
	bh=eetq7XpE3Ybytc8Hsj07t5iui7R/XqM3b5H6eDBH200=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJfiz83zhQRzGWzwe7WrH/Huid+Xi5+5Jt6b5OI0JP/EXpgIuNJ6l8KgY6BgYS5B0eP6sSqR7IeMLhMjfntXYqU+ZvgG2zZ6iHnrw5WHTEzg+tNW94YoZqGwttbbUVHhu3uXgnSKWcnZ03vYWe1tbg25D4EA3c2T2di43tn2q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SXqZIyzG; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXqZIyzG"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso191984b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 12:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265409; x=1785870209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCgHHDSjxqQac2HFS0bKfls/PU3Kxpy40sOV/zTVIrc=;
        b=cT5qjpdsyPhFEoljSH7bpBVc4De8OQn16RXqe+pC/I3ogFj0KsZUoXYynOrH6S/8Mx
         yEDLEt8ppKUjYqacu+QJV1d/wT/71+Cm00EI8eOQrbuURLrQT1Hv05bkqpwmcXqiYN2N
         WFcqhpkEPTUBb+5gkPZgGoseopImey4gZkrhVjSZj37UVix6mVw7yQDCPEEejleJW8mK
         9Al9PWVIVsiZa2fFIF+C1kpwT/iUtpqvlnbDg9yYjkg67T+gF+Ab3ul3Ei5Lb6NflboM
         5TE3jQpvsu3zevfNSdjx3SvOMaZ6xubecu7QGqbMQl21B9E8WmGWo/d0VHbLKV+ohxXK
         QIkA==
X-Forwarded-Encrypted: i=1; AHgh+Rrb2vFUGyHOz5Z82pWAZWMDUPLFXHqwwYQI3zf6D+jOOglyFA6FaGo2+MXBCvMX9AEL7bJ9LdPsIX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYg1BDzZhYn6bR+SyAoGmo7RZcBJjVeKWePe6MpfAbs2ycVbT
	SbuyZdPBAHodpZ2QjQEZtVN9Nqk25HqSadOFCJDDAz8tmCodetmUiDpDxhKsdyJ3zjxfQnMzyz+
	0gWBlSPN7oDRa6aaejECocUNGxzXBV9371g6U2rH6jzrJ4ca0eDRAg5EjXKNT3LwRqpr3eRcPzP
	yeaMB8GdymmGFKOz6NlYb1OkJXlUA1uWxGdXkn34XGfE/WKSJSKIf3qp5B8BcYrQOFkYn4FuO5k
	Evrf5kus/7T
X-Gm-Gg: AR+sD12ByHyZ634n0gn079OHAXwVsdPi5eyEnSNuQTay+ONjWBUeBKrAkleAiLtFkrH
	0w0YnANM+UV3Ws5hqd6+dDHsKc3g00l5F6opGvRjy4zXH3EM6ZQRQDuuU+OeWIl9AxGp8Z29fHr
	ZXJ+2scx9Rjhw1tTn9nHzE5HUp61dCvqGCdHdyjVw1PfJeRBMrsDN9x0YuPn5U7dfppTHd2GDJU
	VhcUrCMg9fxOODra/xKr4zfJcouH5Rlmhr9LBFk6TYfFmKcf4JQG1F+dgvIyMIC+xl7PB/FrPWT
	a6q8LlV9SAMVZ8pYDrJi5fe9m9TI2XGw7nQgiMn0i/lsREGGYUs0Ct9Ia/zfuUey2Hux/b3/Dfx
	g5cDTF35y7qBBxwOKrulZCBWafU/hoz/OcyiWaW4Zfwiiz/yNjQYb5Js4scnuuyk4kjq12VTD/A
	E+HqwQH2nKJTx84Bx/4EPm0XD92uOD5lsO
X-Received: by 2002:a05:6a00:3a1f:b0:845:bda6:574b with SMTP id d2e1a72fcca58-84e931f8e3cmr4095010b3a.5.1785265409077;
        Tue, 28 Jul 2026 12:03:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84e9fe115a0sm56629b3a.2.2026.07.28.12.03.28
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2026 12:03:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52769fc3f2eso2496041cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785265408; x=1785870208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CCgHHDSjxqQac2HFS0bKfls/PU3Kxpy40sOV/zTVIrc=;
        b=SXqZIyzG/5CPFxxGinxQzO+l5JwSMuAYr4LmjeEvKO42tusVbXGYTZ0jTXKly+3q+z
         Did1VGWlziX2AJ1XObhLSLZDmmUDHnpI/ib7XiYu0QWMtafFYCM821zqVDiA8FDgLXts
         /yPieoMbebUeuI13RxLLxz+Tynav3iJBdEI8U=
X-Forwarded-Encrypted: i=1; AHgh+RrrmP6cS+v9Yy3H0MXkpCLi4Jih6cl+E8em6UHbFuO2t++wjdfeHLFPUuQXp97sgocck8RhHgafOY0=@vger.kernel.org
X-Received: by 2002:ac8:5a8f:0:b0:51c:83ee:e429 with SMTP id d75a77b69052e-529d7247571mr33198751cf.78.1785265407730;
        Tue, 28 Jul 2026 12:03:27 -0700 (PDT)
X-Received: by 2002:ac8:5a8f:0:b0:51c:83ee:e429 with SMTP id d75a77b69052e-529d7247571mr33198201cf.78.1785265407041;
        Tue, 28 Jul 2026 12:03:27 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8b21esm5502856d6.46.2026.07.28.12.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:03:26 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mmc: core: Honor keep-power-in-suspend for (e)MMC in suspend/resume
Date: Tue, 28 Jul 2026 15:03:14 -0400
Message-Id: <20260728190314.2325906-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728190314.2325906-1-kamal.dasu@broadcom.com>
References: <20260728190314.2325906-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On some platforms, firmware accesses the (e)MMC card directly during
resume from Suspend-to-DRAM, before the kernel's own resume path has
run, in order to load boot code. This requires the card to remain
powered and responsive throughout suspend: putting it to sleep,
sending it a power-off notification, or removing its supply is not
safe, since firmware needs to talk to a live card.

keep-power-in-suspend / MMC_PM_KEEP_POWER already exist for this
purpose, but are only consumed in the SDIO suspend/resume path
(mmc_sdio_suspend()/mmc_sdio_resume()), gated on a per-function
runtime request via sdio_set_host_pm_flags(). (e)MMC has no
equivalent function-driver layer to make that request, and the
requirement here is a fixed platform characteristic rather than a
per-cycle one, so _mmc_suspend() checks host->pm_caps directly
instead of pm_flags.

When pm_caps has MMC_PM_KEEP_POWER set and pm_type is
MMC_POWEROFF_SUSPEND, skip the poweroff-notify/sleep/power-off
sequence entirely: deselect the card, reset the host to its initial
bus state the same way _mmc_hw_reset() does for a non-power-cycle
reset, mark the card suspended, and set host->pm_flags |=
MMC_PM_KEEP_POWER.

Setting MMC_PM_KEEP_POWER in host->pm_flags during suspend ensures
that host controller resume handlers are aware that card power was
preserved across suspend, allowing them to perform a soft resume
sequence instead of assuming power was lost. Clear this flag in
_mmc_resume() upon completion.

The pm_type check matters because _mmc_suspend() is also called for
shutdown, driver unbind, and undervoltage, none of which are
guaranteed a subsequent _mmc_resume() call, so those still need the
normal power-off path.

Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainelli@broadcom.com/
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
Changes in v4:
  - Gated the fast path on pm_type == MMC_POWEROFF_SUSPEND; it was
    previously unconditional, so it wrongly skipped the required
    power-off/notify handling during shutdown, unbind and
    undervoltage as well.
  - Reset the host to its initial bus state (mmc_set_clock() +
    mmc_set_initial_state(), matching _mmc_hw_reset()'s non-power-
    cycle path) before marking the card suspended.
  - Set/clear host->pm_flags |= MMC_PM_KEEP_POWER around the suspend/
    resume, mirroring the SDIO convention, so host controller resume
    handlers can tell power was preserved and perform a soft resume
    sequence instead of assuming power was lost.
  - Dropped MMC_CAP2_NO_POWEROFF_SUSPEND and the no-mmc-poweroff-
    suspend DT property entirely. Reuse keep-power-in-suspend /
    MMC_PM_KEEP_POWER instead, per Krzysztof's point that the new
    property described the same contract as the existing one.
    _mmc_suspend() now checks host->pm_caps directly rather than
    pm_flags, since (e)MMC has no per-function driver to make the
    dynamic sdio_set_host_pm_flags()-style request SDIO uses.

Changes in v3:
  - Reworked _mmc_suspend() to skip poweroff-notify/sleep/power-off
    entirely, not just SLEEP, per Ulf.
  - Renamed to MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-suspend.

Changes in v2:
  - Replaced the card-level MMC_QUIRK_BROKEN_SLEEP quirk with a host
    capability, per Ulf.
  - Added Reported-by/Closes crediting Florian.

 drivers/mmc/core/mmc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..dff4e372ecc6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2157,6 +2157,35 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 			goto out;
 	}
 
+	/*
+	 * Keep the card powered across an actual suspend; shutdown, unbind
+	 * and undervoltage still need the normal power-off path below,
+	 * since they aren't guaranteed a subsequent _mmc_resume().
+	 *
+	 * Check pm_caps, not pm_flags: unlike SDIO, (e)MMC has no
+	 * per-function driver to request this via
+	 * sdio_set_host_pm_flags(), so it's a fixed platform trait here.
+	 *
+	 * Set MMC_PM_KEEP_POWER in pm_flags so host controller drivers
+	 * know card power was preserved during suspend and perform a
+	 * soft resume sequence.
+	 *
+	 * Reset the host to its initial bus state like _mmc_hw_reset()
+	 * does.
+	 */
+	if (pm_type == MMC_POWEROFF_SUSPEND &&
+	    (host->pm_caps & MMC_PM_KEEP_POWER)) {
+		host->pm_flags |= MMC_PM_KEEP_POWER;
+		if (!mmc_host_is_spi(host))
+			err = mmc_deselect_cards(host);
+		if (!err) {
+			mmc_set_clock(host, host->f_init);
+			mmc_set_initial_state(host);
+			mmc_card_set_suspended(host->card);
+		}
+		goto out;
+	}
+
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_host_can_poweroff_notify(host, pm_type))
 		err = mmc_poweroff_notify(host->card, notify_type);
@@ -2220,6 +2249,7 @@ static int _mmc_resume(struct mmc_host *host)
 	mmc_power_up(host, host->card->ocr);
 	err = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
+	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 
 out:
 	mmc_release_host(host);
-- 
2.34.1

