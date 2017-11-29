From: Gwendal Grignou <gwendal@chromium.org>
Subject: About mmc quirks for some Sandisk eMMC
Date: Tue, 28 Nov 2017 16:16:06 -0800
Message-ID: <CAMHSBOVdF1NwTKhmYdpW1x6u3xuUFOA1yAPWKeibCf_dur8-Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41657 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdK2AQ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Nov 2017 19:16:28 -0500
Received: by mail-wr0-f172.google.com with SMTP id z18so1783798wrb.8
        for <linux-mmc@vger.kernel.org>; Tue, 28 Nov 2017 16:16:28 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: andreiw@motorola.com, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Chris

Looking at c59d44739a8519cb7abdcd7cb7fd88f807dec9fd (mmc: card: Use
manufacturer ID symbols in card quirks.) you set Sandisk card
manufacturer ID at 0x2, but in
https://www.jedec.org/standards-documents/docs/jep-106ab and actual
SEM16G eMMC, the manufacturing code is 0x45.
localhost device # cat name
SEM16G
localhost device # cat manfid
0x000045

Andrei,

Does the fix (6a7a6b45f454686a1549729bfbae31f0b3b595d6) for SEM16G
applies to a very specific model with different CID manfid or do we
need to upgrade drivers/mmc/core/quirks.h to really apply the quirks
to SEMxxG devices?

Gwendal.
