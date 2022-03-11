Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC09AC43217
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 02:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiCKC0u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbiCKC0r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2022 21:26:47 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CED1A6177
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 18:25:45 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EEC945C01C2;
        Thu, 10 Mar 2022 21:19:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 10 Mar 2022 21:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=0YsxwSC1MRHMpx
        XhJmSDg0DtM4ABpVnTGFFDxmFrMEQ=; b=l29xCkcrH99aJZi7Ko6WXm7ajhW2oZ
        9qqy4kPB/G5FqKdJJqP91xjo6dzIS+zj2NuIeDsTTQLQWeYju5xNkxV2ZWo9lDg1
        a2PpB6HdTJgF9yGHiZsZ8BxG8jQDpi0RQFpUuSTTw5wnCJQTbz21ACZpgR2GYNAH
        ZPiNqpQwjaVNqe4GMYusvuPmy6LpxkmqFvNRm8AQ70I3CbtF/u7HJnwIxf0nsunS
        GRl/klp/ijo6O2I+QfLOJ+f9RLtI5i6FFhMeFHLyxwAvqE3xPc+q2M2/y5YRGXga
        Xd4mJ+Ntq61T64HACG3t9y0s9krKn0xaGeRKbq7dmtLx2rm4bN+s4UQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=0YsxwSC1MRHMpxXhJmSDg0DtM4ABpVnTGFFDxmFrM
        EQ=; b=S8FyzSMIQAjOPbt+g4bWKi0YkStkerWLB+Ku9Domrw9vK+k8CD7e6RjPh
        NMvfgG57rc34qvxBLtInlbKrwJ6Iv4QVwJJoMWqcJ+YCe/ZWNpoVbe5p00JA5JIe
        23x6M1d5rgPdMLfY+Og5hN7c4HBSA5qfMgQvxw+Bc6P3HIwCb90xrsI+X3MSw7YZ
        sEj5+OB/AY289q7qzjh+/NOXfe0R68wUkXwJzeB0TWIVmre5Das5QhJMNYsnbtyx
        D+B4PqJVcM7YOUZP1qFs3gMcdiZTnmaLVaIqtNP3ic1jUun0/7vHV9XHxUXPYa+r
        cX28Si7SaoFjiwj9eZ3ol6PpHaL+w==
X-ME-Sender: <xms:s7EqYlWot4v39LJRj-okOhUlDhtaYr9FMOx-mlNgJMxfaVgPEjQaKA>
    <xme:s7EqYlkmwaqhYpOkJK4D3XF-FphE865MQPMxmnBpD8TEvxIEvpgiXRSfXirlYOKzP
    ObRp-_9LRNJ0GSiNQ>
X-ME-Received: <xmr:s7EqYhaiHbz11AMQVC_vQoVxzBbDqoqUfT4VaX-BK4cyiy7DzTCkR5gCa4w6UQATxjnA0pA25t39FRfUapRTyO-ih64veGOJPLKr5-t-hi1DdwkxwpPmSpvhrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:s7EqYoUzaX3jGmybPlYBLN5pn1wudiVL4XoS80ruroi5MtQqqx4fJg>
    <xmx:s7EqYvkx9PqPBUbRpnFH_imIaKfnQ440A-f53jAxHlAo92pPM-zAlg>
    <xmx:s7EqYleZUb9L08jXyUi8NY42iUttx2yptc-WxaJcNSuysIknpcn9jw>
    <xmx:s7EqYpllo9qE8bmlueMmf4gej93iHPfpelYvUeilIsv2hw_S6AhVoQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 21:19:31 -0500 (EST)
Subject: Re: [PATCH 08/14] ARM: dts: suniv: F1C100: add MMC controllers
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org
References: <20220307143421.1106209-1-andre.przywara@arm.com>
 <20220307143421.1106209-9-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <cb6cba52-1729-d7a9-3529-dbd1b3fe0f48@sholland.org>
Date:   Thu, 10 Mar 2022 20:19:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220307143421.1106209-9-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/7/22 8:34 AM, Andre Przywara wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> The F1C100 series contains two MMC controllers, where the first one is
> typically connected to an (micro)SD card slot (as this is the one the
> BROM is able to boot from).
> Describe the two controllers in the SoC .dtsi.
> We also add the pinctrl description for MMC0, since this is the only
> pin set supporting that function anyway, and SD cards are very common
> across boards.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
