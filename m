From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH v2 1/2] regulator: pbias: Fix is_enabled callback implementation
Date: Wed, 9 Apr 2014 17:50:42 +0800
Message-ID: <CAFRkauDeThG0Jh_=bAuOkJx7=61xtrwFgutXywtBAfcqA8Z67g@mail.gmail.com>
References: <1394250929.3892.1.camel@phoenix>
	<CAFRkauBA0XPQvoqsUkUwHksf4WbEGi=2Ekm-AY82SNmegHDsrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:63955 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbaDIJum (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Apr 2014 05:50:42 -0400
Received: by mail-qg0-f46.google.com with SMTP id 63so1934300qgz.33
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2014 02:50:42 -0700 (PDT)
In-Reply-To: <CAFRkauBA0XPQvoqsUkUwHksf4WbEGi=2Ekm-AY82SNmegHDsrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Balaji T K <balajitk@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Stefan Roese <sr@denx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

2014-04-02 8:26 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> 2014-03-08 11:55 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
>> The is_enabled implementation is wrong in some cases:
>> e.g. for pbias_mmc_omap5: enable_mask is : BIT(27) | BIT(25) | BIT(26)
>> However, pbias_regulator_enable() only sets BIT(27) | BIT(26) bits.
>> So is_enabled callback will always return false in this case.
>> Fix the logic to compare the register value with info->enable rather than
>> info->enable_mask.
>>
>
> Hi Chris,
> Would you pick up this patch serial?

I just found Chris sent a pull request for 3.15-rc1.
So I'll resend this serial to Mark after 3.15-rc1 is out.

>
> Regards,
> Axel
