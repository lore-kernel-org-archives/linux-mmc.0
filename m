From: Matthias Kraemer <matthiasmartinsson@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Wed, 12 Apr 2017 22:37:16 +0200
Message-ID: <1492029437-19455-1-git-send-email-matthiasmartinsson@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37397 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdDLUhm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 16:37:42 -0400
Received: by mail-wm0-f47.google.com with SMTP id u2so32751945wmu.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2017 13:37:42 -0700 (PDT)
Received: from matthias-laptop.fritz.box (p57930ECB.dip0.t-ipconnect.de. [87.147.14.203])
        by smtp.gmail.com with ESMTPSA id e21sm7196510wmd.3.2017.04.12.13.37.40
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Apr 2017 13:37:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This patch device specific macros to define the pci_ids table within
the sdhci driver instead of just open-code them.
 

