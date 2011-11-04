From: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Subject: Re: [PATCH]mmc: sdhci: use udelay instead of mdelay for some cases
Date: Fri, 4 Nov 2011 16:24:47 +0800
Message-ID: <20111104082445.GA32546@gmail.com>
References: <20111027041851.GA18442@gmail.com>
 <20111027051532.GA28387@pengutronix.de>
 <20111027050939.GA27531@gmail.com>
 <20111027060213.GB28387@pengutronix.de>
Reply-To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33111 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab1KDIiN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 04:38:13 -0400
Received: by ywf7 with SMTP id 7so2267801ywf.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2011 01:38:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111027060213.GB28387@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, w.sang@pengutronix.de
Cc: linux-mmc@vger.kernel.org

On Thu, Oct 27, 2011 at 08:02:13AM +0200, Wolfram Sang wrote:
>
>> Even there are some SDHCI hardwares cannot be stable in microseconds, I
>> think this is also OK since they just need to wait for a few more loops. The
>> total waiting time is the same as before.
>
>Well, I still think this is curing the symptoms not the cause. But will talk
>with Chris about it since we are both in Prague at the moment...
Hi Wolfram & Chris,

   This issue was found by using ftrace to track the irqsoff latency. Each time
   to call mmc_power_off, the latency is about 1ms on my platform. And this 1ms
   delay is causing by the mdelay(1) in _set_ios.

   You know, after changing some register like CLOCK_CONTROL or RESET, driver
   will start to check them every 1ms since we are using mdelay(1). For some
   devices, it needn't software to wait for 1ms, but only some milliseconds. So
   I think change to use udelay() is much better for those devices.

   How do you think? Can you give some of your advice? Thank you.

   Best Regards
   Shawn
