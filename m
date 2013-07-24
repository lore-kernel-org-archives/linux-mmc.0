From: Franck Jullien <franck.jullien@gmail.com>
Subject: Question about SD/MMC card sharing the same host bus
Date: Wed, 24 Jul 2013 13:32:24 +0200
Message-ID: <CAJfOKBzep_C4juyDHhwSgJGcB632FmnKU5AJ1jFAt_naSdV_Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41025 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab3GXLcZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2013 07:32:25 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so2804630wgh.5
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2013 04:32:24 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I'd like to know if the current Kernel provides support for card wired
on the same host bus, sharing all signals.

>From what I've read so far, "the Host sends the ALL_SEND_CID command;
this causes all cards on the bus to start sending their unique ID,
while monitoring the bus traffic.". Then, "the host selects a card via
its local address using CMD 7, which places that card in the transfer
state.".

However, looking at the Linux mmc source code, selecting a card using
its address seems only be done while probing cards. There is no
xxx_select_card while sending command to the targeted card.

Am I missing something here ?

Thanks in advance.

Franck.
