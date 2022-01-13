Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8162C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jan 2022 09:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiAMJol (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:44:41 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:36849 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiAMJod (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jan 2022 04:44:33 -0500
Received: (Authenticated sender: foss@0leil.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6110F20000B;
        Thu, 13 Jan 2022 09:44:25 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, avri.altman@wdc.com,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v2] add README
Date:   Thu, 13 Jan 2022 10:44:04 +0100
Message-Id: <20220113094404.64510-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This adds a README to the project so that the contribution process is
explicit as well as the licenses that apply to the source code.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

v2:
 - added Avri to the list of maintainers
 - fixed aboive typo
 - updated license to only mention GPL-2.0-only as BSD-3-Clause is
 compatible with GPL-2.0-only projects, as mentioned in
 3rdparty/hmac_sha/ files

 README | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 0000000..71a4e7d
--- /dev/null
+++ b/README
@@ -0,0 +1,31 @@
+MMC tools (mmc-utils)
+=====================
+
+mmc-utils is a tool for configuring MMC storage devices from userspace.
+
+Contribution guidelines
+-----------------------
+
+The project works using a mailing list patch submission process, similar to the
+process used for the Linux kernel itself.
+
+One can document themselves by reading how to submit a patch in the official
+Linux kernel documentation:
+https://www.kernel.org/doc/html/latest/process/submitting-patches.html
+
+Not all sections apply but it should be a good way to get started.
+
+A patch should be sent as a mail (not as an attachement, see documentation
+above) to the linux-mmc@vger.kernel.org mailing list with maintainers as
+Cc recipients.
+
+Maintainers
+-----------
+
+Avri Altman <avri.altman@wdc.com>
+Ulf Hansson <ulf.hansson@linaro.org>
+
+License
+-------
+
+This project is licensed under GPL-2.0-only.
-- 
2.34.1

