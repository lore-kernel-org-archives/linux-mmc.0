Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043E209F2B
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153056; cv=none; b=Yu845XurF2KXgVdPX5dy4WbcjnsqhtyWeg5DWoheTDSn2qe8tFBs/h9qF1slJrx8sqW55vG/NQxdYPve/32YQr/t472fxlP98/Lwxdo6aDoxHQVdmPR8diZZxrKG8PpwQCdx/D92lUVMIsksGy5tJL6k44jyluR9DlqQ87UWBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153056; c=relaxed/simple;
	bh=GT/7Ze1ICZzO91X+fJzIIryCuvOoEcn09j4ZdKtLo6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laU6clr6Kb88UzEnuhUCY+LUcBneGZsL5aehywW5QrX71P8ouscsqVE3GgSXy9IUta+J8IUuZQgAKrLprOCDCJpV8fJpWVTkzNFM+vLs0vp0FemPT38qMzF8AhGw1EuuEWLHkrFheqzwQ5TnzC9KdEaYNSO4xRbifxYa/++AD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URPKnzxz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URPKnzxz"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e396c98af22so3586937276.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153053; x=1733757853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m76+jzfpV1Gl7IDVGFQkptedm6l1QHBc35AI5nAO280=;
        b=URPKnzxzvYoI9ybhzsWZwVzc3sQib1Kf/2TWh+EvBAJ2eCmxCfi+VGggKbP7QX0Pnl
         gBRZHTUe2agFetZFdYg1ZGMd5Hb16QFGmRygKH6h8wwKu0UYplSpnJe8J3tv5I1jZRY5
         PngGCeFtm2Geo3mzxVDjBX6RfXd5/hUG3bM/xasjIx1luQTEFVnQPEzlHMtCVCluNAN8
         OSngWCxmilD0WR1V5Pu5kh9n4GoGV8hUCfPOU6cnnw5kCC0ysOyRUHiWp9VcM/p0IDEA
         cJFgIr13ouQd6/afFwCBWzkjp51FlplKybl9TKJnG2xF+X5l77+2EaOS3FmS2XT5k/Dx
         PCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153053; x=1733757853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m76+jzfpV1Gl7IDVGFQkptedm6l1QHBc35AI5nAO280=;
        b=QmmrUu6dfWdjCYthDKKLOxN7wjp2l8cHtO5TdL7LxLwPf5lV41edHyreDqEk50aVYk
         UWP+/J08JmPI4W1gU3Fvi3czdjwD3PwfdHIdTbMUqSRz3r7DUdGIvMslIdMxFXgMhWjw
         n1vQ8Zr7lwK3gyftGJj70aU54Gn5TI4fXPctH/tzK0hAUUSU+aEO/rZAD/cQNx199JXd
         9zZZLmvBgQJ2tJvxhjf0XmhrA91PZ8Ay2pRM507Twi/RnLSHwpqndSJ2K6cUsBF0uMhA
         2y838l81himB0XW+4X2cWXRT0H63BECPaWrtMpGBVOrzPsoKiG303eZyCRuBginqCq8J
         tWCQ==
X-Gm-Message-State: AOJu0YzC5TPcvVxHTSQ1RiVS5UM1dXSUL81MIMT6KDPOShSXRsmG/cLY
	1Qe57OY4V69+YJSnOMb+I8uLbTx5czBwYlzbLVar0saqIec16/DbZS/w6P83DZ3oiRiQXovRoT+
	PjHhly3hhEqG47PGZVc3s/X0I7MdoA0UAqxojRMhbbFOHJPR+
X-Gm-Gg: ASbGnctrjgTTcvIBAjkKItZDnaFVncH+SK/fzve80I4lwB6T5cOeBeBfh940C/QLD/J
	iOsnYxcQQ1mkMGfzWq0KfcnFlHe+4IK67
X-Google-Smtp-Source: AGHT+IHH7hIx+e8n6avEfQWiti54KkaNN3HlOI/MmlmrT0lxi9lBcIhv+cnoSDvpFTNHzd+CyUH6RHneSifHab2NRNc=
X-Received: by 2002:a05:6902:1895:b0:e33:20c2:223f with SMTP id
 3f1490d57ef6-e395b869e50mr21994700276.10.1733153052749; Mon, 02 Dec 2024
 07:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125122446.18684-1-ulf.hansson@linaro.org>
In-Reply-To: <20241125122446.18684-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:36 +0100
Message-ID: <CAPDyKFqQaPs1oQ9zgvOSBGLnP=tNe0UdX4B=EPELdY2jFjGRuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Further prevent card detect during shutdown
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Anthony Pighin <anthony.pighin@nokia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Disabling card detect from the host's ->shutdown_pre() callback turned out
> to not be the complete solution. More precisely, beyond the point when the
> mmc_bus->shutdown() has been called, to gracefully power off the card, we
> need to prevent card detect. Otherwise the mmc_rescan work may poll for the
> card with a CMD13, to see if it's still alive, which then will fail and
> hang as the card has already been powered off.
>
> To fix this problem, let's disable mmc_rescan prior to power off the card
> during shutdown.
>
> Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
> Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for fixes and by adding a Closes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c  | 2 ++
>  drivers/mmc/core/core.c | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 9283b28bc69f..1cf64e0952fb 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
>         if (dev->driver && drv->shutdown)
>                 drv->shutdown(card);
>
> +       __mmc_stop_host(host);
> +
>         if (host->bus_ops->shutdown) {
>                 ret = host->bus_ops->shutdown(host);
>                 if (ret)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a499f3c59de5..d996d39c0d6f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
>
>  void __mmc_stop_host(struct mmc_host *host)
>  {
> +       if (host->rescan_disable)
> +               return;
> +
>         if (host->slot.cd_irq >= 0) {
>                 mmc_gpio_set_cd_wake(host, false);
>                 disable_irq(host->slot.cd_irq);
> --
> 2.43.0
>
