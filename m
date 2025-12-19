Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4E22FAFD
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140418; cv=none; b=aNGBPmV6U3Hqc+rE03mRufSwS2fKVwnuCSq3qLBeEpMPdzR/3WHMQeAMXLRgNlAp5qIDNyAICGmmiFB4IaaxnPeMXVS1GzeEiM8pyUuNuTNBqhCnIfWVJ5DERed/uEj5gyTlnx9flzu1H5mI9iUETwXm40B+thggCb5bJo8Hv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140418; c=relaxed/simple;
	bh=ouONRlzjs7iFO8J3u1HrlNzZPxiPSU+PJSYz9yl3m0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LaLfjtl2bSQH8eLIM0S/PSMQ1aaIjvVhxpwlUM6zMU4vBjV8MKu0qr4Occ4r0VtqgFIoXnM6xdVqFZIJ9xJ7nk48a0Yvvtqj20D24qINN9A3kadmQcChriHNOBxFsV/1HvEbq7IB1s61nFbHqWFZX0SBIEV8D6SJtOC4TWfcfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gs6ox2xX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gs6ox2xX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so909336f8f.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 02:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766140415; x=1766745215; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbffUOvw+DNC8717fYyvrRxeRJD/DQ/Wl28bn4ox1JU=;
        b=gs6ox2xX+eDBis2kJjCLkKpYMg3b8djI4BX/PPj8WIbbn2jml6RgQMxXXsI5C0tLKm
         0SZ4N+38UcB6v2hpHtkPHO9R7KREPzL8dhfdRX/h4SuSKTd22RidwvPXj5F7AYOOuT3M
         PM26h5a8xhViWpt4D8P0eDsuySl+ZfCY/KxBkkhkH3bTG7IOcKeWkVt/u+BBPeUdkoAm
         ZA3jDoB4XK/bdRvReYEhCACxtZI4npRvcVnDLLgZclKKhYna3WHNse/LFavGoJ1Lx098
         lFNvtUV/9G+kG3iaSYm6dB8AGGtI35Osud3VqCvAcMki9UMLTz8pPvtlWNr3kKXHE20x
         ScNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140415; x=1766745215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbffUOvw+DNC8717fYyvrRxeRJD/DQ/Wl28bn4ox1JU=;
        b=RPpu24JtxBq/CxcVV4uF90qIwbYGlh3lkOqCqq0o1jk1HD8mt+SY88QUQn00pGZ6xH
         EDbP9dp1S0ooVgBolPiAzyutTEwtPvEzhoa9cbpS6sjfc15iIxjZUByI6mAmdF6ZDWFs
         iaqNlXKmuksudVxzILp/gIH/9qrVw/wQMK9uUeUfXvPnJjxwqhpyp/7ZFadeq4ny734O
         Bnjc1WyC1veZg5Gpr3I68yEP05l9OAhiTG/RzvooGzYM3WF1RpT5+o1GDNYSnHqFCE+1
         ojhIsmhEzqgjL74JDdQftAYiYZbwdn/NXadic+EgwrYpWUXGqLFofllZvnudE/oVEC4J
         pGbw==
X-Gm-Message-State: AOJu0YyujOQB6gG6HLqVokLDebhoDT1AUxBgbZyXZfuw4BurrSpONSMz
	44/lhgXQVFPrtZf3GPkpy7P673CqLyM1kYMSHFXCcvoTGU2Ikaq7/GM1Se5+QmQJVXlNL5PdPQN
	qJKvL
X-Gm-Gg: AY/fxX68LR0au8nufhnSE8Xl/crIDaBHkh0GKDLHHHA31TUvqMLBam+UYI2djKoHx5D
	SoAJ0jMEHim2KV+wXL39sA3LaCDev18HDrmdaul1Su+m6FRdpmnaZPZnoQEIYJycOZPrp0DavBf
	GAPTo4LkHBLEXTjVdR5dvpKSqzFP/sThNuqgvSq40gBF4JO3kUe/pDW5FKoDFvU/3vxXTCx/y7n
	YEUxvqaqOK7Ledwk9ASbZi3HKZN9+CEPBAak9b0CZbSIrNN4o+vTyWx+ANx8WSyCy0/RoxMraYu
	tVWwuzu3qM7JiMOZ9J2YCUzAQ5xBtObBDe8KZlMSrx94IQCEhq41cCxPysVjje98yWPcQlMOpdV
	BO+2ck8DHywQQfGoPoSMI7luSBsHzTZvN8B/+ehenBRl379BOeBAAquNYTdIchzsI9r2ZNxaHOl
	hO3UeEj0M+2hc+5DuRvyStDOXphiY=
X-Google-Smtp-Source: AGHT+IHgyo0ohucjsKwyyFdpRDNKZJYrIOkJc/8HaaUIMQMxaXRTFYjufRMcMkjg1RjybYrAHOkJTQ==
X-Received: by 2002:a05:6000:2405:b0:431:656:c73e with SMTP id ffacd0b85a97d-4324e702846mr3031106f8f.62.1766140415046;
        Fri, 19 Dec 2025 02:33:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm4430060f8f.35.2025.12.19.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:33:34 -0800 (PST)
Date: Fri, 19 Dec 2025 13:33:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org
Subject: [bug report] mmc: dw_mmc: Remove struct dw_mci_slot
Message-ID: <aUUp-x2ex9I_Nd57@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Sorry, a couple more.  I should have included these in the same email ]

Hello Shawn Lin,

This is a semi-automatic email about new static checker warnings.

Commit 926311cf3361 ("mmc: dw_mmc: Remove struct dw_mci_slot") from
Dec 16, 2025, leads to the following Smatch complaint:

drivers/mmc/host/dw_mmc.c:3494 dw_mci_runtime_suspend() warn: variable dereferenced before check 'host' (see line 3489)
drivers/mmc/host/dw_mmc.c:3546 dw_mci_runtime_resume() warn: variable dereferenced before check 'host' (see line 3516)
drivers/mmc/host/dw_mmc.c:3562 dw_mci_runtime_resume() warn: variable dereferenced before check 'host' (see line 3516)

drivers/mmc/host/dw_mmc.c
  3488	
  3489		if (host->use_dma && host->dma_ops->exit)
                    ^^^^^^
The host pointer is dereferenced

  3490			host->dma_ops->exit(host);
  3491	
  3492		clk_disable_unprepare(host->ciu_clk);
  3493	
  3494		if (host &&
                    ^^^^
So this check is too late.

  3495		    (mmc_host_can_gpio_cd(host->mmc) ||
  3496		     !mmc_card_is_removable(host->mmc)))

regards,
dan carpenter
