From: Vitaly Wool <vitalywool@gmail.com>
Subject: Huge regression caused by "mmc: Fix sd/sdio/mmc initialization
 frequency retries"
Date: Mon, 18 Jul 2011 13:08:32 +0200
Message-ID: <CAMJBoFMyoY9-Y8XEWKYua6UPaFWA2LH3FgP0fK9TpB6JgbQWXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46410 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab1GRLId (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2011 07:08:33 -0400
Received: by qwk3 with SMTP id 3so1424652qwk.19
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2011 04:08:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

the patch mentioned in subject is bound to break the functionality of
some SDIO cards' drivers. In fact, it will fail for any card probing
that requires an interrupt to consider itself complete.

The explanation is as follows:
1. This patch makes the MMC core claim host for the whole duration of
SDIO chip's probe function: sdio_add_func() is now called with the
host claimed.
2. The chip's probe function may have to wait for SDIO interrupt to
complete the initialization.
3. If it uses the SDIO interrupt, it will never get it because
sdio_irq.c uses a separate thread and when this thread claims the host
it will be stalled.
4. Chip's probe function fails on timeout.

I'm not stating that the whole patch is wrong but what it does at
least in sdio.c is weird so either there should be a correction of
this or I'll come up with the revert.

Thanks,
   Vitaly
