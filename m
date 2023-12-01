Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="mV+fZd7+"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4DBD
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 02:05:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bce40bc4aso2133364e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 02:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701425131; x=1702029931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuneSa6QbCM1xtUYW7Y3DXlGntPa6QFO347mlxKnDHE=;
        b=mV+fZd7+zK2uX+BR4m4jbMbpjEIac7cKxeMSkaQIQAmPXyxw+3ynzdSHX5nBFO/gnO
         v7L4Mx87wyeO/694fz3kjTPokAzq6zl5Cd1VBqR0razRUH3kvDh2+DF9b+8410VUJDXS
         9GcD+KMWZXAdOWQOkvKfZLFAUa+rCN3qdxiryKa72Xx4BtwkOpMguPgR98ICwPhhjgTc
         yUbjCvg08iZkDoAS9kaAIiPSNLMDriAuSyJb0lCjUEfFoTcNMVj2J0xnUmMp2G8DR/ZF
         hrA26VgsuzKFCZGuYPcgBIwwrb6DgRy1NUUY72RKc4PVfLYmigDl1boNzQtw1cmyQTUd
         0CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425131; x=1702029931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuneSa6QbCM1xtUYW7Y3DXlGntPa6QFO347mlxKnDHE=;
        b=NNXsra01tEi6SqL9h3IDDBhNvqJhZT3QdUeXizBsPriCKeZzMuIhVXZNGC9JH0hmnO
         XHH7o1RKyJATamukC97MksK2YcaOAhg3/c9hopbYZVRl2RPBvQftE5tMyLnJTQQztQUR
         2oWmEqMrmthspwaY9d1c8cESGhF/IMiowoM1zt6pBq7INVYF/T26p1DBbNm6XVx3cyEE
         J3SYmwgbVaGyNNunfYcQm3mW+lR56ETjr4UseoQk2tR5Py9SiHJMdmSFMd3we1A5Isf5
         x8XZNzzzWS2KOr9lkmQlwwVDpxHVtQ/oGDjBN2bLm4vBRt2pvatTIhfSrr5uO2qcVksY
         008w==
X-Gm-Message-State: AOJu0YyPrhoEGZPJuK0cnmIju1Hz5CVoK2LXeESCFb+73cCmLel2XYko
	Y0qO+ojyh6SgPSzOwjO2tL8Iig==
X-Google-Smtp-Source: AGHT+IH0TZ6Fc+ufC5XzTglSQ2dJ28+duooe+E9bpakim9bcU2KfLk/n/0AW7+kUcOs3PCtFnOcHUA==
X-Received: by 2002:ac2:5967:0:b0:50b:d764:8023 with SMTP id h7-20020ac25967000000b0050bd7648023mr539062lfp.86.1701425130583;
        Fri, 01 Dec 2023 02:05:30 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b00406408dc788sm8519199wmo.44.2023.12.01.02.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:05:30 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date: Fri,  1 Dec 2023 11:05:27 +0100
Message-Id: <20231201100527.1034292-1-jorge@foundries.io>
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
Cc: <stable@vger.kernel.org> # v6.0+
---

  v2:
     fixes parenthesis around condition
  v3:
     adds stable to commit header

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
