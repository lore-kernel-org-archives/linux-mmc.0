Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A853DC00140
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Aug 2022 04:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiHJEYT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Aug 2022 00:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHJEYS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2022 00:24:18 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A981B06
        for <linux-mmc@vger.kernel.org>; Tue,  9 Aug 2022 21:24:11 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220810042405epoutp033fcb941ac9b94c2c4a473e9224db4844~J4RtpP_i52683426834epoutp03L
        for <linux-mmc@vger.kernel.org>; Wed, 10 Aug 2022 04:24:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220810042405epoutp033fcb941ac9b94c2c4a473e9224db4844~J4RtpP_i52683426834epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660105445;
        bh=Hnitp5j0cxb1x+GVa7jF5TCu3cKNCvz4PaU2+blU1WI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ftiFSscI1aHVh8h4cH6rnsw0CQE9aMOYlbMl+UR+AbV5nSnZ8z+dS2niRHUEeNgkz
         FWOLF84YmxFeyEe5zssrrvzpkPuqyr1c/w8zx18KcvQdYaCJLEW5uLC+0wWtXb06cD
         C8RTejmFV0seT9JhhB3qE8CsB3S2BxwXPNcEFJjI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220810042404epcas1p3fb358ea4134584f02364327d3d49bf65~J4Rs9ofo63042330423epcas1p3Q;
        Wed, 10 Aug 2022 04:24:04 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.227]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4M2cJh3H15z4x9QC; Wed, 10 Aug
        2022 04:24:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.29.09967.4E233F26; Wed, 10 Aug 2022 13:24:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220810042403epcas1p4e139019b79bb86908bab7185a30b49a9~J4RsPO-a41405914059epcas1p4x;
        Wed, 10 Aug 2022 04:24:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220810042403epsmtrp20b557ca1d8f1a99a677387a9182fc8b9~J4RsOorXM0443204432epsmtrp2m;
        Wed, 10 Aug 2022 04:24:03 +0000 (GMT)
X-AuditID: b6c32a38-4a3ff700000226ef-f9-62f332e44295
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.A7.08802.3E233F26; Wed, 10 Aug 2022 13:24:03 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220810042403epsmtip26e613caeedf54969690fb1d782e2537e~J4RsADsAK3044230442epsmtip2H;
        Wed, 10 Aug 2022 04:24:03 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>
Cc:     "'DooHyun Hwang'" <dh0421.hwang@samsung.com>
In-Reply-To: <45d81e6a-91b9-657d-418b-3ae8b631dd81@intel.com>
Subject: RE: [PATCH] mmc: sd: Remove the patch that fix signal voltage when
 there is no power cycle
