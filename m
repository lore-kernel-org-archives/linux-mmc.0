Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB2C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jul 2022 23:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiGYX0C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGYX0B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2022 19:26:01 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A59D1181E;
        Mon, 25 Jul 2022 16:26:00 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-10d6ddda695so16823276fac.0;
        Mon, 25 Jul 2022 16:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v54UcLfyNQ1djxWgf+PNCyjRPCvW5pNaYLYPVrtUUVk=;
        b=YBEVOUOcBLOeFHi91pfy5TgWlqHoyjuPHFaxqWHBXPPvPAYIsWPu7DZH4mxjIrNjGg
         Bc6GAC0YClpWOL7O9YtuPWlfHMYp/0tjkRlD4k1CS6JSG5aaPasDUyDhrkcXf0Vqh+P9
         W0xz6cOq7Vn9OQPldK5079p+yM4XanoBzsvpYa5WTJtotm48SRuOixbGSZNxDolKQ9uf
         Ro0kbb27856WJv2JzSXmBHOZTSd9OE17g/SBOmGDY+9Qeb/L0jSVlV54UarvVfi0q3HS
         WznLQQYznbxE8gN1UxBkjkjdI5Jvi8IQRkEdAND7aWbRNi5hKKWEDsyPdO2nC+tQGrdA
         DoNw==
X-Gm-Message-State: AJIora8TecVPw+uvQCPILd2qz+8i5MxxxEc9YKXcDpSd3ZmHq+xjPfR5
        jGbhfpZ1zc2PlPT1Nlug0w==
X-Google-Smtp-Source: AGRyM1srtAmK8NHbVXrYUZ4su3pd3Y2epHDoAbNdb6EhMrK2frR71syluwbeuW9KB2n+NGTbMVMdiw==
X-Received: by 2002:a05:6870:344c:b0:10c:236a:79f8 with SMTP id i12-20020a056870344c00b0010c236a79f8mr15912644oah.24.1658791559772;
        Mon, 25 Jul 2022 16:25:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f2-20020a4ad802000000b00434ace74464sm5351784oov.16.2022.07.25.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:25:59 -0700 (PDT)
Received: (nullmailer pid 2951881 invoked by uid 1000);
        Mon, 25 Jul 2022 23:25:57 -0000
Date:   Mon, 25 Jul 2022 17:25:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 11/22] dt-bindings: mmc: rockchip-dw-mshc: Document
 Rockchip RV1126
Message-ID: <20220725232557.GA2951823-robh@kernel.org>
References: <20220723204335.750095-1-jagan@edgeble.ai>
 <20220723204335.750095-12-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723204335.750095-12-jagan@edgeble.ai>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 24 Jul 2022 02:13:24 +0530, Jagan Teki wrote:
> Add a compatible string for Rockchip RV1126 SoC.
> 
> Cc: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
