Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BCFC433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 23 May 2022 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiEWJcj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 May 2022 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiEWJce (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2022 05:32:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682D275C5;
        Mon, 23 May 2022 02:32:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 57D081F42D94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653298349;
        bh=7TQ62V5XbcmQui5rWwD8kHW14UO9LXcaDw1amgKSaUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WHv2XvbeJfFJAlIFiFxuTNDmn8ZLfc3Y/RBFFqXPLIq+9aDlV2WU67DqLpEGVE2dm
         Hr8KOR7Aa4+Z5vjdu08OITd5VFG/VCRr1WZbCG9zWPyGbbbui0pPK5Mp9xhAB+xqUX
         WQZHSJolp9HDxO4c/D1AEixqpTqiCUHaABXw+L6AllD01MfDG5jtby7izrBCB3/bl+
         8qvpM6bsIDoRbQwfnTkpduUI0THnG4bs5AJUEhSeROI6eFS7y8Sql7QWinPGHr8/s4
         MVP0VhBHomSL3JkEfqvjbl1WqqjjvBqpvDrzrO2zOJERWVdLI8fQ9Yb5/E7Wqirdmc
         Hq2FbVsw1ec7A==
Message-ID: <926ec290-7644-4820-41cb-5bffb44e2ffc@collabora.com>
Date:   Mon, 23 May 2022 11:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220523074017.12649-1-axe.yang@mediatek.com>
 <20220523074017.12649-2-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523074017.12649-2-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 23/05/22 09:40, Axe Yang ha scritto:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

