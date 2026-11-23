Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795416737;
	b=m/hnyC8j7I7uob6T2Yp2eUZmRxQ4HlgRQHX0tT2lBpwXsTOh0pfC7Yod8yXYtnX9rqyv
	 QQBHd87cQ9/p+X4Ld9W1WdWKdXL6X43k+/IzhP+QKgpbz4N2hm/LeEMC9C/L4tD8/GI4Y
	 mamTgCeYSmQkp/w313yiPbsSBSDA7xWc5IxvQN3iv96Bf0j+5GPC0vHOXdLAPFX9VTcgF
	 +UOSHUcO7MaF1/zLRgQ+U2/zC1a3MzAGqzwsT/KrsumRThxjLs1AwfJwvo0z/34vPBFtX
	 1lTVW4FLnQozO5zQEiUYeWzOAMBe8w1FwdCWnYSj10nKBcBuoaA6Zws9NfLVS8xM3zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416737;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GUKVQF78LxhcCZ4rExAOoGb06gsLyRPQJ3PlRYhBYIw=;
	b=1tTWBvTTS6sObQOEmxNq8zF/Cdx9MoLtMSq+FZI/zDdnb3wpg+0M46lfixeay1AIpqme
	 xfBLwQYWeHkvprYErA7Eptrx1KJI2sBHtHwiIhRNaqc0cG2uexAbGQ6VzBrqX8ks0MO7g
	 zSCsWZNWn3eXXC+0CCOZxgA3PD8h9znVfyAT3M1XoWc6yT233bB6nN7iEVS5UCtUU1C33
	 I9L31dpl9FwQkIAMYXVJV2J8dJ0kxSyhcSSxcBRtB78eKZ8P/FQ6Uya8aQCo/1K+Wz34i
	 ZtZ0phMj+3sg87on1Re/GcjMBi/ZBRa7bCRF2MlW1AJoosBEVU6ixzRVhMDSfN2f3oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKCiH2Fr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E1606A31A;
	Mon, 23 Nov 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKCiH2Fr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795416737;
	b=OnXBMuoNsC2qmr8sRf9y0gUDmIUqI7B0vDNZzS2JibLXkg09p9uZbOwRGqzawDgz2+YC
	 oK8FNTMWCilrW5Z8+ZUDxsh/8XkzSZpyfUJimG+h7ZDoJkQkm2xNpcwsRN/f6/xE1Rr0B
	 XQCOFTYHAki6l7tmddHVNJYqdup07tVw94zYTt8Xcx0APbjYKadL90fpu37MvOA9UwrAF
	 CbA5wYLnxCkno3fjVuxV1IOPg0Pk3G8fWjADStLuv8OmVCuSxkGN5ilR2SV3iH3fMzeah
	 MKt9Bn1YtUWMz3vSLQY0eQvIvPd3iRmNEKaHrC34qifsn7P/5TvEj+xgNX1H/Crb0jQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795416737;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GUKVQF78LxhcCZ4rExAOoGb06gsLyRPQJ3PlRYhBYIw=;
	b=xZlZdbpNuPo7BYq8kUiUExpwRiv8VrCMaGtIm2wgdmPNemFZ9Ik4I8UOqBx64SwkBmo7
	 Bdt+y0sogJ4VYAWwPxXmUif2UDaXjFzizhePL+mup3AfcftAs1JKzpGwBLzRtYVHVdYqP
	 D2+A7YBIAWJCqQHnZQ1PfOQ1IFWtxbovH/QzTJ2lUOezkudCzfjmbxF21DMPJUlyO5hh0
	 S2jLAH/chtLcgVCWIqnop5a1qTBxyymUv+R0m6VTW92AZ7x34JJhli01Bc3UQN2s+QZ/i
	 GpWNwY0yKvfWq+TJubwAwaaHGGdoYi1fQpns2lmEWW02UdD3nwXhx1cTcdJeU0J4Hsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC2621F000CA;
	Mon, 23 Nov 2026 06:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795416737;
	bh=GUKVQF78LxhcCZ4rExAOoGb06gsLyRPQJ3PlRYhBYIw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=fKCiH2FreNy01XVnTxsbvdQjwmIXeZFe63xOJm0CAwFCBuJWod7wMY0Rz4A0+5uuc
	 dg7NxGZZMXBaj64nw5NUre1CW2thbgYJoC6tM9bujOw1h9hdvFHPW5fHuRJ8vzevKX
	 2jJKGYS9/JVWq5V6MKZAde8G9JYwTQmDtRP4w1hERnXUCyGaedKLQ32gEKefllOxhx
	 gb3tRUXTsVp/4NMVtOgoEoip6eYVXSh38ic7lxThr9FFXK9zELVTuMWDGAYeQcucMg
	 79LcoYODHyjVuI70eMyTzk6m4jGiY3Mhs2PSat2vyAs8zviG2KSwtBH0BCuEOwsO9t
	 Y0xSrqy540Lvw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57CDC4C399;
	Mon, 23 Nov 2026 06:52:11 +0000 (UTC)
From: Athira Palliprath via B4 Relay <devnull+palliprath.chromium.org@kernel.org>
Date: Mon, 23 Nov 2026 06:52:08 +0000
Subject: [PATCH v2] mmc: core: poll busy at HS clock if CMD6 errors in
 mmc_select_hs400
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-fix-hs400-clock-v2-1-ad3b935bd9f9@chromium.org>
X-B4-Tracking: v=1; b=H4sIAJfiA2sC/3WNTQ6CMBCFr0Jm7Zh2QGJdeQ/DotZCJwolUyUa0
 rtb2bt738v7WSF5YZ/gVK0gfuHEcSpAuwpcsNPgkW+FgRS1WpPCnt8YUqMUukd0dzSm6P6qGnI
 KSmsWXyLb4qUrHDg9o3y2g0X/3P9bi0aNpj0Q6fpobe3PLkgc+TXuowzQ5Zy/BylIY7EAAAA=
