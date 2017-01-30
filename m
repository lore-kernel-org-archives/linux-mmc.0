From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 0/6] mmc: core: Enable mmc hosts to specify support for
 eMMC DDR 3.3V
Date: Mon, 30 Jan 2017 10:13:12 +0100
Message-ID: <452fe897-6747-b929-f868-ef08c038b83c@i2se.com>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50442 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbdA3JOc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 04:14:32 -0500
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

Am 25.01.2017 um 16:12 schrieb Ulf Hansson:
> It's been reported that some mmc hosts don't support a VCCQ (signal voltage) of
> 1.8V for eMMC DDR mode, but instead only 3.3V. According to the JEDEC spec, an
> eMMC card must support both if any, which makes the mmc host being the
> potential limitation. Therefore, let's invent a new mmc cap, MMC_CAP_3_3V_DDR,
> and a new corresponding DT binding, which tells whether 3.3V is supported for
> the VCCQ.
>
> In the context of these changes, I took the opportunity to make some clean-ups
> of some related code.

I know this series has already been merged, but i want to mention that
it works fine with mxs-mmc on a i.MX28.

Thanks
