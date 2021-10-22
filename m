Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC0BC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CA06109F
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhJVK4U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbhJVK4U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 06:56:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7C0C061764
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 03:54:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e19so1467732edy.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SufbxFFkmOyAJlRjzEYel5xu1nqdLgXz/uAgZqqunrk=;
        b=Xv0AtiVXqEEUQO7OcP2PJHdxN5BlkMLNsA0fbCRE+xaZe7gGDLxthLqIc8KKktqF6F
         XYjXQp/++cyc8lt+ljG26Ra/vmcc5jmE3eFSczGT2sV+gOuZFf5Woqvb+C9yECHpEccB
         BbNg7gwj1bX2seCFiEiYkTfbkcj0qEUua4DCILjrtwlqvJQCjun47T5wSC0dogql4NSc
         mwXi7Mo4amoAfsiGr4CDBDGuiCo0O14x3VWrrFuzmdJkpcWOZgTcZ2Ur8/egWJI9YIGX
         Yk4lPg7vKexlKgIw9cS2QAiqLPOt1LK5Tg6AwxndvF9O1kMZkMLU+aCi0AdI8ohKnFup
         Pu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SufbxFFkmOyAJlRjzEYel5xu1nqdLgXz/uAgZqqunrk=;
        b=phklNJ1QRNeshS9Wx/2g5KLPu0UNRjWVrNWPrOeEc6O0xwR8FcS8yGfAzMbH3JIV85
         DjobsEQ8MCF3lJDQrXcM1ASfczHWb67CFOzDw6kN+bi36HkCrQDhkS1J/UAY04Ti/kKY
         uhvtZcnrQ6zSIxazay5qMC2pMzcV8VoijWL3MpzN/inlfvxWdnD2bhZkU1NMeJL3WKZ0
         1ZxSCimm5X3uQz1k+Dl8vsP8UYlfbK2BolDGZr/rOl+Am6eRGJr/W1+A2NfHzyTs6g+g
         ASSTGaZu+ZYV3HAjYt7Dn7FNKVExAwyo9gpSj5yXuWt3tLB5583GKm+og0yzhR/NcLU8
         a/vg==
X-Gm-Message-State: AOAM531B4+/vYCAvkQg+nzmqHzcp7JWeHRVwe8cqSEyoc5FTJ//hdwhi
        Kghg6a1NUCUZETCcVnvFZyY=
X-Google-Smtp-Source: ABdhPJzh7XsqQeLDSkHYxV7JT5aVhGt0840T9wY7wVcc4k6XdV5pODg8Z3D+uxLAn/qu8xBc3I+cOg==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr14672940ejr.435.1634900040749;
        Fri, 22 Oct 2021 03:54:00 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id hp3sm3252666ejc.61.2021.10.22.03.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Oct 2021 03:54:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: fix the finding clock sample
 value
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20211022082106.1557-1-jh80.chung@samsung.com>
Date:   Fri, 22 Oct 2021 14:53:57 +0400
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        krzysztof.kozlowski@canonical.com,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        m.szyprowski@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DD814C1-8534-4762-BD41-DE941C16DC92@gmail.com>
References: <CGME20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910@epcas1p3.samsung.com>
 <20211022082106.1557-1-jh80.chung@samsung.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


> On 22 Oct 2021, at 12:21 pm, Jaehoon Chung <jh80.chung@samsung.com> =
wrote:
>=20
> Even though there are candiates value if can't find best value, it's
> returned -EIO. It's not proper behavior.
> If there is not best value, use a first candiate value to work eMMC.
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

v2 patch working fine with the module that triggered the original =
report:

[    2.902144] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 400000Hz, actual 396825HZ div =3D 63)
[    2.912118] mmc_host mmc1: Bus speed (slot 0) =3D 50000000Hz (slot =
req 400000Hz, actual 396825HZ div =3D 63)
[    3.142474] mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot =
req 200000000Hz, actual 200000000HZ div =3D 0)
[    3.239339] mmc_host mmc0: Bus speed (slot 0) =3D 50000000Hz (slot =
req 52000000Hz, actual 50000000HZ div =3D 0)
[    3.241388] mmc_host mmc0: Bus speed (slot 0) =3D 266666666Hz (slot =
req 200000000Hz, actual 133333333HZ div =3D 1)
[    3.243310] mmc0: new HS400 MMC card at address 0001
[    3.259191] mmcblk0: mmc0:0001 8GME4R 7.28 GiB=20
[    3.302621]  mmcblk0: p1 p2
[    3.311541] mmcblk0boot0: mmc0:0001 8GME4R 4.00 MiB=20
[    3.327737] mmcblk0boot1: mmc0:0001 8GME4R 4.00 MiB=20
[    3.340919] mmcblk0rpmb: mmc0:0001 8GME4R 512 KiB, chardev (246:0)

Thanks!

> ---
> Changelog V2:
> - Add Marek's Tested-by tag
> - Remove unnecessary code
>=20
> drivers/mmc/host/dw_mmc-exynos.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c =
b/drivers/mmc/host/dw_mmc-exynos.c
> index 0c75810812a0..1f8a3c0ddfe1 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -464,6 +464,18 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 =
candiates)
> 		}
> 	}
>=20
> +	/*
> +	 * If there is no cadiates value, then it needs to return -EIO.
> +	 * If there are candiates values and don't find bset clk sample =
value,
> +	 * then use a first candiates clock sample value.
> +	 */
> +	for (i =3D 0; i < iter; i++) {
> +		__c =3D ror8(candiates, i);
> +		if ((__c & 0x1) =3D=3D 0x1) {
> +			loc =3D i;
> +			goto out;
> +		}
> +	}
> out:
> 	return loc;
> }
> @@ -494,6 +506,8 @@ static int dw_mci_exynos_execute_tuning(struct =
dw_mci_slot *slot, u32 opcode)
> 		priv->tuned_sample =3D found;
> 	} else {
> 		ret =3D -EIO;
> +		dev_warn(&mmc->class_dev,
> +			"There is no candiates value about clksmpl!\n");
> 	}
>=20
> 	return ret;
> --=20
> 2.29.0
>=20

