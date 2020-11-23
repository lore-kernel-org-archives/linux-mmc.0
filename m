Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076B7C63798
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B907D20756
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="VGt0OtlE";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irMEwFn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgKWGaj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 01:30:39 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48493 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKWGaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 01:30:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B129E5C00E0;
        Mon, 23 Nov 2020 01:30:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Nov 2020 01:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=VUpiAH9rXjm/ZsT72ET9GIyEmE
        3rMp0L6k52KA3xg/A=; b=VGt0OtlEce5bdu74DlG7Inr70Wp27gu3H53cs+DpMD
        +e9x/i3fASf+Gk46O4aYU4B9cpkXybzOMUErzv+WvH3cGDJ8PonKnV11Eiv4zI2J
        4rOzOToX9SemuFXGxYKgbdEQG54A7uPuZYveP7oaDpMVMeOY3lgI79mISC8i43Xo
        YviYs62iyPCYyMlHYPPvX8bPq5N5NDLQ6CQNT5H65YSuJIdt1qAw2kalvcwPjOxs
        3fmkkgATPEl5G5EdcaYkoy/CEpuwkNyWqVKW5G/Duq1K7xg8tCYmRAZMoGiIG5O0
        CaXDUClZhkageAN7fzYNNcTiXaAXYcUDNPiqWTD57Z0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VUpiAH9rXjm/ZsT72
        ET9GIyEmE3rMp0L6k52KA3xg/A=; b=irMEwFn/2EyvFECDbRHaPyFNMJsSV1Lcx
        AAA/fuXafTQfPl+NZshialdEUxt0vAfOoNSAYToffbBGebHCYV5RXK9nrrTCfVR7
        4uamjJoV+ZE4psc0ZsJ9SpZRmBna7BtEb36soDZHEDUlD0J1IGQYqn+y5iwhRiBd
        +DsN4sgY4rBQSWExS4QoAen6Obf3O9S1Y4WhNGDEDB/Sfmxdnt6iK1jiTyjtxSdC
        5NhKPxBM17HmWTpICHk4TNWsjIcqMiu/JGxaW/U0JRouL9LJ4yoYAQJUAwlCjXzp
        JplCHJqBYQtytxhJkXc1ej680MAQj4Hv/35nvE9dJvWwhDp7Sjn4Q==
X-ME-Sender: <xms:DFe7Xxdh8s9XdhIsjaRR640RZ2pE6ixHtWmym2KR09gyRu4sFftaxg>
    <xme:DFe7X_McmAhFIb7QwejoY3vh4ar6OUREpwUJRE05BIavqb7_cy6vcoBFYW74GBqCg
    8oB8D_8ormKFIFwbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeghedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepieetheduveelhfdvvdejleeuhfelteevhe
    ffgfeitdefgeekjeefieevgfehhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucfkphepvddtfedrheejrddvtdekrddugeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:DFe7X6j9KrReJN4pSm6fWjJ4qDcf-LxuT6S5gH-BumgP9w8lKIqsiA>
    <xmx:DFe7X69c9iFXuM2BvTCGQtfyoxzpgksqnoqoZ6Zwk2cQeRbuXGe0mA>
    <xmx:DFe7X9t0wjzBJouKTnzXuAZU0HdSX4uWFw0CDlIEgv9OYMZs488ZNg>
    <xmx:DVe7X-_JXo-I77eWR2qDePxgbQAqhGfTvbPmvkFJHgjBEhLjAX0tEA>
Received: from localhost.localdomain (203-57-208-146.dyn.iinet.net.au [203.57.208.146])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE59B3064AAA;
        Mon, 23 Nov 2020 01:30:32 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     robh+dt@kernel.org, joel@jms.id.au, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Subject: [PATCH v3 0/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Date:   Mon, 23 Nov 2020 17:00:01 +1030
Message-Id: <20201123063004.337345-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This series implements support for the MMC core clk-phase-* devicetree bindings
in the Aspeed SD/eMMC driver. The relevant register was introduced on the
AST2600 and is present for both the SD/MMC controller and the dedicated eMMC
controller.

Previously, v1 and v2 of the series implemented custom bindings. Thanks to Ulf
for pointing out that this functionality already existed in the core bindings.
For historical reference, v2 can be found here:

https://lore.kernel.org/linux-arm-kernel/20200911074452.3148259-1-andrew@aj.id.au/

The series has had light testing on an AST2600-based platform which requires
180deg of input and output clock phase correction at HS200, as well as some
synthetic testing under qemu.

Please review!

Cheers,

Andrew

Andrew Jeffery (3):
  mmc: sdhci-of-aspeed: Expose phase delay tuning
  mmc: sdhci-of-aspeed: Add AST2600 bus clock support
  ARM: dts: rainier: Add eMMC clock phase compensation

 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c           | 310 ++++++++++++++++++-
 2 files changed, 300 insertions(+), 11 deletions(-)

-- 
2.27.0

