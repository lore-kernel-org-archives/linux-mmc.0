Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC67F
	for <linux-mmc@vger.kernel.org>; Sun, 14 Jul 2024 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720918436; cv=none; b=AqMOuRTOg5BcQviiSYroip51d0AuSa420VrRjK1xINOAa7RuihaN1XBX1qN/45unHzwtdeyu33leynxYmOhAfJLBGbsebRJcMXpASOn5phuL5H8V+hiA03zU25pW2mg1l+NXfBeygKL51wh0kxYa8oMOfA/xV98fYiKBE60B6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720918436; c=relaxed/simple;
	bh=etHhzSShrnsKFUHGhg/uPc4aoGQEjPi8RdMr605Uvys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XnWzGwVamJf5g+IlPIG1V6eR2iIWqHtZP933r2HDrVXShlD5bhCeByReyRo1UwqBlckj8/wP7C/NJh3n7g6kBBURjEPm0aBeob1pu3qr8A3kKa4vRUl5c6vaYXKXxLg3rrZV9nKYX9/mT5tnnbbfQaYwvyQgFDCNNHLv0VcoqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hqj8z6VW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hqj8z6VW"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70445f0d9b8so1936530a34.0
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jul 2024 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720918434; x=1721523234; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Npt7RMB8C5GVjR6EU+7HxO3zhhUpOewa94YWnAhB+9U=;
        b=Hqj8z6VWEQSbtiA+0+Zk73vP/25JiVj1QUrjwPI2nBqNg2Lj+kgs6hdAcLzOEU0hEd
         gmHGxnsC+JLUNs0nZeEMKQVtYxeW2vQ+CBs5Ux8kIZKeOR9Fopb63Q9TKEYSsD+GavuS
         YuzplHEL7XE0UIqYo41A+2GnBYvZIM/ohJg2gwN387zmPEs1fbWp1Vj7cHXo9StwF/3E
         /xYqW0NPsLV3iQBLD3EgYumeTvYHBs9UbUUVohwc6GdWvFOCNvEaNWkhFcrZvvuCbcaL
         Ve+WXIr6Z0oOnHCGY0lUnZyIkF1yR4pBdu0yESWVEJI55AjITRg/8sjkhU2Lb5la6NCn
         CAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720918434; x=1721523234;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Npt7RMB8C5GVjR6EU+7HxO3zhhUpOewa94YWnAhB+9U=;
        b=fdH21Wmek01RywASE1gSci4mB24F5wS+s+EMDt2SzH1DhE0Fed/tLirLSQdlxYvQe+
         EA5q8Xn7/UWHghhLwN5ZJg9AHbRDo4MKxPD18+3QsrdcO/rA8E0N70OjFS/C6/22Ze5A
         0Uh8i0qSjTKfiVDRMT+QuBkQfZvJQ1i+H27rEh7zJsmFIiGwEy1Bx4d/Z7yL5KxXiown
         Pn5rMG1+KkAf/nwGpgCDjQYSGiX0Mo2kJUor4cvgigFpTJWS/iGy8r+y1bo7oaK8OvM3
         bezL237ok1zaSD8r9AXTob0qz/M2KESdX92vpS5CGez8U3qBvJFAVA6+Sun09+Vznzsw
         cUZw==
X-Gm-Message-State: AOJu0Yzc7aFib5PjtgkwJgSUfGVzcjmUPRVl2nOrdRsgaJSrXp6ygxzU
	2RCrisOEHAw0yh3G91TZi7qcRu3am7DbI6FVG0KhEtPxN/o3AA+GfMys0SUhEh1rZYlWeLhO4bJ
	8
X-Google-Smtp-Source: AGHT+IFSSp+hjf/gyO0G88MK8gFsUOnz2atl9sNnjeeqaweGCVIqdBc8LFs2pdcuUZ76+aGzzqL3Qg==
X-Received: by 2002:a05:6830:22d3:b0:703:6aa1:b13a with SMTP id 46e09a7af769-70375a0581cmr16737681a34.12.1720918433750;
        Sat, 13 Jul 2024 17:53:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0d3ca42sm488805a34.81.2024.07.13.17.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 17:53:53 -0700 (PDT)
Date: Sat, 13 Jul 2024 19:53:51 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Doug Brown <doug@schmorgal.com>
Cc: linux-mmc@vger.kernel.org
Subject: [bug report] mmc: sdhci-pxav2: add SDIO card IRQ workaround for
 PXA168 V1 controller
Message-ID: <9ddaef2a-05bb-4fe7-98c5-da40a0813027@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Doug Brown,

Commit 24552ccb4f1e ("mmc: sdhci-pxav2: add SDIO card IRQ workaround
for PXA168 V1 controller") from Jan 16, 2023 (linux-next), leads to
the following Smatch static checker warning:

	drivers/mmc/host/sdhci-pxav2.c:154 pxav1_request_done()
	error: we previously assumed 'mrq->cmd' could be null (see line 129)

drivers/mmc/host/sdhci-pxav2.c
    123 static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
    124 {
    125         u16 tmp;
    126         struct sdhci_pxav2_host *pxav2_host;
    127 
    128         /* If this is an SDIO command, perform errata workaround for silicon bug */
    129         if (mrq->cmd && !mrq->cmd->error &&
                    ^^^^^^^^
If mrq->cmd is NULL

    130             (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
    131              mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
    132                 /* Reset data port */
    133                 tmp = readw(host->ioaddr + SDHCI_TIMEOUT_CONTROL);
    134                 tmp |= 0x400;
    135                 writew(tmp, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
    136 
    137                 /* Clock is now stopped, so restart it by sending a dummy CMD0 */
    138                 pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
    139                 pxav2_host->sdio_mrq = mrq;
    140 
    141                 /* Set CMD as high output rather than MMC function while we do CMD0 */
    142                 if (pxav2_host->pinctrl && pxav2_host->pins_cmd_gpio)
    143                         pinctrl_select_state(pxav2_host->pinctrl, pxav2_host->pins_cmd_gpio);
    144 
    145                 sdhci_writel(host, 0, SDHCI_ARGUMENT);
    146                 sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
    147                 sdhci_writew(host, SDHCI_MAKE_CMD(MMC_GO_IDLE_STATE, SDHCI_CMD_RESP_NONE),
    148                              SDHCI_COMMAND);
    149 
    150                 /* Don't finish this request until the dummy CMD0 finishes */
    151                 return;
    152         }
    153 
--> 154         mmc_request_done(host->mmc, mrq);
                                            ^^^
Then we are toasted because it will crash here

    155 }

regards,
dan carpenter
