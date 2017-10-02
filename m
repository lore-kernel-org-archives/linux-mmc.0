From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Add support for multiple SD cards on one
 host interface
Date: Mon, 2 Oct 2017 09:12:30 +0200
Message-ID: <CAPDyKFr3==eZQOojPac4fse8baHa+UXweOezdb9vFiSB9jae_Q@mail.gmail.com>
References: <AM5PR0701MB2657094CA5D94164E6D63A8DE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:56762 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdJBHMb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 03:12:31 -0400
Received: by mail-it0-f53.google.com with SMTP id g18so6236746itg.5
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 00:12:31 -0700 (PDT)
In-Reply-To: <AM5PR0701MB2657094CA5D94164E6D63A8DE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 30 September 2017 at 17:39, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> Needs external logic to multiplex the clock signal,
> which is controlled by a GPIO output pin.
>
> Only the selected SD card receives the clock,
> while the other SD card's clock is forced to LOW.
> DATA and CMD lines can be connected to both SD cards.
>
> On warm-start UBOOT should use a sequence of
> CMD12 and CMD7 with RCA=0 to force any active SD card
> to stop transmission and release the DATA bus.

I doubt that is sufficient to support multiple slots.

Sometimes the mmc core needs to perform a sequence of operations
towards *one* host/card and that must be done in guaranteed manner, to
that no other operations are performed for another card/host
in-between.

Perhaps if you are lucky you may get something that is very fragile to
work, but in the end I think the core needs to play along. Moreover,
dw_mmc has recently removed its multiple slot support - simply because
the complexity wasn't worth it.

Unless Jaehoon have changed his mind, I am not going to pick this up.

[...]

Kind regards
Uffe
