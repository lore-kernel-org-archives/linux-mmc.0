Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156553D1AB3
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496434; cv=pass; b=rutuees+pUfLmKvCs6SZ3Zul4wbGGUal8IeDnIgeb845mzG54h3j3UId+qp81zKgkE8q3ligQgvXC5ZFsOs6gckl1cC0/+2imkB3OUB2vt3Wizj2kU1Iu6OD9KKc09nzmrhKOScOiWKN4nuRYb6PcfbyCAoqFUkPIjVWGWnKGnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496434; c=relaxed/simple;
	bh=Q6bCmmxNwha2xCAbpsn/FcAb1BFAxRBVX4B/Cpbli1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0EOFWN8SQI6A7X5eR/4GHCOL/hhcG8ZYp9nBWrpWFPR/C9jJ7qS2g3hOsQzHE3Iw1nacjOcP8Fa8fA/67Syg+pEjukjZ4GbIq+Y8HeSTK97K4tQ9KozubtgHPBXMBLModP9979+WpQVPJyqRXG8ODs9QErqGHQRWycCbDfNlsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvo7yOzz; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvo7yOzz"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so25041666b.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 11:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496428; cv=none;
        d=google.com; s=arc-20260327;
        b=Vbi2xZVYf8F3ZorLw2nL+EGv0nNlOWdyGSBaJ/0TVj4QGre5jrbqVY1ep2kwJFakPB
         b+1wfrPPjleJof52p+X/Tn6Q+qbY4k6pnG1iU+PnMa0I9KKVXUdISf28NBiOFmCRTPz8
         eQ8YgSyMmXHrXnymDPgW3TcVneyeqZUI10GDw4S5E60O2U6t6P4wSWte4GsGvkMa/JxQ
         tgHw6dx7RDC3hTGvfcMtZJdX7Pz1X5dL0+TsS0o1C3OvvU2C0M1NDYZxwK4ZyxEAWoLF
         Cdc2RtQRDtaM4v++CoblhzDH2mDQzW5kuoZlPBXEGYet8xwN2+puqTBRzND84dmZh8MA
         X3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pXLChR3Cua/hV/+FH65ITHAtn+7ekjTkhk2MiyXe18I=;
        fh=BUHC78sHexf6LwKv4raVIpzqcGXqYoeDPuMI14Gua4k=;
        b=EjDajWrS5qQmXvfZ39q60ys3ARjJt0h1BaIwvRb33uSRAbtnTP39Z3Ubvdh2qL1zEA
         o1pXJOg9lYraqbNUPBvI1KoZ9fpqfaweW8LCiYMH7JCasNteJgdSpwsExI+LuS3ve+HT
         Fv8xTriP18rSQb9aCCB4b3mnC+ZCr2Nferjt9J2wkcmqReMMi/EmxndkzTBEkwefTLzO
         A6exo6PFeeDVLJ9s1S+DMxOLCAoQlLXcp+zBRNFlsvAdyg0xyjpv4urgTlXViGKZ4/75
         VZUTu9jwvC8J+t2a106D40vZg+4D54+GtztKGK8umIl3IrW1lKIFTYSAFHi9WpDnIiHU
         DrAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789496428; x=1790101228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pXLChR3Cua/hV/+FH65ITHAtn+7ekjTkhk2MiyXe18I=;
        b=Fvo7yOzzjfi111EuSW2meRmUaIov22B8heaBaVlO1gzaajC/RsCeSJRvai34FlKEvm
         +jHGNMY77Z5+98F8CgjIFaky+Jj1I06l8uul36/D0dO3W18oHikd4Bdmn20Xfgovb2xb
         TFVcm8N/3GiECiDmSwKV4qdYammM5qiAe/FIH9YII+ixQDZO6CDv0BlzgfNwq4h4XkUv
         mYmhzu8iwhqkIwhcA/DOiPEk5l8pSZ8idUnZK0egZw0PSBKsu9VzcBJvmoXHeDDsR+9E
         11NTzp6FmiTcnTeNljfMeZb6Zhc/UKMD40A7FM0iBgkvda+ilKOVFFuJnB2HrFRD//5n
         Y+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496428; x=1790101228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXLChR3Cua/hV/+FH65ITHAtn+7ekjTkhk2MiyXe18I=;
        b=iTAcLgJyx0ijLki05/IhMBStHmMsrrKrN+tNC5DWZVf4nBQy817OEewsG4rqr1NpVZ
         52HRHI0AUNnA3wWSvTT7575ZkgaxUOeJW94UKivVQQ3NrTQGgQXi42K+t9BcX7LygxT6
         NM/G3ZD8eP6K+7CgYL3NyCoRLAkw7ucyxDb/6k6hCKEeLrh6YRv9pYqbTRv/zOGeAU+1
         r9Ugo36r/llg3fEOBFy0iwKerSR0UC4WDYTsJW+B0rVunlVuPad0VJtJjP5QY8b8c6Zv
         wyTBNKUd93JzXFAHgjBnol8kcAAEHZKoUR3ROBPko+0FejGUdOYuLfr2eX7trN4VWPrh
         WVRg==
