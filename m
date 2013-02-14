From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: host: sdhci: Fix parameter of sdhci_do_start_signal_voltage_switch()
Date: Thu, 14 Feb 2013 16:04:27 -0500
Message-ID: <87bobmli90.fsf@octavius.laptop.org>
References: <1360845303-21620-1-git-send-email-fabio.estevam@freescale.com>
	<CA+20K0A4tWsmxrLJ+Enba3GPa8W0-E_tPvzaSL4izCF1x=K8uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60676 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759224Ab3BNVEd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Feb 2013 16:04:33 -0500
In-Reply-To: <CA+20K0A4tWsmxrLJ+Enba3GPa8W0-E_tPvzaSL4izCF1x=K8uQ@mail.gmail.com>
	(Johan Rudholm's message of "Thu, 14 Feb 2013 13:56:53 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, kliu5@marvell.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, arnd.bergmann@linaro.org

Hi,

On Thu, Feb 14 2013, Johan Rudholm wrote:
> 2013/2/14 Fabio Estevam <fabio.estevam@freescale.com>:
>> Commit 3714f4315354 (mmc: sdhci: update signal voltage switch code)
>> changed the
>> type of the second parameter of sdhci_do_start_signal_voltage_switch(), from
>> "struct mmc_ios *ios" to "int signal_voltage" which causes the following build
>> warning:
>>
>> drivers/mmc/host/sdhci.c:2044:2: warning: initialization from
>> incompatible pointer type [enabled by default]
>> drivers/mmc/host/sdhci.c:2044:2: warning: (near initialization for
>> sdhci_ops.start_signal_voltage_switch') [enabled by default]
>>
>> Use the previous type so that it matches the start_signal_voltage_switch()
>> definition from host.h.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Reviewed-by: Johan Rudholm <johan.rudholm@stericsson.com>

Pushed to mmc-next for 3.9.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
