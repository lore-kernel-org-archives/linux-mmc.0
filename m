Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781D5C63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 12:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BEE20DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 12:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgKZMKA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 07:10:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40631 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKZMKA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 07:10:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id m6so1885739wrg.7;
        Thu, 26 Nov 2020 04:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2lwbgkzLOgX8hy8qezRxdBi87KQ1ajnzHG/OJ3/GnM=;
        b=ju/YmTkAYzF56vGEQZfMnZLQB12w3RIMvEs/koHdT5waMWfXSJV14Est1dcDFWY1JU
         jgKbNvEkHCH/Uvr3eom3t0cnFGT134c2OFIZkn/BdQmWeazQgyg6/lg8BRZozj6eK3iY
         vKjKo1UoCvZ/XBpyyl9j06sBZxljUQHzD973kGCMw8oxgbxhzDIKnjDSSjMtmSYxjzMX
         ngVGWdsQX5d+sG2CyKat4+A1/XNeL+966sfzmftW7VK4YCokHdpwgm10C6BsAKn4je+2
         Rw4I+/Wj259yIvT0ENvmAmf0lhSqPEgV2YsEKseqCaVHLfcsPSmBOEAML38aOvWHEQd5
         bi9w==
X-Gm-Message-State: AOAM533qgHsIsp9GXWH3X/Z5t1cDuzUw8a7px5wp9sZBg7+MvtdFmYjt
        jbGgxfh+i0K2VA7fvb+0ruM=
X-Google-Smtp-Source: ABdhPJy2mDQzckZa9jAreobQ3X6QHtEUzOdsfDY5/d8t2pEUum7aBW4vQtal889MOwecncPBoyiBgw==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr3405863wrr.357.1606392598374;
        Thu, 26 Nov 2020 04:09:58 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c4sm8485643wrd.30.2020.11.26.04.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 04:09:57 -0800 (PST)
Date:   Thu, 26 Nov 2020 13:09:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND v4 01/18] dt-bindings: mmc: imx: fix the wrongly
 dropped imx8qm compatible string
Message-ID: <20201126120956.GA36158@kozik-lap>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
 <20201126105900.26658-2-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201126105900.26658-2-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 26, 2020 at 06:58:43PM +0800, Dong Aisheng wrote:
> The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
> commit 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")

"dropped in commit 80fd350b9590 ..."

"patch commit" is a one word too much.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