X-Change-ID: 20261120-fix-hs400-clock-99400fb042c0
To: Ulf Hansson <ulfh@kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 palliprath@google.com, Athira Palliprath <palliprath@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795416730; l=4337;
 i=palliprath@chromium.org; s=20261118; h=from:subject:message-id;
 bh=LgH1THntmAvlqiGNxlcLpYqtPqoAxQtaL85fDfG/ZnQ=;
 b=kU4ot6vnYSfPC/tm5TT5gNcJTkEkEeW7Ooh0EGqLGPDmIiLl8QMQ0J14O522sygH7K+cKjzDv
 3R1HBjwETOnAt8ItX0eS4Dss+i1630e6xGr92zprEvJAak5ZfmjkbSD
X-Developer-Key: i=palliprath@chromium.org; a=ed25519;
 pk=OTJWz85nJwutJ218eeYfQMyFjDnPEnUi0L8N9EGsTa4=
X-Endpoint-Received: by B4 Relay for palliprath@chromium.org/20261118 with
 auth_id=1580
X-Original-From: Athira Palliprath <palliprath@chromium.org>
Reply-To: palliprath@chromium.org
Content-Transfer-Encoding: 7bit

From: Athira Palliprath <palliprath@chromium.org>

When switching from HS200 to HS in mmc_select_hs400(), some eMMC cards
immediately switch to 52 MHz HS timing upon receiving CMD6, causing the
host at 200 MHz to fail sampling the R1b response (-EILSEQ / -ETIMEDOUT)
and leaving the host stuck at 200 MHz HS200 while the card is in 52 MHz
HS mode.

To keep JEDEC JESD84-B51 ordering (send CMD6 first, then lower clock to
<= 52 MHz), pass retries = 0 to __mmc_switch() and, if it fails with
-EILSEQ or -ETIMEDOUT, switch the host to HS timing and 52 MHz first
before polling for busy completion at 52 MHz. Other error codes still
fail immediately.

Also temporarily set host->retune_crc_disable across the HS200->HS
__mmc_switch() and fallback mmc_poll_for_busy(). Since mmc_select_hs400()
runs right after HS200 tuning enables host->can_retune, an expected
-EILSEQ on CMD6 (or on a retried CMD13 while polling) would otherwise
flag host->need_retune in mmc_request_done(), triggering invalid tuning
at 52 MHz HS timing on resume/reset or leaving re-tuning pending after
returning to HS400.

The retries parameter in __mmc_switch() was added in
commit 5e52a168be37 ("mmc: core: Add a retries parameter to __mmc_switch
function") specifically so callers where retrying CMD6 is harmful (such
as eMMC sanitize in commit 5b96247c68d8 ("mmc: core: Let eMMC sanitize
not retry in case of timeout/failure")) can pass 0 instead of
MMC_CMD_RETRIES. Passing 0 here trades off automatic retries if a
transient bus error corrupts the CMD6 request itself at 200 MHz, in
order to avoid retrying CMD6 at 200 MHz after the card has already
switched to 52 MHz.

Fixes: 649c6059d237 ("mmc: mmc: Fix HS switch failure in mmc_select_hs400()")
Signed-off-by: Athira Palliprath <palliprath@chromium.org>
---
Changes in v2:
- Temporarily set host->retune_crc_disable across the HS200->HS
  __mmc_switch() and fallback mmc_poll_for_busy() so expected -EILSEQ
  errors do not set host->need_retune (reported by Sashiko AI review).
- Link to v1: https://lore.kernel.org/r/20261120-fix-hs400-clock-v1-1-96522138aa3e@chromium.org
---
 drivers/mmc/core/mmc.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a02b04938e1a0..d4fc0bab690f6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1181,6 +1181,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
+	bool retune_crc_disable;
 	unsigned int max_dtr;
 	int err = 0;
 	u8 val;
@@ -1192,13 +1193,22 @@ static int mmc_select_hs400(struct mmc_card *card)
 	      host->ios.bus_width == MMC_BUS_WIDTH_8))
 		return 0;
 
-	/* Switch card to HS mode */
+	/*
+	 * Switch card to HS mode.
+	 * Temporarily suppress CRC-triggered re-tuning because non-compliant
+	 * cards may switch to 52 MHz HS immediately on CMD6, causing an
+	 * expected -EILSEQ at 200 MHz (or on a retried CMD13 while polling)
+	 * that would otherwise set host->need_retune.
+	 */
 	val = EXT_CSD_TIMING_HS;
+	retune_crc_disable = host->retune_crc_disable;
+	host->retune_crc_disable = true;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true, MMC_CMD_RETRIES);
-	if (err) {
+			   false, true, 0);
+	if (err && err != -EILSEQ && err != -ETIMEDOUT) {
+		host->retune_crc_disable = retune_crc_disable;
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
 		return err;
@@ -1215,6 +1225,16 @@ static int mmc_select_hs400(struct mmc_card *card)
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
 
+	if (err)
+		err = mmc_poll_for_busy(card, card->ext_csd.generic_cmd6_time,
+					true, MMC_BUSY_CMD6);
+	host->retune_crc_disable = retune_crc_disable;
+	if (err) {
+		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
+		       mmc_hostname(host), err);
+		return err;
+	}
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;

---
base-commit: d2616724e01132376c78872b8324f38659af9f28
change-id: 20261120-fix-hs400-clock-99400fb042c0

Best regards,
-- 
Athira Palliprath <palliprath@chromium.org>


