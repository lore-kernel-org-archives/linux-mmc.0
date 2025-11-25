Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AF31A81F
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075656; cv=none; b=DAMrcR7rHGU3w1wxw7qmnkK/bFc1AbhIV+luaP1XBipnQSLuv5tfgQR8vsJAxynszczFCKWkIfgxSOxelIC3yAxNppi2nGxgi0wCPesAPRSFUxjcDddYm6c2P1kUkluqecENBU5/V/x0cugmSroiMwYSOsyIwIs2H/pB1uFDSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075656; c=relaxed/simple;
	bh=TJje+ZFmoQtgTQbXX2vXROwnFTvKvBdghzPYF7XErno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwVYgbqya2bNKAkuss2iBP89I59sBMFpePeF9NjRNhzis40VoRWFwOtdOxnQLB1UFHJ4+HlsSqB1msnIxcJdw/ZIhOwvuXFkslC8PlmUpV5eztBU7XikbkEmJkOi1N4LVmPCPMvFSx5P7vjJgAjbogJktH8xJ7ZqBYu4XGBsNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qy6HDgzA; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qy6HDgzA"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640c9c85255so7599670d50.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764075654; x=1764680454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1RsPPNmFTp7OpTkMbhK8Rgl/qW4d5zaCYUB+xPaRZ5I=;
        b=qy6HDgzAqvDA4V+O7vdj3pdClk+5DQxkJEdIRth0axUbvSMXA0nxb5KjCoUUQItUcM
         fkC3vE5XiQb2hGPgOB8sSEhPV2c6JWn06TE/uA64vd+Xj1KYHvBMRl9EqoKle+yBfnUH
         dvQIxdETZb2nofVFYCQSMlZHSQezCJhF72kmaGTtVZfKRiA6qsB5JOjPCLHGz6Edd4PD
         L4tJclp4d4hp1YEYh/TskwWUGokbvzD/pZvpnTNMkYUCMbk+aOp4TUet5WBy4kuk0zQ6
         uNfCvnHtAJOlsFLRJv14Ol6SeOo75MN3tNmRjepJrj48HqVwVr6TyYFMnxrnD0koZODi
         6+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075654; x=1764680454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RsPPNmFTp7OpTkMbhK8Rgl/qW4d5zaCYUB+xPaRZ5I=;
        b=YX/q/T7NN0l1Dfz3WMMOStORmuILeXlQ7EpNVTHkyg+f467lXv1snhThbpN16p08ou
         5bcQ5Y78BzKpy86YPup32+4t9yysHpVhPhY15JgDrU15Xv0LbLWaKhMJTES9H9wJ9Ns9
         sITyg56/w/uw4SlS/5rqzx97O6TcMgtpHKVVa2YpGcHQaVLZyH+DwM+PiIhcOazkgyGB
         WoNi2WJoBHH5MwgaisIH7rMdyXkFdA3iCFued1Sm3zjuPysoOhKAGvoPdvmIo9DS1B4N
         mzCn8mSnN42heXfrw6Upye6KBABACLiokgmMnP/a5x68+B46VGti3xCtQMW9FcZB37en
         LweQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm/4C6kUXIGxls8wEi5Ogl29buU6ys8a6HsfZJYQHwERQpQdkdpiduyVKH4uGqPKCpJ58dQIxXMd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzsJIicWM3dQxe9Vl3M9nqVlE9ZJg/SpK3Z4WDSPD02NbjI2T
	E9d+T5gMx43z+sBsx4oI53iNrgVnKUsD7IQmNYqYzBV9iW6KICI2Q/9stjWMsWew5NYmar50X5N
	PWeSWrJmKrvowcWX6IanAkTv8ciMQVdvbxQpeUT/tAw==
