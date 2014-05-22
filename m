From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
Date: Thu, 22 May 2014 14:15:09 +0200
Message-ID: <CAPDyKFqhsErJvw-GYFq=x0xQigt=Tr3Luw=-n12cL5o5D5eGNw@mail.gmail.com>
References: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
	<86zjiaqarn.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:64819 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbaEVMPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 08:15:10 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so5425748qgd.27
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 05:15:09 -0700 (PDT)
In-Reply-To: <86zjiaqarn.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Markus Pargmann <mpa@pengutronix.de>

On 22 May 2014 14:05, Chris Ball <chris@printf.net> wrote:
> Hi Ulf,
>
> On Thu, May 22 2014, Ulf Hansson wrote:
>> Here are a third and final collection of patches for 3.16.
>>
>> I have as you and I discussed (off list), collected the patches from
>> Russell's sdhci patchset. I needed to resolve some conflicts while
>> applying them, but it was manageable. I also omitted the patch which
>> was reported to caused problem with eMMC, (mmc: sdhci: hack up drive=
r
>> to make it more compliant with UHS-1).
>
> Pulled, but:

Great!

>
> drivers/mmc/host/sdhci.c: In function =E2=80=98sdhci_set_uhs_signalin=
g=E2=80=99:
> drivers/mmc/host/sdhci.c:1432:12: error: =E2=80=98ios=E2=80=99 undecl=
ared (first use
> in this function)
>   else if ((ios->timing =3D=3D MMC_TIMING_UHS_DDR50) ||
>             ^

Seems like I manage to break it while I resolved the conflict for the
below commit:

"mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function"

The following lines...
+       else if ((ios->timing =3D=3D MMC_TIMING_UHS_DDR50) ||
+                (ios->timing =3D=3D MMC_TIMING_MMC_DDR52))
+               ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50;

Should be replaced by;
+       else if ((timing =3D=3D MMC_TIMING_UHS_DDR50) ||
+                (timing =3D=3D MMC_TIMING_MMC_DDR52))
+               ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50;

Can you update the code and amend the commit?

Kind regards
Uffe
