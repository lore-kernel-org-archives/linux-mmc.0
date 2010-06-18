From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: sdhci : reduce irq off latency
Date: Fri, 18 Jun 2010 09:16:41 +0900
Message-ID: <AANLkTinZ8If_JswEhoOShRZbQSjlh1uKgFYasnsfFeRx@mail.gmail.com>
References: <4C19E5C3.2080700@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42572 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760005Ab0FRAQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2010 20:16:42 -0400
Received: by vws18 with SMTP id 18so100806vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2010 17:16:41 -0700 (PDT)
In-Reply-To: <4C19E5C3.2080700@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: linux-mmc@vger.kernel.org

Hi,

Not good news. This patch make a hang at probe time.
it's tested against commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 11 19:14:04 2010 -0700

    Linux 2.6.35-rc3

Thank you,
Kyungmin Park

On Thu, Jun 17, 2010 at 6:07 PM, Matthieu CASTET
<matthieu.castet@parrot.com> wrote:
> sdhci code got tasklets (sdhci_tasklet_card and sdhci_tasklet_finish)=
,
> that does :
> {
> spin_lock_irqsave
>
> if (cond) {
> sdhci_reset
> sdhci_reset
> }
>
> spin_unlock_irqrestore
> }
>
> sdhci_reset {
> ...
> while (read_reg) {
> if (timeout =3D=3D 0)
> =A0 break;
> timeout--;
> mdelay(1);
> }
> ...
> }
>
>
> The problem is that sdhci_reset [1] does busy pooling (with a granula=
rity of
> 1 ms) on a register up to a timeout of 100 ms.
>
> With the current code, we got irq off during 2*1ms. With the attached=
 patch
> we reduce irq off to 30 us.
>
> Note that worst case 100 ms irq off still exist.
>
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
>
>
