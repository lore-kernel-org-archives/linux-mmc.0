Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B7C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Mar 2022 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiCHQLX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348172AbiCHQLW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2022 11:11:22 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA7506DA;
        Tue,  8 Mar 2022 08:10:26 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso6822953ota.3;
        Tue, 08 Mar 2022 08:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KyPMfupEleyChJaoF32kD8RM8iDdBNnSag4/WPn+wSg=;
        b=bzt8X3xcdOg/HgtivZ4sumE7NTmxPvMdzAUbSXQSMmFSiOON+8e5sWx1LNe+RhNv/A
         ValLr0RhKJhQ/def9dpVFdxa23Sz1FoezGnLVtLvHAsWyRVexnBGKdLa6KjONXcRZykv
         il6bHCPZ7AekM6HWTF8EUxs0qZY3tTzeCyoUHEsk+kPPCtI/UtHNSHKy+RpgeEfIErpz
         KqOE1QdctzrT7Z2yBOuA30zWThELcHRS3lvqmGAuK9btEuGKYgksNSmqifH6aBiw9S/b
         mmW9XhZMTi99axl0RslceqRfYQfdAzMN1Y/+4CLae0XKXx7s6hmabwedmn8+96u7DDXd
         I3uA==
X-Gm-Message-State: AOAM532KlZT+0FlJ/NQhrfQS0cbznXaunXEr+kecqC53tAQUPzYV3bGA
        RAlJ4QDCPkYNaIGnKEYyGQ==
X-Google-Smtp-Source: ABdhPJyXTiJ+e/GeI6w1oVwRWDTza1x93/zx+7ZIjP9/OFj7HfNrCrfoNhNES3iqqkqU+ttk3AmrXg==
X-Received: by 2002:a9d:20ca:0:b0:5ad:3241:47f0 with SMTP id x68-20020a9d20ca000000b005ad324147f0mr8737395ota.269.1646755825679;
        Tue, 08 Mar 2022 08:10:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f10-20020a4a8f4a000000b00320e5ecfecdsm2957842ool.46.2022.03.08.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:10:24 -0800 (PST)
Received: (nullmailer pid 850672 invoked by uid 1000);
        Tue, 08 Mar 2022 16:10:23 -0000
Date:   Tue, 8 Mar 2022 10:10:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        linux-mmc@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH 07/14] dt-bindings: mmc: sunxi: add Allwinner F1c100s
 compatible
Message-ID: <Yid/7wGcnK6kFu3H@robh.at.kernel.org>
References: <20220307143421.1106209-1-andre.przywara@arm.com>
 <20220307143421.1106209-8-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307143421.1106209-8-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 07 Mar 2022 14:34:14 +0000, Andre Przywara wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> The Allwinner F1C100 series contains two MMC controller blocks. From
> comparing the data sheets, they seem to be compatible with the one used
> in the Allwinner A20: the register layout is the same, and they use the
> same separate sample and output clocks design.
> The only difference is the missing reset line in the A20 version, but
> both the binding and the Linux driver make this optional, so it's still
> a fit.
> 
> Add the new SoC specific name and require it to be paired with the A20
> fallback name, as this is all the driver needs to care about.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
