Return-Path: <SRS0=4qKy=EL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B94C55179
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB44021734
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Nov 2020 10:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiAiD4e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgKEKfI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 05:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgKEKfD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 05:35:03 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E85C061A4A
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 02:35:03 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m16so485943vsl.8
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 02:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdAvLjoOXomWCs8t6TmIL4j/I5mepz3FWTuHztdBTlc=;
        b=BiAiD4e1h7itpTTBhs3DR4K8CfgZymL8qj1e7tZjDyvL22TAbVaJrB6OdCOJ9dCgt8
         uMo1WI+cg7RQpxF0bBlJEyznK83VkivtEouWpjXE0uDzswIn9ngEEIWZkBVtGoJKPI5a
         3gYONlFV9O8ISMzu91uUEboniTdwBNNIgS1GVf+ZVCHpgeExfkJ3HUKHZ4pHVFwQwMtx
         5vGFFB38gJyFP7FBlRczIoGJ/8EUs8e6gc59Rm7O/sKD+Kj4+eFQl2/7R5M52mOjdRQY
         23FqbRx5TWg7iDot8DaIDKVfEKsFUNqqGSEPkpoltdKL/CwkFxGm9pZGSMzsaqx/PW9N
         dskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdAvLjoOXomWCs8t6TmIL4j/I5mepz3FWTuHztdBTlc=;
        b=i/5J0BALBhK2Cu2wy6WH5UkgDG95f7gJ4ZkJxrjkU9N6yXgijliko28LbhIACj5/x4
         4HO7HPVXAplKwLqX+T/p4zRObS+ipgnZiQBPRUA1N67q5aPlKST6wkF655frJvTjc+3G
         kubSRROkxyZPdBR3TpyJ9I3rRT6rN/uc0EaYKyp9S576bESbu13XpdylI0HNF9Z1hAc/
         dyd1UcyL/+YdD0M2N07ZHudiG9HOK559SPy79k2nnl3ne1nWXsaZTt5/OGGW6vXfo3Qz
         kY/IyU3yXhawpH+MZUyZcvO6OToGPXqsQHz5eVfyINufEmHxhx5a4pK8HUob4Vt6mUa5
         Zw/w==
X-Gm-Message-State: AOAM531ylD3YTQ7Zh1p4WxdwCDKXcGTVT6FFVrKAt1MTEQWZUdS9F9Mm
        sh0jiJcT3z1L+hA1/bYFTLRWrQVyBr1Hz6D3dQWLVQ==
X-Google-Smtp-Source: ABdhPJxVfapO8HtgRahAnJ4wz7s9HOgbHIAKW7gtu7MmcNt2t4MXd/COFLbP0begvsat+FQbNQGgY8Hv6gEHSKm9IGw=
X-Received: by 2002:a67:f417:: with SMTP id p23mr725992vsn.42.1604572502741;
 Thu, 05 Nov 2020 02:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20201104234427.26477-1-digetx@gmail.com> <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <20201105100603.skrirm7uke4s2xyl@vireshk-i7>
In-Reply-To: <20201105100603.skrirm7uke4s2xyl@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 11:34:26 +0100
Message-ID: <CAPDyKFoCJt5MBSKBJ8n1OAMdVsWHdwXTx0zFEcZw_F_gQ6Ug0w@mail.gmail.com>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Nov 2020 at 11:06, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-11-20, 10:45, Ulf Hansson wrote:
> > + Viresh
>
> Thanks Ulf. I found a bug in OPP core because you cc'd me here :)

Happy to help. :-)

>
> > On Thu, 5 Nov 2020 at 00:44, Dmitry Osipenko <digetx@gmail.com> wrote:
> > I need some more time to review this, but just a quick check found a
> > few potential issues...
> >
> > The "core-supply", that you specify as a regulator for each
> > controller's device node, is not the way we describe power domains.
>
> Maybe I misunderstood your comment here, but there are two ways of
> scaling the voltage of a device depending on if it is a regulator (and
> can be modeled as one in the kernel) or a power domain.

I am not objecting about scaling the voltage through a regulator,
that's fine to me. However, encoding a power domain as a regulator
(even if it may seem like a regulator) isn't. Well, unless Mark Brown
has changed his mind about this.

In this case, it seems like the regulator supply belongs in the
description of the power domain provider.

>
> In case of Qcom earlier (when we added the performance-state stuff),
> the eventual hardware was out of kernel's control and we didn't wanted
> (allowed) to model it as a virtual regulator just to pass the votes to
> the RPM. And so we did what we did.
>
> But if the hardware (where the voltage is required to be changed) is
> indeed a regulator and is modeled as one, then what Dmitry has done
> looks okay. i.e. add a supply in the device's node and microvolt
> property in the DT entries.

I guess I haven't paid enough attention how power domain regulators
are being described then. I was under the impression that the CPUfreq
case was a bit specific - and we had legacy bindings to stick with.

Can you point me to some other existing examples of where power domain
regulators are specified as a regulator in each device's node?

Kind regards
Uffe
