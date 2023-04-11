Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FD7C77B6F
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Apr 2023 08:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjDKIZb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Apr 2023 04:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjDKIZM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2023 04:25:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C799549D9;
        Tue, 11 Apr 2023 01:24:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6896266031E7;
        Tue, 11 Apr 2023 09:24:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201446;
        bh=Pw0IrMdaMdA9oWbbOHevvqTZ/sbUrBeKNCA7BRFp8EE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P7t1MlhdDHaW/8S0o7/grLftPNGlVZr/zlEIuEX/EOgBvh3+HnpPm4DmhXsD3XWlm
         iFYqm8E8tMogrwQjkqKQmBNEDwpQ9wntEM2j1sSWpmJVIVMLZrofXupVmHFukmR30t
         VLLCrqcgtgWpkRSbIgOuoOfSIuncBW/82SCXWKbbtjTSFs3uLR5PfWD/IdeWYfEMhp
         Fw+nJ8SV9A7LIDwvD+wsvE4LpLS7AFBfGlLZQhnCMyQKV7wruXgOB2ZRxfltem+CB/
         RWllW5OLoUJqyaVLo5bulpJEWgeeZtwX5r2iw/RxTc1ysrhDCSInDXSSyL9+Hx9NEJ
         rArHT9zCwh6vQ==
Message-ID: <812f8cec-4e11-304e-be85-216bd07736a9@collabora.com>
Date:   Tue, 11 Apr 2023 10:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 08/12] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
 <20230203-evk-board-support-v5-8-1883c1b405ad@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v5-8-1883c1b405ad@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 07/04/23 14:59, Alexandre Mergnat ha scritto:
> This patch add support for SuperSpeed USB, in OTG mode, on micro connector.
> It also add support for the Extensible Host Controller Interface USB.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


