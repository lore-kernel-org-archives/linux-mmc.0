Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C018EC43334
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jul 2022 15:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiGHPVv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbiGHPVv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2022 11:21:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7AB1C92F;
        Fri,  8 Jul 2022 08:21:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4723660191B;
        Fri,  8 Jul 2022 16:21:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657293708;
        bh=/4l6Hm4ZPFYh5Jg9Pvp/I+AUhyuHpkqerH8ILiSQSbY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PjNsbvhO5bl88hl69hhVHhysA7/8JkOnWdDAwnz/eOlzd1dNw+kpkvZNFzr4vWZ1f
         3UDbtNKz/QpabAffCJKQlG5tsj3DNm0jBrZCOu8rDa54DlKuSscV3xkOAI87pl3C40
         g3yb/lFow1opOw6G5s64o+B5ADo9SyfmwWhaeJ/2Yoc/tN47psP/f59LU7YXKQol9l
         +nCyZfPUYWRnXTXBqwGThXxnf0gWEATVY+ipfYonktwgk2YgBJHdpDu6i1ToWCyjpC
         SykPd2bMqtZ/VWoUsT6bZce9VJsLI22GRC+ppBB8FfMYsR8jcb9MiPI29hywZxmveN
         k9YnxZddOuQnQ==
Message-ID: <b8709679-3c12-22aa-d118-803bcfa8b79e@collabora.com>
Date:   Fri, 8 Jul 2022 17:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] dt-bindings: mmc: Add compatible for MediaTek MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220708114747.13878-1-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220708114747.13878-1-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 08/07/22 13:47, Johnson Wang ha scritto:
> This commit adds dt-binding documentation of mmc for MediaTek MT8188 SoC
> platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
