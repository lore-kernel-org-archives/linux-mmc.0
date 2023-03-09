Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2617C6FD1F
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCIPFb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjCIPEt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 10:04:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54412ED6BD
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 07:02:52 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c4so1710293pfl.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpG+8TjRKU1Xq1b7ChN1vz1PZS008U/FxhApKNmqYlY=;
        b=ELYbTvyRDRvOH8dgBQ/Fwx17+m9R3aqgz5pT7V7fAkZJsA+oV5WiXFMZLcOenBBcbo
         Iomz7JdnKuw/g52XHENDsg9hzunSk4MHravqG2QuI/iiHrQirjr8y73m7ZbBXY/o7vLg
         qvwNTEDQsWU9Of4q0G3fEWJe30V6onvW2a3+JTt/V7Y4xmemTnj3zMSH2yh0yqy6v2Cj
         a/57s24pd09PXcbhcLZVSXqhgklg7hVV+a1VfUTBgAPlfhwUzkjH5KHMImC7zUxFSqTO
         FQHaGZXufx854DG2kV0GcvrLGNTYFThFRHLCUDrtkIwO46cukE2cBALux/qu3ME/ggcP
         lUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpG+8TjRKU1Xq1b7ChN1vz1PZS008U/FxhApKNmqYlY=;
        b=QoSm1vbsvDKv1kWUYJtooyr6Iml/eyCPANz12eq3GZ3+CLYCuja8ng7Dy8qxoxKw/S
         oPi0PM2gyFfXwKq4TXgg7kCeJOHN9BEwZafxJDu4XUtpefG8Ub05CdO5MtVRmFuf0T6Z
         NvgZvNyP1vRDaZK8u6RHkGcSPXvQ3HcAKJoWG6b0RvvhCA9bSobs3JPeNr+ZFN+EyRq7
         yDSPuZXejn7nHuVWY/MQhy4uMQLsHbDgaiEuxDzCvkymGUMgmYwoWG7WUSenhMPQq88H
         MEu6EC31xICeGg9fB8ln35pkj52PyO0yVLLC5/QkpuS9IJTCXKv175g8L5tmsEhz5iXI
         zX6w==
X-Gm-Message-State: AO0yUKW03Mb0GBCTDhIEIJSE3i/2ncVdvMB5pFnmum3iGvnxZlp1P20s
        wbC/2osXY2VkGYcypc0gUJeL51aLJGbioOkhJqvAJg6SE1fiX7RW
X-Google-Smtp-Source: AK7set/Pu4XGzKcyUzu0ET/xIBNGm/Mc7zvqzaKEVvMGZxTLOsJ3vWQd5u10L1Z/1FJ77TF3nXXUVY+1mwvJkbrIn10=
X-Received: by 2002:a63:bc02:0:b0:4fb:d6b9:abea with SMTP id
 q2-20020a63bc02000000b004fbd6b9abeamr7692841pge.5.1678374171737; Thu, 09 Mar
 2023 07:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20230307024646.10216-1-william.qiu@starfivetech.com> <20230307024646.10216-3-william.qiu@starfivetech.com>
In-Reply-To: <20230307024646.10216-3-william.qiu@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:15 +0100
Message-ID: <CAPDyKFp204LOmo9rD7DS5hE=s2jHuFfgsaj05MRzdTKNrscWWQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: starfive: Add initialization of prev_err
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Mar 2023 at 03:46, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Add a incremental updates to fix a bug that prev_err is uninitialized.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reported-by: Dan Carpenter <error27@gmail.com>

I took the liberty of updating the commit message a bit, to try to
further clarify things. Moreover, future wise, let's use the prefix,
"mmc: dw_mmc-starfive" for the commit message header, to be consistent
with the other dw_mmc drivers.

So, applied for fixes and by adding a fixes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-starfive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
> index 40f5969b07a6..dab1508bf83c 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -51,7 +51,7 @@ static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>         struct dw_mci *host = slot->host;
>         struct starfive_priv *priv = host->priv;
>         int rise_point = -1, fall_point = -1;
> -       int err, prev_err;
> +       int err, prev_err = 0;
>         int i;
>         bool found = 0;
>         u32 regval;
> --
> 2.34.1
>
