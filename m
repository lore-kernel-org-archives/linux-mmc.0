From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode switch"
Date: Tue, 18 Oct 2016 10:36:51 +0200
Message-ID: <CACRpkdaUf+YpUEhi-njseR1GQXvM3GuA97Q5GuEpQ3NtFdkoHw@mail.gmail.com>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34434 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbcJRIgw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 04:36:52 -0400
Received: by mail-qk0-f169.google.com with SMTP id f128so266380685qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2016 01:36:52 -0700 (PDT)
In-Reply-To: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>

On Mon, Oct 17, 2016 at 4:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Before this patch the eMMC is detected and all partitions enumerated
> immediately, but after the patch it doesn't come up at all, except
> sometimes, when it appears minutes (!) after boot, all of a sudden.

FYI this is what it looks like when it eventually happens:
root@msm8660:/ [  627.710175] mmc0: new high speed MMC card at address 0001
[  627.711641] mmcblk0: mmc0:0001 SEM04G 3.69 GiB
[  627.715485] mmcblk0boot0: mmc0:0001 SEM04G partition 1 1.00 MiB
[  627.736654] mmcblk0boot1: mmc0:0001 SEM04G partition 2 1.00 MiB
[  627.747397] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 128 KiB
[  627.756326]  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 p13
p14 p15 p16 p17 p18 p19 p20 p21 >

So after 627 seconds, a bit hard for users to wait this long for their
root filesystem.

Yours,
Linus Walleij
