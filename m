From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: mxcmmc: Convert to SIMPLE_DEV_PM_OPS
Date: Sat, 22 Feb 2014 11:59:53 -0300
Message-ID: <CAOMZO5DesjMCGXeYxaO8y1s7zNfP1z9qr_SsQA2W178n4rcW4A@mail.gmail.com>
References: <1393080372-6760-1-git-send-email-shc_work@mail.ru>
	<1393080372-6760-2-git-send-email-shc_work@mail.ru>
	<CAOMZO5CKgYfHT5NS3MOmDh7q6PQX7zJx2y11csWNjNded6-bqw@mail.gmail.com>
	<1393081043.986934859@f421.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:49374 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaBVO7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 09:59:54 -0500
Received: by mail-vc0-f181.google.com with SMTP id lg15so719646vcb.12
        for <linux-mmc@vger.kernel.org>; Sat, 22 Feb 2014 06:59:53 -0800 (PST)
In-Reply-To: <1393081043.986934859@f421.i.mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>

On Sat, Feb 22, 2014 at 11:57 AM, Alexander Shiyan <shc_work@mail.ru> w=
rote:
> =D0=A1=D1=83=D0=B1=D0=B1=D0=BE=D1=82=D0=B0, 22 =D1=84=D0=B5=D0=B2=D1=80=
=D0=B0=D0=BB=D1=8F 2014, 11:51 -03:00 =D0=BE=D1=82 Fabio Estevam <feste=
vam@gmail.com>:
>> On Sat, Feb 22, 2014 at 11:46 AM, Alexander Shiyan <shc_work@mail.ru=
> wrote:
>> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>> > ---
>> >  drivers/mmc/host/mxcmmc.c | 13 +++----------
>> >  1 file changed, 3 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>> > index 84d630e..86401c0 100644
>> > --- a/drivers/mmc/host/mxcmmc.c
>> > +++ b/drivers/mmc/host/mxcmmc.c
>> > @@ -1220,8 +1220,7 @@ static int mxcmci_remove(struct platform_dev=
ice *pdev)
>> >         return 0;
>> >  }
>> >
>> > -#ifdef CONFIG_PM
>> > -static int mxcmci_suspend(struct device *dev)
>>
>> Doesn't this need to be protected by CONFIG_PM_SLEEP?
>
> No, this already protected by SIMPLE_DEV_PM_OPS(),
> see include/linux/pm.h.

but then you would get a warning saying that "mxcmci_suspend/resume"
are defined by not used" when CONFIG_PM_SLEEP=3Dn
