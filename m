From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Thu, 2 Jul 2015 10:35:16 +0800
Message-ID: <CAAfSe-uuO5VYA9_x_6mog9r=KNTtudRCqz7q46TZhWw8BagMKA@mail.gmail.com>
References: <sprd-mmc-rfc@samsung.com>
	<1435734774-10993-1-git-send-email-chunyan.zhang@spreadtrum.com>
	<5593B971.1010601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34131 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbbGBCfR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 22:35:17 -0400
In-Reply-To: <5593B971.1010601@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>, ulf.hansson@linaro.org, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, billows.wu@spreadtrum.com, =?UTF-8?B?V2VpIFFpYW8gKOS5lOS8nyk=?= <wei.qiao@spreadtrum.com>, baolin.wang@spreadtrum.com, ning.yang@spreadtrum.com, orson.zhai@spreadtrum.com, jason.wu@spreadtrum.com, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, chris@printf.net

On Wed, Jul 1, 2015 at 5:57 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> Is sdhost based on SDHCI controller?
> Why don't use sdhci.c? Is there any reason?
>
> Best Regards,
> Jaehoon Chung
>

Because of base64 code problem of his email server, I'm reporting his
reply instead.

>From Billows Wu <billows.wu@spreadtrum.com>
----------------------------------------------------------------------------------------------------------------------------------------
Hi Jaehoon,
Sdhost driver is not based on SDHCI controller.
Our MMC controller is not a standard controller which meets host
controller specification completely.
We add some registers and change some bits in the remaining register,
such as about clock and regulator portion.
If our driver base on SDHCI controller, we must change many codes in
sdhci.c, and our MMC driver will become more complicated.
In order to better use our controller capability and make MMC driver
more compact, we do not use SDHCI controller.

Thanks.
--------------------------------------------------------------------------------------------------------------------------------------------------
