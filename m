From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Mon, 30 May 2011 03:42:34 -0400
Message-ID: <BANLkTinZgqzX3rvmUg0M=H_3RZhHyygO_g@mail.gmail.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
	<201105300911.54084.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51812 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab1E3Hmf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 03:42:35 -0400
Received: by vxi39 with SMTP id 39so2490897vxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 00:42:34 -0700 (PDT)
In-Reply-To: <201105300911.54084.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, May 30, 2011 at 3:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 30 May 2011 07:42:04 zhangfei gao wrote:
>> On Fri, May 27, 2011 at 11:46 AM, Arnd Bergmann <arnd@arndb.de> wrot=
e:
>> > On Wednesday 25 May 2011, Zhangfei Gao wrote:
>> >> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>> >> +{
>> >> + =A0 =A0 /* Micro SD does not support write-protect feature */
>> >> + =A0 =A0 return 0;
>> >> +}
>> >
>> > You shouldn't need to provide an empty get_ro function, the
>> > default is that there is no write-protect.
>>
>> Thanks Arnd for review.
>> The reason to put get_ro here is some board use micro sd, while some
>> board design is general sd card.
>> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT wil=
l
>> return 1 in our controller, so it shows read only.
>> So add one call back for the board with micro sd card via flag.
>
> Ok, I see.
>
>> >> + =A0 =A0 pxa =3D kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>> >> + =A0 =A0 if (!pxa) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >> + =A0 =A0 pxa->ops =3D kzalloc(sizeof(struct sdhci_ops), GFP_KERN=
EL);
>> >> + =A0 =A0 if (!pxa->ops) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> + =A0 =A0 }
>> >
>> > I think you really shouldn't allocate the sdhci_ops dynamically.
>> > In fact, it would be much better if we were able to mark them
>> > as const in all drivers.
>>
>> We found some issues when supporting multi-slot, each slot may have
>> different ops.
>> So use the method of allocating the sdhci_ops dynamically instead of
>> using static ops.
>> For example, emmc has 74_clocks call back, while mmc and sdio slot
>> does not have such ops.
>> If not dynamically allocate sdhci_ops, all slot ops may become same,
>> and 74_clocks may be called for every slot.
>> Also, some board may have get_ro, while other board may not, so
>> transfer the ops via flags.
>>
>> Not sure whether it is worthy to add additional common files to shar=
e
>> probe and remove function.
>> Also the init the ops part are different.
>
> IMHO, we should try much harder to keep the ops constant. For the
> two examples you gave, I would probably put a flag into private data =
for
> the get_ro operation to signify that it's never read-only, and provid=
e
> a second set of operations for emmc, so that in the probe function
> you check the type of device and then set the appropriate one.
>
> You could also do the same for all three cases:
>
> =A0 =A0 =A0 =A0if (emmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D &sdhci_mmp2_emmc_ops;
> =A0 =A0 =A0 =A0else if (!has_ro_switch)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D &sdhci_mmp2_rw_ops;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops =3D &sdhci_mmp2_default_ops;

Thanks, will take this method to make the ops constant.

>
>> >> +
>> >> +#ifdef CONFIG_PM
>> >> +static int sdhci_mmp2_suspend(struct platform_device *dev, pm_me=
ssage_t state)
>> >> +{
>> >> + =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> >> +
>> >> + =A0 =A0 return sdhci_suspend_host(host, state);
>> >> +}
>> >> +
>> >> +static int sdhci_mmp2_resume(struct platform_device *dev)
>> >> +{
>> >> + =A0 =A0 struct sdhci_host *host =3D platform_get_drvdata(dev);
>> >> +
>> >> + =A0 =A0 return sdhci_resume_host(host);
>> >> +}
>> >> +#else
>> >> +#define sdhci_mmp2_suspend =A0 NULL
>> >> +#define sdhci_mmp2_resume =A0 =A0NULL
>> >> +#endif
>> >
>> > Similarly, I think it would be good if sdhci-pltfm.c would simply
>> > export these functions so you could refer to them in your driver.
>> > There is no need to have identical copies in each variant.
>> >
>>
>> There are some additional code for suspend and resume, so
>> sdhci_pltfm_suspend may not enough.
>> For example, when enable wifi host sleep feature, additional registe=
r
>> have to be configured.
>
> Well, not all drivers would have to use the common functions, but
> right now there are a number of identical copies, so it's certainly
> worth sharing.

Then we use sdhci_pltfm_suspend first, and change to private suspend &
resume when supporting additional feature.

>
> Note that this comment wasn't directed at your patch as much as at
> the overall design of the sdhci sub-drivers.
>
> =A0 =A0 =A0 =A0Arnd
>
