From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: PATCH: mmc.c DDR print of card type not correct
Date: Thu, 4 Nov 2010 14:55:00 +0900
Message-ID: <AANLkTikqccYDA8ZSFJ6LrjSfw9FKn-4ayOKhf21hX2MU@mail.gmail.com>
References: <24C0629C-F7E8-4D4A-A42A-2B6578B5AE2D@marvell.com>
	<AANLkTikDV86SXjkj_B4Mv=hfDeMU=QAywRgQROfcen7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34648 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab0KDFzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 01:55:00 -0400
Received: by pvb32 with SMTP id 32so474320pvb.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Nov 2010 22:55:00 -0700 (PDT)
In-Reply-To: <AANLkTikDV86SXjkj_B4Mv=hfDeMU=QAywRgQROfcen7A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

It should be fixed.

Thank you,
Kyungmin Park

On Tue, Nov 2, 2010 at 3:11 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/10/29 Philip Rakity <prakity@marvell.com>:
>
>> we should not call mmc_card_set_ddr_mode if we are in single data mo=
de. =A0This sets DDR and causes
>> the print out in the log to say the card is DDR when it is not.
>>
>> Explicitly set ddr to 0 rather then rely on MMC_SDR_MODE being 0 whe=
n doing the checks.
>>
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>
> This looks correct to me and my immediate colleagues.
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
