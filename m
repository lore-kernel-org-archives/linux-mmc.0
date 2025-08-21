Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F319E97B
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779577; cv=none; b=kl4451ttBR+s54deaMWmJ+dtsU4hNaS0UnYPMYC/bgJwWwWH3wxhba3cCgRorbCg5m5moWOjfQVw+7vXoAtO2e83ogSa8ekgd0G14a6hVw4NjPoV1VC7jSUa2cKVv7SJxCFnVHTvjr0sY8hheKyGFhI6kFPSqFxh8meUD7FfH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779577; c=relaxed/simple;
	bh=ocQ3d5j9vIq4dGBBuOr8WswQdXME9A/E4gyt+hUQqp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fl2LPm+k3ET6HbZvYqsEFP32KX7SdVMHL625aA0qrwd53rp3MM5XF882EwjSC8d/LrAHfHmO2ofVP7wa7lBo6SrVL3t/YerHl8RPpPUm5y7I6OZsJgBvzDtFwSNm0/4y1ExxZVroCEW/FR16TKZl6FfMlrR8vwlFPMct72eotQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlJCwPyH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlJCwPyH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b916fda762so899500f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779574; x=1756384374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdIRAKr2cN8G91t8BLxjz7Gzji0/85KCNwhJJjiYkCg=;
        b=LlJCwPyH7wQd7hGdjBPPo9QpbeOqt6GOUinJqkXNvJrdyvYw+tzGITSaJy+a2cURXP
         OuXCCFUh9SXzjyjv3ky9IY/HFZlVj2tPyWQ4uuFZgCry/Al31k8WTAY/lAUPJO9W1Kvo
         tX/pgcycrK0qmi9bgAbjSwsWTMHZLF1VKuOA7NYh3GvzmPGe3yYhlLG7rKWdOdrkapLW
         aJaokVdsat/5G25fiZyfZHBPPBF5FL18tb7UGokIzj8hTbYQCD8cVlOR9cwkI4HBqV5U
         pqBn81D7s2PeU0W2GNBw9HC+YbQ+vZJza9IT5bq53I7FHeLSJa7+UghKqAC2lmZs2kqv
         EhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779574; x=1756384374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIRAKr2cN8G91t8BLxjz7Gzji0/85KCNwhJJjiYkCg=;
        b=nj2rAE0oPH02Au+pb5gcU9/3jQWupFYBjS35lwmFzEbggfOfjE+Xr9DDVl3At3sSBz
         S7HtP+Qr2+BsgbLLMPVFwOyvYAAgRX49whsTi4L4QWt+svFNEGAcIq7A9221z3zkGIon
         v1ixcAdPiEpDTquqWyqm6Vut1EqH+U8aLfkax3HVPuLqlw85vDqAK4sN4kEM6naCCQPd
         ebAXHIQ2On/x7TBvsx5zLwIjrB20e8lYY/UO9f+nQs5qNc8RBFiN7dluXShklDCJc0b7
         f6dDkJUz/pwpNunnxnbryIorNJ4UCjvt4uIi+hvMUJmwztyTiaxf4QnVQytvN+Qhpfrq
         lCMw==
X-Forwarded-Encrypted: i=1; AJvYcCWiXE8vnAwEDzmSzDkFfaMG2CKywaC0UX6x1xMWUdWHkNkl9vyhXAzThpIAfwKrVcs52JGiLxdYvQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBrp3votnlfWlqr5d2cBZ1Bl5SLLeL8gi2o/9gnhy6bhvGGuN
	5HKorsSwpGjENh4Ek+LvME5vQI1DsZ6XLVFTqQyPex8aNsQTV4nBI0tUNHpIp11pEzo=
X-Gm-Gg: ASbGnctkwKZf/t6Zpqh1wyKMHAdF7Re34ljTB1v562wtB13107kJEkVg/RXsGHIdVgL
	3xlGX1hHuKuJFGRvMMiNKuCbSKnJXi++Ihc7cnCGhhzFu0kE9PSHDICZDXJl1Lz3zq/KrZgNR/K
	k/u2otNChIYQHd5aPxZqtGOVcD3Jk8RChSDFkLnxAXXyXvz/rrRPknIYOmVPUjAf7xEUWmF3wGs
	gg37WpXsqoauCgzxH6DAmYYsHgsgGitQAHguuDh3hN5VCIdo9AjYqZhmK6O9FnUoOc4ks+usB1f
	dE7vt1gwjFRxlsDIGCyHZ6rlTSexxwL+LRohC2Cn5zp8Q/5l1G7bJjCu2uheQEFOkZ4eJugyPr4
	DaWy//SEaSDUlPU1V6E0asXsdvx1NTNl3jIq3hw==
X-Google-Smtp-Source: AGHT+IGLOFZokM+L1YFBETmJ+c1HGUrKFAr5zBcd3i6pzbkvpmwIxEYCoRLXatleLwvbvzJVH4ODSg==
X-Received: by 2002:adf:9b97:0:b0:3b7:94ad:ef50 with SMTP id ffacd0b85a97d-3c4b4256c02mr1669280f8f.2.1755779573600;
        Thu, 21 Aug 2025 05:32:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788df7sm11530384f8f.48.2025.08.21.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:32:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:32:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricky Wu <ricky_wu@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Avri Altman <avri.altman@sandisk.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: rtsx_usb_sdmmc: Fix uninitialized variable issue
Message-ID: <aKcR8QD81TjVqIhl@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If rtsx_usb_get_card_status() fails then "val" isn't initialized.
Move the use of "val" until after the error checking.

Fixes: d2e6fb2c31a0 ("misc: rtsx: usb card reader: add OCP support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index e1ed39c657c3..70bd21084b97 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -785,13 +785,13 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 
 	mutex_unlock(&ucr->dev_mutex);
 
-	/* get OCP status */
-	host->ocp_stat = (val >> 4) & 0x03;
-
 	/* Treat failed detection as non-exist */
 	if (err)
 		goto no_card;
 
+	/* get OCP status */
+	host->ocp_stat = (val >> 4) & 0x03;
+
 	if (val & SD_CD) {
 		host->card_exist = true;
 		return 1;
-- 
2.47.2

