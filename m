Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5AEC433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC86D207EA
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 07:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jmffmps7";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UiNFEODb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKHpf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:45:35 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60023 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbgIKHpc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2020 03:45:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6DA1DBC0;
        Fri, 11 Sep 2020 03:45:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 11 Sep 2020 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=SE+c5Ec9tZ0o7WH4oDqfgPX1fR
        ZYUDQNxW5WDSo9INY=; b=jmffmps7wsSVCCG8FL+UdZ9lEAtqfDVctpedmD+9Ap
        xkbk9ZdA5tuBxIoHRnB6NmX3trLOEk3CR5KGsbvPLRqHLvRipGcTcSMxIuRCdoKG
        hULFWZr8nyVN178yE20z2fWzxU20nGdCLQ8peAVZ8hZrvnWXeFzLz3fuxpPialz3
        ttlHf6ogbr9ZU6yCjnaH0BHQgw2iFTL719+lTPrA5wf9OOnUy1RVEMEigzg4BJmc
        fcKm58kkP30+NsH1vrvoHT94lAhEMaVrvIDFrFh34TdukYm66jGRA5iF1o/RDzlC
        g/pYO4FGo3xgU8KnIz235x0oec9v548j6rSnrSfdT/vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SE+c5Ec9tZ0o7WH4o
        DqfgPX1fRZYUDQNxW5WDSo9INY=; b=UiNFEODbff4YEHfYKixcS7vIcDNtGEArp
        M198mrzrKtceR7vl/vK0/BjS/9Sva9mmlKWCdVttqvgLlNxJf5ru3ryHNyXxmnYV
        1S8Hp9w8RIDfk3UVycUhoWfUsvcOpXiu9wkh44reHmrm2Dpsz4LXA4tr3RUoP5uj
        Cy9MtjzASgGogcUoz+ZEKHTMM2jC/mE1FM40Jns0Loy7GT9SS+1lnLcBQXTLJLOO
        e7D5+skNUfLqAOeK4OMZFyzWxQsFmvaUIQT6aDRIp8UsrDanrayr5lhQqhaeQy12
        uFfyqgfcTp02gXO82LLnzedrl674uua5cr/WsEEmSdY6MbDj/XeoA==
X-ME-Sender: <xms:GCtbX__OrXUKKiRSF-DRk30q2IUQj2d45A_OsYg59tmKrDKUuA6OdQ>
    <xme:GCtbX7tYBIDaH6kxug4FZdpvwScwcQE8WlbMWbWRIR8E7YVh0flxO3M6eFbEYEmQb
    mSK5RerOImPHDZ6RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeeiteehudevlefhvddvjeeluefhleetve
    ehfffgiedtfeegkeejfeeivefgheehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necukfhppedugedrvddruddtledrkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:GCtbX9AhVlcMvLyuRXIAR8qY933DluGxDzLcTjwqHCXDhEO1O5JOLw>
    <xmx:GCtbX7exsGLjATbuPwVi6weoKKWmFbLY-Mbpy-2uFqqugaEacLeUHg>
    <xmx:GCtbX0PZ3Yd_rS6_AnnCnKce8PfUgnZNtQNCK5nqr6gJ6rlGfGDp-g>
    <xmx:GitbXxrod3ANFoj_2jH4Mty0nKjwTig8OFaAIDULCLNAmgSUzYPVJw>
Received: from mistburn.lan (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34ED83064682;
        Fri, 11 Sep 2020 03:45:25 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Date:   Fri, 11 Sep 2020 17:14:49 +0930
Message-Id: <20200911074452.3148259-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This series exposes some devicetree properties for tuning phase delay in the
Aspeed SD/eMMC controllers. The relevant register was introduced on the AST2600
and is present for both the SD/MMC controller and the dedicated eMMC
controller.

v2 addresses comments from Joel.

v1 can be found here:

https://lore.kernel.org/linux-arm-kernel/20200910105440.3087723-1-andrew@aj.id.au/T/

Please review!

Cheers,

Andrew

Andrew Jeffery (3):
  dt: bindings: mmc: Add phase control properties for the Aspeed SDHCI
  mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
  ARM: dts: tacoma: Add data sample phase delay for eMMC

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   8 ++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   2 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 126 +++++++++++++++++-
 3 files changed, 131 insertions(+), 5 deletions(-)

-- 
2.25.1

