Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="GGFpYQ25"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F710F3
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 01:56:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b4e35ecf1so17914375e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701424572; x=1702029372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=imgzYGiqQhIIN9pgZ0mud47x5443YmKclZtZpKeB2ec=;
        b=GGFpYQ25N72u8lCbtYsLxrIiSTXFWvgnp4ewKQNg1p+Z8/II5IcafVWofDjrRRr3cY
         Cr0aaKGYvro+psN8Hfw9LeUOPWPHHXTo6Hm+l8zel77Da8EobdIPPSAmDzH6qiAbhRim
         8kU2r4cNKkCIJbOd8ZfuL/0dRiDOg695Unz0s9NwVGTgOrtv1f/wHOiG9Ktl9TQwv7ma
         N1LcHn/sf1UjHuowtq7Q1Px3qbMZHOzKVHQxI7ZrfSxREuhlQxnTY2qMCPUXlL95v7Kg
         iAtWJUPplgnxCJZFJ8LcdU/kUHlIctcnPSkxNqhFjylDprJDGhWnXJBHtcx1uX/UifbC
         2iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424572; x=1702029372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imgzYGiqQhIIN9pgZ0mud47x5443YmKclZtZpKeB2ec=;
        b=VdGhrF+OtUxyQ8HVhUtsg6U44WU6+CvpUk25/9S44CZzUwqL1GhYh5bIGtHKwqi0P5
         4HbtNeiArf1BptSrcEaI+wD6CFGcyhfvdX+HEV9ROfiAFOl5gEgLeKCCAlOuR/+RDlAR
         fwdjl2yXLSR8YKHEgkQHo4AAHHIaPcoSpNx29fFt0dibi7U/VUaw9fG2/mTrfYJUNSio
         +oIgpLIUWvepa7uw4iww9x3K3vP2NjU1mYjPJ+HEnYTF41POKEmH8M4axSOUhlHt5Hhi
         ZV4bGxZEVRDcoZM+YDW5XNVhkZdChQgLMIBqi99auwZsc35tm881h3SUcu2F0LHwPC0u
         f6UA==
X-Gm-Message-State: AOJu0Yy3ohgThk8vhEnjPfpTESX03BV/KH6exShzCuilQ0DyJGoZqeDp
	OPrYRk8rMrPGHOTUQwgah+WsEQ==
X-Google-Smtp-Source: AGHT+IFnbhz99eZMpManLr6PpXpUYiNXssmncvB7WIe5Pd7fQ9Q9gc+blj35njaOP99Xp0fGTyYNEQ==
X-Received: by 2002:a05:600c:1f91:b0:40b:5433:17ef with SMTP id je17-20020a05600c1f9100b0040b543317efmr196223wmb.30.1701424572074;
        Fri, 01 Dec 2023 01:56:12 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id h7-20020adf9cc7000000b0032d8eecf901sm3802982wre.3.2023.12.01.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:56:11 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org
Cc: adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date: Fri,  1 Dec 2023 10:56:08 +0100
Message-Id: <20231201095608.1022191-1-jorge@foundries.io>
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
 drivers/mmc/core/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..13093d26bf81 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
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
+	if ((part_type & mask) == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
@@ -3143,4 +3145,3 @@ module_exit(mmc_blk_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
--
2.34.1
