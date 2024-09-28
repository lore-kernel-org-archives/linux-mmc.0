Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140B13E40F;
	Sat, 28 Sep 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540473; cv=none; b=OcdBEkoYzDCTRo6V/kw/c2MlVEHxrwhQjuY8nb03Pt4PR3vyHelDB8zVHMvLASGe6VulzytvLpMCCKloXO+JPAk2CXscU1SJaeLMogEvsLCCd/xqT2M54DTbN49ss7cMAjFKqQ1zgs0BZt312vbMYwDxjQv2r4fivcy/QeFwdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540473; c=relaxed/simple;
	bh=HeDTPRstMRbJUF0VYtbVmMGCe9XPyQsWIuIWJu5p48c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dq/R+ekEM7wC5w0x3bO/4Flbpi21WRgUD6vQFt+WizErNKXNTwmR1oAsX/ffdSUleG9iiZ0HfgDsyrGw7cj7P7P7hwi5xSW2HDxRyAyEqW16oVCHOf++JSB2nTp+59K190IV7jn0SIfBJs0NcxAWrL54Z0NKmkP+PT9yorThLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ScZq+jgE; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ScZq+jgE"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id uaBpsnxpYx1imuaBpsyoC6; Sat, 28 Sep 2024 18:21:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727540461;
	bh=q4g3CAAXG7+9scRECwbKlds18eqRTGeqcQDCJmApgMw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ScZq+jgE7obHCAxUC3fYRkWao467elQvpX2SINVFMhq7TfyArNEXmx/GbqBw2FtYn
	 asgtVViivvRDESi8qa1PL/PxLpyjygPvtcZDABPQVwzCcAq+X2vtPw2QKtWA+5CC51
	 mPp9HFM/n40CGWxTOPdA9VNRglU6zSIFHS1VDyufJbMnePzpkKWUA91o01j6IkdVv/
	 Zq5rPrtBJOFFIWjZ0G7/rf+VzX5LeETZRzo680caMVdRBfK1vHJtEYS2EVZ/nxCecu
	 bow8LVDwS5Fp9J2NcY6g31anKzb7x97akhD3L5Fx1tjqYboCSJXNkrr+seL1zpSkhS
	 Kwg5cTX9wNKBg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 28 Sep 2024 18:21:01 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] memstick: Constify struct memstick_device_id
Date: Sat, 28 Sep 2024 18:20:56 +0200
Message-ID: <6509d6f6ed64193f04e747a98ccea7492c976ca8.1727540434.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct memstick_device_id' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increases overall security.

Update memstick_dev_match(), memstick_bus_match() and struct
memstick_driver accordingly.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  74055	   3455	     88	  77598	  12f1e	drivers/memstick/core/ms_block.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  74087	   3423	     88	  77598	  12f1e	drivers/memstick/core/ms_block.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/memstick/core/memstick.c    | 4 ++--
 drivers/memstick/core/ms_block.c    | 2 +-
 drivers/memstick/core/mspro_block.c | 2 +-
 include/linux/memstick.h            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 9a3a784054cc..ae4e8b8e6eb7 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -26,7 +26,7 @@ static DEFINE_IDR(memstick_host_idr);
 static DEFINE_SPINLOCK(memstick_host_lock);
 
 static int memstick_dev_match(struct memstick_dev *card,
-			      struct memstick_device_id *id)
+			      const struct memstick_device_id *id)
 {
 	if (id->match_flags & MEMSTICK_MATCH_ALL) {
 		if ((id->type == card->id.type)
@@ -44,7 +44,7 @@ static int memstick_bus_match(struct device *dev, const struct device_driver *dr
 						 dev);
 	const struct memstick_driver *ms_drv = container_of_const(drv, struct memstick_driver,
 								  driver);
-	struct memstick_device_id *ids = ms_drv->id_table;
+	const struct memstick_device_id *ids = ms_drv->id_table;
 
 	if (ids) {
 		while (ids->match_flags) {
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 47a314a4eb6f..c572f870fcf1 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2279,7 +2279,7 @@ static int msb_resume(struct memstick_dev *card)
 
 #endif /* CONFIG_PM */
 
-static struct memstick_device_id msb_id_tbl[] = {
+static const struct memstick_device_id msb_id_tbl[] = {
 	{MEMSTICK_MATCH_ALL, MEMSTICK_TYPE_LEGACY, MEMSTICK_CATEGORY_STORAGE,
 	 MEMSTICK_CLASS_FLASH},
 
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 49accfdc89d6..13b317c56069 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1349,7 +1349,7 @@ static int mspro_block_resume(struct memstick_dev *card)
 
 #endif /* CONFIG_PM */
 
-static struct memstick_device_id mspro_block_id_tbl[] = {
+static const struct memstick_device_id mspro_block_id_tbl[] = {
 	{MEMSTICK_MATCH_ALL, MEMSTICK_TYPE_PRO, MEMSTICK_CATEGORY_STORAGE_DUO,
 	 MEMSTICK_CLASS_DUO},
 	{}
diff --git a/include/linux/memstick.h b/include/linux/memstick.h
index ebf73d4ee969..107bdcbedf79 100644
--- a/include/linux/memstick.h
+++ b/include/linux/memstick.h
@@ -293,7 +293,7 @@ struct memstick_host {
 };
 
 struct memstick_driver {
-	struct memstick_device_id *id_table;
+	const struct memstick_device_id *id_table;
 	int                       (*probe)(struct memstick_dev *card);
 	void                      (*remove)(struct memstick_dev *card);
 	int                       (*suspend)(struct memstick_dev *card,
-- 
2.46.2

