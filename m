Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15762701CB
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161651; cv=pass; b=AWxwiB3yEAQ1AFqggIwuH3sbiMzWLAmTSnRZELXpUevn0UIkXiyBtV+LJ+lYX4NbEUWoHX6gi6LT5LQaOnM8YMW2rSPNAEwimWSJyKtCiwoq1Z/UhzC4H6KxNFBSKNHL3DS3ZjTYWCo+hG5pwzp2XF8eu2H4iOpxW0buK4vIw6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161651; c=relaxed/simple;
	bh=WLr3uR7ANLOfMDo/u9PAChUKd9GnpDbjCKXrbEhUzVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjn+/w6NuNNz5KRZTJe6vMN1jtFxQKUjsvVExrXQZANLb9pIhD6kTwKL03hW/WcyXO1ZUuSlqyynNZ21W2behsE13mKggifWu7W/vqYCuqqjFJHQq7AgBlGJt/es7n7SwxubuxpxnQjf/OMehEFgUf3zsLXV6V7E6HyijGseWXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKALd7ih; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKALd7ih"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd263bf42so2442030e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 01:47:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769161641; cv=none;
        d=google.com; s=arc-20240605;
        b=dggpCytACbbKUOtMsAjrmCu9+yYBH9M0diaJhAwQqvpMAgPy0X6RQIqEFhbixifdgc
         CBymnstkrxueedEuJ948ZQRoxjCSd2anMPRQDVkQj5ADopCB5VWAlM8j3RX1ex13d6ex
         AHzRr1ZSTewNE9twVjZF31d5Rk5S3ClatnpFMpq2oLNXOtM6N081ERVNukY9YmZRA757
         V/d5fTChm3q+hL/dm2OjFt21PMpUNhFjDBshKs2s3OM8wUNUF8dI3KUSTUggtGPlLUgI
         KbCG7K9l2O0lbuPsIgeAy+LIGY9JquxpqVMCpYDUiyPTvwKA8OhPyzBao1v7IwmwL36V
         qJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4w4Mg0wUlM2nrkTl2DGZ7j8Q3OQROer/gjziJpUu/Ro=;
        fh=nKr4HdUzYryq78VaOJLYY+cByZ25N6QhwZbUHDhj3is=;
        b=U3SEbGMfIQpAlTp18RvCaRn3kohW1RhRqTfWLC7A9XBBtF4wqvaQj33EJ6P0EmqR2q
         eIc05RwhGNfzngvQ8CxEvc9iEdv85v8n2ilI9COvBwtYkNpj47LGJFG8iFWXHqo53urp
         xc6fgZ2sVb/NYryjH5iCXu21ITOpylmUrg9jr3QC7csegElcptWCgPgiwjUShdqKEzok
         PP6WHi88GMvJ5UcznFmoVdLb55YfUc7OnQ8OTM9SGy8mgO2gy+JfpwYvcTDuOOmNeB6+
         g0OhJiE9/vht/aCpUtQqN8QffQ8keNV6mCYoiR7LjHjZrsBVfRdCkJEq+etTsBHxeJ5G
         o2kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769161641; x=1769766441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4w4Mg0wUlM2nrkTl2DGZ7j8Q3OQROer/gjziJpUu/Ro=;
        b=hKALd7ihfD3P0RK9GOrYyHQP0soPB1f7sN2laun86y5mtQpBq5C1L/RptFiYFkvIxS
         BoF2O1c0f4iBCphgP8nIPKroQm6O1Ce9OrJWYylqiRnkD3VHHMzcPgqW4+8cQlMjws8q
         5tbTF808+6mEjNAse+AT7zSu+LOocFBDdqxEgn52eMwwQViiEcF7fM6I/clkiriZMvkS
         PhHblE1UHxCehqgH35zcngqcvvQALpzHzahaFIs6LuY5Xxdlz4tPth+XuCfIn+QiOyE9
         BxbDe4ANV0qcXIAj4HuwNDgiOGn0w5cVfk4LUXjCPIKxn+6GZ/qWxWcoMSj+jpCFq4S1
         GZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769161641; x=1769766441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w4Mg0wUlM2nrkTl2DGZ7j8Q3OQROer/gjziJpUu/Ro=;
        b=bN/iWtwLbAvjz/ZeU14R5GivH8OUDnJv1NP0FJ382k5An8TL0Vws9ZrApO7BDvrPkb
         R9is7ABVkN5C4mEQhoHxF6hmCsVi7D71PglWs+4WsRR6wk4uSRnVuenF2VP1oigiW15b
         Y6LnzOt97bOBgdxqTS8VfQi1xZ6qrcM5e45sa0UGHsQaSZt8XAK0HeWUj2KXklJj0D7N
         50ktMvxLvki4Mr/LSOXcYd+29m+YES2Rh2utlhe859DeQLwhDrf/s/7SlbHx7lr+Uo6Y
         Js3UOMHE6Uujw8hg6udbxF3oLyK8/ofZf7iBgFGuT2jameP/R+S8nHoOaURJwmOAxnM2
         l48A==
