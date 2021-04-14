Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5388C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D4A613B1
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 10:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbhDNKAr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348185AbhDNKAq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 06:00:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6635C061756
        for <linux-mmc@vger.kernel.org>; Wed, 14 Apr 2021 03:00:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g9so3233636wrx.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Apr 2021 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHs1VI7bCBMLQHluRCKmPfQD9C9ixYNpufWpRqIWhkE=;
        b=l3cVwETuHQqduIAXlo8++0A6pPs7pLslAe4lyc6smU8e/DV4f7a376UloYKjfBsnXQ
         OaEByc3AU8DhYAI4G8ne46SI8sVNarcnyeu2xnhKEqnffqOORFQ/LmE09kDejh2OuqbO
         NOxTtnrJ2TMGGk7XbYKCZPmJl7rBmcvqasmQkHoX9VtmKkN03ur2SZ7cxSQJQGla3SX/
         cfI5LGXUEva3fyvjP6XKiaasv3XPKjrtCZNQJioq6FCou1rppZGV/trmZKzu6Db2D4UA
         3ZMBjQArA5nqTKAkG7SbrMXPtG8TsaFGHPuHchVHpSdxmRQWorYHA5csFidA57GPivFI
         Sr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHs1VI7bCBMLQHluRCKmPfQD9C9ixYNpufWpRqIWhkE=;
        b=RwJaQ3nSVQotMVym7H5EFI3Oc9L94DU/dDCWbDRWjqGLH+Sw20yNkukU9rgg68SXmb
         yijRKAQsHClzHP4IzY8OHtHxZgDs02a82OsnpwiEV5I0QfKyBIhqvRQgDmofPKhYP2ZV
         ey97egvNvANv3ojeRIkGOeQK7NSkQQ7z1P63lUBS91mmBKh7cUxOEc4rc05cFv4MPL40
         qjH8wyz38dP3pzXGjImLpL6jUZBK6bxeJptX5Zh6Kvf91xcTx51nmsRL0D3MY0EsMR+t
         CSxcuZYXDv7K18vrTpWUU7Mw4qXJ6WKr1DAp9fDUJbFJkwwqEUb2nd1gQUZC4Lu3qb9n
         DMWw==
X-Gm-Message-State: AOAM5305ywVdFKVn55hcIcSahLShz6uSs35E29bZq1OrAJx/dUVIT+rp
        J7qTbc8rp8wqmGG33PQys/Nn+Q==
X-Google-Smtp-Source: ABdhPJwVo4r8CagdY1xwnin1Wu5iRm7+Su/KsvFwD/E7y98dMUB5Tn/Oj5UrBGqDFcvpaaKc4Ml0jw==
X-Received: by 2002:a5d:590d:: with SMTP id v13mr9510711wrd.85.1618394422357;
        Wed, 14 Apr 2021 03:00:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:49d:95f:49d5:fff7])
        by smtp.gmail.com with ESMTPSA id s13sm23204737wrv.80.2021.04.14.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:00:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        lebed.dmitry@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] mmc: meson-gx: remove useless warning about scatterlist size alignment in block mode
Date:   Wed, 14 Apr 2021 12:00:10 +0200
Message-Id: <20210414100010.3877669-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=joJCiZ8Vi/Y9gbPhQtYvg8G1NMe/H2kEmTU9lh2L1gI=; m=zKiH954YES215BXInsULtpyDw9oMvFnx219Op9hHlEU=; p=AYUXpPgmnbzdD2EgfOp1CBf5Y6HRf83iQRLUWAs26WI=; g=7c7d0d96a81368feaf7aa048e5e1ace500463711
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB2vP8ACgkQd9zb2sjISdGAyQ//Qd5 v/zcwFbpMCcxb8+wYVg+G8BSFPgmEeIlY3A0mqob2eqwd/lxXmWoS3JSI9aQkypdERq/FrlMyx5JM HGH0r8PUmMzqq87zJ8WaFmGubdQXa6l+5rnPaMG7KKf9SDP+7rwIjR9YXO6ju4Gdsjap8hqi6+C9N kNU0Eh56JoSUcfCxZQdvsULlRXkJ/xUVdkyb58clpYl+xKpULsM0pglGZgMO9Iv4Y4PPZAU/UOLqg VT71ZG3hBK8HzUat7wAKX3G+NRdra8lLluVuh3wT+T89S1Gb9ihSDGRAegt+UY/wka9dWZ8erJcQ8 3S5ebn4mBHoLUqepoOaCZdyT3jlpaKZUK6dn0viNbD5VmNfwNFV2rElF8grgx9AdTbUlGbCWwujAv ec0ZYrtqQkQBzXY6RVLNZnCZMLznf8R+B4iqw/T2cgyeKc0Y88KJgivNCBiHAeoMVk3Ca+Ut71kZD 8wFm/o/cZZPUKjRYWcU7ic8aPWH932o3Zds0tfCWk+vuEb3aRJ2RPqVturYUan2p4S74XaQswGeuX I0Btgw3Esi+InBlZrCAoS6zda/aJbHoBxsESaVjkKFmLQNa+yq9fnlv3L6PofyJ0GFVWL6PSUhRvP llqUl0UdVIfVgof9RrmJnyM3pcm7a+xxcc46s4/NskhXibc6gEOWDuVkgBlV1BqE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
triggerring a warning even if the transfer works in degraded mode.

This should be ultimately fixed in brcmfmac, but since it's only a performance issue
the warning should be removed.

Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index eb6c02bc4a02..6bc151045843 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -246,11 +246,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 		 * size, otherwise chain mode could not be used.
 		 */
 		for_each_sg(data->sg, sg, data->sg_len, i) {
-			if (sg->length % data->blksz) {
-				WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
-					  sg->length, data->blksz);
+			if (sg->length % data->blksz)
 				return;
-			}
 		}
 	}
 
-- 
2.25.1

