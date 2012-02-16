From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH 4/4] ARM: SAMSUNG: move the mmc platdata header file to linux/mmc/
Date: Thu, 16 Feb 2012 23:45:04 +0900
Message-ID: <CAELcNGR7ooTwaNL9p3=hPkBRiOURckPJPTG0LfUjnW4AEEnMuA@mail.gmail.com>
References: <4F39EB0D.90905@samsung.com>
	<4F3CFD00.6020909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab2BPOpG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2012 09:45:06 -0500
In-Reply-To: <4F3CFD00.6020909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

2012/2/16 Kukjin Kim <kgene.kim@samsung.com>:
> On 02/14/12 14:03, Jaehoon Chung wrote:
>>
>>
>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin-park<kyungmin.park@samsung.com>
>> ---
>> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 59 +------------=
-------
>> =A0include/linux/mmc/sdhci-s3c.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 84
>> ++++++++++++++++++++++++++++
>> =A02 files changed, 85 insertions(+), 58 deletions(-)
>> =A0create mode 100644 include/linux/mmc/sdhci-s3c.h
>>
> Hi,
>
> I don't agree with this.
> Basically, the components(struct s3c_sdhci_platdata and some enums) y=
ou
> moved here are just for platform data on each board in arch/arm/.
Hi Mr. Kukjin.

I didn't think so. That components are the board specific. right?
=46or example, dw_mmc.h and  sdhci-spear.h are included the board-data.
But that didn't locate in arch/arm/. there are linux/mmc/.

I think no problem that move to linux/mmc/.

But that's right that s3cxxx_setup_sdhci0_cfg_gpio() or
exynos_setup_sdhciX_cfg_gpio
located in arch/arm/.

That's platdata but that is also generic platdata.
That platdata structure didn't change whatever.

What's problem?

Best Regards,
Jaehoon Chung

>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
