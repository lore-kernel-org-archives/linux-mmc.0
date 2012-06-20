From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: card: Do not scan boot partitions
Date: Wed, 20 Jun 2012 09:51:14 +0200
Message-ID: <CAPDyKFo3YdPjP2izT-PRwo5onaNpTDy46pXcP4Qi0_FmVY+Guw@mail.gmail.com>
References: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
	<87oboe4ibk.fsf@octavius.laptop.org>
	<CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63527 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab2FTHvQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 03:51:16 -0400
Received: by eaak11 with SMTP id k11so2273129eaa.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jun 2012 00:51:15 -0700 (PDT)
In-Reply-To: <CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Johan and Chris,

On 20 June 2012 09:27, Johan Rudholm <jrudholm@gmail.com> wrote:
> Hi Chris,
>
> 2012/6/20 Chris Ball <cjb@laptop.org>:
>> Hi Johan,
>>
>> On Tue, Jun 12 2012, Johan Rudholm wrote:
>>> Do not scan boot partitions for "soft" partitions, since the boot
>>> partitions are supposed to contain boot code. Silences the followin=
g
>>> message during boot:
>>>
>>> =A0mmcblkXbootY: unknown partition table
>>>
>>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>>> ---
>>> =A0drivers/mmc/card/block.c | =A0 =A02 ++
>>> =A01 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 7e3f453..efdea68 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1515,6 +1515,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req=
(struct mmc_card *card,
>>> =A0 =A0 =A0 md->disk->queue =3D md->queue.queue;
>>> =A0 =A0 =A0 md->disk->driverfs_dev =3D parent;
>>> =A0 =A0 =A0 set_disk_ro(md->disk, md->read_only || default_ro);
>>> + =A0 =A0 if (area_type & MMC_BLK_DATA_AREA_BOOT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 md->disk->flags =3D GENHD_FL_NO_PART_SCAN=
;
>>>
>>> =A0 =A0 =A0 /*
>>> =A0 =A0 =A0 =A0* As discussed on lkml, GENHD_FL_REMOVABLE should:
>>
>> Would it be impossible to add a partition table to mmcblkXbootY,
>> or just unlikely?
>
> I believe this is just an unlikely scenario since the boot partitions
> are supposed to contain boot code and also because of their relativel=
y
> small size (a few MBs), but there is no technical problem. Perhaps it
> should be left up to the user? RPMB partitions are an example of
> partitions that would actually generate an error on partition scannin=
g
> (because they require authentication), but this is not the case for
> boot partitions.
>

To me this looks like a fair constraint we can put on the boot
partitions. It does not make sense to have a partition table in there.
So I say go ahead with this patch.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson
