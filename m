From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/12] mmc: sdhci: add a pre voltage switch callback
 function
Date: Tue, 14 Jun 2016 10:07:06 +0300
Message-ID: <575FAD1A.6090407@intel.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-6-git-send-email-gregory.clement@free-electrons.com>
 <575E72DC.5090604@intel.com>
 <D7CF8A19-9181-4A97-90AF-AC5A6517CE2B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D7CF8A19-9181-4A97-90AF-AC5A6517CE2B-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 13/06/16 17:04, Ziji Hu wrote:
> Hi Adrian,
>=20
> Thanks a lot for the suggestion. I'm from Marvell Xenon SDHC team. Mo=
st
> of sdhci host ops are still used in our driver. We just change or add=
 few
> ops. Thus, if we create our own mmc_host_ops, many static sdhci host =
ops
> will be exported. I would like to know whether such a modification ca=
n be
> accepted or not.
>=20
> I notice that community is improving sdhci. Thus all the static sdhci=
 ops
> called outside the sdhci.c will be exported. Is my understanding
> correct? Thank you.

The aim is to make sdhci more like a library and give more control to t=
he
drivers.  That will mean more sdhci functions get exported, particularl=
y mmc
host ops like sdhci_set_ios() or sdhci_start_signal_voltage_switch().

>=20
> Best regards, Hu Ziji
>=20
>>> =D4=DA 2016=C4=EA6=D4=C213=C8=D5=A3=AC16:52=A3=ACAdrian Hunter <adr=
ian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> =D0=B4=B5=C0=A3=BA
>>>=20
>>> On 09/06/16 10:10, Gregory CLEMENT wrote: From: Victor Gu
>>> <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>>=20
>>> Some host controller such as Xenon needs additional setting when=20
>>> switching signal voltage in eMMC mode. They also need to re-enable=20
>>> internal clock before a voltage switch.
>>>=20
>>> This commit adds a callback routine "voltage_switch_pre" in the
>>> struct sdhci_ops, which is used by some host controllers which need
>>> re-enable the internal clock before a voltage switch.
>>=20
>> Don't want to add sdhci host ops for the "do something before a mmc
>> host op" case.
>>=20
>> Instead, export sdhci_start_signal_voltage_switch() and  hook=20
>> host->mmc_host_ops.start_signal_voltage_switch. Then in sdhci-xenon.=
c:
>>=20
>> int xenon__start_signal_voltage_switch(struct mmc_host *mmc, struct
>> mmc_ios *ios) { blah blah return sdhci_start_signal_voltage_switch(m=
mc,
>> ios); }
>>=20
>>=20
>>>=20
>>> [gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: split the initial commit and=20
>>> reformulate the log]
>>>=20
>>> Signed-off-by: Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> Signed-off-by: Marcin
>>> Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org> Signed-off-by: Gregory CLEMENT
>>> <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> --- drivers/mmc/host/sdhci.c |=
 4
>>> ++++ drivers/mmc/host/sdhci.h | 1 + 2 files changed, 5 insertions(+=
)
>>>=20
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c=20
>>> index b07219426d39..cad03ffa9d9b 100644 ---
>>> a/drivers/mmc/host/sdhci.c +++ b/drivers/mmc/host/sdhci.c @@ -1729,=
6
>>> +1729,10 @@ static int sdhci_start_signal_voltage_switch(struct
>>> mmc_host *mmc, if (host->version < SDHCI_SPEC_300) return 0;
>>>=20
>>> +    /* Some controller need to do more before switching */ +    if
>>> (host->ops->voltage_switch_pre) +
>>> host->ops->voltage_switch_pre(host); + ctrl =3D sdhci_readw(host,
>>> SDHCI_HOST_CONTROL2);
>>>=20
>>> switch (ios->signal_voltage) { diff --git a/drivers/mmc/host/sdhci.=
h
>>> b/drivers/mmc/host/sdhci.h index 49c6c5b0e33b..6bec1b0368d2 100644=20
>>> --- a/drivers/mmc/host/sdhci.h +++ b/drivers/mmc/host/sdhci.h @@
>>> -550,6 +550,7 @@ struct sdhci_ops { unsigned int max_dtr, int
>>> host_drv, int card_drv, int *drv_type); void    (*init_card)(struct
>>> sdhci_host *host, struct mmc_card *card); +    void
>>> (*voltage_switch_pre)(struct sdhci_host *host); };
>>>=20
>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>=20
>> -- To unsubscribe from this list: send the line "unsubscribe linux-m=
mc"
>> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
