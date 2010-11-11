From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/5] mmc: do not clear the host->pm_flags when suspend
Date: Fri, 12 Nov 2010 01:45:40 +0200
Message-ID: <AANLkTikEEFXOf5=aiCMiG4HpRsxO13_7rx21xOGR1PCk@mail.gmail.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
 <AANLkTik1c0G2HNcXGboP8WA8vo9YvwYkUpM2=MGf-cLW@mail.gmail.com> <4CDB9A28.5030408@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63016 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab0KKXqB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 18:46:01 -0500
Received: by iwn10 with SMTP id 10so2755506iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2010 15:46:00 -0800 (PST)
In-Reply-To: <4CDB9A28.5030408@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Peppe,

On Thu, Nov 11, 2010 at 9:24 AM, Peppe CAVALLARO <peppe.cavallaro@st.co=
m> wrote:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pm_flags =3D 0=
;
>>
>> This is elapsed because the card is removed at this point (e.g. SDIO
>> returned -ENOSYS).
>>
>> Why would you want to use flags, set by a function driver of an SDIO
>> card, that was just removed ?
>>
> The define MMC_PM_KEEP_POWER has been used to notify that
> a device driver (e.g. sdhci-pltfm) want to wakeup the system.

MMC_PM_KEEP_POWER indicates that a card wishes to preserve its power
during system suspend; SDIO function drivers set it, if desired, and
if the host supports it.

If you permanently set it in sdhci-pltfm, you completely change the
interface. Drivers will be very surprised with such a default power-on
behavior.

> It is set in the pm_flags. When the sdhci suspend is invoked, it can
> call the mmc_suspend_host without free the interrupt if
> MMC_PM_KEEP_POWER is set.
> Then the sdhci_set_wakeup programs the HC to be able to wake up the s=
ystem.

MMC_PM_KEEP_POWER does not necessarily mean the user wants the system
to wake up on any SDIO events (e.g. it might be desired to keep a card
powered in a low power mode, without any wake-up expectancies, just to
be able to bring it up very quickly when the system resumes).

> When the resume is invoked the pm_flags is used to avoid to request t=
he irq.
> For this reason I removed the inst "host->pm_flags =3D 0;" from the
> mmc_suspend_host
> function. Maybe I could not remove it but add a check if the driver
> wants to wakeup

Who is this driver ? Host controller ? I don't think it should decide
whether the system will wake up or not on these events. Host
controller should merely provide capabilities (by means of pm_caps),
and let the upper layers choose.

> the system and the MMC_PM_KEEP_POWER is set. What do you think?

Beyond MMC_PM_WAKE_SDIO_IRQ, which is already established, you seem to
add two additional wake up events: card insertion and card removal.

The insertion event, at least (still need to think about the removal
one), have little to do with the SDIO function driver itself (e.g., if
the system is suspended, and the user inserts a card, obviously there
is no driver loaded for it yet that could have set pm_flags).

These events seem to be more system-wide and not driver-specific: does
the user want the host to wake up on card insertion or not ?

One idea that comes to mind is to use the PM core's wakeup sysfs
device attribute to control this; this way the user will be able to
directly enable/disable these wakeup events.

It might still make sense to use pm_flags and pm_caps here, and then
the user will manipulate the sysfs entries of the mmc host class_dev
rather than manipulating the host controller device directly. Not sure
how big an advantage is that, though.



>
> Thanks
> Regards,
> Peppe
>>
>>
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0}
>> > --
>> > 1.5.5.6
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>
