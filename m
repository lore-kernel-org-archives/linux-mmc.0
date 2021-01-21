Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A9C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F29212CC
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbhAUQcB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:32:01 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39390 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbhAUQCy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 11:02:54 -0500
Received: by mail-oi1-f176.google.com with SMTP id w124so2620220oia.6;
        Thu, 21 Jan 2021 08:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PD67+q56IeIWwh9EcTTNcTtnquhiZRr+vB5SR3iRFJk=;
        b=MZXLHVFSFTcEcRL1w3Hx66YcsR03KGd27c3d/l6/XaHet+QsLaKmZFM82DE3a92Vkj
         yul6zt9JCt7VRhc4ZI2iuPeJ0EWeg1JhRic5QN6305D14x9Us0KI27xLF+gT+Ci9S/Zv
         Fe0bY1Lx5WY+Yi4nyLamweW5MSY8r7T2qqRkB4gtr3w27z/i9RyBmQi+FOEHRSm/TpkW
         izMmu2RkHCqszaMUYAmko+xxcRejQs+xAr7+6kBOj5JboSBERLTgExxXpeKNF9pQhOM+
         Vqun3tTs76KBAZckqBlK0OXlohGduhoiqiE860eF3E8axbBQvcxCBYO08LjPLELfv5AG
         93lA==
X-Gm-Message-State: AOAM530sc+aOqY0EuifNK9Nzoe5BTvQk8EkuUtgeI1wAi+Q+7gfa4BnO
        GP82kPwvJ/UbrhZaRB9PvA==
X-Google-Smtp-Source: ABdhPJyvXB9rRhGO02XjfCZa3hxB2PIUYgQ37EJIgD33OLAmbwcyZt+AucqbzdlDxGOYHSpEfQFISA==
X-Received: by 2002:a05:6808:158:: with SMTP id h24mr142023oie.135.1611244933771;
        Thu, 21 Jan 2021 08:02:13 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm302686ott.64.2021.01.21.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 08:02:11 -0800 (PST)
Received: (nullmailer pid 2814848 invoked by uid 1000);
        Thu, 21 Jan 2021 16:01:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     linux-mmc@vger.kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, ulf.hansson@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, adrian.hunter@intel.com, s.hauer@pengutronix.de
In-Reply-To: <1611198593-16287-3-git-send-email-peng.fan@nxp.com>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com> <1611198593-16287-3-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
Date:   Thu, 21 Jan 2021 10:01:58 -0600
Message-Id: <1611244918.545866.2814847.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Jan 2021 11:09:51 +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add clock bindings for fsl-imx-esdhc yaml
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: clock-names:1: 'ahb' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: clock-names:2: 'per' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

See https://patchwork.ozlabs.org/patch/1429619

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

