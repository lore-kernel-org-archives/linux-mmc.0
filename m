Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43D9C43381
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6CA236F9
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 03:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhANDPw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 22:15:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34409 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbhANDPw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 22:15:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A9F205C01EE;
        Wed, 13 Jan 2021 22:14:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Jan 2021 22:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=XoOzQyq8r+J+/QRDndikLwkl6s
        ZOoTHhqppNgPXoevU=; b=UBHJKtHUDXgkUai/PtA8gu7oTanN3OWM5YAC+RVCOr
        7NFzNPTnp9LmG8oDdBD3mX32TRwHfMZ6I5XrPCJAa9/A/9CsNEh+5p0rJ8BcnGdn
        LlRmpfCaUpkC7RMhFZPxsQHPsylcSPYnldxuxkSvrrRpOuO65icFsrXcVSYNY533
        5AO/Ze6JF8XNFMHdBdsg47HUWelrePeurn31KrP7KEELcz7w7TsHCHm0W8GvZIYI
        l0xO0pOSIPqbpvC6rVSKkjcmJR2B7AE5lLHZ8+i4mB8uZkW8DR/ei1P4qD0xLHNU
        pvnMM/E/+4E3lptiRh0fHIZZf/fzYR2rZcZ+hzJRkFrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XoOzQyq8r+J+/QRDn
        dikLwkl6sZOoTHhqppNgPXoevU=; b=Ok63H03HL9rGeiuzlM2TsCaXexYGhoWOD
        q+/3FWObErqnoE2msODrP+4gYr5EzTxZM+yViMGl4BBkac+3i+5/p9I3DW6REmVB
        z3tAD+2HSObrtdj2YL/0r91EKSWUX28pr9x3f+Y2Yyxjk/4qwsAP6gN1gBPGY8EO
        rfpSJfAguTLWgiGFKsHxsfqLGDoKZaWA7/vP61wZCaaQOjhnTv75utUn0Nv3a/DF
        zsVhCKd4SyBsvvTcb6hibKG0R9at7auaUDj1j1RRoa58j28CgxIKOJaBzKFY+R26
        Mw28NpnSOExM/jWFHzPJk0p0g/dF4YpYGN08yRC/hXvEbGjswtEVg==
X-ME-Sender: <xms:JLf_X1pmuVXqfxZN_FYlJQ1Umr9ldt4U9ND4zSwsX7YelvKmWejIyg>
    <xme:JLf_X3qM08AFZV2xT1x5_GCPRg4kdAvZZ3SS3fzs6yeoWKRwFFHPrbdaKuy9afH8D
    _Nt4QsSHdiOSLJWsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucggtffrrghtthgvrhhnpeeiteehudevlefhvddvjeeluefhleetveehff
    fgiedtfeegkeejfeeivefgheehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    kfhppeduudekrddvuddtrddujeefrdegkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:JLf_XyPEIG6VSysiwhelSYTu6ZUVY1WWPTs9HJnp9lHAUxYnrWPCVA>
    <xmx:JLf_Xw5hUsMIISEPHoaE83mvOdMQZuHAYP3h9mj7RzLAZXceJsKNzQ>
    <xmx:JLf_X06rcQateijtP5RaP5P2M5O8C8Iddu_4_dhULx8zNx7K5wE00w>
    <xmx:Jbf_XzYpgfZVndtwnFaO0szdX7IVvJu1uRYAau8Vj1jGHKpdWzWVrA>
Received: from localhost.localdomain (ppp118-210-173-48.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.48])
        by mail.messagingengine.com (Postfix) with ESMTPA id B254124005C;
        Wed, 13 Jan 2021 22:14:41 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v7 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
Date:   Thu, 14 Jan 2021 13:44:27 +1030
Message-Id: <20210114031433.2388532-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This series implements support for the MMC core clk-phase-* devicetree bindings
in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
and is present for both the SD/MMC controller and the dedicated eMMC
controller.

v7 is just a small change to the the kunit testing in response to Adrian's
feedback.

I've just done a quick build test of v7 given the small change and more
extensive testing done with v5. 

v6 can be found here:

https://lore.kernel.org/linux-mmc/20201218035338.1130849-1-andrew@aj.id.au/

Please review!

Cheers,

Andrew

Andrew Jeffery (6):
  mmc: core: Add helper for parsing clock phase properties
  mmc: sdhci-of-aspeed: Expose clock phase controls
  mmc: sdhci-of-aspeed: Add AST2600 bus clock support
  mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
  MAINTAINERS: Add entry for the ASPEED SD/MMC driver
  ARM: dts: rainier: Add eMMC clock phase compensation

 MAINTAINERS                                  |   9 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
 drivers/mmc/core/host.c                      |  44 ++++
 drivers/mmc/host/Kconfig                     |  14 +
 drivers/mmc/host/sdhci-of-aspeed-test.c      |  98 +++++++
 drivers/mmc/host/sdhci-of-aspeed.c           | 255 ++++++++++++++++++-
 include/linux/mmc/host.h                     |  13 +
 7 files changed, 423 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c

-- 
2.27.0

