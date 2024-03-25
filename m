Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775E13B2BC
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372766; cv=none; b=QdaBYUDBhHLTvlMJPnSvAVtCkEdRoE40TtT/J1aqRMEPPogzkay5kaPNHfyeJjlm5MS98LtYqWJS8FH2m8jMPt/dnR0xYN3Ux5etFyVPDfn9AFWAFQYHLEx4MceF2H4eo5gnz+rplrYTjXL2OQRCmGypr/zaZVfbsuz7L4rM35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372766; c=relaxed/simple;
	bh=4GQ/Ylb2FAdVLwbqTrN8fDxpWE6cYSu4yrX6gxUbEvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9Hl1fwjhbdmM2eb/YtS+8SWKMXtVSxvtFpWYLOMW5ey5daW51rU58hY9jP0t/dBHYUxYDRXuRFL9y33IOCpGgTOeV7jrc4ShWoMTSA9L8Bi9+DtUMPMbECv8APXU72caMishzpLpXzcWpx3wUFvaHiQ0y5u3PXA8WWB7oisfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HltJQNYA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HltJQNYA"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so4232310276.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372764; x=1711977564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CoulX7BQpsTOmyIdZQqRavCOlGmEyy57qcbpihkH62Y=;
        b=HltJQNYA9TVjxtCnpDxj1n8RV0zHicIHy4HWWycnSapxLlYgRsvJvw6Z7nd3/RAKB+
         oLwDbHXi4Wa/tqqAeDardvh7pqmUAlecjQ2GM1idOrGDZs7M6A3So1x0iZ3llEL1DnqJ
         6PMKkVPqoOqzsbmgi/413NCAaHXNUSStoxobtCD08fTxEjF9gcaab52J6TAc4jRF8nP+
         /Je7x3zHp0Bteg3jEVObchC38sxazNchdZuX7mDy3/+G/hOjUo0XTFZxbyHuf0KhTef9
         r7aAT+L/4qbbjhhi4CjIZoC8XItMcTEJQIptFNQU+BhAx2Lv5ostxEOUXLhrG7S0QrOE
         31Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372764; x=1711977564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoulX7BQpsTOmyIdZQqRavCOlGmEyy57qcbpihkH62Y=;
        b=jgXX4YaNiNS2l3OR10vmerwneOPR4/agSNsWTlcIFmaOzvCichNisxrBMyALJ7W3gh
         rzZygL0P7WxMWUlkKWSQ40Wvl7h795NhnuWX96hDOYQaz08Nf2xnaOoUMBNUho/eDlzg
         2koKB9Qm/BYRzgrguPTvvRchOUaJdQc9BqcIrcUr0vtorVZ2SHj71fD1rNnvI7LByZRW
         znhJlOSyfqBrm6VUghJ/Hc1XVcXDGoaSvxVM+/zpxbj+cR0H0TYmCWz7PC0FfE3zQj8a
         hhM3AOazgLuoH858wXQ7VYDjpQVeJC0b8EIoVxtDIZ5Hn4B7h8x+n4sfdv61fRlkVInD
         n1jA==
X-Forwarded-Encrypted: i=1; AJvYcCUIRXWRIc//4Y6A9RZCLbtNdQQZ1n3xLnBHO5/MsQ/UdOFlnJ2QRMskzYm7HTNb+m2XZaIe+v3Vy6OgYFiphtVAx3iYyQv6ymH2
X-Gm-Message-State: AOJu0YzouuOrp900pCh9MXr7HE8wpT8YCrpIyxiBAYDnYPHKGeNhxQd3
	0z0ioOiAXKd0r7FzbvtCMNLG+3LP8d6S5NveR8s0ArrHQ7TxkZTuGR+xSpPaIPtuhvxJc1KHUiy
	xhXai4koBDk/AyC9QnmbSjljImVMZF8dCp30xubNQHklDXfoI
X-Google-Smtp-Source: AGHT+IG4OvqTknR9DVrYyeqEXmiomNARQe3hEQWymLFVrJHFKfkQfsJL+lxdF5P7pIC5YjMQJ4trm2o+KsiTYahSeZI=
X-Received: by 2002:a25:4d03:0:b0:dc7:48f8:ce2e with SMTP id
 a3-20020a254d03000000b00dc748f8ce2emr3956500ybb.37.1711372763830; Mon, 25 Mar
 2024 06:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314091512.1323650-1-lizhijian@fujitsu.com>
In-Reply-To: <20240314091512.1323650-1-lizhijian@fujitsu.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:47 +0100
Message-ID: <CAPDyKFo_D7cCoMMr3LQ6c=G-fVnaCU==_v0n9Dq_0biAaytqhg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Convert sprintf/snprintf to sysfs_emit
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 10:15, Li Zhijian <lizhijian@fujitsu.com> wrote:
>
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
>
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>
> sprintf() will be converted as weel if they have.
>
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
>
> No functional change intended
>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  drivers/mmc/core/block.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 64a3492e8002..1e1e136d9e72 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -234,7 +234,7 @@ static ssize_t power_ro_lock_show(struct device *dev,
>         else if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
>                 locked = 1;
>
> -       ret = snprintf(buf, PAGE_SIZE, "%d\n", locked);
> +       ret = sysfs_emit(buf, "%d\n", locked);
>
>         mmc_blk_put(md);
>
> @@ -296,9 +296,9 @@ static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
>         int ret;
>         struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
>
> -       ret = snprintf(buf, PAGE_SIZE, "%d\n",
> -                      get_disk_ro(dev_to_disk(dev)) ^
> -                      md->read_only);
> +       ret = sysfs_emit(buf, "%d\n",
> +                        get_disk_ro(dev_to_disk(dev)) ^
> +                        md->read_only);
>         mmc_blk_put(md);
>         return ret;
>  }
> --
> 2.29.2
>
