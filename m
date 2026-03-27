Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936836B04B
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774650128; cv=none; b=Ga5L6SR5LwGNDiY4WlH07MfpRyGnSkiommqyok/rAfld9Rc8CchxRMaCpKUnZaeZ0CEDcYHPBAwjlaJA1b0RhcquNyuHv77nHHDo89B5R+2x/wMZqcQ0Vxa9bNOqh609RZoMqXa350SbujKunmbnK5L2lRYfyCXUu8U2KQB1NMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774650128; c=relaxed/simple;
	bh=GS+n/zU0/oqK6fxw0OUAR55w/kR/NtZQwZqDyR34ZIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtU1qQtdfYiL+zRaeQGQBdGuykB6kT5i98N4v9VnLpoLsq6zwiL2iUbCNvlKfsz245VulUwgL6lj+r8XnmdR+Vs/6w1GcREsMh6bo4T6mk/Qs6T2+jfQofGga02gOkDrawpuG9J2qBTQovO1dTMpTkJwNNv1Xbg/9BK3snyw7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Si6FK0B7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Si6FK0B7"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id BD5CB20B6F01; Fri, 27 Mar 2026 15:22:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD5CB20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774650127;
	bh=kb6DDrTZkLFlPcOcfSK1Dh+lEI2bDad+XQjBQaC29nA=;
	h=From:To:Cc:Subject:Date:From;
	b=Si6FK0B7qG7DbagYwne5jGHL0/9sC5uOYcShPMW0MIoUjcFzG6s83M9TllyFAEsyy
	 RhRrXQSzS9imLLYrb5oPRW0TqneBv3307IuW5bYwfQU4MyWGDzetOMyIhPIbrqeWwc
	 ieO1rpfywn8ml2lARdMmXJBPlm8qjzA0N/oPJl+M=
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: rjui@broadcom.com
Cc: sbranden@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	meaganlloyd@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset callback
Date: Fri, 27 Mar 2026 15:21:49 -0700
Message-ID: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the .hw_reset callback so that the eMMC can be reset as needed
given cap-mmc-hw-reset is set in the devicetree and the functionality is
enabled on the eMMC.

Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
---

SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been repurposed
on my Broadcomm processor to be eMMC hardware reset
(SDIO*_eMMCSDXC_CTRL[12], HRESET).

Can you confirm this repurposed bit is consistent across the Broadcomm
iProc processors and thus the .hw_reset callback can be uniformly
applied in this driver?

---
 drivers/mmc/host/sdhci-iproc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 35ef5c5f51467..9018ed7fe2e66 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -181,12 +181,26 @@ static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_host *host)
 	return 200000;
 }
 
+static void sdhci_iproc_hw_reset(struct sdhci_host *host)
+{
+	u8 val = sdhci_readb(host, SDHCI_POWER_CONTROL);
+
+	/* Trigger reset and hold for at least 1us (eMMC spec requirement) */
+	sdhci_writeb(host, val | BIT(4), SDHCI_POWER_CONTROL);
+	usleep_range(2, 10);
+
+	/* Release from reset and wait for at least 200us (eMMC spec requirement) */
+	sdhci_writeb(host, val & ~BIT(4), SDHCI_POWER_CONTROL);
+	usleep_range(250, 300);
+}
+
 static const struct sdhci_ops sdhci_iproc_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_iproc_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.hw_reset = sdhci_iproc_hw_reset,
 };
 
 static const struct sdhci_ops sdhci_iproc_32only_ops = {
@@ -201,6 +215,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.hw_reset = sdhci_iproc_hw_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
@@ -283,6 +298,7 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.hw_reset = sdhci_iproc_hw_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
-- 
2.49.0

