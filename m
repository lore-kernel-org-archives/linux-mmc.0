Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49623EDAC6
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952729; cv=pass; b=VAczQGYMQCV24rDkaewLWfcmwCIhfIRJymS/d9x9nZoPKYs5X1EhsFNMJl75dsfBFnk8X1kLTjijGN6nX00RT8QMTvVx3uHI6o5gKQDNGmm0PQ9YPRRBTlHow8MpS/7lwrUdgy5mIy4bBNYkJWk7AHAZo7wPhKU2DtsBHUwgdxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952729; c=relaxed/simple;
	bh=0xZ65aEgS6XS5mPxZxPz+I09u2lkDz0qU/QCr6kni98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUvPvujoeM+iWeWo5iI7juIw9u6pbCVb8aIs8zKkWziKkZ4t9EfrrvKE5n/2mItQXZKlZSjlM5yc4N8GrWJFloS9Rw+UgO5CII5cGnMZHYgEg9ZKqodjnesr+OQZl0r5gVJDLq8wNLmX30/NJiWN2w45+Q2otbBXeoR1BPela98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0q7can2; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0q7can2"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so2028954e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 03:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952726; cv=none;
        d=google.com; s=arc-20240605;
        b=BGPIIqnW/uGKSCSmhfuq6n+RvdPTycV9YEU4b2eo/KT7DnlM+y0B2jkctVq80GJlI4
         xrRtQZZUQ7I+YaHi5flXn86UHZ03pa6jSQwaJn/BNzcvXewTMpqv+rij0OqyX4ebOOgM
         JtNewyZt68b2sSVjErZFi/oUP09FwO7fyU3KigwDFjQZ4LiCcZHceuuHBjjYFCiENfI3
         RLWYVS9tw+aulbShXiwBS0D2X1oWjZ54keG4dzqI0qjlMMn5KFkfVegFRowjYkUR1zCU
         Nj+tL1ieZkH0mwJF5Sh4J4RKyBoJyq9esMMMDg/hAwtsWVlNGIxjRXFfuEwZtPy896s8
         85CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XBIXQ1IvymanQZCLCIrI88ZGl5hQ8LVN5jZWed3Qpaw=;
        fh=c7vdrdk1dHX5jbw9IzLE07koVLHt3qPOhiXTF22KYyQ=;
        b=JIpJIzjMRBYXK9RjR1tMEjaYMDT9/9bCTVjp83Cyjp7nseXXDbEeW4h/LNwjbaS2j8
         jYehm2ZmCHOe6xwY9dzQ57yHMKEeSsCPJFrTab85X4GfNTMfTRbOcs0T3texKzTb9EKh
         0em7nhTKnLpsiSQR4T/Pjlvw6NGVqxkx4bFjvxr/CTDdFWBgG+44rpy+snsf5yFIQ2S6
         HRWCmhCOyXMLK/bJHzI3lD2XZNe3u2ydq7KkyrRQoUORHucGi3a0S3s9WP7bjUBvjZ50
         Os4NYOpiOXLOkrXXZYVoxLAc3easa8uDrBZQe3aHWZOm9OqISSCBoNc+2kFLLqSHOgBK
         KsIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774952726; x=1775557526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBIXQ1IvymanQZCLCIrI88ZGl5hQ8LVN5jZWed3Qpaw=;
        b=I0q7can2Er4GEjaTvJcJoio3e/OmMeWUqIdoJ2zalmOBjgyyr1Qn+28PoA6y5hfm7d
         jVJcYYs/03x6TAehpH7NM4oW/TKbbp3PFT9n1YMHLI0B1VizQkXqMw6benc3GfwcRL+7
         pePqKE0FNEuPSi/g/3G2amM++JB+IOyt1m6UNpuDoG/bPyAcDWJHZBACdMxvBMan0cmF
         pzm85rfYBfTTbs06VktZPolPG7owQe5Qeovb9RXODjLKrLZmsUHCC3MQ44CkGtYxbinI
         1766JtsyqQWKrq5JrhEpP9ELr9jMmTdZtE8MsyQineuOnyaYQAjdD+ISE+AyouSZEWqC
         KYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952726; x=1775557526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBIXQ1IvymanQZCLCIrI88ZGl5hQ8LVN5jZWed3Qpaw=;
        b=nb6AQwBLWWY5MqYasgUFkshfQ0AMEyN0J9+4plazuMZR20zBCPioCv6D5upeSQ5QqK
         4H0p6u48OCjNMmq5E6Am+MH5jqlMDORDJo7ek5p9aPNaikirpsWE+JzwJ+jYL76WpEQg
         7+XFB+5VnT1/vGStFsTHdLW6Wy32XiuToPzk1K0CgbhyfysCkvSA3UdARXOLgXR5ACnc
         PkX62Vz9qQyjfWjmRb3lkyDSKHgomfImNP1K3RLE3w8wMRAeqKDhZvjiIjx0KwZ/LwHi
         hxMkxK6UtpR/eb+WIxPTIwwB1Qa7cM5jTlmdA2XuUOwo8T8LJ46z9jXB3ieGP2IpaRAh
         9zLw==
X-Gm-Message-State: AOJu0YxjBwaGK3sYGHMzALxkgkQ1By1nRMRPuFDJKP8VFPc7FGYXd+5W
	YuE1p7Lr/EV0Mbdk7ukGmgAbPQzcFUwBlgWeZeNTdUERdX1MlsOWGtRaTy9v9JW1dDbDnaRJPTm
	VykJ+IT2Rht/8nsUZNY+IdEHTyf88wgk6/S2bsuQ7mA==