X-Gm-Message-State: AFuF++lysCzViQ596Kke75qOkYKqC+ZgJ8vjQHMPLS1jzjqu6FAjoKvB
	0pYOIqtxQj0Li8oVs6PINQZxna0uzU2SJkhljAa6M7L8Xyu+sGeCxHXP7gD1Nfnbg4xolCghJjz
	Frs7re+DKtgNiu5aZ8rNf2VGcd3ofi5QBIQ==
X-Gm-Gg: AYBFou2h/x1123uvMhGtgSXnmWvvaK7qCy8o0egfCMKeJcMCv3tePQ9rP7acKyXcsX0
	y93WRmCmqtWvgzxCT1jEW/dS5RlpEWMUHTFyalsYCwwJzoGS9d7TOI8TD4M6tEWOD6qkwImMnxP
	YOA0ntlGwLlskeCK0YXMH1eSpP3n26c9sG3UA1OSJxn7KSvg9to9U/rDDHlGjPjqwCW1yJHXbac
	U5CR5ZQt3G2zQIVP62rIusK2+z4CrubR4VmKwqJjGLCwI6n9YrgCwYc1M2ibiZCko4qjZlyZ6sy
	/pP2i03qLTaI1qyqz3l+X5bDanqiE+gZhfYyJ+E9wneXtO+tweY9C/lhT2cKYbt2eXt9EbbQSiH
	racdU+0j49mXU6nzL9y7to53FDXm1+N7qBO3ii/AwdXCbiVMladiqL24mno9+4R9iaSlg67uAFK
	clB2gzX/Dwc+Of4nTcmBKT2E2nO0ePjNuz9ZxKHTDhqkeh3NgEY9gt3fbbTtJBHbyS2yY=
X-Received: by 2002:a17:907:c08c:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c29d78fe104mr158403866b.23.1789496427760; Tue, 15 Sep 2026
 11:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915180401.7809-1-rosenp@gmail.com>
In-Reply-To: <20260915180401.7809-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 15 Sep 2026 11:20:16 -0700
X-Gm-Features: AcwNN1XY15gfxhnZUjtT9upTFPFoC0v82P4B2b-BJxQ86TC0qzSFbhj-ZOfq44k
Message-ID: <CAKxU2N_dF-CPSJ_pFDce+KHVMVi02r8nCfs31FKRzn34_K=i6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: use managed clock enablement
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:04=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Replace devm_clk_get() plus clk_prepare_enable() with the managed
> variants devm_clk_get_enabled() and devm_clk_get_optional_enabled().
> The core clock becomes optional, which removes the IS_ERR() guards
> in runtime suspend/resume and lets devms unwind the clocks, so the
> manual clk_disable_unprepare() calls in the probe error paths and
> remove are dropped.
>
> clk_prepare_enable() and friends are NULL safe, so no need to check if
> the optional clock is present.
>
> Also handle failures of clk_prepare_enable() in runtime resume instead
> of ignoring them: a failed enable would leave controller register
> accesses hitting unclocked hardware. Bail out before resuming the host
> and unwind clk_io when enabling clk_core fails. This also drops the
> now unused pltfm_host variable from remove().
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
ugh this should have been a v2. I'll send a v3 tomorrow.
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 42 +++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav=
3.c
> index f39764ffd4a0..c2ad801dc9a8 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -413,19 +413,18 @@ static int sdhci_pxav3_probe(struct platform_device=
 *pdev)
