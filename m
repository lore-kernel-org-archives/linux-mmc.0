From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] MMC: OMAP HS-MMC: convert to dev_pm_ops
Date: Tue, 18 May 2010 09:34:47 -0700
Message-ID: <87ocgdqic8.fsf@deeprootsystems.com>
References: <1273615036-4516-1-git-send-email-khilman@deeprootsystems.com>
	<87k4r74p01.fsf@linux-g6p1.site> <87ljbmmnp2.fsf@deeprootsystems.com>
	<20100514225720.GA13046@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100514225720.GA13046@console-pimps.org> (Matt Fleming's message of "Fri\, 14 May 2010 23\:57\:20 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Matt Fleming <matt@console-pimps.org> writes:

> On Fri, May 14, 2010 at 09:51:21AM -0700, Kevin Hilman wrote:
>> 
>> I don't see a reason either, but it requires patching the MMC core as
>> well as all the users.  As I'm not an MMC core person, I thought this
>> best left to someone in that domain.
>> 
>> Fixing the core and callers could easily be done on top of this patch.
>
> I've sent a patch that fixes up all the callers now and Andrew has taken
> it into -mm.

Very nice,  Thanks.

Kevin
