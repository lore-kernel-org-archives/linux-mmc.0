From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] sdhci-s3c: Add SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk
	for Samsung SoC
Date: Fri, 11 Jun 2010 17:18:42 +0900
Message-ID: <AANLkTilyfUvwRUP1M1HD5r_cx3PWxDG9SbmqZd6M1MT1@mail.gmail.com>
References: <1276169991-16396-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTim2LzIh7dadCAWCo6jltS4CYA8gLKaiQne_VzqK@mail.gmail.com>
	<003901cb093d$3dd14110$b973c330$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <003901cb093d$3dd14110$b973c330$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Lee Hyuk <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 11, 2010 at 5:08 PM, Kukjin Kim <kgene.kim@samsung.com> wro=
te:
> Kyungmin Park wrote:
>>
>> Hi,
>>
>> On Thu, Jun 10, 2010 at 8:39 PM, Kukjin Kim <kgene.kim@samsung.com> =
wrote:
>> > From: Lee Hyuk <hyuk1.lee@samsung.com>
>> >
>> > On Samsung's SDMMC hosts the timeout clock is derivied from the SD
>> > Clock, which is set dynamically.
>> > So, checked 'SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK' quirk and remove=
d
>> > 'sdhci_s3c_get_timeout_clk' callback which doesn't need any more.
>> >
>> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> > ---
>> > =A0drivers/mmc/host/sdhci-s3c.c | =A0 10 +++-------
>> > =A01 files changed, 3 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci=
-s3c.c
>> > index af21792..ca09382 100644
>> > --- a/drivers/mmc/host/sdhci-s3c.c
>> > +++ b/drivers/mmc/host/sdhci-s3c.c
>> > @@ -110,11 +110,6 @@ static unsigned int sdhci_s3c_get_max_clk(str=
uct
>> sdhci_host *host)
>> > =A0 =A0 =A0 =A0return max;
>> > =A0}
>> >
>> > -static unsigned int sdhci_s3c_get_timeout_clk(struct sdhci_host *=
host)
>> > -{
>> > - =A0 =A0 =A0 return sdhci_s3c_get_max_clk(host) / 1000000;
>> > -}
>> > -
>> > =A0/**
>> > =A0* sdhci_s3c_consider_clock - consider one the bus clocks for cu=
rrent
> setting
>> > =A0* @ourhost: Our SDHCI instance.
>> > @@ -188,7 +183,6 @@ static void sdhci_s3c_set_clock(struct sdhci_h=
ost
> *host,
>> unsigned int clock)
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ourhost->cur_clk =3D best_src;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->max_clk =3D clk_get_rate(clk)=
;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D sdhci_s3c_get_=
timeout_clk(host);
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl =3D readl(host->ioaddr + S3C_S=
DHCI_CONTROL2);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~S3C_SDHCI_CTRL2_SELBASEC=
LK_MASK;
>> > @@ -211,7 +205,6 @@ static void sdhci_s3c_set_clock(struct sdhci_h=
ost
> *host,
>> unsigned int clock)
>> >
>> > =A0static struct sdhci_ops sdhci_s3c_ops =3D {
>> > =A0 =A0 =A0 =A0.get_max_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_get=
_max_clk,
>> > - =A0 =A0 =A0 .get_timeout_clock =A0 =A0 =A0=3D sdhci_s3c_get_time=
out_clk,
>> > =A0 =A0 =A0 =A0.set_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c=
_set_clock,
>> > =A0};
>> >
>> > @@ -335,6 +328,9 @@ static int __devinit sdhci_s3c_probe(struct
>> platform_device *pdev)
>> > =A0 =A0 =A0 =A0host->quirks |=3D (SDHCI_QUIRK_32BIT_DMA_ADDR |
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_QUIRK_32BIT_=
DMA_SIZE);
>> >
>> > + =A0 =A0 =A0 /* HSMMC on Samsung SoCs uses SDCLK as timeout clock=
=2E */
>> > + =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCL=
K;
>>
>> How do you know Samsung SoCs use SDCLK in the spec?
>>
> Samsung SoC hardware engineer guided about that.

Of course H/W team know it. they made it. I mean how can we know it at =
Spec?

If MMC developer don't know the samsung socs well, then how to set it
quirk from Spec.

Thank you,
Kyungmin Park

>
>> Is it also true at s3c64xx series?
>>
> Yes, of course.
>
>
>
>>
>> > +
>> > =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
>> > =A0 =A0 =A0 =A0if (ret) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_add_host() fail=
ed\n");
>> > --
>> > 1.6.2.5
>> >
>> > --
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
