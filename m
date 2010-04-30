From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
	breaks my SD card reader [197b:2381]
Date: Fri, 30 Apr 2010 19:06:14 +0200
Message-ID: <20100430170614.GA22807@gargoyle.fritz.box>
References: <bug-15836-27@https.bugzilla.kernel.org/> <201004262048.o3QKml95025961@demeter.kernel.org> <20100426135800.28378e99.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:42139 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932592Ab0D3RDp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 13:03:45 -0400
Content-Disposition: inline
In-Reply-To: <20100426135800.28378e99.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, Stephan =?iso-8859-1?Q?S=FCrken?= <absurd@olurdix.de>

> Can anyone suggest how 6ad696d2cf535772dff659298ec7e7260e344595 ("mm:
> allow memory hotplug and hibernation in the same kernel") could have
> caused the mmc failures which Stephan is reporting in the above
> bugzilla record?

The mission information is which CONFIG_* option changes the behaviour.
(or maybe it's in the bugzilla, i just skimmed it very quickly)

presumably it's either hibernation or memory hotadd that introduces
the problem.

My patch just allowed to have both together.

Once it's determined which one it is one could do a second bisect
with that option always on (and the other off)? Or maybe it's not a 
regression.

-Andi
