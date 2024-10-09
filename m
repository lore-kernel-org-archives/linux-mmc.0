Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329819924E
	for <linux-mmc@vger.kernel.org>; Wed,  9 Oct 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485954; cv=none; b=sRg6XBNX4Z+p5AE7GdN/MGVabyZFp+mre60G3f+fkYO0bDw6vxx9fn5dCMwuSnCFVlFN+C1LqfhxFwSsKoeYB8+ODYV3GCVajSaIutsHaWRkh5GvonRAP2aco3vJv5l/goSX4wSn2W86m0xw7Z0VH4Qsf00scCOf1aL04Z6Crc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485954; c=relaxed/simple;
	bh=6W20wo6W1NAhBdGCBRPwGUkZeOFh5Ij+4seoe5QKTNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SOJQ9CG6WakqBQAvoPOHs45MljQ21lV7qdvHLwvl/FwxqtU7UCWxLCa8IjGSjmc3j9KQioGiDT3GRnNfR3FU01277GXsVLx7xlNwLbJaTS1HeaGwZ/Y34scJaCuM6GPE9tdyPmIKABxP+x9YkEaokq/r/GruuyKS073BNu9m1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f/VLf+bY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/VLf+bY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43057f4a16eso11804175e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2024 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728485951; x=1729090751; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbTJBsmlSC2opQN7CDx2Kt6P13+GI4y4fO1oC2dKQdQ=;
        b=f/VLf+bYqsnDh/n4b1LUNzPcUwE99d9NSLxAYnBUykS515lIrfKhphSW2zYl7JctxK
         Un63rOh3T2KvXQn9S8f9ocZ9ECGBjbYMB8/3CwkyLV7npyZg5tJo1znsZKq8bKkxC68T
         5ekAWvlvGuPkL9O5wHvG4YjsaHweTS2ifjVRpTc9BmSPIEAt2nUTkZc1D+XSaKUVjXi9
         tmse1e6RGEeavAdCxrrP10fTWfPTZtCJ8PuXv6Nz6joEUX7WS0TJ1i2kLzP77+NjpRrP
         kW/kvy5g5/a4p3+ao1oDs/+wwBuftmvtKBRv1AP3dysT0O+GZPebvOzlofpGR0X3flAJ
         Gshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485951; x=1729090751;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbTJBsmlSC2opQN7CDx2Kt6P13+GI4y4fO1oC2dKQdQ=;
        b=Fb28UpYoV4ngt0kUwC2bUvPTYeaDYQ13O+rpbNvpFEP+/CxVVqYFqMrvZzxX/kl5wh
         GdOH6kp0eDiOQcOXgO3YEy7orUUeq+CnBrcs3omqYkZLL+MK3qa7/1Sx606RBEDRnTCl
         tt4x0TlZKRJO4lXNlEyMjXxl3rIcMsW0oCbyj6aPD0t81lUZsUEkjL9HhsfLF+zj/I1n
         WKcoWL1hCGSuCFRyLOUmJvFBh5m8fQN3D66xd64jbodL+W8si8rQxczGI4u+LA4YXlnL
         y/5Ul+0nnG+SgspEULDammYKznqyq4NpVFPxr1wiQyjdExigyba4hZd4JbZkOdR2h+KC
         qEZg==
X-Gm-Message-State: AOJu0YySnpmOMLV64sXBvW3WLQbj8/o3X5m6KNF397mwwtfissDotCL4
	mvX0hEk3d58Y41135o04xkBiALg3s1huM88X1UBHD1t8XpqrvW9iAjQ/VE8MwYg=
X-Google-Smtp-Source: AGHT+IF6Y7zH0RcQHVk5OOw9QNetNXYT4TOsCCSm/xGO/1/nkgcpOo5vp0kzdI0penn4Ra7OTK038Q==
X-Received: by 2002:adf:ee51:0:b0:37c:d179:2f73 with SMTP id ffacd0b85a97d-37d47e9d173mr87377f8f.13.1728485950705;
        Wed, 09 Oct 2024 07:59:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f7f6sm23149485e9.8.2024.10.09.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:59:10 -0700 (PDT)
Date: Wed, 9 Oct 2024 17:59:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [bug report] mmc: core: Prepare to support SD UHS-II cards
Message-ID: <0605eaf7-a28d-4f87-a9cf-d4c3517ca5d9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ulf Hansson,

Commit cda235518e91 ("mmc: core: Prepare to support SD UHS-II cards")
from Sep 13, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/mmc/core/sd_uhs2.c:138 sd_uhs2_init_card()
	error: uninitialized symbol 'node_id'.

drivers/mmc/core/sd_uhs2.c
    120 static int sd_uhs2_init_card(struct mmc_host *host)
    121 {
    122         struct mmc_card *card;
    123         u32 node_id;
    124         int err;
    125 
    126         err = sd_uhs2_dev_init(host);
    127         if (err)
    128                 return err;
    129 
    130         err = sd_uhs2_enum(host, &node_id);
    131         if (err)
    132                 return err;
    133 
    134         card = mmc_alloc_card(host, &sd_type);
    135         if (IS_ERR(card))
    136                 return PTR_ERR(card);
    137 
--> 138         card->uhs2_config.node_id = node_id;

The sd_uhs2_enum() function is a dummy function so this is kind of intentional
but I just checked and it causes a build error in Clang.  I'm surprised
Nathan hasn't complained yet.

    139         card->type = MMC_TYPE_SD;
    140 
    141         err = sd_uhs2_config_read(host, card);
    142         if (err)
    143                 goto err;
    144 
    145         err = sd_uhs2_config_write(host, card);
    146         if (err)
    147                 goto err;
    148 
    149         host->card = card;
    150         return 0;
    151 
    152 err:
    153         mmc_remove_card(card);
    154         return err;
    155 }

regards,
dan carpenter
