Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B9C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 20:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A0F61205
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Sep 2021 20:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhITUC0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Sep 2021 16:02:26 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:14305 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbhITUAZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2021 16:00:25 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 16:00:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1632167211;
    s=strato-dkim-0002; d=heimpold.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=sYmeE9NhGej+TIULAW92fTrv6k82xbmWvx7J2kvBIIk=;
    b=ChBAGs1MP615V7qzRaj3nlEER+l4pBzJ3iq7iCUat7ESBjGEjOtZnoiYqnEOr9tsV1
    KobDnSKCxIOaQGil+eUiQs2j0OYXx0Ki8g6ZRPM3gfrqJSaNKevv4jEI2h54rBcDYHZo
    Mx2F7p56nqRo5uK/to4E0pfeyF+nsxwfqvQgbeDAB/94yRzJBurApQGtS8OQBBBu+08b
    dH/agUP812Abcxck7cVyUtyzYxx1R76KL+iOnaFzGwz4+uIlPyHDwJU90tPjqDTfmKPQ
    H1IKHxMUFeq4rXk1xO1vYyp25pJn3lDzyWx3tUsWSt4+fnGnYvRCj6/jOM6jSa641bjd
    EYYw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZKUSN7PfdWTGQORRBv+ASfYPl1MuUMIWkP+zAVCpUbQGp4/2evP5zAp3QxIrLJQ=="
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id x085ffx8KJko2AG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 20 Sep 2021 21:46:50 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 21E13179F70;
        Mon, 20 Sep 2021 21:46:50 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     linux-mmc@vger.kernel.org
Cc:     Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH v3] mmc-utils: One further optimization of trimming routine
Date:   Mon, 20 Sep 2021 21:46:33 +0200
Message-Id: <20210920194633.814-1-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The last change to the trimming routine made it more efficient,
however, we can even get rid of the memmove() as we leave the
function with strdup() anyway.

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

While doing some house-keeping, I found this somewhat older
patch still hanging around (v2 was sent on 2018-12-08).
I'm just resending to check what's the current opinion
about it :-)

 lsmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lsmmc.c b/lsmmc.c
index 06cc0b8..05d59e8 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -393,10 +393,9 @@ char *read_file(char *name)
 		start++;
 		len--;
 	}
-	memmove(line, start, len);
-	line[len] = '\0';
 
-	return strdup(line);
+	start[len] = '\0';
+	return strdup(start);
 }
 
 /* Hexadecimal string parsing functions */
-- 
2.17.1

