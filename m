From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: print debug messages for runtime PM actions
Date: Wed, 20 Jul 2011 12:44:13 -0400
Message-ID: <m262mw9a1u.fsf@bob.laptop.org>
References: <20110717153841.D4BF29D401C@zog.reactivated.net>
	<m2pql79f1s.fsf@bob.laptop.org>
	<CAGq3pz7ni49sKW2sLabAi7rof=cETEuviuQcpZPcmJOzOzmsog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51170 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab1GTQoS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jul 2011 12:44:18 -0400
In-Reply-To: <CAGq3pz7ni49sKW2sLabAi7rof=cETEuviuQcpZPcmJOzOzmsog@mail.gmail.com>
	(Daniel Drake's message of "Wed, 20 Jul 2011 17:36:46 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Jul 20 2011, Daniel Drake wrote:
>>     pr_debug("%s: %s: powering down\n", mmc_hostname(host), __func__);
>>
>> which gets you the same CONFIG_MMC_DEBUG semantics? (The messages will
>> be at the debug loglevel rather than info, but that sounds right to me.)
>
> I did, and that would probably be fine (assuming that CONFIG_MMC_DEBUG
> would actually turn it on? I can't see where that would happen)

It's in drivers/mmc/Makefile:
subdir-ccflags-$(CONFIG_MMC_DEBUG) := -DDEBUG

include/linux/printk.h:
#if defined(DEBUG)
#define pr_debug(fmt, ...) \
        printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
        
> was trying to make it a bit more prominent and appear the same as the
> debug message from mmc_rescan_try_freq() which does it in this way.

Ah, okay, seems reasonable -- I'll merge the original patch for 3.1.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
