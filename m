Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D9DC43219
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 09:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKGJ0I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiKGJZo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 04:25:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8052B17E30;
        Mon,  7 Nov 2022 01:25:24 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1526C660038D;
        Mon,  7 Nov 2022 09:25:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667813122;
        bh=L4BTOxf8EfVaRtVRyQKbIwvN9SelwSbZ8rXFeZJu18A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GURCp/A1yH2u7bMEodbIIFDg0K3VHuubl9Cz1zC0gSwnny2rh9jqAOkSQmNeio6XQ
         oQfvG6I3M1KvG41nWytHse547+qzXMe2Ag1Sio4Ur7LjKrjUmMoXCsxmdotVeZkBHs
         3TuA2ahYAdDEGQlPWiVwGdxZyoZIDG28LEpZYPV516oxzKRdV2KlidFLEA0fmOcNQ4
         EWEkJNd2mDzVXgp6/L+wf3B4/lL8F+7RG/w2d2sfBdpwyZfiyxK4avexx0/Vdg7YRI
         DQbBlsQI68TVzV8Y7+Y2kXrQeaGTDsiers1fneAFDkEg2QbFpn+qx4MqqOvh4+72Qi
         cyd9YSMBuKXYg==
Message-ID: <053b4e08-d6d5-26ec-9713-981f03458442@collabora.com>
Date:   Mon, 7 Nov 2022 10:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND v2 2/2] dt-bindings: mmc: mtk-sd: add Inline Crypto
 Engine clock
Content-Language: en-US
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221106033924.9854-1-mengqi.zhang@mediatek.com>
 <20221106033924.9854-3-mengqi.zhang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221106033924.9854-3-mengqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 06/11/22 04:39, Mengqi Zhang ha scritto:
> Add optional crypto clock of the Inline Crypto Engine of Mediatek SoCs.
> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


