From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Thu, 9 Oct 2014 10:46:59 +0200
Message-ID: <CAPDyKFoPBep287uAVDQWSXdFz-aoV4VmV7xgP_PEZ-c1q9Oz0w@mail.gmail.com>
References: <2750153.I3nVqzmXTP@amdc1032>
	<1998495.eXa2FjeVGo@wuerfel>
	<CAD=FV=VB_eK9pSmmTBRHoQmkORweHzT-OFaMWA6haFYnQuQaUQ@mail.gmail.com>
	<1819182.VPTrtc9d2P@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:59006 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaJIIrA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Oct 2014 04:47:00 -0400
Received: by mail-qg0-f45.google.com with SMTP id q107so1021233qgd.18
        for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2014 01:47:00 -0700 (PDT)
In-Reply-To: <1819182.VPTrtc9d2P@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Doug Anderson <dianders@google.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>

On 8 October 2014 20:28, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 October 2014 08:29:16 Doug Anderson wrote:
>>
>> On Wed, Oct 8, 2014 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Why does it cause a regression though? Does this mean you are breaking
>> > any boot with an old DT file and a new kernel? That would be very
>> > bad, the driver is supposed to keep working with an existing dtb.
>>
>> The old dts file specified completely the wrong regulator.  It
>> happened that the old code didn't really care, but when the code was
>> fixed to care then things broke.  If we need to keep old dts files
>> working then the most sensible place to do it would be in a "fixup old
>> broken device trees" stage somewhere in kernel boot.
>
> Ok, got it. I guess it's better to apply this one first then.
>
>         Arnd

Thanks for your comments Arnd! I have applied this once to my mmc tree
now. Please tell me soon if you want to carry this through arm-soc
instead, thus I can drop it.

Kind regards
Uffe
