From: Daniel Drake <dsd@laptop.org>
Subject: -ENOSYS suspend-powerdown regression
Date: Mon, 30 May 2011 15:26:19 +0100
Message-ID: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63440 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab1E3O0T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 10:26:19 -0400
Received: by pvg12 with SMTP id 12so1632744pvg.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 07:26:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

The libertas_sdio driver has a suspend routine which returns -ENOSYS
when the card should effectively be removed and powered during
suspend, to be re-probed during resume.

This is broken in linus master. Everything appears somewhat normal
going down into suspend:

[   70.217948] libertas_sdio mmc1:0001:1: mmc1:0001:1: suspend: PM flags = 0x3
[   70.225588] uhci_hcd 0000:00:10.0: PCI INT A disabled
[   70.231140] viafb 0000:00:01.0: PCI INT A disabled
[   70.236233] libertas_sdio mmc1:0001:1: Suspend without wake params
-- powering down
[   70.244588] mmc1: card 0001 removed

but the "remove" routine of libertas_sdio is never called, meaning
that things get very confused during resume.

It was definitely working before (although I couldn't pinpoint exactly when).

Any ideas?

Thanks,
Daniel
