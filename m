From: Timo Teras <timo.teras@iki.fi>
Subject: Re: error -110 sending stop command
Date: Tue, 24 May 2016 17:37:27 +0300
Message-ID: <20160524173727.63441f1c@vostro>
References: <20160524093747.12bfe046@vostro.util.wtbts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35856 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbcEXOhe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2016 10:37:34 -0400
Received: by mail-lf0-f47.google.com with SMTP id e130so7021715lfe.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2016 07:37:34 -0700 (PDT)
In-Reply-To: <20160524093747.12bfe046@vostro.util.wtbts.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Richard Ash <richardashaudacity@googlemail.com>, Tor Krill <tor@openproducts.com>

On Tue, 24 May 2016 09:37:46 +0300
Timo Teras <timo.teras@iki.fi> wrote:

> I'm having the following errors on my SD-card when writing to them:
> 
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 sending stop command, original cmd response 0x900,
> card status 0x400e00
>[...] 
>
> Any suggestions how to debug this further? Perhaps some quirks to
> test? Or already committed patches/fixes that might resolve this
> issue?

If I force PIO mode (sdhci.debug_quirks=0x60), I get:
[  111.201763] mmc0: Timeout waiting for hardware interrupt.
[  111.201887] mmc0: Got data interrupt 0x00000020 even though no data operation was in progress.
[  111.202032] mmcblk0: error -110 sending stop command, original cmd response 0x900, card status 0x400e00    

And enabling SDHCI_QUIRK_NO_MULTIBLOCK (sdhci.debug_quirks=0x200000)
seems to fix all immediate issues, but it also degrades the performance
seriously.
 
/Timo
