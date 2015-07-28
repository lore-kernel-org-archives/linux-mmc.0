From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
Date: Tue, 28 Jul 2015 07:46:18 +0200
Message-ID: <55B7172A.5070408@monstr.eu>
References: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
 <55B5EA96.6020604@monstr.eu> <55B6D5C2.4080907@rock-chips.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9s72EFluCXeqmBCbW3sF6GPCJNcGATeBU"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38743 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbG1FqW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jul 2015 01:46:22 -0400
Received: by wibxm9 with SMTP id xm9so144235287wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2015 22:46:20 -0700 (PDT)
In-Reply-To: <55B6D5C2.4080907@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9s72EFluCXeqmBCbW3sF6GPCJNcGATeBU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2015 03:07 AM, Shawn Lin wrote:
> On 2015/7/27 16:23, Michal Simek wrote:
>> On 07/27/2015 10:04 AM, Shawn Lin wrote:
>>> This patch adds the interface to get quirks from dts, and
>>> there is no need to assign different quirks by condition statement
>>> of arasan IP version.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>>   drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>> index ef5a7d2..db07788 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops,=

>>> sdhci_arasan_suspend,
>>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>>   {
>>>       int ret;
>>> +    u32 quirktab[2];
>>>       struct clk *clk_xin;
>>>       struct sdhci_host *host;
>>>       struct sdhci_pltfm_host *pltfm_host;
>>> @@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct
>>> platform_device *pdev)
>>>           goto clk_disable_all;
>>>       }
>>>   +    if (of_property_read_u32_array(pdev->dev.of_node,
>>> +                       "arasan,quirks", &quirktab[0], 2)) {
>> This is not documented anywhere that's why you should send binding to =
DT
>> mailing list and get ACK for it.
> Thanks, Michal. You'r right, and  forgive me, a green hand, for my
> inappropriate patch.
>>> +        host->quirks |=3D quirktab[0];
>>> +        host->quirks2 |=3D quirktab[1];
>>> +    }
>>> +
>>>       if (of_device_is_compatible(pdev->dev.of_node,
>>> "arasan,sdhci-4.9a")) {
>>>           host->quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;
>>>           host->quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;
>>>
>> Also is there any binding which is done in this way?
> Thanks.
> BTW:
> I got a FPGA board w/ a sdhci-arasn emmc controller & PHY IP which can
> support emmc version 5.1.
> But I cannot find any documented details from  IP databook for the
> vendor version, such as "sdhci-4.9a".
> The only one is "ACS eMMC5.1 PHY IP uses TSMC ESD I/O protection
> structures TMSC  product name
> tphn28hpcgv2od3 Version 120a". Is "sdhci-120a" the version if  I add a
> compatib node?
> Kindly hope you can elaborate more =EF=BC=9A)

Is this xilinx board? If you look at TRM we have 8.9a arasan IP on Zynq
that's why we are using this compatible string. If you have different IP
version on your board feel free to extend compatible list and add
specific features for this IP.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--9s72EFluCXeqmBCbW3sF6GPCJNcGATeBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlW3FyoACgkQykllyylKDCF+QQCaA2EvKem8sUEv40Di8ibAlMb2
Q8IAnRvkqdiKgqbSn/sU5H6acRlSepwI
=JvcE
-----END PGP SIGNATURE-----

--9s72EFluCXeqmBCbW3sF6GPCJNcGATeBU--
