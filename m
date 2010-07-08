From: Ethan Du <ethan.too@gmail.com>
Subject: Re: SD Driver : FAT: FAT read failed (blocknr 8) in sd card error
	while removing sd card during writing
Date: Thu, 8 Jul 2010 19:06:09 +0800
Message-ID: <AANLkTinHHYaVlBJKI2MxyvKzZ-EcNHtHBvXrtzsCIglS@mail.gmail.com>
References: <AANLkTim_7C0pYl_xwPbavrz96GJHiiTngUSWEiMAzGuL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44233 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab0GHLGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2010 07:06:10 -0400
Received: by vws5 with SMTP id 5so926722vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jul 2010 04:06:09 -0700 (PDT)
In-Reply-To: <AANLkTim_7C0pYl_xwPbavrz96GJHiiTngUSWEiMAzGuL@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: hardik patel <hk5patel@gmail.com>
Cc: linux-mmc@vger.kernel.org

Card removal not detected by driver?
You should see a line of log if card removal is detected:
card xxxx removed

Would you describe how do you detect card removal/insertion on your boa=
rd?

Regards,
-Ethan

On Thu, Jul 8, 2010 at 6:05 PM, hardik patel <hk5patel@gmail.com> wrote=
:
> I have sd card on board ... During recording/writing SD card, remove
> SD card ... then i am getting endless error in dmesg as below :
>
> end_request: I/O error, dev mmcblk0, sector 24
> FAT: FAT read failed (blocknr 8)
> mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
> sending read/write command, response 0x0, card status 0x0
> Block mmc_blk_issue_rq function call 346
> end_request: I/O error, dev mmcblk0, sector 4
> FAT: FAT read failed (blocknr 4)
> MMC: killing requests for dead queue
> end_request: I/O error, dev mmcblk0, sector 8
> FAT: FAT read failed (blocknr 8)
> FAT: FAT read failed (blocknr 4)
> FAT: FAT read failed (blocknr 8)
> FAT: FAT read failed (blocknr 4)
> FAT: FAT read failed (blocknr 8)
> FAT: FAT read failed (blocknr 4)
> FAT: FAT read failed (blocknr 8)
>
> How to stop this message ... what is ideal situation when we remove
> card while writing ...... can u help me what to do ?
>
> where is the problem here? sd host controler driver problem or block
> driver problem or file system problem
>
> Note: I have formatted sd card with FAT32 file system .
>
>
>
> With EXT3 File system :
>
> Remove SD card while writing/recording we got error messages like
> below. but this is not endless. After some time it stops.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> end_request: I/O error, dev mmcblk0, sector 156536
> mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
> sending read/write command, response 0x0, card status 0x0
> mmcblk0: error -110 requesting status
> end_request: I/O error, dev mmcblk0, sector 4736
> Aborting journal on device mmcblk0p1.
> ext3_abort called.
> EXT3-fs error (device mmcblk0p1): ext3_journal_start_sb: Detected
> aborted journal
> Remounting filesystem read-only
> end_request: I/O error, dev mmcblk0, sector 4448
> journal commit I/O error
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
