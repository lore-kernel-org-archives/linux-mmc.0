From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 18:07:37 -0600
Message-ID: <AANLkTi=gVXFUajp3K_bhy8P0VcJ2v4=xNYPE7WySQEiL@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
	<AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
	<AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
	<AANLkTi==6jPPBJQou8KAGZCKtmmN44Q85PR5x2_KOR2J@mail.gmail.com>
	<AANLkTinKiLF2+Yb0q9UmA21h1-uVRCSRmXNXzOWJNtnJ@mail.gmail.com>
	<AANLkTimOnOvePrb2dT7z15RMepMEBtA4NtKLgAJVk1gW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:60513 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1CJAHk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:07:40 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2A07tlX008859
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:07:55 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2A05uEu008352
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:07:55 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 39so1337649vxb.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:07:38 -0800 (PST)
In-Reply-To: <AANLkTimOnOvePrb2dT7z15RMepMEBtA4NtKLgAJVk1gW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Grant Grundler <grundler@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

On Wed, Mar 9, 2011 at 5:56 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Mar 9, 2011 at 3:11 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>
>>> Does kernel.org still need something to deal with state of
>>> SDHCI_QUIRK_NO_SDIO_IRQ quirk bit?
>>
>> I'm confused. I see this quirk added as part of Tegra sdhci support in
>> our K36 tree. I suppose with this patch the should be no need for this
>> quirk. I'll apply your change today and see what I get.
>
> Next time, feel free to cc me. :)
>
> I removed the quirk during driver cleanup because, based on my
> testing, it was no longer needed. I also asked nvidia why the quirk
> was ever needed (took a while to get a response):
>
> Turns out it was left over from hardware errata on a previous product
> using the same IP block (i.e. Tegra 1), and is no longer required for
> Tegra 2 (since the block gap interrupt is enabled).
>
> So, no, it should not be needed in the upstream driver. The patch from
> Grant is though.
>
> If it's unappetizing for sdhci-wide consumption, we could add
> suspend/resume hooks for sdhci-tegra only and save/restore it there.
>

I believe Grant's change is necessary for any SDHCI controller with
SDIO and suspend/resume.

A
