From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 00/16] omap_hsmmc patches
Date: Wed, 13 Jul 2011 11:36:26 -0400
Message-ID: <m2k4bm2nwl.fsf@bob.laptop.org>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41876 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab1GMPgi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Jul 2011 11:36:38 -0400
In-Reply-To: <CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 13 Jul 2011 13:48:08 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

Hi,

On Wed, Jul 13 2011, Grazvydas Ignotas wrote:
> it seems this series got lost in time, at least patches 01, 02, 03,
> 04, 05, 06, 07, 08, 12 look like valid standalone fixes and
> improvements to me, they don't touch other trees and still apply
> cleanly, so would be good to have.

Yeah.  I didn't merge them because Tony still has unanswered comments on
the OMAP side of the patches, and they're submitted as a single patchset.

I've applied {2, 3, 5, 6, 7, 8, 12} to mmc-next for 3.1 now.  1 doesn't
apply because the function doesn't exist anymore.  4 doesn't apply
because iclk doesn't exist anymore.

If someone wants to look at rebasing the rest of these against mmc-next
and resubmitting, I think that'd be useful.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
