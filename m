Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C29C64EC7
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Feb 2023 11:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjB1L1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjB1L1V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2023 06:27:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01322F7B4
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 03:26:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a7so5456652pfx.10
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 03:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSt/wO7XSIyNtS1D8q6gqRP/ksadQMSkTlr22kMpteE=;
        b=DleE+djUNCUoLG/L/VRCp5h/HcnGLjcJ/0hTQ8J7bUTpBDYSBZV8jpJhXK3QtGEaV6
         g/EtTEmSu4vaszclIOl4f+tcX16HiPMIbww/80W6SwWC/dILQ7HFnJUxGyi1iseLcH3Z
         LfHWV7iIsgOwgzomKDvUU6K3M/V0UJ0CFZHJPKpvFSU+EFdlRlS/Cdzpqd+mtxE3SEu5
         mKe3E38R8q7W+DzsDljbq+jyDBEDPVeKi3oj0M3a6lO01OJjTy42M+qjHprIDpjASDdl
         MNnovKPN04SwWh8XUuinjrSxFtwUq4r5H1JNDRZ9llYKVRUR2ZEHaUDXK8kE8DNKdYQ7
         /TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSt/wO7XSIyNtS1D8q6gqRP/ksadQMSkTlr22kMpteE=;
        b=nZBvDufEQMWl3A/W2arHTnXpyCASIRrNlevG88SAn4a7+Eq7Vf9+//Hbd2m6easRdp
         ES9Dg2O/wFwB9zw5VhxZMG6xHcBXA2g5/d8qmjnhm90drHni5IU3GrabKWwzuio2HWPP
         SEjOOMCXGkEyYfGeQwEPs6vnr6xw7HTalFxGQqpg3rASkXfuZOPkMc2vD3rVQteZ1Hqe
         LoAxlonM6cBwMAmBjLkZrJC6HY+ngS24YmSDcF+yo0y2e7sDqSoDvEh5cEf36Q+2duZk
         WkOxSVYRSJFAkVWl0sJZdoO44t3jAe1cUpA2VdXNi891181gcJ5szDFhCD5lun+0OiEl
         alog==
X-Gm-Message-State: AO0yUKUJPUd/pnTZck8fHFDus6hEFXJuRn5gq8YRz4jvFmrHFrGxXpsH
        +zO5pPNFT07kukukPmwdDseD7nVh79NmkMGjXF7y0g==
X-Google-Smtp-Source: AK7set/6wnsjUlxEM67eUAD5nkOTF3rDyaRKaTHx9cHuAKzLygejHFZyifGTp0jN5rfK5zvKxrCbtCleH7vzIT0FdXI=
X-Received: by 2002:a63:b513:0:b0:4fc:a80e:e6ec with SMTP id
 y19-20020a63b513000000b004fca80ee6ecmr664111pge.5.1677583530601; Tue, 28 Feb
 2023 03:25:30 -0800 (PST)
MIME-Version: 1.0
References: <1675298118-64243-1-git-send-email-shawn.lin@rock-chips.com>
 <1675298118-64243-3-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoN3GDRYRJep1ARf8rSftZRBUceda92OPuDQLvG3dVhhQ@mail.gmail.com>
 <a336a9ef-77e9-fa1d-ad95-805a8b5a89cb@rock-chips.com> <CAPDyKFrpv+DoqMK9cLrYMBk1m6dXoDXu40xSJ_UMVK8O+=Ud6A@mail.gmail.com>
 <c0f5f292-f639-1f7c-3d12-2c80015c67fc@rock-chips.com>
In-Reply-To: <c0f5f292-f639-1f7c-3d12-2c80015c67fc@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Feb 2023 12:24:54 +0100
Message-ID: <CAPDyKFpM3+0OTRP5iSiSkpomgDYWHZD6dDXtif7B0FGjoeAt=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-dwcmshc: Add runtime PM support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Rafael

On Wed, 15 Feb 2023 at 01:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Ulf
>
> On 2023/2/14 18:41, Ulf Hansson wrote:
> > On Tue, 14 Feb 2023 at 04:36, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> >>
> >> Hi Ulf,
> >>
> >> On 2023/2/14 7:45, Ulf Hansson wrote:
> >>> On Thu, 2 Feb 2023 at 01:35, Shawn Lin <shawn.lin@rock-chips.com> wro=
te:
> >>>>
> >>>> This patch adds runtime PM support.
> >>>>
> >>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>>> ---
> >>>>
> >>>> Changes in v2: None
> >>>>
> >>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 51 ++++++++++++++++++++++++=
++++++++++++-
> >>>>    1 file changed, 50 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/=
sdhci-of-dwcmshc.c
> >>>> index 46b1ce7..fc917ed 100644
> >>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>>> @@ -15,6 +15,7 @@
> >>>>    #include <linux/module.h>
> >>>>    #include <linux/of.h>
> >>>>    #include <linux/of_device.h>
> >>>> +#include <linux/pm_runtime.h>
> >>>>    #include <linux/reset.h>
> >>>>    #include <linux/sizes.h>
> >>>>
> >>>> @@ -551,6 +552,13 @@ static int dwcmshc_probe(struct platform_device=
 *pdev)
