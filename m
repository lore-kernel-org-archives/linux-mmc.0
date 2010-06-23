From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH] MMC: add support for the Marvell platform SDHCI
	controller
Date: Wed, 23 Jun 2010 15:11:04 +0300
Message-ID: <AANLkTimqyW5Q9YTsZ1YA0nLDXRYKuTuoaKH-C9wiQFqK@mail.gmail.com>
References: <1277215742-25994-1-git-send-email-saeed@marvell.com>
	<87631a6k60.fsf@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61012 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0FWMLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2010 08:11:08 -0400
Received: by wwc33 with SMTP id 33so935040wwc.19
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jun 2010 05:11:05 -0700 (PDT)
In-Reply-To: <87631a6k60.fsf@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Saeed Bishara <saeed@marvell.com>, linux-mmc@vger.kernel.org

On Wed, Jun 23, 2010 at 2:52 PM, Matt Fleming <matt@console-pimps.org> =
wrote:
> On Tue, 22 Jun 2010 17:09:02 +0300, Saeed Bishara <saeed@marvell.com>=
 wrote:
>> This patch implements the driver for the platfrom SDHCI controllers =
that found on some of Marvell's SoC's.
>>
>> Signed-off-by: Saeed Bishara <saeed@marvell.com>
>
> That's a nice, small driver ;-)
>
> [...]
>
>> +
>> + =C2=A0 =C2=A0 if (!devm_request_mem_region(&pdev->dev, iomem->star=
t,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size(iomem=
),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_hostname(host->=
mmc))) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "can=
not request region\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EBUSY;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_request;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 host->ioaddr =3D devm_ioremap(&pdev->dev, iomem->sta=
rt,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_size(iomem));
>> + =C2=A0 =C2=A0 if (!host->ioaddr) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev, "fai=
led to remap registers\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_request;
>> + =C2=A0 =C2=A0 }
>
> If you fail to remap the registers shouldn't you release the mem_regi=
on
> you've allocated above?
the point behind the devm_ (device managed) resouce allocation is not
to do the free explicitly, the kernel does that on behalf of the
driver.
>
>> +
>> +#if defined(CONFIG_HAVE_CLK)
>> + =C2=A0 =C2=A0 mv_host->clk =3D clk_get(&pdev->dev, NULL);
>> + =C2=A0 =C2=A0 if (IS_ERR(mv_host->clk))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_notice(&pdev->dev, "=
cannot get clkdev\n");
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(mv_host->clk)=
;
>> +#endif
>> +
>> + =C2=A0 =C2=A0 ret =3D sdhci_add_host(host);
>> + =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_request;
>
> Likewise here, I think you should be iounmap()'ing the registers if t=
his
> fails. Otherwise this looks good.
ditto
>
