From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v4] mmc: core: select the operation mode with sysfs
Date: Mon, 6 Feb 2012 15:45:35 +0900
Message-ID: <CAKYAXd8jk2uc3-r2iypN+99ubh8wgZhX3CpmBTnTBpcuUzWvzw@mail.gmail.com>
References: <4F2F3D14.6060204@samsung.com>
	<CAKYAXd_LDUKQHDN7p44921n4uym9kOSoF2dGrGSr6vJ_19-2jw@mail.gmail.com>
	<4F2F6339.40501@samsung.com>
	<CAKYAXd81CsSggjj1WA2cDejSr-Lc9o0qmWgQR9gpAq8paoy2vQ@mail.gmail.com>
	<4F2F7383.60701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56634 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2BFGpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 01:45:38 -0500
Received: by bkcjm19 with SMTP id jm19so4407724bkc.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2012 22:45:36 -0800 (PST)
In-Reply-To: <4F2F7383.60701@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

2012/2/6 Jaehoon Chung <jh80.chung@samsung.com>:
> On 02/06/2012 03:17 PM, Namjae Jeon wrote:
>
>> 2012/2/6 Jaehoon Chung <jh80.chung@samsung.com>:
>>> Hi Mr.Jeon.
>>>
>>> On 02/06/2012 01:19 PM, Namjae Jeon wrote:
>>>
>>>> Hi. Jaehoon.
>>>>
>>>> I have questions.
>>>>
>>>> 1. Would you explain why we need on/off function of this CMD23 at =
runtime ?
>>>
>>> Now..operation mode is set at compile time..That means if we use th=
e pre-defined mode,
>>> must always use the pre-defined mode.
>>> Packed-cmd, Data-tag, Context-Id..etc..almost features need to use =
CMD23.
>>> But in vendor side, some card need to use the open-ended in order t=
o update the firmware code.
>>> (or not)
>>> If we use the cmd23, to update the firmware code maybe need to rebu=
ild..it's worthless.
>>> So i added this patch.
>> First, Thanks for your explaination.
>> If possible, you can add this description in patch header so that th=
e
>> other understand.
>>>
>>>> 2. While frequently reading/writing, Have you tested by being
>>>> enabling/disbling CMD23 using this function ?
>>>
>>> Yes..i tested that case..and working well.
>>>
>>>> 3. Why is irq disable needed when calling mmc_change_operation_mod=
e ?
>>>> If are we just using spin_lock ?
>>>
>>> that value is how we process the request, so i think that need spin=
_lock_irq().
>>> Well..spin_lock()? i think that..
>> if it can replace spin_lock, it is better to avoid using irq disble.
>> if surely needed, it should be explained.
>>
>>>
>>>> 4. When do we use host->pre_defined_op value after setting it ?
>>>
>>> Just the setting value..to show the value..any other opinion.
>>> If you have the other approach, i will change.
>> I didn't find this value usage in patch. if it is not using in this
>> patch and other elsewhere, plz remove it.
>
> Remove? it's sysfs node value..what do you use to show the value if r=
emoved that?
I found this usage in mmc_cmd23_show. sorry for the noise.

