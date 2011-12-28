From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc: Check to disable IOCTL when card is mounted
Date: Wed, 28 Dec 2011 18:16:04 +0530
Message-ID: <CANYdXnqfokBvVZhnK2TGh=gxaX=RrjJRs=aAJ32_rTqHHUWDSg@mail.gmail.com>
References: <1325069180-16319-1-git-send-email-shashidharh@vayavyalabs.com>
	<4EFB06EC.1050100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33260 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab1L1MqH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2011 07:46:07 -0500
Received: by iaeh11 with SMTP id h11so21997619iae.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Dec 2011 04:46:06 -0800 (PST)
In-Reply-To: <4EFB06EC.1050100@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, linux-mmc@vger.kernel.org

On Wed, Dec 28, 2011 at 5:39 PM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 28/12/11 12:46, Shashidhar hiremath wrote:
>> From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>
>> The Patch adds a check to disable the IOCTL from running when the ca=
rd is mounted
>> or device is opened elsewhere.
>
> What if someone wants to do that.
The issue with not having this is that if there is huge size data
transfer operation happening, the IOCTL issuing will corrupt the data
transfer operation. So it would be better to finish the device's
access by one thing and give control to ioctl after that.
>
> Generally the kernel does not prevent access to raw block devices
> just because a file system is mounted on them, so I guess MMC should
> not either.

>
>
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> =C2=A0drivers/mmc/card/block.c | =C2=A0 =C2=A06 ++++++
>> =C2=A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 0cad48a..e680929 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -387,6 +387,12 @@ static int mmc_blk_ioctl_cmd(struct block_devic=
e *bdev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cmd_done;
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 /* Disallow the IOCTL run if card is already mounted=
 or device is
>> + =C2=A0 =C2=A0 =C2=A0* opened elsewhere */
>> + =C2=A0 =C2=A0 if (md->usage > 3) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cmd_done;
>> + =C2=A0 =C2=A0 }
>
> Checking the usage will not work consistently e.g.
> if there is a sysfs access or another ioctl access at the
> same time, or just some other kernel user of the device.
>
>>
>> =C2=A0 =C2=A0 =C2=A0 card =3D md->queue.card;
>> =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(card)) {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
regards,
Shashidhar Hiremath
