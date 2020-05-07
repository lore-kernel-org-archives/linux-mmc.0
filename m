Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA6BC38A24
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3481221835
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879073;
	bh=0/3czGbj+k5uPvCYm8OBIo+Z8QOj3dkRHRsWw+WWKIM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OzeytYt3QFBdNE59IjQQaScgQ+pxS/kk2v28ovN8jp81ONXUQZHi0xH7SelQKjFu9
	 VafqPhTG3fe5kmMHa35Jhbvg2lPF3Dq7qF4EKgFn7uONktLhXdH9pqc56fwCs/k6Dt
	 OLZ1Qr4eH9XFY0Kkqp5f2SwzcYbvr5S8C9VGmayo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgEGTRw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEGTRw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 May 2020 15:17:52 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416F8208D6;
        Thu,  7 May 2020 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879071;
        bh=0/3czGbj+k5uPvCYm8OBIo+Z8QOj3dkRHRsWw+WWKIM=;
        h=Date:From:To:Cc:Subject:From;
        b=vHJF+aq1utpEoV4h6yRFd8lbIxb270fu51bEDSro7iwkdcWn2K3Ww9ut5f9Mv9TUF
         E0/G1+mdPDutRcsm0U6kYvpm9TRms0cHlz20eNl9k5XsZHfa7uhdW4lBIQl2EsF5KC
         pD5ZBHzPB1I8Y25ciHCtJt8yo12g7TRGHBQfJujQ=
Date:   Thu, 7 May 2020 14:22:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: Replace zero-length array with flexible-array
Message-ID: <20200507192218.GA16315@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/memstick.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memstick.h b/include/linux/memstick.h
index 216a713bef7f..da4c65f9435f 100644
--- a/include/linux/memstick.h
+++ b/include/linux/memstick.h
@@ -288,7 +288,7 @@ struct memstick_host {
 	int                 (*set_param)(struct memstick_host *host,
 					 enum memstick_param param,
 					 int value);
-	unsigned long       private[0] ____cacheline_aligned;
+	unsigned long       private[] ____cacheline_aligned;
 };
 
 struct memstick_driver {

