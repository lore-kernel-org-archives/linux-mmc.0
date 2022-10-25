Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD07FA373E
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 10:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJYKwN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiJYKwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 06:52:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5578769F;
        Tue, 25 Oct 2022 03:52:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 89E9D660239E;
        Tue, 25 Oct 2022 11:52:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666695128;
        bh=bSnVLL8Pc8DTD3Pf6881nmJo6l8V96eFCrGuGcmdU4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=es+lRqNKDNionDgcTpis7RV31K7MhghDuuKQsTDDRz44pfp1Oy6y6RNGu22yLDQnl
         8PFuv37ffvvc2vG1mhxutWoRPlZkUPIitr8nsABx67F/HOJPYi73CM5B0xTvXJRk6H
         Gq1nWzEDV1WcbXdcBiKdr+OpCbl6k0JgrGm1Ldb7HI1nGZ/bamiJBdC9s8LULIipvC
         mSmsUolxk10fJh7F0QLmwAm6uk1cd1eGKCKvP0RWxm6/uz4RwGoxr/9mcDaIm20fjY
         ZsaERHnE7h7Kr3GaOvGOwtwDsPRFYk1dhJvGKY7la1BHxecoC9TkbY7RMU2PVBXOzs
         icANv1HT9MwiA==
Message-ID: <2bc75b20-9469-e7e3-24e3-cc80ab9b8a8e@collabora.com>
Date:   Tue, 25 Oct 2022 12:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 5/6] arm64: dts: mt7622: drop r_smpl property from mmc
 node
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-6-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221025074238.18136-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 25/10/22 09:42, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This property is not defined in binding and driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Fixes tag please.


