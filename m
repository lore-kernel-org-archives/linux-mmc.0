From: Torne Wuff <torne@wolfpuppy.org.uk>
Subject: Too large timeout requested for CMD25
Date: Sun, 12 Feb 2012 13:26:45 +0000
Message-ID: <CAA4+OU-D3m942qXjO-HNWrccoUKR-nXuu0b0mvJ0Y-G4ibHKVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:43635 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663Ab2BLN0q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Feb 2012 08:26:46 -0500
Received: by obcva7 with SMTP id va7so5524991obc.19
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2012 05:26:45 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I have a device with an Intel Poulsbo SDHCI controller and an eMMC,
and I get constant spam of:

mmc2: Too large timeout requested for CMD25

whenever I write to the device. I looked into this and worked out what
the card's CSD parameters suggest the write timeout should be, and
unfortunately it's so large it's not only impossible for the SDHCI
controller to reach, but actually causes an integer overflow during
the timeout calculation in mmc_set_data_timeout. :)

The TACC specifies a read time of 20ms, and R2W_FACTOR is 128, which
means it's claiming a write takes two and a half seconds, which is
then multiplied by ten to get the timeout - but this is a 32-bit
machine, so data->timeout_ns is an unsigned int and this overflows.
This looks like a bug in the MMC stack; even if this value is
ridiculous it seems to be allowed for by the spec, so it should
probably be taking care to avoid overflow here.

Even with the overflow the value wraps to 4.125 seconds, which is
still larger than the 48MHz timeout clock will allow, and thus it
continues to spam the too large timeout warning. I'm sceptical that
this warning is actually useful; unless I'm missing something, there's
nothing you can actually *do* about it other than throw the card out
and get one with saner values in CSD, which is tricky with an eMMC. At
most it should be sufficient to complain about this when CSD is read,
instead of during every command?

Is there anything I can sensibly do about this other than convince
syslog to filter the message out? I don't want to run a patched kernel
on this device forever. Would a patch to calculate the worst case
timeout at card detect time and just warn about it once be accepted?

Thanks in advance for any tips (and please leave me in CC as I am not
subscribed to the list),

--
Torne Wuff
torne@wolfpuppy.org.uk
