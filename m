From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Fri, 09 Mar 2012 09:10:58 -0800
Message-ID: <87pqcl4s4d.fsf@ti.com>
References: <Pine.LNX.4.44L0.1203091015290.1527-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:54100 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758213Ab2CIRK5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Mar 2012 12:10:57 -0500
Received: by mail-iy0-f180.google.com with SMTP id e36so3746288iag.39
        for <linux-mmc@vger.kernel.org>; Fri, 09 Mar 2012 09:10:56 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1203091015290.1527-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 9 Mar 2012 10:17:32 -0500 (EST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Alan Stern <stern@rowland.harvard.edu> writes:

[...]

> How about calling it "runtime latency"?  Or "runtime wakeup latency" in 
> case people think there might be some other sort of latency associated 
> with runtime power management.

Either is better than just latency, but I would vote for runtime wakeup
latency.

Kevin


