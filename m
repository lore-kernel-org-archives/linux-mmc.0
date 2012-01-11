From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc: core: move suspend/resume to dev_pm_ops and add
 hibernation support
Date: Wed, 11 Jan 2012 10:54:20 +0800
Message-ID: <CAGsJ_4yruL+M3osK2DjWj_ankvOFnUFG_tgmrMe9c1uKa4JrNw@mail.gmail.com>
References: <1326090169-4942-1-git-send-email-Barry.Song@csr.com> <CAM=Q2cv_sZ89YJbyqVhKYaBA=Yg3UDcv6hfpiebvMYoXkrVg3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37151 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692Ab2AKCym convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2012 21:54:42 -0500
Received: by bkvi17 with SMTP id i17so178080bkv.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2012 18:54:41 -0800 (PST)
In-Reply-To: <CAM=Q2cv_sZ89YJbyqVhKYaBA=Yg3UDcv6hfpiebvMYoXkrVg3Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Barry Song <Barry.Song@csr.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, workgroup.linux@csr.com, Bin Shi <Bin.Shi@csr.com>

2012/1/9 Shubhrajyoti Datta <omaplinuxkernel@gmail.com>:
> Hi Bin,
>
> On Mon, Jan 9, 2012 at 11:52 AM, Barry Song <Barry.Song@csr.com> wrot=
e:
>> From: Bin Shi <Bin.Shi@csr.com>
>>
>> This patch moves suspend/resume to dev_pm_ops and add hibernation su=
pport.
>> It was tested on CSR SiRFprimaII cortex-a9 platform. A sd partition =
is used
>> as swsusp partition.
>>
>> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
>> Signed-off-by: Barry Song <Barry.Song@csr.com>
>> ---
>> =C2=A0drivers/mmc/core/bus.c | =C2=A0 38 +++++++++++++++++++++++++--=
-----------
>> =C2=A01 files changed, 25 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 6be4924..bab50f7 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> =C2=A0}
>>
>> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
>> +static int mmc_bus_suspend(struct device *dev)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_driver *drv =3D to_mmc_driver(=
dev->driver);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_card *card =3D mmc_dev_to_card=
(dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev->driver && drv->suspend)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drv->susp=
end(card, state);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drv->susp=
end(card, PMSG_SUSPEND);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>> =C2=A0}
>>
>> @@ -144,6 +144,17 @@ static int mmc_bus_resume(struct device *dev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>> =C2=A0}
>>
>> +static int mmc_bus_freeze(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_driver *drv =3D to_mmc_driver(dev-=
>driver);
>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_card *card =3D mmc_dev_to_card(dev=
);
>> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (dev->driver && drv->suspend)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D drv->susp=
end(card, PMSG_FREEZE);
>
> Not a comment , rather a doubt
>
> Any particular reason to differenciate freeze and =C2=A0suspend?


Shubhrajyoti,
there is no real difference for our system. this is just to keep
back-compatible with old mmc_driver.suspend() since the function
accepts a PMSG_xxx as param.
i think all things go well if we add freeze/thaw/restore in Dmitry
Shmidt's "[PATCH V4] mmc: Set suspend/resume bus operations if
CONFIG_PM_RUNTIME is used"

-barry
