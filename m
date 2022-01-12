Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFAC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Jan 2022 13:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiALN4Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:56:16 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:55433 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbiALN4G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2022 08:56:06 -0500
Received: (Authenticated sender: foss@0leil.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4F957200008;
        Wed, 12 Jan 2022 13:56:03 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH] add README
Date:   Wed, 12 Jan 2022 14:54:53 +0100
Message-Id: <20220112135453.5927-1-quentin.schulz@theobroma-systems.com>
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
 README | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 0000000..47f436b
--- /dev/null
+++ b/README
@@ -0,0 +1,32 @@
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
+abiove) to the linux-mmc@vger.kernel.org mailing list with maintainers as
+Cc recipients.
+
+Maintainers
+-----------
+
+Ulf Hansson <ulf.hansson@linaro.org>
+
+License
+-------
+
+This project is licensed under:
+ - BSD-3-Clause for lsmmc,
+ - GPL-2.0-only for everything else,
-- 
2.34.1

