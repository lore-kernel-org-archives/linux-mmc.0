Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E239C636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjBMQhS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 11:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBMQhR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 11:37:17 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645EC83F2;
        Mon, 13 Feb 2023 08:37:09 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pRbov-0002s2-Tr; Mon, 13 Feb 2023 17:36:49 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lucas Tanure <lucas.tanure@collabora.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: rockchip-dw-mshc: Add RK3588 compatible
 string
Date:   Mon, 13 Feb 2023 17:36:47 +0100
Message-ID: <2871496.e9J7NaK4W3@diego>
In-Reply-To: <20230213152740.359055-1-lucas.tanure@collabora.com>
References: <20230213152740.359055-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am Montag, 13. Februar 2023, 16:27:39 CET schrieb Lucas Tanure:
> Add RK3588 compatible string for SD interface.
> 
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


