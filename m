From: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [MX25][MMC] mmc esdhc very slow r/w speed
Date: Wed, 25 Jan 2017 12:32:59 +0300
Message-ID: <6861f8ad-25bf-21ff-1cef-21f6d473e512@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.181.189]:59344 "EHLO
        fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdAYJ4V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 04:56:21 -0500
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
        by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 87CFF24157A3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 12:33:03 +0300 (MSK)
Received: from [85.26.165.30] (port=10373 helo=[192.168.42.30])
        by smtp29.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1cWJwq-0003sz-MA
        for linux-mmc@vger.kernel.org; Wed, 25 Jan 2017 12:33:01 +0300
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi!
I have the same problem as:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091529.html
Read/write speed of SDHC card is very slow.
Kernel 2.6.35 from Freescale works with a excellent mmc performance.
Mainline kernels from 3.17 to 4.9.5 works very slow with mmc.
Is there any solutions about this problem?
