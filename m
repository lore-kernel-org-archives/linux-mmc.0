Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E8FC54EBD
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Jan 2023 14:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjAIOTR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Jan 2023 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAIOSu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2023 09:18:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5925164B4
        for <linux-mmc@vger.kernel.org>; Mon,  9 Jan 2023 06:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B05661170
        for <linux-mmc@vger.kernel.org>; Mon,  9 Jan 2023 14:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D64C43396;
        Mon,  9 Jan 2023 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673273928;
        bh=rP/q5PI5+9VsM9NHQlOzk3wACSP9ZKD3iTSstyibXd0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Jg0rwItb7VHD3oBhc8lpS7JIUHJ+zlQ5wJeNR4edtAXQf0507V/94fGbD60K0EE1k
         ObElcnqszNcbVd/VIb4MyFdJLROYQnA1Lsquo95u8CZPLzPPCxZ5ygTiR11OHFS0UQ
         ViMZnAISiAYyYo71LKRxQ85Nju0hfIiiElVofD01HpTz8eed3n+JdFB0zlNW//+drH
         z0aAz71Q5jiBTryoPLrD4glml5W1GIa5AxBve7ESYaYmGnXniOZB9NyaWAhS4iY8f/
         JxI6DgEqcWCjwuwvr6XLpsv9y7uTQ4AoI0QdtK3boqdkElofLBQeedzNhlPBuYsD5k
         FxDLPuOSnW+WQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 36D0C27C005A;
        Mon,  9 Jan 2023 09:18:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 09 Jan 2023 09:18:47 -0500
X-ME-Sender: <xms:RiK8Y3KRXR6pGL4NFNLbVNKD26lg3HuM-N3Xj2wWYDMO4p9n2tQHmw>
    <xme:RiK8Y7J1kTez6KObYAd9FAxMwLJNj7GETNchqMUzKf8Ifs26KTd5nGAZ4s2T_IeJ5
    BTeHTRsFkr8lGfGjVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeehudeg
    tdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
    gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
    gv
X-ME-Proxy: <xmx:RiK8Y_tgJSyb9h-h3udmeagNikidGuf3UFYhmAWZ3tDoClRW_OxVSA>
    <xmx:RiK8YwY5U7dsDzslamLKMsMuEK7x92QW6hos8Bpev2ia-gYyTL2Xzg>
    <xmx:RiK8Y-ZvdtWHV1KwfF22rlX3bV-Tw-Gq8cpiPkYsC3P-6LH4Vba0VA>
    <xmx:RyK8Y6SrdZVfrMS3EPzbHsr5CSGVmEfVzPv-iQBW6FIyf3KAHvvMaw>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A37BB60086; Mon,  9 Jan 2023 09:18:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <59f8702d-bfa7-45ba-a415-ff29a1203365@app.fastmail.com>
In-Reply-To: <2d085660-41a2-492c-a343-7df80d510a59@app.fastmail.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-5-arnd@kernel.org> <m2sfglh02h.fsf@free.fr>
 <2d085660-41a2-492c-a343-7df80d510a59@app.fastmail.com>
Date:   Mon, 09 Jan 2023 15:18:27 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>
Cc:     "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 04/27] ARM: pxa: drop pxa310/pxa320/pxa93x support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jan 8, 2023, at 14:40, Arnd Bergmann wrote:
> On Sun, Jan 8, 2023, at 09:49, Robert Jarzmik wrote:
>> Arnd Bergmann <arnd@kernel.org> writes:

> If that's all you think is missing, I can add this
> trivial patch as well and rework the series to not
> drop code that depends on PXA310/PXA320:
>
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -45,6 +45,8 @@ config MACH_PXA27X_DT
>  config MACH_PXA3XX_DT
>         bool "Support PXA3xx platforms from device tree"
>         select CPU_PXA300
> +       select CPU_PXA310
> +       select CPU_PXA320
>         select PINCTRL
>         select POWER_SUPPLY
>         select PXA3xx

I've put this in a separate branch now and will submit
it as a bugfix along with two other patches for issues
I found while testing omap1.

I've dropped the pxa310/320 removal now, but kept
the pxa93x removal, since that has no DT support at
all and remains dead code.

     Arnd
