Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CDC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 00:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743C661002
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 00:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhJZApT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Oct 2021 20:45:19 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59281 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234876AbhJZApS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Oct 2021 20:45:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88CA4580675;
        Mon, 25 Oct 2021 20:42:55 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 20:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=KfId3zDeeQQl/KssBDK5CIkF0Ft/Bsc
        n5IlmX7vmGVQ=; b=W4lnkCAy+fi3mjBX+CM5qW7hAbHq3VZYlD+PMtAShxwH/T3
        f0C1FVl5eQwqzd8hgesNoANfK9O8gjtlD1EVks9Rbz7NxnH9TsBOBSwZxPoouzrs
        tD/qmJcZEcPGveCqo/m4wFqAcPRigmoubMt7ETgLT70WCYExweBnNrfYU7VcfTEa
        4lVgXHNHivZ7ke52osnw0xUEmMwS3FKrdln7bzcLLKzeVbh69XS4FqLO3wxc1Z/O
        TUZaxLymXwZj3aT+Ac6CAGjuz+7wRgd8IuYPY2QmfY39O5IYBnlupUwzmWTE1FWk
        wd2CZTTMjmamxiU+QnVjfbEAXjGriV7llQFGuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KfId3z
        DeeQQl/KssBDK5CIkF0Ft/Bscn5IlmX7vmGVQ=; b=E0Fmka/huuODDXk8U8NmIJ
        1WcVUjvdrU3fYHSVt6ky7uto4GlfrUM2Ofyhds1xnfDiCmF8GBpWamEO8mqjuBcM
        hg0PNudUs1yQ5jU/WcI2TcebcnTFuCjW+kDPM+nQ7ueKCzPeE3jvskfeUqSE7O7Z
        ur9dfFtxu/vrnxyGATk/aOW8O1Pt50doqYk1h/OhC/5uc6Te34OufaZfW2xnP8B8
        6aUUrT9QQWsCz2bIXSTVQygl7tTrHymeQy3liI01Ii1cGZJgAhxKglUIKDIvWybm
        +3onXGQotpa1lDj0tLE56M7zm/S6CvuYmhx8Rv7zU0BT4Ypw9cFvxCNFzftCiIXw
        ==
X-ME-Sender: <xms:Dk93YdrdScfPNM669ixbDglfvCYJlkGfPhlFj-rovAy7OsJcIZvvEw>
    <xme:Dk93YfptsxCQlYw-MwV6kMJNzG99CrNzQgr0LhMorY78JyFS9yyhWexcb-8gpt8-i
    hhtsJmRLLBV4O-qEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefiedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:Dk93YaPHDHcE8xOKScKhhKiak8JaZ0CI9hiinkes00SWVOz-g32h2g>
    <xmx:Dk93YY7e9NS8MNVG2d582L6fVkNYyTmJZoHkuZJ5V-BNiw2qTVsfvQ>
    <xmx:Dk93Yc4aYjfRxfyxNUmTcL-y8jZ4XyZzr5BMkATk4MUOTxlPY5zQVA>
    <xmx:D093YcxuyNIo92npvjc8wF_uKt6VT4dwT4MeEVp75DU127SoyWrNTg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B396CAC03DB; Mon, 25 Oct 2021 20:42:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <88c261c2-797a-4803-ac30-24f95a397496@www.fastmail.com>
In-Reply-To: <20210922103116.30652-4-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-4-chin-ting_kuo@aspeedtech.com>
Date:   Tue, 26 Oct 2021 11:12:34 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Chin-Ting Kuo" <chin-ting_kuo@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, "Steven Lee" <steven_lee@aspeedtech.com>
Subject: Re: [PATCH 03/10] dts: aspeed: ast2600: Support SDR50 for SD device
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Wed, 22 Sep 2021, at 20:01, Chin-Ting Kuo wrote:
> The maximum frequency for SD controller on AST2600 EVB is
> 100MHz. In order to achieve 100MHz, sd-uhs-sdr50 property
> should be added and the driver will set the SDR50 supported
> bit in capability 2 register during probing stage.
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

As this is a limitation of the SoC it should be done in aspeed-g6.dtsi. 
Unless I've misunderstood?

Andrew

> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index b7eb552640cb..4551dba499c2 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -280,6 +280,7 @@
>  &sdhci0 {
>  	status = "okay";
>  	bus-width = <4>;
> +	sd-uhs-sdr50;
>  	max-frequency = <100000000>;
>  	sdhci-drive-type = /bits/ 8 <3>;
>  	sdhci-caps-mask = <0x7 0x0>;
> @@ -292,6 +293,7 @@
>  &sdhci1 {
>  	status = "okay";
>  	bus-width = <4>;
> +	sd-uhs-sdr50;
>  	max-frequency = <100000000>;
>  	sdhci-drive-type = /bits/ 8 <3>;
>  	sdhci-caps-mask = <0x7 0x0>;
> -- 
> 2.17.1
