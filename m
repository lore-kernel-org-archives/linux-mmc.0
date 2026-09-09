Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D23B7B64
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990010; cv=pass; b=B0mmhNVXhOADtdTN6Zmr3J3349OdZvqjfRrbTbxBX444LJm0yEk6FAg2ywNqsACilQ1wfA0Jn2AsFG29hUcdsGUnmq3ojkE8J4OlrHnT+jy8Xo0xw5i3uEbmY7ONUJQ+uVMxOoZ5gGF5bSvHAVMxeY8LnWsSf696Zqy84jxuFHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990010; c=relaxed/simple;
	bh=ddYlgRH+Eu31kZhzBqiV/ZLzQ+kkAleS3Iapjo7h8+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCzmDKqVHhB8K56KVSCw7nLeUhAqcJw1PYZ2dT5anDLfhJs0N2bImxeWxyC+SLmC5l0i0835M5PWVk3tuPt9U3/RhGxL68wFk8pAw9GAKiHKVq4Bp23KcdCmL4dnMiGC9f4G1tvT8m1hITxZiTIqyBUQdOOYipbhvEKcgesSNbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqOuAtwQ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqOuAtwQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1670dad7a8so1042245266b.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 14:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788989997; cv=none;
        d=google.com; s=arc-20260327;
        b=H28pU42xrSuOy6RdwbFczN9xk/5vdlzil0MpzcR4XgrHCMdEoYFgZjzRly2yWL4bUd
         gB94g8kVwnJfs5if1oqffBWnLBpPO6EKbtsYMx+GZ5ONfjZvaeBY38u+YvQH1cBxzcTE
         yV5KPIZGSAMEShBsKp1STr9vjMdyOT89sjglSnfQ0rEzJeJoRKupSdHIqrOLio2pUlYk
         XQGhjMbsUEwnsON1+cJ5/ly/KUM33aYm+UzarKwr7exRHUTBVXEf8UF6i5VVHZ0HxXJb
         64zBtXrc5Lt0D67+NYaIMxO5fa3F/HABbMrvTgfGqP44YgzU+ha/7KKxCHipHJChL89x
         1grQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HyaCdrxKlZQ2oXMbYltyBFEBTyPKfY34zB6KlNdy/xA=;
        fh=hByJu+G1Gk/+W3Afx0if0vMz/yjCNmIA1pbHUWJaMv0=;
        b=VKiXl59bkiDfQmqu4+O9HXtuBTNIK5hMgEeLQZwQpTLRFBCQCrb94ZuGNLoI3kiMeo
         mp19jFqPUQlVzpF3sHzEzt75d0etHvmbHWbBtOv7UwqbCMsKH7v77yELnCoHcm5op1XC
         6xuupqeEAhlbT4pwU577rs5TMtOi/hEmqe+16AlEeVld48CYUa1vPoexFmaq+4cDJzpo
         +2JjsGUzZHBI3JBShzz5dfcxfYIfRZEAXTDQ91GNNTc3sqggZHwnRQs/FCKK1tpK7Er+
         4kReBKmKr1dkfYpNXcN8D1jhqJlxfZ7AQihsLWCIEEvevkl+PXhMxqYX8JkwwAXR6UXJ
         p6UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788989997; x=1789594797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HyaCdrxKlZQ2oXMbYltyBFEBTyPKfY34zB6KlNdy/xA=;
        b=CqOuAtwQuaMUS4pKzYGX8Je6JCE5CFo0ZFukn9Qi1giILHgqQybl44MELOR1UTCvML
         Lj9GCGDz396Do1U+JQy9oRPflDlrY+r7mq1bvcz7dLLI79JupsST0LHVT42zRPNhrUr0
         IlD8hLOzlOckecwi3DgbXZXahDZRSsFODCTUC5iRKcfKsnYxwMKI34DYqQlpqOjvzVtG
         F4paTxyIeGQh96MAO7auc4NP5oJped8pfQLQW0XOj3g/y1GbuDXK+7113BOV6M0McqRj
         9KsM50WMmr0w03sFD4/Jyi8lVGPJmZwz2z9gEvJmj+qFCJGvISeHECZqAUzC1HfaIgDs
         u+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989997; x=1789594797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyaCdrxKlZQ2oXMbYltyBFEBTyPKfY34zB6KlNdy/xA=;
        b=bZO99YS3iZCKJZdAq8Nnf5gUFFcccD5k0MOLPS5SpundvguXuXUV4hJhfa4WN9syTm
         krwfXHWEVFloglI0QI8aC/6Ecf7mRXlBx+eFV1/dNMk0f2ceGeOJ7ToEMjDNp396RbCY
         YNNdCQdyzG+FoB7o18aa+72dLjxtJk7FBIf7+8HOOzEzUal9Pmjr9gdAIQcW+FUbKXoO
         pnzkSHfchMz5kXHPBi/GZbehturgv/yfYxARDSua/IWTnfzMpPOASVnHAC88ZBhVQmc5
         g/CMeYWojMySPUkUq3Lxb8fw3ovEwICm0lpfZNcgoTXknuuLrgPNAVUf10+EVEW4pVSG
         Monw==
