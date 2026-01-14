Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCF31691A
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420275; cv=none; b=eiiwL0V2DYd/AzHEY99CW0sTFje06ZPTFocPVeOsXWazKW4dYnT54ywdqiVcu9pYg9hjasWaXBLl8izVGxpBGjffQCrSnqG3dm3V8rbxbum+8ZJA+UZEdxjm2kCd9pk45RST3sxw9JgWfjSqDs/obGsztCWkAvjZJZWZekuMBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420275; c=relaxed/simple;
	bh=MIqVdFinLL7QD5ovk/fEjl2ffTjUIjA9yBA4X53aVbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gktVuo+ECy3/XcR+a8B039/3n2KG4E2E5TCwWHLBsUipayUI5MmdZHC20rvvUa6dDyJhwVCImhVsH8nqu44/f/brurNhKmlFafY2FbDeDcFqmuckyx9x3ZbuyMu6cnhijbvek8yQGVjGXqyJcs4eHQscU353RSurHhtw7od7bVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfGsKn1/; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfGsKn1/"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65d096dd0ceso58352eaf.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768420273; x=1769025073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmkX++zqRoXmQufKUjRGX+1ajYsTgPtGYI1EAO7VUfk=;
        b=VfGsKn1/9A2zRW/5R4RI1NxBQGJTH4lGB0ExURlSX+fBcaoPqxmCFquxNwZe58/dZW
         MJsVLav2Fe2HHqmngN1+hbE2LJNl4MFcO2Sx0fCIl50Vk8wq5yc3bf9+jIYETGET7gOf
         nAdEjFYsy6UP9rlEZlr+l25u69D1uggGuRN4y8bepNV99Y9zJoIGRiqE+VGq44Pp8ECm
         j7bvlRs/kjYNE1mz9QdF+lgMKR76Q22RDo3n0PvXusvnmFz1B+meerZV8I6lNCs27vvP
         fLhQYGffMYFVMSPpWWHywJyLZDMjMbWGeJO5JEvLUOryTLAhXbtvSEiNW3zC7OOXEFIF
         igoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420273; x=1769025073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmkX++zqRoXmQufKUjRGX+1ajYsTgPtGYI1EAO7VUfk=;
        b=ST2l+RlQng7tr1Fh3z6WktkZpuwdpDDRslmGQJO0Mo1z7NsKiB+okFh1//zeHfHGym
         tgUXSahWtUgU0Pyjc7BiRXQ+Q1R7u9i+JT0nQkM8hz0cWWDmZqlgTj+AvXJFsEYVmB8R
         2BNsHzNKdcJPyjlQuLoA4mtqlcBhpBakLRyrFzhT0wDJK4D1Ysp1GIfobGraskyrvzQ+
         Tw0kjoa+rzHn3R+F+yKQ5ZvcBAza6aLgOnJrXyr8hIzU9ORmmDeqfX5jZuHOVPO/ck8S
         zCLsIFUYcYYA7ULK7EF+aQW703LWfeDiomLz2goeresAvp+nAj8WwSOvQXPTB2gk+2Re
         cWYg==
X-Forwarded-Encrypted: i=1; AJvYcCWYbnzbDdEBle6IOlC4U8EolepuNyb/rX58PMbJyBxTSWRct5ms8ISPtCO2l6KUtpKJu5JkSWzVjQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqB1vlAFt7wvbaUJxcT6/jH/MELNe8t/HbsWNEssZ9V3SX4ukX
	OnQDFgSJy5fCQ8KmBybKMCpq65AfG+IsvmlyKahevmGWNubcFBMRBdUzN8IFHNFALTQ2Aiwmq9T
	flLpFnknibaF1I4wObCnuqLNzLU6rjuqchCKotlIz3Q==
X-Gm-Gg: AY/fxX4ksXZBm/AyHqH0+wpp7IvmZYERoGAmVyU7xNQ/5YoLUvHd11qVxSLkyl8fjGh
	OjQezcoyrk1E/38AdqaoN1WbXiT0H8ChFIugJFaENfP3hNMsbj4qY86we6marQ66jbNw+QB46rq
	+50MJlAXVuEvDbaBME7E1WI52ToJWqk33vAV6shaaXS85iN2HiO79t1gJs6sWvDvc+pxU9m5n2l
	dgD0/gwu72Ch/tFsF2vADPYhvZaM5kqKBVxzBBZ5yaAysAZQrzYF9lLkOQeC7B406tiu/2bnfK4
	ao3rwov0fVyffBbi3cisGcfLlZ0=
