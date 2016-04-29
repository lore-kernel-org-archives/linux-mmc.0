From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 15:22:50 -0700
Message-ID: <CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
References: <20160429181248.GW19428@n2100.arm.linux.org.uk>
	<CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
	<20160429195741.GY19428@n2100.arm.linux.org.uk>
	<CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
	<20160429211328.GZ19428@n2100.arm.linux.org.uk>
	<CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
	<20160429212920.GA19428@n2100.arm.linux.org.uk>
	<CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
	<20160429215017.GC19428@n2100.arm.linux.org.uk>
	<CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
	<20160429221606.GE19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33795 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcD2WWv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 18:22:51 -0400
Received: by mail-yw0-f177.google.com with SMTP id j74so185366678ywg.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 15:22:51 -0700 (PDT)
In-Reply-To: <20160429221606.GE19428@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Agner <stefan@agner.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jisheng Zhang <jszhang@marvell.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, devicetree-spec@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Lars-Peter Clausen <lars@metafoo.de>, Jon Hunter <jonathanh@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>Pawel Moll <p>

Hi,

On Fri, Apr 29, 2016 at 3:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 29, 2016 at 02:56:38PM -0700, Doug Anderson wrote:
>> Russell,
>>
>> On Fri, Apr 29, 2016 at 2:50 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Apr 29, 2016 at 02:39:35PM -0700, Doug Anderson wrote:
>> > [didn't read most of your reply]
>> >
>> >> Really I just reposted it several times because I notice that you seem
>> >> to ignore many points of my emails.  I was really hoping to get you to
>> >> address this point.  I notice that you still didn't.  Either you are
>> >> just trying to annoy me, or you don't have an answer to how my patch
>> >> series hurts you.
>> >
>> > I don't see you treating Rob with the same contempt that you have
>> > treated me in this thread, despite Rob and myself both telling you
>> > basically the same thing.
>>
>> Rob wrote a nice thoughtful reply and I tried to give a nice
>> thoughtful reply back to him.  He raised some good points and I raised
>> some good points back to him.  I look forward to his future thoughts
>> on the topic.
>
> Meanwhile, I've pointed out that you appear to be coming from a
> misunderstanding (that's certainly clear because you believed
> initially that grub did something it doesn't), showing that the
> "problem" you have is no different from the majority of other
> systems running Linux, and you treat me with contempt.
>
> What are you going to do to resolve this?

As I tried to indicate in earlier emails, I don't actually care how
grub works in this case.  It was originally meant to illustrate the
other people's workflows and mine are not the same.  If they have a
solution that works for them, that's great.

I want my MMC and MMCBLK device numbers to be sane and consistent to
help me parse through dmesg and sysfs.  If it happens to also make it
easy / possible to specify a root filesystem using "mmcblkN" that's
great and I'll probably take advantage of that.

I'm very sorry if those using SATA and ATA disks don't have a way to
get sane and consistent device number ordering.  I really am.  ...but
just because they don't have a well defined ordering doesn't mean
those of us using MMC should have to suffer.  ...and I don't think
giving a sane ordering to MMC devices hurts anyone, does it?

-Doug
