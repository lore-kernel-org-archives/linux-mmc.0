From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 14983] New: SD card reader stopped working
 completely
Date: Fri, 8 Jan 2010 15:05:25 -0800
Message-ID: <20100108150525.331a6f5d.akpm@linux-foundation.org>
References: <bug-14983-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48788 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751396Ab0AHXFk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2010 18:05:40 -0500
In-Reply-To: <bug-14983-10286@http.bugzilla.kernel.org/>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, peter.kraus@geeksonbikes.net


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 4 Jan 2010 10:22:53 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=14983
> 
>            Summary: SD card reader stopped working completely
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.30 trough 2.6.32
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: MMC/SD
>         AssignedTo: drivers_mmc-sd@kernel-bugs.osdl.org
>         ReportedBy: peter.kraus@geeksonbikes.net
>                 CC: peter.kraus@geeksonbikes.net
>         Regression: Yes
> 
> 
> Created an attachment (id=24428)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=24428)
> working 2.6.29 kernel config
> 
> Hello.
> My Ricoh card reader, which used to work absolutely fine, stopped working in
> newer kernels.
> 
> - it works with kernel 2.6.29
> 

This is a regression.  There's additional info at the bugzilla link.

Could someone please work with Peter on this?

Thanks.
