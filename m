From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc: card: Do not scan boot partitions
Date: Wed, 20 Jun 2012 09:27:46 +0200
Message-ID: <CA+20K0DJYYeo80pVC1wLo_+VaXYvgiOnJzSvf9mE_u69Dj941w@mail.gmail.com>
References: <1339506253-7164-1-git-send-email-johan.rudholm@stericsson.com>
	<87oboe4ibk.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53668 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab2FTH1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jun 2012 03:27:47 -0400
Received: by lbbgm6 with SMTP id gm6so214597lbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jun 2012 00:27:46 -0700 (PDT)
In-Reply-To: <87oboe4ibk.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Chris,

2012/6/20 Chris Ball <cjb@laptop.org>:
> Hi Johan,
>
> On Tue, Jun 12 2012, Johan Rudholm wrote:
>> Do not scan boot partitions for "soft" partitions, since the boot
>> partitions are supposed to contain boot code. Silences the following
>> message during boot:
>>
>> =A0mmcblkXbootY: unknown partition table
>>
>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 =A02 ++
>> =A01 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 7e3f453..efdea68 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1515,6 +1515,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(=
struct mmc_card *card,
>> =A0 =A0 =A0 md->disk->queue =3D md->queue.queue;
>> =A0 =A0 =A0 md->disk->driverfs_dev =3D parent;
>> =A0 =A0 =A0 set_disk_ro(md->disk, md->read_only || default_ro);
>> + =A0 =A0 if (area_type & MMC_BLK_DATA_AREA_BOOT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 md->disk->flags =3D GENHD_FL_NO_PART_SCAN;
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* As discussed on lkml, GENHD_FL_REMOVABLE should:
>
> Would it be impossible to add a partition table to mmcblkXbootY,
> or just unlikely?

I believe this is just an unlikely scenario since the boot partitions
are supposed to contain boot code and also because of their relatively
small size (a few MBs), but there is no technical problem. Perhaps it
should be left up to the user? RPMB partitions are an example of
partitions that would actually generate an error on partition scanning
(because they require authentication), but this is not the case for
boot partitions.

Kind regards, Johan
