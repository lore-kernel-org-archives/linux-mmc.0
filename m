From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4 v2] mmc: host: switch OF parser to use gpio descriptors
Date: Tue, 9 Sep 2014 14:29:35 +0200
Message-ID: <CAPDyKFpXqQLH0mBJ1skQ0sSD_BPg9dN4zkcx19wDUi=Jea4hPQ@mail.gmail.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
	<1409137253-25189-3-git-send-email-linus.walleij@linaro.org>
	<CACRpkdasOHPvb8ev5BrT4LPVYSJYATXnpRjazdAupb6zy4-NrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:59327 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbaIIM3f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 08:29:35 -0400
Received: by mail-qc0-f179.google.com with SMTP id o8so1080576qcw.38
        for <linux-mmc@vger.kernel.org>; Tue, 09 Sep 2014 05:29:35 -0700 (PDT)
In-Reply-To: <CACRpkdasOHPvb8ev5BrT4LPVYSJYATXnpRjazdAupb6zy4-NrA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On 9 September 2014 09:05, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 27, 2014 at 1:00 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> This switches the central MMC OF parser to use gpio descriptors
>> instead of grabbing GPIOs explicitly from the device tree.
>> This strips out an unecessary use of the integer-based GPIO
>> API that we want to get rid of, cuts down on code as the
>> gpio descriptor code will handle active low flags.
>>
>> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Restore error reporting as done in previous stand-alone
>>   patch.
>
> Hi Ulf,
>
> the v2 version of this patch set should be working fine on
> v3.17-rc4, as I merged a patch setting up the correct
> prototypes for systems without gpiolib.
>
> Fenguang's build tests are working on it atleast, I promise...
>
> Tell me if you want me to resend the patch set or if you can
> take the same patches again, but on top of -rc4. There is
> no change in them.
>

Hi Linus,

I have re-applied them again, let's hope for better luck this time. :-)

Kind regards
Uffe
