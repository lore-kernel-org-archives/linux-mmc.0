From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: add workaround for T4240
 incorrect HOSTVER value
Date: Tue, 25 Aug 2015 14:04:17 +0200
Message-ID: <CAPDyKFoBch9zSq_CwuZnXH9Lo9+AcAbkXqAQevpJuBCErOK1Wg@mail.gmail.com>
References: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
	<1437791242.2993.268.camel@freescale.com>
	<CAPDyKFp8ZStYVaFm8tjPL190dqV6vCE+oT706M=6wVCckWesLw@mail.gmail.com>
	<1438012638.2993.289.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34931 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbbHYMES (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:04:18 -0400
Received: by igbjg10 with SMTP id jg10so10196614igb.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:04:17 -0700 (PDT)
In-Reply-To: <1438012638.2993.289.camel@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 27 July 2015 at 17:57, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, 2015-07-27 at 09:58 +0200, Ulf Hansson wrote:
>> On 25 July 2015 at 04:27, Scott Wood <scottwood@freescale.com> wrote:
>> > On Tue, 2015-07-21 at 15:02 +0200, Ulf Hansson wrote:
>> > > On 21 July 2015 at 11:45, Yangbo Lu <yangbo.lu@freescale.com> wrote:
>> > > > For T4240-R1.0-R2.0, the HOSTVER register has incorrcet vender
>> > > > version value and sdhc spec version value. This will break down
>> > > > the ADMA data transfer. So add workaround to get right value
>> > > > VVN=0x13, SVN = 0x1.
>> > >
>> > > So T4240-R1.0-R2.0 is the version of the controller, right?
>> > >
>> > > If I understand correct you are checking what CPU/SoC you are running
>> > > on, to figure out which controller version you are using, as that
>> > > can't be fetched (trusted) from the registers of the esdhc controller
>> > > itself!?
>> > >
>> > > Instead, you could deal with this directly in the DTS files. I assume
>> > > you have some DTS file for each SoC/board variant, right?
>> >
>> > No, we do not have a separate DTS file for each revision of an SoC -- and
>> > if
>> > we did, we'd constantly have people using the wrong one.
>> >
>> > > In principle, in your DTS file specific for the board/SoC that holds
>> > > the T4240-R1.0-R2.0 version of the controller, should add a specific
>> > > esdhc DT property to indicate this errata.
>> >
>> > No, because (in addition to the above issue about chip revisions) the
>> > device
>> > tree is stable ABI and errata are often discovered after device trees are
>> > deployed.
>>
>> Fair enough. Then what is your suggestion for the solution here?
>
> As I said in my comment on patch 2/3, read SVR from the device-config/guts
> MMIO block, which works on both PPC and ARM.
>

That's okay, as long as don't have include sections of non generic
header files in the driver.

To be more clear, this is not okay to have:
#include <mach/*>

Kind regards
Uffe
