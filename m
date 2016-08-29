From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v2] mmc: sdhci-brcmstb: Remove incorrect capability
Date: Mon, 29 Aug 2016 21:01:47 +0900
Message-ID: <FBE78AC0-851A-45D4-AD4D-97BF045F5028@gmail.com>
References: <20160829091707.78436-1-jaedon.shin@gmail.com> <CAPDyKFp=rX8J0K=6pQFv3Wm=UfUVCX5cPyJPqHKeYm3075OLSQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34210 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756705AbcH2MCP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 08:02:15 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so8900833pac.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2016 05:01:53 -0700 (PDT)
In-Reply-To: <CAPDyKFp=rX8J0K=6pQFv3Wm=UfUVCX5cPyJPqHKeYm3075OLSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaedon Shin <jaedon.shin@gmail.com>, Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

Hi Ulf,

2016. 8. 29., =EC=98=A4=ED=9B=84 8:13, Ulf Hansson =
<ulf.hansson@linaro.org> =EC=9E=91=EC=84=B1:
>=20
> On 29 August 2016 at 11:17, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Removes incorrect 64-bit ADMA capability on Broadcom MIPS based SoCs.
>> The MIPS based BRCMSTB SDHCI host controllers are using ADMA only, =
but
>> the several chipsets have a incorrect capability about ADMA 64-bit.
>>=20
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> drivers/mmc/host/sdhci-brcmstb.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/mmc/host/sdhci-brcmstb.c =
b/drivers/mmc/host/sdhci-brcmstb.c
>> index cce10fe3e19e..683bfc2af512 100644
>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>> @@ -98,6 +98,8 @@ static int sdhci_brcmstb_probe(struct =
platform_device *pdev)
>>         * properties through mmc_of_parse().
>>         */
>>        host->caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
>> +       if (IS_ENABLED(CONFIG_MIPS))
>=20
> I thought we agreed on using a specific DT compatible string to
> distinguish what to do here was better? No?

My mistake. please drop this patch.

The v3 patch should have new compatible string =E2=80=9Cbrcm,bcm7445-sdhci=
=E2=80=9D. The BCM7445 is
initial and typical 28nm generation ARM SoC. I=E2=80=99ll be send =
updated patch next day.

Thanks,
Jaedon

>=20
>> +               host->caps &=3D ~SDHCI_CAN_64BIT;
>>        host->caps1 =3D sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>        host->caps1 &=3D ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 =
|
>>                        SDHCI_SUPPORT_DDR50);
>> --
>> 2.9.3
>>=20
>=20
> Kind regards
> Uffe

