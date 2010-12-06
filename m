From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: reference implementation of runtime PM
Date: Mon, 6 Dec 2010 23:42:29 +0200
Message-ID: <AANLkTingua1jOcw=60Qg75iEgm4yLz3BSrCKiNU18VPH@mail.gmail.com>
References: <AANLkTikK-SvvDHfeNHXP4tw_e3p3gZ4XaT8Ta5YpuDar@mail.gmail.com> <AANLkTimbc3Hwq+JckQLW5=AMAzhDTQGaPsaS-r5M0XKt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34810 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab0LFVmu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 16:42:50 -0500
Received: by iwn9 with SMTP id 9so689189iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Dec 2010 13:42:49 -0800 (PST)
In-Reply-To: <AANLkTimbc3Hwq+JckQLW5=AMAzhDTQGaPsaS-r5M0XKt@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Mon, Dec 6, 2010 at 10:03 PM, Daniel Drake <dsd@laptop.org> wrote:
> power_save is done by the bus, not the host, and the host does get it=
s
> opportunity to power down via the set_ios callback that comes in
> telling it to turn the card off.

yes.

In fact, the actual work is being handled by mmc_power_off, and not by
the ->power_save() handler (which is not being used at all today).

>
> Still can't get our card to reset properly though. Tried sprinking
> some sdhci_reset and sdhci_reinit calls around, no luck.
>
> We do know that it can be powered down and up just fine at runtime vi=
a
> mmc_stop_host then mmc_start_host.

Just wondering.. how did you verify this ? rmmod/insmod your host contr=
oller ?

> So there's something that happens
> in that path which does not occur with runtime pm...

Then you can probably compare the flow (ftrace ?) and find the differen=
ce.

>
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
