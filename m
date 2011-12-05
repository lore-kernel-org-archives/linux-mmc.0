From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: remove unnecessary/dupulicated code
Date: Mon, 5 Dec 2011 23:33:42 +0900
Message-ID: <CAELcNGR=qV_0G8SK5dwH7jEthiyCpQRJqqhCGaoRECRv+3-pSg@mail.gmail.com>
References: <4EDC0D14.5080204@samsung.com>
	<000b01ccb303$148e84e0$3dab8ea0$%jun@samsung.com>
	<4EDC4607.3000102@samsung.com>
	<4EDC48A3.2020102@samsung.com>
	<000d01ccb30e$0201d3d0$06057b70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239Ab1LEOdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 09:33:43 -0500
Received: by eaak14 with SMTP id k14so4071662eaa.19
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2011 06:33:42 -0800 (PST)
In-Reply-To: <000d01ccb30e$0201d3d0$06057b70$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Seungwon

2011/12/5 Seungwon Jeon <tgih.jun@samsung.com>:
> Jaehoon Chung wrote:
>> And that flag didn't affect anywhere..in my case..
>>
>> If you know why use this flag, i don't remove this flag.
> For the external card detection, this flag indicates whether a card i=
s inserted or not.
> I found sdhci_do_set_ios() checks only "SDHCI_DEVICE_DEAD".
> That means it doesn't consider the case of internal CD's state.
> How about approaching the sdhci_do_set_ios() for your problem?
I didn't consider the case of CDn detect..
I will consider your opinion..
Thanks for your comment..

Best regards,
Jaehoon Chung
>
> Thanks,
> Seungwon Jeon.
>
>>
>> Thanks,
>> Jaehoon Chung
>>
>> On 12/05/2011 01:18 PM, Jaehoon Chung wrote:
>>
>> > Hi Seungwon
>> >
>> > On 12/05/2011 01:05 PM, Seungwon Jeon wrote:
>> >
>> >> Hi Jaehoon,
>> >>> This patch is just removed the unnecessary code.
>> >>>
>> >>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> >>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> >>> ---
>> >>> =A0drivers/mmc/host/sdhci-s3c.c | =A0 =A07 +------
>> >>> =A01 files changed, 1 insertions(+), 6 deletions(-)
>> >>>
>> >>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdh=
ci-s3c.c
>> >>> index b6558b8..ad0ef39 100644
>> >>> --- a/drivers/mmc/host/sdhci-s3c.c
>> >>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> >>> @@ -334,11 +334,9 @@ static void sdhci_s3c_notify_change(struct =
platform_device *dev, int state)
>> >>> =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> >>> =A0 =A0 =A0 =A0 =A0 if (state) {
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "card ins=
erted.\n");
>> >>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI_DEVICE=
_DEAD;
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIR=
K_BROKEN_CARD_DETECTION;
>> >>> =A0 =A0 =A0 =A0 =A0 } else {
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "card rem=
oved.\n");
>> >>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_DEVICE_=
DEAD;
>> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks &=3D ~SDHCI_QUI=
RK_BROKEN_CARD_DETECTION;
>> >>> =A0 =A0 =A0 =A0 =A0 }
>> >> Could you explain the reason of these remove?
>> >> SDHCI_DEVICE_DEAD flag is needed for external card detection
>> >> and is used in "sdhci.c".
>> >
>> >
>> > I didn't know why this flag is assigned
>> > I found that if this flag is set when card is removed,
>> > ENSDCLK bit in CLOCK control register is always set in sdhci_set_i=
os().
>> > If device dead, be skipped set_ios.
>> > (In my case, when i use SD clock-gating, this flag is problem.)
>> >
>> > Best regards,
>> > Jaehoon Chung
>> >
>> >>
>> >> Best regards,
>> >> Seungwon Jeon.
>> >>
>> >>> =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->card_tasklet);
>> >>> @@ -521,6 +519,7 @@ static int __devinit sdhci_s3c_probe(struct =
platform_device *pdev)
>> >>> =A0 if (pdata->cd_type =3D=3D S3C_SDHCI_CD_PERMANENT)
>> >>> =A0 =A0 =A0 =A0 =A0 host->mmc->caps =3D MMC_CAP_NONREMOVABLE;
>> >>>
>> >>> + /* It supports additional host capabilities if needed */
>> >>> =A0 if (pdata->host_caps)
>> >>> =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
>> >>>
>> >>> @@ -543,10 +542,6 @@ static int __devinit sdhci_s3c_probe(struct=
 platform_device *pdev)
>> >>> =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_max_clock =3D sdhci_cmu_ge=
t_max_clock;
>> >>> =A0 }
>> >>>
>> >>> - /* It supports additional host capabilities if needed */
>> >>> - if (pdata->host_caps)
>> >>> - =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
>> >>> -
>> >>> =A0 ret =3D sdhci_add_host(host);
>> >>> =A0 if (ret) {
>> >>> =A0 =A0 =A0 =A0 =A0 dev_err(dev, "sdhci_add_host() failed\n");
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc" in
>> >>> the body of a message to majordomo@vger.kernel.org
>> >>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>> >>
>> >>
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
