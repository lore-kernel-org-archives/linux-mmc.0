Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0938ECAAD8
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 11:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIULe7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIULe6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 07:34:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D9356D0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 04:34:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso3215300wmq.4
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 04:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/ybfT4WqyBnAKfmlmo21rIN6NvZIY8b7reraMYXuOX0=;
        b=ISpz+8pCJUOW9j7bw59/it7p9eJD9j/m+cF/7JHGpcvlo790NmC2J4AIPXFUdiVM5z
         k2V0ASn8gSZte2wEtZ2AhmywGMafZiJ2lsZpVGCm13+qGIt8tRTpq5L7jo7AlrTENsI9
         4fUfIIIuJXvCMjhgp7A/YC0MiXVnQulgSbDF1U2XLiAvfmcjqjWRgVRzA0v3uJjHn4b7
         7RohnRHutCMPUa10ZqEn/gMc1PYbQqokFVWjzOin//aVErFx9BxA/cyWUcdhytNx7svw
         otjCBXz81X/yjlrNIGvd7qpKHmQZIXQh5OHo4By0fqOLx/4nPeEV6vXjNUvt1zygz7e2
         kpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/ybfT4WqyBnAKfmlmo21rIN6NvZIY8b7reraMYXuOX0=;
        b=M9BjboQrtvCtU0cSE7V1SJiAzspeG1SepH7paHNNAQX3T+3vVjSMRGbnsLZJkV7SzW
         2cxc3ecC8GORzgD7gOBf9azxeK5IVjjUyKLzhGR3NxyDSL8Sb1XIL2r8W0ekeiTB7xF5
         Fdt+DEIxKhRrpQXNfuf6NnWqhiTIhiDG0D++0VgvWAIM12WMmEKPmMpnbJqIf2P5VROj
         5lxnL1xPkgQxjUNPejKhVO49sgAlz5uxNHkjdxi4ipzZ4X0k6Hp0qpKT+QMWMhzd+KlR
         UIHrDJdboNXPSNbsqTu4l1aLy6m0tRInyIfViHm680jO+eX3e0/wT2XsgnQKm/CLVQXZ
         8QRA==
X-Gm-Message-State: ACrzQf1ZEvLVkhohUxbobFYEZXFt7ToaU60fNkmvDjiZKLfhbpmF/RQW
        MeXJIoBKbS+NjzIeXk4JMGBdZA+KsTZIMgDp4aO4iJeLzBc=
X-Google-Smtp-Source: AMsMyM6L2l1GyjMDmgH6dYdmp/omAc/U89EA2USB/mU5ko5lOSdFoc85hnij/4m5w2Mtg3ShNXNn7m6alfm/yXgvo5A=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr5343487wmq.17.1663760094782; Wed, 21
 Sep 2022 04:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220919181309.286611-1-dinguyen@kernel.org> <20220919181309.286611-2-dinguyen@kernel.org>
 <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
 <50c7d35b-f395-6421-1422-56e30a580318@kernel.org> <07c118cb-4daf-8e82-2969-1cff072ec52a@linaro.org>
 <CAPDyKFoQJsf4EAoQRO9hoKWug+QTX2Hw1ukFqhr0sNQCCwR8Bg@mail.gmail.com> <74c9c011-b0db-c838-e9bb-d732361ff799@linaro.org>
In-Reply-To: <74c9c011-b0db-c838-e9bb-d732361ff799@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 13:34:18 +0200
Message-ID: <CAPDyKFp7WU0Bk5=xmpt9cZL2redunTuBo44ZLjj=1Tx1r3G+9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Sept 2022 at 13:13, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/09/2022 12:31, Ulf Hansson wrote:
> >> Not in next-20220919.
> >
> > Dinh is right!
> >
> > It seems like both me and Krzysztof missed the already documented
> > binding. Probably because the property is named like below and that I
> > did "git grep clk-phase-sd" :-)
> >
> > "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":
>
> Too much trust in git grep. Thanks for finding it.
>
> >
> >>
> >>>
> >>> Should I create a specific documentation just for
> >>> "altr,socfpga-dw-mshc" and document "clk-phase-sd-hs"?
> >>
> >> All properties must be documented.
> >
> > Yes, but as stated above, we should be okay in this case.
> >
> >>
> >>>
> >>>>
> >>>>> +       if (rc) {
> >>>>> +               sys_mgr_base_addr =
> >>>>> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> >>>>
> >>>> DT bindings?
> >>>
> >>> "altr,sysmgr-syscon" has already been documented in
> >>> Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> >>
> >> This is not documentation of nodes you are changing here and in patch 1.
> >>
> >> You linked altr,socfpga-stmmac and here you have altr,socfpga-dw-mshc...
> >
> > Right.
> >
> > I guess an option is to convert
> > Documentation/devicetree/bindings/net/socfpga-dwmac.txt into the yaml
> > based format and then reference that binding from
> > synopsys-dw-mshc-common.yaml?
>
> I did not look much inside, but isn't them entirely different devices
> (net vs mmc)? If they are different, then such vendor-custom property
> needs to appear in each bindings. The same as we have for other
> syscon-like properties.

I was thinking that it was a specific binding for the syscon device
that could be shared among its consumers. But it isn't.

So, you are definitely right, it seems better to have a vendor-custom
property defined in the mmc bindings for this. Thanks for your
feedback!

>
> Best regards,
> Krzysztof
>

Kind regards
Uffe