X-Gm-Message-State: AFuF++lP6qnqendb4Cf8eBlE5yFb79mD/yAKBRlvwgaU2zByoxhFn0EC
	+Zcofev1HsAvRGLkd/8lipiqv/JBdHlPtt/EsFBc6RkNs5407YwVY6fMY22N165utnhPd2CP7lA
	7ePXQ7MOSiSJ767JTaOJ/F6ZRMi5Ln0oEEA==
X-Gm-Gg: AYBFou3inEDuJ3eIbmUwIYs/R28lXiQe6rDGivgDw9pKQ9AYLkl4IHyEuhNOuwHLBbg
	eFTuTEGeYCH+Ae1KPUgB381u36Lnwm0VRPldKcYgMB48ZpfGwy7LGRr/mXEY9KtmlZ3rFdl+PVj
	OIjmDwwB21JeYUwODqpYribn4SMKRL7Eej47Ytl8hGizbSZVkVC5rG5oWH+lrMbz9meFyHszDMS
	eNNpx7ikWCaXx8tUrztwrszrb5pYbGbeTXDpEs9wGFAtYPnQDhK3kB6DCbiOSXBAVOj/BDGtiZG
	f4tInfKl5y7xL2ZbBSYMwKcJA6+n/xquWiEdFwgthFLLGFHsQi+mtP1xOguoaw/XcO0qYbq5Lu2
	GTzNwelpLGDIdlTNei6DOoYomTGDiWthfBySpnzuWpp+gFo3vl/Y+9HW3OE7Zcr+PxVNNDOowJE
	mTEwFf4nQDZ04K7YgVKxDgCzF+uRXq+2ZN6VmpulOatUQ6TJTCyZMRS6QEPCdXZNaa0Q==
X-Received: by 2002:a17:907:94d1:b0:c25:5ad1:41e0 with SMTP id
 a640c23a62f3a-c260cb4539cmr1647515266b.23.1788989997322; Wed, 09 Sep 2026
 14:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901004243.50052-1-rosenp@gmail.com> <890a971a-49cc-46e9-83ee-7df6d892f65c@intel.com>
