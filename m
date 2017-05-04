From: Matthias Kraemer <matthiasmartinsson@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Thu,  4 May 2017 20:55:57 +0200
Message-ID: <1493924158-2577-1-git-send-email-matthiasmartinsson@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35088 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbdEDS4W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 May 2017 14:56:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so2314935wrg.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 May 2017 11:56:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

Hello everybody,

I will give it another try. I just found a compile-time issue,
introduced during last minute clean-ups.

Kind regards
Matthias

