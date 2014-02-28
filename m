From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/4] ARM: dove: prepare new Dove DT Kconfig variable
Date: Fri, 28 Feb 2014 19:12:20 +0100
Message-ID: <5310D184.3050905@gmail.com>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com> <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com> <20140228015310.GC9383@sirena.org.uk> <20140228163448.GM1872@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140228163448.GM1872@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>
Cc: Chris Ball <chris@printf.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Wim Van Sebroeck <wim@iguana.be>, Liam Girdwood <lgirdwood@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 02/28/2014 05:34 PM, Jason Cooper wrote:
> On Fri, Feb 28, 2014 at 10:53:10AM +0900, Mark Brown wrote:
>> On Thu, Feb 27, 2014 at 10:28:03PM +0100, Sebastian Hesselbarth wrote:
>>> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
>>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
>>> DT-only MACH_DOVE to mmc, thermal, wdt, and asoc Kconfigs.
>>
>> I'd be much happier merging this sort of stuff individually through the
>> subsystems, we already have an annoying conflict here...  Is there some
>> bisection problem with doing that?
>
> shouldn't be.  Since these changes || the old with the new config
> symbols.
>
> Sebastian, can you split this up into individual patches?

Sure, I'll send them in-reply-to this mail soon. I'll also add the SATA
PHY Kconfig in a bisectable way, i.e. add MACH_DOVE and for now ignore
that the driver is DT-only. We plan to remove mach-dove in one or two
cycles anyway, it will go with it then.

Sebastian
