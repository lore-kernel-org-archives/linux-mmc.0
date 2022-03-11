Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5F8C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 02:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbiCKC0s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiCKC0r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2022 21:26:47 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 18:25:45 PST
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79F1986E1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 18:25:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DD0F05C0180;
        Thu, 10 Mar 2022 21:19:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 10 Mar 2022 21:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=/A2iUX6sjPM+7y
        bDWTdehPYnFppVhf0PL85YkPJ5gzw=; b=SncenCo1jSsZar/t5mvCZZaHimjHtG
        UiJj9lFT7nvpstJz+kHiR3Mr4XOb7UA/yRuP2c6aoQkNkEwtscyg+yaaYuC2aGuI
        /I0xuccvhQRbXN+vqAQEZfEsF+VjtimfRgQbVTrh/zBuYwzKPJb/OoXfdMtWvT9t
        fnsqp19nyJ8RfXRAXSp8/amFZUTzhLan2h7r1E1WaM2cqspawDJDkig7BZsWWSct
        fdqUzA2euQPYEnautCEfmEdL09ptRz32jgP9PQ9Ec9VA5b2IdRVTRR8J2geyioUA
        yWy0iD6AJK5U8BtfJBQ+mEokHzM1x2cSmRqajMle/WEtglQ+VzUJjd2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=/A2iUX6sjPM+7ybDWTdehPYnFppVhf0PL85YkPJ5g
        zw=; b=e1Bn1sIVdXotWweWGXGPTLE2SvE0FdjM//C2YDgqBjmrRiTtNznwm1oXS
        hWNHQaHvAdxuH8V7Gpqun/6wcZzoLsfVDkFVhbtgiK7+OuqVD9NiE02AFZgrYVGV
        4fYKLRlhC5Zv9fipwKw3GWLLSahh0g3isvQv0XS3SyZPR7y6aUP6oCrWmzSqCjAF
        oLQ8BvXZnHo4gp0doOSIOfovcaTV37VD4ByONwbKKXAVrQc32V9K4N0GGP87Vmhu
        eUWGoyPgMIhT51uBfS9//YwO4Y16r9DQyLQLyrRjKLUX9GV+DXc48D4vexCNpEEr
        xhXv0nYCS+0Y3P4hxoBmKe3fccC/g==
X-ME-Sender: <xms:vLEqYoriLuGnojHSFcJmSW-enb8wwxdBOt1hLnJpfPtYPduLzKYUYg>
    <xme:vLEqYuqMrMsmFW_Z1R9kuKjfWxrvoe7VYB5aOBEjtJ4PdQY4VQxf2MsE65OuRLBHt
    bqCyQVi59WNf8aBrg>
X-ME-Received: <xmr:vLEqYtOTKoqDhrbn2AXKOtZcpchIn53g1yMgiLuDDPF9Kq5rupyX3N8Qm5ShjsUq07Fp2eKogVcJ4U0VpXQ4Kdk1Mj-6tHFnrG-0HrPchi9liYQhXZhLuAsw6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:vLEqYv7uV5q0OICKqG7rbvQTDTZYpSncAqSCPuuFIbfxX3JJew-A6Q>
    <xmx:vLEqYn66lIqxevK7VvyFAXH_D0-mEMQMzLmqQzqf2d7ktswfdeJD4w>
    <xmx:vLEqYvg371FIKw6wpLXiC51sFho6j0hVIG94As8HylKoJcuDODIxnQ>
    <xmx:vLEqYuJTukAdy8Vp6L2DSsw0o4j4oxUo110Tj388AsY3rN4A26Hg1Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 21:19:39 -0500 (EST)
Subject: Re: [PATCH 09/14] ARM: dts: suniv: licheepi-nano: add microSD card
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
 <20220307143421.1106209-10-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <38436b31-1aeb-9789-05c3-fa0a4123c766@sholland.org>
Date:   Thu, 10 Mar 2022 20:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220307143421.1106209-10-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/7/22 8:34 AM, Andre Przywara wrote:
> From: Jesse Taube <mr.bossman075@gmail.com>
> 
> Enable MMC0 and supply the board setting to enable the microSD card slot
> on the LicheePi Nano board.
> Apart from the always missing write protect switch on microSD slots,
> the card-detect pin is not connected to anything, so we use the
> broken-cd property.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Andre: add alias and vmmc supply]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>
