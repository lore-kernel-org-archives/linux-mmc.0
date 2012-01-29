From: Ido Yariv <ido@wizery.com>
Subject: Re: [RFC 1/2] mmc: davinci: Eliminate spurious interrupts
Date: Sun, 29 Jan 2012 21:37:10 +0200
Message-ID: <20120129193710.GA24514@WorkStation>
References: <4F1E9194.90608@mvista.com>
 <1327403766-962-1-git-send-email-ido@wizery.com>
 <B6A220404B6BFC4BBD2AB91C54D39DF43176A5C7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39740 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab2A2ThU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2012 14:37:20 -0500
Received: by wgbed3 with SMTP id ed3so3807194wgb.1
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2012 11:37:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <B6A220404B6BFC4BBD2AB91C54D39DF43176A5C7@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>

Hello Sudhakar,

On Fri, Jan 27, 2012 at 08:11:55AM +0000, Rajashekhara, Sudhakar wrote:
> I tested both these patches and they work fine on the OMAP-L138 EVM. I
> observed that with these patches the number of interrupts during a transfer
> are less compared to earlier. For a 100 MB transfer, I could see around
> 700-800 interrupts less. Did you see any performance improvement with these
> patches?

Thanks for testing these.

The difference in the number of interrupts, or rather the ratio, depends
on the scenario you're working on.
The spurious patch has an effect on non-dma transfers, while the polling
optimization affects small (i.e. up to 128 bytes) transactions.
I expect these to have a greater impact on SDIO scenarios than on SD scenarios.

Regarding the performance improvement, these patches were tested using a
WLAN SDIO adapter, which requires quite a few small transactions.
The polling optimization had an impact of around 10-15% in throughput.
The spurious patch did not have any noticeable effect on throughput, but did
lower the number of interrupts by up to 25% in some cases.

Thanks,
Ido.