X-Gm-Gg: ATEYQzxp4qRWWck6DvL6uLu8SW8k98elh2GlNduZQCDx5yYm8vFTZBq1oo3G3JHKuLv
	jgIpP2ZGxh13tIWbhx8gfarD8LywGui8bMuNcazByQGausyu1XABGHZpV6WDMfE6mqQmkBh/T9+
	mji9auoxE9yOsaMLoFzg4XUtzDApsMAVwIwvx/jQA+1OCRg+MzzY8dooTTm4VmD/9J8PRotUKTm
	oMfQHVnPfMTB6teAGM5WB/nuzLkFH1FVGT+ked5HxTPjJJYudWSgV6ZEYfu2hiBDymEVM+3wDgK
	WCbebJkp
X-Received: by 2002:a05:6512:1108:b0:5a1:1e44:8682 with SMTP id
 2adb3069b0e04-5a2ab9294a9mr4892116e87.34.1774952725626; Tue, 31 Mar 2026
 03:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org> <20260327105208.1310739-3-johan@kernel.org>
In-Reply-To: <20260327105208.1310739-3-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 12:24:49 +0200
X-Gm-Features: AQROBzAIIF4vqFpK44CPUhY9m2k50H9Tt7zGx_VCKe9Z30Qp-B8l6-4bTcnNwJE
Message-ID: <CAPDyKFrX2Bw_Ari-6kvSbSd=VsDh4bpxn5UbZV+eFChCsBE1kQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: vub300: fix use-after-free on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
>
> The vub300 driver maintains an explicit reference count for the
> controller and its driver data and the last reference can in theory be
> dropped after the driver has been unbound.
>
> This specifically means that the controller allocation must not be
> device managed as that can lead to use-after-free.
>
> Note that the lifetime is currently also incorrectly tied the parent USB
> device rather than interface, which can lead to memory leaks if the
> driver is unbound without its device being physically disconnected (e.g.
> on probe deferral).
>
> Fix both issues by reverting to non-managed allocation of the controller.

Huh, sounds like a real mess, but thanks for the detailed description.

I will defer applying until we finalize the discussion on patch1, but
otherwise this looks good to me.

Kind regards
Uffe

>
> Fixes: dcfdd698dc52 ("mmc: vub300: Use devm_mmc_alloc_host() helper")
> Cc: stable@vger.kernel.org      # 6.17
> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mmc/host/vub300.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index f173c7cf4e1a..3c9df27f9fa7 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -369,11 +369,14 @@ struct vub300_mmc_host {
>  static void vub300_delete(struct kref *kref)
>  {                              /* kref callback - softirq */
>         struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
> +       struct mmc_host *mmc = vub300->mmc;
> +
>         usb_free_urb(vub300->command_out_urb);
>         vub300->command_out_urb = NULL;
>         usb_free_urb(vub300->command_res_urb);
>         vub300->command_res_urb = NULL;
>         usb_put_dev(vub300->udev);
> +       mmc_free_host(mmc);
>         /*
>          * and hence also frees vub300
>          * which is contained at the end of struct mmc
> @@ -2112,7 +2115,7 @@ static int vub300_probe(struct usb_interface *interface,
>                 goto error1;
>         }
>         /* this also allocates memory for our VUB300 mmc host device */
> -       mmc = devm_mmc_alloc_host(&udev->dev, sizeof(*vub300));
> +       mmc = mmc_alloc_host(sizeof(*vub300), &udev->dev);
>         if (!mmc) {
>                 retval = -ENOMEM;
>                 dev_err(&udev->dev, "not enough memory for the mmc_host\n");
> @@ -2269,7 +2272,7 @@ static int vub300_probe(struct usb_interface *interface,
>                 dev_err(&vub300->udev->dev,
>                     "Could not find two sets of bulk-in/out endpoint pairs\n");
>                 retval = -EINVAL;
> -               goto error4;
> +               goto err_free_host;
>         }
>         retval =
>                 usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
> @@ -2278,14 +2281,14 @@ static int vub300_probe(struct usb_interface *interface,
>                                 0x0000, 0x0000, &vub300->hc_info,
>                                 sizeof(vub300->hc_info), 1000);
>         if (retval < 0)
> -               goto error4;
> +               goto err_free_host;
>         retval =
>                 usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
>                                 SET_ROM_WAIT_STATES,
>                                 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
>                                 firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
>         if (retval < 0)
> -               goto error4;
> +               goto err_free_host;
>         dev_info(&vub300->udev->dev,
>                  "operating_mode = %s %s %d MHz %s %d byte USB packets\n",
>                  (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
> @@ -2300,7 +2303,7 @@ static int vub300_probe(struct usb_interface *interface,
>                                 0x0000, 0x0000, &vub300->system_port_status,
>                                 sizeof(vub300->system_port_status), 1000);
>         if (retval < 0) {
> -               goto error4;
> +               goto err_free_host;
>         } else if (sizeof(vub300->system_port_status) == retval) {
>                 vub300->card_present =
>                         (0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
> @@ -2308,7 +2311,7 @@ static int vub300_probe(struct usb_interface *interface,
>                         (0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
>         } else {
>                 retval = -EINVAL;
> -               goto error4;
> +               goto err_free_host;
>         }
>         usb_set_intfdata(interface, vub300);
>         INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
> @@ -2338,6 +2341,8 @@ static int vub300_probe(struct usb_interface *interface,
>         return 0;
>  error6:
>         timer_delete_sync(&vub300->inactivity_timer);
> +err_free_host:
> +       mmc_free_host(mmc);
>         /*
>          * and hence also frees vub300
>          * which is contained at the end of struct mmc
> --
> 2.52.0
>
