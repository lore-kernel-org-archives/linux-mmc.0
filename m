Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF95C49EA7
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A3A613C7
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 20:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFXUtU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:49:20 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:33768 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUtU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 16:49:20 -0400
Received: by mail-io1-f44.google.com with SMTP id a6so10002036ioe.0;
        Thu, 24 Jun 2021 13:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0x4IyKT2x+eXf6Aevlji6hFmmkziyiUYw8K70PDgcc=;
        b=WaIhv0iy648C4MlmzPSgg8I9lrXIRBe+8KAULYY/bRermCCNnQyw2i2W36AM1jNS+k
         4I/0KJ59FAopQEDIbByFALMFxu3gQLv1HIrGTUHQOTRwhE5vLAh3+ggqeZ2joakh2qgQ
         hCdDOdAeIbyzw8ACdtFDP9wP3taUUYt4QrJe1OdNqeWiHlXjaLaPuVjhsDZP+qcuE+yC
         m2KAwimnc7/iVu0UTl8q9E8qluID9Wj5N/J+OzcWg9njqf+oXTUtEvJERVVukEKM7EVI
         WVcQDnki6WN30u7M63N/W2jXLmrXtTaz6ahlYD2TLnF3j381Ci88ZaYFu3DI0ZVJqodL
         FG8w==
X-Gm-Message-State: AOAM530QWpfMb/B4ZxdkB0atre/i/D4AdjFxwiRdsxCG+0b8flRC5B6e
        SrI8zK2wVfuUN0iYUkuygg==
X-Google-Smtp-Source: ABdhPJxP/WQNIhGKFN6SWUFmmpwOJftdPFMIatfnXDGwKcwWhakNCpsdPciM/vUKfsSrKJLq/dXC4w==
X-Received: by 2002:a02:c6d9:: with SMTP id r25mr6248042jan.137.1624567620217;
        Thu, 24 Jun 2021 13:47:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q7sm1883511iob.49.2021.06.24.13.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:46:58 -0700 (PDT)
Received: (nullmailer pid 1960808 invoked by uid 1000);
        Thu, 24 Jun 2021 20:46:55 -0000
Date:   Thu, 24 Jun 2021 14:46:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1] dt-bindings: mmc: change compatiable string for
 MT8195 mmc host IP
Message-ID: <20210624204655.GA1960751@robh.at.kernel.org>
References: <1623726033-16073-1-git-send-email-wenbin.mei@mediatek.com>
 <1623726033-16073-2-git-send-email-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623726033-16073-2-git-send-email-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Jun 2021 11:00:33 +0800, Wenbin Mei wrote:
> MT8195 mmc host IP is compatible with MT8183, and currently it shows:
> properties:
>   compatible:
>     oneOf:
> ...
>       - items:
>          - const: mediatek,mt8192-mmc
>          - const: mediatek,mt8195-mmc
>          - const: mediatek,mt8183-mmc
> which means the compatible string in the device tree would be:
> 	compatible = "mediatek,mt8192-mmc", "mediatek,mt8195-mmc",
> 		     "mediatek,mt8183-mmc";
> The bindings is wrong and that isn't the result we want.
> instead we want:
> properties:
>   compatible:
>     oneOf:
> ...
>       - items:
>          - const: mediatek,mt8192-mmc
>          - const: mediatek,mt8183-mmc
>       - items:
>          - const: mediatek,mt8195-mmc
>          - const: mediatek,mt8183-mmc
> which would give us:
> 	compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> and
> 	compatible = "mediatek,mt8195-mmc", "mediatek,mt8183-mmc";
> 
> Fixes: eb9cb7227e5c (dt-bindings: mmc: Add compatible for Mediatek MT8195)
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
