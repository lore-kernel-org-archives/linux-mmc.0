Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FABC433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Feb 2022 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbiBEU5N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 5 Feb 2022 15:57:13 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:22345 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235807AbiBEU5M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 5 Feb 2022 15:57:12 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 3DB937645F;
        Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
        (envelope-from marius@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4Jrl8S117Rz4jyg;
        Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
        (envelope-from marius@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
        t=1644094632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuSGZ5/yCrBoF5NKk8PtVR/aMcZdGo3tebV8LC0pus0=;
        b=dK0LfTh/8syz5WKHiqH50BskCL9dNyQRuJq4dZzAF5Gm77Jw6ioENv2C6aoaarUZ3R6JIb
        NUmZfKCZ3H48is2+BvvQ+IWmZ0Vr1eKbA4iejMBlv6rpIQFeswvMYN8Ds7gIlXn44bcXvG
        DD8EmMhmerSl9SGAgcl+2+SrLMbFT3hPNdR7U5n9cg8awdUpqfgf84zHGWHjplumbXVnh9
        Z9Cn/WT+ZutdJVIxxlcaQA2Y7Ev0BNkg2w8xyVXNrOGBXJA7KH4bKqYPIlt2v8sQpI2ATj
        xQ0VLy2rnNEzccYJ/BuC65zhP9C3/qCEqBZs+VuAxgux9S2K6TljCM5ONGhwXw==
Received: by freefall.freebsd.org (Postfix, from userid 1018)
        id EFC0636F4; Sat,  5 Feb 2022 20:57:11 +0000 (UTC)
From:   Marius Strobl <marius@FreeBSD.org>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marius Strobl <marius@FreeBSD.org>
Subject: [PATCH 2/3] mmc-utils: Remove unused MMC_BLOCK_MAJOR
Date:   Sat,  5 Feb 2022 20:56:46 +0000
Message-Id: <20220205205647.7677-2-marius@FreeBSD.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220205205647.7677-1-marius@FreeBSD.org>
References: <20220205205647.7677-1-marius@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
        s=dkim; t=1644094632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuSGZ5/yCrBoF5NKk8PtVR/aMcZdGo3tebV8LC0pus0=;
        b=lJeqwf57TdAGBoPU9FRwHdhGUQ8M533sE3wpCfh8hcKpqlY5AM4cXUeTUnOe5j7Og76w1v
        Y7VzeJvO+TstN9oG+fLZHk/KS5Aeu1tkK8SlyEpzC83E+nPdgbZTs8uwAM5FDY6NG21WBe
        LbveqrtyT2H+MnGgSX9T8r0oEX/Rz4MAudyAjfs4oaXw5X1IPbQN+IWT2sH3sa5Wj8yZFE
        slI9FOE15E8y8fmY1a3gomRzGwnrw5EwpHIUhx2ZP6UNv5clzOIZhxY5t7AJ97jCtadQCA
        vM9BdC/q9bJW3kyDA+9qLVVzu79Rk9kLBzjfikGsHsYYYjJWs+pTbVglhVOigw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1644094632; a=rsa-sha256; cv=none;
        b=moxEGCk8AM1D6TgxG2dbGSyDZkmsWMG+W/cDY3nQs7ysRLnQeAJK34gAvdD3H6tPoX1ChX
        /jxCVxy2Nj/8stFv+0hoXz8KfazHr3OoxDL01CDLP3dvXhjearnYJJO8T8IEFT6ZHbMUTL
        YduPXa/sPfW0Il/u15lISyMkYb2qljQ3oOvt/APsaYO2RYvoYSZmLr+2rSLT+1ohcPmMGI
        5ngmCQFJPIQElnWGgcvwjYNjDvv2z1ew5IInKaBJbn43AYtfzT26p2/um21xNTmt0a/Ocb
        gff4Hgleg5yApnEsKxg8LQ30fLQIOa8CC6liy3h2d7z3pq6cjqUJ3O4hERrjQg==
ARC-Authentication-Results: i=1;
        mx1.freebsd.org;
        none
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It was added in commit 294bf86972d6 ("mmc-utils: Remove dependency on
linux/major.h.") but never actually used, apparently.

Signed-off-by: Marius Strobl <marius@FreeBSD.org>
---
 mmc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mmc.h b/mmc.h
index e9766d7..2ff6e66 100644
--- a/mmc.h
+++ b/mmc.h
@@ -19,9 +19,6 @@
 
 #include <linux/mmc/ioctl.h>
 
-/* From kernel linux/major.h */
-#define MMC_BLOCK_MAJOR			179
-
 /* From kernel linux/mmc/mmc.h */
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
-- 
2.31.1

