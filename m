From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 15:56:24 -0800
Message-ID: <AANLkTimOnOvePrb2dT7z15RMepMEBtA4NtKLgAJVk1gW@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
	<AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
	<AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
	<AANLkTi==6jPPBJQou8KAGZCKtmmN44Q85PR5x2_KOR2J@mail.gmail.com>
	<AANLkTinKiLF2+Yb0q9UmA21h1-uVRCSRmXNXzOWJNtnJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60234 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1CIX4Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 18:56:25 -0500
Received: by bwz15 with SMTP id 15so1106938bwz.19
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 15:56:24 -0800 (PST)
In-Reply-To: <AANLkTinKiLF2+Yb0q9UmA21h1-uVRCSRmXNXzOWJNtnJ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Grant Grundler <grundler@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

Hi,

On Wed, Mar 9, 2011 at 3:11 PM, Andrei Warkentin <andreiw@motorola.com> wrote:

>> Does kernel.org still need something to deal with state of
>> SDHCI_QUIRK_NO_SDIO_IRQ quirk bit?
>
> I'm confused. I see this quirk added as part of Tegra sdhci support in
> our K36 tree. I suppose with this patch the should be no need for this
> quirk. I'll apply your change today and see what I get.

Next time, feel free to cc me. :)

I removed the quirk during driver cleanup because, based on my
testing, it was no longer needed. I also asked nvidia why the quirk
was ever needed (took a while to get a response):

Turns out it was left over from hardware errata on a previous product
using the same IP block (i.e. Tegra 1), and is no longer required for
Tegra 2 (since the block gap interrupt is enabled).

So, no, it should not be needed in the upstream driver. The patch from
Grant is though.

If it's unappetizing for sdhci-wide consumption, we could add
suspend/resume hooks for sdhci-tegra only and save/restore it there.


-Olof