Date:   Wed, 10 Aug 2022 13:24:03 +0900
Message-ID: <001301d8ac71$05e14180$11a3c480$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpt5FcOhFG+N8hh+VoMjV22ziL8QIcZ0v4AX4z2rkC2cG9TAHOm/pGApzuqfWsrkDCcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmge4To89JBjOeiVqcfLKGzWLftZPs
        Fkf+9zM6MHss3vOSyaNvyypGj8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMyZ9m8FUcLWq4sfkzYwNjIuSuxg5OSQETCTmfehj
        7WLk4hAS2MEosWrPbCjnE6PEzs/rGCGcz4wSXx48ZIJp+fFjA1RiF6PEpMPXoVpeMErsO/+U
        HaSKTUBH4s2n/6wgtoiAj8SNvuUsIDazgIHEk5u7wWxOAVuJi2+esYHYwgKpErennASrZxFQ
        lZj2dTrYNl4BS4lHRw+xQdiCEidnPoGaoy2xbOFrZoiLFCR+Pl0GtStMov3VBWaIGhGJ2Z1t
        zCDHSQi8ZZe4ceEfVIOLxIrGC+wQtrDEq+NboGwpic/v9rJB2MUSbf9g6iskDvZ9gbKNJT59
        /gz0PgfQAk2J9bv0IcKKEjt/z2WE2Msn8e5rDytIiYQAr0RHmxBEibLEy0fLoIEoKbGk/Rbz
        BEalWUg+m4Xks1lIPpiFsGwBI8sqRrHUguLc9NRiwwITeGwn5+duYgQnQi2LHYxz337QO8TI
        xMF4iFGCg1lJhPfI2vdJQrwpiZVVqUX58UWlOanFhxhNgWE9kVlKNDkfmIrzSuINTSwNTMyM
        TCyMLY3NlMR5e6eeThQSSE8sSc1OTS1ILYLpY+LglGpgqi8VWm5+IqSmReTBZx2fXfFsdg8k
        s3zCJ6f9NZ6tZZQaxTZvQtzy9u97MyQ/Pzks/mhH3MKO28Xrc86eX8MX3OQRMi2vLHfmc50c
        T5+SU6dusE3zvrir+Qi75pt9CybMyXKT37zP+LLQydz22fos1u90D28XcvR1l/yyXWfuzFfR
        ceEqqyZ57K/R/vzuW/i99x3p35fPf/77fc9cBcutmybJ7esN195+I+jjzkkr9+9n+L7GvijE
        9Cv/tGOhW3LrDfer2eZ8959YcW43A9enxpTdiz4c6V2a4Zh0Q1OzdonpfK35q86uF7I/onPV
        996znMQTD6cWb34b7ScvOi0xuyK9sfeZRbyT96mQG18bDymxFGckGmoxFxUnAgCQZ6N2DQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvO5jo89JBm/7jC1OPlnDZrHv2kl2
        iyP/+xkdmD0W73nJ5NG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZ0w/PZiq4Ulqx/8o21gbG
        6XFdjJwcEgImEj9+bGDsYuTiEBLYwSjxqm0JO0RCUmLxo4dsXYwcQLawxOHDxRA1zxgltr55
        zgZSwyagI/Hm039WEFtEwE/iw9ffzCA2s4CBxJObu1lAbCGBk0wSPV+MQGxOAVuJi2+egfUK
        CyRL3JvQAdbLIqAqMe3rdCYQm1fAUuLR0UNsELagxMmZT1ggZmpL9D5sZYSxly18zQxxp4LE
        z6fLoG4Ik2h/dQHqBhGJ2Z1tzBMYhWchGTULyahZSEbNQtKygJFlFaNkakFxbnpusWGBUV5q
        uV5xYm5xaV66XnJ+7iZGcERoae1g3LPqg94hRiYOxkOMEhzMSiK8R9a+TxLiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaeI8daOKxSEJLknMCx4yTdTu
        qPPWWaC30SNWc5Vx7bFdxXP2mbLYrH/i5bFi387PSceL+XY+fTiZjW39chHhJQWfHszqvvhh
        gVuZWaPqTv+AjxvfC16dl6w3l7O2x/fLMsHEn1lXXn+6+GHTjVAmR5O27//2L44ulViXsGtm
        zsuWTw9+nZKuPm3uev6to98WNd1l8Wl+7/TLr8nev1OQNGFdr8uiSf4r+Qzu6Rr+dOB9+3Xb
        9NfLdqzm0Z6XNPvXzS29B5dcNCs2K/9c0B147feU8uKMgNqi+zNeS+21XrDpdNXXs3/7GV5t
        YzVcevrT3wOtbg4Tz38TbtHPujzdpexXclgey975Fi07NmVOTN+rxFKckWioxVxUnAgArdWZ
        C/cCAAA=
X-CMS-MailID: 20220810042403epcas1p4e139019b79bb86908bab7185a30b49a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc
References: <CGME20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc@epcas1p4.samsung.com>
        <20220721055924.9043-1-sh043.lee@samsung.com>
        <001901d8a09b$480bfd70$d823f850$@samsung.com>
        <11158c9f-b1a8-20cb-95a2-6c8f7f06c35f@intel.com>
        <000001d8ab00$59393260$0bab9720$@samsung.com>
        <45d81e6a-91b9-657d-418b-3ae8b631dd81@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Adrian Hunter <adrian.hunter=40intel.com>
