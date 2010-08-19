From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: 'error: 'SDHCI_QUIRK_NO_HISPD_BIT' undeclared' and 'undefined
 reference to `sdhci_card_detect''
Date: Thu, 19 Aug 2010 10:59:49 +0900
Message-ID: <AANLkTi=Ece8jFtHW3rtiQ6cenqxgtQfVOWA+9uFCYe6A@mail.gmail.com>
References: <008d01cb3ab9$ae73da60$0b5b8f20$%kim@samsung.com>
	<000901cb3abf$5ef59b30$1ce0d190$%szyprowski@samsung.com>
	<20100818113314.20c174f1.akpm@linux-foundation.org>
	<AANLkTikkUcyGv25FM2Nns29VxikJXk3pLVsjM5xdNwZi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35144 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0HSB7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2010 21:59:52 -0400
In-Reply-To: <AANLkTikkUcyGv25FM2Nns29VxikJXk3pLVsjM5xdNwZi@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org

On Thu, Aug 19, 2010 at 10:10 AM, Kyungmin Park <kmpark@infradead.org> =
wrote:
> On Thu, Aug 19, 2010 at 3:33 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Fri, 13 Aug 2010 10:13:04 +0200
>> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>>> Hello,
>>>
>>> On Friday, August 13, 2010 9:32 AM Kukjin Kim wrote:
>>>
>>> > This is just information about Samsung sdmmc stuff building error=
 now.
>>> >
>>> > I found Marek's 'sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk=
' in the
>>> > Linus' tree.
>>> > (commit ID: a1d5646005af1247d6ae78434bb4db15b07a07b2)
>>> >
>>> > But not defined the quirk yet...so following build error happened=
 with
>>> > s3c6400_defconfig in Linus' latest.
>>> >
>>> > drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
>>> > drivers/mmc/host/sdhci-s3c.c:400: error: 'SDHCI_QUIRK_NO_HISPD_BI=
T'
>>> > undeclared (first use in this function)
>>> > drivers/mmc/host/sdhci-s3c.c:400: error: (Each undeclared identif=
ier is
>>> > reported only once
>>> > drivers/mmc/host/sdhci-s3c.c:400: error: for each function it app=
ears in.)
>>> > make[4]: *** [drivers/mmc/host/sdhci-s3c.o] Error 1
>>> > make[3]: *** [drivers/mmc/host] Error 2
>>> > make[2]: *** [drivers/mmc] Error 2
>>> > make[1]: *** [drivers] Error 2
>>> >
>>> > Kyungmin Park's below patch can solve this and it is in mmotm now=
=2E
>>> > (commit ID: 2935b9e7fcc4bea3751b8d039b383b2036a7d36d)
>>> >
>>> > But I think, to update quirk definition should being in Marek's p=
atch for
>>> > avoiding build error.
>>> > Of course, I'm not sure whether the commit order changed.
>>> > Anyway, in this case, will be solved after merging mm tree.
>>> >
>>> >
>>> > And second case is same.
>>> >
>>> > Marek's 'sdhci-s3c: add support for new card detection methods' c=
ause
>>> > following build error.
>>> > (commit ID:17866e14f3a4f219e94f1374ece7226479418ff8)
>>> >
>>> > drivers/built-in.o: In function `sdhci_s3c_notify_change':
>>> > /home/kgene/linux/linux-2.6-mainline-dev/drivers/mmc/host/sdhci-s=
3c.c:255:
>>> > undefined reference to `sdhci_card_detect'
>>> > make[1]: *** [.tmp_vmlinux1] Error 1
>>> > make: *** [sub-make] Error 2

and this issue is another. check the this.
http://marc.info/?l=3Dlinux-mmc&m=3D128201811218629&w=3D3

>>> >
>>> > And Andrew's patch(b567e5dd5a34c184e5642100e752cb87e064bb97) can =
solve this.
>>> > (of course this needs another patches...)
>>> >
>>> > Anyway...
>>> > Marek, in future please make sure your patch has no building prob=
lem before
>>> > submitting.
>>> > (or it can help to add some kind of dependency note in your patch=
)
>>>
>>> My patches submited to Andrew Morton had the description and a note=
 that they
>>> have been prepared especially for his tree, taking into account all=
 patches
>>> that are already there (mainly a tasklets to threaded irq conversio=
n). For me
>>> it was quite obvious that they will be merged after all other sdhci=
 changes
>>> from that tree. I have no idea why the order of the patches has bee=
n reversed
>>> and my sdhci patches has been submitted to Linus before the other s=
dhci
>>> changes.
>>
>> We're talking about these:
>>
>> s5pc110-sdhci-s3c-can-override-host-capabilities.patch
>> s5pc110-sdhci-s3c-support-on-s5pc110.patch
>> sdhci-add-no-hi-speed-bit-quirk-support.patch
>>
>> I have a note that these await an ack from Ben Dooks so I held them
>> back for a closer look after -rc1. =A0I was unaware of this dependen=
cy.
>>
>> Ben, are you OK with those patches?
>
> These are required for support s5pc110 & s5pc210.
>
> Current sdhci on s5p has some wrong assumption. only support 4-bit
> bandwidth. and don't consider the embedded mmc like eMMC.
>
>>
>> http://userweb.kernel.org/~akpm/mmotm/broken-out/s5pc110-sdhci-s3c-c=
an-override-host-capabilities.patch
> It required for override the host caps and pass to the mmc with corre=
ct caps
>> http://userweb.kernel.org/~akpm/mmotm/broken-out/s5pc110-sdhci-s3c-s=
upport-on-s5pc110.patch
> required for support s5pc110 and also s5pc210
>> http://userweb.kernel.org/~akpm/mmotm/broken-out/sdhci-add-no-hi-spe=
ed-bit-quirk-support.patch
> As SDHCI on s5p don't has HISPD bit in controller register. need to q=
uirks.
>>
>> Thanks.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sams=
ung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
