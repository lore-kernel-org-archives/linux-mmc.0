From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: Help needed on an error during SD card enumeration
Date: Mon, 21 Jan 2013 20:30:15 +0530
Message-ID: <CANYdXnr80xUS1n1h03FG7yE4zm=MQrv5HotJNb57zHMGdbNf2Q@mail.gmail.com>
References: <CANYdXnrSP80ex7xCr029D_AQPRWjShnrvckPt0Hu7cVYx0QicQ@mail.gmail.com>
	<CAF=Qhp19xxpQBJybCOeyuP-wW8WWOoM65dFsmiD0C6S6XB7YUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36920 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab3AUPAQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 10:00:16 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so10055876ieb.31
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jan 2013 07:00:16 -0800 (PST)
In-Reply-To: <CAF=Qhp19xxpQBJybCOeyuP-wW8WWOoM65dFsmiD0C6S6XB7YUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jae hoon Chung <jh80.chung@gmail.com>

thanks Kishore, please find my comments below:-

On Mon, Jan 21, 2013 at 8:19 PM, Kishore Kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> Hi Shashidhar Hiremath,
>
>
> <snip>
>
>>
>> mmc0:host doesn't support card's voltages
>> set_ios invoked
>> Poweroff Done
>>
>> mmc0: error -22 whilst initializing SDIO card
>
> Could you check whether the MMC host controller regulator is
> configured properly
.
I am testing on an FPGA the power enabling is done through a PWREN
register write.
>
>> eventhough I have inserted a SD card
>
> Which SD card you are using ?
The card is a Kingston SD card.

Does ocr_avail in driver have any connection with this. And Why is
set_ios called with POWER_OFF
>
> <snip>
>
> Regards,
> Kishore



--
regards,
Shashidhar Hiremath
