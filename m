From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Thu, 21 Apr 2011 11:47:19 +0200
Message-ID: <BANLkTim_5fsJ06CTgxAvPjrb8y5FpW=xRg@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<20110417164830.GE17935@S2100-06.ap.freescale.net>
	<BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
	<20110420140120.GF1965@S2100-06.ap.freescale.net>
	<BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
	<20110421062924.GB4024@S2100-06.ap.freescale.net>
	<BANLkTimq8_R-CJmryTvRWHZ+-2vqj-Y6cQ@mail.gmail.com>
	<20110421091115.GH4024@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57303 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab1DUJrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 05:47:20 -0400
Received: by qwk3 with SMTP id 3so764597qwk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 02:47:19 -0700 (PDT)
In-Reply-To: <20110421091115.GH4024@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-kernel@lists.linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 21 April 2011 11:11, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Apr 21, 2011 at 10:46:18AM +0200, Per Forlin wrote:
>> On 21 April 2011 08:29, Shawn Guo <shawn.guo@freescale.com> wrote:
>> > On Wed, Apr 20, 2011 at 05:30:22PM +0200, Per Forlin wrote:
>> > [...]
>> >> Remove dma_map and dma_unmap from your host driver and run the te=
sts
>> >> (obviously nonblocking and blocking will have the same results). =
If
>> >> there is still no performance gain the cache penalty is very smal=
l on
>> >> your platform and therefore nonblocking doesn't improve things mu=
ch.
>> >> Please let me know the result.
>> >>
>> > Sorry, I could not understand. =A0What's the point to run the test=
 when
>> > the driver is even broken. =A0The removal of =A0dma_map_sg and
>> > dma_unmap_sg makes mxs-mmc host driver broken.
>> The point is only to get a measurement of the cost of handling
>> dma_map_sg and dma_unmap_sg, this is the maximum time mmc nonblockin=
g
>> can save.
>> The nonblocking mmc_test should save the total time of dma_map_sg an=
d
>> dma_unmap_sg, if the pre_req and post_req hooks are implemented
>> correctly.
>> Running without dma_map_sg and dma_unmap_sg will confirm if the
>> pre_req and post_req hooks are implemented correctly.
>>
> With dma_map_sg and dma_unmap_sg removed, the mmc_test gave very low
> numbers, though blocking and non-blocking numbers are same. =A0Is it
> an indication that pre_req and post_req hooks are not implemented
> correctly?
I think you could get the same numbers for the nonblocking with
dma_map and dma_unmap in place.

> =A0If yes, can you please help to catch the mistakes?
I will take a look.

> --
> Regards,
> Shawn
>
>
Regards,
Per