>         pltfm_host =3D sdhci_priv(host);
>         pxa =3D sdhci_pltfm_priv(pltfm_host);
>
> -       pxa->clk_io =3D devm_clk_get(dev, "io");
> +       pxa->clk_io =3D devm_clk_get_enabled(dev, "io");
>         if (IS_ERR(pxa->clk_io))
> -               pxa->clk_io =3D devm_clk_get(dev, NULL);
> +               pxa->clk_io =3D devm_clk_get_enabled(dev, NULL);
>         if (IS_ERR(pxa->clk_io)) {
>                 dev_err(dev, "failed to get io clock\n");
>                 return PTR_ERR(pxa->clk_io);
>         }
>         pltfm_host->clk =3D pxa->clk_io;
> -       clk_prepare_enable(pxa->clk_io);
>
> -       pxa->clk_core =3D devm_clk_get(dev, "core");
> -       if (!IS_ERR(pxa->clk_core))
> -               clk_prepare_enable(pxa->clk_core);
> +       pxa->clk_core =3D devm_clk_get_optional_enabled(dev, "core");
> +       if (IS_ERR(pxa->clk_core))
> +               return PTR_ERR(pxa->clk_core);
>
>         host->mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
>         /* enable 1/8V DDR capable */
> @@ -434,17 +433,17 @@ static int sdhci_pxav3_probe(struct platform_device=
 *pdev)
>         if (device_is_compatible(dev, "marvell,armada-380-sdhci")) {
>                 ret =3D armada_38x_quirks(pdev, host);
>                 if (ret < 0)
> -                       goto err_mbus_win;
> +                       return ret;
>                 ret =3D mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>                 if (ret < 0)
> -                       goto err_mbus_win;
> +                       return ret;
>         }
>
>         match =3D of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pd=
ev->dev);
>         if (match) {
>                 ret =3D mmc_of_parse(host->mmc);
>                 if (ret)
> -                       goto err_of_parse;
> +                       return ret;
>                 sdhci_get_of_property(pdev);
>                 pdata =3D pxav3_get_mmc_pdata(dev);
>                 pdev->dev.platform_data =3D pdata;
> @@ -499,27 +498,18 @@ static int sdhci_pxav3_probe(struct platform_device=
 *pdev)
>  err_add_host:
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
> -err_of_parse:
> -err_mbus_win:
> -       clk_disable_unprepare(pxa->clk_io);
> -       clk_disable_unprepare(pxa->clk_core);
>         return ret;
>  }
>
>  static void sdhci_pxav3_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
> -       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> -       struct sdhci_pxa *pxa =3D sdhci_pltfm_priv(pltfm_host);
>
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
>         sdhci_remove_host(host, 1);
> -
> -       clk_disable_unprepare(pxa->clk_io);
> -       clk_disable_unprepare(pxa->clk_core);
>  }
>
>  static int sdhci_pxav3_suspend(struct device *dev)
> @@ -560,8 +550,7 @@ static int sdhci_pxav3_runtime_suspend(struct device =
*dev)
>                 mmc_retune_needed(host->mmc);
>
>         clk_disable_unprepare(pxa->clk_io);
> -       if (!IS_ERR(pxa->clk_core))
> -               clk_disable_unprepare(pxa->clk_core);
> +       clk_disable_unprepare(pxa->clk_core);
>
>         return 0;
>  }
> @@ -571,10 +560,17 @@ static int sdhci_pxav3_runtime_resume(struct device=
 *dev)
>         struct sdhci_host *host =3D dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>         struct sdhci_pxa *pxa =3D sdhci_pltfm_priv(pltfm_host);
> +       int ret;
>
> -       clk_prepare_enable(pxa->clk_io);
> -       if (!IS_ERR(pxa->clk_core))
> -               clk_prepare_enable(pxa->clk_core);
> +       ret =3D clk_prepare_enable(pxa->clk_io);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D clk_prepare_enable(pxa->clk_core);
> +       if (ret) {
> +               clk_disable_unprepare(pxa->clk_io);
> +               return ret;
> +       }
>
>         sdhci_runtime_resume_host(host, 0);
>         return 0;
> --
> 2.55.0
>
