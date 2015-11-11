From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 16/16] mmc: host: omap_hsmmc: use "mmc_of_parse_voltage"
 to get ocr_avail
Date: Wed, 11 Nov 2015 12:40:23 +0100
Message-ID: <CAPDyKFqAknBT5nAsr27F8vA=Di4TDiKipY6eYttD+v7h3X7GUQ@mail.gmail.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
	<1438604801-11823-17-git-send-email-kishon@ti.com>
	<CAPDyKFoctSjBb0aPFNe0cyHe0uoD_DkWooQ-yyTX-P+bGJa_Vw@mail.gmail.com>
	<564317B9.8010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35774 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbKKLkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2015 06:40:24 -0500
Received: by ykba77 with SMTP id a77so43549673ykb.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2015 03:40:23 -0800 (PST)
In-Reply-To: <564317B9.8010502@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>

On 11 November 2015 at 11:26, Roger Quadros <rogerq@ti.com> wrote:
> Hi,
>
> On 25/08/15 17:50, Ulf Hansson wrote:
>> On 3 August 2015 at 14:26, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> For platforms that doesn't have explicit regulator control in MMC,
>>> populate voltage-ranges in MMC device tree node and use
>>> mmc_of_parse_voltage to get ocr_avail
>>
>> I don't like this.
>>
>> If we are able to fetch the OCR mask via an external regulator, that
>> shall be done.
>
> Agreed.
>>
>> I think the mmc_of_parse_voltage() API and the corresponding DT
>> binding it parses, should be used for those HW when we don't have an
>> external regulator to use. For example if the MMC controller itself
>> somehow controls the voltage levels. Is that really the case for you?
>
> What shall be done if there is no software control of the external regulator
> and it is fixed at a certain voltage?

I think you can model that as a so called fixed regulator.

Kind regards
Uffe
