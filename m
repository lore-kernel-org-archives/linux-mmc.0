From: Loic pallardy <loic.pallardy@gmail.com>
Subject: Re: [PATCH v1 2/5] mmc: card: Do not scan RPMB partitions
Date: Wed, 11 Jul 2012 14:36:08 +0200
Message-ID: <CAKGveeZTGq1amnRr5urJ4ykMTPC_vxenn3WObnz1K1dWfa2mYg@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-3-git-send-email-loic.pallardy@stericsson.com>
	<CAKYAXd-Qn7EZfSw-Q=+0L3P1bE6q_ofPoEqC6eCM9HmFND6qHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34693 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2GKMgJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jul 2012 08:36:09 -0400
Received: by obbuo13 with SMTP id uo13so1611648obb.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jul 2012 05:36:08 -0700 (PDT)
In-Reply-To: <CAKYAXd-Qn7EZfSw-Q=+0L3P1bE6q_ofPoEqC6eCM9HmFND6qHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Loic Pallardy <loic.pallardy@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 276d21c..1b202fe 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1521,6 +1521,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct
>> mmc_card *card,
>>       md->disk->queue = md->queue.queue;
>>       md->disk->driverfs_dev = parent;
>>       set_disk_ro(md->disk, md->read_only || default_ro);
>> +     md->disk->flags = GENHD_FL_EXT_DEVT;
> Currrenlty mmc have been setting minors to CONFIG_MMC_BLOCK_MINORS.
> Why did you add GENHD_FL_EXT_DEVT ?
>
> Thanks.
Yes, my mistake, indeed not related to this patch.
Thanks.
