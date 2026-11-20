Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150966;
	b=ZWp9Ym6HkTn6cgybdIjTp+ysREGLIa2x16tAjRgHpW0asbhhtI4GhOmcwbH3YsKMKjdn
	 p96xEiT1b9h0Io1lAq+Wmv5NurKYJjsu8dyTCoMTPuMiDZp5ABExyRZ4RzdlyaAQRfL1M
	 4MpYHInDPNZQCeE1Fwm2OEpBaETBzENPSMd6xgx4fyq9Zu+lEWdWttdb4LcYQF4ysAFW0
	 owuVixeLv9v3CEV3wUV8WK9ywh82FayiP7IJE6ZqE5nnz8GXEmxziQag3EY2FW9mMeCXm
	 vVhbfsrceUdWa1/9n0rFoXMbUn811P9nrNIMrA+RZf2a0P5NNjLh/lTTvTwRBbi5xag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150966;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lLMa3/wI0i/A+eBuqYmrFXouZ7L356xRnwrVv8zr9cs=;
	b=tvh780rVlfi73MefgRIkJnq9VxA4RXJE//dlp5L07+VLoSCL5K/LTWy7IPXLqlCOSCYf
	 ufGPbIgJ6t/sMcHMKTZHIPdhBiLRahuvkUEXoIVoAGXD0d8w1JEbPJ8/Wt1hVK3AFEAuL
	 29tLRjlJxkFnGlg9WCSqPKtM6HnCUboZGAyisgAp8Z6T/hHkaSmnEA9VE6kNqHVhjZ6Z5
	 M8aMUUdiqct3u7i11HUBmIvvqg776Je4ZaOZrCa8k9sipsII1A8t8Xm0id+qzdHbr5wcx
	 1C8Q09kV/W7E0VPXx51XHPrJSwM1fAnzZAm9lTCriydqJHSB5CLmozV1sH2fa51Octw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QG32nTtW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CB606A320;
	Fri, 20 Nov 2026 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QG32nTtW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795150966;
	b=KQrEk67uiCcF8iqLA/If+ZPO3uo0MEHyrFybzJp+wd5st9YAHQSA0njHeYVzXdgBp4dN
	 2eS8sysmw4CcAY/ebOnroJoViS0usZb7BmEAft0XJYyG9xDSeDP26fFjGSGbb6mhe3RRt
	 BEpnyBiIesbMsblZOI3vNuB8QBS4EZYTJhfzWoofJ9Sw0/XXBLwz+ME1tTD0vNx3aRsH3
	 DBOxUkN5NOu53SL9m9TeVeXT7BBQmVnwjD1mAu7EgoSYE3yR2XlgeyzMG/F4w7un37uKQ
	 1BRrlAsjKC1Sf8Jcfdr40i/Vr4HZXuK2M/QNO1uipWebqxomsDZzBuD4IlXajpZjDAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795150966;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lLMa3/wI0i/A+eBuqYmrFXouZ7L356xRnwrVv8zr9cs=;
	b=sCctdpPeVoI2T+cgp5S4tqVXHGDOYEI2CNY8muXxc6WLhf6Rhr+gTx0t0x8NnhA1YB55
	 qDzS6Aq7rQuR6sDAdVCujvULzwBYUizYwdRk+09byWNdX3ZZzjhXtO1bIECnWgD+A8I1S
	 sRAGvBUOC3MgHMtxkqVXPbr3OSmKbXCbpZ9dP98MHWeQA0ZAocwPKtPMzoATQVpfqV7Gq
	 ZSDs9ej7lZI1+E/eyGdkny07lkZXQXJU41ODIR/2vH/9yvtqWu6zOEduSUhoYayuh3azo
	 5KCquUnZoEbY9VZxaVeO6Pnjt83fdibuisaHXPyJTZqkT7EbBnDyXdzfWFKERt7fOYA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C62ED1F000C6;
	Fri, 20 Nov 2026 05:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150966;
	bh=lLMa3/wI0i/A+eBuqYmrFXouZ7L356xRnwrVv8zr9cs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QG32nTtWx+WbOzZgDNA24TSNFOImIiBhIBPiaFK7hUgIMEiPBeqtAGsUSlBKiMx4Z
	 Ey6PKZuP8m2AVR8Xsw5+Vgu1oR59sj0HeUYjR7xgct/wHXhJxPowBkZFe1IJgr5uXZ
	 cxyt96WiffYkZgFm7VrGGPvMvEHwrNKv3gilE/ACs56Fgqu/xqVD0NSCI1UW7uLwXO
	 Eqdrhrf7IQfB8eN0n3S1hnvAol010LEkxLOzLCp1MbSaefqF/7iyLW49jTAqa6yduL
	 OTI0SiLVPOGJ35lJsftSgkEBvejOcyKC5DW9pg3Rv7/qKTMlGmKvXMu9Gnkr6OnXhK
	 MgfdQYxepz27w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 59661496D8;
	Fri, 20 Nov 2026 05:02:45 +0000 (UTC)
From: Athira Palliprath via B4 Relay <devnull+palliprath.chromium.org@kernel.org>
Date: Fri, 20 Nov 2026 05:02:43 +0000
Subject: [PATCH] mmc: core: poll busy at HS clock if CMD6 errors in
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
Message-Id: <20261120-fix-hs400-clock-v1-1-96522138aa3e@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHLU/2oC/x2MQQqAMAwEv1JyNpAWEepXxIPWVINipQURpH83e
 JuB2X2hcBYu0JsXMt9SJJ0qtjEQtulcGWVRB0eus9YRRnlwKy0RhiOFHb1XjjO1LhDo6sqsyf8
 4jLV+taE0Z2EAAAA=
X-Change-ID: 20261120-fix-hs400-clock-99400fb042c0
To: Ulf Hansson <ulfh@kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 palliprath@google.com, Athira Palliprath <palliprath@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795150964; l=2681;
 i=palliprath@chromium.org; s=20261118; h=from:subject:message-id;
 bh=YLwtxDOh0JfJFa+O1qwwy7UmOgrYuamaO4eozXT5naM=;
 b=fMjFiQmZr5ZDCT2h3dwJgoqw0ECRQFpDbxvzXo4v63Zh9UtEoyHeEvLp89+XIIBRq8YsaFp2s
 KvNnzW2Od8tDJP6NwFpWavhXM6ghhVRzUr3i0ccRqRU4H5O9MM6cN7g
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
 drivers/mmc/core/mmc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a02b04938e1a0..03a60b74c3aba 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1197,8 +1197,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time, 0,
-			   false, true, MMC_CMD_RETRIES);
-	if (err) {
+			   false, true, 0);
+	if (err && err != -EILSEQ && err != -ETIMEDOUT) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
 		return err;
@@ -1215,6 +1215,16 @@ static int mmc_select_hs400(struct mmc_card *card)
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
 
+	if (err) {
+		err = mmc_poll_for_busy(card, card->ext_csd.generic_cmd6_time,
+					true, MMC_BUSY_CMD6);
+		if (err) {
+			pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
+				mmc_hostname(host), err);
+			return err;
+		}
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


