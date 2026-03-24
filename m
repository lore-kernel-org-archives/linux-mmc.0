Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AD3F076E
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354243; cv=pass; b=lLBcQtIkJ45srJIxqLqdARLUEVLTpVdPsZBiYApswI5lT2jM31m5KYVAUmc4MtoydhE4GQig2Y+GSjE+N4tk5KZAakZF+77L4m/DiYIlNfAK5kYzCwsUJT75D19VgyQeEJW4N/e0d4lAdQZ06qIiWOxXsqZPQSk72KNhDx1oubo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354243; c=relaxed/simple;
	bh=ME8y0XpwUNq4qr+0EtqCuTDiJ69UNmzYwocZMg5TGdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFByW6wcjzyrEzzfw3qu7BSruYhvr41zqmIb2IhFrZIVi79gGLMILmpULBWzC1eowheiUklAF1aeBn68u2rgX4O/o+46SZU5eT/1qjwNDPZFPR1lyEe39y6OWdzKr+zRQWgIPd8+KMfDZwexVBMp4g3NbBGhMPXQsXxmk9oVZYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5Q2A3yF; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5Q2A3yF"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64aedd812baso1210557d50.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 05:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774354239; cv=none;
        d=google.com; s=arc-20240605;
        b=hNjY9xp4XYWRhP7KE4RcTuHfYSGOWkQrC+K+udcvmYb5I+Hv+DNNIIsKMcTqxVbKUH
         vcupWhv8NpK7s8RDRWk9rNwHtBLRf9eVYA/+4bqeueuIKNkmFFk8m9ZaRxeeCB502kWL
         NvyLcSCQJoEXUpmw3n0g2HR0p23n+6UGj9qdsPr6AdbpImFk5Rekm/vsoWvsP6kDQkKn
         Dm4UYKmrxdnNzdqTZ9wcAeKKAzAlzzL/TZ8WIA8ojJpiDeg0ZWUUaDbaV3jptIqciGzY
         uBSaDqxeg5vPOIQ6DSUTXDY4qISM6d1ON09DVLRbbHiGE8TWRlb2JBRpNvl8LHMT1+SJ
         +nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZSEKLTV9z4Z4c0Sy4oh4vQKScIehcuUk97kkvZj9O7c=;
        fh=JW/9lrIuGXtAVA4oR++eJbBbIoz0rcDBUdH8X/gQbIY=;
        b=I5plChlDJCpNxVInhG/lIlz6hV8oMz0oZSATmqm+kK6uwx0jejk+fXWMMxxbKc2CLA
         XLW8NH3YYDKYXn5MIz3cERa9cu3PnCR6yOOpAegcJYJBeZilQpmr2qwrX0nGz5ROzvm4
         6BgSSNWS8o+mNAoYDpZaxsCpHzYkST+G8I9znSOalSCGF/Xz1uLcXNYOIilm0yIuJdjK
         n5hJTvwZ6A2H2EspnU/erGTpTZgwJx7eXMsLY8fVSoNZuTmziykJR08MHxJfuEVFt1JY
         grFmPywyHf5nmVK7SDuBV42e2yQyXDLKW/SMP5BT+SkiB7DO4i5eg6tx3V1GjJ8bweVe
         PWJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774354239; x=1774959039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSEKLTV9z4Z4c0Sy4oh4vQKScIehcuUk97kkvZj9O7c=;
        b=J5Q2A3yFzjOubI38Ynoql5olbAyiEmuOdqpUFUA9CnmAEKYBFBLDxCNqkogoyErT7h
         bSM5E+edDyKxkwM1WD6GnmVcFgyc5F0jHmLu2r1hq77OxgsFPlxRSPfVZ68PHMnTATxW
         PwYXuMGeZWvfRqe917V4D8xZli+dUfY9jgCG/LGReDr+D75bDF5EhHMN880xkRvSFhAL
         pMYZzxImBJ4zHMnUtDCsT6MSKfKtU+X179ss3TK5wsJfzaME7wDhvYDFgJggjdGTVSVJ
         sxOjvWi1LvTCIdWRx1HzX5RifOIjJrMzcif2AoDFfRPvysxjUR9cncUjnokezOhr3OM6
         pMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354239; x=1774959039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSEKLTV9z4Z4c0Sy4oh4vQKScIehcuUk97kkvZj9O7c=;
        b=kJnX+Cpp0mCJ5gD11Uv4Q074dPJAclBPayJZQp4OVCkpZ8rvta68CQ4RcI1jaBm0DK
         dIYcQDam9ycinopFTCpJ+IFiZkq7aWystKe8WkPZUGLQQ0ZgZOLBgoBV1diZvZY94+SB
         oFOPv8dIYqVJbpPA248aQJD0ckB5zMRZr2iqXuUs+T9C2Ar/xIIMdZn7aa/4+QlbEUS/
         iTWh/GxaKJnBzf7RanFossw7zOaXEuX5dxvD2YgpOddmJzeCi+JwmuMgnucOL30S+Q0N
         kcJMY/0UJNGqQdRGkpEVT2CMzoK11tiCmqXnH1Esee0R3NTVJRZ5zxMarEOmHJlQAZaP
         kyWQ==
