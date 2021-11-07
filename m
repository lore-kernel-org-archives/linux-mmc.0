Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3F4C433F5
	for <linux-mmc@archiver.kernel.org>; Sun,  7 Nov 2021 19:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97586113A
	for <linux-mmc@archiver.kernel.org>; Sun,  7 Nov 2021 19:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhKGTXZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Nov 2021 14:23:25 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34516 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhKGTXV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2021 14:23:21 -0500
Received: by mail-oi1-f171.google.com with SMTP id bg25so23586130oib.1;
        Sun, 07 Nov 2021 11:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=r1/wcCU/2X1I1Y5JLtP+b/0PYuwkoBpy63PD+ijntA4=;
        b=sDfEXnMnRmWnvZ3LwFMNxyQkR4vvIMexEljFCodigxeHNxQ3njyk1G7NIh5mz+rQqy
         NiHZezq3C2TWQtaxfB7xvZIQJ2Rkb1I1dSXtyWEYKaW9I2SjOZ2VPd8mDglyQDQHiSjw
         /0sfmOwfrjLaBat55BKYMYR9N8Mu/bxWRfEQYNb4AqkNNhzdC+Z8mhoVFA7RlQw/FOUH
         juebuetITryX8vrV1Ow7F+KV1O7/V107bbMExxyVGQdEwUXKp+igq/NMuCD3M67HrPjF
         cngLy52X8zpijmpNcXHRh7S/jjL4xCh0D7Ri6hdtwg1uPo9r+z55czzKotNHG7JNWuVQ
         gxHw==
X-Gm-Message-State: AOAM531JDX1eSEATioN62oDb2rQsvJIejweu91ZtOdKGvUDFcwa4b/Wv
        9TqeTxfGEiYCuXJCsT/p3A==
X-Google-Smtp-Source: ABdhPJzEUvEsha8d49NX1P6EOkdOY8Nv3eLZZ3xuEKDjM4jFGhTBU1+upmwtuoWD0mh/bp/aKWrBJw==
X-Received: by 2002:a05:6808:170e:: with SMTP id bc14mr34049600oib.86.1636312837939;
        Sun, 07 Nov 2021 11:20:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h1sm2628351oom.12.2021.11.07.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 11:20:37 -0800 (PST)
Received: (nullmailer pid 1404562 invoked by uid 1000);
        Sun, 07 Nov 2021 19:20:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     wells.lu@sunplus.com, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, Tony Huang <tony.huang@sunplus.com>
In-Reply-To: <1636208598-18234-2-git-send-email-tony.huang@sunplus.com>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com> <1636208598-18234-2-git-send-email-tony.huang@sunplus.com>
Subject: Re: [PATCH 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
Date:   Sun, 07 Nov 2021 13:20:36 -0600
Message-Id: <1636312836.425525.1404561.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 06 Nov 2021 22:23:17 +0800, Tony Huang wrote:
> Add mmc yaml file for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tony.huang@sunplus.com>
> ---
>  .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mmc/sunplus-mmc.example.dts:21:18: fatal error: dt-bindings/clock/sp-sp7021.h: No such file or directory
   21 |         #include <dt-bindings/clock/sp-sp7021.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/mmc/sunplus-mmc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/mmc/sunplu-mmc.yaml

See https://patchwork.ozlabs.org/patch/1551671

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

