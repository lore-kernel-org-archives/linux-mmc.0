Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703240;
	b=OwKeklIAZVr/f5zVuguj6BFK1/DpZyfj9vEuBuKdd1T8YoN7ai0iD+BdSEZGwe6GBoKy
	 eI8Q2xwAC6p5mrbk/rSOwJqj8xX37eIFTbR+QNaxK3Te9rzlFQFPlSZ3py306brEgE5Pp
	 zgJyrl9+G9gJ17jSHKVMCEcbUVVFXl8sw9TUUgQ9n1pD/BWB/gsFyXhMibS7oZFddvd1F
	 agCg8hGUiAhN0uFYK9BwNTdP0o6RviuGsRqe3TToUpLsJliZFmWypt6SfOVxGebf3RSUS
	 c5s6ma8ynP/snJWl6MILJP/NK2nGApjlQmAUcrEDJKHq6c54ClXA6GgIt15aOo2OVMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703240;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=zH4d+s9FfvQlDDz9Hkbyu1/1z0SBoGSgebRCUsfwcdA=;
	b=mY/UyNKa0h+upEBUvXpYAzBny82epUUosPQsYh8D1Lf8qR9u+IUq86Hu4g87FQlbMxBL
	 I4jyft8qmRbZ1iHmT4zlM6+lcMKFYkGnUxUQsuixtqTUCx4j683t7aO7mnm4zyOIywsdw
	 tTPp/19vqXojT6RC/PRfbk5OHpqcTiaFPbe4PtB7SHTZAJuEgwbpOQU5tbitX8b/Bx0ey
	 V0a1Qx//4ywEkKPDIi1+yHTkNcsj/LD5ZpFIVpVUEnraxMQqoMOwC6swUXuZKMQE1KW4W
	 xRGl+W0gCbyLV8pGIPnETiq9fQU0CUCBVq8MYEqLfy26K5HDcIyjryzCtKt1ZUFxquQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA526082BDA;
	Tue,  3 Nov 2026 10:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA526082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJlmy22rDz57HS9;
	Tue, 03 Nov 2026 18:53:54 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A3ArgTu052508;
	Tue, 3 Nov 2026 18:53:42 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 18:53:44 +0800 (CST)
X-Zmail-TransId: 2afa6ae9bd38a27-b218c
X-Mailer: Zmail v1.0
Message-ID: <20261103185344752TLpWp9rb9fhJW6zaJT5TX@zte.com.cn>
Date: Tue, 3 Nov 2026 18:53:44 +0800 (CST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ulfh@kernel.org>, <linux-mmc@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbWM6IGJsb2NrOiBjaGVjayBtbWNfYmxrX2dldCgpIGluIHRoZSBzeXNmcyBjYWxsYmFja3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3ArgTu052508
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Nov 2026 18:53:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE9BD42.000/4jJlmy22rDz57HS9

power_ro_lock_show(), power_ro_lock_store(), force_ro_show() and
force_ro_store() dereference the result of mmc_blk_get() without checking
it.  mmc_blk_get() uses kref_get_unless_zero() and returns NULL once
mmc_blk_kref_release() has run; an already open sysfs attribute can still
invoke these callbacks after del_gendisk(), for example.

Other entry points in this file (mmc_blk_ioctl(),
mmc_blk_alternative_gpt_sector()) already handle a NULL return.  Do the
same here.

Fixes: add710eaa886 ("mmc: boot partition ro lock support")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a02bb2fee874..a1e942435575 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -235,9 +235,14 @@ static ssize_t power_ro_lock_show(struct device *dev,
 {
 	int ret;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
-	struct mmc_card *card = md->queue.card;
+	struct mmc_card *card;
 	int locked = 0;
 
+	if (!md)
+		return -EINVAL;
+
+	card = md->queue.card;
+
 	if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PERM_WP_EN)
 		locked = 2;
 	else if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
@@ -266,6 +271,9 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		return count;
 
 	md = mmc_blk_get(dev_to_disk(dev));
+	if (!md)
+		return -EINVAL;
+
 	mq = &md->queue;
 
 	/* Dispatch locking to the block layer */
@@ -305,6 +313,9 @@ static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
 	int ret;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 
+	if (!md)
+		return -EINVAL;
+
 	ret = sysfs_emit(buf, "%d\n",
 			 get_disk_ro(dev_to_disk(dev)) ^
 			 md->read_only);
@@ -319,6 +330,9 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
 	unsigned long set;
 
+	if (!md)
+		return -EINVAL;
+
 	if (kstrtoul(buf, 0, &set)) {
 		ret = -EINVAL;
 		goto out;
