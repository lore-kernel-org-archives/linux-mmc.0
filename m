Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40186C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Mar 2022 00:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiC2AE0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiC2AEY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2022 20:04:24 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2B12AF9
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 17:02:41 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B5E742C06FB;
        Tue, 29 Mar 2022 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648512159;
        bh=2yoNCniX/MtoTMpkQdC4Gm/7f/mkXZvG4wvzBibLAz8=;
        h=From:To:Cc:Subject:Date:From;
        b=PAkB6PlUPigDCHpXjBgAG4U+deMOinEz6yQdq76Xx3MWsVQN+ptmFdVoSE1I5UuAW
         tbol0iVpfuJ4ZA9tmAptQQtbeqBEjfa2PwZF2NUNgC+1ZsQ2pe+Zeiqj8Mw0uo243K
         z1tCx13sZX8GpLsXwQzq2YQ7u1nG248BMezoOIQ3cmQsNIx1ypznpOLeH/mJFYkJ4a
         l5CXh9XEvhuDRSQ/bScWR1y4UkJEVNp96Toy0m9+GypgwmeydWMzX0IZkTNxU2J+Lt
         JbCKYNUPJugxUPySRr6vUlkVi0n2YbJWGs8jatbHmHIzo8HXiziVmNsFFUmrv8OWKe
         se1OJzzAfQuBQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62424c9f0000>; Tue, 29 Mar 2022 13:02:39 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6FAA313EE00;
        Tue, 29 Mar 2022 13:02:39 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C91392A2679; Tue, 29 Mar 2022 13:02:35 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 0/2] mmc: xenon: Convert to JSON schema
Date:   Tue, 29 Mar 2022 13:02:29 +1300
Message-Id: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=RB5vAHK8orW3AuQTtkgA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series converts the xenon-sdhci-binding to JSON schema. There are so=
me
schema violations with the clock nodes for the existing dts. It's unclear
whether the ap806/ap807 actually need the 2nd clock but the change that
introduced the requirement to the old binding was fairly explicit about t=
his
being required for cp110 and ap806.

Chris Packham (2):
  arm64: dts: marvell: Update sdhci node names to match schema
  dt-bindings: mmc: xenon: Convert to JSON schema

 .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
 .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   4 +-
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   2 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 6 files changed, 280 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-s=
dhci.yaml

--=20
2.35.1

