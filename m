Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEADC43334
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jul 2022 02:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiGZC4a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiGZC43 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2022 22:56:29 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFA240AA
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jul 2022 19:56:26 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220726025621epoutp01a12936df2202768529acdebb26c2354e~FQZ0r6vm-0579605796epoutp01a
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 02:56:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220726025621epoutp01a12936df2202768529acdebb26c2354e~FQZ0r6vm-0579605796epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658804181;
        bh=voQe5EppwtncuTSCtO3UcfuBK91t76NFRcueqnvLyiE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=YB1X93n1+IUFwizALkIUzWYN0WIWJKk+WTStnrX8vedCU/XBORTJGSquFXCjgkXJh
         k6kqL7+apYM9GFzY2k+3Ne9JNfFQvwnbxJfxLVARScy0+rVFF3MmsSxlChEReZsrz8
         QHLslmEwaN3dKPKrkh4WQFrdjZiphmur/b+eIIjg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220726025620epcas1p32eefdfd569ec57c5d3a65420fe4d36df~FQZ0KxBZd3084330843epcas1p3o;
        Tue, 26 Jul 2022 02:56:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LsM4N19lfz4x9Ps; Tue, 26 Jul
        2022 02:56:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.B6.09661.4D75FD26; Tue, 26 Jul 2022 11:56:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220726025619epcas1p4a491f4db1c4861fec894883fc152d3b4~FQZzkjrgJ2870428704epcas1p4Z;
        Tue, 26 Jul 2022 02:56:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220726025619epsmtrp1f35e838afbfa597980377a930b2b949b~FQZzj__vZ0619506195epsmtrp1R;
        Tue, 26 Jul 2022 02:56:19 +0000 (GMT)
X-AuditID: b6c32a37-2cfff700000025bd-9e-62df57d4d485
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.6A.08802.3D75FD26; Tue, 26 Jul 2022 11:56:19 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220726025619epsmtip230c14ee0069061228a39adfc3d0bfdfc~FQZzavcHf3083530835epsmtip2V;
        Tue, 26 Jul 2022 02:56:19 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <adrian.hunter@intel.com>
Cc:     "'DooHyun Hwang'" <dh0421.hwang@samsung.com>
In-Reply-To: <20220721055924.9043-1-sh043.lee@samsung.com>
Subject: RE: [PATCH] mmc: sd: Remove the patch that fix signal voltage when
 there is no power cycle
