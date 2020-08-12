Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A21C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B60020855
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 13:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SWWPiB4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H81HBxxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHLNZg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:25:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49379 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgHLNZd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 09:25:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 49D315803DD;
        Wed, 12 Aug 2020 09:25:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Aug 2020 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=i8XRP2VVPIQwUPhvLuLe5eBXjcL
        /b/B3ukCtwKVvXZk=; b=SWWPiB4QgAlnbKDiZPT8AW01PsffGj0mrWQyc97g3/v
        8EPAPSx3q4uR8pxdunQOQdU3CYfzEhUxi5IhHk/51NWbbiJ01IZM+D1Y9okbKR4l
        1PA/DephHOSIaKmiDIX1mNczVU915u5qaonwiLa6hKJcIGUSoay3uhJFlrsVIxJ0
        7bDIfW5zXV/E5r2IjpFq47bwdwj6ZFNEEqd62aGIxTOxMpjNpdWmcS2QsRKUHAAx
        4dvCTHv7OU9ZD8yLwR/pgNv3x3mMxC6LjFM9z2SmWrAnkZlG4lm8pmvECAj2ezxX
        Yvocn/52skKMNrlbvLEw/W0WigZZNHGM+fzo6gL6zfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=i8XRP2
        VVPIQwUPhvLuLe5eBXjcL/b/B3ukCtwKVvXZk=; b=H81HBxxX4JrQ1zha30YBda
        yr7S3/jm8F8i9uy8C00665rTJX54SHUOYIgS8RGB4a2RB06bU/IoQOeP7JmGSe+d
        qXCpfzLe7HemRq/yohmq4iJQp6jivUGOaMmt4LuxgpanlaXXjL16Nv4QJuAzvo+l
        m1LWrhDUBu1dtyZS26dubDnv6zrkRrRwejUK+FsgoobjYVpZcZkrj9T63yd3fo6s
        l19ih6HVi9IwN4jRG4/HfexvL1K3lg1saqBGFn+JqYfCz3kkffosOCXqwFZgXCGb
        pDY7ilHTwGAixd0Dw5LeOAeKncOxiQQOm5qGbgUPZCjr3dJkq14I1GGMdv6sI0cg
        ==
X-ME-Sender: <xms:zO0zX8_wVHT6keAG2IM9EuvNFhU4C5-AX9rYIl_H8Fv46Xfa_Q45mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrledvgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueelledthe
    ekleethfeludduvdfhffeuvdffudevgeehkeegieffveehgeeftefgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghh
    rdgtohhm
X-ME-Proxy: <xmx:zO0zX0ueTqGbRvjnBEbuQALeQ5o0wI2a13y2RDS_hugxcXohwqCI8w>
    <xmx:zO0zXyAgNT_2F1bYAu-jI8QUAQdouYfi0Mic-WLHGhTqOkxbtDsdrA>
    <xmx:zO0zX8fZ3kavY9GE9pSuhTtb6NLKG9QmvKTAGaypXZRRBEiLw_jQJA>
    <xmx:zO0zX0r6iSe_5AL_yw0hjMkHh0CPJdYs_vqclR_254UT70VS5pKEaA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id B536B328005D;
        Wed, 12 Aug 2020 09:25:31 -0400 (EDT)
Date:   Wed, 12 Aug 2020 15:25:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [v2,2/3] arm64: dts: mt7622: add reset node for mmc device
Message-ID: <20200812132542.GB2489711@kroah.com>
References: <20200812130129.13519-1-wenbin.mei@mediatek.com>
 <20200812130129.13519-3-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812130129.13519-3-wenbin.mei@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 12, 2020 at 09:01:28PM +0800, Wenbin Mei wrote:
> This commit adds reset node for mmc device.
> 
> Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 1a39e0ef776b..5b9ec032ce8d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -686,6 +686,8 @@
>  		clocks = <&pericfg CLK_PERI_MSDC30_0_PD>,
>  			 <&topckgen CLK_TOP_MSDC50_0_SEL>;
>  		clock-names = "source", "hclk";
> +		resets = <&pericfg MT7622_PERI_MSDC0_SW_RST>;
> +		reset-names = "hrst";
>  		status = "disabled";
>  	};
>  
> -- 
> 2.18.0

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
