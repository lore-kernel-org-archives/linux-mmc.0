Return-Path: <SRS0=ANdn=CT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6026AC07548
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Sep 2020 11:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C4021D7E
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Sep 2020 11:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fxtXh8w7";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="esHI8a9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgIJLKG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:10:06 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40225 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730518AbgIJKyx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 06:54:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D98BB5C10CA;
        Thu, 10 Sep 2020 06:54:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 06:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=7fKJTSl0aTWXfPqJvnHuuREMnq
        wvVIPeCygVKzFLhOk=; b=fxtXh8w7MOT/hbSneypqL4AaQEJs9Oa7hjYBE36m6V
        bFQbNlck8V5HR+8Og664JCIeTPrQtbMn6O3Hr2yjdfd7/fXUryMyt+rAfnkLm8Xd
        qsmKUYhLqlv5q/zOTbqkLNMURKjvFNJQjrZY0z1qaoiM9coVN/71pOg2m4x3Pd2x
        4iO6PM9TXcfN4FDnA3K56qTPCawdW7e1EjVv3u+Jk4cbEW3Q/x+Slp8eZVOtTeVW
        fJ99fyfkrcVZ1TxqeYdibUf5dOq2lduZemAmyfFCLwjJYmhH3me2h6ArZvzJp7qV
        FPoUgdf6b6vXnf4aOSYyXr9fW0Ejbq9uZyTDjNzWbZMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7fKJTSl0aTWXfPqJv
        nHuuREMnqwvVIPeCygVKzFLhOk=; b=esHI8a9kX3HYOmCJF/FpjTamHSxljQ/3W
        rXI5ymnmwwzpcGOlDoiug7t8xGo+9lt3FDQ9VRMBEqZ3y3VylAk47gS9Bc6FygzY
        g4Dd/awAKLQzZpMmKIECUUwKthXG4/tfN5aOE+OwbIXiF1cXMBs9Ib3l5DYKdHIB
        N6SosTwHX9NIiB8/JZKiX4uCmy0JvXcNkiJwNhvQeToicI81qnUVdZ0XaYFIxX5T
        3LNPBL163D0DFwxb3VTFJzGiZcokT9cZ/axUP2Do7020FuIr4Wj/Hw6dR0aM19+Z
        nrcoMAmk7qggYV68akFDWEGSTmJ4FSfeEks70zvxyuv68voBVYcdg==
X-ME-Sender: <xms:-wVaX-WKFyau5GnnmRSgZMXohkCOYq4WcdHAPTH0SyfF-wgt4_Hrfw>
    <xme:-wVaX6n94UdHrfu_KWsqQnPz6lW_ZlplSzuGXYbrHRkvLVI3PXmhfwnDZym721iPx
    O3LiiafmceUnQqbKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepkefhieffjeevfeevhedtieeihfefvdejle
    dvvddthefftedujeethfeuueelfedtnecukfhppedugedrvddruddtledrkeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifse
    grjhdrihgurdgruh
X-ME-Proxy: <xmx:-wVaXyYvSwKl1dXxL0Zk70s0r7UxLVD3BrXBYfW5RSp1FNDf4l0IUg>
    <xmx:-wVaX1WjSjZC7qa1ZMhvd0bLPwO_PLxVC_k7y4YNigLbclrZYn30iA>
    <xmx:-wVaX4mtJbHWNwba7tbwaSIWM0uO1eOgWSTTMS0mdVXJ5Lh43_3txw>
    <xmx:_AVaX2ZzQVYpU_Rod9vcAulCnt5CGQIkOYl7GsIZr2eJRjxbbCbQZQ>
Received: from localhost.localdomain (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA51F3064674;
        Thu, 10 Sep 2020 06:54:48 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
Date:   Thu, 10 Sep 2020 20:24:37 +0930
Message-Id: <20200910105440.3087723-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This series exposes some devicetree properties for tuning sample phase
delay in the Aspeed SD/eMMC controllers. The relevant register was
introduced on the AST2600 and is present for both the SD/MMC controller
and the dedicated eMMC controller.

Please review!

Joel: If Rob's happy with the binding change can you take the dts patch
through the aspeed dt tree?

Cheers,

Andrew

Andrew Jeffery (3):
  dt: bindings: mmc: Add phase control properties for the Aspeed SDHCI
  mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
  ARM: dts: tacoma: Add data sample phase delay for eMMC

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   8 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   2 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 137 +++++++++++++++++-
 3 files changed, 142 insertions(+), 5 deletions(-)

-- 
2.25.1

