From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] sdhci-s3c: add platform_8bit_width()
Date: Wed, 12 Jan 2011 12:54:07 +0900
Message-ID: <AANLkTi=oh004OUBQSSBQU634SuwKhRHNzriUu4DZv9dD@mail.gmail.com>
References: <4D2CF631.4080402@samsung.com>
	<20110112022030.GA27414@void.printf.net>
	<4D2D1900.1020200@samsung.com>
	<20110112032700.GA28143@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33157 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab1ALDyI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2011 22:54:08 -0500
Received: by wwi17 with SMTP id 17so3459068wwi.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jan 2011 19:54:07 -0800 (PST)
In-Reply-To: <20110112032700.GA28143@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>

On Wed, Jan 12, 2011 at 12:27 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Jaehoon,
>
> On Wed, Jan 12, 2011 at 11:59:12AM +0900, Jaehoon Chung wrote:
>> Hi Chris.
>>
>> Thanks for your comments.
>> So i fixed them, and resend the patch.
>
> Thanks! =A0I've pushed it to mmc-next.
>
>> We have 8-bit width support bu is not a v3 controller.
>> So we need platform_8bit_width() to support 8-bit buswidth.
>> Also we need MMC_CAP_8_BIT_DATA, so we add it in platdata.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> I made one more change -- the rest of sdhci-s3c.c uses kerneldoc form=
at
> function comments, but your patch doesn't have the correct kerneldoc =
syntax:
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 89f019f..5309ab9 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -277,12 +277,14 @@ static void sdhci_cmu_set_clock(struct sdhci_ho=
st *host, unsigned int clock)
> =A0 =A0 =A0 =A0host->clock =3D clock;
> =A0}
>
> -/*
> +/**
> =A0* sdhci_s3c_platform_8bit_width - support 8bit buswidth
> + * @host: The SDHCI host being queried
> + * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
> =A0*
> =A0* We have 8-bit width support but is not a v3 controller.
> =A0* So we add platform_8bit_width() and support 8bit width.
> - **/
> + */
> =A0static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, =
int width)
> =A0{
> =A0 =A0 =A0 =A0u8 ctrl;
>
>
> Ben, feel free to yell if you object to the final version of the patc=
h,
> else I'll merge it for .39.

Hi Chris,

Umm I think it's kind of bug fix since we used 8-bit buswidth previous
code but recent change don't make it working
So re-support the 8-bit buswidth. Can you merge it at 38.rc period?

How do you think?

Thank you,
Kyungmin Park
