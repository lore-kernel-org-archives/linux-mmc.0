From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v7 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Wed, 22 Jun 2011 11:31:16 +0200
Message-ID: <BANLkTi=GT=1u0YEtUaJre24BOhRyDNGUSg@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-3-git-send-email-per.forlin@linaro.org>
	<BANLkTikqeKg=Mr9BxVYL7x=9k_jzGeLnQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58462 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab1FVJbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2011 05:31:17 -0400
In-Reply-To: <BANLkTikqeKg=Mr9BxVYL7x=9k_jzGeLnQQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nickolay Nickolaev <nicknickolaev@gmail.com>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

On 22 June 2011 10:51, Nickolay Nickolaev <nicknickolaev@gmail.com> wro=
te:
> Hello,
>
> this one's causing me compilation trouble troubles when CONFIG_DMA_EN=
GINE is
> not defined.
>
I don't see this issue when I compile the kernel for a Pandaboard
without CONFIG_DMA_ENGINE being set. Could you please clarify or show
me your build log?
I don't see how host->next_data.cookie is connected to DMA_ENGINE.

> On Wed, Jun 22, 2011 at 2:38 AM, Per Forlin <per.forlin@linaro.org> w=
rote:
>>
>> @@ -2077,6 +2155,7 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0host->mapbase =A0 =3D res->start;
>> =A0 =A0 =A0 =A0host->base =A0 =A0 =A0=3D ioremap(host->mapbase, SZ_4=
K);
>> =A0 =A0 =A0 =A0host->power_mode =3D MMC_POWER_OFF;
>> + =A0 =A0 =A0 host->next_data.cookie =3D 1;
>>
>> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>> =A0 =A0 =A0 =A0INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_dete=
ct);
>> --
>> 1.7.4.1
>>
>>
>
> Maybe we can wrap it in a function as the others.
>
> regards,
> Nikolay Nikolaev
>

Regards,
Per
