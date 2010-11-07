From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 7 Nov 2010 10:51:25 +0000
Message-ID: <AANLkTimcoDvfVLxF6c3c78yeBOoNGsuTm1ZaSujM0A4b@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
	<AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
	<AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
	<AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
	<AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
	<AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
	<AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
	<AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
	<AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
	<AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
	<AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
	<AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
	<AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
	<AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
	<AANLkTinXyW-iymJUeXGODLLBOevTwyUOcROg-B1wwJcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52736 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab0KGKv0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 05:51:26 -0500
Received: by gwj21 with SMTP id 21so2873405gwj.19
        for <linux-mmc@vger.kernel.org>; Sun, 07 Nov 2010 02:51:26 -0800 (PST)
In-Reply-To: <AANLkTinXyW-iymJUeXGODLLBOevTwyUOcROg-B1wwJcA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 7 November 2010 10:42, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Good. Did it also solve the 1st issue you had ?

Yes.

>> But, what you point out is quite interesting.
>> We currently have a (not-yet-upstream) rfkill driver for the XO-1.5,
>> which we also put in place for power saving reasons.
>
> Can you please elaborate ? What power saving ? How do you exactly plan
> to use it ? Do you plan to power off the card without taking the wlan
> interface down first ?

If you take the interface down, the card is still powered up in some
way. We were looking for a way to cut as much power as possible.
It can be used by the "rfkill block wifi" command, and theres a
checkbox available in the sugar UI which calls that.

> Chris and I briefly discussed this in LPC, and he mentioned that you
> might have an external power source to that card, that is not
> controlled by the mmc regulator, and which you disable/enable from
> user space just before suspending the host ?

Not sure what he's referring to there. Perhaps he can clarify.

When I asked the hardware guy he said it was entirely controlled by
the normal SD power pin, but a full card reset will be needed after
cycling the power.

Daniel
