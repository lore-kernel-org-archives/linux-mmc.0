From: Renju Liu <i.am.renju.liu@gmail.com>
Subject: mmc card suspension problem
Date: Thu, 19 Nov 2015 16:57:33 -0500
Message-ID: <CA+pCbJ3C3+V3Rp2AmU9d2s_dOkHQE6=MpHrEpCeQZksezrTWOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34192 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759376AbbKSV5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 16:57:34 -0500
Received: by obbbj7 with SMTP id bj7so71839881obb.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2015 13:57:34 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi All,

I'm currently studying the suspension behavior of MMC. However, I
don't quite understand the rationale why the kernel needs to wait
until timeout in the following code:

/*
 * If the host does not wait while the card signals busy, then we will
 * will have to wait the sleep/awake timeout.  Note, we cannot use the
 * SEND_STATUS command to poll the status because that command (and most
 * others) is invalid while the card sleeps.
 */

if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY)){
mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
}

Can anyone explain this to me?


Best,
Renju Liu
i.am.renju.liu@gmail.com
--------------------------------------------
"Renju is awesome!"
