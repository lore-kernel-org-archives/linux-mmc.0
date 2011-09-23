From: Praveen G K <praveen.gk@gmail.com>
Subject: slow eMMC write speed
Date: Thu, 22 Sep 2011 22:05:51 -0700
Message-ID: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39684 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IWFFw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2011 01:05:52 -0400
Received: by fxe4 with SMTP id 4so3442087fxe.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2011 22:05:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello all,

I am working on the block driver module of the eMMC driver (SDIO 3.0
controller).  I am seeing very low write speed for eMMC transfers.  On
further debugging, I observed that every 63rd and 64th transfer takes
a long time.  I have tabulated this by noting the time interval
between when CMD 25 (multi block write command) is sent and when
DATA_END interrupt is received.  In normal cases, to transfer 64k (128
blocks of data), it takes about 2.5ms.  But, under the really slow
transfer speed cases, it takes about 250-350ms to get the data_end
interrupt after the multiblock write command is sent.  In some cases,
it takes a longer time.  This radically reduces the throughput of the
transfers.

I have also enabled the bounce buffers.  As a side question, can
somebody please tell me why the bounce buffer is restricted to 64kB?

Thanks in advance for any help that you can provide me on this issue.
Also, please include my email id in the cc field when replying to this
email since I am not subscribed to this mailing list.

Thanks,
Praveen Krishnan
