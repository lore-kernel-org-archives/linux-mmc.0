Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852C1E991B
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142133; cv=none; b=ep9zzOB9xLOZs1XQ+TcMAa2PS1O/jUr0sRut0KfGsz1wGKSzk+RBg+365gVF4wC3kL7lAS1fKRlhaTy71Rpn66hVPrU6aLved2grKzg1RYYOHzG3D9Li+GyKz7gxxz10ZENipYQp/C7u+hseeH3diQ5myIvhYxu7vQXb27qpa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142133; c=relaxed/simple;
	bh=+qzmdehfHdF14WJEjMhvv1mK3gFFR/JtnjYHpc/r8UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6DGxDQOfgd+ysGJGmXPw3cgY8wi76TsDXVrgODhhLaMQ85zF8Ci+OMqbqnVl3Si/UPHo4ejHL5xaF+Hbg8bzX1jF4skbiLWFjbkIP+XXWrQ9nRkSni4NZgg7ExpfQV8BgXOoLNY7kzQRyi6qDLBm9UCoGsf85qy/kP4XWdmH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOMyjtUd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOMyjtUd"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5942bac322dso1928193e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766142129; x=1766746929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEd1xYkeo5a1LXVzTfQ+pHOg6Znn6zWv2kFOFCYOWco=;
        b=QOMyjtUdqqEPeKMhFOrPMEOhFO0truXAHb+zhVbIAWi7eam0yuBNQRwfnXTxmUliHN
         KTfOGyB5RO/F6+YTgq3u5LSrSF0LHaqIRCMAhQz2an+8sBIavlzHzDlh2za62fm0e7Dl
         0jbLnka0XaDnHjCBA+KRVE3rmPsGGXAeWUzbQRgr3BiZwxbSBhmfktqQgZXs/qO6IIo+
         lacwzUJKOGRP6NmO8XWs9JRh3xofajjNE+Lout7KtzAWCtq7Dd4piKBSsC6krJvSUL3k
         ibwZywhuMZ/UYHteT0adg/HZJKuAV3gHe037L+F3LWF0iY66/MP+DaS/eOFpsvlIV9sM
         PzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766142129; x=1766746929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEd1xYkeo5a1LXVzTfQ+pHOg6Znn6zWv2kFOFCYOWco=;
        b=WHNR5pmZf+qIRQH+DhCxCWdjTgiUp6+gDLfahAmRc66hg/5ap8zhKTiZqDIKBXxrLH
         Y6j38McFEB7XdDhz6jZp66EGebKJxY4/IDk2w1SipVHqeYirHqkkMcrAdXV9IzvOvBYz
         Biv9mveka2+kTD64xHR//vU1Pwu6I/0ZQ/0eu2Z7nhrTdK+kV4dPv9WE8W0kOuU7E2YD
         Cn8keKBaYAZ8MNsg5aU1TAk1P0L/y/SUrwAMMEnLhh9mtVrVlf3VjdJz0tzGAXRaXNJy
         jwZfF79IjrdVp2R5ON3ifvK8N7MmVRvfU9mJgkEJsxxvcSPOiDTY9ZVUOe8sgJ+RXVQe
         wfWw==
X-Forwarded-Encrypted: i=1; AJvYcCXcjJcWpVW5pWTUJZJHm8eDNEbC7HHVL1brDgnmu28qHOOU7CI/lL+K2yryCzaEhIBwiHYXyI245ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj67H6HqLpyVyhqpt1DI+PHXh19xesdJ4F3HrZlHtyZr/NbNCi
	LSQ6tZ1Miqi856i43unTXPf4a94MKuz7AghwByaC59yLvzPZ0rFtR2N8mpJwidvuXN/FM57a4KS
	qzIEUdkLn/QWMhmYoLlcPFdBnG0eYnnIT/Lram25Ufl+wP4f7q5Tf
X-Gm-Gg: AY/fxX5rrRpBjTuL4qK4EnHdstp7xZxZSsTChP0Z2pONJq+GGFUuE3xeelBhSSleaLq
	Ymio8kQ5zEyEOa3fro3nFjZ3u0qPYFM3k4VuZGNCimL/AblFXjYTJOa1N1oVhCFGvZxZVvZKAfp
	cFYfjisTiNVOL6L+1a/FoOkandg5vW97zFd6AqLT+67I3KpttXtsulxea3qHq5Yx5jlpY8QgUS5
	KFIIEGa6WkQb31TVVYkYggTkCeYo+FLbzv+sMMeqWaMjmt73jCTgmlgWtZO6O9l4/4+gc4Z
X-Google-Smtp-Source: AGHT+IHP/8kLt6mI5OBbWjI6Z8CfCJE1D6mB0FHvoYxGt5wCb7rMs6xYEuolWQTsqRluUA1Vz4BLJvmzdqPD+dQSeDY=
X-Received: by 2002:a05:6512:239e:b0:594:26cb:fce6 with SMTP id
 2adb3069b0e04-59a17d417bemr1121069e87.34.1766142129257; Fri, 19 Dec 2025
 03:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUUp-x2ex9I_Nd57@stanley.mountain>
In-Reply-To: <aUUp-x2ex9I_Nd57@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Dec 2025 12:01:33 +0100
X-Gm-Features: AQt7F2r0Ok_W4IxNPHO8h10xl0mawL2KNeGUusXQKhE9blAANx-kvTq5KcKs11U
Message-ID: <CAPDyKFp2Mysr_XB0E3mkbPG_L+wqMT_v5k=Yjgen1k_ej+Qc0w@mail.gmail.com>
Subject: Re: [bug report] mmc: dw_mmc: Remove struct dw_mci_slot
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 11:38, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> [ Sorry, a couple more.  I should have included these in the same email ]
>
> Hello Shawn Lin,
>
> This is a semi-automatic email about new static checker warnings.
>
> Commit 926311cf3361 ("mmc: dw_mmc: Remove struct dw_mci_slot") from
> Dec 16, 2025, leads to the following Smatch complaint:
>
> drivers/mmc/host/dw_mmc.c:3494 dw_mci_runtime_suspend() warn: variable dereferenced before check 'host' (see line 3489)
> drivers/mmc/host/dw_mmc.c:3546 dw_mci_runtime_resume() warn: variable dereferenced before check 'host' (see line 3516)
> drivers/mmc/host/dw_mmc.c:3562 dw_mci_runtime_resume() warn: variable dereferenced before check 'host' (see line 3516)
>
> drivers/mmc/host/dw_mmc.c
>   3488
>   3489          if (host->use_dma && host->dma_ops->exit)
>                     ^^^^^^
> The host pointer is dereferenced
>
>   3490                  host->dma_ops->exit(host);
>   3491
>   3492          clk_disable_unprepare(host->ciu_clk);
>   3493
>   3494          if (host &&
>                     ^^^^
> So this check is too late.
>
>   3495              (mmc_host_can_gpio_cd(host->mmc) ||
>   3496               !mmc_card_is_removable(host->mmc)))
>
> regards,
> dan carpenter
>

Thanks for reporting Dan, the offending commit has just been dropped
from my next branch.

Kind regards
Uffe
