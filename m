From: Naveen Kumar Parna <pnaveenkos@gmail.com>
Subject: mmc: sdhci: SDIO OCR Signal voltage switch fail crash?
Date: Thu, 11 Feb 2016 22:11:12 +0530
Message-ID: <CAG0bkv+7AFepFYVsZZuW6WoHh9=pTbn+bmVmtBuHiAAwRUc6+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33406 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcBKQlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 11:41:12 -0500
Received: by mail-ig0-f181.google.com with SMTP id y8so14636475igp.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 08:41:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,



As per SDIO spec version 3.0, I/O OCR bit position range is from 0 to
23, but in mmc_sdio_init_card() OCR=E2=80=99s bit24 set to 1 if card  s=
upports
1.8V signalling.



OCR bit position 24 is out of range right?



It may lead to crash after =E2=80=9CSignal voltage switch failed power =
cycling
card=E2=80=9D in sdhci_set_power()=E2=80=99s BUG() statement.



Thanks,

Naveen
