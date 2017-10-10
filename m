From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Add support for multiple SD cards on one
 host interface
Date: Tue, 10 Oct 2017 09:59:35 +0200
Message-ID: <CAPDyKFqwajTGCyexd8Bxj-jEtKJCDb3b8q1HqOrYoNAMSdevcg@mail.gmail.com>
References: <AM5PR0701MB2657094CA5D94164E6D63A8DE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAPDyKFr3==eZQOojPac4fse8baHa+UXweOezdb9vFiSB9jae_Q@mail.gmail.com> <ed12bab0-1270-af10-0313-ad9e2f32173e@hotmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:49631 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755650AbdJJH7g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2017 03:59:36 -0400
Received: by mail-it0-f47.google.com with SMTP id y15so1396165ita.4
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2017 00:59:36 -0700 (PDT)
In-Reply-To: <ed12bab0-1270-af10-0313-ad9e2f32173e@hotmail.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 2 October 2017 at 16:31, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
> On 10/02/17 09:12, Ulf Hansson wrote:
>> On 30 September 2017 at 17:39, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>
>>> Needs external logic to multiplex the clock signal,
>>> which is controlled by a GPIO output pin.
>>>
>>> Only the selected SD card receives the clock,
>>> while the other SD card's clock is forced to LOW.
>>> DATA and CMD lines can be connected to both SD cards.
>>>
>>> On warm-start UBOOT should use a sequence of
>>> CMD12 and CMD7 with RCA=0 to force any active SD card
>>> to stop transmission and release the DATA bus.
>>
>> I doubt that is sufficient to support multiple slots.
>>
>
> A hardware exists and AFAICT works as expected,
> with bus speeds up to 50 MHz.
> We have a use case with internal peripherals.
>
>> Sometimes the mmc core needs to perform a sequence of operations
>> towards *one* host/card and that must be done in guaranteed manner, to
>> that no other operations are performed for another card/host
>> in-between.
>>
>
> Could you please elaborate on this?

mmc_claim|release_host() is used by the core to get exclusive access
to the host and its controller.

That's needed for a several reasons, both good and bad. In the case I
am referring to, it's about running a sequence of operations as to
follow the MMC/SD/SDIO spec. The sequence may involve calling several
of the host ops callbacks (->set_ios() ->request() etc) in a row,
without having any other to interfere with the same host.

Now, because those host drivers that *tries* to support multiple
cards, registers one host per card slot, the above assumption from the
core falls apart. In other words, the core can no longer guarantee to
follow the specs.

>
>> Perhaps if you are lucky you may get something that is very fragile to
>> work, but in the end I think the core needs to play along. Moreover,
>> dw_mmc has recently removed its multiple slot support - simply because
>> the complexity wasn't worth it.
>>
>
> I was not overly happy to see this removed, when I re-based to current master :-(

Sorry, but the code has never worked. And because no one complained,
it for sure made sense to remove it.

Kind regards
Uffe
