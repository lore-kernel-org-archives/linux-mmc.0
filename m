Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDF48AE0D
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875916; cv=none; b=eV8J3moo0ArvlWgcpwTvQLkOQwlcAaEgBsAxhfUuLBflm6KkZM/mR5jsr0436HbRoo+zUJj0hdWVSXAESwXSmEQJKMHWgI3MwVjvmPg7/rS30wnupKfPM4DJyjkZkQTSBqZnCNvKl3w7KVikroXYTRGLQP75fz995C9affehvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875916; c=relaxed/simple;
	bh=vGhPuXq1iNs0S9LWh5B+ANM3UKDA3I+HCz4oggIpVgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1PKEP3D5AvYB7R7yGIMBSXIPkc9TsnzqKLIqZ/tGVqdXyKG8k6Z5TcaqzmuD9l5aFJ/5WBsnyjhpp1UFym6n1sXII6Pjv13Y9YuNPGtYkgPwD7cdTeEJt1GWBiByG7lCVIXSVJ11rOI9e5nch257Em5cRre+/aUcXM4Vv2gWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IMIcAum5; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IMIcAum5"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-664b05d408bso213103d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875914; x=1786480714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1SOtiVsmUE6ZgXMlvd++4bCVWf5EA4Vx02vkVKxhPM=;
        b=cGtkQTiK2LVl48z6Lk75I1lU35F+T8tvn3LuG3kRk4amSY8a8XBziSp5avyexUqma5
         Fqj1H1K38lwn4INK4Auv92ZZKTUcOw8K3zZpl4/oFQ2LK4BlOwQ0wKKqRBAX0P9UsQwI
         vRe3asmZN8gt6VMoMTtHGEJe+flZpx6ZqCCimPws5QoU8ERtdbq+RR1Art3oyXsebaYV
         sXqvSclPSkXOlR5QdE+hi4aUtfFXSqZEJTFmKge7tgDSXtbiQpUTEz0UqOc2LmQEvq9b
         qDZRsHdxwppd5Vopb8Qj6/lFsYp8irsJdHbvbWbdKLNUzp4we0rBcUYwqRYUS5k3/PJP
         CAuA==
X-Forwarded-Encrypted: i=1; AHgh+RpFr7IuznB8ghJTBn9TgViCbTtDDdG6JYbMO/gw/5wt7toh49ppxRprmfVoM0vGHJkdcX0wp7N8Ppg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWu+xgGh1ZaYypc1stnG5+0UTeOp9eWSpvi9CRmWpsRzWhbnSD
	+ttk+eEMnkg0DchIbzmk2usSdq5UYCT7YH0EK5DQSfgUGp4+vqg3pVttg9Sezfbww48cSCY+z4F
	nSZQJr8ERykS2e54Tm7xtQAhrJpvukclNRXPXjJ78D+XSlh1DcHFVh/AsRWWPURtdt0rmLDYdi0
	PeOwAQluI7ljL2E8m0l5u94Gnrsktakyj0IiptDIo3CUg8W1m1HvJuhn6rh/Gsrq1TEAypWIBlf
	Y9847dGSqJM
X-Gm-Gg: AR+sD102D/9l3SdBpcSpJawVaGb27KJfDPr2OCBPyvOHGdd4uv7lEbdEYLW7WaNjjiI
	M7/sL9a2YQ0GGpz2mGXJDac8MfioCnuWUgkra2umxbb8ozASdc0LTAdbzgy/8eR+A3q+mdo1dsQ
	IANMHMBoofo5RtWae4rDBY5qhsJn2q7MDmoGdMjT7TMdNWI5XmF/X3jo5aEoMBe6GMW6Cg7ZA0z
	PKeKvQAUgA+24EpCLcF8bXHVR7xBoLFWnUqtbI5Z6YodV3UpIy0TnUJF+QRJPGUmgnQsRyEn7/z
	XSDxtbrAYCRL+0HLLtetaP8Osxg5+XCwXLkVKi/SBZO7sXl8z+6zqMJrbV0paqzXsR6Ib04iBs6
	w6mFtFncZMsyolrm/D7kyaV2ZUF4WK87WqhSY57/creFy8soWuvjBbGWUfiEzvTVmKLNsa+7hAD
	0XvqJOpSTM+cuNtUISZegqXbzvbUPzRorE
X-Received: by 2002:a05:690e:480a:b0:667:d3ab:d0a with SMTP id 956f58d0204a3-6699ad042c6mr737447d50.52.1785875913783;
        Tue, 04 Aug 2026 13:38:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-669915f1920sm141514d50.24.2026.08.04.13.38.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 13:38:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93106d8affcso26228085a.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785875913; x=1786480713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1SOtiVsmUE6ZgXMlvd++4bCVWf5EA4Vx02vkVKxhPM=;
        b=IMIcAum5+dXw+SKbozC04+S2X3mAFqObSAMX14tdJ2ZGrGNrbMWhmmvwWTaeIf5ZCO
         eXIuyBLlegt9bQ+zT7S6p3yix0vfmqwg3lrq3/W041trg+9VkDpzGEpDFNdzR71jjJZ3
         Oow7C3VmbuoCpNvnQZ2Z5kdUN8l/LawxIrQa0=
X-Forwarded-Encrypted: i=1; AHgh+RplYUVWOODvzKWUebz7SFViunswuQgjPJDtEWIixCCTC08Xf4+HqT2VoxUW3Ga+3AOhVoUs8gi7hTY=@vger.kernel.org
X-Received: by 2002:a05:620a:a00c:b0:92e:6c8a:2a39 with SMTP id af79cd13be357-9364915b1d3mr120054585a.13.1785875912861;
        Tue, 04 Aug 2026 13:38:32 -0700 (PDT)
