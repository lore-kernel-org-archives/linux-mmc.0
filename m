From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
Date: Tue, 6 Oct 2015 17:35:18 +0200
Message-ID: <CAPv3WKebE9SHd25mDbn+y4f0awseo_KXA9-aFgUNHTty4KxGFQ@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-7-git-send-email-mw@semihalf.com>
	<20151006033131.GA24230@lunn.ch>
	<CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
	<8737xo9gvx.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8737xo9gvx.fsf@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>
List-Id: linux-mmc@vger.kernel.org

Gregory,

2015-10-06 17:05 GMT+02:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi,
>
>  On mar., oct. 06 2015, Marcin Wojtas <mw@semihalf.com> wrote:
>
>> Hi Andrew,
>>
>> 2015-10-06 5:31 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>>> On Tue, Oct 06, 2015 at 03:22:40AM +0200, Marcin Wojtas wrote:
>>>> The newest revisions of A388-GP (v1.5 and higher) support only
>>>> DAT3-based card detection, which is enabled by this commit. Hitherto
>>>> revisions, without such modification, will be impacted with a broken
>>>> card detection - in order to operate the cards have to be present
>>>> during kernel boot.
>>>
>>> Humm. Is this acceptable, breaking old boards?
>>>
>>> I would say at minimum, there should be a big fat comment at the top
>>> of armada-388-gp.dts explaining that this DTS file is broken on
>>> v0.0-v1.4.
>>>
>>> Or we have two .dts files for the 388-gp file, and a dtsi file.
>>>
>>
>> I expected this patch would be controversial, hence I propose a
>> compromise: set A388-GP SDHCI to 'broken-cd' by defeault. However
>> Marvell insisted on HW card detection, because software polling spoils
>> the SD/MMC benchmarks, but this way the user would decide whether to
>> stay with broken-cd or switch to GPIO/DAT3 detection. What do you
>> think?
>
> I don't know hwo to correctly handle this case.
>
> From my point of view in a ideal work it is typically something that
> sould be updated by the bootloader. However in the real world, we can't
> rely on the bootloader :(
>
> I also don't like having a dts for each new version of the board but as
> the end you can see them as different boards. Also now it seems that the
> distribution are moving to link the dtb and the kernel: for eaxh new
> version of the kernel they also provide a new version of the dtb. That
> means, that if we modify the dts, then the old board won't work with the
> new kernel. So maybe creating a armada-388-gp-v1.5.dts could be the best
> option.
>
> What do you think of it?
>

My first feeling is that creating brand new dts just for sdhci
detection (afaik there are no other bigger modifications of the PCB)
is not the best idea. However maybe changing armada-388-gp.dts to dtsi
and then add two single-entries' dts files on top is an option? Of
course we can satisfy each type of boards with 'broken-cd' polling
detection. I think it's rather a question of a taste and maintanance
point of view.

Best regards,
Marcin
