Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E9C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117FF207F7
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 12:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHLMDN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLMDN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 08:03:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0BC06174A
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2020 05:03:12 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k5pTG-0006el-Oc; Wed, 12 Aug 2020 14:03:06 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k5pTE-0007Dr-MD; Wed, 12 Aug 2020 14:03:04 +0200
Message-ID: <6e667ff6f5a1aae51b89d00e9ec5bba29852f683.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] mmc: dt-bindings: Add resets/reset-names for
 Mediatek MMC bindings
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Date:   Wed, 12 Aug 2020 14:03:04 +0200
In-Reply-To: <20200812093726.10123-2-wenbin.mei@mediatek.com>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com>
         <20200812093726.10123-2-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2020-08-12 at 17:37 +0800, Wenbin Mei wrote:
> Add description for resets/reset-names.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 8a532f4453f2..35da72de7aac 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -49,6 +49,8 @@ Optional properties:
>  		     error caused by stop clock(fifo full)
>  		     Valid range = [0:0x7]. if not present, default value is 0.
>  		     applied to compatible "mediatek,mt2701-mmc".
> +- resets: Phandle and reset specifier pair to softreset line of MSDC IP.
> +- reset-names: Reset names for MSDC.

I think the reset-names documentation should mention the actual value
the driver should look for, "hrst".

regards
Philipp
