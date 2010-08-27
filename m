From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH RESEND] au1xmmc.c: use resource_size()
Date: Sat, 28 Aug 2010 00:38:56 +0200
Message-ID: <AANLkTinDgFa2YMZ7-tL6OTtotnXXCALxaipWKncdqkJQ@mail.gmail.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9FB@mi8nycmail19.Mi8.com>
	<20100827191134.GF20407@void.printf.net>
	<20100827192626.GD7258@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48971 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab0H0Wi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 18:38:59 -0400
Received: by iwn5 with SMTP id 5so2983070iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 Aug 2010 15:38:57 -0700 (PDT)
In-Reply-To: <20100827192626.GD7258@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Chris Ball <cjb@laptop.org>, H Hartley Sweeten <hartleys@visionengravers.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>

On Fri, Aug 27, 2010 at 9:26 PM, Matt Fleming <matt@console-pimps.org> =
wrote:
> [Adding maintainer to CC]
>
> On Fri, Aug 27, 2010 at 08:11:34PM +0100, Chris Ball wrote:
>> From: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Date: Mon, 14 Dec 2009 14:28:06 -0500
>>
>> Use resource_size().
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> [cjb: rebased patch against Linus]
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>> =A0drivers/mmc/host/au1xmmc.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
>> index c8da5d3..e14b866 100644
>> --- a/drivers/mmc/host/au1xmmc.c
>> +++ b/drivers/mmc/host/au1xmmc.c
>> @@ -964,7 +964,7 @@ static int __devinit au1xmmc_probe(struct platfo=
rm_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out1;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 host->ioarea =3D request_mem_region(r->start, r->end - r->=
start + 1,
>> + =A0 =A0 host->ioarea =3D request_mem_region(r->start, resource_siz=
e(r),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0pdev->name);
>> =A0 =A0 =A0 if (!host->ioarea) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "mmio already in use=
\n");

Wasn't that posted ages ago?  I'm fine with it.

Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
