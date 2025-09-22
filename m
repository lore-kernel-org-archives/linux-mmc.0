Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100F4A1E
	for <linux-mmc@vger.kernel.org>; Mon, 22 Sep 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543296; cv=none; b=hEud2m4e9ctDkviPlfFyHQHhA3dpFwRxYlH7ZbNamzSvuHr2L3GimTeq6mXiSh1vTK3neLdIhlo1NmvAlHSt3/Qm+d0DvgjGBeiHwMRYc0SGm4Y4QVNNJ8kxDI/J/fSDHXw88qRS2YAcnAccYgGiDoQEgwwIIoZIimtQxE9D3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543296; c=relaxed/simple;
	bh=s3TZHCsvBKTHC4VDJoY8CP/+x8truixAUpds0Qxw8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3Fag9yA5Y+qc5q9esWnx1qO8YrR89rICTCGaaq5bMQKmEhRi1mOa5rafcM66qAkXV8/bDeybxWl0yvIQrBF+bWVwWxYI7N+tbTCBKltdP4Et5Pev2a2DOTlWq/0EGeYkg56LKwIRT6phxorWGFszUj3axRQ91iKUh4+/DJrymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JpVTTPgA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JpVTTPgA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JpVTTPgA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JpVTTPgA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD50033A5A;
	Mon, 22 Sep 2025 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758543292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e6UoiFCg3+pyeaMkWnMdohoObmZ3Y84lNo209nAcLhk=;
	b=JpVTTPgAeLzB2fx+jqSpHVFfFjs2YiXXFglG2juRQ8fhMxs90pYP8dG2P/9DnJIQY4Ab7n
	fV2OE6pMNGLuPNJO6TX5S9csNDb9ce0krTlDUh+KoXyEhm+4ksnjOSjwwAawCmqIMMxus4
	5M2n67TnhgezkxElGPGswtRY9BKtb8M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758543292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e6UoiFCg3+pyeaMkWnMdohoObmZ3Y84lNo209nAcLhk=;
	b=JpVTTPgAeLzB2fx+jqSpHVFfFjs2YiXXFglG2juRQ8fhMxs90pYP8dG2P/9DnJIQY4Ab7n
	fV2OE6pMNGLuPNJO6TX5S9csNDb9ce0krTlDUh+KoXyEhm+4ksnjOSjwwAawCmqIMMxus4
	5M2n67TnhgezkxElGPGswtRY9BKtb8M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7703213A63;
	Mon, 22 Sep 2025 12:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jW7fG7w90WiEYAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 22 Sep 2025 12:14:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: ulf.hansson@linaro.org,
	wsa+renesas@sang-engineering.com,
	avri.altman@wdc.com,
	adrian.hunter@intel.com,
	viro@zeniv.linux.org.uk,
	ansuelsmth@gmail.com,
	linux-mmc@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] mmc: core: remove uselss memalloc_noio_save
Date: Mon, 22 Sep 2025 14:14:30 +0200
Message-ID: <20250922121448.1377124-1-oneukum@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linaro.org,sang-engineering.com,wdc.com,intel.com,zeniv.linux.org.uk,gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

mmc_sd_num_wr_blocks() is in the block error path.
It needs to use GFP_NOIO. There is no need to complicate
anything here.

Fixes: 869d37475788 ("mmc: core: Use GFP_NOIO in ACMD22")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/mmc/core/block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9cc47bf94804..766691d27a04 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -995,7 +995,6 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	u32 result;
 	__be32 *blocks;
 	u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
-	unsigned int noio_flag;
 
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
@@ -1020,9 +1019,7 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
-	noio_flag = memalloc_noio_save();
-	blocks = kmalloc(resp_sz, GFP_KERNEL);
-	memalloc_noio_restore(noio_flag);
+	blocks = kmalloc(resp_sz, GFP_NOIO);
 	if (!blocks)
 		return -ENOMEM;
 
-- 
2.51.0

