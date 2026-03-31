Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF63A6B93
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952061; cv=pass; b=TBFcYW4wppTV2Vb3dYOfIjIyXE1VApCJYMjTXJfWpln+xwz/tiBUvZqoxRu54OGxVm3VXyWq3F8/HGzKjiL4K71POLV2b1gdmBxz7QKlrEqCyTJ218GOFQhcZ1hRq6z09cr5y1ezKkk7JaTRtxu+mAV29WxmgnOWYZdy8kdwZNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952061; c=relaxed/simple;
	bh=x+hWUIPclyR7BqlGWjp+2Cw6RFCkNpm6eMx7G4FvPDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpdiqXJCAMf4vCg6P8dhAbIZzkOQULJP45AvTxAt7ubkEeH9ssMyteMDCWyKC4Ch4C8mCqVhz6EWPP/s/jmumV+HrqvWySJowwifxnWAKd1AkufcM6TBRPzLPdfXo/syKXwMwuI2RIzSZhHSCopiItS030WEIWTSi8f20DARBj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBADqEWy; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBADqEWy"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so6505707e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 03:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952058; cv=none;
        d=google.com; s=arc-20240605;
        b=TO390l7DGKGIvAWzTyKx218nb4fQ/qanZHFBwWdmZO/jiRBS5vxec+8Opv5bk3X1sV
         6dBaWhbSy7NiOBFu7HmzbHxFd00gatl/uGRFYRLuDxKCmyiHgtSv5K5edQf+AGOP5WjO
         9lJcRfyOIUMYs5QH+9hM0ujlsPQsGmNfPKF6/uispcvRE5jRRvDpeZ9bSPCLgTU9fgLH
         HZ6dA9UX5PB8U07J3U1zEk4yzt5x40r1DCINWaLBnFARodCQ65z1hiQF26voIOVpf7hN
         RxfBWQiPTBlOIcRQvk65FM7IF4p20hNDHEq4gl0ClgkMGRk0/3ZTcjLhZjVU5vb/KM+K
         eNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mx/+M5uRKYIghnrRmqlR7yaaW+6rwphedvm5LQykdMQ=;
        fh=6V54VY1pZjU7PwX0NVbw8/vH/OQCIyL/CxCqsAkH/+0=;
        b=CQbR/7/YzcylfPaH1CCjjjhvFQDkzieMimCub7ySX/B5Jdqv4897fVrtA1e7dEKWG7
         eHYL9E6COvEIw9N3B21CTy6Coc8TJ+V4XYHq4+yh967wWFPCV0MCB3jKoIXYK5lRhfnd
         FZs0VMH9RVcbHMzIi9Ynn/Um9+4LRLMVs3L72Z3LDfWHMq8cDmxNdvpgY4hSXalLqP8Q
         z5cyB/4lGIfSImf/tpvMI3n+kvTMFsCGMyfBVgDIDmH+WzfJTgR3q3oqifDegplK2bpv
         UP9Po0WPgxdo3atQ9EVuRq3K0SN56e2KgZqQ7+QbVUH4SJ6jYvE5jSKmaV34GSs9cYhl
         G6ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774952058; x=1775556858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mx/+M5uRKYIghnrRmqlR7yaaW+6rwphedvm5LQykdMQ=;
        b=yBADqEWyvu6kWKxswsWYb4rfsjbY9TnaWI9Rftfd0FZVeZl2VnLuhFojT9kGyuOF2Z
         dZYeUw/TbFiUqemUlcymIg+XYRL8nQxcIRw4w6fSRPG8k7mU3g2xq/eyWLLvmq1LoZqP
         j/H6bNTRHAiTFjxiUi1hexz7MA18GXakHTIxOhUIF1THoA6WJ3fsw3uZs5oEALk4ktmx
         yo1Y7yqgKgnUkoGOEdsUNnD0j3THyyKkLmeFQcEsAsPEtlJKHAI3Sgst72xDU5oSaDoo
         pAPazmapPAcvNk1Vxu4th5Qzu3uEEc489clOoqMzAFA2BQX0LpMHIjEyEaM00RXzzhMw
         764w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952058; x=1775556858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx/+M5uRKYIghnrRmqlR7yaaW+6rwphedvm5LQykdMQ=;
        b=tZEiG1mdJ8NGTIQ1v+y1nTg7Bji7BTZU/ttsdLs8K7A8xblB7MI/cE1caxHzCWoat8
         G+9anab+wM1hBqX2nB6ytFYQH3+MzHd4LJOVC2gu4TMcGOBWUrugscZNgUKzmH7B7ccS
         hH2OAnNJd3eENnEqpXQsEzBMgCaFpgADs6U9nQZADQO7cUYlLg8uYyX3DLFb+07vVLq3
         5gEZhfwvqHkSCogXhqZUdeRsblifqg+kxhTNKJT5/KS3W63YRa4etiGV7447ikkgeJkN
         5SHRb3VGONFU8kX8W0Cv2vM74Ws+SVUr90O6kqdRrjz3VLvuniGOdPCTJnEtFhFf2i3l
         aF+Q==
