From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: Add an orphaned entry for the dw_mmc driver.
Date: Tue, 15 Jan 2013 10:56:12 +0000
Message-ID: <CAFbHwiQUqDsvsnKBm3gv3pYLeWf_EtNUam4OroZkhDUgPz1MGw@mail.gmail.com>
References: <CAFbHwiRX19Zm=O2dNZrbTDGZxnXDOx0zJ3pvTkfC1q8m5DBFug@mail.gmail.com>
	<87wqvjmxt6.fsf@laptop.org>
	<001301cdf233$9cf2bca0$d6d835e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:48263 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab3AOK4O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jan 2013 05:56:14 -0500
Received: by mail-la0-f47.google.com with SMTP id fh20so4855421lab.20
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jan 2013 02:56:12 -0800 (PST)
In-Reply-To: <001301cdf233$9cf2bca0$d6d835e0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>

On Mon, Jan 14, 2013 at 8:46 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Saturday, January 12, 2013, Chris Ball wrote:
>> Hi,
>>
>> On Fri, Jan 11 2013, Will Newton wrote:
>> > I submitted this driver but will shortly no longer have access
>> > to hardware that uses it. The driver is quite widely used so
>> > there may be someone out there that feels strongly enough to
>> > step up and maintain it.
>> > ---
>> >  MAINTAINERS |    6 ++++++
>> >  1 files changed, 6 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index f940e81..88329bc 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -6558,6 +6558,12 @@ F:   include/linux/dw_dmac.h
>> >  F: drivers/dma/dw_dmac_regs.h
>> >  F: drivers/dma/dw_dmac.c
>> >
>> > +SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
>> > +L: linux-mmc@vger.kernel.org
>> > +S: Orphaned
>> > +F: include/linux/mmc/dw_mmc.h
>> > +F: drivers/mmc/host/dw_mmc*
>> > +
>> >  TIMEKEEPING, NTP
>> >  M: John Stultz <johnstul@us.ibm.com>
>> >  M: Thomas Gleixner <tglx@linutronix.de>
>>
>> Thanks for your work on the driver, Will!  I'm CC'ing some recent
>> committers so they can volunteer to take over if they're interested.
> Will, Thank you for your efforts.
> It's interesting to me. I am ready to volunteer to maintain 'dw_mmc*' driver.
> I would appreciate it if you let me know what you think.

It's probably best to send a patch adding an entry to MAINTAINERS then
get a couple of acks (Chris and myself anyway). Would it make sense to
co-maintain with Jaehoon Chung as you have both been active in
submitting patches from Samsung?
