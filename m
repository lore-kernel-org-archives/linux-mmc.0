From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: Help needed on an error during SD card enumeration
Date: Mon, 21 Jan 2013 20:19:26 +0530
Message-ID: <CAF=Qhp19xxpQBJybCOeyuP-wW8WWOoM65dFsmiD0C6S6XB7YUA@mail.gmail.com>
References: <CANYdXnrSP80ex7xCr029D_AQPRWjShnrvckPt0Hu7cVYx0QicQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:47669 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab3AUOtr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 09:49:47 -0500
Received: by mail-ob0-f179.google.com with SMTP id x4so5900908obh.24
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jan 2013 06:49:46 -0800 (PST)
In-Reply-To: <CANYdXnrSP80ex7xCr029D_AQPRWjShnrvckPt0Hu7cVYx0QicQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jae hoon Chung <jh80.chung@gmail.com>

Hi Shashidhar Hiremath,


<snip>

>
> mmc0:host doesn't support card's voltages
> set_ios invoked
> Poweroff Done
>
> mmc0: error -22 whilst initializing SDIO card

Could you check whether the MMC host controller regulator is
configured properly.

> eventhough I have inserted a SD card

Which SD card you are using ?

<snip>

Regards,
Kishore
