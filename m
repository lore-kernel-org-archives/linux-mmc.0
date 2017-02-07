From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 2/8] mmc: bcm2835: Add new driver for the sdhost
 controller.
Date: Tue, 7 Feb 2017 09:24:03 +0100
Message-ID: <f495e10a-bb9b-ab23-e3af-47a000b28783@i2se.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
 <1486123913-31705-3-git-send-email-kraxel@redhat.com>
 <1708749883.208474.1486413240581@email.1und1.de>
 <1486454575.24589.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486454575.24589.29.camel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, swarren@wwwdotorg.org, rjui@broadcom.com, lee@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, eric@anholt.net, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Gerd,

Am 07.02.2017 um 09:02 schrieb Gerd Hoffmann:
> On Mo, 2017-02-06 at 21:34 +0100, Stefan Wahren wrote:
>> Hi Gerd,
>>
>> first of all here my wishlist for the next round of this driver:
>> * compile test the series with ARM and ARM64
> It is tested on both arm and arm64 (rpi2 + rpi3).

i got implicite declaration for request_threaded_irq() and free_irq().
After including linux/interrupt.h the issue is fixed (patch #1 of my
series).

>
>> * add me in CC for all patches of the series
> Oops.  /me should be more careful when reading names.  I thought I had
> you on Cc:  Double-checked.  Turned out that was Stephen Warren ...

No problem

>
>> * run checkpatch.pl before submission
> Hmm?  Are there any issues?  /me has a pre-commit hook running
> checkpatch to avoid anything slipping though.

Just a single issue about a unnecessary return at the end of
bcm2835_data_irq() (patch #4 of my series). Maybe this was a new rule.

>
>> * apply the patch series to your cgit repo
> Branch pushed now: bcm2837-sdhost-squashed-v2

Thanks

>
>>> The sdhci controller supports both sdcard and sdio.  The sdhost
>>> controller supports the sdcard only, but has better performance.  Also
>> Sorry, for the confusion. I was wrong. According to the registers the SDHOST should also support SDIO. It's a feature we could implement later.
> Ok.
>
>>> note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
>>> controller allows to use the sdhci controller for wifi support.
>>>
>>> The configuration is done by devicetree via pin muxing.  Both SD
>>> controller are available on the same pins (2 pin groups = pin 22 to 27 +
>>> pin 48 to 53).  So it's possible to use both SD controllers at the same
>>> time with different pin groups.
>>>
>>> The code was originally written by Phil Elwell in the downstream
>>> Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
>>> out of the original 2055) for inclusion.
>> I think it would be helpful to known the downstream commit, because this commit [1]
>> doesn't seem to be included.
>>
>> [1] - https://github.com/raspberrypi/linux/commit/ea4b1c5c2ddbb6caba43ab9b0103542a4ca7e1f0

Sorry wrong link, this must be the right one

https://github.com/raspberrypi/linux/commit/1131510a589ae7262b8861af8d2f4a000710d59c

>>
>> I've found and fixed a lot of issues in this version and i think it would be better if i send you the patches for squashing them all together. Here is the preview for my patch series:
>>
>> Stefan Wahren (15):
>>   mmc: bcm2835: Add missing include for threaded irq
>>   mmc: bcm2835: Remove CMD_DALLY_US
>>   mmc: bcm2835: Fix pio_timeout handling
>>   mmc: bcm2835: Remove unnecessary return in bcm2835_data_irq
>>   mmc: bcm2835: Handle error cases during probe
>>   mmc: bcm2835: Print clk_max as decimal
>>   mmc: bcm2835: Downrate message in case of PIO fallback
>>   mmc: bcm2835: Don't unveil the data pointer
>>   mmc: bcm2835: remove unused host members
>>   mmc: bcm2835: Avoid unnecessary linebreaks
>>   mmc: bcm2835: Add leading zero to register dumps
>>   mmc: bcm2835: Align struct members with tabs
>>   mmc: bcm2835: Rearrange bcm2835_finish_request()
>>   mmc: bcm2835: Rearrange bcm2835_dma_complete_work()
>>   mmc: bcm2835: Rename Kconfig switch
>>
>> I'll send it after my tests. In the following review i will mention only the issues which aren't fixed in my patch series.
> I'll pick up the patches and look at the remaining issues, new version
> later this week (i hope).
>
> thanks,
>   Gerd
