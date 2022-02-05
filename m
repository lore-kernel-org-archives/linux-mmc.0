Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C22C433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Feb 2022 20:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359693AbiBEU5R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 5 Feb 2022 15:57:17 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:22372 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352676AbiBEU5Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 5 Feb 2022 15:57:16 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 2B0DD7662E;
        Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
        (envelope-from marius@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4Jrl8S0RZGz4k6h;
        Sat,  5 Feb 2022 20:57:12 +0000 (UTC)
        (envelope-from marius@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
        t=1644094632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m+fupKVUT/hO2gLKe1/gKpJtcKq6h1c+tLbZJMFOnnA=;
        b=ZaR0bUasGYfLy6p7+1rXss1zK81GOkU+9bmJrPWomreJq93pwl8Evwtg5Od9YRonrSqcWk
        ZwScxhd7qCv0ADmYEq25yxPiI2DWx2+MzUr1qK8nGvxu5XFHTo/yShGrcPYB5b6Su0wUqS
        inCezkCrb7r5WFWVAAcJLJaql87W21kr1JqwHAv6IfNwSdi1aaW3BFAd0m5YxWsiC7n93D
        6Spk7HPuJ3jWqi9EVs/MZntcppEexJ9ejeaQzSVDK1Lw/OaZvjvqR4OmB7nUaUbfy9F3si
        wWPN5QYNLVFwy3D9F5Zahixy0306YhWb7dFaabFxGujDcjh4u9jg7mDE8FYSOA==
Received: by freefall.freebsd.org (Postfix, from userid 1018)
        id E9CE938E3; Sat,  5 Feb 2022 20:57:11 +0000 (UTC)
From:   Marius Strobl <marius@FreeBSD.org>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marius Strobl <marius@FreeBSD.org>
Subject: [PATCH 1/3] mmc-utils: manpage: Document -c option for partitioning commands
Date:   Sat,  5 Feb 2022 20:56:45 +0000
Message-Id: <20220205205647.7677-1-marius@FreeBSD.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
        s=dkim; t=1644094632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m+fupKVUT/hO2gLKe1/gKpJtcKq6h1c+tLbZJMFOnnA=;
        b=cI7tmYuqH+TfZb5Qw8ACg4EJbfHEjkxwupfThcRsU08LNklE7jUJXoxl2KGPnSkSGMMAPe
        IxFCL308gOE+3q9emOu9XU2+wtL3QOdIyRfk3OQsfXxn8Af2lQao6WLLTMx/3JKzEAA7lh
        rPlJGjRTvl96nW43bRGIpd9+VKz+J89cCTdUfByVcx0+c9g7ASFIMHAAnvdm58/UGDQFBK
        WMowAfmeHZ1GDTTK4JIVUIkL12jULi+of7dU1jb+v20DsBiHlY4rhaTsyqhIdYQGpTpM1y
        Qyr32O+bMur9rkc6bXiUIMrexwisOoDc0DoJIYjedgK9zNN8iClWwgrnDsi5iQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1644094632; a=rsa-sha256; cv=none;
        b=Nhip4NE2fjlUzucn7yKYT/AhUHjREHfDbw/IgFcczcRJHLBnv96ARJC2uiKhx13DNZ3gvE
        Q7EGcmUo3tcL9s8pIE6e54EByXjSZpYcXK+P192+/HvIPAqRlXJfu9qQ9wOrnFydYx42BB
        YQLypEMAAs3IMwqOvlN7asjFfznAJfPPoQXtKJW5Iwu1551D+DkqdKNRGNwJfxV7pxqtcZ
        gu0EcEamMJQg21uUvMbaf5qvt025w48k195iZwfViQcZtKtnC7AMPpJDpTG82dXJTdKfXF
        JoQaRiAGGcuzDmk046S8zSkEOB9FMbOoexSxLLvk87OKmp4jJ0vv8e9PeqXhkg==
ARC-Authentication-Results: i=1;
        mx1.freebsd.org;
        none
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 'continue' option was added in commit 752072dafe9c ("Add -c option
for partitioning commands).

Signed-off-by: Marius Strobl <marius@FreeBSD.org>
---
 man/mmc.1 | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/man/mmc.1 b/man/mmc.1
index bdb6f09..bccabf3 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -30,21 +30,24 @@ This sets the eMMC to be write-protected until next boot.
 Set the eMMC data sector size to 4KB by disabling emulation on
 <device>.
 .TP
-.BR "gp create <-y|-n> <length KiB> <partition> <enh_attr> <ext_attr> <device>"
+.BR "gp create <-y|-n|-c> <length KiB> <partition> <enh_attr> <ext_attr> <device>"
 create general purpose partition for the <device>.
-Dry-run only unless -y is passed.
+Dry-run only unless -y or -c is passed.
+Use -c if more partitioning settings are still to come.
 To set enhanced attribute to general partition being created set <enh_attr> to 1 else set it to 0.
 To set extended attribute to general partition set <ext_attr> to 1,2 else set it to 0.
 NOTE!  This is a one-time programmable (unreversible) change.
 .TP
-.BR "enh_area set <-y|-n> <start KiB> <length KiB> <device>"
+.BR "enh_area set <-y|-n|-c> <start KiB> <length KiB> <device>"
 Enable the enhanced user area for the <device>.
-Dry-run only unless -y is passed.
+Dry-run only unless -y or -c is passed.
+Use -c if more partitioning settings are still to come.
 NOTE!  This is a one-time programmable (unreversible) change.
 .TP
-.BR "write_reliability set <-y|-n> <partition> <device>"
+.BR "write_reliability set <-y|-n|-c> <partition> <device>"
 Enable write reliability per partition for the <device>.
-Dry-run only unless -y is passed.
+Dry-run only unless -y or -c is passed.
+Use -c if more partitioning settings are still to come.
 NOTE!  This is a one-time programmable (unreversible) change.
 .TP
 .BR "status get <device>"
-- 
2.31.1

