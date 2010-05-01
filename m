From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
	breaks my SD card reader [197b:2381]
Date: Sun, 2 May 2010 01:04:43 +0200
Message-ID: <20100501230443.GB8074@gargoyle.fritz.box>
References: <bug-15836-27@https.bugzilla.kernel.org/> <201004262048.o3QKml95025961@demeter.kernel.org> <20100426135800.28378e99.akpm@linux-foundation.org> <20100430170614.GA22807@gargoyle.fritz.box> <1272739661.10538.30.camel@weslok.olx.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:37177 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab0EAXCK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 May 2010 19:02:10 -0400
Content-Disposition: inline
In-Reply-To: <1272739661.10538.30.camel@weslok.olx.intra>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephan =?iso-8859-1?Q?S=FCrken?= <absurd@olurdix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org

> I explicitly confirmed this on top of 2.6.33.2:

Thanks that makes a bit more sense.

> 
> config-2.6.33.2.git19f00f0-config-2.6.33-2-amd64.nohiber:CONFIG_MEMORY_HOTPLUG=y
> =>"bad"
> config-2.6.33.2.git19f00f0-config-2.6.33-2-amd64.nohotplug:# CONFIG_MEMORY_HOTPLUG is not set
> =>"good"
> 
> So any code enabled by CONFIG_MEMORY_HOTPLUG is the winner, presumable
> somewhere in the mmc code (?).

I doubt the mmc code really knows anything about memory hotplug.
Must be some subtle side effect.

Can send the diff of two boot logs with memory hotplug on and off?
I wonder if you have the same memory layout in both cases.

-Andi
