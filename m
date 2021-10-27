Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682BDC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E58961039
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 23:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhJ0XPA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:15:00 -0400
Received: from straum.hexapodia.org ([216.252.162.53]:47748 "EHLO
        straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJ0XO7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2021 19:14:59 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 19:14:59 EDT
Received: by straum.hexapodia.org (Postfix, from userid 22448)
        id 845D94070D; Wed, 27 Oct 2021 16:05:05 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:05:05 -0700
From:   Andy Isaacson <adi@hexapodia.org>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: mmc: update maintainer name and URL
Message-ID: <20211027230505.GA23994@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Old-GPG-Fingerprint: 1914 0645 FD53 C18E EEEF C402 4A69 B1F3 68D2 A63F
X-GPG-Fingerprint: A5FC 6141 F76D B6B1 C81F  0FB7 AFA0 A45F ED3D 116D
X-GPG-Key-URL: http://web.hexapodia.org/~adi/gpg.txt
X-Domestic-Surveillance: money launder bomb tax evasion
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mmc-utils repo is no longer in /cjb/ and Ulf has taken over 
maintenance.

Signed-off-by: Andy Isaacson <adi@hexapodia.org>

---
 Documentation/driver-api/mmc/mmc-tools.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/mmc/mmc-tools.rst b/Documentation/driver-api/mmc/mmc-tools.rst
index a231e9644351..eee1c2ccfa8f 100644
--- a/Documentation/driver-api/mmc/mmc-tools.rst
+++ b/Documentation/driver-api/mmc/mmc-tools.rst
@@ -2,10 +2,10 @@
 MMC tools introduction
 ======================
 
-There is one MMC test tools called mmc-utils, which is maintained by Chris Ball,
+There is one MMC test tools called mmc-utils, which is maintained by Ulf Hansson,
 you can find it at the below public git repository:
 
-	https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
+	https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
 
 Functions
 =========
-- 
2.20.1