> Sent: Tuesday, August 9, 2022 2:37 PM
> To: Seunghui Lee <sh043.lee=40samsung.com>; linux-mmc=40vger.kernel.org
> Cc: 'DooHyun Hwang' <dh0421.hwang=40samsung.com>
> Subject: Re: =5BPATCH=5D mmc: sd: Remove the patch that fix signal voltag=
e
> when there is no power cycle
>=20
> On 8/08/22 11:24, Seunghui Lee wrote:
> >> -----Original Message-----
> >> From: Adrian Hunter <adrian.hunter=40intel.com>
> >> Sent: Tuesday, July 26, 2022 7:57 PM
> >> To: Seunghui Lee <sh043.lee=40samsung.com>; linux-mmc=40vger.kernel.or=
g;
> >> adrian.hunter=40intel.com
> >> Cc: 'DooHyun Hwang' <dh0421.hwang=40samsung.com>
> >> Subject: Re: =5BPATCH=5D mmc: sd: Remove the patch that fix signal
> >> voltage when there is no power cycle
> >>
> >> On 26/07/22 05:56, Seunghui Lee wrote:
> >>>> -----Original Message-----
> >>>> From: Seunghui Lee <sh043.lee=40samsung.com>
> >>>> Sent: Thursday, July 21, 2022 2:59 PM
> >>>> To: ulf.hansson=40linaro.org; linux-mmc=40vger.kernel.org;
> >>>> adrian.hunter=40intel.com
> >>>> Cc: Seunghui Lee <sh043.lee=40samsung.com>; DooHyun Hwang
> >>>> <dh0421.hwang=40samsung.com>
> >>>> Subject: =5BPATCH=5D mmc: sd: Remove the patch that fix signal volta=
ge
> >>>> when there is no power cycle
> >>>>
> >>>> At first, all error flow of mmc_set_uhs_voltage() has power cycle
> >>>> except R1_ERROR and no start_signal_voltage_switch() func pointer.
> >>>>
> >>>> There is the performance regression issue of SDR104 SD card from
> >>>> the market VOC. Normally, once a SDR104 SD card fails to switch
> >>>> voltage, it works HS mode.
> >>>> And then it initializes SDR104 mode after system resume or error
> >> handling.
> >>>>
> >>>> However, with below patch,
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> >>>> co
> >>>> mmit/
> >>>> drivers/mmc/core/sd.c?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
> >>>> Once a SD card does, it initializes SDR25 mode forever after system
> >>>> resume or error handling(re-initialized).
> >>>> Host updates sd3_bus_mode by calling mmc_read_switch(), the value
> >>>> of sd3_bus_mode doesn't set for SDR104, SDR50 and DDR50 mode.
> >>>>
> >>>> So, if host doesn't update sd3_bus_mode, the SD card works SDR104
> >>>> mode after system resume or error-handling.
> >>>>
> >>>> Here is an example.
> >>>>
> >>>> AS-IS : test log
> >>>> // normal case : sd3_bus_mode =3D 0x1F, sd_bus_speed =3D SDR104, clo=
ck
> >> 208MHz
> >>>> =5B  111.907789=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D mmc_sd_i=
nit_card: 1119:
> >>>> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >>>> signal_voltage =3D0x1.
> >>>> =5B  111.907824=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D mmc_sd_i=
nit_card: 1149:
> >> rocr
> >>>> 0xc1ff8000, S18A, uhs.
> >>>> =5B  111.908707=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D
> sd_update_bus_speed_mode:
> >>>> caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card->oc=
r =3D
> >>>> 0x40000.
> >>>> =5B  111.912484=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D sd_set_b=
us_speed_mode:
> >>>> sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D0=
x40000.
> >>>> // resume : issue occurs : SDcard doesn't release busy for checking
> >>>> 10 times
> >>>> =5B  112.096550=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1040:
> >>>> card->ocr 0x40000.
> >>>> =5B  112.096560=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_g=
et_cid: ocr
> >>>> 0x40000(pocr 0x40000), retries 10.
> >>>> ...
> >>>> =5B  114.531129=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_powe=
r_cycle.
> >>>> =5B  114.579500=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_g=
et_cid: ocr
> >>>> 0x41040000(pocr 0x40000), retries 0.
> >>>> =5B  114.579506=5D =5B5:    kworker/5:2:  207=5D mmc0: Skipping volt=
age switch
> >>>> =5B  114.757575=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1119:
> >>>> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >>>> signal_voltage =3D0x0.
> >>>> =5B  114.757583=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1128:
> >>>> switch with oldcard.
> >>>> =5B  114.759742=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_read=
_switch:
> >> sd_switch
> >>>> ret 0, sd3_bus_mode=3D3.
> >>>> // sd3_bus_mode =3D 0x3 supports HS, SDR25 and SDR12
> >>>> =5B  114.759750=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1157:
> >>>> switch hs.
> >>>> // next resume : the SDcard initializes to SDR25(HS)
> >>>> mode(sd_bus_speed =3D 1) by sd3_bus_mode setting with clk 50MHz
> >>>> =5B  114.968346=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1040:
> >>>> card->ocr 0x40000.
> >>>> =5B  114.968359=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_g=
et_cid: ocr
> >>>> 0x40000(pocr 0x40000), retries 10.
> >>>> =5B  115.167346=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1119:
> >>>> caps=3D0x407f020f, sd3_bus_mode=3D0x3, v18_fixup_failed false,
> >>>> signal_voltage =3D0x1.
> >>>> =5B  115.167366=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_card: 1149:
> >> rocr
> >>>> 0xc1ff8000, S18A, uhs.
> >>>> =5B  115.168041=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_i=
nit_uhs_card:
> >> before
> >>>> update: caps 0x407f020f, sd3_bus_mode =3D 3, sd_bus_speed =3D 3,
> >>>> card->ocr =3D 0x40000.
> >>>> =5B  115.168051=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D
> sd_update_bus_speed_mode:
> >>>> caps 0x407f020f, sd3_bus_mode =3D 3, sd_bus_speed =3D 1, card->ocr =
=3D
> >> 0x40000.
> >>>> =5B  115.169176=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D sd_set_b=
us_speed_mode:
> >>>> sd_bus_speed=3D1, timing=3D4, uhs_max_dtr=3D50000000, card->ocr=3D0x=
40000.
> >>>>
> >>>> TO-BE : TEST log with this commit
> >>>> // resume : issue occurs : SDcard doesn't release busy for checking
> >>>> 10 times
> >>>> =5B 1843.594805=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_g=
et_cid: ocr
> >>>> 0x41040000(pocr 0x40000), retries 0.
> >>>> =5B 1843.594812=5D =5B4:    kworker/4:5:21512=5D mmc0: Skipping volt=
age switch
> >>>> =5B 1843.772555=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_i=
nit_card: 1122:
> >>>> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >>>> signal_voltage =3D0x0.
> >>>> // no update sd3_bus_mode value
> >>>> =5B 1843.772563=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_i=
nit_card: 1164:
> >>>> switch hs.
> >>>> // next resume : the SDcard initializes to SDR104
> >>>> =5B 1844.191295=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_i=
nit_card:
> 1122:
> >>>> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >>>> signal_voltage =3D0x1.
> >>>> =5B 1844.191315=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_i=
nit_card:
> 1154:
> >>>> rocr 0xc1ff8000, S18A, uhs.
> >>>> =5B 1844.192175=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_i=
nit_uhs_card:
> >>>> before update: caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =
=3D
> >>>> 3,
> >>>> card->ocr =3D 0x40000.
> >>>> =5B 1844.192187=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D
> >> sd_update_bus_speed_mode:
> >>>> caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card->oc=
r =3D
> >>>> 0x40000.
> >>>> =5B 1844.198697=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D sd_set_b=
us_speed_mode:
> >>>> sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D0=
x40000.
> >>>>
> >>>> Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> >>>> Tested-by: DooHyun Hwang <dh0421.hwang=40samsung.com>
> >>>> ---
> >>>>  drivers/mmc/core/sd.c =7C 47
> >>>> ++-----------------------------------------
> >>>>  1 file changed, 2 insertions(+), 45 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> >>>> cee4c0b59f43..4e3d39956185 100644
> >>>> --- a/drivers/mmc/core/sd.c
> >>>> +++ b/drivers/mmc/core/sd.c
> >>>> =40=40 -1001,18 +1001,6 =40=40 unsigned mmc_sd_get_max_clock(struct
> >>>> mmc_card
> >> *card)
> >>>>  	return max_dtr;
> >>>>  =7D
> >>>>
> >>>> -static bool mmc_sd_card_using_v18(struct mmc_card *card) -=7B
> >>>> -	/*
> >>>> -	 * According to the SD spec., the Bus Speed Mode (function group 1=
)
> >>>> bits
> >>>> -	 * 2 to 4 are zero if the card is initialized at 3.3V signal level=
.
> >>>> Thus
> >>>> -	 * they can be used to determine if the card has already switched
> >>>> to
> >>>> -	 * 1.8V signaling.
> >>>> -	 */
> >>>> -	return card->sw_caps.sd3_bus_mode &
> >>>> -	       (SD_MODE_UHS_SDR50 =7C SD_MODE_UHS_SDR104 =7C SD_MODE_UHS_D=
DR50);
> >>>> -=7D
> >>>> -
> >>>>  static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8
> >>>> page,
> >>>> u16 offset,
> >>>>  			    u8 reg_data)
> >>>>  =7B
> >>>> =40=40 -1400,10 +1388,9 =40=40 static int mmc_sd_init_card(struct mm=
c_host
> >>>> *host,
> >>>> u32 ocr,
> >>>>  	int err;
> >>>>  	u32 cid=5B4=5D;
> >>>>  	u32 rocr =3D 0;
> >>>> -	bool v18_fixup_failed =3D false;
> >>>>
> >>>>  	WARN_ON(=21host->claimed);
> >>>> -retry:
> >>>> +
> >>>>  	err =3D mmc_sd_get_cid(host, ocr, cid, &rocr);
> >>>>  	if (err)
> >>>>  		return err;
> >>>> =40=40 -1472,36 +1459,6 =40=40 static int mmc_sd_init_card(struct mm=
c_host
> >>>> *host,
> >>>> u32 ocr,
> >>>>  	if (err)
> >>>>  		goto free_card;
> >>>>
> >>>> -	/*
> >>>> -	 * If the card has not been power cycled, it may still be using
> >>>> 1.8V
> >>>> -	 * signaling. Detect that situation and try to initialize a UHS-I
> >>>> (1.8V)
> >>>> -	 * transfer mode.
> >>>> -	 */
> >>>> -	if (=21v18_fixup_failed && =21mmc_host_is_spi(host) &&
> >>>> mmc_host_uhs(host) &&
> >>>> -	    mmc_sd_card_using_v18(card) &&
> >>>> -	    host->ios.signal_voltage =21=3D MMC_SIGNAL_VOLTAGE_180) =7B
> >>>> -		/*
> >>>> -		 * Re-read switch information in case it has changed since
> >>>> -		 * oldcard was initialized.
> >>>> -		 */
> >>>> -		if (oldcard) =7B
> >>>> -			err =3D mmc_read_switch(card);
> >>>> -			if (err)
> >>>> -				goto free_card;
> >>>> -		=7D
> >>>> -		if (mmc_sd_card_using_v18(card)) =7B
> >>>> -			if (mmc_host_set_uhs_voltage(host) =7C=7C
> >>>> -			    mmc_sd_init_uhs_card(card)) =7B
> >>>> -				v18_fixup_failed =3D true;
> >>>> -				mmc_power_cycle(host, ocr);
> >>>> -				if (=21oldcard)
> >>>> -					mmc_remove_card(card);
> >>>> -				goto retry;
> >>>> -			=7D
> >>>> -			goto done;
> >>>> -		=7D
> >>>> -	=7D
> >>>> -
> >>>>  	/* Initialization sequence for UHS-I cards */
> >>>>  	if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) =7B
> >>>>  		err =3D mmc_sd_init_uhs_card(card); =40=40 -1566,7 +1523,7 =40=40
> static
> >>>> int mmc_sd_init_card(struct mmc_host *host,
> >>>> u32 ocr,
> >>>>  		err =3D -EINVAL;
> >>>>  		goto free_card;
> >>>>  	=7D
> >>>> -done:
> >>>> +
> >>>>  	host->card =3D card;
> >>>>  	return 0;
> >>>>
> >>>> --
> >>>> 2.29.0
> >>>
> >>> Dear All,
> >>>
> >>> Please review this commit.
> >>
> >> I have started to look at it, but my time is limited at the moment.
> >>
> >> Note the original patch is 5 years old and fixes a real problem, so
> >> we don't want to just throw it away.
> >>
> >
> > Dear Mr. hunter,
> >
> > Could you check this with below patch?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
> > mit/drivers/mmc/core/core.c?id=3D147186f531ae49c18b7a9091a2c40e83b3d956=
4
> > 9
> >
> > In the mmc_set_uhs_voltaga func(),
> > once it occurs error, it has power_cycle except R1_ERROR with CMD11.
> > So, When mmc_set_uhs_voltage() return error, host and card can't leave
> > 1.8V voltage.
> >
> > Regards,
> >
> >>>
> >>> Once the SDR104 SD card fails to switch voltage, there is no chance
> >>> to work SDR104 bus speed again due to update sd3_bus_mode.
> >>>
> >>> To fix this regression issue, do not update sd3_bus_mode.
> >>> And then it has the chance to work SDR104 again.
> >>>
> >>> AS-IS:
> >>> voltage_switch fail -> mmc_read_switch() -> HS mode next system
> >>> resume voltage switch success -> SDR25 mode
> >>>
> >>> TO-BE:
> >>> Voltage switch fail -> HS mode
> >>> Next system resume
> >>> Voltage switch success -> SDR104 mode
> >>>
> >>> And plus, mmc_set_uhs_voltage() has power_cycle now.
> >>> It means that if voltage switch fails, the card initializes 3.3V
> >>> signal level.
> >>>
> >>> Regards,
> >>> Seunghui Lee.
> >>>
> >
> >
>=20
> Does this help?
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> cee4c0b59f43..1abe8af48bfc 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> =40=40 -949,15 +949,15 =40=40 int mmc_sd_setup_card(struct mmc_host *host=
, struct
> mmc_card *card,
>=20
>  		/* Erase init depends on CSD and SSR */
>  		mmc_init_erase(card);
> -
> -		/*
> -		 * Fetch switch information from card.
> -		 */
> -		err =3D mmc_read_switch(card);
> -		if (err)
> -			return err;
>  	=7D
>=20
> +	/*
> +	 * Fetch switch information from card.
> +	 */
> +	err =3D mmc_read_switch(card);
> +	if (err)
> +		return err;
> +
>  	/*
>  	 * For SPI, enable CRC as appropriate.
>  	 * This CRC enable is located AFTER the reading of the

Dear Mr.Hunter,

Your suggestion works well :)
I've tested and verified the sd3_bus_mode's value updated.

So, May I update your suggestion as patch v2?
Or Would you like to your patch to contribute?

Regards,

Here is the test log.

=5B 2347.726601=5D =5B4:   kworker/4:98: 2227=5D =5BTEST=5D mmc_sd_get_cid:=
 ocr 0x41040000(pocr 0x40000), retries 0.
=5B 2347.726608=5D =5B4:   kworker/4:98: 2227=5D mmc0: Skipping voltage swi=
tch
=5B 2347.932495=5D =5B4:   kworker/4:98: 2227=5D =5BTEST=5D mmc_read_switch=
: sd_switch ret 0, sd3_bus_mode=3D0x3.
=5B 2347.932508=5D =5B4:   kworker/4:98: 2227=5D =5BTEST=5D mmc_sd_init_car=
d: 1116: caps=3D0x407f020f, sd3_bus_mode=3D0x3, v18_fixup_failed false, sig=
nal_voltage =3D0x0.
-> sd3_bus_mode is 0x3.
=5B 2347.932514=5D =5B4:   kworker/4:98: 2227=5D =5BTEST=5D mmc_sd_init_car=
d: 1154: switch hs.
=5B 2347.936315=5D =5B4:   kworker/4:98: 2227=5D =5BTEST=5D mmc_sd_init_car=
d: 1198: card->ocr 0x40000.

* next resume
=5B 2348.156021=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_sd_init_car=
d: 1037: card->ocr 0x40000.
=5B 2348.156065=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_sd_get_cid:=
 ocr 0x40000(pocr 0x40000), retries 10.
=5B 2348.387214=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_read_switch=
: sd_switch ret 0, sd3_bus_mode=3D0x1f.
-> sd3_bus_mode is 0x1f
=5B 2348.387253=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_sd_init_car=
d: 1116: caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false, si=
gnal_voltage =3D0x1.
=5B 2348.387273=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_sd_init_car=
d: 1146: rocr 0xc1ff8000, S18A, uhs.
=5B 2348.388399=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_sd_init_uhs=
_card: before update: caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =
=3D 3, card->ocr =3D 0x40000.
=5B 2348.388427=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D sd_update_bus_s=
peed_mode: caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card=
->ocr =3D 0x40000.
=5B 2348.390614=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D sd_set_bus_spee=
d_mode: sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D=
0x40000.
=5B 2348.393757=5D =5B0:    kworker/0:6:26086=5D =5BTEST=5D mmc_sd_init_car=
d: 1198: card->ocr 0x40000.

