Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F94AC25B06
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Aug 2022 08:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiHHIZM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHIZK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2022 04:25:10 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015D13E26
        for <linux-mmc@vger.kernel.org>; Mon,  8 Aug 2022 01:25:06 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220808082500epoutp0455d874fc7baf661e4bc1fc953d3790db~JURfjNQ0D2841728417epoutp04d
        for <linux-mmc@vger.kernel.org>; Mon,  8 Aug 2022 08:25:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220808082500epoutp0455d874fc7baf661e4bc1fc953d3790db~JURfjNQ0D2841728417epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659947100;
        bh=lFbgADHeQFvXVvOfP0u1R8v7CISqDDkSwTvfw95bZ4k=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fkvzMOvLUyLaOERnhE9A+kPnPdLU5RsFtp9nkZubCYIemeezCVgmhguqxzGkoL65H
         D+Iw5C/YnZixvZMERE+89tBejKMw1Nd6orgjWobYVFau1nLJDmyx9iUB9gX/fcqbIl
         tS6Zbfyj9ZBZaaDMivjlLsoF3CwqDvLy9XGE38ew=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220808082500epcas1p36e40b66bdb69148b27cf99283f4d0045~JURfPsJHr0955809558epcas1p3N;
        Mon,  8 Aug 2022 08:25:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.227]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4M1Tlc0Kg2z4x9Pw; Mon,  8 Aug
        2022 08:25:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.67.09657.B58C0F26; Mon,  8 Aug 2022 17:24:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220808082459epcas1p1b8edfe00d380c8989c7e52813a007a69~JUReeodRU0149701497epcas1p1H;
        Mon,  8 Aug 2022 08:24:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220808082459epsmtrp2db2c0c6d9f09d0641bc78126d6e2ec9e~JURedztPM0156401564epsmtrp2a;
        Mon,  8 Aug 2022 08:24:59 +0000 (GMT)
X-AuditID: b6c32a35-f4312a80000025b9-7a-62f0c85b0c13
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.94.08905.B58C0F26; Mon,  8 Aug 2022 17:24:59 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220808082459epsmtip2235503aff6766f85796e247d25154921~JURePYuUR0042600426epsmtip2b;
        Mon,  8 Aug 2022 08:24:59 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>
Cc:     "'DooHyun Hwang'" <dh0421.hwang@samsung.com>
In-Reply-To: <11158c9f-b1a8-20cb-95a2-6c8f7f06c35f@intel.com>
Subject: RE: [PATCH] mmc: sd: Remove the patch that fix signal voltage when
 there is no power cycle
