From: Richard Ash <richardashaudacity@googlemail.com>
Subject: Re: 'error -110 sending stop command' on Zynq platform
Date: Thu, 14 Apr 2016 14:20:20 +0100
Message-ID: <CACOFwanA-Bx6GYaJLRUAfwgXSxDkX55yGUbFzCTMovCgSZmQ_A@mail.gmail.com>
References: <CACOFwa=KnacTNDvsTcMzj4_0YCu8uADp3hrxFG7RDK+jLDCing@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36633 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbcDNNUV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 09:20:21 -0400
Received: by mail-oi0-f49.google.com with SMTP id y204so92862034oie.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Apr 2016 06:20:21 -0700 (PDT)
In-Reply-To: <CACOFwa=KnacTNDvsTcMzj4_0YCu8uADp3hrxFG7RDK+jLDCing@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC / SD subsystem <linux-mmc@vger.kernel.org>

On 13 April 2016 at 12:40, Richard Ash
<richardashaudacity@googlemail.com> wrote:
> I am regularly suffering system lock-ups caused by the above error on
> my custom board based on the Xilinx Zynq 7000 Soc. The error from the
> kernel is always exactly the same (including all the same hex values):
>
>  mmcblk0: error -110 sending stop command, original cmd response
> 0x900, card status 0xe00
[...]
> This problem originally showed up in a Xilinx kernel based on 3.18, I
> have subsequently upgraded the kernel to the Xilinx v2105.4.01 which
> is based on mainline 4.0.0, with no change in the messages and
> results. I am about to start on trying to run a stock mainline kernel
> to see if I can reproduce the problem there (although this generates
> other issues with drivers for the Xilinx QSPI controller).

I have now repeated the test using kernel 4.5.1 from kernel.org, which
supports enough hardware to get a serial console and test the SD card.
I am seeing effectively the same error

 mmcblk0: error -110 sending stop command, original cmd response
0x900, card status 0x400e00

This is the same message as before, except that the card status value
is printed wider. However I left the console open after it happened,
and received the following messages on it, in a block maybe a minute
or two later:

mmc0: Card stuck in programming state! mmcblk0 card_busy_detect
mmc0: card never left busy state
blk_update_request: I/O error, dev mmcblk0, sector 24060
Buffer I/O error on dev mmcblk0p1, logical block 15868, lost async page write
blk_update_request: I/O error, dev mmcblk0, sector 24061
Buffer I/O error on dev mmcblk0p1, logical block 15869, lost async page write
mmcblk0: error -110 sending status command, retrying
mmcblk0: error -110 sending status command, retrying
mmcblk0: error -110 sending status command, aborting
blk_update_request: I/O error, dev mmcblk0, sector 38551
Buffer I/O error on dev mmcblk0p1, logical block 30359, lost async page write

Where do I take this from here?

Richard
