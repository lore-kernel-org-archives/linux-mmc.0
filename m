Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA1279336;
	Tue, 21 Apr 2026 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739387; cv=none; b=R7aCUX+o8MvbeyOOap4VSztf5FKan9Y1qPg82alaX+GjnS7i6b0PkonzU+rE95w/b4QaX/L0XF+z85Mh75b/dQML36pED9ByoQm8QjoWEFDLk6AtRiZArPHnk8hGL9hXVDmBDBWk1YrnV9tMaTQXccXQLaFcNhYQ8AZw9Fs+59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739387; c=relaxed/simple;
	bh=s4p5t5C2kx0PVoBIN+nISS6dbH5HAheLCnhdL+31H2o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hZwh7n5LErcQHUxTYX5ObLq3JriRXjG0RADzZ4UqrKzs9Z9n8frv6133fPbjEQ9Ua4hA0tYewajpLTKfpsoapEn0MwBrcEbEu+DCBz0HCLuqB291e3ZboUGk4O75CvkmmrI0LuTWd3Rs9Vair1XZKHXnNvRAmB0PiBGNlHXQ9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gPIlJfAI; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gPIlJfAI"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b7cb1a73;
	Tue, 21 Apr 2026 10:37:45 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: Switch to use pm_ptr() for bus.c
Date: Tue, 21 Apr 2026 10:37:33 +0800
Message-Id: <1776739053-120472-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9dade69ee209cckunm6372ce729a010
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGkJKVkwZTEhIHxpLQkkdTVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gPIlJfAIuSWgM1MZYB70JfGuf4plxwEIJataxl2jVK59A4yYG7wOTe+pMe5Ph0BXZUFNPs7IKoV6rg/8bm8r1lqIwxKT2XZhpHnQ45eEkHYS0nP8iPZrHxY3Iy0q+jpz/56dV7zJGwUyttmtwBHomjnLN6up4fZbJC7Lpq8L7ns=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+uPNHvqX4pbf8kAKSASKrNq4rQGV3/EB3Bt3AYTG7hY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Replace this #ifdef usage with the standard pm_ptr() helpers. This
allows the compiler to automatically optimize away the unused code
paths when CONFIG_PM_SLEEP or CONFIG_PM is not selected, resulting
in cleaner and more maintainable code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/bus.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index be5cf33..b613b20 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -160,7 +160,6 @@ static void mmc_bus_shutdown(struct device *dev)
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mmc_bus_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -192,9 +191,7 @@ static int mmc_bus_resume(struct device *dev)
 	ret = pm_generic_resume(dev);
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -210,11 +207,10 @@ static int mmc_runtime_resume(struct device *dev)
 
 	return host->bus_ops->runtime_resume(host);
 }
-#endif /* !CONFIG_PM */
 
 static const struct dev_pm_ops mmc_bus_pm_ops = {
-	SET_RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
+	RUNTIME_PM_OPS(mmc_runtime_suspend, mmc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mmc_bus_suspend, mmc_bus_resume)
 };
 
 static const struct bus_type mmc_bus_type = {
@@ -224,7 +220,7 @@ static const struct bus_type mmc_bus_type = {
 	.probe		= mmc_bus_probe,
 	.remove		= mmc_bus_remove,
 	.shutdown	= mmc_bus_shutdown,
-	.pm		= &mmc_bus_pm_ops,
+	.pm		= pm_ptr(&mmc_bus_pm_ops),
 };
 
 int mmc_register_bus(void)
-- 
2.7.4

