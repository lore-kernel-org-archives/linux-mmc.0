From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 1/3] mmc: add per device quirk placeholder
Date: Mon, 10 Jan 2011 18:02:02 +0100
Message-ID: <AANLkTinKp6-eR9zK4pddqnBTKoawiaoq4zfEUKk2Qr=u@mail.gmail.com>
References: <cover.1294588491.git.tardyp@gmail.com>
	<6191610532f25d7cda435781ce9b83bfdb677b5a.1294588491.git.tardyp@gmail.com>
	<77BC89B5-DFC2-4908-8875-59BCD00DC10F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59430 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab1AJRCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2011 12:02:03 -0500
In-Reply-To: <77BC89B5-DFC2-4908-8875-59BCD00DC10F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pierre Tardy <pierre.tardy@intel.com>

>> +
>> + =A0 =A0 for (f =3D mmc_fixup_methods; f->hook; f++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((f->vendor =3D=3D card->cis.vendor
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| f->vendor =3D=3D (u16) SDIO_=
ANY_ID) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (f->device =3D=3D card->cis.device
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| f->device =3D=3D (u16) SDIO_=
ANY_ID)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&card->dev, "calli=
ng %pF\n", f->hook);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f->hook(card, f->data);
>
>
> hook is not a very nice name --- =A0something more meaningful: =A0ven=
dor_fixup =A0?
I just copied the pci/quirks.c way of doing. I think is more coherent
to keep is this way, this name will forever appear only in 4 lines
inside the kernel, so I dont care that much.
I'll change that if you really do care. :-)

Waiting for a few more comments to do all in a row.

Thanks,
--=20
Pierre
