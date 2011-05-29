From: Prashanth Bhat <prashanth.bhat@manipal.net>
Subject: Re: Possible bug in sdio.c?
Date: Sun, 29 May 2011 20:47:48 +0530
Message-ID: <4DE2639C.2090200@manipal.net>
References: <4DE1A7B0.7000600@manipal.net> <20110529141208.GC8360@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtpauth16.prod.mesa1.secureserver.net ([64.202.165.22]:52082
	"HELO smtpauth16.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753252Ab1E2PSI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 May 2011 11:18:08 -0400
In-Reply-To: <20110529141208.GC8360@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sunday 29 May 2011 07:42 PM, Micha=B3 Miros=B3aw wrote:
> On Sun, May 29, 2011 at 07:26:00AM +0530, Prashanth Bhat wrote:
>   =20
>> Hi Micha=B3,
>> In mmc/core/sdio.c, routine mmc_enable_4bit_bus():
>>
>> I think:
>>
>>      if (card->type =3D=3D MMC_TYPE_SDIO)
>>                return sdio_enable_wide(card);
>>
>> should really be:
>>
>>      if (card->type =3D=3D MMC_TYPE_SDIO || card->type =3D=3D MMC_TY=
PE_SD_COMBO )
>>                 return sdio_enable_wide(card);
>>
>> Otherwise, the SDIO component of the SD Combo card will not operate
>> in wide mode. What do you think?
>>
>> Perhaps a similar change is needed in the sdio_enable_hs() routine t=
oo.
>>     =20
> Hi,
>
> You sent similar problem report some time ago. I assumed you will fol=
low
> on with a patch fixing mmc_card_sd() and friends (the functions you p=
oint
> out in this mail should use that).
>
> Best Regards,
> Micha=B3 Miros=B3aw
>
>
>   =20
Thanks for the reply. Are there other places where this new function=20
must be used? Is it only these 2 places?

Could you please clarify the formal process for including these changes=
=20
into the build? I have made the previous changes in my private code tre=
e=20
only so far.

Thanks,
Prashanth
