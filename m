Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113302E7F0A
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854150; cv=none; b=GWIHxGAb/9qAc1GPxJR0A4cXTV5ZTYHMKUH0QgoJ8mznaHPFj77ZxjRkBGQjWApixwSsKUfrbO9mCg8sOfwopCjjf8vIH+Cg3h+J4VspcUv38i3TflKq0gbv8CraysAS3eK74DUwU3910Q6CsFSbBacYHQ+KvA0nQclx2RrSjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854150; c=relaxed/simple;
	bh=jNPXFguZ0o33eieY8lz73vZNTUwXVK/ZZse4W5W/FWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tde95MDl3Uyvir0+dH303LbS6mC36BeKxysv0JMk/42nOkKqZYZznIOgNDcHEJYWh2GZc2vnBrIXpLNZ+5K4RvFpq4TN4RtYd3KM0mxOIkL/Jg2aWF9bdRfzDwauttPwWH+kBdikFJ+JBLubGd7X4qOdvG7Fq2F5vVVLQX3lG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV3YpeQe; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV3YpeQe"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso7486516a91.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759854148; x=1760458948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PpoHs7x3DMAGLg3gdog2cHx5D9ViCBx9xQddbSTGLHY=;
        b=PV3YpeQeTFIl2wsKaDZByDBNmRKdoqol6WSHRz6SdDnrLV4MyaXQvyQiByFh0spgCS
         +ScbZJhGvjgjQ9cVpBBh+gmTD4xoEqR6JojPfsJ45t8KRytjwqcATnSuyxCB58AxBxF7
         nvsuGq9x6WSIp2ogFhLc6GS6/DOeEvshGMEGZx0FOrHYyMsb3666X3GCb2vlUwKoJJ1R
         2bmlNDQrsW6x9b8rzXD7TEezTFZL+ZVHu0wbp6bFunpDkxaD11ldpB1y8tpumpak4/Rp
         IdGzOzk4+GDtwcKGwVBcKaQ6Fyvj/jqz/q3HHBUQAwSla9MWZYAMEdoFlVU1TUwFBpL2
         d25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854148; x=1760458948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpoHs7x3DMAGLg3gdog2cHx5D9ViCBx9xQddbSTGLHY=;
        b=oAGrmeHdolhLPR3AQIFwjBoYwHyg3ryNqSHgsOfG7Jk8kyZz/IkCKsd8fmuLzp2Js/
         2ZyqCmxEjgRLb5/dqJMD0ln2bInglblzPwNBiOble2dSxSJDNXCBh5p0+zSx3ShS/yI3
         7jr42efi2q8caxVkmbmwZvxK+7bszTQvcKjnJ2WUyf36q7IYTIADQ+OPYDMaHiIviLis
         uGQXQ2xbTMJC9g3fcbhbedO4IIpgSrfeXi3eGHCpeFw+D1QrT8oXksDoVtYxWPN6FOjX
         FlDm6w4WVdWKWwBMNLhQd/hlEuXc0fp0XB2ETIZV/KC4Juwrmc4CPAqSkITytMRgiJnu
         4yxA==
X-Forwarded-Encrypted: i=1; AJvYcCVjKUvDA3umOKN5QrIj9ziRsn2rW+jOTVqC2EnWWCTIZ8KHnrCA/WF7iOcP//1kq1qftjx4Nu+vnZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7JNCXACmigoVuqlWQcII3Wa/IucW04wjof/qXimX1CPQ8cEn
	9+C1M964TgFUSY4nzgyKv6mpIh6Hr4WflZUlKNXsXResSyWvAGqoqCr7
X-Gm-Gg: ASbGncu8Hr/itP3jx7N5n5/Kgd0VLrBJeQMzEjQzNRTh4JNYWh7XQ03SapdffBjUVqf
	ZBcK8Ko/rnVSgX+2iIxFVRiLgDgeJUVu6xW0bWy/6PzKAONpFAw1zBfbi4KBUtivH05kqSaCyfO
	uIS7mIUCpwfH9/SnKiws6kO75PE744TJNl2DXet8YSEkcqWT09a13ntwHjj9Ktz8d+xjyJEMSdp
	Z1kwpkXNPvYd02FL6o5T02My7syqs5q/tkn8Z0VM96IVnHrgm4gOC0N1F0cA4wstCfxpla9grmI
	VyIwSpeKwSJtEZjG5q/csmSUCSVTC+h2txWJBtXdxlCr6VdjIGqVRMe845ODZ/q7szKBoO8+N51
	sJw1Sdh4AC/gucxB6s0yoOjWyVD6LA4sn7vGNDcjJMBFrqJbU/xzdlqmcUODUv0A=
X-Google-Smtp-Source: AGHT+IEVmC+M/InRT3VdaLJRW/KctK/jw/7e7suEc5r/fdcvZSXq5B54eCtA1zk17y2IKaq6ovlUJw==
X-Received: by 2002:a17:90b:1e0c:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-33b513ebbedmr59703a91.34.1759854147989;
        Tue, 07 Oct 2025 09:22:27 -0700 (PDT)
Received: from rakuram-MSI.. ([2405:201:d027:f04e:d2f9:a2da:e7d:3e96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee0f830fsm1431733a91.5.2025.10.07.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:22:27 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: ulf.hansson@linaro.org
Cc: zhoubinbin@loongson.cn,
	u.kleine-koenig@baylibre.com,
	chenhuacai@kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rakuram.e96@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in pxamci_probe()
Date: Tue,  7 Oct 2025 21:47:44 +0530
Message-ID: <20251007161948.12442-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported:
drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'

Case 1:
When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
This mistakenly returns 0 instead of the real error code.

Case 2:
When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the similar
issue like case 1. 

Store the error code before nullifying the pointers in both the cases.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---

Build and Analysis:
This patch was compiled against the configuration file reported by
0day CI in the above link (config: s390-randconfig-r071-20251004) using
`s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`. 

Static analysis was performed with Smatch to ensure the reported warning 
no longer reproduces after applying this fix.

Command used for verification:
  ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
  ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c

 drivers/mmc/host/pxamci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..4fab693d3b32 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(host->clk)) {
+		ret = PTR_ERR(host->clk);
 		host->clk = NULL;
-		return PTR_ERR(host->clk);
+		return ret;
 	}
 
 	host->clkrate = clk_get_rate(host->clk);
@@ -705,8 +706,9 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->dma_chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(host->dma_chan_rx)) {
+		ret = PTR_ERR(host->dma_chan_rx);
 		host->dma_chan_rx = NULL;
-		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
+		return dev_err_probe(dev, ret,
 				     "unable to request rx dma channel\n");
 	}
 
-- 
2.48.1

