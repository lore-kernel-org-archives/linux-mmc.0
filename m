Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA419CA0EC3
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 09:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjILJMw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjILJMv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 05:12:51 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B282171A
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 02:12:47 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 624CA3F639
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694509966;
        bh=XqCmz97wiINzvOoT4WgJ0jIs9/XOEFkVGg6FT5TVn8s=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AfP5do/6J5GIGAwXM5VWuPUlh1EAWHOhJdVtno3OjG1ctcBXJiQZatDq7avxUPtqc
         2lwZsaguzKfck41ndLSI+4HTawnb00sAKqFBUERkuZXcjCWUB4dPF10dulYGE95gMP
         8ymATo9/kgFeC5c9aD2/VGUFEXA76xfLUQlDNtRIeFuyPb9U3Zksy6yV6Cwvj8CJ3a
         qU6IBKt6cYWDnPFk693yUHf1D7W9ltKxNJ0bREg5Vi/ZXZPowZkl59OWjLP6EnIokN
         pNOPG38WgUVRro62gfOyFu7L6Cb+CxNMBv38r8n3xh5eyq9STldtYAzaqmPuHT2yLc
         SdvZWNjDZcZDA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-414f842870dso61420871cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 02:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509965; x=1695114765;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqCmz97wiINzvOoT4WgJ0jIs9/XOEFkVGg6FT5TVn8s=;
        b=ct2uf7F56tikDg2Op062MLNOua3U7+uKsEyVTPUrYgdBVvwk3LqW/EFqBzWXydTYIL
         bjWlb1/cQMYlAj31ttM/2T8kN7r19TpWABt3G30QCRlAqWxvAJrV8bEEzB6Jj1xJC3uI
         6fnOT3zslQpaA+sxXQ17plhQ3BpZQo0OmZ0y4H8a+KMYDaplfpHqdKBKnXjicDxU/Ip1
         XtFwmYmZWanSqFvxlA0v0xlYz/DcyBGZTmpuIAqPmRw8LlfyEdKsFw55fnKpwgaJEnhC
         YmpcAto2YiwRRLrNbCX6BprY4Zw7g5wb/pK8G0ziqzWxzX3QkleX2E3x1tNdfF2KO/jI
         gUbg==
X-Gm-Message-State: AOJu0YxFtk6ukoJnZGosGR6WMYL/FIb+FQe7Bbyy1sgOpXJgkmANBSk3
        tbEMp4mJVl3ZfGTFYN3DXprafcasV+/jLC8nLIwBj2HqiIHrr+X/zjxFLkhZVU3RIT7XLw7iLtX
        8dQFRsGzgh4IN7ixPFRJvmOUayvMJc1XsuzGHj1gSzBTzf/UQvevkOQ==
X-Received: by 2002:ac8:5a89:0:b0:412:1c5f:4783 with SMTP id c9-20020ac85a89000000b004121c5f4783mr15578483qtc.10.1694509965372;
        Tue, 12 Sep 2023 02:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQQlGlQgk/r9shaDmrB/tSYmyaL8Wp5LDCM9Gtr+QkolQC9uKaGfomkgojXdkeuMHTeIyAFpf8bRY5ZqnJUC4=
X-Received: by 2002:ac8:5a89:0:b0:412:1c5f:4783 with SMTP id
 c9-20020ac85a89000000b004121c5f4783mr15578458qtc.10.1694509965100; Tue, 12
 Sep 2023 02:12:45 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 02:12:44 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230912081402.51477-1-william.qiu@starfivetech.com>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Tue, 12 Sep 2023 02:12:44 -0700
Message-ID: <CAJM55Z_NjSVwCcS0MfHw3mAwsBuScAU0OXX1Ga1+TfQNHKB7Vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Remove properties from required
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

William Qiu wrote:
> Due to the change of tuning implementation, it's no longer necessary to
> use the "starfive,sysreg" property in dts, so remove it from required.

nit: again the device tree should be a description of the hardware, so the
justification here shouldn't be that the Linux driver doesn't use the field,
but that it turns out the registers aren't required for the peripheral to work
properly. Don't respin the series just for this though.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> index 51e1b04e799f..553a75195c2e 100644
> --- a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> @@ -55,7 +55,6 @@ required:
>    - clocks
>    - clock-names
>    - interrupts
> -  - starfive,sysreg
>
>  unevaluatedProperties: false
>
> @@ -73,5 +72,4 @@ examples:
>          fifo-depth = <32>;
>          fifo-watermark-aligned;
>          data-addr = <0>;
> -        starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
>      };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
