Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94BC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Mar 2022 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbiC2MuB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiC2Mti (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2022 08:49:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B41B2;
        Tue, 29 Mar 2022 05:47:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BCB281F43E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648558073;
        bh=tJzMYOhX+6l/q9zZjN+QPrd8ljoj0rb7a1tgDfRrPbE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O8GNe3VfKg3pYdZ1I8sCYquUFd3JTXG47fVyk4/DELPOhaEyYXPaqqCMaQRum5ABL
         nLTj/0NFPa6rsIOqyIbVU0WBvKCO/ed/kSqGLCT5Dw33SMxA+BReycYTJqX4wEY7t/
         EZwqjhi2wfNLtxbPYZCew6QiDqDOIsfO/5vhk9ZQ6lGYiTKZ4pVNKuj9Y2ciqIJhuz
         t4FXcLiZ1QQmo9J0TC/B9hsLFIszOpTvq9ezpMZNaHUnoqeMiZCYw5EXZrF/IcchM9
         NCVD/dDFRANMa3ojLk4nDut1LDYowr0eIuTU+zLw3hNpbqvQCUChfDSTbU+7cWteW1
         7gmzR+I7KPV6w==
Message-ID: <97f2b11d-15c7-d28e-f7b5-e65f2f333580@collabora.com>
Date:   Tue, 29 Mar 2022 14:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 1/3] dt-bindings: mmc: mtk-sd: fix yamllint error
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
 <20220329114540.17140-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220329114540.17140-2-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 29/03/22 13:45, Tinghan Shen ha scritto:
> Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>    54:81     error    line too long (95 > 80 characters)  (line-length)
> 

I can't reproduce this error that you're getting... this commit is not
necessary, as the .yamllint file in the kernel allows a maximum line-length
of 110 characters.

rules:
   line-length:
     # 80 chars should be enough, but don't fail if a line is longer
     max: 110

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/.yamllint?h=next-20220329

Please drop this commit.

> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
