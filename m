Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482BCC433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1628D610F7
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 16:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEJQR7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 May 2021 12:17:59 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44674 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhEJQRx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 May 2021 12:17:53 -0400
Received: by mail-ot1-f49.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so14907056otp.11;
        Mon, 10 May 2021 09:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrcqbsyKBAhq77Sm8CjIWowkf8WymhxPZxoEz43q6O8=;
        b=ZxgYbaj4ieRZrzO2t0VkA9o8+2gc0VW8ZEbiqWmn3Ij2jVMJa8L0ewTPh8hG4e8lsl
         EIXxZW7bucyB9fr21/vpxUpOyvnzSjKGMCs74MOAbyDg30IOBrkG98QmgZGDfNSkTLRV
         kgdzBRoszFdDdpNNQ7JV0QrQLd/k94rNdSuQrpvyKIELGNGoahixsa3+9HEASQDDSEKz
         ZOAeFMmnFtR2rVed9Ix4DtBzt3keAQYvd8C/GHo0qES73OlgJUAFKd6IC7hL0iAHVE7T
         deMJyryW5IsFxpL8zCw6TON8alefWZQNX53gQDvNM+2CH91daNtwaPACezJVo/48nWm0
         Amdw==
X-Gm-Message-State: AOAM531drauM8wyyv4wrZNm4Ygp1ymv6AvX7XBHZLosx7fnUhWeu+8sZ
        fDHuO8rEXzx7flfjfurnHg==
X-Google-Smtp-Source: ABdhPJzso8melaggO++aFIWeh86OeFUvHG+pnNX61c2NBBnz3Lalt8pOb7JM8tRhjBofqZZEeF5KbQ==
X-Received: by 2002:a9d:754a:: with SMTP id b10mr22341197otl.359.1620663408529;
        Mon, 10 May 2021 09:16:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i130sm2724994oif.49.2021.05.10.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:16:47 -0700 (PDT)
Received: (nullmailer pid 222668 invoked by uid 1000);
        Mon, 10 May 2021 16:16:46 -0000
Date:   Mon, 10 May 2021 11:16:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <dev@lynxeye.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add no-mmc-hs400 flag
Message-ID: <20210510161646.GA222624@robh.at.kernel.org>
References: <20210508205658.91105-1-dev@lynxeye.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508205658.91105-1-dev@lynxeye.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 08 May 2021 22:56:57 +0200, Lucas Stach wrote:
> HS400 requires a data strobe line in addition to the other MMC signal
> lines, so if a board design neglects to wire up this signal, HS400 mode
> is no available, even if both the controller and the eMMC are claiming
> to support this mode. Add a DT flag to allow boards to disable the
> HS400 support in this case.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