Date:   Tue, 26 Jul 2022 11:56:19 +0900
Message-ID: <001901d8a09b$480bfd70$d823f850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpt5FcOhFG+N8hh+VoMjV22ziL8QIcZ0v4rNzfJiA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmnu6V8PtJBsua2CxOPlnDZrHv2kl2
        iyP/+xktjq8Nd2DxWLznJZPHnWt72Dz6tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO+PUuXVMBbt9Ki7cusXawPjWtouR
        g0NCwERi7hnTLkYuDiGBHYwSW39dYYdwPjFKbJzQxwjhfGaUaH0/jwWmo/m2BER8F6PE7GO3
        WCGcF4wSP09OACri5GAT0JF48+k/K0iDiECYRNdyb5Aws4CBxJObu8FKOAWsJNY2dYHZwgKp
        ErennGQFsVkEVCXmTpnHCNLKK2Ap8fwrWCuvgKDEyZlPWCDGaEssW/iaGcSWEFCQ+Pl0GVir
        CNDI1Q+OM0HUiEjM7mxjBjlNQuAnu8TlD0cYIRpcJObPWA9lC0u8Or6FHcKWknjZ3wZlF0u0
        /fsHtaBC4mDfFyjbWOLT589gtzELaEqs36UPEVaU2Pl7LiPEXj6Jd197WCFBxSvR0SYEUaIs
        8fLRMiYIW1JiSfst5gmMSrOQfDYLyWezkHwwC2HZAkaWVYxiqQXFuempxYYFxvCYTs7P3cQI
        Tola5jsYp739oHeIkYmD8RCjBAezkghvV9rtJCHelMTKqtSi/Pii0pzU4kOMpsCgnsgsJZqc
        D0zKeSXxhiaWBiZmRiYWxpbGZkrivKumnU4UEkhPLEnNTk0tSC2C6WPi4JRqYLIWiJl/oODh
        gtxYORbviBjTjwvaIn9wHnH4feH7qhdT/f0nvufPfRKS1aG28Lea3JINX4J/7si8culBcJqJ
        d+ZKB2aOwjbPSM4z90IDf08qcVlxgqX5vf0C3f+lr7YGp+zSdzVfefXffEO5Rj25oosye358
        9AxXja84nDRt2aV6raLzK+dzGt1ckXMrZFvojI8Lln5KXRG6+s/Wg64eu3vDVj8Kvtj258Lp
        CUseqx4I2mI3+c+shV1pVSWp3j8cOVx2tWdJLFvL275byEo8qi741WW+a/a3lq554KPBod49
        q9foSObJuFUeDqobnvAsNQnexVPFtqlhwkThyXn+ed9NnPv3Lhbfyp1aL1a9xFiJpTgj0VCL
        uag4EQB5+p8REgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO7l8PtJBosaDSxOPlnDZrHv2kl2
        iyP/+xktjq8Nd2DxWLznJZPHnWt72Dz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEr4/kf94IP
        HhWrPmxmbGBcY9XFyMEhIWAi0XxboouRi0NIYAejxIeHFxi7GDmB4pISix89ZIOoEZY4fLgY
        ouYZo8TH9c+YQWrYBHQk3nz6zwpSIyIQITHxbT1ImFnAQOLJzd0sEPXdjBKnN51jA0lwClhJ
        rG3qYgGxhQWSJe5N6GAFsVkEVCXmTpnHCDKHV8BS4vlXb5Awr4CgxMmZT1ggZmpL9D5sZYSx
        ly18zQxxpoLEz6fLwMaIAI1f/eA4E0SNiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1
        oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4OrS0djDuWfVB7xAjEwfjIUYJDmYlEd6utNtJ
        QrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAFaHaYO60+
        +3G9rNbVr0oHlLbeizX9vs9Wm+EXz67lS0K23uDtNP6bO2GHluNU3acm2sWzpPZfjrOYXF2+
        5cmnPd9OyGx4O3/Bacvq/EfXjXfWv1ystvyRWItmy/Ut2lu+nJ9t2aQlHP7yoBb76uJSuWWP
        0vbpCE0901BomXj1/EIb7aOswYFOeiHRVb4LWnRn3bzLN1/F7nrB0TMXHj5IEJV7dZ196oOr
        X/T/cpRvyuWbWZ136uMJtWMzF5ZX6cYzLuvnFS34M3ViTGl5+NR5wqFz7igGr9m23Z/zsP/J
        i1ULtHatV3I0cd00rXjm9dQfmVwbLS+Hr1zytX6LLV/K//CTZhLKcX84NB7f7jrArMRSnJFo
        qMVcVJwIADV6qMn9AgAA
X-CMS-MailID: 20220726025619epcas1p4a491f4db1c4861fec894883fc152d3b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc
References: <CGME20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc@epcas1p4.samsung.com>
        <20220721055924.9043-1-sh043.lee@samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Seunghui Lee <sh043.lee=40samsung.com>