X-Received: by 2002:a05:620a:a00c:b0:92e:6c8a:2a39 with SMTP id af79cd13be357-9364915b1d3mr120047085a.13.1785875912290;
        Tue, 04 Aug 2026 13:38:32 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a52dbeesm11089085a.30.2026.08.04.13.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:38:31 -0700 (PDT)
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
Subject: [PATCH v6 3/3] mmc: core: Honor keep-power-in-suspend and reset-card-at-resume for (e)MMC
Date: Tue,  4 Aug 2026 16:38:18 -0400
Message-Id: <20260804203818.881765-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804203818.881765-1-kamal.dasu@broadcom.com>
References: <20260804203818.881765-1-kamal.dasu@broadcom.com>
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
safe, since firmware needs to talk to a live card. Since the card is
never power-cycled, nothing else resets it back to a known state
before the kernel reuses it after resume.

keep-power-in-suspend / MMC_PM_KEEP_POWER already exist for the first
part, but are only consumed in the SDIO suspend/resume path
(mmc_sdio_suspend()/mmc_sdio_resume()), gated on a per-function
runtime request via sdio_set_host_pm_flags(). (e)MMC has no
equivalent function-driver layer to make that request, and the
requirement here is a fixed platform characteristic rather than a
per-cycle one, so _mmc_suspend() checks host->pm_caps directly
instead of pm_flags.

When pm_caps has MMC_PM_KEEP_POWER set and pm_type is
MMC_POWEROFF_SUSPEND, skip the poweroff-notify/sleep/power-off
sequence entirely: deselect the card and mark it suspended. The
pm_type check matters because _mmc_suspend() is also called for
shutdown, driver unbind, and undervoltage, none of which are
guaranteed a subsequent _mmc_resume() call, so those still need the
normal power-off path.

reset-card-at-resume covers the second part: when set, _mmc_resume()
resets the host to its initial bus state the same way _mmc_hw_reset()
does for a non-power-cycle reset, before mmc_power_up() and
mmc_init_card() re-identify the card. This is independent of
MMC_PM_KEEP_POWER in the code, though on brcmstb both capabilities
are set together, since keeping the card powered is what creates the
unknown-state problem reset-card-at-resume addresses.

host->pm_flags is set alongside marking the card suspended, and
cleared in _mmc_resume(), so host controller resume handlers can tell
power was preserved if they need to.

Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainelli@broadcom.com/
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
Changes in v6:
  - Reworked around Ulf's two-property split: dropped the
    unconditional mmc_set_clock()/mmc_set_initial_state() reset from
    the suspend-side fast path, and instead perform it in
    _mmc_resume(), gated on the new MMC_CAP2_RESET_AT_RESUME (from
    reset-card-at-resume), matching the property's name and
    description ("before the card can be used, it must be reset").
  - No longer touches MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-
    suspend at all -- that capability and property are gone, per the
    v4 rework; this patch only adds MMC_CAP2_RESET_AT_RESUME.

Changes in v5:
  - Only set host->pm_flags |= MMC_PM_KEEP_POWER after
    mmc_deselect_cards() succeeds, instead of unconditionally before
    it. Otherwise, if the deselect fails, the card is never marked
    suspended, _mmc_resume() takes its early exit, and the flag never
    gets cleared -- leaking it for the rest of uptime.

Changes in v4:
  - Gated the fast path on pm_type == MMC_POWEROFF_SUSPEND; it was
    previously unconditional, so it wrongly skipped the required
    power-off/notify handling during shutdown, unbind and
    undervoltage as well.
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

 drivers/mmc/core/host.c  |  2 ++
 drivers/mmc/core/mmc.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |  1 +
 3 files changed, 36 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d452..1622f7846441 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -400,6 +400,8 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "no-mmc-hs400"))
 		host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
 				 MMC_CAP2_HS400_ES);
+	if (device_property_read_bool(dev, "reset-card-at-resume"))
+		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
 
 	/* Must be after "non-removable" check */
 	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..f85e034c79ed 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2157,6 +2157,26 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
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
+	 */
+	if (pm_type == MMC_POWEROFF_SUSPEND &&
+	    (host->pm_caps & MMC_PM_KEEP_POWER)) {
+		if (!mmc_host_is_spi(host))
+			err = mmc_deselect_cards(host);
+		if (!err) {
+			host->pm_flags |= MMC_PM_KEEP_POWER;
+			mmc_card_set_suspended(host->card);
+		}
+		goto out;
+	}
+
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_host_can_poweroff_notify(host, pm_type))
 		err = mmc_poweroff_notify(host->card, notify_type);
@@ -2217,9 +2237,22 @@ static int _mmc_resume(struct mmc_host *host)
 	if (!mmc_card_suspended(host->card))
 		goto out;
 
+	/*
+	 * Firmware or other hardware may have accessed the card while it
+	 * stayed powered through suspend, leaving it in a state the kernel
+	 * can no longer assume it knows. Reset the host to its initial bus
+	 * state like _mmc_hw_reset() does for a non-power-cycle reset,
+	 * before mmc_init_card() re-identifies the card.
+	 */
+	if (host->caps2 & MMC_CAP2_RESET_AT_RESUME) {
+		mmc_set_clock(host, host->f_init);
+		mmc_set_initial_state(host);
+	}
+
 	mmc_power_up(host, host->card->ocr);
 	err = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_card_clr_suspended(host->card);
+	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 
 out:
 	mmc_release_host(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..14a407a9f9b7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -463,6 +463,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_RESET_AT_RESUME (1 << 29)	/* Card must be reset before use at resume */
 
 	bool			uhs2_sd_tran;	/* UHS-II flag for SD_TRAN state */
 	bool			uhs2_app_cmd;	/* UHS-II flag for APP command */
-- 
2.34.1

