From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef system suspend
Date: Tue, 3 Jan 2012 00:24:53 +0900
Message-ID: <CAELcNGTVj854nre5zNSmPXEHcWA2ujvauQm2eiYtv5PBYxUJvw@mail.gmail.com>
References: <1325211872-12567-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F01117F.6000206@samsung.com>
	<20120102114925.GF2899@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52952 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab2ABPYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2012 10:24:54 -0500
Received: by eaad14 with SMTP id d14so8043484eaa.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2012 07:24:53 -0800 (PST)
In-Reply-To: <20120102114925.GF2899@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

2012/1/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 02, 2012 at 11:07:59AM +0900, Jaehoon Chung wrote:
>> On 12/30/2011 11:24 AM, Mark Brown wrote:
>
>> > +#include <linux/pm.h>
>
>> I think this include is unnecessary.
>
> I think you are wrong. =A0What makes you say that you think it is not
> needed?
If that didn't include,,what's happen?
I think that is already included...Anyway..this patch looks fine to me.=
=2E
(if use with your patch[2/2]..)

Thanks,
Jaehoon Chung
>
>> > +#ifdef CONFIG_PM
>> > =A0static const struct dev_pm_ops sdhci_s3c_pmops =3D {
>> > - =A0 .suspend =A0 =A0 =A0 =A0=3D sdhci_s3c_suspend,
>> > - =A0 .resume =A0 =A0 =A0 =A0 =3D sdhci_s3c_resume,
>> > + =A0 SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
>
> Note that above.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
