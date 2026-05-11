Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E013FAE04
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508325; cv=pass; b=eiryZwd/P/3uyPxmrSxpvMeUrEVDN0gj2MOogjPjDjgfx3yu/SKXumg2OY0YR1MssRNNsc2Hdce0wjB0jaHFFAE1b8zj/ayb//Wog803H3M8J94coj54sKxcRTy/M+bouaEMcyflCnO3E59elk7iR8mgWGTgx6IEtX9jH1VYtTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508325; c=relaxed/simple;
	bh=FyBLSBZ7hNhVkjO/zSnSGEvlOg1Vr2+XpoAgSkY3z8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYpG819sxeaMg+NUSTrG7Zz4g5I2VFYcPKzun5+CXH54WQC0ZK7V9XnVd7GltcXs4Ge1jccKwary/12leAtXLrqRaS/lqg+ph1GkazgiRkMV+CF28L2NDM6yyFPXRkNc5BDwCZVY3ahP+ubRMElHQZPw+6LuZFCja2dTFiSN554=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qd69i+O9; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qd69i+O9"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd5c773ef3so43099417b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 07:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778508323; cv=none;
        d=google.com; s=arc-20240605;
        b=QiNorqrQULyt0ii5gF2+We3MaA6fGTxyX4UHWwdgD+OyOwLa+4CAxRb6juCc+CgQ8z
         vWprO8Ulsb3jslUU3RzYef9blVvFU3mNgjFumHiJwvy6PyJaGO/ZPt9FaJXJFo02+upx
         CjnC0HG8EcQssjKyZZCnws3Ooq56EbtmTxbkmFdm1NmZO7mJlgCMcvkf7UPTU+ZC1Ttv
         q2q/ZR+Q7Y5eJO0nmfZ7QVFMBd1Dsd29acM0gtIFmdEPSWHDSaXO2tHPU7zecBMB0RYt
         HYAnaD+xKzCXSMEmfNNNgd2dvSqp+h0Q6vgmDDcOv6YufP9vokObKFcC4oUK2JpuEnmE
         nsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r5NMXAS4+ZKW+xqccXrFy4JcKzWY5f2WjQmSFVnrvmE=;
        fh=DfloEa4hRRL/NMcq+EdWLdD5gt909D3PFG2NXpghhXY=;
        b=ke4Lbj08BtvBCTLI1fDzTDrirJQg+oEcOkK3VV7BJ7lUgHiC/rN/1SSmWdPpnTrD8I
         c5KQwbJYy+jPELIxY6itGHIDuKtD+uLRM7Lq2zHBvmndLbEUWpewcMkL5OLEkY2EbUxM
         lNRc9bKx0bKb/6Or6ghUgeS9HjB6H6Ut8/ADsfOCtKqjGAuLvsN17JZFxZlsov0gc5i/
         jq5RKWJq1Ow7bss3xpODKKqf88vJN7Jhepd38jWsZehc6Ae17WdVAQweDRx65JRKHxK7
         seKxxBF+rDuDpbZvB0lEda7ya4eW2cAHndoT7fom8HbICg7jMVhKAbf5faQpYKD7pzV3
         s7zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778508323; x=1779113123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r5NMXAS4+ZKW+xqccXrFy4JcKzWY5f2WjQmSFVnrvmE=;
        b=Qd69i+O9ADvp32Pxkbh+QuMdpJRyaTf3Un78PZ/s6vWgZ8ug4OhUoTWQ/Utx0c/zII
         fND6wQzddTvdUz+6onxOWLewONrQAejB1PFF5HTJl5KObGWJnzVlmeM2Rx8IaeTuWK+M
         wdZzZoV5OwebWsAZ2nCX9CjukmglqF4m1ntgW45RwvG/B7ey/DuYpaevV+lzHei6EJqd
         12QOcoGtYK6Ay4Crr932oVQG0yyIjed+MnWU+g1MCiORbHtX4cEKuCy13lmCmUtlButd
         UwB2dgXSCUBZ5u6QiCHZrytVmPryf8He4x/L79AGHBCaR1PAfmjryAzZB7bCmTfyp2ns
         l5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508323; x=1779113123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5NMXAS4+ZKW+xqccXrFy4JcKzWY5f2WjQmSFVnrvmE=;
        b=nz0O9cUPfyvhMeP1bsrlntcoOYp825h00UQEatQdE0MIeL6/wbtOYbi+XNqe3tX3yv
         Ix+BgQvVqSbmN20SGCFMF9h0kgaZ73qrO7PJQwGP/IxNsMOR4H8bKLGxz/6R5CFJCVzW
         2o4Cjo8s5krAmN2+cvIMFm9yyCU+32+iCRV9+LGEzCbKxS67OmAtSaFMbBVBpsAfr7Fq
         yvNwF3Zef7jxppWzuxKt/J7zc7eAdpW9GZmGNoLuqbg/BJhHwzvLIKxQogfuT0C/mi9/
         qKBDy9jkR7YWC9Scc8N+OP/dhviNIpZfoDWtBK+SkH78bRSxUIPj7aqCif6EqYJP0IGN
         wV3w==
