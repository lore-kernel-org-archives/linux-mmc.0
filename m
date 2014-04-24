From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] mmc-utils: gp partition support
Date: Thu, 24 Apr 2014 16:17:50 +0530
Message-ID: <1398336472-16679-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbaDXKr7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 06:47:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Balaji T K <balajitk@ti.com>

Add support to create general purpose partition on eMMC device.
gp partition if needed can be marked with either enhanced or
extended attributes.

Note:
creation of gp partition with enhanced attribute has been tested.
Due to lack of access to eMMC device with extended attribute,
I could not test gp partition creation with extended attribute.

Balaji T K (2):
  mmc-utils: add check for max enhanced user area.
  mmc-utils: add support to create gp partition

 mmc.c      |    5 ++
 mmc.h      |   18 +++++
 mmc_cmds.c |  226 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 mmc_cmds.h |    1 +
 4 files changed, 248 insertions(+), 2 deletions(-)

-- 
1.7.5.4

