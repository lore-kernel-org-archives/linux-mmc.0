From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Regression after "do not use CMD13 to get status after speed mode
 switch"
Date: Tue, 18 Oct 2016 16:23:39 +0300
Message-ID: <d08ed4e8-84b2-e337-c9ea-a6e36fb6b9e7@intel.com>
References: <CACRpkdbfNq+R9U9AwsKBM=xyKKTzyVDkiW4jqJ0Nb2LXvq20BA@mail.gmail.com>
 <CACRpkdaUf+YpUEhi-njseR1GQXvM3GuA97Q5GuEpQ3NtFdkoHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43333 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760970AbcJRN2b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Oct 2016 09:28:31 -0400
In-Reply-To: <CACRpkdaUf+YpUEhi-njseR1GQXvM3GuA97Q5GuEpQ3NtFdkoHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andy Gross <andy.gross@linaro.org>

On 18/10/16 11:36, Linus Walleij wrote:
> On Mon, Oct 17, 2016 at 4:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> Before this patch the eMMC is detected and all partitions enumerated
>> immediately, but after the patch it doesn't come up at all, except
>> sometimes, when it appears minutes (!) after boot, all of a sudden.
> 
> FYI this is what it looks like when it eventually happens:
> root@msm8660:/ [  627.710175] mmc0: new high speed MMC card at address 0001
> [  627.711641] mmcblk0: mmc0:0001 SEM04G 3.69 GiB
> [  627.715485] mmcblk0boot0: mmc0:0001 SEM04G partition 1 1.00 MiB
> [  627.736654] mmcblk0boot1: mmc0:0001 SEM04G partition 2 1.00 MiB
> [  627.747397] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 128 KiB
> [  627.756326]  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 p13
> p14 p15 p16 p17 p18 p19 p20 p21 >
> 
> So after 627 seconds, a bit hard for users to wait this long for their
> root filesystem.

If the driver does not support busy detection and the eMMC card provides
zero as the cmd6 generic timeout (which it may especially as cmd6 generic
timeout wasn't added until eMMCv4.5), then __mmc_switch() defaults to
waiting 10 minutes i.e.

#define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */

So removal of CMD13 polling for HS mode (as per commit
08573eaf1a70104f83fdbee9b84e5be03480e9ed) is going to be a problem for some
combinations of eMMC cards and host drivers.

