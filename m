Return-Path: <SRS0=7kHn=62=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EDC2D0FB
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 22:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF0B20784
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589323460;
	bh=4F6QFsajeKzJn03KqzBxlJWS/kGOU/ReZu7YZTM9lFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dePqEprX0qkujAke50eRsxPLztShVdg6v5PKv+T03KdqMrJafqZ7stv7B74T87zzD
	 ba5WQAIAbiUdi1UV1E5CqwMQlpMrgAMYoP3UjzI91xxFaP7VAroDsn5oXnisSH8EIb
	 aaHUb1foJC8Bw/nzSivjC022MX+i6aabXURWVi2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgELWoU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 May 2020 18:44:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39909 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELWoT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 May 2020 18:44:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id m13so11902708otf.6;
        Tue, 12 May 2020 15:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uumrDYsgwLaDX3HJhkdtaUmDr4MtGqDPU0CrAV2rD6U=;
        b=fPoCX/hhbrhSy5yZwtpIiJfDR0sAPxnf2YxEkHYmaoyU1YSQZfPeBsOd8tKJ05VNE9
         RX+oCe61gf27bCSA97qPM9et9p5dNza8B3xo1EqzxKT+oKmmpsg33vjbU0M1Wi1eb4jd
         vnvTD3IM8g/LW7+2/9xLd3eHj9tnKcIP1xLS1k0UHq0kYXVWms2nLVQ4hjg0zxUvQRIk
         REyWw1u6aqOp2OAJrOFFpLZTlMOAzgObCm1Vzeaw9+7BNZUYZDVklx8GsRjW327NeCD5
         oAUOJ52MF8B6kD3ayJL1rZ7rInhdpDSV0yBsMCQavxGQNeFZIFudePdw2MO7wtkLLvUQ
         mghA==
X-Gm-Message-State: AGi0Pua8gq73Thaf5SN84lAb2TIrBy/u7gKrS9Aw0MGu+1ZWfBhVcGjs
        cv9ZjIkQD6f8nqXkjOoT/g==
X-Google-Smtp-Source: APiQypLudLaDx5Hvkugopv+ecKjUtr8tCweVHIWbZyoNgK4NPkO3hFmOEWUVAp12V5dMbReJH6+0XQ==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr19153655oto.267.1589323458777;
        Tue, 12 May 2020 15:44:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w3sm3779500otg.24.2020.05.12.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:44:18 -0700 (PDT)
Received: (nullmailer pid 11405 invoked by uid 1000);
        Tue, 12 May 2020 22:44:17 -0000
Date:   Tue, 12 May 2020 17:44:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, jbrunet@baylibre.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin_1989@aliyun.com,
        lnykww@gmail.com, jianxin.pan@amlogic.com,
        linux-arm-kernel@lists.infradead.org, linux.amoon@gmail.com
Subject: Re: [PATCH v7 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC
 MMC host controller
Message-ID: <20200512224417.GA11220@bogus>
References: <20200512204147.504087-1-martin.blumenstingl@googlemail.com>
 <20200512204147.504087-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512204147.504087-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 May 2020 22:41:46 +0200, Martin Blumenstingl wrote:
> This documents the devicetree bindings for the SDHC MMC host controller
> found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> HS200 mode (up to 100MHz clock). It embeds an internal clock controller
> which outputs four clocks (mod_clk, sd_clk, tx_clk and rx_clk) and is
> fed by four external input clocks (clkin[0-3]). "pclk" is the module
> register clock, it has to be enabled to access the registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
