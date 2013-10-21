From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: Re: [PATCH 3/8] sdhci: Use work structs instead of tasklets
Date: Mon, 21 Oct 2013 10:36:27 +0200
Message-ID: <5264E78B.1020209@parrot.com>
References: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com> <1381940458-12628-4-git-send-email-jeremie.samuel.ext@parrot.com> <874n8b9ywb.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:49940 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810Ab3JUIhv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 04:37:51 -0400
In-Reply-To: <874n8b9ywb.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?B?R3LDqWdvciBCb2lyaWU=?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Hi Chris,

Thanks for the feedback.

Do you have a way for me to compile the driver for all the architecture=
s=20
impacted by the patch? So I could send a patch which compile for all=20
these architectures.

Cordially,

Jeremie

--=20
Jeremie Samuel              Parrot S.A.
Software Engineer           14, quai de Jemmapes
R&D/OS Platform             75010 Paris, France
http://www.parrot.com

On 21/10/2013 03:49, Chris Ball wrote:
> Hi Jeremie,
>
> On Wed, Oct 16 2013, Jeremie Samuel wrote:
>> The driver can happily live without an atomic context and tasklets,
>> so turn the tasklets into the work structs.
>>
>> Tasklets handlers still grab irqsave spinlocks, but we'll deal
>> with it in a separate patch.
>>
>> Patch based on:http://thread.gmane.org/gmane.linux.kernel.mmc/2579.
>>
>> Signed-off-by: Anton Vorontsov<avorontsov@mvista.com>
>> Signed-off-by: Jeremie Samuel<jeremie.samuel.ext@parrot.com>
>> [..]
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index 2b0f4f3..05cd76c 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -161,8 +161,8 @@ struct sdhci_host {
>>   	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
>>   	dma_addr_t align_addr;	/* Mapped bounce buffer */
>>  =20
>> -	struct tasklet_struct card_tasklet;	/* Tasklet structures */
>> -	struct tasklet_struct finish_tasklet;
>> +	struct work_struct	card_detect_work;
>> +	struct work_struct	finish_work;
> More compile errors:
>
>   =CE=BB git grep card_tasklet drivers/mmc/host
> drivers/mmc/host/sdhci-bcm-kona.c: * to generate the CD IRQ handled i=
n sdhci.c which schedules card_tasklet.
> drivers/mmc/host/sdhci-dove.c:  tasklet_schedule(&host->card_tasklet)=
;
> drivers/mmc/host/sdhci-s3c.c:           tasklet_schedule(&host->card_=
tasklet);
> drivers/mmc/host/sdhci-spear.c: tasklet_schedule(&host->card_tasklet)=
;
>
> Thanks,
>
> - Chris.

