Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA1C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8083C61186
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhKHQE1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:04:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:33174 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHQE1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 11:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636387265;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9gQJ+8te3UTuKnqS6mILMU9387N1gvJoGGc2kbCSpSg=;
    b=kQxTpR2gkUA0NJfVP+/JA3dsuAnOcRfp60ou2InoBhpk+vi8drLHJvdIrmtVr2qEqs
    FrkfytFlRZ0vaAie1KQh3f1vLoquSA2+7epVFblqlytpMYlIG2WiWATKOEfs2edlQ+Nz
    SlqfaVtt/DGt/CE94vbpom8CvJCCYLhN7FmOqUUvetSeYOLf0pN935hG3SyxYCh0hRP0
    6PzHP+vKuQcnAqsJOpspjQDAS8c5F1A8r3NmlM4iwFpHs0QkeYASanXh8yK2lrsM6Z1M
    sE/6wOZFgRvKAe+KVGi1Xk0khy5q1J2J+Vetevqrlfy5zjhKyS+HmOTGN0vmgM9uNpH+
    JjNA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3gMZ+"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA8G12LY8
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 8 Nov 2021 17:01:02 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC v4 2/6] mmc: core: allow to match the device tree to apply
 quirks
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <10252914.21crK1JNra@pc-42>
Date:   Mon, 8 Nov 2021 17:01:01 +0100
Cc:     Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>,
        =?utf-8?Q?Gra=C5=BEvydas_Ignotas?= <notasas@gmail.com>,
        linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8874B3D3-E2D1-4743-B9B6-F2FD3EB4033F@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
 <7121F069-56C7-402C-BA82-A922B1A36587@goldelico.com>
 <CAPDyKFo09xhaWbGgWuPa2=x0zXCfir0VMDhd4ZdSc8rh25nG9A@mail.gmail.com>
 <10252914.21crK1JNra@pc-42>
To:     =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> Am 08.11.2021 um 16:34 schrieb J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>:
>=20
> On Monday 8 November 2021 16:00:02 CET Ulf Hansson wrote:
>> On Sat, 6 Nov 2021 at 15:31, H. Nikolaus Schaller <hns@goldelico.com> =
wrote:
>>>=20
>>> Hi J=C3=A9r=C3=B4me,
>>>=20
>>>> Am 05.11.2021 um 15:27 schrieb J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>:
>>>>=20
>>>> On Friday 5 November 2021 10:05:47 CET H. Nikolaus Schaller wrote:
>>>>> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>>>>>=20
>>>>> MMC subsystem provides a way to apply quirks when a device match =
some
>>>>> properties (VID, PID, etc...) Unfortunately, some SDIO devices =
does not
>>>>> comply with the SDIO specification and does not provide reliable =
VID/PID
>>>>> (eg. Silabs WF200).
>>>>>=20
>>>>> So, the drivers for these devices rely on device tree to identify =
the
>>>>> device.
>>>>>=20
>>>>> This patch allows the MMC to also rely on the device tree to apply =
a
>>>>> quirk.
>>>>>=20
>>>>> Signed-off-by: J=C3=A9r=C3=B4me Pouiller =
<jerome.pouiller@silabs.com>
>=20
> [...]
>=20
>>>>> ---
>>>>> drivers/mmc/core/card.h   |  3 +++
>>>>> drivers/mmc/core/quirks.h | 17 +++++++++++++++++
>>>>> 2 files changed, 20 insertions(+)
>>>>>=20
>>>>> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card =
*card,
>>>>> +                                                const char *const =
*compat_list)
>>=20
>> After a second thought, I am not sure we really need a list of
>> compatibles here. The quirks we may want to apply should be specific
>> per device and most likely not shared among a family of devices, =
don't
>> you think?
>=20
> Indeed. I dislike to have to declare a list of compatible device (see=20=

> wl1251_compatible_list in patch 5) outside of the fixup list.
>=20
> If I have several devices, I prefer to copy-paste a few lines in the=20=

> mmc_fixup list (for the WFX driver, I have 4 devices to declare).

Agreed. It makes the macro easier to use.

BR and thanks,
Nikolaus=
