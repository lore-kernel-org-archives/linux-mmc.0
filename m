Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA1C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Sep 2021 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855CE60F9C
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Sep 2021 19:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhICTq4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Sep 2021 15:46:56 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38683 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhICTqz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Sep 2021 15:46:55 -0400
Received: by mail-oi1-f176.google.com with SMTP id u25so505815oiv.5;
        Fri, 03 Sep 2021 12:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqgPSH01uLhwVy8qHZMEBTkuJiuHbtZXBvN7UqeK0QI=;
        b=C26RfHRaE4+D35LohPYstv67BjpV3ls2JbBZTwe3ZSxTaSpOizcxPpcMf5nmW0ADHw
         qsO3jXHYudxd0U3c+If6/ogGyk8oj5qfzVHiqBEQysqaREDnFarzUI0z7sKg+ZZNS0mQ
         +NDuewsLHzRdpv2EznosSiLgmD/mz+EiLR5heXcFWZqe161qcxdCx6U9RhI1BSRKRmFv
         E4LPoZNzNuqBWj1hB8EVfELdn1xw+x0s766bAPKzoBTLcxBb+L9UW1YzWiTfzUdvuhp4
         t7fB2hiY14VaN9HiE5uP14IMCnnTqwljfnsXZVtizheFDu8DQH2H6vssJshEVTfP+ya7
         ftNg==
X-Gm-Message-State: AOAM531i9admwyeI7cTnFEXa6Vp+kRRxBBNm66Uo+Ulg64C7HrAx4ksq
        jYu8oWLiCIFKl1zQnuUBxrFd5CDCAw==
X-Google-Smtp-Source: ABdhPJzagHsU0ZnvYW4iKxXcqheTTOlORsdFiMbftW50LobXJys2f6cnvYGQ25neQcLF7xJ7+PBfAg==
X-Received: by 2002:aca:3bc2:: with SMTP id i185mr311051oia.67.1630698355086;
        Fri, 03 Sep 2021 12:45:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g8sm64057otk.34.2021.09.03.12.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:45:54 -0700 (PDT)
Received: (nullmailer pid 3340272 invoked by uid 1000);
        Fri, 03 Sep 2021 19:45:53 -0000
Date:   Fri, 3 Sep 2021 14:45:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-sunxi@googlegroups.com, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 30/52] dt-bindings: mmc: Convert MMC Card binding to a
 schema
Message-ID: <YTJ7cReisyxIE6Cy@robh.at.kernel.org>
References: <20210901091852.479202-1-maxime@cerno.tech>
 <20210901091852.479202-31-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901091852.479202-31-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 01 Sep 2021 11:18:30 +0200, Maxime Ripard wrote:
> MMC Cards can have an optional Device Tree binding to add
> non-discoverable properties.
> 
> Now that we have the DT validation in place, let's convert the device
> tree bindings for that driver over to a YAML schema.
> 
> Some of these properties were already described in the MMC controller
> binding, even though they are not generic and do not apply to any
> device, so we took the occasion to fix this.
> 
> Cc: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---
> 
> Changes from v1:
>   - Fixed additionalProperties
> ---
>  .../devicetree/bindings/mmc/mmc-card.txt      | 30 ------------
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 48 +++++++++++++++++++
>  .../bindings/mmc/mmc-controller.yaml          |  6 ---
>  3 files changed, 48 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
