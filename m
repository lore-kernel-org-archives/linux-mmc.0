Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF4C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BEA61183
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhKAVIH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:08:07 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:44710 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhKAVIC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2021 17:08:02 -0400
Received: by mail-ot1-f43.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so21244291otj.11;
        Mon, 01 Nov 2021 14:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hF0gq7OZT/2n7lqQ8ZeIkQEJq8W0bUDrLpwtT9xTHAs=;
        b=XpajehX+ccT3ki4D41GAQVQ2zQwrvgh59U2/Cllg97/NQnqyi88x6XYI31Lv0wPCK+
         BHYZpC9zXpt6lJWwEj8WoW1A6zGPKUOw7okwjeIbgnduaAjz0NN4keyw1G1di9tj3bDx
         Xu4l0i/l09MteeLLQKm5xMK+ajb8dep9YmW+2B2SJiTGF2npoQQEXObhcMKOWmu93SWu
         bV8TQD6CnOLt7rYf0It3Jd9kDws8Y5jOvvzqGi2dAT/fRLTMheddqw7tLtSeBFH3BdZk
         dVTP3pj9r3PS7bEK1lUpsQ32sOmZp/J8OIyLzUBK2Q1Pyi+sX5voPB7FWzzSxmuGRbOj
         Wd6A==
X-Gm-Message-State: AOAM531iAEgrVeYmIYHFs0opGhTxv8zItyCLncZPgp22MA7VDXFMzKie
        f0orfHEatTi8USQtfF2uenycO7wK/g==
X-Google-Smtp-Source: ABdhPJzebc4mSKfiSbZ+OzwIzY6vJhGjC2sRd3/DsCnEvgX4/XYs7katMtMQ4C/Jr3FLOWKe45zeTg==
X-Received: by 2002:a05:6830:448e:: with SMTP id r14mr11514551otv.171.1635800728728;
        Mon, 01 Nov 2021 14:05:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q5sm4375431otc.79.2021.11.01.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 14:05:27 -0700 (PDT)
Received: (nullmailer pid 1056273 invoked by uid 1000);
        Mon, 01 Nov 2021 21:05:26 -0000
Date:   Mon, 1 Nov 2021 16:05:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     rashmi.a@intel.com
Cc:     mallikarjunappa.sangannavar@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        kris.pan@linux.intel.com, furong.zhou@intel.com,
        linux-kernel@vger.kernel.org, mahesh.r.vaidya@intel.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        andriy.shevchenko@linux.intel.com, kishon@ti.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, nandhini.srikandan@intel.com,
        ulf.hansson@linaro.org, vkoul@kernel.org
Subject: Re: [RESEND PATCH v2 3/4] dt-bindings: phy: intel: Add Thunder Bay
 eMMC PHY bindings
Message-ID: <YYBWllS8/J9P24uI@robh.at.kernel.org>
References: <20211027115516.4475-1-rashmi.a@intel.com>
 <20211027115516.4475-4-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027115516.4475-4-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Oct 2021 17:25:15 +0530, rashmi.a@intel.com wrote:
> From: Rashmi A <rashmi.a@intel.com>
> 
> Binding description for Intel Thunder Bay eMMC PHY.
> Added the newly introduced files into MAINTAINERS file-list
> 
> Signed-off-by: Rashmi A <rashmi.a@intel.com>
> ---
>  .../phy/intel,phy-thunderbay-emmc.yaml        | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