X-Gm-Message-State: AOJu0YymWakdUCyd8X04pV1C2rIF4LlDeP9IncXlTjimsqWzKLBf/ILJ
	06QG4+CbiL/pjpPn00yRdrM/pMrU8KYgLrwyda1AiI39lNXFUihyYksiHyx5Mfxv5hXgarFYQHr
	ZUPuikB9Tuxnf4om9DhlWFbeqPNhU3QDPXon8Kc2eKQ==
X-Gm-Gg: ATEYQzyLfbkwgbYdc6fTToaXbky2zRf7a5Bjc5qaQzWdCWTVlxRTpYteKziZTvVQ5F2
	5Mn7WmkC3cFQt76tXoNa5Eysw7cfZniz1htQNaB87ciSy4KxNzLHuhK36YiISZjc647PjEL7BDa
	sKjlpnMd5CENbv/+2tYQGpVfDFaxS9qypATU0UJpaWJxH70mZT8BxCl8uXmPSwffKunHSeO8rHr
	bYwpeNMl1PQJcSMpuRDCyqKXbu6gch2UD2ELPld2AhylV0wpAVwdHnH+dK+VNnDQQBvLWnxIQgZ
	Xgo5c4A5
X-Received: by 2002:a53:e198:0:b0:64c:a0cb:83a1 with SMTP id
 956f58d0204a3-64eaa6cceb4mr12884224d50.26.1774354238442; Tue, 24 Mar 2026
 05:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-6-sean@starlabs.systems>
In-Reply-To: <20260312121559.19197-6-sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 13:10:00 +0100
X-Gm-Features: AQROBzAnscYa8la8cWUxd5zXVJ2M7wbuDFLlmR25wPLcmDYWEmUTaez8dagKFA4
Message-ID: <CAPDyKFqdr3cwqxykESQ47ednC_RAsvLSjesTkt-XhsUPR6XJpg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 5/6] rtsx_usb: hold runtime PM during transfers
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ricky Wu <ricky_wu@realtek.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, Matthew Schwartz <matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"

+ Matthew

On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
>
> Hold a runtime-PM reference across bulk transfers, and mark the device
> busy afterwards.
>
> When runtime PM is already in progress (e.g. from rtsx_usb_suspend()),
> avoid forcing a runtime resume from within the PM path by using
> usb_autopm_get_interface_no_resume() unless the interface is already
> runtime-suspended.

Can you please clarify the problem further? It's unclear to me what
you mean by "runtime PM is already in progress."

>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/misc/cardreader/rtsx_usb.c | 38 ++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index 1830e9ed2521..5d818b632788 100644
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

Thanks for adding a comment here! Yet it's unfortunately not clear
enough to me what is happening.

Can you please elaborate a bit more?

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
> --
> 2.51.0

Kind regards
Uffe
