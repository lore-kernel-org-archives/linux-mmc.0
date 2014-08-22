From: romain izard <romain.izard@mobile-devices.fr>
Subject: Re: [PATCH v2] mmc: sdhci-sirf: fix 8bit width enable by overwriting set_bus_width
Date: Fri, 22 Aug 2014 10:15:09 +0200
Message-ID: <CAGkQfmPfYsEZ+QSep9pmm4xe0oYZ0L7eTjr5ROCksoqxnxqKSg@mail.gmail.com>
References: <1408453153-8125-1-git-send-email-21cnbao@gmail.com>
 <lt2b4j$tk3$1@ger.gmane.org> <CAGsJ_4yC+7G26pPGCMSmfKSCbw+k7VxhBMmxn3BNtqF-A08pqw@mail.gmail.com>
 <5EB3BFCD089AD643B9BB63439F5FD5E9012C982503@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:51049 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbaHVIPa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Aug 2014 04:15:30 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp4so8343845obc.29
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2014 01:15:30 -0700 (PDT)
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E9012C982503@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: Barry Song <21cnbao@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Minda Chen <Minda.Chen@csr.com>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>

2014-08-22 8:48 GMT+02:00 Barry Song <Barry.Song@csr.com>:
>
> Minda's version is:
> static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
> {
>         u8 ctrl;
>
>         ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>         ctrl &= ~(SDHCI_CTRL_4BITBUS | SDHCI_SIRF_8BITBUS);
>
>         if (width == MMC_BUS_WIDTH_8) {
>                 /*
>                  * CSR atlas7 and prima2 SD host version is not 3.0
>                  * 8bit-width enable bit of CSR SD hosts is 3,
>                  * while stardard hosts use bit 5
>                  */
>                 ctrl |= SDHCI_SIRF_8BITBUS;
>         } else if (width == MMC_BUS_WIDTH_4)
>                 ctrl |= SDHCI_CTRL_4BITBUS;

Here, the braces are not right. The coding style requires braces for both
sides of an 'else', or none of them

>
>         sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> }
>
> It is basically same with you.
>
Yes.

>> > You can use it verbatim with my signoff if you want.
>> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>
> do you mean a Reviewed-by?
>

In case you wanted to take the code snipplet I provided without changing it,
I provided you my Signed-off-by to be sure that there is no issue. Since Minda
wrote it on his/her own, it's not necessary.

But now, you can use:
Reviewed-by: Romain Izard <romain.izard.pro@gmail.com>

Best regards,
-- 
Romain Izard
