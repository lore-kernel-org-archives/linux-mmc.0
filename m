Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="k5cxZLcH"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7F171C
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 01:10:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33318b866a0so1659144f8f.3
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 01:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701421838; x=1702026638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGkdE3ShZBtVYdzFjb0Caam+cQoN6A+OKXsRf0MTX64=;
        b=k5cxZLcHul+zqe1oTBXN5DTyVF3kRq1KKkdCjX11fF7O3r5O1HDOUQJrR5rzYNN1qW
         4ThLIEdy139OmQXXE+RCmcpQ/zOwzcsftXHkExfMH1VcXVRMJ2wy20TEJ0xCgzphB2Ll
         jk0SJcImvYgYkP/fc7MkZur4qcVPUEXZB3P1GXI2ZqbD9rb7PIaKKaKjWIfpvOsjZZej
         KIzXGJ2B4zqbLYWlXwMOGZ+HzWjnLFr3LA0IfltS/PHZsSiIZ99EpJoiqK2j/xwgUI4v
         JD6ffM2j2Obh/YM7WBBvL8m3yciRnFYhG1kRaDmK2ixrhG2euO1ZiILNBqY6lGFg+1hG
         6Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421838; x=1702026638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGkdE3ShZBtVYdzFjb0Caam+cQoN6A+OKXsRf0MTX64=;
        b=tZSfRHo3eGAT8ma56Tp/aeE8tO6yKFGKiXQVOBcEKQM2Uc5r5+31jofRfJ/gLUJh/p
         /85AOq8F3PppGIOp6zXkSCOLsF7GghstkAB7kHN2l2Qd/deBr9oSTpdaMzSWI5X5+zNJ
         a0GIp1xxueHD+xA7whcXbTqi+MonLPbObkcngZeYc0Ex1ecOOKHnUEmapzDYDedsmVn/
         GJKOxEAHLtlvlZPDit8YQg5mbqrhtzzSgU7sTZ4VnPbJLIknvmoi6qErbXcW1dHgC94l
         Wi/XKCvTH2b7k2c+9dKWEf4M38Sq/Vn+FDBNEOWdiL1zOuIJfymr+X/MyaLJuuvb8YMd
         DpJw==
X-Gm-Message-State: AOJu0YzcWNUObvRAdgglnun/1+tRc4vWqiES2Y4krgX6lwVzm+Ng3pyA
	H4GRaJYINsj5lVKsWLK7PYOgCQ==
X-Google-Smtp-Source: AGHT+IHZonxthapqsbWJUZ2LZiH+1fCsdg6XXK042uL4XQkFvWOB7sgRe1iNUmtIsZENwisK8aLtFw==
X-Received: by 2002:a05:6000:12c6:b0:333:3be:2d44 with SMTP id l6-20020a05600012c600b0033303be2d44mr534769wrx.45.1701421838421;
        Fri, 01 Dec 2023 01:10:38 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id q13-20020adffecd000000b0033334410d01sm157126wrs.36.2023.12.01.01.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:10:37 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	CLoehle@hyperstone.com,
	adrian.hunter@intel.com,
	jinpu.wang@ionos.com,
	hare@suse.de,
	beanhuo@micron.com,
	asuk4.q@gmail.com,
	yangyingliang@huawei.com,
	yibin.ding@unisoc.com,
	victor.shih@genesyslogic.com.tw,
	linus.walleij@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date: Fri,  1 Dec 2023 10:10:34 +0100
Message-Id: <20231201091034.936441-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RPMB was converted to a character device, it added support for
multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
to a character device").

One of the changes in this commit was transforming the variable
target_part defined in __mmc_blk_ioctl_cmd into a bitmask.

This inadvertedly regressed the validation check done in
mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().

This commit fixes that regression.

Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/mmc/core/block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..8d29687635c4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if (part_type & mask == mask) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if (part_type & mask == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
--
2.34.1