> >>>>           if (err)
> >>>>                   goto err_setup_host;
> >>>>
> >>>> +       pm_runtime_get_noresume(&pdev->dev);
> >>>> +       pm_runtime_set_active(&pdev->dev);
> >>>> +       pm_runtime_enable(&pdev->dev);
> >>>> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> >>>> +       pm_runtime_use_autosuspend(&pdev->dev);
> >>>> +       pm_runtime_put_autosuspend(&pdev->dev);
> >>>> +
> >>>>           return 0;
> >>>>
> >>>>    err_setup_host:
> >>>> @@ -580,6 +588,11 @@ static int dwcmshc_remove(struct platform_devic=
e *pdev)
> >>>>           if (rk_priv)
> >>>>                   clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> >>>>                                              rk_priv->rockchip_clks)=
;
> >>>> +
> >>>> +       pm_runtime_get_sync(&pdev->dev);
> >>>> +       pm_runtime_disable(&pdev->dev);
> >>>> +       pm_runtime_put_noidle(&pdev->dev);
> >>>> +
> >>>>           sdhci_pltfm_free(pdev);
> >>>>
> >>>>           return 0;
> >>>> @@ -638,7 +651,43 @@ static int dwcmshc_resume(struct device *dev)
> >>>>    }
> >>>>    #endif
> >>>>
> >>>> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_re=
sume);
> >>>> +#ifdef CONFIG_PM
> >>>> +static int dwcmshc_runtime_suspend(struct device *dev)
> >>>> +{
> >>>> +       struct sdhci_host *host =3D dev_get_drvdata(dev);
> >>>> +       u16 data;
> >>>> +       int ret;
> >>>> +
> >>>> +       ret =3D sdhci_runtime_suspend_host(host);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>> +       data =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >>>> +       data &=3D ~SDHCI_CLOCK_CARD_EN;
> >>>> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int dwcmshc_runtime_resume(struct device *dev)
> >>>> +{
> >>>> +       struct sdhci_host *host =3D dev_get_drvdata(dev);
> >>>> +       u16 data;
> >>>> +
> >>>> +       data =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >>>> +       data |=3D SDHCI_CLOCK_CARD_EN;
> >>>> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
> >>>> +
> >>>> +       return sdhci_runtime_resume_host(host, 0);
> >>>> +}
> >>>> +#endif
> >>>> +
> >>>> +static const struct dev_pm_ops dwcmshc_pmops =3D {
> >>>> +       SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend,
> >>>> +                               dwcmshc_resume)
> >>>
> >>> I have looked at dwcmshc_suspend(), which calls sdhci_suspend_host().
> >>> As sdhci_suspend_host() will write to internal registers of the IP
> >>> block, it's recommended to make sure the device's runtime resumed
> >>> before doing that call. So that needs to be added along with $subject
> >>> patch.
> >>>
> >>
> >> Yep, let me add a check here.
> >>
> >>> There is also another option that may better for you, which is to use
> >>> the pm_runtime_force_suspend|resume() helpers. There should be plenty
> >>> of references to look at, but don't hesitate to ask around that, if
> >>> you need some more help to get that working.
> >>
> >> If I understand correctly,  pm_runtime_force_suspend|resume() helpers
> >> would use runtime PM ops for suspend/resume routine. In this case, the
> >> main issue is the handling of clock is quite different. In suspend we
> >> need to gate all clocks but in rpm case, it shouldn't.
> >
> > I see, but let me then ask, what's the point of keeping the clocks
> > ungated at runtime suspend?
> >
> > That sounds like wasting energy to me - but maybe there are good reason=
s for it?
>
> The point to keep the clocks ungated at runtime suspend is that if they
> are gated,  the DLL would lost its locked state which causes retuning
> every time. It's quite painful for performance. However, if we just gate
> output clock to the device, the devices(basically I refer to eMMC) will
> get into power-save status by itself. That helps us too keep balance
> between power & performance during runtime. =EF=BC=9A=EF=BC=89

I see, thanks for clarifying! In principle your approach should work
fine, but it depends a bit on the platform/soc too.

I assume there could also be a PM domain attached to the mmc host
device, right? If such a PM domain gets powered off, wouldn't you need
to run a retuning sequence anyway?

FYI, I have heard about similar problems for devices before - and it's
been discussed too. In principle, it sounds to me that we have devices
that would benefit from using *multiple* idle states, rather than just
the one we have for runtime suspend and the one for system wide
suspend.

Kind regards
Uffe
