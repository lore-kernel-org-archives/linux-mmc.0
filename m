Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018CC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 02:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbiCKC0t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiCKC0r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2022 21:26:47 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A671A6171
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 18:25:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DDDEE5C01CA;
        Thu, 10 Mar 2022 21:19:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 10 Mar 2022 21:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=QzpdagHFMsHkfe
        vKHrECzy0vm0NCdHt+uUlT9KrMBrY=; b=dzqtdo+has9K05Dyrs8DN53e8ojTdG
        G4e0QBVk7ecFAQ9R41cPkAVC7XX+iL/HxtU7F2MKD7rFXj2kcM11SS1dqKYdKk/h
        iq5ESoM25ObooASrIRuZWI7mj5fBzsYPVcQwdFAW3nEp2AA5CGInDwEGYkJ95ZTN
        ZiBnwZeLJJNNJWngBxhnLC7fgok8R5ypGB/Vvu95K2bN8cDB1On3Zr0U0e/5mE4p
        irclZxeg5AlqQvohUQ0EX1Uz7/BlikeER5fqqPn3cKCkJXYjUdQPrFOhOZU41z+y
        3NeWjL8bWSTGjo0ZPK+ny0jWQSx4aN8WrEwQP0bS7Ij/fp2QUyrzo7Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=QzpdagHFMsHkfevKHrECzy0vm0NCdHt+uUlT9KrMB
        rY=; b=SQMHoYF3hpLp+wDhH2MIIBHtMD/xEU2jK9De4DQ9tAaOih4pp3LqHdUsC
        RzI6asHZ3z3GLMpXXQXN/q6gD+UciAUCs0PEmTBApT40Gp5kwK+o2GWDzi9KdvgN
        QqvzuPNhgLBiaKU6BZi6dRWTyGcQdyaeD0WdNtDhX153a7ubWNcgonuw+lneeAaQ
        XGvKxOk9rpNZ+cUJUA/oklPZ9bEtQfluZtSwo4ISVru9ufSXKKYiUJu1OyhJd6kJ
        seL0VFSEQ6dXvUtnzbayHI2jDSJV6uDteCgTG7HpP7ZQo0SvY9JIGyH/oV6SVW3b
        SAzQimMT01Wb0f/dv9yAeOtpYCRLg==
X-ME-Sender: <xms:r7EqYoy9KMcyPsAVK1VgaJbWvKhiC1y6XdFWcqskTHV61dki2Tjhkw>
    <xme:r7EqYsSYqtOc4oPSftZ1Eo0UJxbW6no__C5KHLQkyUv4fQK-x8rfS_XHR78Q0m2bI
    jYWvWjYL0NboGnNvQ>
X-ME-Received: <xmr:r7EqYqV78yirJ6SrFBcBGXra5AZ_04mc0M5OCJ9MnukKRIAa2WfU46ZE10EjIQpe608emiltpxvJhZy-ula08fwT678GQ2DZhm_nWTs71VhPOqLlGaoVCSDj2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:r7EqYmhPwYcIIuBdO3jA-BWSyoxaA2q6eQ_By-05Es5fFyF4Q_oGgg>
    <xmx:r7EqYqADyhqKP-tv06wyOzw5bipG3-3N2RfBb0eO1IV12B4UM52fjA>
    <xmx:r7EqYnLnq3-W5NDa6JMXO88KJsjsLbySEAYkBkvI1DUX6EKXdiGE1Q>
    <xmx:sLEqYmxnah1dKjRAk-Qx8ptXayp7iBoUuvZXq2QOXVEZk3rjqYYznQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 21:19:26 -0500 (EST)
Subject: Re: [PATCH 07/14] dt-bindings: mmc: sunxi: add Allwinner F1c100s
 compatible
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
 <20220307143421.1106209-8-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <50bea156-d834-22da-2216-aa1ef5544d5b@sholland.org>
Date:   Thu, 10 Mar 2022 20:19:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220307143421.1106209-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/7/22 8:34 AM, Andre Przywara wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> The Allwinner F1C100 series contains two MMC controller blocks. From
> comparing the data sheets, they seem to be compatible with the one used
> in the Allwinner A20: the register layout is the same, and they use the
> same separate sample and output clocks design.
> The only difference is the missing reset line in the A20 version, but
> both the binding and the Linux driver make this optional, so it's still
> a fit.
> 
> Add the new SoC specific name and require it to be paired with the A20
> fallback name, as this is all the driver needs to care about.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