Date:   Mon, 8 Aug 2022 17:24:59 +0900
Message-ID: <000001d8ab00$59393260$0bab9720$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIpt5FcOhFG+N8hh+VoMjV22ziL8QIcZ0v4AX4z2rkC2cG9TKzO7oFg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnm70iQ9JBm/n21icfLKGzWLftZPs
        Fkf+9zM6MHss3vOSyaNvyypGj8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM35eaWMvWBlV0bRkP0sD4xyPLkZODgkBE4mdvdNZ
        uhi5OIQEdjBKTLw6gRkkISTwiVFi/RImiMQ3Romvrzcww3Tcf/aQFSKxFyjRsZwFouMFo8TF
        T9UgNpuAjsSbT/9ZQWwRAR+JG30QNcwCBhJPbu4GszkFbCWWvznPBmILC6RK3J5yEqyeRUBF
        YvfrQ4wgNq+ApcTEh4/YIGxBiZMzn0DN0ZZYtvA11EEKEj+fLoPa5SbRsXIbG0SNiMTszjZm
        kEMlBB6xS7z+v44dosFF4m3XFzYIW1ji1fEtUHEpic/v9kLFiyXa/v2DWlAhcbDvC5RtLPHp
        82eg4ziAFmhKrN+lDxFWlNj5ey4jxF4+iXdfe1hBSiQEeCU62oQgSpQlXj5axgRhS0osab/F
        PIFRaRaSz2Yh+WwWkg9mISxbwMiyilEstaA4Nz212LDAEB7Xyfm5mxjBSVDLdAfjxLcf9A4x
        MnEwHmKU4GBWEuE9svZ9khBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB6bhvJJ4QxNLAxMz
        IxMLY0tjMyVx3lXTTicKCaQnlqRmp6YWpBbB9DFxcEo1MDGlJS01TH0idHybdV37lpB+y78s
        d2W/6PNaKPwzVWY5WSW0vcZFbNJCL4372lPdJ/3NWl+l+qyab55xg5bkT/Z9am+b+ndft9Xb
        XXCI+0728mfJ/7Z/PPjw5MFnEx4k7/+16OIhP4GfMnr7jaxO5uuv9L+bkml13tml8YvGj532
        nopa/9cyHWHUXWcoLyuY8H+W7bSlj3sCN3yeOs/ogwjb3O4dRUphu4I1G7yfHOn6VS5/dYfB
        CrGIdy/2pbH+2u6w/uL5VWdUuPZN2M5Q4Ln10YJUnrTAM8Wpt65V9/l1W/490pN1PWn1JpsP
        jJG83I82yFr7CJpyddidfLnjCRe7+t1Di3dYP25ZuY117RslluKMREMt5qLiRAAV4DVBCwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG70iQ9JBsdvi1ucfLKGzWLftZPs
        Fkf+9zM6MHss3vOSyaNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgyXu7RLXgUVrGk7wNLA+Nl
        ly5GTg4JAROJ+88esnYxcnEICexmlFi35BQLREJSYvGjh2xdjBxAtrDE4cPFEDXPGCWm31vM
        CFLDJqAj8ebTf1YQW0TAT+LD19/MIDazgIHEk5u7WSAaXjFKTN1xF6yIU8BWYvmb82wgtrBA
        ssS9CR1gcRYBFYndrw+BDeUVsJSY+PARG4QtKHFy5hMWiKHaEk9vPoWzly18zQxxqILEz6fL
        oI5wk+hYuY0NokZEYnZnG/MERuFZSEbNQjJqFpJRs5C0LGBkWcUomVpQnJueW2xYYJiXWq5X
        nJhbXJqXrpecn7uJERwRWpo7GLev+qB3iJGJg/EQowQHs5II75G175OEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYIoNWG7xq6h54S/m6ZblPh4qle+N
        NTZFJZT4FBn/2HvL9V1xxuHEQAd11g0df4VdU7vWNc4rMZfRqfrfKOc7JbJR6NIFn0VW8nxs
        WzclKjo7b7kRvEmoYArTGsWZxjFh87YnCQtNF2ERnFzIqXfId9FhlqgfC5m0tV6/c//b4lPl
        6Pfk7LsAydzQKzkhp56sVmPn0za9mG+Q39RmfT9W2PHk1e+7DTcf/XKrY5vUJraYx7USb93q
        zynt5os333Pd7vT+BVfYm1we1IoaKccVVlxZZ7yfTWfODg7uXyyVU55Pz7CYUtgmyrbKdKbl
        FMFFrccrkiu+759zvPb7hNf/Nl6IupS5VOhXSt39xcfPK7EUZyQaajEXFScCABV+qEz3AgAA
