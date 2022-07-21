Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238CC43334
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jul 2022 16:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiGUQOm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiGUQO3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2022 12:14:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B944088F1E
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m12so2460227lfj.4
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2022 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfRywfpBkkaqnsL05Cdsm5CpXw1RcR8MqqXFBOo3uu0=;
        b=AnLmh8pLCTGjsr0Qktr5XASJQbSB6ocEuGMEH7VUB1TcBqSQ1F33Vt28AOvobo4rUL
         f5yuXS5nu3q+/mkgdtLP7RKWXAOfiTh+s8tJ4NEr23bp7BILn8M0s1aBqAZ972UruMr6
         Jp0gTrhJVuQ0Kyjn1sPKGfWc4b8NuJtfWxy6SCyH8RRrZL9CnLYQtx7mYO37hu0oQC/1
         79hk+DpT4fOTncVhLmpNQVoOu6PmuLwL5qukZe6at7irFwnViYQR2AvKWYACB0fGZ/yU
         wUBL22qm4es8d+LKnLdKDfm8DGQCYHDW5pfWuZyYszZOIhVNkI4qxuhOydKNlXHMODnx
         aLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfRywfpBkkaqnsL05Cdsm5CpXw1RcR8MqqXFBOo3uu0=;
        b=0g1eESCJd5AWEJHIXP50IsdEyh/0LKLfXFUcmj6O6CGj0FI/wi3GKU0+RK/snwl1Vv
         IU7MpU+t4Gp248zfWDGv9mxQuh93rf2VGei4H6Y+JM/7Nn9ib860sawN/GVs1RSD7n4Z
         qKmxp7WnT6z3uUO0z4tcyCHVvjdaKMw65oMXEtVjCNKEnibXwfAms6lNTbmPGpbMKahm
         XqWYNPKv6sXo1+f2N2r06gdg8r/ofHGoPz8IfV45yBy8o3YBHNkRKxq0BvWiVEYrzct2
         OfZ5FPIrZHWIPaQXlq5948/N2gWYb1fatgi+dhpAAbr/x1tvb6I1e76myIdduREv2OXz
         w+UA==
X-Gm-Message-State: AJIora+hm5A/qoF6Es6CQ03dV/6Bz76ZPkavsvkugTbDwC7p+ZBvpsK+
        Sxwoe6IX6WF1B8qVjitPJOqMRq3B4wDadq4xKAr/Fw==
X-Google-Smtp-Source: AGRyM1ubywzWNyGYTWlAuObao8gJRO5/BJzg3myAWQ+ssuW3s3NPP+qlIKkhesD/S30d1QNIaigEutZKrnfHSnsS3cw=
X-Received: by 2002:a05:6512:3403:b0:481:60ae:7ebc with SMTP id
 i3-20020a056512340300b0048160ae7ebcmr23109282lfr.358.1658420032383; Thu, 21
 Jul 2022 09:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220719095216.1241601-1-windhl@126.com> <20220719095216.1241601-2-windhl@126.com>
In-Reply-To: <20220719095216.1241601-2-windhl@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 18:13:15 +0200
Message-ID: <CAPDyKFokJyR3tyAK=3um5yQtFN=oHfXbhv8LnGMEaxA4m10FXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: cavium-thunderx: Add of_node_put() when breaking
 out of loop
To:     Liang He <windhl@126.com>
Cc:     rric@kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Jul 2022 at 11:52, Liang He <windhl@126.com> wrote:
>
> In thunder_mmc_probe(), we should call of_node_put() when breaking
> out of for_each_child_of_node() which has increased and decreased
> the refcount during each iteration.
>
> Fixes: 166bac38c3c5 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs")
> Signed-off-by: Liang He <windhl@126.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index 76013bbbcff3..202b1d6da678 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -142,8 +142,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                                 continue;
>
>                         ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
> -                       if (ret)
> +                       if (ret) {
> +                               of_node_put(child_node);
>                                 goto error;
> +                       }
>                 }
>                 i++;
>         }
> --
> 2.25.1
>
