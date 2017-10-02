From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [PATCH] mmc: dw_mmc: Add support for multiple SD cards on one
 host interface
Date: Mon, 2 Oct 2017 14:31:59 +0000
Message-ID: <ed12bab0-1270-af10-0313-ad9e2f32173e@hotmail.de>
References: <AM5PR0701MB2657094CA5D94164E6D63A8DE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAPDyKFr3==eZQOojPac4fse8baHa+UXweOezdb9vFiSB9jae_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oln040092071010.outbound.protection.outlook.com ([40.92.71.10]:8672
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbdJBOcD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Oct 2017 10:32:03 -0400
In-Reply-To: <CAPDyKFr3==eZQOojPac4fse8baHa+UXweOezdb9vFiSB9jae_Q@mail.gmail.com>
Content-Language: de-DE
Content-ID: <5DC1D082CB6F974EAA3DCA8D4F7F8A37@sct-15-1-1199-6-msonline-outlook-20107.templateTenant>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 10/02/17 09:12, Ulf Hansson wrote:
> On 30 September 2017 at 17:39, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> Needs external logic to multiplex the clock signal,
>> which is controlled by a GPIO output pin.
>>
>> Only the selected SD card receives the clock,
>> while the other SD card's clock is forced to LOW.
>> DATA and CMD lines can be connected to both SD cards.
>>
>> On warm-start UBOOT should use a sequence of
>> CMD12 and CMD7 with RCA=0 to force any active SD card
>> to stop transmission and release the DATA bus.
> 
> I doubt that is sufficient to support multiple slots.
> 

A hardware exists and AFAICT works as expected,
with bus speeds up to 50 MHz.
We have a use case with internal peripherals.

> Sometimes the mmc core needs to perform a sequence of operations
> towards *one* host/card and that must be done in guaranteed manner, to
> that no other operations are performed for another card/host
> in-between.
> 

Could you please elaborate on this?

> Perhaps if you are lucky you may get something that is very fragile to
> work, but in the end I think the core needs to play along. Moreover,
> dw_mmc has recently removed its multiple slot support - simply because
> the complexity wasn't worth it.
> 

I was not overly happy to see this removed, when I re-based to current master :-(


Bernd