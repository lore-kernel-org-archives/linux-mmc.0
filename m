Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C130B53F
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108871; cv=none; b=VxvsJCqBarXzLCRIBVXuIfnvNrLx4tgkFLE3XDQi44YPo6yGfpNfjKhc0S67Jebg9Yp6sqbuF0WAkhyEZvcgeziDjhEZAMHlP+4kqgbf5M0AH5smhcRPCkfIhRFxNAtGpW1tdcR8eQg8ovyX4mqCpUgc12MLBGVH6lilb8AWwqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108871; c=relaxed/simple;
	bh=ykdIkvx4cqaj9RPfNM0pafXHT1sVc5JnrzlKxZNQbbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4B4zUi5pUifzP22oAL9neJUY+3q35o7XUa778P4f6A03j6CfHNOP60ay1ruvzR9YpMP0KRWStwxluBSfvpJ/IOwLYXEymeptSRlWTuWApFUcwbarEwGVCpNq+AhJ4NTEuiBApZZHHL02cUl7HxQEYdDchTuyzsuSVsV5ZFOlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=riErROMm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riErROMm"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so10800952e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108868; x=1767713668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVOyprJ3Cj2YRlSR4vH7ppFe43eLFh6BnkA7raxZ3uM=;
        b=riErROMmGevHzMUX10BR01/vzWKZWplkfJIe1DZCyTF8a3u05JYXrmdn58p9gqq6TW
         9Y8izmofrtcOo1spwRSYpzVRriZa87c7I7CxepYZNcZX50VJyiY5YsPQfMcXmmWxNTqA
         7iZnt4SuIw15A/r+WHToy5nGecawnIHXBnYpQMzJQHY8lJWSYjWkfyBHqwOsbgwPxXUo
         F0o/2r+8sp4gsrwsZSfWPgM1xaBEToMipx9ygrdq3fGALu7HjzRgOj2Qn970gz3XOk8+
         PK9kPnol3FfVNE7TawaTc8/Ku4swkbKWn3aXleO9eugGu5LG7Rvq34X+jytlrno2QAc+
         scpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108868; x=1767713668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVOyprJ3Cj2YRlSR4vH7ppFe43eLFh6BnkA7raxZ3uM=;
        b=XZy2S1dyWfiEeJh5VsNcHBTTnSS2OW2j6HhhVzlgzWYMd47yyylYOyR3mm5olR/j3H
         i9KaYeh5Jo41lKDbkSEenepO7Qr+b65cmZZ9v3gEv54oAm07YgeYfKZl8HxF1a3bvYr8
         sxYNcNt55ki55ZnaW8Pyp7Isnv1W3NLAD4PM4V1LTe/PhqgPlpLeUeM26z+R3SYnkorL
         LJ/WfbyeMgNOwZqgvwRQjc2fFXqr85UcHcGVTW6U4/y2X9qRf+HIIcW/SiTgxl45jaxP
         Mm5X11FRLmNWzBdKXMx8FelGasZuo/gaAidC7cyiprgj+htjYiJ+Apck8xWyWhPXx0Yz
         vG2w==
X-Forwarded-Encrypted: i=1; AJvYcCXsOZv36lmQsorOn49haeAFcCP9prUGRFl5ELd3DxvICuneR5Y1DA8dVT5H3DxE0hS/rcMim1Gf2F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QewUr+1KO+YCtEgsM7JsEzoa9ukZ2AILBrWfov2U5XDV35oS
	e+sxtoR9JF9f0qcVMYpUpo9NodEb+dYzgvH7aT5xSHeItdJ4UtN0/s8fG5jrg0ZiWErBOJll1nZ
	TTDVqSpukf2t2Gtobf8UiOkveK6EW1fjeYsbRfC3adw==
X-Gm-Gg: AY/fxX5TDQ9Qk+fGzKv6Qw5LfiTMFhYkpskMBfk2JCl7Wmig6UzjAM5YJ7oS3RBv80o
	el0vA9nagzZqZV2XksPwPR0b4lH7DI00C4hdID2PgERIiO/AB+k0zs2pWeM6K/zYw9JPAhrjFaN
	ZTIe5ajosjVAhU5Z/6ATnf06aO6azhfUqvdZdqL2gL0V1rJomz3RKMHDrbRtv1lSwwKJBghrR1j
	tTvbw1jtus6YexyDbbhpWLI0BowZXtpTl7wdCJsYtLzDhl4Qw9eLEmzd8kSkgGDyWXFzHRR
X-Google-Smtp-Source: AGHT+IEdpLJulaMagiCntHq1v9KxSgC049v9J3ss/UBW2tRdN7RsCII8vnj/WhdRIz5aTHz6WELoj9cCY8mYimOF/RA=
X-Received: by 2002:a05:6512:b8b:b0:598:8f92:c33f with SMTP id
 2adb3069b0e04-59a17d77435mr12093495e87.51.1767108867602; Tue, 30 Dec 2025
 07:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1766387485-205480-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1766387485-205480-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:51 +0100
X-Gm-Features: AQt7F2oM5uh2RRoQE3AlSJVcnjGKNpD0QEAOcfCTfTFC010Q-hSrZ7pgui_gOls
Message-ID: <CAPDyKFrAyQY1o0x_-ZqxfwACZHhDPqiSWCBfLWGtHzX9fUSnTw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in
 HS200/HS400 mode
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 08:11, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> When operating in HS200 or HS400 timing modes, reducing the clock frequency
> below 52MHz will lead to link broken as the Rockchip DWC MSHC controller
> requires maintaining a minimum clock of 52MHz in these modes.
>
> Add a check to prevent illegal clock reduction through debugfs:
>
> root@debian:/# echo 50000000 > /sys/kernel/debug/mmc0/clock
> root@debian:/# [   30.090146] mmc0: running CQE recovery
> mmc0: cqhci: Failed to halt
> mmc0: cqhci: spurious TCN for tag 0
> WARNING: drivers/mmc/host/cqhci-core.c:797 at cqhci_irq+0x254/0x818, CPU#1: kworker/1:0H/24
> Modules linked in:
> CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0H Not tainted 6.19.0-rc1-00001-g09db0998649d-dirty #204 PREEMPT
> Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
> Workqueue: kblockd blk_mq_run_work_fn
> pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : cqhci_irq+0x254/0x818
> lr : cqhci_irq+0x254/0x818
> ...
>
> Fixes: c6f361cba51c ("mmc: sdhci-of-dwcmshc: add support for rk3588")
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 51949cd..204830b 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -739,6 +739,13 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         sdhci_writel(host, extra, reg);
>
>         if (clock <= 52000000) {
> +               if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +                   host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +                       dev_err(mmc_dev(host->mmc),
> +                               "Can't reduce the clock below 52MHz in HS200/HS400 mode");
> +                       return;
> +               }
> +
>                 /*
>                  * Disable DLL and reset both of sample and drive clock.
>                  * The bypass bit and start bit need to be set if DLL is not locked.
> --
> 2.7.4
>
