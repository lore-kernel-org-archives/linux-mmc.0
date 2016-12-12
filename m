From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: SDIO bus hang on BayTrail machines
Date: Mon, 12 Dec 2016 17:55:35 -0500
Message-ID: <CA+A7VXXmA1KGjPfnUmZPBKDXmUMYhjLeXbo=8Ho3CrCvt7rjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34399 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbcLLW4R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2016 17:56:17 -0500
Received: by mail-yw0-f195.google.com with SMTP id a10so8874072ywa.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2016 14:56:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, linux-mmc@vger.kernel.org, linux@endlessm.com

Hello Dong Adrian and Ulf,

I'm working on enabling a BayTrail-based machine with very similar
hardware to one of the Intel Compute sticks, which is an Intel
BayTrail and has a RTL8723BS WiFi card on the SDIO bus. I'm using
Linux 4.8 with the driver from https://github.com/hadess/rtl8723bs,
and I was experiencing a complete machine hang when using the WiFi
card. Passing `intel_idle.max_cstate=3D1` together with the following
patch (with the sdhci_runtime_pm_get and sdhci_runtime_pm_put
implementations added back) makes the problem go away:
https://github.com/hadess/rtl8723bs/blob/master/patches_4.5/0002-mmc-sdhci-=
get-runtime-pm-when-sdio-irq-is-enabled.patch

I could not find much information on why this was never sent upstream,
and would like to know if this approach would be acceptable, or if
there are any other better alternatives to solve this problem. I'm not
a runtime PM expert, but as I understand this keeps the device powered
on as long as interrupts are enabled, potentially increasing the power
consumption. As this kernel has to run several different machines
using the same code base and config, I would rather avoid something
that could have a negative impact on other platforms.

Any ideas appreciated, and I'm happy to try a newer tree if you guys
think some other commit might have fixed the problem.

Thanks and best regards,

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
