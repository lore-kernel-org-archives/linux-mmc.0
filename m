From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Mon, 14 Feb 2011 10:29:55 +0100
Message-ID: <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
	<AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
	<447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
	<B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41533 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BNJ34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 04:29:56 -0500
Received: by qwa26 with SMTP id 26so2948290qwa.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 01:29:55 -0800 (PST)
In-Reply-To: <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Feb 14, 2011 at 6:50 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> Pierre,
>
> are you comfortable with this ?
The mmc_delay() looks hackish at the first sight. Looks like Pierre
Ossman was the author, he must have his reasons.

It looks like the mdelay are not in the fastpath, so why bother.

And, more important, you will do cond_resched while holding you
spinlock, which is *bad*.
What if the mmc stack will call you again from another thread? deadlock=
=2E..


> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> -static inline void mmc_delay(unsigned int ms)
why do you want to remove it from here ?
It is still used by the core code.


> @@ -1043,7 +1043,7 @@ static void sdhci_set_clock(struct sdhci_host *=
host, unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(1);
This looks like timeout code that never happen in normal condition.


> @@ -1108,7 +1108,7 @@ static void sdhci_set_power(struct sdhci_host *=
host, unsigned short power)
> =A0 =A0 =A0 =A0 * can apply clock after applying power
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_delay(10);
Do you need this quirk in your platform?


Pierre
