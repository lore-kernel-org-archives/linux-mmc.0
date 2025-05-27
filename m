Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E5D530
	for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325309; cv=none; b=lMqjcLCzihvnvIPOKHBUKk6oFAoYpFAnvQadW1uWI4RhRSI1ZCHNyZ8iwDLGsa9XqFK1glR6Gsy8l6fmPKyKQzYiADeQI6csjk5WXzIw3trYqGOorqbENODbYSjObiFLDSJPhN11EqxZBYlkRwtb9G0g84AazAU+yc9WHWFxCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325309; c=relaxed/simple;
	bh=kp2Ho/gN90qoPt7EOupJs6drcisxOPFdqCVoJAm4AUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tMRu2YZi2CcXbRchoHxsS5q0Yvw/YUalsY6Vo6oirclKVCavMiC+jglqTszjmzmsFMCBiYmoUNDbd+cVHYOeXIQB4kt1Lzeisg0QXkkppsJSRlg5f16lyyLfFCxFFgYfxMFhFV8Xk+0NVhb5h7eT6MYzl9dko/22H33KFxUdz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqBvIRK6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqBvIRK6"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso5705093a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748325305; x=1748930105; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/92qQ8/8bI1foaF/B/6o65zGGONk9qpEUFF2woz+1A=;
        b=oqBvIRK6POmfT6Lpcsd6rtLAadL4/sk/ZvLuE/DlnDsmWoT8GJGKs1AbGOToP/560N
         q+wok/6j9NUxz7tdV/UKvySUjjXgURCOkEx5cGyuQPScB49rvwfi9A1EG2dhZRNw1ANw
         v3OXvegVtDbJ12mJW0exwPsJ0hLnEzjBwKezoN8XOmMQ2Ja6HGfhHUCwiD6OHFvaJ/DA
         iAdv6DwNssGp0yZ/yr+Z0JtY8pQnHDTag20uURulIUtuvRKnIG2K8HT7mexi/jj4SEGk
         bm7Atk3CzfGgQHmKECGcYoBO5ShbMjzHwur97nY2EVw/dCl0VXjEOJ4OF3ujguvlKPd0
         O0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325305; x=1748930105;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/92qQ8/8bI1foaF/B/6o65zGGONk9qpEUFF2woz+1A=;
        b=iGEGDEmX9wn/UsqqLJzvWuhXu7aIxLcEh0yeX61PG+MFEpQVckiup3ZrObIqyR1UFR
         gcDgtJvH6bghVMtVeMpzboBtjJ3YKuRpWJM9WRXkp772qf6pmwyuhvlr6q5WlXvZAuKn
         c4osz+t3V7+/JJDkHW8iCm6TDACSlkGc9tdU8c5OQh7birTH4QXOyOixRPv14XmWlvPX
         aKhqPeuXX66nrEHnmaTiU2Z3eUdcDM3V4fF40O9SNBJ/ubDhHnx2N8tPFaWNps++qSTC
         Ff90U5reJtwX1MdR9dG7GR8igsNZUzwhK3mqvJoAmEuD9hcDv9vlFdEt6hgAoqcWZKdB
         /MyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlkAbGyxKMGW+UaT2Ym+8CEJTLfxDd8smui8NdNXVHotP03G8OMixjogBW6k/UgzoaoBdAFWgOqSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0t29C0XZOvwluH4D5zRy6r5zfEiPHFPCQHQAnMMk/BWG5Yfdq
	AL1aXZO3qDtJnUl62mJcsZp8jtQnFKUPWv1PKzVczEIaK9LMJgwLOer6jSi98EIDeIw=
X-Gm-Gg: ASbGncuHHdKgnTQdyggAtU+SE0jNRuomePv99Jx5As2hLhrYh8lXnjQgDEORbzD/7CG
	7JSOCMDQn1/RuVETBjwQEFK7//FvTAZOnDEKSgXQpi78VsDX53RwvsXwSA07VfC+ZuBOfO4JHIp
	hTIyJ/9fYa5EwApJpKwwX/3I1ZqHjxYFiY2uvW6m6jhT5RFRlnU+QiQYMDQRp28OKUOaw6AWEhQ
	UgGEBVOOAqhzejwsisU5dlsWJtirpp7dgpsSHLuJKVhynY+u7yszA+GB+WpXTpHe0SC0v5J2n7P
	0T2vCIa7mzgKAzrWKA/9XE2R0jbucbEaOnY+ZWxmuG6/fPOHDwRKgOjS4H2+xp+v2cuwvN5t6os
	=
X-Google-Smtp-Source: AGHT+IEv5s7xDmY7xLIqn57Glb7AygAOacFI1nEFLy11fNwi+mIgMvJcQA8W8aLW+zQYLW7VY4hQDA==
X-Received: by 2002:a05:6402:2713:b0:602:1832:c187 with SMTP id 4fb4d7f45d1cf-602d8f5d5camr8978474a12.4.1748325305573;
        Mon, 26 May 2025 22:55:05 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60464875b8csm3393023a12.76.2025.05.26.22.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:55:05 -0700 (PDT)
Date: Tue, 27 May 2025 08:55:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: sdhci-of-k1: Fix error code in probe()
Message-ID: <aDVTtQdXVtRhxOrb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If spacemit_sdhci_get_clocks() fails, then propagate the error code.
Don't return success.

Fixes: e5502d15b0f3 ("mmc: sdhci-of-k1: add support for SpacemiT K1 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 6880d3e9ab62..2e5da7c5834c 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -276,7 +276,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
-	if (spacemit_sdhci_get_clocks(dev, pltfm_host))
+	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
+	if (ret)
 		goto err_pltfm;
 
 	ret = sdhci_add_host(host);
-- 
2.47.2

