Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528133F166D
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102048; cv=none; b=MZ4R/M68QH3h/jRe5fqgDUNQ8r2LO03dKFVct1O65gxiJGlXNpcy6lstnmzrv35Pk2ozlYElD1bgjTMo/cSp321BQMJiAUhWmZ3miBmP4QxkxpTs4rgq8WzUkWDPMv3crb+T05yyrVfcFT1gnfQJkC0zQSvkYuPe9HWHCu/pYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102048; c=relaxed/simple;
	bh=G483c+51U6n63u5210Hj/pYjb7P49iX7YPbToR4/NTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIUI+gv2Z8SCE0tryOuxHPUZ19lSPZz9KVO8SBG/iQyx+T6+MlG8V77h7upsYrijsqG4a/12u7m3I5Fmayl4ULA/BlXG2fdlcuL6Hm/I5g4YlS6sgFBZlrvIydpb1aeAW2ylxrKYm2N1DN3yYccWY/iL9H9508r5DKDvoqr1HPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDUFOOGI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDUFOOGI"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so21582381fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779102040; x=1779706840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNHvnYVwQWG83OUGk07u2/NdxY7MGsqd0rP+g+OVY8Q=;
        b=TDUFOOGIcFMxjirlh6HZ665CbizXjT9nRzumFkkqqcNfA2o/d8v0k8zcIp55Fx9/BG
         i05rJSrEmp0MW22PTU6Jtr52LmsszArx6/e7iJxEILS3Vxpf5eRZa6UGj7KWmBhaK1vG
         fr8IzLA0mQbPe3kzC6gbyqbb3lUyQGgX0v3/Cr3nmO28TQfrXed6FRtB8uE/6Th+RlW7
         F0Too8ZVBNa8v9V3I5QKDb4GXuhmfoyU/rBLd8iedizFUsN5HFI/AWW4ls1VWWFmxm8D
         lNCoY4GMrZIWhUJoJLSAn8q5GWNvD5Uqx8ERl7k85QhJis8xZZ0VoPUiYqn60+FwVBm5
         OQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102040; x=1779706840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNHvnYVwQWG83OUGk07u2/NdxY7MGsqd0rP+g+OVY8Q=;
        b=C079FpSvHaLSRgWAwqvL1nMePOFiK0UwoCbwD6x3hrVCkuYWDcsY4bdYNSiTbmWsYj
         lsrx37DXRnXg/B0GGZ8AzUzC6Rq0/38k0UzW8WTEkWi/X8NxGnJ/UXA+CmUnOUYZqeem
         US9w1E0cQlWqOz6IMH2lh7DBPqS2zf/P4brInxMHOfGJGmSGz9mB4yZwQ1kheBuU/Jia
         RJReSJHhXcnJy+Kt6Je+fNhfPJEM5pbnBqMn68485gyUWkh/pliIkyWHYlffOxkNe+0T
         KuGRtRF7ev1e47RAbbvTDQoNQx49q+V9DJvDGiK95loW3PyBh+mkNZ9uvDAGbCVNP0Ve
         ds6w==
X-Forwarded-Encrypted: i=1; AFNElJ/JJh2V53EuaqLS5sYYRowj03duGxuWhpkhAnuOennbBCZn2D4V9TH3YGMaa6GcWx6TkrQfzGc0K4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZI7G1JGFwjrXh8L1W71th1+XOunKmj/FC1IzfW447QIwiuhu/
	cg6mZFIXMQtv6uBS0vw1pcoqpNbwXq8Nd0q1HUbuJC+Q02vpghzg/4Yr
X-Gm-Gg: Acq92OFFa7+Dpd37moOVUdG+IFb0LbQ3x84DIqi/86n5zm4sZ07xUJY3uXQUcU0//lN
	t1QpEE/4s4XIdeK6eaBdXzNGX0FR9VCBks1wOPg8y+vstlouc6JyN5iWMW3GDkJkqEzZGjYko70
	tK+1udn5ZQ/OaGS1qN82i4JGWVhdfIjlCOPtGxVI/VDagJ+wPO17uZptP42a2ulOulNwxt4zQ/4
	CtrA1aeZziFlSUr5akEJP76OdL0hvVi+7Mfw1EhvV8K1/5x+UygeF5r8cVILD809aemai4QxhQq
	nx3HYYe090t6BEn/HM82yuOZ7wutDZolh39gECikjv7vH93ltd23UFj6ofjvru9R+NNSqA6eviO
	JpVlnVB9JDVxkWecTs2Zd82xJhmoqI5Kqbw7Qtj4Nu+TrCnDlXkVfT3Ensb/jFVd5ARjIURuLLz
	s/X/qa6Pp9j0rM930C/aySwGoD
X-Received: by 2002:a05:6512:401e:b0:5aa:b6a:6027 with SMTP id 2adb3069b0e04-5aa0e75300dmr4211392e87.44.1779102039455;
        Mon, 18 May 2026 04:00:39 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.222])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc462sm3239263e87.45.2026.05.18.04.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:00:38 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: sdhci-of-dwcmshc: Minor cleanups
Date: Mon, 18 May 2026 14:00:30 +0300
Message-ID: <20260518110034.142587-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series introduces three non-functional cleanups for the Synopsys
DWC MSHC driver.

Patch 1 replaces udelay(1) with fsleep(1) in Rockchip-specific paths,
following the kernel documentation recommendation for delays in
non-atomic contexts.

Patch 2 removes redundant IS_ERR() checks for bus_clk in suspend/resume
paths where the called functions already have internal protection.

Patch 3 converts error handling in probe paths to use dev_err_probe()
macro for more compact code and better deferred probe debugging.
--
Best regards,
Artem

Artem Shimko (3):
  mmc: sdhci-of-dwcmshc: improve delay handling with fsleep()
  mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
  mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths

 drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

-- 
2.43.0

