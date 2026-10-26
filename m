Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998042;
	b=2wdca6vi/sn1JrD/MS6tGsWnJ/n6i8XqOqssgtuFz4QjUpFzcyuXbU5kpPcJ84hbgtV2
	 WrW3XyFuazqDYsxH7cijhwhF+eEA8P9fCs6lNF472kx6XehcnhjhNF2oSCbum2ng6ABRJ
	 6GvtIDBtupQ0ZZuq10zJMrDtEiIy/0Uw2zuT4qckhnuTIQwxUAkw8io1FsYc575D6YU3o
	 rZWxhkLqh0F9ciufTwAOiGy4YJcxIneGZf6b3Ck+b2LtBFYcXdOYhUaI02qQv7+EeIdcP
	 1ccHfqeFZ2Tx93L8qTiw5NwXBkY+//NJoPQF7/FCvbZOnj4cfKbzb/Ygp+Z9cejJqmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998042;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GA405jjg1oy9XsfdL3uCT+kPI+tLb1CwSG7y0Rl3BsI=;
	b=syTPnJ3HgXQ1ydFIIAh0kDkxcKtO44VgPLaQwsstkZQKmhXwG4XCKCXMhZXlT27xQrG6
	 /sW85DBkuhhrrMdGUfrVidJawf1gWUCindtSxwRp2hPqn9VRCccT11AHkBYqWp5uCmaeW
	 S4u3JceYncmhio4wSR+NSATOferwGoyVjFD37NGzoNggxl2tbP+Y+VEqg6JcI5vw3e3Y/
	 5RwG9j1AErmYMLbY73NUJDqGqbyzUp2oip1d3qXo8aBqMVE7RaM0+dgxEPuLLYvbmt052
	 XpZkAWvgbBKYbH/6+huHqU91liXjnpxyp/qy5wAVe5xB0MQun4LhVXLjCsGO3FowDQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J0KN14Nz;
	arc=none smtp.remote-ip=95.215.58.31
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCBF606A31D
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 07:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCBF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J0KN14Nz
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6kvQ/Bwxdh8Klia4u43nik8nSsLsM1qOF+SbQ/eRJog=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792998039; v=1; x=1793602839;
 b=J0KN14NzVURrB9KG0LeNunSJ0md6986w/aQI8liz1vKaYkSpEHZixGAlGqySVMXWG3O1SWM4
 2B+PdgyCcGAHiB8dVogZRF75ExkdikZbfrQhJPq7/3EpEiCM0jQCEXIFKc1jKCMZtIw2kcePaMz
 OV5PkhAHSZ5horj4QojFALow=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ac9873a0fe15efeb;
	Mon, 26 Oct 2026 07:00:39 +0000
X-Mizu-Trace-ID: ac9873a0fe15efeb
X-Migadu-Flow: FLOW_OUT
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: Fix wrong comments in the regulator helpers
Date: Mon, 26 Oct 2026 15:00:29 +0800
Message-Id: <20261026070029.1108506-1-shawn.lin@linux.dev>
X-Mailer: git-send-email 2.25.1
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

From: Shawn Lin <shawn.lin@rock-chips.com>

mmc_ocrbitnum_to_vdd() stores the voltage range in microvolts, as the
min_uV and max_uV argument names say, but its kernel-doc documents the
unit as mV. Fix the unit.

mmc_regulator_disable_vqmmc() returns void, but its kernel-doc claims
that it returns 0 or an errno. Drop that sentence.

No functional change.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index a85179f1a4de..bbc773c647fa 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -19,8 +19,8 @@
 /**
  * mmc_ocrbitnum_to_vdd - Convert a OCR bit number to its voltage
  * @vdd_bit:	OCR bit number
- * @min_uV:	minimum voltage value (mV)
- * @max_uV:	maximum voltage value (mV)
+ * @min_uV:	minimum voltage value (uV)
+ * @max_uV:	maximum voltage value (uV)
  *
  * This function returns the voltage range according to the provided OCR
  * bit number. If conversion is not possible a negative errno value returned.
@@ -418,7 +418,7 @@ EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
  * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
  * @mmc: the host to regulate
  *
- * Returns 0 or errno. Disables the regulator for vqmmc.
+ * Disables the regulator for vqmmc.
  * Keeps track of the enable status for ensuring that calls to
  * regulator_enable/disable are balanced.
  */
-- 
2.25.1

