Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DAC433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Feb 2022 20:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiBEU5R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 5 Feb 2022 15:57:17 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:22371 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241545AbiBEU5Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 5 Feb 2022 15:57:16 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 3D9B0765BE;
        Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
        (envelope-from marius@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4Jrl8S115cz4jv4;
        Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
        (envelope-from marius@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
        t=1644094632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOSRFVjhGeV3+LmN1bdkdkaeODnfJ0HC11OD5hljoUM=;
        b=Go7kQzZ3FJp2QQD48i+4Bgt7lNVH0vy5nHSv5zqHti8DvWAVROgm+rY4bfDCP6rrivNX+E
        Eme6L2WpYF4AysortUASSJCZrOBqqiCnm/Cgb3MJB5urBs9c5IWohjqhZFrJdHh3RT+ksX
        r0+NMBtWKw4ySr86Ept68RbbumfDTFWUG20Wl6IZ7l0Ayw2FPG5cbpxOH1HLjqR7uAb2cX
        Ojmp9UR/8LbTBuMMZTCJJZaPW9/nviE2zqkQiMtPQANVmv73CgS1G+CXKLlPmQPJ2Ax1YX
        GxsKzMEge4WC7/FTp3nu8IBSFBZTfCOh4N4IbcNwdAknnxUn2M4nxewrTIuPHQ==
Received: by freefall.freebsd.org (Postfix, from userid 1018)
        id 086A03A47; Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
From:   Marius Strobl <marius@FreeBSD.org>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marius Strobl <marius@FreeBSD.org>
Subject: [PATCH 3/3] mmc-utils: Display STROBE_SUPPORT when printing EXT_CSD
Date:   Sat,  5 Feb 2022 20:56:47 +0000
Message-Id: <20220205205647.7677-3-marius@FreeBSD.org>
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
        bh=mOSRFVjhGeV3+LmN1bdkdkaeODnfJ0HC11OD5hljoUM=;
        b=ZQRKpk15K16k5xZxEU/tzCVo6xSX5A3TYzbmtI+j7yVCNHLsYygs4V2li2hh1WCHZEoWr+
        JdS1Tv4j/R7I9sFqiMqYQk2uybmbg7jGeBAr6ix/bb8ZxZyLlzzWdT8WvLe4JQmP0+6CaT
        UCHSE0Qj1c0YeI+URrubmTZkThvz9L6Fye1ObjiVPvq0yFu42yWVDCM896Fxmn214p3pcw
        T6tcTS85a9FnuiYOsvlEX3et5IT8jvN/zA4C5SZhwklHJArn4h4N/bRtTwMQwgThV5ryxg
        XvjPm1lO0+Uh5Z3wFR5rN6gDStxG6eLSDWeo+wm2WeBC1A3n5fDdemp5YzJ5tQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1644094632; a=rsa-sha256; cv=none;
        b=iAbys9EwdyJvkCHpoSnYh6n2ttOYMne3URkQy07dSb1BqrNB8S2CnKPqdSyRDZQSM9bkB3
        8K8FIFUdpgDil9IH/UaOpiSY4sCJfnKn3NPeL5uVb/bgi2+HjvhAZ4I/dqc7/yHItCIIcr
        rW+iUrG90IvEYRufrblyH/9X2n9KckK3zomjb1KYjwmbXJp5X8+IbCnAmuISUaXYbrL0NL
        Iet4ICylwnocCqeXDMY9CmR4tAT36cEU+UEp86/nCUmhcOww0DTPmH56643Yu3kvQVrBkl
        6N2zB28w90YKb7rwhsyd4laUZY40xOLCLdnMnB7pEK+pFsUbj7okv9NPx9ulBQ==
ARC-Authentication-Results: i=1;
        mx1.freebsd.org;
        none
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Support for Enhanced Strobe mode introduced in eMMC 5.1 JESD84-B51
can be determined via EXT_CSD[184]. Along with the identification of
HS400 data rates added in commit 3969aa4804ed ("mmc_cmds: add HS400
data rates"), this allows to differentiate support for HS400/HS400ES.

Signed-off-by: Marius Strobl <marius@FreeBSD.org>
---
 mmc_cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index f024079..508ddad 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1628,6 +1628,9 @@ int do_read_extcsd(int nargs, char **argv)
 	printf("Power class [POWER_CLASS: 0x%02x]\n", ext_csd[187]);
 	printf("High-speed interface timing [HS_TIMING: 0x%02x]\n",
 		ext_csd[185]);
+	if (ext_csd_rev >= 8)
+		printf("Enhanced Strobe mode [STROBE_SUPPORT: 0x%02x]\n",
+			ext_csd[184]);
 	/* bus_width: ext_csd[183] not readable */
 	printf("Erased memory content [ERASED_MEM_CONT: 0x%02x]\n",
 		ext_csd[181]);
-- 
2.31.1

