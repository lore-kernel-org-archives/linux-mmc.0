From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
 breaks my SD card reader [197b:2381]
Date: Mon, 26 Apr 2010 13:58:00 -0700
Message-ID: <20100426135800.28378e99.akpm@linux-foundation.org>
References: <bug-15836-27@https.bugzilla.kernel.org/>
	<201004262048.o3QKml95025961@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35066 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751128Ab0DZU6z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 16:58:55 -0400
In-Reply-To: <201004262048.o3QKml95025961@demeter.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, Stephan =?ISO-8859-1?Q?S=FCrken?= <absurd@olurdix.de>, Andi Kleen <andi@firstfloor.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 26 Apr 2010 20:48:47 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=15836
> 

OK, I give up.

Can anyone suggest how 6ad696d2cf535772dff659298ec7e7260e344595 ("mm:
allow memory hotplug and hibernation in the same kernel") could have
caused the mmc failures which Stephan is reporting in the above
bugzilla record?

Thanks.
