Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A2DC61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 17:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCKRlv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCKRlu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 12:41:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B4F1F5D3
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 09:41:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m6so10689666lfq.5
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678556435;
        h=from:cc:to:in-reply-to:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gucexyEn/MXQiixU059a1/bhO0FmHxte+9JfrT4eP5U=;
        b=j70WkXYg0Rh6B6miG7w3QX0exuvuHc7y6PXZwbZnTgG/Q5z/1PP4ywiFk40F81Ecvv
         FM5mt5wXEHze+VsxWkyhk7EKY2ykblpnje8ddkOf/sQFMxEZwNtIwBir7UbMbnEsdE7e
         xCQSZnQRQ2DwhRVdfvVqYi9wultKSkhgwjZByoIVxzQk0dc0FryBZ7wp/b1YF4fsPrch
         XLTrTaaPvR67Ua+iW1vG5OmiLiCHDxIvpG+jQ7CbTYeW1FmW+p+r2uqcDgwRvpFkzbu1
         1z+fDWFxxheSK8IAE6Xmfi1smH9pnJ0GDO5pzD/lyZPI4EEi1MvnaiK9vZIdhyO5DeSx
         1h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556435;
        h=from:cc:to:in-reply-to:message-id:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gucexyEn/MXQiixU059a1/bhO0FmHxte+9JfrT4eP5U=;
        b=blHJtjRqabU/I6yjKXIsknKnvltb/lXc1RcR0jgWPvMPzZSumtiPD0EkhxnSNykT/a
         30dqf1CPFKUqmWnL5JnS2GkQ9WWrZnTiz48GW20Uw7Odff/7FX66paU4reVYdxEPTC8Y
         ah65z/OmTcc6LcC99Zw+YyJJalrdhiEgTGNoFDTZZprYQSEFV59ezHYv1pA0+m+J9oCF
         b0ztE2RxitBGEk1kHXj+ki6PTjsGfzBCA4inaVTUunwrpSzbWre7gha9adgBIn78Xmnf
         Ji6aTVQMx/ghDauggL9iNUf1tmZETERnMk8DRg6zimPmzlY/RC2C31ljP7HW3Ca2c6w0
         Zy7A==
X-Gm-Message-State: AO0yUKWskkY8MdcA0xAxM6lCmzaY6lH/9kcsyyaX4UaAvSB+qAGnpRJY
        aKnHWaA0M+nmXudcAtrJwIWjVbn9A62C4NCT+gU=
X-Google-Smtp-Source: AK7set/3odt/jEcVTzzidsY1dgjrw8PL1aIfvGyiiY4i3X6gQtGpluDbkvGXVhfBVwApo4cP9jnbCw==
X-Received: by 2002:ac2:4a90:0:b0:4db:2c52:349b with SMTP id l16-20020ac24a90000000b004db2c52349bmr8331772lfp.21.1678556435662;
        Sat, 11 Mar 2023 09:40:35 -0800 (PST)
Received: from letter.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id m27-20020ac24adb000000b004b581ab4c77sm372637lfp.78.2023.03.11.09.40.35
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:40:35 -0800 (PST)
Date:   Sat, 11 Mar 2023 09:40:35 -0800 (PST)
Message-ID: <c13993bc-9d12-f20e-de27-fa0b8a58ed33-1-sleirsgoevy@gmail.com>
In-Reply-To: <c13993bc-9d12-f20e-de27-fa0b8a58ed33@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > ---
> >  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> > index 8dfad89c7..2bc5ac528 100644
> > --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> > @@ -57,6 +57,12 @@ properties:
> >        force fifo watermark setting accordingly.
> >      $ref: /schemas/types.yaml#/definitions/flag
> >  
> > +  fifo-access-32bit:
> 
> Missing type boolean.

Thanks, will add the same $ref as for the entry above.

> > +    description:
> > +      Specifies that this device requires accesses to its 64-bit registers
> > +      to be done as pairs of 32-bit accesses, even on architectures where
> > +      readq is available.
> 
> And why the device would require this? If it has 64-bit registers in the
> first place, they can be accessed in 64-bit. Otherwise these are not
> 64-bit registers, but just lower/upper 32-bit, right?
> 
> Also, why this cannot be implied from compatible? Why different boards
> with same SoC should have different FIFO access?

It probably can be implied, but I am not exactly sure on which boards it
affects, so I decided to go for a new devicetree option. Anyway, the same
argument applies to the "data-addr" property, which is already in the
spec, so I supposed that adding such knobs is fine.
