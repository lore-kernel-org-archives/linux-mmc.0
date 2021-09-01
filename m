Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8637C432BE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF82060238
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbhIAIJL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28751 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242944AbhIAIJK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2021 04:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630483694; x=1662019694;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=acPplmh0ZzLic81uLKmpts3O5q+lr1KahcYPlLs7V4k=;
  b=DE+K/oK2jQzSGAimWE4+Xwq1MXpdIckGAx3srXcCxf2vHl0UHB8O8yiA
   4R9CWPXdcpUBMIfyAIvGLNm/zeWTpaInDoEpA6lJ3baSaZ9PwkaTC+daG
   TPLSLXsiMJf3yawVxRlylmLJHyS+ysUBnaLTkoJOPL9bFOIDpeZefeq1s
   n/ALQ2afiIKb1xsfMSMlcZt5PYf5HgtZbJTfY3DiWnXxuJZ/lSB2IwS4V
   xNIcUM+6HrfKzZuRp9Fxpl1VEd1XiKJ+inIcAswzaZm9T86wcRs4rfrwc
   z4sDw3QgNmUUE3CxDdPGvQNIo8sqx8RjeDO5YB4Q0kWmO5NhE6rZeVqIw
   w==;
IronPort-SDR: kWMl6HsB5SgWyvu2N3W+ufhxksxZyoFQ8axuwNcDjIUF7M+7kjrnMO0jxZgjLoZefFOyl9B7lY
 tkg7wh0DO52PljrkzAYUZZYuIigt6lhoCE83LCF09X799GS+351+bVZqAdm1XJEjF+8fM6pxJX
 JgF1hAOFhGiyzzZFxSh9t3Ps76TMXFxHip3WO38/eJVaj0XHvLAjNi5J4twgY99TV0ZR/EN3L/
 TWPQ8lDCXchCRdMVC/OGCZGO2Ru0kM7VhsVj8VrsqEEfQTOryhOMZamENN3x/XOe+2ouMQGgch
 8lxOziPK4PkpJqJPkAkHkwCg
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="134402103"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 01:08:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 01:08:12 -0700
Received: from [10.12.72.234] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 1 Sep 2021 01:08:10 -0700
Subject: Re: [PATCH v3 0/4] mmc: pwrseq: sd8787: add support wilc1000 devices
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
 <CAPDyKFrcBS2tf32H9+wsy7=TsHkaqtw0cZcSAgZc3XjnLzJ__w@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d8bf8840-4b13-7f95-8fe3-243c3d27a2e4@microchip.com>
Date:   Wed, 1 Sep 2021 10:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrcBS2tf32H9+wsy7=TsHkaqtw0cZcSAgZc3XjnLzJ__w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/2021 at 16:56, Ulf Hansson wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 20 Aug 2021 at 11:30, Claudiu Beznea
> <claudiu.beznea@microchip.com> wrote:
>>
>> Hi,
>>
>> This series adds support for WILC1000 devices on pwrseq-sd8787 driver.
>> WILC1000 devices needs a minimum delay of 5ms b/w reset and power lines.
>> Adapt the sd8787 driver for this by adding a new compatible for WILC1000
>> devices and specify the delay on .data field of struct of_device_id.
>>
>> Thank you,
>> Claudiu Beznea
>>
>> Changes in v3:
>> - fixed dt binding compilation
>>
>> Changes in v2:
>> - changed cover letter title (it was: mmc: pwrseq: sd8787: add support
>>    for selectable)
>> - use new compatible in pwrseq-sd8787 driver instead of adding a new
>>    binding for specifying the delay; with this, the patch 1/1 from v1 is
>>    not necessary
>> - adapt patch 3/3 from this version with the new compatible
>>
>>
>> Claudiu Beznea (3):
>>    dt-bindings: pwrseq-sd8787: add binding for wilc1000
>>    mmc: pwrseq: sd8787: add support for wilc1000
>>    mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
>>
>> Eugen Hristev (1):
>>    ARM: dts: at91: sama5d27_wlsom1: add wifi device
>>
>>   .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  4 +-
>>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 71 +++++++++++++++++++
>>   drivers/mmc/core/Kconfig                      |  2 +-
>>   drivers/mmc/core/pwrseq_sd8787.c              | 11 ++-
>>   4 files changed, 84 insertions(+), 4 deletions(-)
>>
> 
> Applied patch1 -> patch3, thanks! I leave patch 4 for soc maintainers.

Perfect, we take care of patch 4 through at91 -> arm-soc trees for 5.16 
kernel timeframe.

Best regards,
   Nicolas


-- 
Nicolas Ferre
