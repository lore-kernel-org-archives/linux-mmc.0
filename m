From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: Check the return value from clk_prepare_enable()
Date: Sat, 26 Oct 2013 16:11:45 -0200
Message-ID: <CAOMZO5ADVoqiumJFCKWkX=VoS_Uj_VUO0H9V7AK-m2Z1iGJd=w@mail.gmail.com>
References: <1381351059-30650-1-git-send-email-festevam@gmail.com>
	<20131012073857.GD21305@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:52129 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab3JZSLt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Oct 2013 14:11:49 -0400
Received: by mail-ve0-f171.google.com with SMTP id pa12so3347899veb.2
        for <linux-mmc@vger.kernel.org>; Sat, 26 Oct 2013 11:11:49 -0700 (PDT)
In-Reply-To: <20131012073857.GD21305@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Chris,

On Sat, Oct 12, 2013 at 4:38 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Oct 09, 2013 at 05:37:39PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> clk_prepare_enable() may fail, so let's check its return value and propagate it
>> in the case of error.
>>
>> Also, fix the sequence for disabling the clock in the probe error path and
>> also in the remove funct
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Any comments on this one?

Regards,

Fabio Estevam
