Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE634BA2D;
	Fri, 10 Oct 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103609; cv=none; b=dYFix9rk3SS6iNs9bW4AHnlkEx2ii0l78TqoHs4nebtC18GSaJQZ4rVqVAsnMZabb0F9/U3hiwpgOuq/DAZdXlFkSlWQfAwb8LxzS5KfUQMPYGMIynwuqOj0XJTRNgv3odacvthP/gCPXLBqgjwx7UiSLeh908pegPPoz+04FfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103609; c=relaxed/simple;
	bh=+E3kXB3wuofhIZ2ns/MGintJL8HHpgzOU8UoyCZ2Mjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lF1TTJy+jLdK5B6U6Ef5oQJmL4CYZtdzL3ytDKPKgYdVYBG+PFzuWEDZvABoxniWiwzpanzlliYLZNg5Jhh85ojQu9yoAyNYo/pkqC77GMyfO0bZtxlGaH4LCg0siTh6SqTYX8rt8ipU/XPXH3G2q7FnDlSWTDiipEv3v3pcfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl1boXQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl1boXQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638DAC4CEF1;
	Fri, 10 Oct 2025 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760103609;
	bh=+E3kXB3wuofhIZ2ns/MGintJL8HHpgzOU8UoyCZ2Mjg=;
	h=From:To:Cc:Subject:Date:From;
	b=Hl1boXQWECy6jvAt2RXGfOIgEu4NKQVW5xRz5X+vL+duVOotx8KYlcgRHyPjcPbwv
	 6v200SJr5Lah4zowuIOpEjQCurZHVPTwZn2vF5ZPtg0yXzmaPIAH0qSlJ/s/5rpYwx
	 dF1IcLt+wZburwd3LYZ2Jr0IrRmOa2aEregB+pytg2t4HnS5lqV4zaZ17XGq7iu4Aw
	 wE4E8CtSbkIitSKLUbuZBJV2rf04AJHJJtoxCxf9EEPkqZCic1g+V/ow9iI/b74cm+
	 B4ZwsqUr0Wwi4tb5NTFTF6gjBGxfuZlPcIetZuA+Jmi42XVDwViyU0Rh7p397jCx72
	 eX0Jqz6MbwPgA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v7DLr-000000003Rf-3xMJ;
	Fri, 10 Oct 2025 15:40:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH] mmc: wmt-sdmmc: fix compile test default
Date: Fri, 10 Oct 2025 15:38:56 +0200
Message-ID: <20251010133856.13167-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling compile testing should not enable every individual driver (we
have "allyesconfig" for that).

Fixes: 7cd8db0fb0b2 ("mmc: add COMPILE_TEST to multiple drivers")
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2c963cb6724b..10d0ef58ef49 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -950,7 +950,7 @@ config MMC_USHC
 config MMC_WMT
 	tristate "Wondermedia SD/MMC Host Controller support"
 	depends on ARCH_VT8500 || COMPILE_TEST
-	default y
+	default ARCH_VT8500
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Wondermedia WM8505/WM8650 based SoCs.
-- 
2.49.1