In-Reply-To: <890a971a-49cc-46e9-83ee-7df6d892f65c@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 9 Sep 2026 14:39:46 -0700
X-Gm-Features: AcwNN1WAUPI16ZC4OyveYJgLyv2MzCWa68SEubVmklnGNCwLKbGkugxFaxcW1ds
Message-ID: <CAKxU2N_CUNgM07-8=c4nKw=fbExxz6g0mdnsO2dvce7MT1vVwA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: use managed clock enablement
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, Karel Balej <balejk@matfyz.cz>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:51=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 01/09/2026 03:42, Rosen Penev wrote:
> > Replace devm_clk_get() plus clk_prepare_enable() with the managed
> > variants devm_clk_get_enabled() and devm_clk_get_optional_enabled().
> > The core clock becomes optional, which removes the IS_ERR() guards
> > in runtime suspend/resume and lets devms unwind the clocks, so the
> > manual clk_disable_unprepare() calls in the probe error paths and
> > remove are dropped.
> >
> > clk_prepare_enable() and friends are NULL safe, so no need to check if
> > the optional clock is present.
> >
> > Also handle failures of clk_prepare_enable() in runtime resume instead
> > of ignoring them: a failed enable would leave controller register
> > accesses hitting unclocked hardware. Bail out before resuming the host
> > and unwind clk_io when enabling clk_core fails. This also drops the
> > now unused pltfm_host variable from remove().
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-pxav3.c | 42 +++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-px=
av3.c
> > index d082c4e21aa9..db9dfa92cb57 100644
> > --- a/drivers/mmc/host/sdhci-pxav3.c
> > +++ b/drivers/mmc/host/sdhci-pxav3.c
> > @@ -414,19 +414,18 @@ static int sdhci_pxav3_probe(struct platform_devi=
ce *pdev)
> >       pltfm_host =3D sdhci_priv(host);
> >       pxa =3D sdhci_pltfm_priv(pltfm_host);
> >
> > -     pxa->clk_io =3D devm_clk_get(dev, "io");
> > +     pxa->clk_io =3D devm_clk_get_enabled(dev, "io");
> >       if (IS_ERR(pxa->clk_io))
> > -             pxa->clk_io =3D devm_clk_get(dev, NULL);
> > +             pxa->clk_io =3D devm_clk_get_enabled(dev, NULL);
>
> Sashiko has a point about getting the wrong clock:
>
>         https://sashiko.dev/#/patchset/20260901004243.50052-1-rosenp%40gm=
ail.com?part=3D1
It's technically correct but meaningless. All dts files specify the
clock properly. Both paths attempt to enable the same clock.
>
> >       if (IS_ERR(pxa->clk_io)) {
> >               dev_err(dev, "failed to get io clock\n");
> >               return PTR_ERR(pxa->clk_io);
> >       }
> >       pltfm_host->clk =3D pxa->clk_io;
> > -     clk_prepare_enable(pxa->clk_io);
> >
> > -     pxa->clk_core =3D devm_clk_get(dev, "core");
> > -     if (!IS_ERR(pxa->clk_core))
> > -             clk_prepare_enable(pxa->clk_core);
> > +     pxa->clk_core =3D devm_clk_get_optional_enabled(dev, "core");
> > +     if (IS_ERR(pxa->clk_core))
> > +             return PTR_ERR(pxa->clk_core);
> >
> >       host->mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
> >       /* enable 1/8V DDR capable */
> > @@ -435,17 +434,17 @@ static int sdhci_pxav3_probe(struct platform_devi=
ce *pdev)
> >       if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
> >               ret =3D armada_38x_quirks(pdev, host);
> >               if (ret < 0)
> > -                     goto err_mbus_win;
> > +                     return ret;
> >               ret =3D mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> >               if (ret < 0)
> > -                     goto err_mbus_win;
> > +                     return ret;
> >       }
> >
> >       match =3D of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pd=
ev->dev);
> >       if (match) {
> >               ret =3D mmc_of_parse(host->mmc);
> >               if (ret)
> > -                     goto err_of_parse;
> > +                     return ret;
> >               sdhci_get_of_property(pdev);
> >               pdata =3D pxav3_get_mmc_pdata(dev);
> >               pdev->dev.platform_data =3D pdata;
> > @@ -500,27 +499,18 @@ static int sdhci_pxav3_probe(struct platform_devi=
ce *pdev)
> >  err_add_host:
> >       pm_runtime_disable(&pdev->dev);
> >       pm_runtime_put_noidle(&pdev->dev);
> > -err_of_parse:
> > -err_mbus_win:
> > -     clk_disable_unprepare(pxa->clk_io);
> > -     clk_disable_unprepare(pxa->clk_core);
> >       return ret;
> >  }
> >
> >  static void sdhci_pxav3_remove(struct platform_device *pdev)
> >  {
> >       struct sdhci_host *host =3D platform_get_drvdata(pdev);
> > -     struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > -     struct sdhci_pxa *pxa =3D sdhci_pltfm_priv(pltfm_host);
> >
> >       pm_runtime_get_sync(&pdev->dev);
> >       pm_runtime_disable(&pdev->dev);
> >       pm_runtime_put_noidle(&pdev->dev);
> >
> >       sdhci_remove_host(host, 1);
> > -
> > -     clk_disable_unprepare(pxa->clk_io);
> > -     clk_disable_unprepare(pxa->clk_core);
> >  }
> >
> >  static int sdhci_pxav3_suspend(struct device *dev)
> > @@ -561,8 +551,7 @@ static int sdhci_pxav3_runtime_suspend(struct devic=
e *dev)
> >               mmc_retune_needed(host->mmc);
> >
> >       clk_disable_unprepare(pxa->clk_io);
> > -     if (!IS_ERR(pxa->clk_core))
> > -             clk_disable_unprepare(pxa->clk_core);
> > +     clk_disable_unprepare(pxa->clk_core);
> >
> >       return 0;
> >  }
> > @@ -572,10 +561,17 @@ static int sdhci_pxav3_runtime_resume(struct devi=
ce *dev)
> >       struct sdhci_host *host =3D dev_get_drvdata(dev);
> >       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >       struct sdhci_pxa *pxa =3D sdhci_pltfm_priv(pltfm_host);
> > +     int ret;
> >
> > -     clk_prepare_enable(pxa->clk_io);
> > -     if (!IS_ERR(pxa->clk_core))
> > -             clk_prepare_enable(pxa->clk_core);
> > +     ret =3D clk_prepare_enable(pxa->clk_io);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D clk_prepare_enable(pxa->clk_core);
> > +     if (ret) {
> > +             clk_disable_unprepare(pxa->clk_io);
> > +             return ret;
> > +     }
> >
> >       sdhci_runtime_resume_host(host, 0);
> >       return 0;
>
