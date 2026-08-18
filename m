Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16C47278D;
	Tue, 18 Aug 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058450; cv=none; b=hVWUQfs051o+fjNuHx8S3oXU9o6MVRMSyCjXPvEms6MKdKO11fGMlKnOllxJEtUMEdpsd06UE17QxfYsXGT3nfyUSt78O0VdF3b2IgOkSBv0+RgFi0fo0TkVZ1ter2EY7hR+0uREAzHBD/lAt98iqhFlZfNbXv6PxMKSDI7kU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058450; c=relaxed/simple;
	bh=pGRCYXGwfqpPvAVshLOX28YUxUiq3dpyodBmFoZTZVM=;
	h=Message-ID:From:Subject:To:Date; b=fRrUkOzIhRodiso7UcCx8Qj7d+CP9Sg27absAdBo2K7KDecpS657/rM6HUFI5ROgWA02esLOsnCb6cn3OYyFz0uLJ7rqVUm9GpHptbL2HE8TQpeOgpw7Gb/trHUTciQv/omKmNy4OVTTm+rJ7wzVuPm6ivSpimNobMLiRaglF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=V60lbrhI; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="V60lbrhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787058444; bh=rYpzhkzuL6ll/XpD8Q354MeqaqCNk8Kcf6Ilc+t3jFk=;
	h=From:Subject:To:Date;
	b=V60lbrhIFNWbDSLNrwDGm9sIy/dzk8cp1fOHEpeFk3jLBcIev4yLmc3W0HK40wm7A
	 cdvoCDc63hMRNHF0qXy2mG9OQKAWyGLHkXnbjC6mrtNsXrn6IK65baVsSZmi7gtk/o
	 1G/Bs3HppHQC9GkSNux/2lSXqnG1MCDwAFsI8/Ck=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058352tpqobjp2k
Message-ID: <tencent_76880DF24877C8490B50E7D7BC52A55EA105@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GSQtaFuXC5axO4dzKis4ZHeNTrO2XhYXvie6ZRxLDXsRPCQKjOC
	 LJ9GNQVu+QXk6z3NMgWZt6ExBLBDcp37gd10jbQkE18dsdHh67bU+5Pr2TpMCGKE+oaNUcFRwlSo
	 c2esPaVMphfnwuBLc02SUgrps8CfKoYeZBMmgq26hd2XOvS3pkBvA0gMxH7VYyI/PHpHUkB+oLLb
	 jUJOAOhRLSvn/SAvqxbNQF6AJmauNxqdUUikIy2mECndLbWRQfw1k52FBjuqjf76NZoarEsZYjIH
	 emESCWe0KU0zKKI9ZXJHnBCvfkc2QTULqkhwhWKmlaDcGcTEypQhlqGmibuVleTtBU/32+xPbSgb
	 eJ4Kh4PPY5bD9yIpajEIqrMCqpNO6FEiCS2UxQVwbKe8MWzPlqEG5tIyIA6NPwk/RWZ4XeuWKwRl
	 IWeOcnYvnvcaYErQihZSqxQvIgXXxJcEmVJGsPZCh0vyg9a2kn/alTjNwYHZyjg0AQ0z6yf/b4D+
	 NKLZZMyFDnIFixN6edi7WTeQ4NFnhqSABw1K2k6MbNXChQMnQofKFzJ+17TflH6XbIAU0u7aF0Xj
	 TOwcpFDzbcQvWq9OUfrefvhTXQJjip48oSvxQ0ENyu7r53pxJHXkky0oN+7kmh/SoAFKAq1MfaAO
	 tL2JpmTFqFFC1dNIhJIVhm9tO0ZrwKn03KDlVUWjszTB7KfQxe3pVfL43pZMS2M3MvtemRdwXliH
	 oHeCGl4K2OQD3I4EWMalxLs0ByyQ1WOycNoLTWD9APZWgfGV91vy4czP75qEVZZw+ID1XTM8IWgz
	 lLPOiwrGaXULSZ3YtHrC+U4xg+ezlMHr8/G9nMImvlaVEzG2HjNE29o1acB4zexwusdESBDYtTtS
	 uqe7ZOes5Px/k2ulMeyD4nAPjzPvf5xha3nRRXxKgELNh3b2PQ97bUnfMQIa1LiEzZpQ9KLqbIci
	 TbO43QkpEUNqK7SxdYVtCWn7yjOKZqwZToiYH6EmxIF3jXlTrSnWcLdGc7NQcTS+3LPPXcGjQJBO
	 Nfm7yjUOkGJ7syyYSFpHpbCN/WRbWmw0IOUVmkSY6VJsf9sxDsPXqUum7m/yZpIGx3m5j09g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] mmc: sdhci-s3c: check clk_prepare_enable return in probe
To: Adrian Hunter <adrian.hunter@intel.com>, Ben Dooks <ben-linux@fluff.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:07:22 +0400
X-OQ-MSGID: <178705844261.291840.9546612849683584216@qq.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

sdhci_s3c_probe() ignores the return value of
clk_prepare_enable(sc->clk_io). If this call fails, the clock is not
enabled, but the driver continues and later calls
clk_disable_unprepare() on it, leading to an unbalanced clock
disable/unprepare.

Fix this by checking the return value and propagating the error,
cleaning up only resources acquired before the failed enable.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -534,7 +534,11 @@
 	}
 
 	/* enable the local io clock and keep it running for the moment. */
-	clk_prepare_enable(sc->clk_io);
+	ret = clk_prepare_enable(sc->clk_io);
+	if (ret) {
+		dev_err(dev, "failed to enable io clock\n");
+		return ret;
+	}
 
 	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		char name[14];

