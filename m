Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1B8615A;
	Sat, 29 Mar 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743266511; cv=none; b=Q8GRRB3kfsq2sYqs+A07V14Lt66bzva52/IbSjuemdlilJg2dA96aDEWCXbW6Ufl/aSG7Yic5FT770xfhz0L1YpXCFZwUlcd6Hc4aDgHASsS7y7ElqgY7IlrWYX9r9T3dds391XaUW+nOol1jZqQi1J55hC++R8W3sjz4carb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743266511; c=relaxed/simple;
	bh=6IgNvVv91JMQj/HO6i4kZ4m5WjShbFyHyc0FYdkdYYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQc1hPX0hy74RNhMgl2V4foOWNrai4sCSXSv2+9U0936f+HqctFVcydPVp2UMg9IlOkio2GS7UUqKjsEgmqG8ZETvQB0G95Krh7IyZwqUz8Y0nW1dvHijOapLz6Ap6A53TY9RGY/JhZFFB31Rs8jDP/c4ficDve12TDEZSCvDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBKliG4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBKliG4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E522C4CEE2;
	Sat, 29 Mar 2025 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743266510;
	bh=6IgNvVv91JMQj/HO6i4kZ4m5WjShbFyHyc0FYdkdYYo=;
	h=From:To:Cc:Subject:Date:From;
	b=iBKliG4uEN1tUK49NqSjTPC/H32WQ1NUJIksQe6AGoQK2HMNqzsYItHNfSfhaoK5Q
	 6FPyZEX8MaR/nLOy2AufU82LP01y0yETTs2Oy5i+XNBkIOYapAbQP/CV0ndWW0CxvO
	 jQe3kNORn2zDfZf8XyRPCM8U1Oq7G+yFGsSDhleDzwgWb6KkkWWTCZxQO3afUvg8fi
	 Qqt/ip+JWZpOQ4tdn/wfxwOTFGl3k8V6gy73zSwk31G9YlaJ9X7pJc4POlhn9YRLid
	 zmXzAONYDDROIULTIqc8kOLKiYAKqYIBJUQDYPmsAO+wO9e4y5Uuo7u3gfIMrMzyf7
	 lXzu1U6ooq45A==
From: Arnd Bergmann <arnd@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] mmc: renesas_sdhi: add regulator dependency
Date: Sat, 29 Mar 2025 17:41:26 +0100
Message-Id: <20250329164145.3194284-1-arnd@kernel.org>
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
a dependeny on CONFIG_REGULATOR:

ERROR: modpost: "rdev_get_drvdata" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!
ERROR: modpost: "devm_regulator_register" [drivers/mmc/host/renesas_sdhi_core.ko] undefined!

The 'select RESET_CONTROLLER' needs to either go away or get changed to a dependency
in order to avoid Kconfig dependency loops here. It also turns out the the superh
version needs neither RESET_CONTROLLER nor REGULATOR, and this works because
CONFIG_OF is not set there.

Change both to a 'depends on', but add '|| OF' for the superh case.

Fixes: fae80a99dc03 ("mmc: renesas_sdhi: Add support for RZ/G3E SoC")
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c3a9e856053b..c9e067b5ba94 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -694,8 +694,8 @@ config MMC_TMIO_CORE
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on (RESET_CONTROLLER && REGULATOR) || !OF
 	select MMC_TMIO_CORE
-	select RESET_CONTROLLER if ARCH_RENESAS
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
-- 
2.39.5

