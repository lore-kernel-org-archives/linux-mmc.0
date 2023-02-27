Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1ABC7EE23
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjB0Pc1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjB0PcI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 10:32:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FAAE3B8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 07:32:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p6so6256148plf.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vzLIC74mB4AwHY8XZKujyRlKy1H/v8jLcorp2jlzWKI=;
        b=rn2fD9rsD+flcfwbZ84UDOjziBTFna+IHPFzXHCPW1Yzl4fraiAdSBPnSJyrxvCOLB
         92iPch09wt00afbcOo/z92y+270U/I8xPA1HmCsvRioGbFgK4eV7IYUqHZNeh6NeIAuX
         JYgz5bOAQrkTqd9Yi8gjFD62Mvn/LfZ9nLh9DxzINU63gJJfTRnnzk6ibXC1N0xvt0zn
         CZNBVGnU1NVzWfshIig6wTqCwSQsPBh+oYa6pehfaTwmYnIgfAZC23UlBjvmWXq/CxU5
         466+NRjzW1Zibn4WN1YfwH1grqJRpdONzLm27Bw8Btuk9yCZRWBhXp1AEujakFQDVH1m
         nxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzLIC74mB4AwHY8XZKujyRlKy1H/v8jLcorp2jlzWKI=;
        b=37p0wtk2pbrpzm8/PyWRsbfU59Sox0+iJ0e6lpY1EjmGo2djrLZOSjT5wNArpokuw3
         hRsLKAMyhB62KR+2PNs0k180einCZfdnN//nvsV676NetDSBkVeri06tRuL2GnKWcZE9
         JWqpPz5vHPd5QfCxkceWk1I9+DSfUOmRsr6F9+Uu/33oYuWyKqAnXeKGDZv4xrrBj9Cs
         hfy0C7lIvGsfbHa/F7qF6jWfNjnRhC+EJhIRMW1JsTtoNEL21p8pTV60+yj6MhmQXmpu
         VxNL1sbdFjVYuc17Nlk2NDSZBKapDd4DdPCr06lVIMpVG3p1pI/Q9xYs1zRv59E+xwA0
         nBHw==
X-Gm-Message-State: AO0yUKVFiCkv6H3JsLNn9CIDApPuoPwUQShBJN7/2LGGnBrxJ+vSTVQf
        IMuSl0gIOQiUXa9+vi6tubr13KmF5nL4yngGoyyF9w==
X-Google-Smtp-Source: AK7set/ieFVvPk5OsQRJ/WKQ5w2et0AxhClz7JOXVNp6TN5ekbvqgj9/a9oDkKRVv7jSrVMImvXaObbch9JIl078zXs=
X-Received: by 2002:a17:90b:fd8:b0:236:855f:f9a8 with SMTP id
 gd24-20020a17090b0fd800b00236855ff9a8mr4890098pjb.9.1677511926439; Mon, 27
 Feb 2023 07:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20230223141402.23979-1-swati.agarwal@amd.com> <CAPDyKFoGmHpdt5UckyDTWQSK7OmZ789g9Owz7sPP4VJ6ezJbsQ@mail.gmail.com>
 <6e037df0-8f59-9277-3f40-c22278e02430@amd.com>
In-Reply-To: <6e037df0-8f59-9277-3f40-c22278e02430@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 16:31:30 +0100
Message-ID: <CAPDyKFoJUS01wFVPbri05SdJa-Y5qhmBxWnnXFUGnsm+zCpUfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate" clock
To:     Michal Simek <michal.simek@amd.com>
Cc:     Swati Agarwal <swati.agarwal@amd.com>, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Feb 2023 at 16:09, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 2/27/23 15:56, Ulf Hansson wrote:
> > CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> >
> >
> > On Thu, 23 Feb 2023 at 15:14, Swati Agarwal <swati.agarwal@amd.com> wrote:
> >>
> >> Add support to read the optional "gate" clock property and request the
> >> clock which will be used to ungate the DLL clock.
> >>
> >> For Xilinx platforms which has DLL module, dll clock must be
> >> ungated/enabled when SD controller operates at higher frequencies like 50
> >> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> >> clock from the driver.
> >
> > I guess we need to update the DT bindings too?
>
> DT binding has it already. It is just not used.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml?h=v6.2#n110

Aha, thanks for the pointer!

Kind regards
Uffe