X-Gm-Gg: ASbGnctS1ltSmGiscNEjJmbfzBUR/1Wa02wSR+U61PS9W1ocSxNb/82i8zFvQI/8Abx
	leBMlIglnulP+S4lPMXGz/WxP5DaAJ//CEUVFbJDdmjq/7OyK8k/DiPjDCFGHrvlPvoQUdJ+MRj
	ZjZn7CF+ZjHEF3FaCy0EISCqZYzkpylyBv4Lu0aH7X3Qy5o6YTY+C9pKdH+lenYqPvtQmRAQ1d0
	Tq7G/QmSuCwaML1/aqwwU0P7mPSuq8vvWtvTkzao8H03UoqbrN5/dYKCUsMUVHUPw1ulVR2
X-Google-Smtp-Source: AGHT+IEP20Hd5zXH7TaBK1luFEI91whta9/nRanMdGqkrRNeye2Tk/PEkWxVIZl9IN/yXd7H6AlOEFw6B+87i0XqsQ8=
X-Received: by 2002:a53:d056:0:10b0:641:f5bc:68d4 with SMTP id
 956f58d0204a3-6432941d131mr1383516d50.81.1764075651936; Tue, 25 Nov 2025
 05:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121-rockchip-emmc-cqe-rk3576-fix-v1-1-a77805f40072@collabora.com>
In-Reply-To: <20251121-rockchip-emmc-cqe-rk3576-fix-v1-1-a77805f40072@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 14:00:16 +0100
X-Gm-Features: AWmQ_bn9XHBZp-_mXQSdYI6S_EfNS30h2ysruAh8MZxFVousTjCGxc-bOSJ4hr4
Message-ID: <CAPDyKFp4oNWQn3xW3+GGbGmi8U7H98Bbos0vRqaQPaht54nZ=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Fix command queue support for RK3576
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yifeng Zhao <yifeng.zhao@rock-chips.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 17:27, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> When I added command queue engine (CQE) support for the Rockchip eMMC
> controller, I missed that RK3576 has a separate platform data struct.
> While things are working fine on RK3588 (I tested the ROCK 5B) and
> the suspend issue is fixed on the RK3576 (I tested the Sige5), this
> results in stability issues. By also adding the necessary hooks for
> the RK3576 platform the following problems can be avoided:
>
> [   15.606895] mmc0: running CQE recovery
> [   15.616189] mmc0: running CQE recovery
> [...]
> [   25.911484] mmc0: running CQE recovery
> [   25.926305] mmc0: running CQE recovery
> [   25.927468] mmc0: running CQE recovery
> [...]
> [   26.255719] mmc0: running CQE recovery
> [   26.257162] ------------[ cut here ]------------
> [   26.257581] mmc0: cqhci: spurious TCN for tag 31
> [   26.258034] WARNING: CPU: 0 PID: 0 at drivers/mmc/host/cqhci-core.c:796 cqhci_irq+0x440/0x68c
> [   26.263786] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-rc6-gd984ebbf0d15 #1 PREEMPT
> [   26.264561] Hardware name: ArmSoM Sige5 (DT)
> [...]
> [   26.272748] Call trace:
> [   26.272964]  cqhci_irq+0x440/0x68c (P)
> [   26.273296]  dwcmshc_cqe_irq_handler+0x54/0x88
> [   26.273689]  sdhci_irq+0xbc/0x1200
> [   26.273991]  __handle_irq_event_percpu+0x54/0x1d0
> [...]
>
> Note that the above problems do not necessarily happen with every boot.
>
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Closes: https://lore.kernel.org/linux-rockchip/01949bc9-4873-498b-ac7d-f008393ccc4c@intel.com/
> Fixes: fda1e0af7c28f ("mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Sorry for the delay in sending this :)
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index c66a8dfad47c..ee0008d91b98 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1767,6 +1767,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
>                 .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                            SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>         },
> +       .cqhci_host_ops = &rk35xx_cqhci_ops,
>         .init = dwcmshc_rk35xx_init,
>         .postinit = dwcmshc_rk3576_postinit,
>  };
>
> ---
> base-commit: dcbce328d3a2d87770133834210cf328c083d480
> change-id: 20251121-rockchip-emmc-cqe-rk3576-fix-ec8ac72e6e32
>
> Best regards,
> --
> Sebastian Reichel <sebastian.reichel@collabora.com>
>
