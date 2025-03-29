Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B259188938;
	Sat, 29 Mar 2025 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743236489; cv=none; b=sG0tXa9ddVa7IL8tyiGU7zCHM9/VGnELMf8zjHAZpDex5xvUiCkN93VsqXjOOLKvV5Lqc/1olAm9yEZ2IuxR5XxfLvsK5j4C5dDfiZKgJ9A/CzgyhrW3mf30Uv3AchW1aCHew6cLQ8yJpvV8WVVzz3JsjWIZhPT0dsLRF1rZoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743236489; c=relaxed/simple;
	bh=RDng1iC7yEBwccXwe6X3ReRjKhh5M2mkpnVRCHzVEVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suvH/oO9QxuRSIkJB/fStSOFLJUWo0ldb/60tvB76fYz4KpKbXYGhwBX5PTdJBPQA2NPjl9wVL8wlu/ScqnFjpBQneA2vfZouHDdS98H9RaOlRjJ3tWhr0kZhZm+ojctV4G/SJr7/lb++yoIbeW8SBUdB8zpBSB1dG/KrhAEkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugOdIkXd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugOdIkXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE999C4CEE2;
	Sat, 29 Mar 2025 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743236488;
	bh=RDng1iC7yEBwccXwe6X3ReRjKhh5M2mkpnVRCHzVEVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ugOdIkXdli9YEmXGD6v14NPkkigM4FbVuLZK9T8U01dQQN72KRBAnug885XBg5yf7
	 7H5z2d7TmkD0TZ6nCIxhYV7lPEjRUK+qYg2hZoHq/VxBCmgD6KUxeYuxbEKcsadWde
	 4hXI/n7ixGxWJc6Ma/rJOxuOQrFiEHNb9gnn1ePhDGvMvtENcNeT6vkpczuKYVwLDf
	 nvZL9MQFfEEt8lNc5+vRxxHet5i8zscJMKduDYrrQPV6crL7Y3SU1ua1ZX/IcsIx6x
	 ab2026Qku1lDwRifGHomEHFXT6Ka463JdyP/rDA5vH7bGgq4hwiwBfT3HWjWasWE/g
	 Bk6VkIHSuCBFA==
From: Arnd Bergmann <arnd@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: renesas_sdhi: add regulator dependency
Date: Sat, 29 Mar 2025 09:20:52 +0100
Message-Id: <20250329082123.2325267-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver started using the regulator subsystem and fails to build without
that now:

ERROR: modpost: "rdev_get_drvdata" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!
ERROR: modpost: "devm_regulator_register" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!

Add a Kconfig dependency for this.

The 'select RESET_CONTROLLER' needs to either go away or get changed to a dependency
in order to avoid Kconfig dependency loops here. The 'select' is otherwise used by
drivers that register a reset controller, but normally not by those that just use one.

Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d7c90a9630e9..c0f03367d765 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -692,9 +692,9 @@ config MMC_TMIO_CORE
 
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
-	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on SUPERH || (ARCH_RENESAS && RESET_CONTROLLER) || COMPILE_TEST
+	depends on REGULATOR
 	select MMC_TMIO_CORE
-	select RESET_CONTROLLER if ARCH_RENESAS
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
-- 
2.39.5

