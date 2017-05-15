From: Matthias Kraemer <matthiasmartinsson@gmail.com>
Subject: [PATCH V6] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Mon, 15 May 2017 23:44:16 +0200
Message-ID: <1494884657-18268-1-git-send-email-matthiasmartinsson@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33261 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdEOVot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2017 17:44:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so32041758wmh.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2017 14:44:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

I am re-sending this with another set of modifications and a cleaned commit message.

v2,3:
introduce device specific macros to shorten the pci_ids table even further
as suggested by Adrian
v4:
fix compile time issue

v5:
additional cleanup of macros                     

v6:
reorganizing of defines and macros, minor cleanup


