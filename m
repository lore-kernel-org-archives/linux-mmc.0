From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Request for SPI testing
Date: Sat, 3 Jul 2010 22:51:25 -0600
Message-ID: <AANLkTingjwUlUlrho3xHS7AkuaZC3tK-lIizvFd_8_QS@mail.gmail.com>
References: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
	<20100703190504.693fe8fa.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43958 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0GDEvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Jul 2010 00:51:47 -0400
Received: by gwj21 with SMTP id 21so383537gwj.19
        for <linux-mmc@vger.kernel.org>; Sat, 03 Jul 2010 21:51:46 -0700 (PDT)
In-Reply-To: <20100703190504.693fe8fa.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: spi-devel-general@lists.sourceforge.net, linux-mmc@vger.kernel.org, Ernst Schwab <eschwab@online.de>, Ned Forrester <nforrester@whoi.edu>, David Brownell <dbrownell@users.sourceforge.net>, Anton Vorontsov <cbouatmailru@gmail.com>, openezx-devel@lists.openezx.org, Matt Fleming <matt@console-pimps.org>

On Sat, Jul 3, 2010 at 11:05 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Tue, 29 Jun 2010 21:30:34 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> I've pushed out Ernst's spi bus locking API patches to the following
>> branch. =A0Before I push them into linux-next, I'd like to get some
>> testing. =A0Can I have some volunteers please to pull this branch an=
d
>> give it a spin? =A0Bonus points for people who have mmc cards
>> multiplexed with other devices on their SPI bus.
>>
>
> From a quick test it works for me too, I have both the MMC and the PM=
IC
> (battery, regulators) attached to spi, this is Motorola A910 phone
> (pxa27x). Just FYI I applied the patches to 2.6.34 and tested with th=
is
> kernel, without the patches I cannot make mmc_spi work reliably (lots
> of I/O errors, due to conflict with the PMIC) with these patches I ca=
n
> finally use the MMC card.
>
> Thanks a lot,
> =A0 Antonio

Thanks everyone who tested.  I've pushed this out for linux-next
inclusion (next-spi branch)

g.
