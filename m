From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Fri, 09 Mar 2012 13:34:52 -0800
Message-ID: <87eht131c3.fsf@ti.com>
References: <Pine.LNX.4.44L0.1203091015290.1527-100000@iolanthe.rowland.org>
	<87pqcl4s4d.fsf@ti.com> <201203092159.40409.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59826 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601Ab2CIVev (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 16:34:51 -0500
Received: by mail-iy0-f173.google.com with SMTP id j26so3432382iaf.32
        for <linux-mmc@vger.kernel.org>; Fri, 09 Mar 2012 13:34:50 -0800 (PST)
In-Reply-To: <201203092159.40409.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 9 Mar 2012 21:59:40 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, March 09, 2012, Kevin Hilman wrote:
>> Alan Stern <stern@rowland.harvard.edu> writes:
>> 
>> [...]
>> 
>> > How about calling it "runtime latency"?  Or "runtime wakeup latency" in 
>> > case people think there might be some other sort of latency associated 
>> > with runtime power management.
>> 
>> Either is better than just latency, but I would vote for runtime wakeup
>> latency.
>
> Well, that would be pm_qos_runtime_wakeup_latency_us.  Kind of long, IMHO.

Yeah, the long names are why I initially suggested having a 'qos'
subdir.  

> Apart from this "wakeup" may be thought to refer to "remote wakeup", which
> is when a device is resumed as a result of an external signal.
>
> pm_qos_resume_latency_us is shorter and since it is referred to in the
> documentation as "resume latency", I don't see any problems with that name.

OK

Kevin
