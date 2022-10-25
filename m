Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5077C04A95
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 10:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiJYKwq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiJYKwq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 06:52:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BAF17F662;
        Tue, 25 Oct 2022 03:52:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 872AC660239E;
        Tue, 25 Oct 2022 11:52:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666695164;
        bh=SzdPiBYNWocdiKOHMHJ7iv+TcTpeRmBI/i9El5W824Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mAOMNf0UO0+7xSfeErCzx3yn5i6/gpXzdqqSp6MLZGVGUgXfzgVCd4hTe3NKjvV75
         cN+NH9qsXKwGuEIKFke8p9cmtFE30ifenB7o9OQncAKZaIu5Gs8fUXIWLm+jQ1S519
         uN6F9EirwhavJzZ0kSPQOoY11tV9S0NPyjPoXhLFQ5Ir++qfyQNKPA/5Ct7Dl1GquL
         UT8Z4Uqc79E8pAAUrX1k9l8V7b5dd5E9M0kfpOMylhL8B40GHA1eJ+glbE/9IeeoaQ
         p1N+5iIU+L9UW1jYf9TkkPBtps3eW49wdaVoaTi0GKp+/YpXcQ4c0fvaN2o7atsddE
         vvDQNCo6dGWGA==
Message-ID: <aae70248-878a-5e36-ad4c-82849a184926@collabora.com>
Date:   Tue, 25 Oct 2022 12:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 6/6] mmc: mediatek: add support for MT7986 SoC
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-7-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221025074238.18136-7-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 25/10/22 09:42, Frank Wunderlich ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Adding mt7986 own characteristics and of_device_id to have support
> of MT7986 SoC.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


