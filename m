From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 4/7] mmc: sdhci-pxav3: Modify clock settings for the
 SDR50 and DDR50 modes
Date: Thu, 29 Jan 2015 09:51:07 +0100
Message-ID: <54C9F47B.1020200@free-electrons.com>
References: <1422031587-18212-1-git-send-email-gregory.clement@free-electrons.com>	<1422031587-18212-5-git-send-email-gregory.clement@free-electrons.com> <CAPDyKFpTnGrdKLYjH=GaG2bQ-44F68fSxRvRQBi8bHP5A83Ahw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58791 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750790AbbA2IvM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 03:51:12 -0500
In-Reply-To: <CAPDyKFpTnGrdKLYjH=GaG2bQ-44F68fSxRvRQBi8bHP5A83Ahw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>

Hi Ulf,

[...]

>> +               dev_warn(&pdev->dev, "conf-sdio3 register not found\n");
>> +               dev_warn(&pdev->dev, "disabling SDR50 and DDR50 modes\n");
>> +               dev_warn(&pdev->dev, "consider updating your dtb\n");
> 
> One dev_warn() should be enough. Also I don't think checkpatch
> complains about long lines for dev_warn().

Right. Once you will have told if you sill want a change or not in patch 1,
I will send a new version with this change.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
