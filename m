From: Nitin Singla <nitin.akshainie@gmail.com>
Subject: Multiple eMMC Card Support ?
Date: Sun, 18 Aug 2013 08:43:17 +0530
Message-ID: <CAOprVPKYwo2Oq8pHMp4zX6c2D0snW0+CwaSvZRQKfPJyBXqL3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f65.google.com ([209.85.215.65]:57809 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab3HRDNS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Aug 2013 23:13:18 -0400
Received: by mail-la0-f65.google.com with SMTP id ep20so1252335lab.4
        for <linux-mmc@vger.kernel.org>; Sat, 17 Aug 2013 20:13:17 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have question regarding MMC subsystem ; whether it supports multiple
emmc card. As for eMMC in mmc_init_card function card->rca = 1 set for
all cards.
As per Jedec there is no chip select for eMMC so on the basis of
Relative Card Address card selected.
Jedec does not tell about multiple card support.

Thanks,
Nitin