>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> Thanks.
>>>>
>>>> 2012/2/6 Jaehoon Chung <jh80.chung@samsung.com>:
>>>>> This patch is support the sysfs for operation mode.
>>>>>
>>>>> There are two operation modes(open-ended/pre-defined).
>>>>> Now, operation mode is selected only one at the compile time.
>>>>>
>>>>> But using this patch, we can change the operation mode with node =
at runtime.
>>>>>
>>>>> * pre-defined mode
>>>>> echo 1 > /sys/class/mmc_host/mmc0/pre_defined_op
>>>>> * open-ended mode
>>>>> echo 0 > /sys/class/mmc_host/mmc0/pre_defined_op
>>>>>
>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>> ---
>>>>> Changelog V4:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the explanation in Documentation=
/mmc/mmc-dev-attrs.txt
>>>>> Changelog V3:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the mmc_change_operation_mode()
>>>>> Changelog v2:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the check point in mmc_cmd23_sto=
re()
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(If host controller didn't support CMD=
23, need not to change the ops-mode.)
>>>>>
>>>>> =C2=A0Documentation/mmc/mmc-dev-attrs.txt | =C2=A0 16 +++++++++++=
+++
>>>>> =C2=A0drivers/mmc/card/block.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 19 +++++++++++++++++
>>>>> =C2=A0drivers/mmc/core/host.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 39 +++++++++++++++++++++++++++++++++++
>>>>> =C2=A0include/linux/mmc/card.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A01 +
>>>>> =C2=A0include/linux/mmc/host.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A03 ++
>>>>> =C2=A05 files changed, 78 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/=
mmc/mmc-dev-attrs.txt
>>>>> index 22ae844..e7ba3b6 100644
>>>>> --- a/Documentation/mmc/mmc-dev-attrs.txt
>>>>> +++ b/Documentation/mmc/mmc-dev-attrs.txt
>>>>> @@ -74,3 +74,19 @@ This attribute appears only if CONFIG_MMC_CLKG=
ATE is enabled.
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0clkgate_delay =C2=A0 Tune the clock ga=
ting delay with desired value in milliseconds.
>>>>>
>>>>> =C2=A0echo <desired delay> > /sys/class/mmc_host/mmcX/clkgate_del=
ay
>>>>> +
>>>>> +SD and MMC Operation Mode Attribute
>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> +
>>>>> +SD and MMC can support the two operation mode.
>>>>> +(Pre-defined(CMD23)/Open-ended operation mode)
>>>>> +
>>>>> +This attribute can change the operation mode at runtime if card =
is supported the CMD23.
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 pre_defined_op =C2=A0Support the pre-defin=
ed mode if set 1.
>>>>> +
>>>>> +1) Open-ended mode
>>>>> +echo 0 > /sys/class/mmc_host/mmcX/pre_defined_op
>>>>> +
>>>>> +2) Pre-defined mode
>>>>> +echo 1 > /sys/class/mmc_host/mmcX/pre_defined_op
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index a7c75d8..2c1981c 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -1766,6 +1766,25 @@ static const struct mmc_fixup blk_fixups[]=
 =3D
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0END_FIXUP
>>>>> =C2=A0};
>>>>>
>>>>> +void mmc_change_operation_mode(struct mmc_card *card, int val)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_blk_data *md =3D mmc_get_drvdat=
a(card);
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 if (mmc_host_cmd23(card->host)) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc_card_m=
mc(card) ||
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
(mmc_card_sd(card) &&
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0card->scr.cmds & SD_SCR_CMD23_SUPPORT)) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (val) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 md->flags |=3D MMC_BLK_CMD23;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->host->pre_defined_op =3D=
 val;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 } else {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 md->flags &=3D ~MMC_BLK_CMD23=
;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->host->pre_defined_op =3D=
 val;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>> + =C2=A0 =C2=A0 =C2=A0 }