X-CMS-MailID: 20220808082459epcas1p1b8edfe00d380c8989c7e52813a007a69
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
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Adrian Hunter <adrian.hunter=40intel.com>
> Sent: Tuesday, July 26, 2022 7:57 PM
> To: Seunghui Lee <sh043.lee=40samsung.com>; linux-mmc=40vger.kernel.org;
> adrian.hunter=40intel.com
> Cc: 'DooHyun Hwang' <dh0421.hwang=40samsung.com>
> Subject: Re: =5BPATCH=5D mmc: sd: Remove the patch that fix signal voltag=
e
> when there is no power cycle
>=20
> On 26/07/22 05:56, Seunghui Lee wrote:
> >> -----Original Message-----
> >> From: Seunghui Lee <sh043.lee=40samsung.com>
> >> Sent: Thursday, July 21, 2022 2:59 PM
> >> To: ulf.hansson=40linaro.org; linux-mmc=40vger.kernel.org;
> >> adrian.hunter=40intel.com
> >> Cc: Seunghui Lee <sh043.lee=40samsung.com>; DooHyun Hwang
> >> <dh0421.hwang=40samsung.com>
> >> Subject: =5BPATCH=5D mmc: sd: Remove the patch that fix signal voltage
> >> when there is no power cycle
> >>
> >> At first, all error flow of mmc_set_uhs_voltage() has power cycle
> >> except R1_ERROR and no start_signal_voltage_switch() func pointer.
> >>
> >> There is the performance regression issue of SDR104 SD card from the
> >> market VOC. Normally, once a SDR104 SD card fails to switch voltage,
> >> it works HS mode.
> >> And then it initializes SDR104 mode after system resume or error
> handling.
> >>
> >> However, with below patch,
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co
> >> mmit/
> >> drivers/mmc/core/sd.c?id=3D6a11fc47f175c8d87018e89cb58e2d36c66534cb
> >> Once a SD card does, it initializes SDR25 mode forever after system
> >> resume or error handling(re-initialized).
> >> Host updates sd3_bus_mode by calling mmc_read_switch(), the value of
> >> sd3_bus_mode doesn't set for SDR104, SDR50 and DDR50 mode.
> >>
> >> So, if host doesn't update sd3_bus_mode, the SD card works SDR104
> >> mode after system resume or error-handling.
> >>
> >> Here is an example.
> >>
> >> AS-IS : test log
> >> // normal case : sd3_bus_mode =3D 0x1F, sd_bus_speed =3D SDR104, clock
> 208MHz
> >> =5B  111.907789=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D mmc_sd_ini=
t_card: 1119:
> >> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >> signal_voltage =3D0x1.
> >> =5B  111.907824=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D mmc_sd_ini=
t_card: 1149:
> rocr
> >> 0xc1ff8000, S18A, uhs.
> >> =5B  111.908707=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D sd_update_=
bus_speed_mode:
> >> caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card->ocr =
=3D
> >> 0x40000.
> >> =5B  111.912484=5D =5B1:    kworker/1:3:  772=5D =5BTEST=5D sd_set_bus=
_speed_mode:
> >> sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D0x4=
0000.
> >> // resume : issue occurs : SDcard doesn't release busy for checking
> >> 10 times
> >> =5B  112.096550=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1040:
> >> card->ocr 0x40000.
> >> =5B  112.096560=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_get=
_cid: ocr
> >> 0x40000(pocr 0x40000), retries 10.
> >> ...
> >> =5B  114.531129=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_power_=
cycle.
> >> =5B  114.579500=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_get=
_cid: ocr
> >> 0x41040000(pocr 0x40000), retries 0.
> >> =5B  114.579506=5D =5B5:    kworker/5:2:  207=5D mmc0: Skipping voltag=
e switch
> >> =5B  114.757575=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1119:
> >> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >> signal_voltage =3D0x0.
> >> =5B  114.757583=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1128:
> >> switch with oldcard.
> >> =5B  114.759742=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_read_s=
witch:
> sd_switch
> >> ret 0, sd3_bus_mode=3D3.
> >> // sd3_bus_mode =3D 0x3 supports HS, SDR25 and SDR12
> >> =5B  114.759750=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1157:
> >> switch hs.
> >> // next resume : the SDcard initializes to SDR25(HS)
> >> mode(sd_bus_speed =3D 1) by sd3_bus_mode setting with clk 50MHz
> >> =5B  114.968346=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1040:
> >> card->ocr 0x40000.
> >> =5B  114.968359=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_get=
_cid: ocr
> >> 0x40000(pocr 0x40000), retries 10.
> >> =5B  115.167346=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1119:
> >> caps=3D0x407f020f, sd3_bus_mode=3D0x3, v18_fixup_failed false,
> >> signal_voltage =3D0x1.
> >> =5B  115.167366=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_card: 1149:
> rocr
> >> 0xc1ff8000, S18A, uhs.
> >> =5B  115.168041=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D mmc_sd_ini=
t_uhs_card:
> before
> >> update: caps 0x407f020f, sd3_bus_mode =3D 3, sd_bus_speed =3D 3,
> >> card->ocr =3D 0x40000.
> >> =5B  115.168051=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D sd_update_=
bus_speed_mode:
> >> caps 0x407f020f, sd3_bus_mode =3D 3, sd_bus_speed =3D 1, card->ocr =3D
> 0x40000.
> >> =5B  115.169176=5D =5B5:    kworker/5:2:  207=5D =5BTEST=5D sd_set_bus=
_speed_mode:
> >> sd_bus_speed=3D1, timing=3D4, uhs_max_dtr=3D50000000, card->ocr=3D0x40=
000.
> >>
> >> TO-BE : TEST log with this commit
> >> // resume : issue occurs : SDcard doesn't release busy for checking
> >> 10 times
> >> =5B 1843.594805=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_get=
_cid: ocr
> >> 0x41040000(pocr 0x40000), retries 0.
> >> =5B 1843.594812=5D =5B4:    kworker/4:5:21512=5D mmc0: Skipping voltag=
e switch
> >> =5B 1843.772555=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_ini=
t_card: 1122:
> >> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >> signal_voltage =3D0x0.
> >> // no update sd3_bus_mode value
> >> =5B 1843.772563=5D =5B4:    kworker/4:5:21512=5D =5BTEST=5D mmc_sd_ini=
t_card: 1164:
> >> switch hs.
> >> // next resume : the SDcard initializes to SDR104
> >> =5B 1844.191295=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_ini=
t_card: 1122:
> >> caps=3D0x407f020f, sd3_bus_mode=3D0x1f, v18_fixup_failed false,
> >> signal_voltage =3D0x1.
> >> =5B 1844.191315=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_ini=
t_card: 1154:
> >> rocr 0xc1ff8000, S18A, uhs.
> >> =5B 1844.192175=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D mmc_sd_ini=
t_uhs_card:
> >> before update: caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =
=3D
> >> 3,
> >> card->ocr =3D 0x40000.
> >> =5B 1844.192187=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D
> sd_update_bus_speed_mode:
> >> caps 0x407f020f, sd3_bus_mode =3D 0x1f, sd_bus_speed =3D 3, card->ocr =
=3D
> >> 0x40000.
> >> =5B 1844.198697=5D =5B5:   kworker/5:93: 2282=5D =5BTEST=5D sd_set_bus=
_speed_mode:
> >> sd_bus_speed=3D3, timing=3D6, uhs_max_dtr=3D208000000, card->ocr=3D0x4=
0000.
> >>
> >> Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> >> Tested-by: DooHyun Hwang <dh0421.hwang=40samsung.com>
> >> ---
> >>  drivers/mmc/core/sd.c =7C 47
> >> ++-----------------------------------------
> >>  1 file changed, 2 insertions(+), 45 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> >> cee4c0b59f43..4e3d39956185 100644
> >> --- a/drivers/mmc/core/sd.c
> >> +++ b/drivers/mmc/core/sd.c
> >> =40=40 -1001,18 +1001,6 =40=40 unsigned mmc_sd_get_max_clock(struct mm=
c_card
> *card)
> >>  	return max_dtr;
> >>  =7D
> >>
> >> -static bool mmc_sd_card_using_v18(struct mmc_card *card) -=7B
> >> -	/*
> >> -	 * According to the SD spec., the Bus Speed Mode (function group 1)
> >> bits
> >> -	 * 2 to 4 are zero if the card is initialized at 3.3V signal level.
> >> Thus
> >> -	 * they can be used to determine if the card has already switched
> >> to
> >> -	 * 1.8V signaling.
> >> -	 */
> >> -	return card->sw_caps.sd3_bus_mode &
> >> -	       (SD_MODE_UHS_SDR50 =7C SD_MODE_UHS_SDR104 =7C SD_MODE_UHS_DDR=
50);
> >> -=7D
> >> -
> >>  static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8 page,
> >> u16 offset,
> >>  			    u8 reg_data)
> >>  =7B
> >> =40=40 -1400,10 +1388,9 =40=40 static int mmc_sd_init_card(struct mmc_=
host
> >> *host,
> >> u32 ocr,
> >>  	int err;
> >>  	u32 cid=5B4=5D;
> >>  	u32 rocr =3D 0;
> >> -	bool v18_fixup_failed =3D false;
> >>
> >>  	WARN_ON(=21host->claimed);
> >> -retry:
> >> +
> >>  	err =3D mmc_sd_get_cid(host, ocr, cid, &rocr);
> >>  	if (err)
> >>  		return err;
> >> =40=40 -1472,36 +1459,6 =40=40 static int mmc_sd_init_card(struct mmc_=
host
> >> *host,
> >> u32 ocr,
> >>  	if (err)
> >>  		goto free_card;
> >>
> >> -	/*
> >> -	 * If the card has not been power cycled, it may still be using
> >> 1.8V
> >> -	 * signaling. Detect that situation and try to initialize a UHS-I
> >> (1.8V)
> >> -	 * transfer mode.
> >> -	 */
> >> -	if (=21v18_fixup_failed && =21mmc_host_is_spi(host) &&
> >> mmc_host_uhs(host) &&
> >> -	    mmc_sd_card_using_v18(card) &&
> >> -	    host->ios.signal_voltage =21=3D MMC_SIGNAL_VOLTAGE_180) =7B
> >> -		/*
> >> -		 * Re-read switch information in case it has changed since
> >> -		 * oldcard was initialized.
> >> -		 */
> >> -		if (oldcard) =7B
> >> -			err =3D mmc_read_switch(card);
> >> -			if (err)
> >> -				goto free_card;
> >> -		=7D
> >> -		if (mmc_sd_card_using_v18(card)) =7B
> >> -			if (mmc_host_set_uhs_voltage(host) =7C=7C
> >> -			    mmc_sd_init_uhs_card(card)) =7B
> >> -				v18_fixup_failed =3D true;
> >> -				mmc_power_cycle(host, ocr);
> >> -				if (=21oldcard)
> >> -					mmc_remove_card(card);
> >> -				goto retry;
> >> -			=7D
> >> -			goto done;
> >> -		=7D
> >> -	=7D
> >> -
> >>  	/* Initialization sequence for UHS-I cards */
> >>  	if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) =7B
> >>  		err =3D mmc_sd_init_uhs_card(card);
> >> =40=40 -1566,7 +1523,7 =40=40 static int mmc_sd_init_card(struct mmc_h=
ost
> >> *host,
> >> u32 ocr,
> >>  		err =3D -EINVAL;
> >>  		goto free_card;
> >>  	=7D
> >> -done:
> >> +
> >>  	host->card =3D card;
> >>  	return 0;
> >>
> >> --
> >> 2.29.0
> >
> > Dear All,
> >
> > Please review this commit.
>=20
> I have started to look at it, but my time is limited at the moment.
>=20
> Note the original patch is 5 years old and fixes a real problem, so we
> don't want to just throw it away.
>=20

Dear Mr. hunter,

Could you check this with below patch?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/mmc/core/core.c?id=3D147186f531ae49c18b7a9091a2c40e83b3d95649

In the mmc_set_uhs_voltaga func(),
once it occurs error, it has power_cycle except R1_ERROR with CMD11.
So, When mmc_set_uhs_voltage() return error,
host and card can't leave 1.8V voltage.

Regards,

> >
> > Once the SDR104 SD card fails to switch voltage, there is no chance to
> > work SDR104 bus speed again due to update sd3_bus_mode.
> >
> > To fix this regression issue, do not update sd3_bus_mode.
> > And then it has the chance to work SDR104 again.
> >
> > AS-IS:
> > voltage_switch fail -> mmc_read_switch() -> HS mode next system resume
> > voltage switch success -> SDR25 mode
> >
> > TO-BE:
> > Voltage switch fail -> HS mode
> > Next system resume
> > Voltage switch success -> SDR104 mode
> >
> > And plus, mmc_set_uhs_voltage() has power_cycle now.
> > It means that if voltage switch fails, the card initializes 3.3V
> > signal level.
> >
> > Regards,
> > Seunghui Lee.
> >


