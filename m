Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44409C04FDF
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 20:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjHHUpO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjHHUo5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 16:44:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502FEB3B6
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:35:08 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so4595581fac.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512471; x=1692117271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6q8AWTQBFD8b34cUtgYL+witLNypid98p7CdPe4IBE=;
        b=bNkBRiZ2QKm+Pz802w27+xM1XIFNxRAXl3XViTHV5sOyDZSCPwMDflLbg/zlYAGEoL
         wKg75YIwzdHMfE3rCnZksGz/LiE7g/4Ls+GCG8CCUmmPcDw74R6vymj/l90bt4Mw8Pu1
         nkkYtiBi0ZYGjBIa2jPsRfg/QwoJ9fE/Z+OVD5YjTlJem0j3w50M1Zvsc4M56k55INW0
         C0dOJR2hfxjhIGSdoUdytD/4LXzIwXcHkSJnb3UwcxbwcsatdguEBXy6kuB76n/mBIS2
         AVnZM4+lO5mrEFUkkyt5XkvOtHc7NpCkg+LQz7qTg1rlJ+Cw20Z62mQkh1zJXHLBEC8a
         xzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512471; x=1692117271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6q8AWTQBFD8b34cUtgYL+witLNypid98p7CdPe4IBE=;
        b=TvrBm+mRICqXQ9wNNOlznSRedGmi8rccgHakUpfcvMHwLiSNzElfPIftnsYD6aXZox
         hm2vbYJ1mkrzzmu3oe3XHg2hdtwUfyBlCf9Z8bmlO5gvIgUmyg/TKLL3HSaq3pttFWG/
         jQLPq8rTHOrxQNuObLqxT1Nqdd4cYQKOzUF2cejNOZGqho5gX0usbz7h823wGF60WdCS
         s1F1c7C4n/NgiH3a4EEIaGm+EtE9JtKovdUe2wHaPgegEBfcYZ499T9usUxc2jI0Rwqa
         h3HSB4YGnjeL6hsYtmSyfZTOQi07pWvHH+42UAXIsTx8vEtyFQZnENLifWFu+EP62EHW
         AaCA==
X-Gm-Message-State: AOJu0Yy3uPxOZtRG3mHZZ78SdmjFoRvUCHLMN23ds8101mTvLOH7mh4z
        5rSSaMdGfirxO7kqBSamX8lniUau2752z8tsh0z8pd7BkYRqifei
X-Google-Smtp-Source: AGHT+IHPeWlMhp/iuilCXvaLkenjZHEONKa+356uZo9i11tbs0WMo8B7ql77BuPz+mojouwmY87u8kqJrivnVxW927A=
X-Received: by 2002:a25:374c:0:b0:d0d:2d17:3f11 with SMTP id
 e73-20020a25374c000000b00d0d2d173f11mr12364694yba.17.1691503040670; Tue, 08
 Aug 2023 06:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com> <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
 <BN9PR12MB506823B5AF3069C0C8350BE9D30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB506823B5AF3069C0C8350BE9D30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 15:56:44 +0200
Message-ID: <CAPDyKFq+S544LFH_fMNucd8B8mrV9ORbL+v05q2EnWtgg+8ggA@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Aug 2023 at 15:21, Liming Sun <limings@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Tuesday, August 8, 2023 5:40 AM
> > To: Liming Sun <limings@nvidia.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; David Thompson
> > <davthompson@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>; linux-
> > mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operation=
s
> >
> > On Sat, 5 Aug 2023 at 01:30, Liming Sun <limings@nvidia.com> wrote:
> > >
> > > This commit implements the runtime PM operations to disable eMMC
> > > card clock when idle.
> > >
> > > Reviewed-by: David Thompson <davthompson@nvidia.com>
> > > Signed-off-by: Liming Sun <limings@nvidia.com>
> > > ---
> > > v5->v6:
> > >     - Address Adrian's more comments and add coordination between
> > >       runtime PM and system PM;
> > > v4->v5:
> > >     - Address Adrian's comment to move the pm_enable to the end to
> > >       avoid race;
> > > v3->v4:
> > >     - Fix compiling reported by 'kernel test robot';
> > > v2->v3:
> > >     - Revise the commit message;
> > > v1->v2:
> > >     Updates for comments from Ulf:
> > >     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> > > v1: Initial version.
> > > ---
> > >  drivers/mmc/host/sdhci-of-dwcmshc.c | 72
> > ++++++++++++++++++++++++++++-
> > >  1 file changed, 70 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/s=
dhci-
> > of-dwcmshc.c
> > > index e68cd87998c8..aaf66358f626 100644
> > > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/sizes.h>
> > >
> > > @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device
> > *pdev)
> > >
> > >         host->mmc->caps |=3D MMC_CAP_WAIT_WHILE_BUSY;
> > >
> > > +       pm_runtime_get_noresume(dev);
> > > +       pm_runtime_set_active(dev);
> > > +       pm_runtime_enable(dev);
> > > +
> > >         err =3D sdhci_setup_host(host);
> > >         if (err)
> > > -               goto err_clk;
> > > +               goto err_rpm;
> > >
> > >         if (rk_priv)
> > >                 dwcmshc_rk35xx_postinit(host, priv);
> > > @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device
> > *pdev)
> > >         if (err)
> > >                 goto err_setup_host;
> > >
> > > +       pm_runtime_put_sync(dev);
> > > +
> >
> > The async pm_runtime_put() is probably sufficient - and it would allow
> > the probe to complete a bit "sooner".
>
> Sure, will test and update the line in v7.
>
> >
> > >         return 0;
> > >
> > >  err_setup_host:
> > >         sdhci_cleanup_host(host);
> > > +err_rpm:
> > > +       pm_runtime_disable(dev);
> > > +       pm_runtime_put_noidle(dev);
> > >  err_clk:
> > >         clk_disable_unprepare(pltfm_host->clk);
> > >         clk_disable_unprepare(priv->bus_clk);
> > > @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       ret =3D pm_runtime_force_suspend(dev);
> >
> > Can dwcmshc_suspend() be called for a device that may be attached to
> > the ACPI PM domain?
>
> BlueField SoC is the only chip that uses ACPI in this driver for now and =
it doesn't support System Sleep. Thus, the dwcmshc_suspend() won't be calle=
d. But I guess it might be possible when other new chip support is added in=
to this driver. Is it a concern?

The ACPI PM domain doesn't support drivers using
pm_runtime_force_suspend|resume(). Unless that has been changed
without me knowing about it.

Anyway, it looks like it shouldn't be a problem at this point. We can
also add separate callbacks for other SoCs, if that comes into play
going forward.

[...]

Kind regards
Uffe
