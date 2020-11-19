Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD6DC6369E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590D92222F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 13:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKSNRZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:17:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44908 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgKSNRZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 08:17:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id l5so5751569edq.11;
        Thu, 19 Nov 2020 05:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t7sOG05xM9btzlntg27DUvchH3mG2VDPpGbU+DsbCFc=;
        b=cI3Rs6aJ6isUzyz3dtX+dgWtn+3R8eVyFGE3aZf32lXmJ5Wd1Dg+0NOb0u5NtOc5xU
         +ILMlrN3aPMszi2b9b285j67VF5MyPEfuGYDC8NwZlerjEsMiLoscdfDos6hR3C4utgp
         bPLoNl3EPIyvoKUqeUjCXSoTJs4ELMupfRW3Ycy28p66ORQBvriA7Ov5vO7k8zyjoCU2
         jYuM9O3eEfiz4FGcHXffpQJci8BDZ7Yha9AaoJbEJZYI2fbiSzGZKJUtR6eToQ/H3Nw1
         Efe2ETYz33hdKxqDkh6UR/huXI3oNBIGv8QwFjQV9kRjBhVwt45pLen0Sij2MVgX83iJ
         8d6Q==
X-Gm-Message-State: AOAM531YF2ifDZvadu/HBsctOQXmRY1JquPtPFsaHPcoWmHHPwOo9sIQ
        36yZj+u9DnL4lTHfp9xqhzbEOYSWaJE=
X-Google-Smtp-Source: ABdhPJxix64srp78pXpbMq7NteKH0ScF2/iuQBMtLnXPaYY4QZkAOD8C/ql84F96YQCkQrTbV7cQig==
X-Received: by 2002:a50:ab15:: with SMTP id s21mr30331183edc.88.1605791843391;
        Thu, 19 Nov 2020 05:17:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id ks18sm3494561ejb.67.2020.11.19.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 05:17:22 -0800 (PST)
Date:   Thu, 19 Nov 2020 14:17:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped
 imx8qm compatible string
Message-ID: <20201119131720.GA348129@kozik-lap>
References: <20201119125304.1279-1-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119125304.1279-1-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 19, 2020 at 08:53:02PM +0800, Dong Aisheng wrote:
> The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
> 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
> Add it back.

Although the compatible was dropped, by why wrongly? Please describe it.
The compatible is nowhere to be found, it is not used.

Best regards,
Krzysztof

> 
> Cc: Haibo Chen <haibo.chen@nxp.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Fixes: 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
