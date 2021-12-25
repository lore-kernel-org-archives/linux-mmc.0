Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C68C433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Dec 2021 10:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhLYKuD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Dec 2021 05:50:03 -0500
Received: from ciao.gmane.io ([116.202.254.214]:35306 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhLYKuC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 25 Dec 2021 05:50:02 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glkm-linux-mmc@m.gmane-mx.org>)
        id 1n14cj-00082g-Kd
        for linux-mmc@vger.kernel.org; Sat, 25 Dec 2021 11:50:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mmc@vger.kernel.org
From:   Julian Sikorski <belegdol@gmail.com>
Subject: nothing happens upon SD card insertion (Asus Zenbook UM425IA,
 RTS522A)
Date:   Sat, 25 Dec 2021 11:45:57 +0100
Message-ID: <sq6sp6$cs9$1@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

I have an Asus Zenbook UM425IA laptop with Realtek RTS522A card reader:

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A 
PCI Express Card Reader (rev 01)


Almost every time when I insert a card into it, nothing happens - no 
dmesg message or anything.

echo 1 | sudo tee -a /sys/kernel/debug/tracing/events/mmc/enable

sudo cat /sys/kernel/debug/tracing/trace_pipe > mmc_trace.txt

also results in an empty file. If I am lucky, the card will be detected 
after some delay and the following will appear in the log:

Dez 25 11:34:41 snowball3 kernel: mmc0: cannot verify signal voltage switch

Dez 25 11:34:41 snowball3 kernel: mmc0: new ultra high speed SDR50 SDHC 
card at address aaaa

Dez 25 11:34:41 snowball3 kernel: mmcblk0: mmc0:aaaa SL32G 29.7 GiB

Dez 25 11:34:41 snowball3 kernel:  mmcblk0: p1


How can I investigate this further? As things stand now, the reader is 
almost unusable. I am using 5.15.11-200.s0ix01.fc35.x86_64 kernel. Thank 
you in advance.

Best regards,
Julian

