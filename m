From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/2] mmc: atmel: get rid of struct mci_dma_data
Date: Sat, 09 Jan 2016 12:13:03 +0000
Message-ID: <yw1xwprjx86o.fsf@unicorn.mansr.com>
References: <1452302551-24199-1-git-send-email-mans@mansr.com>
	<1452302551-24199-2-git-send-email-mans@mansr.com>
	<CAHp75Vdq83QRUw_ZxxVWcC6Xut5y-sJfYwLA+cOtGMhjB7Rm3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:50851 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbcAIMNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Jan 2016 07:13:11 -0500
In-Reply-To: <CAHp75Vdq83QRUw_ZxxVWcC6Xut5y-sJfYwLA+cOtGMhjB7Rm3w@mail.gmail.com>
	(Andy Shevchenko's message of "Sat, 9 Jan 2016 14:10:27 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Sat, Jan 9, 2016 at 3:22 AM, Mans Rullgard <mans@mansr.com> wrote:
>> As struct mci_dma_data is now only used by AVR32, it is nothing but
>> pointless indirection.  Replace it with struct dw_dma_slave in the
>> AVR32 platform code and with a void pointer elsewhere.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>
>> @@ -1376,15 +1375,15 @@ at32_add_device_mci(unsigned int id, struct =
mci_platform_data *data)
>>                                 ARRAY_SIZE(atmel_mci0_resource)))
>>                 goto fail;
>>
>> -       slave =3D kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
>> +       slave =3D kzalloc(sizeof(*slave), GFP_KERNEL);
>>         if (!slave)
>>                 goto fail;
>>
>> -       slave->sdata.dma_dev =3D &dw_dmac0_device.dev;
>> -       slave->sdata.src_id =3D 0;
>> -       slave->sdata.dst_id =3D 1;
>> -       slave->sdata.m_master =3D 1;
>> -       slave->sdata.p_master =3D 0;
>
> Seems you based this on top of our non-submitted yet patches.

You're right.  I didn't realise this file had been touched by those
patches, and I didn't read the code all that carefully when making this
change.

>> +       slave->dma_dev =3D &dw_dmac0_device.dev;
>> +       slave->src_id =3D 0;
>> +       slave->dst_id =3D 1;
>> +       slave->m_master =3D 1;
>> +       slave->p_master =3D 0;
>
> --=20
> With Best Regards,
> Andy Shevchenko

--=20
M=E5ns Rullg=E5rd
