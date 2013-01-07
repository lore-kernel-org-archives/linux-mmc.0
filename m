From: "Dr. Rainer Kaluscha" <rainer.kaluscha@web.de>
Subject: Re: [PATCH 1/2] regulator: add regulator_is_dummy function
Date: Mon, 07 Jan 2013 13:30:54 +0100
Message-ID: <50EABFFE.9070908@web.de>
References: <1357537131-8000-1-git-send-email-kliu5@marvell.com> <20130107112527.GD4544@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59131 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab3AGMa7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 07:30:59 -0500
In-Reply-To: <20130107112527.GD4544@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

Am 07.01.2013 12:25, schrieb Mark Brown:
> On Mon, Jan 07, 2013 at 01:38:50PM +0800, Kevin Liu wrote:
>> Introduce a regulator_is_dummy function to check whether the
>> regulator is dummy.
>
> No, we've been through this repeatedly.  Whatever problem you're trying
> to bodge around is going to be a problem with some real physical
> regulators too.

Though I don't know the previous discussion, this seems a different case to me.

The problem is that *only* a dummy regulator is available which refuses to do any regulation at 
all.
So sdhci/mmc should better behave as no regulator was available at all.
This may happen if e.g. in a precompiled kernel of some linux distro regulator support 
(including dummy) is enabled but the machine running that kernel doesn't have a known hardware 
regulator. This results in sdhci/mmc failing to enable the SD card reader though it would work 
well without regulator support in the kernel.

Rainer



