From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: MMC block addressing mode.
Date: Thu, 13 Apr 2017 14:49:37 -0500
Message-ID: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:40289
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755951AbdDMTtm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Apr 2017 15:49:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

Uffe,

The Cavium hardware requires knowledge of the card addressing mode.
We need to either restore mmc_card_blockaddr(), or create another
way to generate the same information. You previously suggested use
of the 'blksz' value, however, it has the same value regardless of
the card capacity. What would you suggest? Cheers.

Steve
