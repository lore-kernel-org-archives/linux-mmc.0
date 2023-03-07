Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E845C6FD1B
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Mar 2023 12:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCGMwg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCGMw0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Mar 2023 07:52:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C057EA2A
        for <linux-mmc@vger.kernel.org>; Tue,  7 Mar 2023 04:52:07 -0800 (PST)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 546653F591
        for <linux-mmc@vger.kernel.org>; Tue,  7 Mar 2023 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678193526;
        bh=nmWr6ekGjQZxJ+Q7zdHZXafHGNlXxBrbViGkz8bn1+c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HW4d0JXq8/NOQpK+uYGqtLow9FuTQ0hec+KBDX0jbd3ron+mwaz/ZZ/kt1UEqF5+L
         BvwY+XN/SH3QEBLn4rvul478UcfBrM6S27xWZHk81tvGUqVEMU7rLpy9LfaoXXnlzO
         KzcAVjGv3mwRx2l11+ogLbjQReZN9GnYBHHAaFgxImTO1fseHRAqYg0zHPnmMrUIUc
         PutfpxWF/RtYVZcm0zuq+R/mwRrkhJAbiyWdB3EBcsfouvHd/6CWk9QXlyjuBA2UwK
         4tuxjD10LsKQTVoyIwkySdOV/l3vvQVggsW9nW6br6HO9c+3xkaOFq7dWSnlaEpwyd
         8kPpErUXrWQ5g==
Received: by mail-qt1-f197.google.com with SMTP id t22-20020ac86a16000000b003bd1c0f74cfso7047574qtr.20
        for <linux-mmc@vger.kernel.org>; Tue, 07 Mar 2023 04:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmWr6ekGjQZxJ+Q7zdHZXafHGNlXxBrbViGkz8bn1+c=;
        b=th7glf5/bsoXO2sgDI/EjxUdqDEAyKzyYW8bKm7YbEIpq+F7JBrQLErkAPeP/R5FNI
         NQ37QmH1oUmqUUi4VxYOprlc29lZK60mC/3PDdCWxSJFY1OpRlc1DRw++1mD1EtUJJld
         BlE7Qsle2/8K9gVEuk3dipleUK3MgWJIY8elCPxIO78jnq+zzWahKUXa3kGLsxB94A+w
         G/sPQRpuJD1/y1taxKen23z09PcTEQur6F0sh62l4E+WVd3/+mh0Yb/t4/Y5iM1T+rAX
         2vBv+lIH8+NAsYRPYkXUHX1j46VNPMKSxjMk220bw5x5gL759yF9SZe3SXO2HjN3sTL/
         HfgA==
X-Gm-Message-State: AO0yUKUAp4y7U0BtmrSznjIH3dp1zy35josNqrl445LIXKj7nCgpdAF1
        zbcqWFbbF6Y0cEG33CEnHJfUKbW09//MnOwBq3LpXI6PZfnh8jqx3mqNTjTEUjUPe3VPFWw7BdG
        ovk+gMQGjmw+5IBtydM911ydVk0xfQJgOK1hiq58g2AOxIdcAEgI3gw==
X-Received: by 2002:ad4:4e28:0:b0:56e:b446:34f1 with SMTP id dm8-20020ad44e28000000b0056eb44634f1mr4079232qvb.5.1678193525414;
        Tue, 07 Mar 2023 04:52:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8EvyNc/L3E70dvuWathZFkQOqKVEkT1IIx0wT1ixr8AJw2s+ppYU5aOJDsokfzAi4ghyW4HUFDQpSET1IIO54=
X-Received: by 2002:ad4:4e28:0:b0:56e:b446:34f1 with SMTP id
 dm8-20020ad44e28000000b0056eb44634f1mr4079223qvb.5.1678193525129; Tue, 07 Mar
 2023 04:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20230307024646.10216-1-william.qiu@starfivetech.com> <20230307024646.10216-3-william.qiu@starfivetech.com>
In-Reply-To: <20230307024646.10216-3-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 7 Mar 2023 13:51:49 +0100
Message-ID: <CAJM55Z_mzzAW52RMC6cfgiKNLicF9ip74csbsrbikE3tN+taaw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mmc: starfive: Add initialization of prev_err
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Mar 2023 at 03:49, William Qiu <william.qiu@starfivetech.com> wrote:
> Add a incremental updates to fix a bug that prev_err is uninitialized.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reported-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
