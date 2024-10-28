Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03561D63F1
	for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115872; cv=none; b=RoPqeHo8TGCoG/SN1ion5LuCW2woiDu2zgmzSUdygZSUzqesN+QF4oCQAPu4CpnUaGVXWXG7jis7doR2X6A6h+qW3rCqLPSVsMJTrZnTcWMtcUwhtdu7FlWjeleBEVNcfEqHJn9l54qVFP4IgyruqINHG+05kCHEnXA/AX0XZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115872; c=relaxed/simple;
	bh=v3yjuR/if/Qk08YvHm7Za9TOJuneF2XX7j+JN5TSp+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdRAc55i5KGgae38iqIw8M4Mlw2xE2IrFUE7NfDNZ5CYVyJSysT54I+DQZnoK8zyhOOSgJ/fAKo+AOvqvaj2ySkqvBXSjdKo1nIkhQ7PlSt70XVRju795QtFc2eRvcTc3bbSBnlYfKF7SGbPjaV8hGzVaYNsy2E6uojdA43lfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlBi5E3o; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlBi5E3o"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5e5c43497so34486307b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115870; x=1730720670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w67vg9M/PUfllFizpdXiSM7HQlThvR5jg0fvSeOpX5U=;
        b=rlBi5E3o8u6RF9xXcM4Z/PtRZdaq6cPNZhPayq1E2gt/1SBrbUzkzRoVDp3HmUkQe9
         vBSDU1dflKbs5F7uE83P3kQBgD3gCmemVfpeF2QA0n8DObk8UAcNMuckD5hUNIsz7B/B
         8sEOyuGs00Cku/0OePjAwlu2DI2lFoTYF6SkiyjEGFxvRLM4aJOHD/ZRnNuSjOvx4D6Z
         C1stew0KywHJnQFMXouD83txW8tqiFxBvNKGjmeSy3t+BX7TLEwPGJZDt61/wBUg0cOp
         42YDZ1HSs97BAeFaCZ0tXvzJeVgZnW9fuzpR6LWJDkSV7Y0naOWaJ3ZUv083naGlTfPv
         OOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115870; x=1730720670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w67vg9M/PUfllFizpdXiSM7HQlThvR5jg0fvSeOpX5U=;
        b=iulvEgIQoVJ9yBSDlOWruDzuMYkJQ+JyFekWv8Gqv4TfLF5VHKQICCP/6TrhQ3D0/v
         EGluh2jI3KpFcBPhtRSPRR1WMCvWtDOtJQ7U3XUXUMAPJGPnaSqHHbGyvh0IpLa2qYSr
         fE3DgMwmx9WWdR6oyj4YXArKdP5XfxGiaszpx5aTcCSVF9jjK8PjTbpRkT2p8thwKqtI
         gYLn4x7yDiYyCUQcO6QKDTt7rz73ozKNM1UfN28ZZgz6EltllWS45NuCQ0qkCXF05Smj
         OvGQH+W4Gueu05vuu5cuzcCmp2cJJIOv6CjP3kMf9a5CthlWJ3tnca9BdP5DikGwfQZ7
         rh0g==
X-Forwarded-Encrypted: i=1; AJvYcCUanJsbpE0hP8YLa3FRP/7y35PcN2tJoqbJ5FftI50fekgZwSDEybvC882knOqryy5+qrEwoGIu8uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzJ7RcsuDm/goi8xE+HBU73zoZSpFB092U089baAlZSac3j8U
	crOyBKIc1IfSijVmR0YKoXLbnvVwxptznTB/5IBfcR9Ph+oqkHbDRk+QRlGm6WGCWQbUKbsyZjR
	4zbv4JdJEVAs+NrMoEymgiMETnJQoBMvfwyorTw==
X-Google-Smtp-Source: AGHT+IF26G/KW53BnVmsufrZN4oEUN/Y3tFfc1+XSv54Nwo/CrFvFba9ljoAEAfzBRZISL4FpyAIkN8L5k8Ymwv2dPg=
X-Received: by 2002:a05:690c:46c6:b0:6e5:a431:af41 with SMTP id
 00721157ae682-6e9d8ad6cf4mr74632897b3.38.1730115869914; Mon, 28 Oct 2024
 04:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025103621.4780-1-wahrenst@gmx.net> <20241025103621.4780-4-wahrenst@gmx.net>
In-Reply-To: <20241025103621.4780-4-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 12:43:54 +0100
Message-ID: <CAPDyKFr7mJPWPkTrtB9ORdQw0TtBDKM=B9g6QsKvUHRx1zDNxQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/9] mmc: bcm2835: Fix type of current clock speed
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>, 
	"Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 12:36, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> The type of mmc_ios.clock is unsigned int, so the cached value
> should be of the same type.
>
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 35d8fdea668b..3d3eda5a337c 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -150,7 +150,7 @@ struct bcm2835_host {
>
>         struct platform_device  *pdev;
>
> -       int                     clock;          /* Current clock speed */
> +       unsigned int            clock;          /* Current clock speed */
>         unsigned int            max_clk;        /* Max possible freq */
>         struct work_struct      dma_work;
>         struct delayed_work     timeout_work;   /* Timer for timeouts */
> --
> 2.34.1
>