> Sent: Thursday, July 21, 2022 2:59 PM
> To: ulf.hansson=40linaro.org; linux-mmc=40vger.kernel.org;
> adrian.hunter=40intel.com
> Cc: Seunghui Lee <sh043.lee=40samsung.com>; DooHyun Hwang
> <dh0421.hwang=40samsung.com>
> Subject: =5BPATCH=5D mmc: sd: Remove the patch that fix signal voltage wh=
en
> there is no power cycle
>=20
> At first, all error flow of mmc_set_uhs_voltage() has power cycle except
> R1_ERROR and no start_signal_voltage_switch() func pointer.
>=20
> There is the performance regression issue of SDR104 SD card from the
> market VOC. Normally, once a SDR104 SD card fails to switch voltage, it
> works HS mode.
> And then it initializes SDR104 mode after system resume or error handling=
.
>=20
> However, with below patch,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/
> drivers/mmc/core/sd.c?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
> Once a SD card does, it initializes SDR25 mode forever after system resum=
e
> or error handling(re-initialized).
> Host updates sd3_bus_mode by calling mmc_read_switch(), the value of
> sd3_bus_mode doesn't set for SDR104, SDR50 and DDR50 mode.
>=20
> So, if host doesn't update sd3_bus_mode, the SD card works SDR104 mode
> after system resume or error-handling.
>=20
> Here is an example.
>=20
> AS-IS : test log
> // normal case : sd3_bus_mode =3D 0x1F, sd_bus_speed =3D SDR104, clock 20=
8MHz
> =5B  111.907789=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D mmc_sd_init_c=
ard: 1119:
> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false, signal_vo=
ltage
> =3D0x1.
> =5B  111.907824=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D mmc_sd_init_c=
ard: 1149: rocr
> 0xc1ff8000, S18A, uhs.
> =5B  111.908707=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D sd_update_bus=
_speed_mode:
> caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card->ocr =3D
> 0x40000.
> =5B  111.912484=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D sd_set_bus_sp=
eed_mode:
> sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D0x4000=
0.
> // resume : issue occurs : SDcard doesn't release busy for checking 10
> times
> =5B  112.096550=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1040:
> card->ocr 0x40000.
> =5B  112.096560=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_get_ci=
d: ocr
> 0x40000(pocr 0x40000), retries 10.
> ...
> =5B  114.531129=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_power_cyc=
le.
> =5B  114.579500=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_get_ci=
d: ocr
> 0x41040000(pocr 0x40000), retries 0.
> =5B  114.579506=5D =5B5:    kworker/5:2:  207=5D mmc0: Skipping voltage s=
witch
> =5B  114.757575=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1119:
> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false, signal_vo=
ltage
> =3D0x0.
> =5B  114.757583=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1128:
> switch with oldcard.
> =5B  114.759742=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_read_swit=
ch: sd_switch
> ret 0, sd3_bus_mode=3D3.
> // sd3_bus_mode =3D 0x3 supports HS, SDR25 and SDR12
> =5B  114.759750=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1157:
> switch hs.
> // next resume : the SDcard initializes to SDR25(HS) mode(sd_bus_speed =
=3D 1)
> by sd3_bus_mode setting with clk 50MHz
> =5B  114.968346=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1040:
> card->ocr 0x40000.
> =5B  114.968359=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_get_ci=
d: ocr
> 0x40000(pocr 0x40000), retries 10.
> =5B  115.167346=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1119:
> caps=3D0x407f020f, sd3_bus_mode=3D0x3, v18_fixup_failed false, signal_vol=
tage
> =3D0x1.
> =5B  115.167366=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_c=
ard: 1149: rocr
> 0xc1ff8000, S18A, uhs.
> =5B  115.168041=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_init_u=
hs_card: before
> update: caps 0x407f020f, sd3_bus_mode =3D 3, sd_bus_speed =3D 3, card->oc=
r =3D
> 0x40000.
> =5B  115.168051=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D sd_update_bus=
_speed_mode:
> caps 0x407f020f, sd3_bus_mode =3D 3, sd_bus_speed =3D 1, card->ocr =3D 0x=
40000.
> =5B  115.169176=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D sd_set_bus_sp=
eed_mode:
> sd_bus_speed=3D1, timing=3D4, uhs_max_dtr=3D50000000, card->ocr=3D0x40000=
.
>=20
> TO-BE : TEST log with this commit
> // resume : issue occurs : SDcard doesn't release busy for checking 10
> times
> =5B 1843.594805=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_get_ci=
d: ocr
> 0x41040000(pocr 0x40000), retries 0.
> =5B 1843.594812=5D =5B4:    kworker/4:5:21512=5D mmc0: Skipping voltage s=
witch
> =5B 1843.772555=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_init_c=
ard: 1122:
> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false, signal_vo=
ltage
> =3D0x0.
> // no update sd3_bus_mode value
> =5B 1843.772563=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_init_c=
ard: 1164:
> switch hs.
> // next resume : the SDcard initializes to SDR104
> =5B 1844.191295=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_init_c=
ard: 1122:
> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false, signal_vo=
ltage
> =3D0x1.
> =5B 1844.191315=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_init_c=
ard: 1154:
> rocr 0xc1ff8000, S18A, uhs.
> =5B 1844.192175=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_init_u=
hs_card:
> before update: caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3=
,
> card->ocr =3D 0x40000.
> =5B 1844.192187=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D sd_update_bus=
_speed_mode:
> caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card->ocr =3D
> 0x40000.
> =5B 1844.198697=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D sd_set_bus_sp=
eed_mode:
> sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D0x4000=
0.
>=20
> Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> Tested-by: DooHyun Hwang <dh0421.hwang=40samsung.com>
> ---
>  drivers/mmc/core/sd.c =7C 47 ++-----------------------------------------
>  1 file changed, 2 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> cee4c0b59f43..4e3d39956185 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> =40=40 -1001,18 +1001,6 =40=40 unsigned mmc_sd_get_max_clock(struct mmc_c=
ard *card)
>  	return max_dtr;
>  =7D
>=20
> -static bool mmc_sd_card_using_v18(struct mmc_card *card) -=7B
> -	/*
> -	 * According to the SD spec., the Bus Speed Mode (function group 1)
> bits
> -	 * 2 to 4 are zero if the card is initialized at 3.3V signal level.
> Thus
> -	 * they can be used to determine if the card has already switched
> to
> -	 * 1.8V signaling.
> -	 */
> -	return card->sw_caps.sd3_bus_mode &
> -	       (SD_MODE_UHS_SDR50 =7C SD_MODE_UHS_SDR104 =7C SD_MODE_UHS_DDR50)=
;
> -=7D
> -
>  static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8 page, u16
> offset,
>  			    u8 reg_data)
>  =7B
> =40=40 -1400,10 +1388,9 =40=40 static int mmc_sd_init_card(struct mmc_hos=
t *host,
> u32 ocr,
>  	int err;
>  	u32 cid=5B4=5D;
>  	u32 rocr =3D 0;
> -	bool v18_fixup_failed =3D false;
>=20
>  	WARN_ON(=21host->claimed);
> -retry:
> +
>  	err =3D mmc_sd_get_cid(host, ocr, cid, &rocr);
>  	if (err)
>  		return err;
> =40=40 -1472,36 +1459,6 =40=40 static int mmc_sd_init_card(struct mmc_hos=
t *host,
> u32 ocr,
>  	if (err)
>  		goto free_card;
>=20
> -	/*
> -	 * If the card has not been power cycled, it may still be using
> 1.8V
> -	 * signaling. Detect that situation and try to initialize a UHS-I
> (1.8V)
> -	 * transfer mode.
> -	 */
> -	if (=21v18_fixup_failed && =21mmc_host_is_spi(host) &&
> mmc_host_uhs(host) &&
> -	    mmc_sd_card_using_v18(card) &&
> -	    host->ios.signal_voltage =21=3D MMC_SIGNAL_VOLTAGE_180) =7B
> -		/*
> -		 * Re-read switch information in case it has changed since
> -		 * oldcard was initialized.
> -		 */
> -		if (oldcard) =7B
> -			err =3D mmc_read_switch(card);
> -			if (err)
> -				goto free_card;
> -		=7D
> -		if (mmc_sd_card_using_v18(card)) =7B
> -			if (mmc_host_set_uhs_voltage(host) =7C=7C
> -			    mmc_sd_init_uhs_card(card)) =7B
> -				v18_fixup_failed =3D true;
> -				mmc_power_cycle(host, ocr);
> -				if (=21oldcard)
> -					mmc_remove_card(card);
> -				goto retry;
> -			=7D
> -			goto done;
> -		=7D
> -	=7D
> -
>  	/* Initialization sequence for UHS-I cards */
>  	if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) =7B
>  		err =3D mmc_sd_init_uhs_card(card);
> =40=40 -1566,7 +1523,7 =40=40 static int mmc_sd_init_card(struct mmc_host=
 *host,
> u32 ocr,
>  		err =3D -EINVAL;
>  		goto free_card;
>  	=7D
> -done:
> +
>  	host->card =3D card;
>  	return 0;
>=20
> --
> 2.29.0

Dear All,

Please review this commit.

Once the SDR104 SD card fails to switch voltage,
there is no chance to work SDR104 bus speed again
due to update sd3_bus_mode.

To fix this regression issue, do not update sd3_bus_mode.
And then it has the chance to work SDR104 again.

AS-IS:
voltage_switch fail -> mmc_read_switch() -> HS mode
next system resume
voltage switch success -> SDR25 mode

TO-BE:
Voltage switch fail -> HS mode
Next system resume
Voltage switch success -> SDR104 mode

And plus, mmc_set_uhs_voltage() has power_cycle now.
It means that if voltage switch fails,
the card initializes 3.3V signal level.

Regards,
Seunghui Lee.

