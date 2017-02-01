From: amit mahadik <amitmaddy@gmail.com>
Subject: How to print CMD18 read data
Date: Wed, 1 Feb 2017 12:53:40 +0530
Message-ID: <CAMGZvfKXGwmrOSD-z_4F5aM5S7TPENmPkLKQ3ArQxJ+rEruhtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37530 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdBAHXm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 02:23:42 -0500
Received: by mail-it0-f48.google.com with SMTP id r185so11755902ita.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 23:23:41 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,
         I want to interface MMC card via SPI bus. However, I am
getting CRC errors for CMD18. I tried reading partition table using
CMD17 but still get errors.
The same SDMMC card gets detected using SD interface. I want to
compare the data of CMD18/CMD17 of SD and SPI modes. Please let me
know how can I print the read data of the said commands in the block
layer?

I tried using the following code but it didn't help

sg_copy_to_buffer(brq->data.sg, brq->data.sg_len, buf, 4096); and printed buf.

Regards,
Amit.
