From: Boris Schmidt <boris.schmidt@siemens.com>
Subject: [PATCH v1 0/1]
Date: Tue, 14 Mar 2017 14:03:21 +0100
Message-ID: <1489496602-10306-1-git-send-email-boris.schmidt@siemens.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:53469 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdCNNIx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 09:08:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Boris Schmidt <boris.schmidt@siemens.com>, Chris Ball <chris@printf.net>

I made some tests on Micron MTFC16GAKAECN-4M IT to get the 10% values.

Boris Schmidt (1):
  mmc-utils: feature spec 5.0+, device life time estimation for MLC and
    pSLC mode

 mmc.h      |  2 ++
 mmc_cmds.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

-- 
2.1.4

