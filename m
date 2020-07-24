Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BCC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB42F206D7
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECPu6+uJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXJgu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJgt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 05:36:49 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D90C0619E5
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 02:36:49 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id g22so2054026vke.9
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOx9p9BRbHYFyzTDeDw1C6pMjBAIj6x0Ehxcc1dpviE=;
        b=ECPu6+uJ3ZzbkRGb3tE2DYl78eO7To6KVAIEykSObvdCdOC8UYpYCXhwrLuj3yXU3m
         hDps3bWLT8jFOvErQ8OjHMn+08iBtoAsrGUoK6yu9EpzbcoVF4CmaWt47LYBxamX1d2I
         M4KVvniPWN3rj5V22sYt3kbkTDn4BY02zvoe3AXGpUtlU0zKuF4D5aflxhthdTQ8WRT0
         N2EAUAJYiRtg4QKRaAeKm+qhFIGmRvTsFmyM9NSNQxZfplD0pJ34KI9vn3ygMFdmiZ5v
         SB5tFwvO3DrAzsvmPQIKykXdSjgBNNVEb8QnGC6+UOtr36ecCJ1jO5Y9z3A6TzYAWNoM
         3RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOx9p9BRbHYFyzTDeDw1C6pMjBAIj6x0Ehxcc1dpviE=;
        b=Iw7B9X0cS+joigKe06vOvfMYVoM+b0RxUGijUEc1VpsnDnHcQUYLxozhBi9qA4Fm1e
         vIDBfIYoxy07l/HrrhMijhxdJUkBHD7EFK1GMLhcons6J8b+38rIGLAJQs1oJD2K+xbt
         G/974ZeRKsGldFRu5BOB37aFS79jf245quOgZh46dcPwKh1Pu9zMZSTscd1WNwY44W5I
         b+AlJB+/et+zA7QjkVK87C9KDAMMKdWNsyOM0p+Nv9FBdWHRW0MUdZ89wgOnoyiVnW94
         vjH4NpsRUsRTPZW5IZVS6w41qmYnkxTvtut9OZwQaUgRJf0S4jXKIQD/iePvvHXq3zBj
         Jbcg==
X-Gm-Message-State: AOAM532q/02G3BezUg5dCUf5SHVkYJfoRM39EUYM+3lG5TE0ue2yFpLn
        szX6UfxqiQ5+9y1VkQnJ3EMzjAHeUq1SN/R8OI8JFw==
X-Google-Smtp-Source: ABdhPJwYNRHepiT7HFCBe+3t9Dq0oP/VTz3d5SmdWFkGQXl5erWU5g7rzzUNDCU6jQvAvpBTBCIpq/JTZuPwXRkS3pU=
X-Received: by 2002:a1f:3f0f:: with SMTP id m15mr7154482vka.53.1595583408542;
 Fri, 24 Jul 2020 02:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
 <1594213888-2780-2-git-send-email-vbadigan@codeaurora.org>
 <20200710005233.GN3191083@google.com> <63323fe2-e3a3-030f-5275-01fa6b04e23b@codeaurora.org>
 <20200711001948.GO3191083@google.com> <2c322fe1-6a86-43c9-11f3-387b917836ed@codeaurora.org>
 <406769f7-2282-d658-5573-3a510d256eee@codeaurora.org>