X-Forwarded-Encrypted: i=1; AJvYcCU5L/lAFS33qwO22GtKD9fhvxkkLcJoJGG4+ROilM4ZUqh7fcb71GFm4tacC78sGhwMVF8t00Gli8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUwb1zw1J0ut5T9fpI1NZvmLc3u4tfAYcGbt5GJ7RKFMNLctS
	JcnZyPwyNuXLw1DhOXAjrt/pI7HGfxjZ+jfIH5rEorJ+wXhz+OuP4PSBLvRCU19f39bUNJ1HECp
	RuBC5/FlsO4pBJvBAMRp3w9247fJYc9Lsbq8rYuiLFQ==
X-Gm-Gg: AZuq6aIdttG9HEj9JbfuhKUgJlmby3xYBaCRbs+gr1wByo3QVy9u2e3qGFxz2VDGXrd
	VcJksNz+eBszf7ywfMH/DYWA/KRajKhOqqG8P2K0dCrqPBSFTBw7L4TYMwODisYy2jgIgwb6zy2
	Fv/fzgMizBJmnBchbs0jiw+mkNdlw8I1LRRReXCSWihWSvjgxHd15i8Ua7FcteOR9haFvXQzBc4
	e8552EE5XbYXxv9cdvxs0xCq2R8v3dOkwBWYv226jiVPsLB2Dl4XG5rR9cz5L+dNp7mDgMk
X-Received: by 2002:a05:6512:61a6:b0:59d:d705:139b with SMTP id
 2adb3069b0e04-59de4925a15mr677606e87.30.1769161641419; Fri, 23 Jan 2026
 01:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
 <20260123085613.182773-1-ping.gao@samsung.com>
In-Reply-To: <20260123085613.182773-1-ping.gao@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Jan 2026 10:46:45 +0100
X-Gm-Features: AZwV_Qj-sHfmqDbq8equ2gh5RrWwdaCDXx1i2PW9PFpOvTWsho6rpWcwXbsCusk
Message-ID: <CAPDyKFqJaojUwGhNPnQXpL7q7MkmtfA7Q-QkDHKj=nVF4YYVCw@mail.gmail.com>
Subject: Re: [PATCH] drivers: dw_mmc: Replace devm_clk_get with devm_clk_get_optional
To: "ping.gao" <ping.gao@samsung.com>
Cc: jh80.chung@samsung.com, sebastian.reichel@collabora.com, 
	shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 09:51, ping.gao <ping.gao@samsung.com> wrote:
