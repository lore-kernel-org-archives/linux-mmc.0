Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE2C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jun 2022 21:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiFNVRC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiFNVRB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2022 17:17:01 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635A4F9C7;
        Tue, 14 Jun 2022 14:16:59 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id s1so7555076ilj.0;
        Tue, 14 Jun 2022 14:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZxFnOn/etis5V4OgRvXPWEzaEmDBFSJemPFkXlvs0E=;
        b=ewKMnTCWIFx153zl6j575TfDMmPvE2U8HxucGyVs7/vcpRp1h3Ur7RM+MRrj9BhS6W
         pFufeE4q/HX+kwk0y549hkOKbGbvX4yx0ndD46/dBJiAD8pH9Pz1ovl2m/uKvOhI4vd4
         kPQyU+ycbHGSuGP9ycnbMaDiFA/Tiooht99CplyezmTMH6ODd7Pedvy4K68tmj5PS1Ck
         hfV/aNk0GMeAm0v8FZWMB/4yImbDGp/Zfy1Hk2rlL7pFjsxcLRuxbCORaQX6zRqms3xq
         Oh8yjIF67t4/haquZYuoUsXDKh5DFBj96rJMLL67imZwSuWaYT5ErXinJGjXtXNkCVkF
         ZC3Q==
X-Gm-Message-State: AJIora+vje8LJ3iFtaVgV+LG25iQoXykQcxkbsKmRsKbAGNOTkFTYw47
        HfeCBdX5nMWYFc7Op7CNaQ==
X-Google-Smtp-Source: AGRyM1sEvlPTrV+frVbq2JFD5krZSXbkV7wqDerH3Abq4vk/1Vo7YPBM0wEbQmENv3/g0h0Nlq4uUA==
X-Received: by 2002:a05:6e02:d01:b0:2d3:bc87:8e19 with SMTP id g1-20020a056e020d0100b002d3bc878e19mr4054538ilj.183.1655241418655;
        Tue, 14 Jun 2022 14:16:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e15-20020a6b500f000000b00669de60a268sm3818483iob.21.2022.06.14.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:16:58 -0700 (PDT)
Received: (nullmailer pid 2627316 invoked by uid 1000);
        Tue, 14 Jun 2022 21:16:54 -0000
Date:   Tue, 14 Jun 2022 15:16:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     devicetree@vger.kernel.org, catalin.marinas@arm.com,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, blarson@amd.com,
        broonie@kernel.org, gsomlo@gmail.com, rdunlap@infradead.org,
        ulf.hansson@linaro.org, will@kernel.org, alcooperx@gmail.com,
        fancer.lancer@gmail.com, p.yadav@ti.com,
        linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
        samuel@sholland.org, thomas.lendacky@amd.com,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, piotrs@cadence.com,
        brijeshkumar.singh@amd.com, krzk@kernel.org, lee.jones@linaro.org,
        gerg@linux-m68k.org, p.zabel@pengutronix.de,
        adrian.hunter@intel.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 01/15] dt-bindings: arm: add AMD Pensando boards
Message-ID: <20220614211654.GA2627093-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-2-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-2-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jun 2022 12:56:44 -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document the compatible for AMD Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