In-Reply-To: <406769f7-2282-d658-5573-3a510d256eee@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 11:36:12 +0200
Message-ID: <CAPDyKFpLg0HnZ6p=x9Egv9w65hB5CtFw=gV1rpL8vbWcHYtCzg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Set IO pins in low power state during suspend
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Jul 2020 at 16:12, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 7/13/2020 9:26 PM, Veerabhadrarao Badiganti wrote:
> >
> > On 7/11/2020 5:49 AM, Matthias Kaehlcke wrote:
> >> Hi,
> >>
> >> On Fri, Jul 10, 2020 at 04:28:36PM +0530, Veerabhadrarao Badiganti
> >> wrote:
> >>> Hi Mathias,
> >>>
> >>> On 7/10/2020 6:22 AM, Matthias Kaehlcke wrote:
> >>>> Hi,
> >>>>
> >>>> On Wed, Jul 08, 2020 at 06:41:20PM +0530, Veerabhadrarao Badiganti
> >>>> wrote:
> >>>>> Configure SDHC IO pins with low power configuration when the driver
> >>>>> is in suspend state.
> >>>>>
> >>>>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >>>>> ---
> >>>>>    drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++++
> >>>>>    1 file changed, 17 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci-msm.c
> >>>>> b/drivers/mmc/host/sdhci-msm.c
> >>>>> index 392d41d57a6e..efd2bae1430c 100644
> >>>>> --- a/drivers/mmc/host/sdhci-msm.c
> >>>>> +++ b/drivers/mmc/host/sdhci-msm.c
> >>>>> @@ -15,6 +15,7 @@
> >>>>>    #include <linux/iopoll.h>
> >>>>>    #include <linux/regulator/consumer.h>
> >>>>>    #include <linux/interconnect.h>
> >>>>> +#include <linux/pinctrl/consumer.h>
> >>>>>    #include "sdhci-pltfm.h"
> >>>>>    #include "cqhci.h"
> >>>>> @@ -1352,6 +1353,19 @@ static void
> >>>>> sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
> >>>>>            sdhci_msm_hs400(host, &mmc->ios);
> >>>>>    }
> >>>>> +static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host,
> >>>>> bool level)
> >>>>> +{
> >>>>> +    struct platform_device *pdev = msm_host->pdev;
> >>>>> +    int ret;
> >>>>> +
> >>>>> +    if (level)
> >>>>> +        ret = pinctrl_pm_select_default_state(&pdev->dev);
> >>>>> +    else
> >>>>> +        ret = pinctrl_pm_select_sleep_state(&pdev->dev);
> >>>>> +
> >>>>> +    return ret;
> >>>>> +}
> >>>>> +
> >>>>>    static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
> >>>>>    {
> >>>>>        if (IS_ERR(mmc->supply.vmmc))
> >>>>> @@ -1596,6 +1610,9 @@ static void sdhci_msm_handle_pwr_irq(struct
> >>>>> sdhci_host *host, int irq)
> >>>>>                ret = sdhci_msm_set_vqmmc(msm_host, mmc,
> >>>>>                        pwr_state & REQ_BUS_ON);
> >>>>>            if (!ret)
> >>>>> +            ret = sdhci_msm_set_pincfg(msm_host,
> >>>>> +                    pwr_state & REQ_BUS_ON);
> >>>>> +        if (!ret)
> >>>>>                irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
> >>>>>            else
> >>>>>                irq_ack |= CORE_PWRCTL_BUS_FAIL;
> >>>> I happened to have a debug patch in my tree which logs when regulators
> >>>> are enabled/disabled, with this patch I see the SD card regulator
> >>>> toggling constantly after returning from the first system suspend.
> >>>>
> >>>> I added more logs:
> >>>>
> >>>> [ 1156.085819] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
> >>>> [ 1156.248936] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
> >>>> [ 1156.301989] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
> >>>> [ 1156.462383] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
> >>>> [ 1156.525988] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
> >>>> [ 1156.670372] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
> >>>> [ 1156.717935] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
> >>>> [ 1156.878122] DBG: sdhci_msm_set_pincfg: level = 1 (ret: 0)
> >>>> [ 1156.928134] DBG: sdhci_msm_set_pincfg: level = 0 (ret: 0)
> >>>>
> >>>> This is on an SC7180 platform. It doesn't run an upstream kernel
> >>>> though,
> >>>> but v5.4 with plenty of upstream patches.
> >>> I have verified this on couple of sc7180 targets (on Chrome platform
> >>> with
> >>> Chrome kernel).
> >>> But didn't see any issue. Its working as expected.
> >> Did you test system suspend too? At least in the Chrome OS kernel
> >> tree system
> >> suspend is not supported yet in the main branch, you'd need a pile of
> >> 30+
> >> extra patches to get it to work. This is expected to change soon
> >> though :)
> > Yes. I have verified with system  suspend-resume scenario.
> > Sorry forgot to mention this point explicitly in last response.
> >
> > I believe all the needed patches were present on qcom internal tree.
> > Suspend-resume is working fine on sc7180 qcom chrome tree.
> >
> Thanks Matthias. I cloud reproduce the issue on device without SDcard.
>
> Without SDcard inserted, cd-gpio (SD card detect GPIO) is getting read
> as active HIGH
> (as if card is inserted) during system-resume, resulting SDcard probe/scan.
>
> After that its triggering interrupt again when pinctrl config is applied
> during SDcard
> power-up sequence (as part of probe/scan) which is again triggering
> sdcard scan.
>
> I will have to change SDcard cd-gpio sleep config to fix this issue like
> below:
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index e2230f47a17d..9266d514e163 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2447,7 +2447,7 @@
>
>                                  pinconf-sd-cd {
>                                          pins = "gpio69";
> -                                       bias-disable;
> +                                       bias-pull-up;
>                                          drive-strength = <2>;
>
> I will check more on why its getting read as active HIGH during resume.
>
>
> >>> Let me know if you are observing this issue constantly on multiple
> >>> boards, I
> >>> will share you
> >>> a debug patch to check it further.
> >> I currently have only one board with the SD card slot populated, I might
> >> get another one next week.
> >>
> >> The toggling occurs only when no SD card is inserted.
>
> Thanks
>
> Veera
>

Thanks for testing and for looking into this. Perhaps I should drop
the $subject patch then?

Kind regards
Uffe