X-Forwarded-Encrypted: i=1; AFNElJ8Ak29xAqsC1q2q3KhuXUK8pBU7LAwozlj0Aig77GGM1kkdWuCOcEkEN+JwQuPPpBGCtNWzMzzjq2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXlYIi0aMbmfeP6QsqPfSp1duSMhppAvw8xLPjgeQAzjqFlRI
	C/LLNH24YD0NTCIDD1sxq1nsbdbHt+KtULcgk2eC0Z98Tzv7TkEsILzmRnATyMHYkT3WQNm+aNC
	xWxlK2riARP9mXmTgAeo1qeWxjJ5nH7ssDjt2cIBH7Q==
X-Gm-Gg: Acq92OFFoBmWSvalJVdVjMsAeu7gIc9PxfjuFJSHlN/R5BT2ewGs2pXdLEiIvE8vklD
	rMmCmv61lpANEDQvTqM2dww1o3DeYX/e4oG2V6bgIQkuspG3UXxddSeSVeUCSK9xI8EVGYtlXz/
	F+gtLDjZWiiA1OdRRXJFOaMeorEU4EywfGGFfPzKLPYxIGn1ILMP0uC1twJtjFktpEpCOn8U5x9
	8LpK4se+lwscbzI8TtlNRc7pgtIPcoeHpAq0wQMdGyMv0QQ1voC/FP5b3SLgYVPKMu7iDdJddrs
	JW/wop4K9mq1e8yPmq8=
X-Received: by 2002:a05:690c:660c:b0:7bd:6432:daa with SMTP id
 00721157ae682-7bdf5e9d4d7mr253386017b3.27.1778508322803; Mon, 11 May 2026
 07:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776080528.git.sean@starlabs.systems> <95a293902585bd43c6857b79bdcdb8be692ff687.1776080528.git.sean@starlabs.systems>
In-Reply-To: <95a293902585bd43c6857b79bdcdb8be692ff687.1776080528.git.sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:04:45 +0200
X-Gm-Features: AVHnY4JEFLkDhtjbzsGFfUGYFgE_s22UpVwHZIgmGXAQCxyohGxow3JwqZ-VRJs
Message-ID: <CAPDyKFo+wJ3LZ4hFj0WqKpjfcioXkZJ94gtDO_Xbx99=Lyeujg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rtsx_usb: hold runtime PM during transfers
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu <ricky_wu@realtek.com>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-usb@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 13:42, Sean Rhodes <sean@starlabs.systems> wrote:
>
> Hold a runtime-PM reference across bulk transfers, and mark the device
> busy afterwards.

Why isn't it sufficient to let the mmc host device (child device) and
its corresponding driver to manage runtime PM reference counting?

As soon as the mmc host driver is requested to power-on the card via
its ->ios() callback (set to sdmmc_set_ios() in
drivers/mmc/host/rtsx_usb_sdmmc.c, it bumps the runtime PM usage
count. Therefore, the usb device should be prevented from being
runtime suspended as long as a card is inserted. Isn't that
sufficient?

>
> When runtime PM is already in progress (e.g. from rtsx_usb_suspend()),
> avoid forcing a runtime resume from within the PM path by using
> usb_autopm_get_interface_no_resume() unless the interface is already
> runtime-suspended.

Why is this needed? What problem does it solve?

>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

Kind regards
Uffe

> ---
>  drivers/misc/cardreader/rtsx_usb.c | 38 ++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index f65acf4d1164..c8badd0db87b 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -12,6 +12,7 @@
>  #include <linux/usb.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/core.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/rtsx_usb.h>
>
>  static int polling_pipe = 1;
> @@ -65,19 +66,42 @@ static int rtsx_usb_bulk_transfer_sglist(struct rtsx_ucr *ucr,
>  }
>
>  int rtsx_usb_transfer_data(struct rtsx_ucr *ucr, unsigned int pipe,
> -                             void *buf, unsigned int len, int num_sg,
> -                             unsigned int *act_len, int timeout)
> +                                     void *buf, unsigned int len, int num_sg,
> +                                     unsigned int *act_len, int timeout)
>  {
> +       int ret;
> +       struct device *dev = &ucr->pusb_intf->dev;
> +
>         if (timeout < 600)
>                 timeout = 600;
>
> +       /*
> +        * During runtime suspend/resume callbacks, avoid forcing a runtime resume
> +        * from within the PM path. The device is still active when
> +        * rtsx_usb_suspend() runs, but usb_autopm_get_interface() can block when
> +        * runtime PM is already in progress.
> +        */
> +       if (pm_runtime_status_suspended(dev)) {
> +               ret = usb_autopm_get_interface(ucr->pusb_intf);
> +       } else {
> +               usb_autopm_get_interface_no_resume(ucr->pusb_intf);
> +               ret = 0;
> +       }
> +       if (ret)
> +               return ret;
> +
>         if (num_sg)
> -               return rtsx_usb_bulk_transfer_sglist(ucr, pipe,
> -                               (struct scatterlist *)buf, num_sg, len, act_len,
> -                               timeout);
> +               ret = rtsx_usb_bulk_transfer_sglist(ucr, pipe,
> +                                                   (struct scatterlist *)buf,
> +                                                   num_sg, len, act_len,
> +                                                   timeout);
>         else
> -               return usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_len,
> -                               timeout);
> +               ret = usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_len,
> +                                  timeout);
> +
> +       usb_mark_last_busy(ucr->pusb_dev);
> +       usb_autopm_put_interface(ucr->pusb_intf);
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(rtsx_usb_transfer_data);
>
