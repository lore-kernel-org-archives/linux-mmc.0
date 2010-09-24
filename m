From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v3 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Fri, 24 Sep 2010 22:01:48 +0530
Message-ID: <AANLkTim0Qm=x3vVuT26oSNzTg+BZV+KCAJj5oVs3etWD@mail.gmail.com>
References: <14833.10.24.255.18.1285173812.squirrel@dbdmail.itg.ti.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F57C548@dlee03.ent.ti.com>
	<AANLkTikLqi4=OOJ_ciMqTt7HKJzDo-WsZJ8D2CpP712c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTikLqi4=OOJ_ciMqTt7HKJzDo-WsZJ8D2CpP712c@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Hari,


On Thu, Sep 23, 2010 at 11:22 AM, kishore kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> Hi Hari,
>
> On Thu, Sep 23, 2010 at 1:19 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrot=
e:
>> Kishore,
>>
>>> +int twl6030_mmc_card_detect(struct device *dev, int slot)
>>> +{
>>> + =A0 =A0 int ret =3D -EIO;
>>> + =A0 =A0 u8 read_reg =3D 0;
>>> + =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);
>>> +
>>> + =A0 =A0 switch (pdev->id) {
>>> + =A0 =A0 case 0:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* BIT0 of REG_MMC_CTRL
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0 - Card not present ,1 - Card present
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &=
read_reg,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_MMCCTRL);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read_reg & STS_MMC;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> nitpick: may be you don't need a switch statement for only one case.
>
> From future perspective,since there are 5 MMC controllers on OMAP4
> and current patch supports card detect feature only for one controller i.=
e MMC1
> as of now. Once the interfaces connected on the remaining 4 MMC controlle=
rs
> are defined further additions will be required for respective cases.


Correcting my previous comment, I've just verified twl6030 current
version spec on OMAP4
which can provide card detect interrupt only for one MMC controller i.e MMC=
1.
I will replace switch with if.

Regards,
Kishore
