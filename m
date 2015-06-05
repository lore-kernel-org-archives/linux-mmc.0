From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 4/8] mmc: lock: Add card lock/unlock maintenance commands
Date: Fri, 5 Jun 2015 13:42:23 -0400
Message-ID: <1433526147-25941-5-git-send-email-alcooperx@gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:6749 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbbFESBZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 14:01:25 -0400
In-Reply-To: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, pgynther@google.com
Cc: Al Cooper <alcooperx@gmail.com>

Create a sysfs interface that allows a user to manage an inserted
cards lock state. The sysfs attribute "lock" will be added to the
device's sysfs directory. The following commands are supported:
"setpw"   - Set the cards password
"clearpw" - Clear the cards password
"lock"    - Lock the card
"unlock"  - Unlock the card
"erase"   - Force erase the card, clear the password and unlock it
Commands that require a password will request the password through
the kernels KEYS subsystem.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/mmc.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f36c76f..8e94eb8 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -697,6 +697,84 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 	return err;
 }
 
+#ifdef CONFIG_MMC_LOCK
+
+ssize_t mmc_lock_show(struct device *dev, struct device_attribute *att,
+			  char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	if (!mmc_card_lockable(card))
+		return sprintf(buf, "unsupported\n");
+	else
+		return sprintf(buf, "%slocked\n", mmc_card_locked(card) ?
+			       "" : "un");
+}
+
+
+static struct lock_cmd {
+	const char *name;
+	int io_cmd;
+	int locked_required;
+	int need_pw;
+} lock_cmds[] = {
+	{ "erase", MMC_LOCK_MODE_ERASE,  true,  false },
+	{ "clrpw", MMC_LOCK_MODE_CLR_PWD, false, true },
+	{ "setpw", MMC_LOCK_MODE_SET_PWD, false, true },
+	{ "lock", MMC_LOCK_MODE_LOCK, false,  true },
+	{ "unlock", MMC_LOCK_MODE_UNLOCK, true,  true },
+};
+
+/*
+ * implement MMC password functions: force erase, set password,
+ * clear password, lock and unlock.
+ */
+ssize_t mmc_lock_store(struct device *dev, struct device_attribute *att,
+			   const char *data, size_t len)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	int res = -EINVAL;
+	int x;
+	struct mmc_password password;
+
+	mmc_claim_host(card->host);
+	if (!mmc_card_lockable(card))
+		goto out;
+	for (x = 0; x < ARRAY_SIZE(lock_cmds); x++) {
+		if (sysfs_streq(data, lock_cmds[x].name))
+			break;
+	}
+	if (x >= ARRAY_SIZE(lock_cmds))
+		goto out;
+
+	if ((lock_cmds[x].locked_required && !mmc_card_locked(card)) ||
+	    (!lock_cmds[x].locked_required && mmc_card_locked(card))) {
+		dev_warn(dev, "%s requires %slocked card\n",
+			 lock_cmds[x].name,
+			 lock_cmds[x].locked_required ? "" : "un");
+		goto out;
+	}
+	if (lock_cmds[x].need_pw) {
+		res = mmc_get_password(card, &password);
+		if (res)
+			goto out;
+	}
+	res = mmc_lock_unlock(card, &password, lock_cmds[x].io_cmd);
+out:
+	mmc_release_host(card->host);
+	if (res == 0)
+		return len;
+	else
+		return res;
+}
+
+static DEVICE_ATTR(lock, S_IWUSR | S_IRUGO,
+		   mmc_lock_show, mmc_lock_store);
+
+
+#endif /* CONFIG_MMC_LOCK */
+
+
 MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->raw_cid[1],
 	card->raw_cid[2], card->raw_cid[3]);
 MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
@@ -751,6 +829,9 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_enhanced_area_size.attr,
 	&dev_attr_raw_rpmb_size_mult.attr,
 	&dev_attr_rel_sectors.attr,
+#ifdef CONFIG_MMC_LOCK
+	&dev_attr_lock.attr,
+#endif /* CONFIG_MMC_LOCK */
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
-- 
1.9.0.138.g2de3478

