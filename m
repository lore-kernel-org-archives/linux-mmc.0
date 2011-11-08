From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 5/6] mmc: Add OF bindings support for mmc host controller capabilities
Date: Tue, 8 Nov 2011 20:49:14 +0530
Message-ID: <CAJuYYwRPoNQ3WAGHf_F8wLckyiuCqGDuE_TvHtiTMvH5O5m41A@mail.gmail.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
	<1320266163-15292-6-git-send-email-thomas.abraham@linaro.org>
	<20111104195717.GA3045@quad.lixom.net>
	<CAJuYYwThsY0gwG4D3bNC-VnifggT6Y4f0s3FVHebAXdubTb4Zg@mail.gmail.com>
	<20111107211518.GB28491@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52856 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1KHPTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2011 10:19:16 -0500
In-Reply-To: <20111107211518.GB28491@ponder.secretlab.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

Hi Grant,

On 8 November 2011 02:45, Grant Likely <grant.likely@secretlab.ca> wrot=
e:
> On Mon, Nov 07, 2011 at 07:51:26PM +0530, Thomas Abraham wrote:
>> On 5 November 2011 01:27, Olof Johansson <olof@lixom.net> wrote:
>> > On Thu, Nov 03, 2011 at 02:06:02AM +0530, Thomas Abraham wrote:
>> >> Device nodes representing sd/mmc controllers in a device tree wou=
ld include
>> >> mmc host controller capabilities. Add support for parsing of mmc =
host
>> >> controller capabilities included in device nodes.
>> >>
>> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> >> ---
>> >> =A0.../devicetree/bindings/mmc/linux-mmc-host.txt =A0 =A0 | =A0 1=
3 ++++++++
>> >> =A0drivers/mmc/core/host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 31 ++++++++++++++++++++
>> >> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A01 +
>> >> =A03 files changed, 45 insertions(+), 0 deletions(-)
>> >> =A0create mode 100644 Documentation/devicetree/bindings/mmc/linux=
-mmc-host.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host=
=2Etxt b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
>> >> new file mode 100644
>> >> index 0000000..714b2b1
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
>> >> @@ -0,0 +1,13 @@
>> >> +* Linux MMC Host Controller Capabilities
>> >> +
>> >> +The following bindings can be used in a device node to specify a=
ny board
>> >> +specific mmc host controller capabilities.
>> >> +
>> >> +- linux,mmc_cap_4_bit_data - Host can do 4-bit transfers
>> >> +- linux,mmc_cap_mmc_highspeed - Host can do MMC high-speed timin=
g
>> >> +- linux,mmc_cap_sd_highspeed - Host can do SD high-speed timing
>> >> +- linux,mmc_cap_needs_poll - Host needs polling for card detecti=
on
>> >> +- linux,mmc_cap_8_bit_data - Host can do 8-bit transfer
>> >> +- linux,mmc_cap_disable - Host can be disabled and re-enabled to=
 save power
>> >> +- linux,mmc_cap_nonremovable - Host is connected to nonremovable=
 media
>> >> +- linux,mmc_cap_erase - Host allows erase/trim commands
>> >
>> > linux-prefixed properties are a big red flag. The device tree shou=
ld describe
>> > the hardware, not what linux does with the hardware.
>>
>> The vendor-prefixes documentation for device tree bindings includes
>> 'linux' as an option. And I was trying to encode the linux specific
>> host controller capabilities using the above bindings.
>>
>> >
>> > See previous comments about "support-8bit" for encoding exactly th=
e same
>> > hardware capability in a linux-agnostic way. What the sdhci driver=
 chooses to
>> > do with it is up to the driver, and in some cases it means it will=
 set the
>> > capabilities flag.
>> >
>> > Same goes for the other properties. It should not go in as it is
>> > implemented in this patch, it needs to be fixed up.
>>
>> Ok. I will remove all these linux specific bindings and replace with=
 a
>> more generic ones. Bindings will be defined for all the linux define=
d
>> host capabilities. Non-linux platforms can add additional bindings a=
s
>> required. A function to parse such properties from a controller devi=
ce
>> node could actually be shared among all the mmc/sd host controller
>> drivers in linux. I will redo this patch and submit again.
>>
>> Thanks Olof for your review and comments.
>
> This patch appears to be conceptually wrong. =A0Many of these propert=
ies
> are merely static capabilities of each individual device which the
> driver should already have knowledge of, and be setting the capabilit=
y
> bits appropriately on its own.
>
> So, you /don't/ want to simply create a 1:1 list between the current
> linux capability bits (which are subject to change) and the device
> tree properties (which ideally must not be changed after they are
> defined).

okay.

>
> What you need to do is figure out which properties are required to
> describe the hardware about things that the driver wouldn't already
> know. =A0For example, 'polling' is something the driver would already
> know because it is an aspect of the specific device, but
> 'nonremovable' is a physical characteristic of some boards. =A0'disab=
le'
> and the speed timings are also something I would expect the driver to
> know about and what to set itself.

The host capability 'polling' seems to be more of board dependent
property than controller property. This property changes the way the
host stack detects the presence of the card. Some boards might have
broken card detection logic. So 'polling' cannot be generalized as a
controller property. Each host controller instance in a SoC would have
to be told if its card detection is broken. This is done currently
using the platform data.

Similarly, the host property 'disable' depends on the board. The
controller would be capable of handling the 'disable' feature but on
some boards, disabling to save power during idle times might not work
since the device connected to that host might have issues by doing so.
On a SoC with multiple host controllers, some controllers would want
to use 'disable' feature and others might not. So, 'disable' would
have to be board specific.

>
> So, only define properties for things that the device-specific driver
> cannot know for itself; or are the sort of parameters that a
> multi-device driver is already using for differentiation (ie. appears
> in pdata instead of directly set by the driver). =A0You should be abl=
e
> to justify the need for each property that gets defined.

Okay. I agree with your viewpoint. I will try to redo this again.
Unfortunately, host controller drivers have used platform data to feed
host controller capabilities directly from platform code to the mmc
stack. And more and more of such changes are still being made. I will
attempt another version of this patch based on yours, Olof's and Rob's
comments.

Thanks Grant for your comments.

Regards,
Thomas.

>
> g.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