X-Received: by 2002:a4a:bb09:0:b0:65f:5b63:2bd with SMTP id
 006d021491bc7-661006092bemr2099962eaf.16.1768420273146; Wed, 14 Jan 2026
 11:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com> <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
 <6934ae0d-16c5-436f-97f6-c11d304ca51d@rock-chips.com>
In-Reply-To: <6934ae0d-16c5-436f-97f6-c11d304ca51d@rock-chips.com>
From: Marco Schirrmeister <mschirrmeister@gmail.com>
Date: Wed, 14 Jan 2026 20:51:02 +0100
X-Gm-Features: AZwV_QhkpvCh021_8aZe2zj5NJEjyP2doG40Uc8dVAbqe8HO8DzZyH15qQIvC28
Message-ID: <CAGJh8eDXT43_PfmUbShL4Hysfkd21R=sCerRNe_AGQANbwvSPA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	heiko@sntech.de, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Shawn,

On Wed, Jan 14, 2026 at 9:08=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> Except for the patch mentioned above for fixing the hot-plug problem
> which you confirmed to work fine. I looked the code a bit and see
> a potential problem related to the runtime suspend + power-domain.
> Please check the patch to see if it fixes your problem:

I tested your patch and the issue is still present. For verification I did
add some debug statements and just to see what it saves and restores.

The symbols are there.
root@nanopi-r76s ~# grep dw_mci_rockchip_runtime /proc/kallsyms
ffff800080bf27a0 t dw_mci_rockchip_runtime_suspend
ffff800080bf29c0 t dw_mci_rockchip_runtime_resume

# dmesg output
[Wed Jan 14 20:13:46 2026] E220d: Restoring phases: sample=3D231, drv=3D180
[Wed Jan 14 20:13:46 2026] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz
[Wed Jan 14 20:13:47 2026] mmc_host mmc1: Bus speed (slot 0) =3D 198000000H=
z
[Wed Jan 14 20:13:47 2026] dwmmc_rockchip 2a310000.mmc: Successfully
tuned phase to 232
[Wed Jan 14 20:13:48 2026] E220d: Saving phases: sample=3D231, drv=3D180
[Wed Jan 14 20:13:48 2026] E220d: Restoring phases: sample=3D231, drv=3D180
[Wed Jan 14 20:13:48 2026] mmc_host mmc1: Bus speed (slot 0) =3D 400000Hz
[Wed Jan 14 20:13:48 2026] mmc_host mmc1: Bus speed (slot 0) =3D 198000000H=
z
[Wed Jan 14 20:13:48 2026] dwmmc_rockchip 2a310000.mmc: Successfully
tuned phase to 231
[Wed Jan 14 20:13:48 2026] E220d: Saving phases: sample=3D231, drv=3D180

Based on this, it makes me believe that power to the sd card is completely =
cut
and when it wakes up and knows how to continue, it still must go through th=
e
retraining phase.

> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -36,6 +36,8 @@ struct dw_mci_rockchip_priv_data {
>          int                     default_sample_phase;
>          int                     num_phases;
>          bool                    internal_phase;
> +       int                     sample_phase;
> +       int                     drv_phase;
>   };
>
>   /*
> @@ -573,9 +575,43 @@ static void dw_mci_rockchip_remove(struct
> platform_device *pdev)
>          dw_mci_pltfm_remove(pdev);
>   }
>
> +static int dw_mci_rockchip_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev =3D to_platform_device(dev);
> +       struct dw_mci *host =3D platform_get_drvdata(pdev);
> +       struct dw_mci_rockchip_priv_data *priv =3D host->priv;
> +
> +       if (priv->internal_phase) {
> +               priv->sample_phase =3D rockchip_mmc_get_phase(host, true)=
;
> +               priv->drv_phase =3D rockchip_mmc_get_phase(host, false);
> +       }
> +
> +       return dw_mci_runtime_suspend(dev);
> +}
> +
> +static int dw_mci_rockchip_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev =3D to_platform_device(dev);
> +       struct dw_mci *host =3D platform_get_drvdata(pdev);
> +       struct dw_mci_rockchip_priv_data *priv =3D host->priv;
> +       int ret;
> +
> +       ret =3D dw_mci_runtime_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->internal_phase) {
> +               rockchip_mmc_set_phase(host, true, priv->sample_phase);
> +               rockchip_mmc_set_phase(host, false, priv->drv_phase);
> +               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
> +       }
> +
> +       return ret;
> +}
> +
>   static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops =3D {
>          SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> pm_runtime_force_resume)
> -       RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NUL=
L)
> +       RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend,
> dw_mci_rockchip_runtime_resume, NULL)
>   };
>
>   static struct platform_driver dw_mci_rockchip_pltfm_driver =3D {
