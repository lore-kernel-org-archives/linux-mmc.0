From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] mmc: core: Fix build warning with !CONFIG_SUSPEND
Date: Sun, 27 May 2012 16:11:55 +0530
Message-ID: <CAMQu2gxH0e=Kdh5eABi3W07Rg_HNsCChUmNOtV4HmxYpQssmFA@mail.gmail.com>
References: <1337414319-27719-1-git-send-email-santosh.shilimkar@ti.com> <87d35q1gjb.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53363 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab2E0KmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 27 May 2012 06:42:17 -0400
Received: by qcmt36 with SMTP id t36so1239509qcm.29
        for <linux-mmc@vger.kernel.org>; Sun, 27 May 2012 03:42:15 -0700 (PDT)
In-Reply-To: <87d35q1gjb.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 27, 2012 at 8:22 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Sat, May 19 2012, Santosh Shilimkar wrote:
>> With !CONFIG_SUSPEND, mmc core layer throws below build warnings.
>>
>> drivers/mmc/core/bus.c:125: warning: 'mmc_bus_suspend' defined but n=
ot used
>> drivers/mmc/core/bus.c:136: warning: 'mmc_bus_resume' defined but no=
t used
>> drivers/mmc/core/sdio_bus.c:197: warning: 'pm_no_operation' defined =
but not used
>>
>> Fix is by wrapping suspend hooks under CONFIG_SUSPEND
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>> =A0drivers/mmc/core/bus.c =A0 =A0 =A0| =A0 =A02 ++
>> =A0drivers/mmc/core/sdio_bus.c | =A0 =A02 +-
>> =A02 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index c60cee9..ca8925d 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -122,6 +122,7 @@ static int mmc_bus_remove(struct device *dev)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +#ifdef CONFIG_SUSPEND
>> =A0static int mmc_bus_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct mmc_driver *drv =3D to_mmc_driver(dev->driver);
>> @@ -143,6 +144,7 @@ static int mmc_bus_resume(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->resume(card);
>> =A0 =A0 =A0 return ret;
>> =A0}
>> +#endif
>>
>> =A0#ifdef CONFIG_PM_RUNTIME
>>
>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus=
=2Ec
>> index 236842e..87d1b7e 100644
>> --- a/drivers/mmc/core/sdio_bus.c
>> +++ b/drivers/mmc/core/sdio_bus.c
>> @@ -192,7 +192,7 @@ static int sdio_bus_remove(struct device *dev)
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -#ifdef CONFIG_PM
>> +#ifdef CONFIG_SUSPEND
>>
>> =A0static int pm_no_operation(struct device *dev)
>> =A0{
>
> This patch doesn't apply against mmc-next, and I think this has alrea=
dy
> been fixed upstream -- please could you retest against Linus HEAD?
>
Indeed. It got fixed by commit 0dd1bfeb6.
Thanks for the update.

Regards
Santosh
