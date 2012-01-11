From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] mmc: core: move suspend/resume to dev_pm_ops and add
 hibernation support
Date: Wed, 11 Jan 2012 11:56:53 +0530
Message-ID: <CAM=Q2csKtAfp-htp1WyTT9oXL3TappC6F9G+i0ZVy2pVZdWw3A@mail.gmail.com>
References: <1326090169-4942-1-git-send-email-Barry.Song@csr.com>
	<CAM=Q2cv_sZ89YJbyqVhKYaBA=Yg3UDcv6hfpiebvMYoXkrVg3Q@mail.gmail.com>
	<CAGsJ_4yruL+M3osK2DjWj_ankvOFnUFG_tgmrMe9c1uKa4JrNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62415 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab2AKG0y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2012 01:26:54 -0500
Received: by vcbfk14 with SMTP id fk14so280019vcb.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2012 22:26:53 -0800 (PST)
In-Reply-To: <CAGsJ_4yruL+M3osK2DjWj_ankvOFnUFG_tgmrMe9c1uKa4JrNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Barry Song <Barry.Song@csr.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, workgroup.linux@csr.com, Bin Shi <Bin.Shi@csr.com>

Hi Barry,

On Wed, Jan 11, 2012 at 8:24 AM, Barry Song <21cnbao@gmail.com> wrote:
> 2012/1/9 Shubhrajyoti Datta <omaplinuxkernel@gmail.com>:
>> Hi Bin,
>>
>> On Mon, Jan 9, 2012 at 11:52 AM, Barry Song <Barry.Song@csr.com> wro=
te:
>>> From: Bin Shi <Bin.Shi@csr.com>
>>>
>>> This patch moves suspend/resume to dev_pm_ops and add hibernation s=
upport.
>>> It was tested on CSR SiRFprimaII cortex-a9 platform. A sd partition=
 is used
>>> as swsusp partition.
>>>
>>> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
>>> Signed-off-by: Barry Song <Barry.Song@csr.com>
>>> ---
>>> =A0drivers/mmc/core/bus.c | =A0 38 +++++++++++++++++++++++++-------=
------
>>> =A01 files changed, 25 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>>> index 6be4924..bab50f7 100644
>>> --- a/drivers/mmc/core/bus.c
>>> +++ b/drivers/mmc/core/bus.c
>>> @@ -122,14 +122,14 @@ static int mmc_bus_remove(struct device *dev)
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>>
>>> -static int mmc_bus_suspend(struct device *dev, pm_message_t state)
>>> +static int mmc_bus_suspend(struct device *dev)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct mmc_driver *drv =3D to_mmc_driver(dev->driver=
);
>>> =A0 =A0 =A0 =A0struct mmc_card *card =3D mmc_dev_to_card(dev);
>>> =A0 =A0 =A0 =A0int ret =3D 0;
>>>
>>> =A0 =A0 =A0 =A0if (dev->driver && drv->suspend)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, state);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, PMSG_SUSPE=
ND);
>>> =A0 =A0 =A0 =A0return ret;
>>> =A0}
>>>
>>> @@ -144,6 +144,17 @@ static int mmc_bus_resume(struct device *dev)
>>> =A0 =A0 =A0 =A0return ret;
>>> =A0}
>>>
>>> +static int mmc_bus_freeze(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 struct mmc_driver *drv =3D to_mmc_driver(dev->driver)=
;
>>> + =A0 =A0 =A0 struct mmc_card *card =3D mmc_dev_to_card(dev);
>>> + =A0 =A0 =A0 int ret =3D 0;
>>> +
>>> + =A0 =A0 =A0 if (dev->driver && drv->suspend)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(card, PMSG_FREEZ=
E);
>>
>> Not a comment , rather a doubt
>>
>> Any particular reason to differenciate freeze and =A0suspend?
>
>
> Shubhrajyoti,
> there is no real difference for our system. this is just to keep
> back-compatible with old mmc_driver.suspend() since the function
> accepts a PMSG_xxx as param.
> i think all things go well if we add freeze/thaw/restore in Dmitry
> Shmidt's "[PATCH V4] mmc: Set suspend/resume bus operations if
> CONFIG_PM_RUNTIME is used"
>
Thanks for the explanation.

> -barry
