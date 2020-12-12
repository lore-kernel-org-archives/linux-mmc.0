Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F88C4361B
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 05:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887EB22B3F
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 05:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgLLFHX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 12 Dec 2020 00:07:23 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:42948 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgLLFHV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Dec 2020 00:07:21 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 7BC7E20CD0
        for <linux-mmc@vger.kernel.org>; Sat, 12 Dec 2020 05:06:36 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 6D3E82008F
        for <linux-mmc@vger.kernel.org>; Sat, 12 Dec 2020 05:05:41 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 4D7073F157;
        Sat, 12 Dec 2020 05:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 92D8A2A510;
        Sat, 12 Dec 2020 06:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607749447;
        bh=1kReouX7Rdy6dmkTKtScUVsD9gkvk20YqptCWD/nPTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VngGVNzUBlb83e5Of1MvSQLXN9EgFx8RY6oba/trw6li9eym/ffR6er+S8CuOuKDq
         PNL9N0dM7R8Q7zc7TiYJgtyeEAhrCDTnk3BVGH3QwKrlG4f6cO7vGu+mslMeqaojoj
         9TeySdwcqaam69dixdC3apCKdn3M/E6fWd0BNh5o=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D8qkaISYhdYb; Sat, 12 Dec 2020 06:04:06 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 12 Dec 2020 06:04:06 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id D767C42D9B;
        Sat, 12 Dec 2020 05:04:05 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="L/Gu/b/J";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 53D3142D9B;
        Sat, 12 Dec 2020 05:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607749439; bh=1kReouX7Rdy6dmkTKtScUVsD9gkvk20YqptCWD/nPTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/Gu/b/J9CvdNZSy+4BcVkJ8P5mo3t6RU7Ej/w0vhMOalKZNwQiPThJBDr6aV8xnk
         Sl6oGsYpCFj99tDjDINCAaCnjV2wb/W40vMvTD9y5w1AQTGVXy1k20bSHZ5XTnvrVu
         4Oqe3oxIXBsXxTWK7j2lnsy9QmE4TmspDVbuuh14=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [RFC PATCH 08/12] dt-bindings: mmc: sunxi: add compatible strings for V831 MMC
Date:   Sat, 12 Dec 2020 13:03:42 +0800
Message-Id: <20201212050346.3644673-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201212040157.3639864-1-icenowy@aosc.io>
References: <20201212040157.3639864-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.2:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: D767C42D9B
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

V831 has MMC controllers similar to the ones on H6.

Add a compatible string for them.

The eMMC controller compatible is not added, because the eMMC controller
is not available on V831, only V833.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index e82c9a07b6fb..985586cb93b4 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -35,6 +35,9 @@ properties:
       - items:
           - const: allwinner,sun8i-r40-mmc
           - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun8i-v831-mmc
+          - const: allwinner,sun50i-a64-mmc
       - items:
           - const: allwinner,sun50i-h5-emmc
           - const: allwinner,sun50i-a64-emmc
-- 
2.28.0
