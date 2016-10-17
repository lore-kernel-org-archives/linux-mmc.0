From: Linus Walleij <linus.walleij@linaro.org>
Subject: Regression after "do not use CMD13 to get status after speed mode switch"
Date: Mon, 17 Oct 2016 16:32:43 +0200
Message-ID: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:32840 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933583AbcJQOcq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2016 10:32:46 -0400
Received: by mail-qt0-f170.google.com with SMTP id s49so121272002qta.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2016 07:32:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>

Hi Chaotian,

my Dragonboard 8060 has a regression on detecting the eMMC after
bisecting it down to this patch (which is sadly already in v4.8):

commit 08573eaf1a70104f83fdbee9b84e5be03480e9ed
Author: Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Thu May 19 16:47:41 2016 +0800
mmc: mmc: do not use CMD13 to get status after speed mode switch

Before this patch the eMMC is detected and all partitions enumerated
immediately, but after the patch it doesn't come up at all, except
sometimes, when it appears minutes (!) after boot, all of a sudden.

Do you have any ideas on what can be wrong?

This is the Qualcomm MMCI variant whid does *not* support
busydetection in hardware.

I will continue looking at it but would be happy for any hints on how to
solve it, currently I cannot mount root off the eMMC because of this.

Yours,
Linus Walleij
