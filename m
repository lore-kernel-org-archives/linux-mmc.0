From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 19:29:22 -0700
Message-ID: <CAD=FV=UuGdbagFgK-EpF_0RKw35pdcm-92qDgRf_Csrwj6seLA@mail.gmail.com>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
	<CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
	<20160429211328.GZ19428@n2100.arm.linux.org.uk>
	<CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
	<20160429212920.GA19428@n2100.arm.linux.org.uk>
	<CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
	<20160429215017.GC19428@n2100.arm.linux.org.uk>
	<CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
	<20160429221606.GE19428@n2100.arm.linux.org.uk>
	<CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
	<20160429224407.GF19428@n2100.arm.linux.org.uk>
	<CAD=FV=U5jnJJ3v=nFGFecoKB5KGv1ufC+aKbHx2iCqBTWpDTww@mail.gmail.com>
	<5723F514.4@hurleysoftware.com>
	<CAD=FV=V_YyfBOSs7BLkyhv=_5HBmf3djUWACbL6d-bwnrueDjA@mail.gmail.com>
	<5723FCE3.9070308@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5723FCE3.9070308@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kern
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 29, 2016 at 5:31 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 04/29/2016 05:03 PM, Doug Anderson wrote:
>> Hi,
>>
>> On Fri, Apr 29, 2016 at 4:58 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>>     On 04/29/2016 04:01 PM, Doug Anderson wrote:
>>     > * serial allows numbering devices by alias.
>>
>>     Which is in fact a total nightmare.
>>
>>     While stable device order is mandatory in serial because of
>>     console command line parameters and existing userspace expectations,
>>     it is the number one barrier to providing a shared ttyS namespace
>>     for mixed uart platforms.
>>
>>     Stable device order has a very real (and often unforeseen) maintenance
>>     burden.
>>
>>
>> Interesting. I wonder if these burdens are unique to serial or shared
>> by all the other subsystems that allow ordering? Maybe this is all
>> because of legacy reasons?
>
> Well, the specific issue is certainly unique to serial.
> But what I was suggesting is that 5 years from now, these patches
> could be the "legacy reasons" in mmc.
>
> FWIW, there is already a defacto expectation by boot configurations in the
> field that a given mmc block device is stable across boots. The reality
> is that 100000's of kernel command lines look like:
>
>         root=/dev/mmcblk0p2
>
> This was a recent regression fixed by Ulf in commit 9aaf3437aa72
> ("mmc: block: Use the mmc host device index as the mmcblk device index")

Ah.  Well, in this case it sounds like we've already got an
expectation of stable numbering from boot to boot.  I had missed Ulf's
patch, so I guess part 3 of my series isn't actually needed and can be
dropped.

So it's just a question of whether we allow people to manually specify
via device tree.


Note: if we really think using root=/dev/mmcblkNpM is a bad idea then
we should deprecate it and yell about it in the boot log.  Then 5 (or
20) years down the road we could remove the feature when the legacy
burden become a pain.  Note that even if we deprecated
root=/dev/mmcblkNpM I'd still love to see the numbering be consistent
to help folks parse dmesg.


Thanks for your thoughts!


-Doug
