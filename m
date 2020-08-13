Return-Path: <SRS0=OPc0=BX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FADC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Aug 2020 09:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9FF21775
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Aug 2020 09:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XU2DRv/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMJ1y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:27:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:48673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJ1x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Aug 2020 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597310848;
        bh=QQgcAqFsQMdctRYRQQkFM4/FaAdJSbAly6eNGHWh7JY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XU2DRv/M7Qr/SvQ4xb30m4g28JCoCIPLm6mmgWJQR0UE8+iK6wvgOkE9T31svAh8K
         RCM9gAi7SG7BudQpY4+Hx3Ya6rgtF4G/3PewRpJ3m/6UDmlrxu1hWkgpRfK0RXpV+Q
         Qg73xMfvZy9980EHBipZMpFjdr6MaV+TdayPqbMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.75.75.198] ([185.75.75.198]) by web-mail.gmx.net
 (3c-app-gmx-bap04.server.lan [172.19.172.74]) (via HTTP); Thu, 13 Aug 2020
 11:27:28 +0200
MIME-Version: 1.0
Message-ID: <trinity-ba9f3a8a-4588-48d3-8131-ce2a7ab5403e-1597310848667@3c-app-gmx-bap04>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Aw: [v4, 0/3] mmc: mediatek: add optional reset property mmc:
 mediatek: add optional module reset property arm64: dts: mt7622: add reset
 node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
 arch/arm64/boot/dts/mediatek/mt7622.d
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 Aug 2020 11:27:28 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200813090618.28009-1-wenbin.mei@mediatek.com>
References: <20200813090618.28009-1-wenbin.mei@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:mXGJHHF88bG10JaMCy6eru/9VAgIE4rI2I0CB2gNmVZ1v9dYAOF3QLGE1FofnG1OstrvN
 KvylGzK5GMDiyOno6TRQVoetCMIsdujumuFaURvjxwPLw8J7eEtyRWW3TZU9CuRo/nCSWvDCvfnQ
 sXHdssRZ8ti/DhpGRn4ubmTmP/ocOwo5VUKfORmwt0Qt1Em77zg2+Q2YV39v0nL5niPDaUFYr4Lz
 K54oLCH6eOWM5iwr+NTcggvyefPblhKiFYN7HZRzUbTXTbgax995RoUe60r5+xPg/qFizEKdpO5Q
 iQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vw33wiRjJGk=:p++MCWCwlhii3JRTH6pCA8
 8WIzt/TEIBJ4unZ8aragxwA2U3wg1XZGiKYnR3e8b5VPNV9nl9lmhde0bBDjMUj4DTYCU5bs6
 qXoBZzlmOem/1Vf3EGxPlO7vxCPlomiH6fbc7U1XmRHSB/NQvCSXqRfcjIqW5AVPBxmX1hqie
 x0zo8kAjNmj8AbHm/kxvLTCfrn4/YaaHl70652fQ10Me84Bmn5sCjB5c8zFrALc+xInNN4JN2
 su1uyZTasOqQKH3/VZWJVOBuiOpM7Kqo1WXaxZXWfcDUWiCKf1sGDd9IdG0GRFWT0BOF78dPZ
 Y8qE3JrkBuPgwccKNEIki/hgqALwb/ecmyONQ3HRRbv7PHexLQBrtX1CsgjHYFw3OSsdNIMOw
 fdSDZw0b3vaJlJ66fe82fQKsbp4TI29F1JphoESRDJXL5uLQllHTpu7OowVRxirjcFgi1Tk4C
 wOrOdyDkLjxLGuAMm4t5bYmg7sJjlMq2MMb4siJDaExN+tcQckr3daXZY27FJ1OaiBseKY0A/
 laQy6hITzbHX/QgdJvIrTXRp/CR7MqPiuH5sm45RmDycUtJGWhK2mDfaaPH3yfp2fUspmKwPj
 3gYuoFUdOKkI4+QxUpdzrMK1fKMHYpsNTN154qKFFAIfmnvTeUj8seEb/qeEUylk0h+KEX7ov
 XTaLna95HIosfil7jXgStJ0WRVqvgX3II4ftvv0azxnR9cI+U37ORAN+MQxiJoi3MGVg=
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

it looks like you still miss a blank line between subject and your text in cover-letter

regards Frank

> Betreff: [v4, 0/3] mmc: mediatek: add optional reset property mmc: mediatek: add optional module reset property arm64: dts: mt7622: add reset node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++ arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 ++ drivers/mmc/host/mtk-sd.c | 13 +++++++++++++ 3 files changed, 17 insertions(+)
>
> --
> 2.18.0

