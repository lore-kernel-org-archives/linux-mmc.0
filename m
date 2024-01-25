Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1C28E3C
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193430; cv=none; b=NJR6qsCFiRFP40AkM/MZngbKie39myUF69lTg94B+bcIyMK0XdVu7+P0zqlmJYG0GiXmBXst4x7q1beNIRDIEpIg70pbf/ybu8EPFfjy9MHlX986HgZ6avNL7dkieoW7uwztKVKo+gEQ4eDTzX1sB8F2R3FfJ1+1oHmy6FvDnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193430; c=relaxed/simple;
	bh=LdyXJuXes8r86g/h3o9TyzHM58o0lFRK+kpKZZFj2A8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qaJauLj1UPwWygiB2q6QHiR+K5uBiQ5k+cyqDD4eRcIkDSe5ODiDJGKc6TpF3pepqssoqcPhA7jHsRC93sjeE86MdOsn2jPovhyiVAstSmaeYE5RKcAqc5HFPe44CXOsLQujvsR1t2YnMTQwRyQPzrmvzu9XfOM2JbsdOd6M/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzZeuRao; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzZeuRao"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51022133a84so133552e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193426; x=1706798226; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PY0FJRxd/qeRrb4ukxj5gGPXGnLGCFI9vbya5ZkPcOk=;
        b=mzZeuRaofCJtviZmvRuvgcdjdPUHFT6VMDteH7wHcWOlBc/rqW3NF4HgveTY4xGg4G
         4iHmi1dtafdJQrpAxq3HEiQHD6jD+y2t658LpXMnbyYQoL5iRzcrjzuo6A7QelGknc1k
         TF/DP5YcjEz9Kci4LsGYqeR+LbmB7UQz8RnAEkWLYP7FwCm5tVLS7NdmJF3FBhSvpEyh
         FVoUgShEcpJB9VMhMWt9lrvpbzdPFTPaBGRqOdgc7DQj24/UWlJ1VtQi5luYjM6k9UBx
         RehxTWour1+OVBdbPf2D3kx9+DwV12BdJ1EheDX/9S44BQ1UPF6EV/1jSzU8/6OkqQKP
         y8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193426; x=1706798226;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY0FJRxd/qeRrb4ukxj5gGPXGnLGCFI9vbya5ZkPcOk=;
        b=U+KzRkVAsE7Hv+4J8fCeabQ2NBjK7YvHxQ+SIJkfHb0bQ1kwbrKeRgsntPivgRfA+j
         Z894tdlqMWlF7rl8zd+Oy0eXgEOzvM2G1wYh3dDzMWwgNOG4/MEgevIRepbe56qDL/K4
         BuDyl4fEfNZxekMbgVDdrDcnr8HCOL1QDREOM8FaA1h1p5+72nWdSKwcwWwDDHKIn7Lb
         HfsdfoPBZ7Oc1MV2r4mwxmYajJQC26wsoxlUQERxjFAo2tIlQiKCyuQbOmf0Fp8C+OBQ
         9Ww4/JaZ/ZRDkCDD7LVpysvYyKY/rOIDhLZY/QvGQvSDpUtw7NM3Hr0o5+c4PFlArOGO
         Do+w==
X-Gm-Message-State: AOJu0YzsLH3SXStYEXXydNpPhAA/hw34IXNGVNMr/I6cHlYST8akv7BM
	bdD3f5p/xaFZJ2U0VdJcwxZi2PC1kg7zPhDIU01y1l1RjVum94IOSbKvNQ8dP3w=
X-Google-Smtp-Source: AGHT+IGNowrJ+ExOTEseHFYkxYqx0+T2cock91wk/oWIqjeYEFWjHC5mMrgXgR6U01DMWiHgqVUVoA==
X-Received: by 2002:a2e:9b16:0:b0:2cc:a618:f11b with SMTP id u22-20020a2e9b16000000b002cca618f11bmr923011lji.93.1706193426317;
        Thu, 25 Jan 2024 06:37:06 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:05 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7] mmc: Try to do proper kmap_local() for scatterlists
Date: Thu, 25 Jan 2024 15:37:04 +0100
Message-Id: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABBysmUC/x3MQQqAIBBA0avErBtIyYKuEi1CxxpCkxEiEO+et
 HyL/wtkEqYMS1dA6OHMd2xQfQf23ONByK4Z9KDHQWmDIVhMcicSvMKe0Gs3Wm+cms0ErUpCnt/
 /uG61fs+YJ0lhAAAA
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

It was brought to our attention that some MMC host drivers
are referencing sg_virt(sg) directly on scatterlist entries,
which will not perform buffer bouncing for CONFIG_HIGHMEM
pages that reside in highmem.

See the following mail from Christoph and the discussion:
https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/

This means that bugs with highmem pages can go unnoticed
until an actual highmem page is finally used and not bounced,
resulting in things like unpredictable file corruption.

Attempt to fix this by amending all host controllers
calling sg_virt() for PIO to instead do proper mapping
and unmapping of the scatterlist entry, possibly bouncing
it from highmem if need be.

More complicated patches are possible, the most obvious
to rewrite the PIO loops to use sg_miter_[start|next|stop]()
see for example mmci.c, but I leave this refactoring as
a suggestion to each device driver maintainer because I
can't really test the patches.

All patches are compile-tested except the m68k one,
sdhci-esdhc-mcf.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (7):
      mmc: davinci_mmc: Map the virtual page for PIO
      mmc: moxart-mmc: Map the virtual page for PIO
      mmc: mvsdio: Map the virtual page for PIO
      mmc: mxcmmc: Map the virtual page for PIO
      mmc: omap: Map the virtual page for PIO
      mmc: sdhci-esdhc-mcf: Map the virtual page for swapping
      mmc: sh_mmcif: Map the virtual page for PIO

 drivers/mmc/host/davinci_mmc.c     | 10 ++++++++--
 drivers/mmc/host/moxart-mmc.c      |  3 ++-
 drivers/mmc/host/mvsdio.c          |  3 ++-
 drivers/mmc/host/mxcmmc.c          | 23 +++++++++++++++--------
 drivers/mmc/host/omap.c            |  7 ++++++-
 drivers/mmc/host/sdhci-esdhc-mcf.c |  3 ++-
 drivers/mmc/host/sh_mmcif.c        | 22 ++++++++++++++++++----
 7 files changed, 53 insertions(+), 18 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240125-mmc-proper-kmap-f2d4cf5d1756

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

