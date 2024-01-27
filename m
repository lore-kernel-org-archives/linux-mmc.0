Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25F2F44
	for <linux-mmc@vger.kernel.org>; Sat, 27 Jan 2024 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314819; cv=none; b=Z1GB07DZdDsuV5gSj4oXET4j+Z0xeoD+pxpDuJ1c0XM/E22xsEfYflSI8aWTx2UQ2jOGgfe/PbmDwJHLdaBG6kq86qlQgfm3I9SxGMtA0PioSrXXB9t8r6jIxRdTdnYIgT1f+EQ9up2Sg3vb5URQ/y+I8k5YjA5YrqIh1QTh8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314819; c=relaxed/simple;
	bh=r6GJCJTqaQQRhKM/4b2T3qgoDHj0cK2/fTlyNuihGgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAkfBOL4gcDHveRAoQLXIZ8F6ZCc1Lu6byPFbArSSa3/iHDRtmOeeVqloZv7nEj2Nl0cj+7YoGDmlEZxIg7FZVgRIeHN9cCbuCGTCwnM4SG6lkeb0MH4E0WjLUrF5Guruw7BauSaTIz9I0Q8fV1VmZr26F4xKXuf5TJzbMaiUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANQjOT8w; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANQjOT8w"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf1288097aso15122761fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jan 2024 16:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314815; x=1706919615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kus8wRLkItgWvRgBCeH/aGV0whUxwXs/muBiM1oKFIc=;
        b=ANQjOT8wKhKeFTolKIrWpzCLwM+5Mjn1CEMsc/IWfzZRn0pwGezxthrptX3MCyHL3c
         fhCrLjB+mJ7z5cZwU9e9/BCaskurrlAXyXg4qEYgxK6m03mpoo04q63+WKhH+I42tM4T
         J6GFISk+G4f/E26GlNVmgWZkmoXQwKTQ/9mGL/UGUWZmRTa4m/Ucm/HMWY7pNmd+pI6u
         ECsDjLbDqfWgJsA3HxNn04LuR9wyJJPDUcn48ko5ffIoDZjPBq4jEX7s4YdKnLTvjs7H
         dAMVpZcLGIPSfA8tnYMJTY5fxUD+Cr0lyBfrapsLyvlCcqDtAKhzoUlACzvDIO27ZZax
         ywGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314815; x=1706919615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kus8wRLkItgWvRgBCeH/aGV0whUxwXs/muBiM1oKFIc=;
        b=eEvxziWh46Ix0wJ6x3NS3qLntUpwi4W/+0f2AdU8UyhLLPEFFnmRfQwY2oiklWwIZT
         g/NJJCTxKJ4THasB6XgkynK+v1RPlPTRt3z7oHOjd2dGwtZe0t9Jh5csEtB4p6AJ3ubr
         H++9nPg57Rik78pAdN+JbaECV5kZQcpJu7wQ6np7dXzg327Y2wi+8AjcSO3cSnbWpBW+
         rSs+rrgrinaHOj4Zx+r8fjpbMj3f1sOdRA+wHKcsGFgHO8TIwGxVFGOdg44lkf4Zm3Ku
         i6aQcsJEJlXPKkmjYzhm5/2FOUpu3dn4ANHzkH/y9mjgVO1Wh7yRpFIjS0yH5TVNPCGM
         F6ew==
X-Gm-Message-State: AOJu0YyLblqxZnXUGW59ZI7MjlPV3RhEmahBWfArJMwQ5pZuX8HObLvk
	YhbT4oCLODzIJrkhrn63ayu8LrI1Fp85dp5zeipq90uVlbo6zA9J+hE9kXTfThg=
X-Google-Smtp-Source: AGHT+IEpxRIR5WbtJSMP9B8XikMs/Wg95wGD4l3znJD007vGaYsPUxly5zh+a+tVyVBz+XzwNXGKnw==
X-Received: by 2002:ac2:5df5:0:b0:50e:5a25:efbf with SMTP id z21-20020ac25df5000000b0050e5a25efbfmr346844lfq.42.1706314814980;
        Fri, 26 Jan 2024 16:20:14 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 01:19:50 +0100
Subject: [PATCH v2 3/9] mmc: moxart-mmc: Fix accounting in DMA transfer
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-mmc-proper-kmap-v2-3-d8e732aa97d1@linaro.org>
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
In-Reply-To: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The whole scatterlist chain is submitted to the DMA engine,
but the code is written to just account for the length of
the first sg entry.

When the DMA transfer is finished, all the data in the
request has been transferred, account for this instead.

This only works because the moxart_request() function isn't
checking that all data was transferred and will
unconditionally issue mmc_request_done() after returning
successfully from moxart_transfer_dma().

Keep the assignment of accounted bytes in .bytes_xfered
but move it after the completion where we know it has
actually happened.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/moxart-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d12d7d79b19c..8ede4ce93271 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -296,11 +296,11 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 		dma_async_issue_pending(dma_chan);
 	}
 
-	data->bytes_xfered += host->data_remain;
-
 	wait_for_completion_interruptible_timeout(&host->dma_complete,
 						  host->timeout);
 
+	data->bytes_xfered = host->data_len;
+
 	dma_unmap_sg(dma_chan->device->dev,
 		     data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));

-- 
2.34.1