X-Gm-Message-State: AOJu0YxRgt9O/If69S5ijaaLO6jEkQgUgXtW2OoMz1wMgW7wmKJqEBK9
	acHM1xOpHOtWQRL1a6zlfw4PWQe4TPdGGrp/Vz5C9Okrlie8gxAVAKTrvB50z/bIFOVjve3BcXF
	38iO7OpPKji1fYwyzhtuz4RYC8XOu5o5U+xcWDWJwHw==
X-Gm-Gg: ATEYQzwRxbIRSGlZVYY+S48JVWdokZUZyo870TrXtpa866hH2gKLCxHUfIwrYQR/InW
	iTueBCAHXB0dvWb/cKDgeyxp2HDaL8toE7MdMhwzljb67HYUAZUXvm4qjhZCkRvXn2rLCjLa6by
	1dDhLBUppV/f3pxax1nZuhZg7clkSYKoqK4rXs/xEKxBVIcQTvtO5fNDVcfpQxyXSR1/eWl79bv
	oLRMhel3QCjxpyRRLWv6ah9/VAIxdvTnj0HMWb1N2bD5yb6MY9fyeoNV5jSF/xzjvDudUXEEmjc
	/1zJFA5I
X-Received: by 2002:ac2:4307:0:b0:5a2:c05c:1199 with SMTP id
 2adb3069b0e04-5a2c05c141fmr148052e87.15.1774952058111; Tue, 31 Mar 2026
 03:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org> <20260327105208.1310739-2-johan@kernel.org>
In-Reply-To: <20260327105208.1310739-2-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 12:13:41 +0200
X-Gm-Features: AQROBzCGShN7LcmS5ZDY0r5zMcz3ndnLqxaBtBqvP89b7e8uYTHkjABOijCfaBI
Message-ID: <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
>
> Make sure to deregister the controller before dropping the reference to
> the driver data on disconnect to avoid NULL-pointer dereferences or
> use-after-free.
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Cc: stable@vger.kernel.org      # 3.0
> Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mmc/host/vub300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index ff49d0770506..f173c7cf4e1a 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
>                         usb_set_intfdata(interface, NULL);
>                         /* prevent more I/O from starting */
>                         vub300->interface = NULL;
> -                       kref_put(&vub300->kref, vub300_delete);
>                         mmc_remove_host(mmc);
> +                       kref_put(&vub300->kref, vub300_delete);

While this seems like a step in the right direction, I don't see why
calling usb_set_intfdata(interface, NULL) and assigning
vub300->interface = NULL is safe.

For example, some of the workqueues might be running a work that uses
the vub300->interface, isn't that a problem too?

>                         pr_info("USB vub300 remote SDIO host controller[%d]"
>                                 " now disconnected", ifnum);
>                         return;
> --
> 2.52.0
>

Kind regards
Uffe
