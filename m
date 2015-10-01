From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: All OMAP platforms: MMC is broken
Date: Thu, 1 Oct 2015 11:50:00 +0200
Message-ID: <CAPDyKFpnqJBrtiBekikrNHAf-agZm12KnF9n+=+72HH=jti-KA@mail.gmail.com>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
	<20150924233756.GN23801@atomide.com>
	<20151001093325.GU21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35697 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbJAJuC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2015 05:50:02 -0400
Received: by wicge5 with SMTP id ge5so21211422wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Oct 2015 02:50:00 -0700 (PDT)
In-Reply-To: <20151001093325.GU21513@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "arm@kernel.org" <arm@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1 October 2015 at 11:33, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 24, 2015 at 04:37:56PM -0700, Tony Lindgren wrote:
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150924 02:04]:
>> > Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
>> > SDP fail to boot due to lack of working MMC.  Both platforms fail to
>> > find their rootfs, which is on a SD card.
>> >
>> > The breakage occurred somewhere between trees of September 9th (commit
>> > 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
>> > merge window.
>>
>> Yes sorry things got messed up in multiple ways :( I've summarized
>> the mess here earlier:
>>
>> http://article.gmane.org/gmane.linux.kernel.mmc/33911
>>
>> And today commit b9c93646fd5c ("regulator: pbias: program pbias register
>> offset in pbias driver") hit mainline so I'll send a pull request for
>> the related dts change.
>
> It's still broken and untestable.  We're 8 days off it being a full
> month worth of failed testing for OMAP3 and OMAP4 platforms.
>
> I think OMAP and MMC people need to do a post-mortem and work out why
> this happened, and how to stop it happening again in the future.

You are probably right!

I think I should have been more persistent when asking on how to deal
with these patches. Typically they should all have gone together via
one tree, or we needed a slower way forward keeping changes more
standalone.

Anyway, according to kernelci.org, which builds and boot my next
branch omap3/4 seems to boot now...
http://kernelci.org/boot/all/job/ulfh/kernel/v4.3-rc3-27-gf7734d097520/

Kind regards
Uffe