>
> By using devm_clk_get_optional, if clk is optional for device and not define in dts
> it will return NULL, then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
> bail out internally.
>
> before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
> not null,it will panic when call clk_prepare
> log is below:
> [  438.400868] [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
> [  438.400877] [7:   binder:436_2: 4998] Mem abort info:
> [  438.400881] [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
> [  438.400887] [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  438.400894] [7:   binder:436_2: 4998]   SET = 0, FnV = 0
> [  438.400899] [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
> [  438.400904] [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault
> ...
> [  438.409424] [7:   binder:436_2: 4998] Call trace:
> [  438.409429] [7:   binder:436_2: 4998]  clk_prepare+0x10/0x24
> [  438.409439] [7:   binder:436_2: 4998]  dw_mci_runtime_resume+0x50/0x2d8 [dw_mmc_samsung cd210e210975263404c28fc89778f369f8398f0c]
> [  438.409471] [7:   binder:436_2: 4998]  dw_mci_exynos_runtime_resume+0x18/0x58 [dw_mmc_exynos_samsung 2735a594c7c9c9e8c65b0b87523fbf70dcaabfff]
> [  438.409496] [7:   binder:436_2: 4998]  pm_generic_runtime_resume+0x40/0x58
> [  438.409506] [7:   binder:436_2: 4998]  pm_runtime_force_resume+0x9c/0x134
> [  438.409517] [7:   binder:436_2: 4998]  platform_pm_resume+0x40/0x8c
> [  438.409529] [7:   binder:436_2: 4998]  dpm_run_callback+0x64/0x230
> [  438.409540] [7:   binder:436_2: 4998]  __device_resume+0x1d8/0x394
> [  438.409551] [7:   binder:436_2: 4998]  dpm_resume+0x110/0x2b8
> [  438.409561] [7:   binder:436_2: 4998]  dpm_resume_end+0x1c/0x38
> [  438.409570] [7:   binder:436_2: 4998]  suspend_devices_and_enter+0x828/0xab0
> [  438.409582] [7:   binder:436_2: 4998]  pm_suspend+0x334/0x618
> [  438.409592] [7:   binder:436_2: 4998]  state_store+0x104/0x144
> [  438.409601] [7:   binder:436_2: 4998]  kobj_attr_store+0x30/0x48
> [  438.409610] [7:   binder:436_2: 4998]  sysfs_kf_write+0x54/0x6c
> [  438.409619] [7:   binder:436_2: 4998]  kernfs_fop_write_iter+0x104/0x1a8
> [  438.409628] [7:   binder:436_2: 4998]  vfs_write+0x24c/0x2f4
> [  438.409640] [7:   binder:436_2: 4998]  ksys_write+0x78/0xe8
> [  438.409652] [7:   binder:436_2: 4998]  __arm64_sys_write+0x1c/0x2c
> [  438.409664] [7:   binder:436_2: 4998]  invoke_syscall+0x58/0x114
> [  438.409676] [7:   binder:436_2: 4998]  el0_svc_common+0xac/0xe0
> [  438.409687] [7:   binder:436_2: 4998]  do_el0_svc+0x1c/0x28
> [  438.409698] [7:   binder:436_2: 4998]  el0_svc+0x38/0x68
> [  438.409705] [7:   binder:436_2: 4998]  el0t_64_sync_handler+0x68/0xbc
> [  438.409712] [7:   binder:436_2: 4998]  el0t_64_sync+0x1a8/0x1ac
>
> Signed-off-by: ping.gao <ping.gao@samsung.com>

You are not versioning your patches, which makes it difficult for me
to manage them. Again, please read
Documentation/process/submitting-patches.rst before you continue to
post any more patches.

Anyway, I can pick this up as is for now, when Shawn has reviewed it.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..6bcc1e7233c0 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3375,7 +3375,7 @@ int dw_mci_probe(struct dw_mci *host)
>                                              "platform data not available\n");
>         }
>
> -       host->biu_clk = devm_clk_get(host->dev, "biu");
> +       host->biu_clk = devm_clk_get_optional(host->dev, "biu");
>         if (IS_ERR(host->biu_clk)) {
>                 dev_dbg(host->dev, "biu clock not available\n");
>                 ret = PTR_ERR(host->biu_clk);
> --
> 2.50.1
>
