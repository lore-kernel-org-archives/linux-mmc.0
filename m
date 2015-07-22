From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Update driver to support without regulators
Date: Wed, 22 Jul 2015 17:47:02 +0530
Message-ID: <55AF89BE.3000208@ti.com>
References: <1436902186-6542-1-git-send-email-fcooper@ti.com>	<CAPDyKFq8NVqkZQ_8oL_5JM0_wYK6-gTaXr9ExHLa767tmcpxxA@mail.gmail.com>	<55AEA008.6050808@ti.com>	<55AF822F.8060507@ti.com> <CAPDyKFpVh3EDJLX--h3H4qa4EDy2nDJQeRZtPQ8+uU9K43b_Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33136 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934035AbbGVMRH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 08:17:07 -0400
In-Reply-To: <CAPDyKFpVh3EDJLX--h3H4qa4EDy2nDJQeRZtPQ8+uU9K43b_Tg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>

Hi,

On Wednesday 22 July 2015 05:37 PM, Ulf Hansson wrote:
> [...]
> 
>> Hi Ulf,
>>
>> Just to clarify do you have an issue with this patch or in general
>> you rather nothave !CONFIG_REGULATOR supported? If its the latter
>> then wouldit be better to remove the !CONFIG_REGULATOR portion from
>> this driver all together.
> 
> I don't like this patch as is, as it seems like you are replacing the
> VMMC regulator that actually exist in HW by parsing a DT property.
> 
> I think mmc_of_parse_voltage() shall *only* be used when the OCR mask
> (->ocr_avail) can't be fetched by using a regulator. Typically that's
> when the VMMC voltage levels are managed within the mmc controller
> itself.
> 
> I don't have a strong opinion on how you solve that, but I guess you
> have two options.
> 
> 1.
> Make sure the driver can be build and used both for CONFIG_REGULATOR
> and !CONFIG_REGULATOR. What you need to take care of then, is to
> assign the ->ocr_avail mask to a default value in the case when it
> can't be fetched from a regulator. Most mmc drivers has some kind of
> fall-back mechanism like this.

I'm working on cleaning up omap_hsmmc driver where I have taken care to avoid
dependency with CONFIG_REGULATOR. I'll post the series asap.

Thanks
Kishon
