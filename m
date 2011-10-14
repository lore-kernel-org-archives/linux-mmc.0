From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Fri, 14 Oct 2011 08:13:17 +0800
Message-ID: <CACVXFVMnm2rLPNsaLtTT2NtVkh5UFO8mEy7E9VWNYdjhvw2-0A@mail.gmail.com>
References: <CACVXFVMoac7psbfO6UdDvNux4c8bQYS4YNUdz1C-o+CiJzyuZA@mail.gmail.com>
	<Pine.LNX.4.44L0.1110131202350.2026-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35026 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab1JNANS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 20:13:18 -0400
In-Reply-To: <Pine.LNX.4.44L0.1110131202350.2026-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Likely <grant.likely@secretlab.ca>, Andrei Warkentin <awarkentin@vmware.com>, Greg KH <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Manjunath@jasper.es, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, Oct 14, 2011 at 12:04 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 13 Oct 2011, Ming Lei wrote:
>
>> Hi,
>>
>> On Thu, Oct 13, 2011 at 10:31 PM, Alan Stern <stern@rowland.harvard.edu>
>> >> Maybe we should understand the correct model of the ordering constraints
>> >> for the multiple device dependancies first, could you give a description or
>> >> some examples about it?
>> >
>> > The requirement is that devices must be capable of resuming in the
>> > order given by dpm_list, and they must be capable of suspending in
>> > the reverse order.
>> >
>> > Therefore if device A can't work unless device B is functional, then B
>> > must come before A in dpm_list.
>>
>> If all devices can support async suspend and resume correctly, looks like
>> the device order given by dpm_list is not needed any longer, doesn't it?
>
> It _is_ needed, because the user can disable async suspend/resume via
> /sys/power/pm_async.
>
> Also, not all devices do support async suspend/resume.

Basically, the devices which don't support async suspend/resume
should have out of tree PM dependency. If out of tree PM dependency
issue is solved, all devices can support async suspend/resume.

thanks,
-- 
Ming Lei