>>>>> +}
>>>>> +
>>>>> =C2=A0static int mmc_blk_probe(struct mmc_card *card)
>>>>> =C2=A0{
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *md, *part_md;
>>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>>> index 30055f2..7dab0dc 100644
>>>>> --- a/drivers/mmc/core/host.c
>>>>> +++ b/drivers/mmc/core/host.c
>>>>> @@ -293,6 +293,41 @@ static inline void mmc_host_clk_sysfs_init(s=
truct mmc_host *host)
>>>>>
>>>>> =C2=A0#endif
>>>>>
>>>>> +static ssize_t mmc_cmd23_show(struct device *dev,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_=
attribute *attr, char *buf)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_host *host =3D cls_dev_to_mmc_h=
ost(dev);
>>>>> + =C2=A0 =C2=A0 =C2=A0 return snprintf(buf, PAGE_SIZE, "%d\n", ho=
st->pre_defined_op);
>>>>> +}
>>>>> +
>>>>> +static ssize_t mmc_cmd23_store(struct device *dev,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_=
attribute *attr, const char *buf, size_t count)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_host *host =3D cls_dev_to_mmc_h=
ost(dev);
>>>>> + =C2=A0 =C2=A0 =C2=A0 int value;
>>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 if (kstrtoint(buf, 0, &value))
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL=
;
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&host->lock, flags);
>>>>> + =C2=A0 =C2=A0 =C2=A0 mmc_change_operation_mode(host->card, valu=
e);
>>>>> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&host->lock, flags)=
;
>>>>> + =C2=A0 =C2=A0 =C2=A0 return count;
>>>>> +}
>>>>> +
>>>>> +static inline void mmc_host_cmd23_sysfs_init(struct mmc_host *ho=
st)
>>>>> +{
>>>>> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.show =3D mmc_cmd23_=
show;
>>>>> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.store =3D mmc_cmd23=
_store;
>>>>> + =C2=A0 =C2=A0 =C2=A0 sysfs_attr_init(&host->pre_defined_attr.at=
tr);
>>>>> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.attr.name =3D "pre_=
defined_op";
>>>>> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.attr.mode =3D S_IRU=
GO | S_IWUSR;
>>>>> + =C2=A0 =C2=A0 =C2=A0 if (device_create_file(&host->class_dev, &=
host->pre_defined_attr))
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: Fa=
iled to create pre_defined_op sysfs entry\n",
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_hostname(host));
>>>>> +}
>>>>> +
>>>>> =C2=A0/**
>>>>> =C2=A0* =C2=A0 =C2=A0 mmc_alloc_host - initialise the per-host st=
ructure.
>>>>> =C2=A0* =C2=A0 =C2=A0 @extra: sizeof private data structure
>>>>> @@ -381,6 +416,10 @@ int mmc_add_host(struct mmc_host *host)
>>>>> =C2=A0#endif
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_host_clk_sysfs_init(host);
>>>>>
>>>>> + =C2=A0 =C2=A0 =C2=A0 if (host->caps & MMC_CAP_CMD23)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->pre_defi=
ned_op =3D 1;
>>>>> + =C2=A0 =C2=A0 =C2=A0 mmc_host_cmd23_sysfs_init(host);
>>>>> +
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_start_host(host);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0register_pm_notifier(&host->pm_notify)=
;
>>>>>
>>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>>>> index 1a1ca71..b36d408 100644
>>>>> --- a/include/linux/mmc/card.h
>>>>> +++ b/include/linux/mmc/card.h
>>>>> @@ -489,5 +489,6 @@ extern void mmc_unregister_driver(struct mmc_=
driver *);
>>>>>
>>>>> =C2=A0extern void mmc_fixup_device(struct mmc_card *card,
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct mmc_fixup *table);
>>>>> +extern void mmc_change_operation_mode(struct mmc_card *card, int=
 val);
>>>>>
>>>>> =C2=A0#endif /* LINUX_MMC_CARD_H */
>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>> index 20d7c82..59a30bf 100644
>>>>> --- a/include/linux/mmc/host.h
>>>>> +++ b/include/linux/mmc/host.h
>>>>> @@ -259,6 +259,9 @@ struct mmc_host {
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP2_HS200_1_2V_SDR)
>>>>> =C2=A0#define MMC_CAP2_BROKEN_VOLTAGE =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(1 << 7) =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use the broken voltage */
>>>>>
>>>>> + =C2=A0 =C2=A0 =C2=A0 struct device_attribute pre_defined_attr;
>>>>> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pre_defined_op; /* CMD23 should be use =
or not */
>>>>> +
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_pm_flag_t =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pm_caps; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* supported pm features=
 */
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0=
power_notify_type;
>>>>> =C2=A0#define MMC_HOST_PW_NOTIFY_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
