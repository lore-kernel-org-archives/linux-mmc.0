Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B80C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9FD61053
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 11:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhJVLpE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 07:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhJVLpE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 07:45:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1EC061764
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 04:42:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 5so1286076edw.7
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p3jHyV1bbwCXGq/dttKf5mmqVhtJ1s/xJMdYCd5TYqE=;
        b=MkVUZkVqt2NekzhnO4BjzIbRsm30FASvMVZ+uix/kse7xJH6Z+HVPA93qpzzJoR9Mq
         4C33qfPQWSUhF1yIvdgT/Ut8RYc1cFj7mepnH4ocQ8a024wR8/Tjt6MX5XV++IZyDXuE
         c74T3rCWJc6LUL3Pjfk/2eMwmyFZwSaeLcul9JwFLmxSQDNS8LQA9CWSTSL+9tInVvlE
         GMQgiNAZRc/+KPJXacMyhzpHhfIUpZrZ8M8ZvzvqqEj25DIB0AeKf0HhppHPJV7ck0hT
         q6cWsMuVqVz23hSDiS6k7cglN4qyzI8rCFBZFQgQKO/P4qWNbDLCX4sH0UMiOFMhXtLs
         A3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p3jHyV1bbwCXGq/dttKf5mmqVhtJ1s/xJMdYCd5TYqE=;
        b=kpWmudI7qHBlJQUPvNdLmO8A3DRiVxftw5lddUxIlbBIpb0337phulA7spUrxAqJOi
         ILdjTWje8iJ9aRta/VtOwnGbx+vtw1ElsCagZ/Y+P7v+QHw19PqvxfiwfnYWPF+f6f7I
         KDKTmiVA94CeeNVolxl4oNwzmCtEB/PReXeWwV/u6FnEojds2QBdvYT05ve6dCyvGhXu
         bPCj/dF2hAS0IOf8rxpAYmCPSbWpPNtZxPiK0y643ABfXfvUBCGdUBBEF589BU5WBIdu
         9yC4pHgJ/OwlHwtcz+4G/XgAHZfRNSdHhfSImtQRBXZ6+yD8yY9c+Oer1NU5hoxnsZxT
         a07w==
X-Gm-Message-State: AOAM533MW/kenJWk9c5jzZsfQFoB+XTnY6A5zY4CCfqzziiN9Le/db2V
        UNTHfup2xJmY4CYwR2OYiJk=
X-Google-Smtp-Source: ABdhPJyb5wv/6vCEtEEUdUr0efBt3TT+ypFp/DK15puxF+lBxkbuv8PrdCSn6qvuM5JPdZf/qMCZGA==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr16283130edf.247.1634902965064;
        Fri, 22 Oct 2021 04:42:45 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id s16sm4568747edd.32.2021.10.22.04.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Oct 2021 04:42:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: fix the finding clock sample
 value
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <9792ea4f-2696-484d-a5d7-04da270684cd@samsung.com>
Date:   Fri, 22 Oct 2021 15:42:41 +0400
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        krzysztof.kozlowski@canonical.com,
        Marian Mihailescu <mihailescu2m@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC6E985A-0F0B-4913-B829-6C2AE76978E1@gmail.com>
References: <CGME20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910@epcas1p3.samsung.com>
 <20211022082106.1557-1-jh80.chung@samsung.com>
 <8DD814C1-8534-4762-BD41-DE941C16DC92@gmail.com>
 <9792ea4f-2696-484d-a5d7-04da270684cd@samsung.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


> On 22 Oct 2021, at 3:35 pm, Marek Szyprowski =
<m.szyprowski@samsung.com> wrote:
>=20
> Hi,
>=20
> On 22.10.2021 12:53, Christian Hewitt wrote:
>>> On 22 Oct 2021, at 12:21 pm, Jaehoon Chung <jh80.chung@samsung.com> =
wrote:
>>>=20
>>> Even though there are candiates value if can't find best value, it's
>>> returned -EIO. It's not proper behavior.
>>> If there is not best value, use a first candiate value to work eMMC.
>>>=20
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>=20
>> v2 patch working fine with the module that triggered the original =
report:
>>=20
>> [    2.902144] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 400000Hz, actual 396825HZ div =3D 63)
>> [    2.912118] mmc_host mmc1: Bus speed (slot 0) =3D 50000000Hz (slot =
req 400000Hz, actual 396825HZ div =3D 63)
>> [    3.142474] mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz =
(slot req 200000000Hz, actual 200000000HZ div =3D 0)
>> [    3.239339] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 52000000Hz, actual 50000000HZ div =3D 0)
>> [    3.241388] mmc_host mmc0: Bus speed (slot 0) =3D 266666666Hz =
(slot req 200000000Hz, actual 133333333HZ div =3D 1)
>=20
> I wonder why 266666666Hz bus speed is selected instead of the=20
> 400000000Hz one. Did you remove the workaround patch which changed the=20=

> divider value from your kernel tree? I didn't analyze the code, so =
maybe=20
> this change is intentional result of this patch? On my XU4 I get=20
> 400000000Hz bus clock for the eMMC dw-mmc controller.

Yes, I removed the workaround patch before testing. It=E2=80=99s =
delivering
the same result as the workaround so perhaps it=E2=80=99s normal for =
this
module. All the emmc modules I have (all samples from HK sent at the
same time) are identical so there=E2=80=99s nothing else I can test =
with.

Christian

>> [    3.243310] mmc0: new HS400 MMC card at address 0001
>> [    3.259191] mmcblk0: mmc0:0001 8GME4R 7.28 GiB
>> [    3.302621]  mmcblk0: p1 p2
>> [    3.311541] mmcblk0boot0: mmc0:0001 8GME4R 4.00 MiB
>> [    3.327737] mmcblk0boot1: mmc0:0001 8GME4R 4.00 MiB
>> [    3.340919] mmcblk0rpmb: mmc0:0001 8GME4R 512 KiB, chardev (246:0)
>=20
> Best regards
> --=20
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland

