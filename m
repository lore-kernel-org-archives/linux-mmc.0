From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Sun, 20 Oct 2013 22:10:21 -0400
Message-ID: <87wql78jci.fsf@octavius.laptop.org>
References: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
	<20131018080922.GC22289@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52212 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab3JUCKa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 22:10:30 -0400
In-Reply-To: <20131018080922.GC22289@shlinux2.ap.freescale.net> (Dong
	Aisheng's message of "Fri, 18 Oct 2013 16:09:23 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi Shawn,

On Fri, Oct 18 2013, Dong Aisheng wrote:
> On Thu, Oct 17, 2013 at 03:19:43PM +0800, Shawn Guo wrote:
>> Changes since v1:
>> * Create flags only for features and errata such things, and keep using
>>   is_imx*_esdhc() for small register differences between esdhc variants.
>> 
>> Shawn Guo (4):
>>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
>>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
>>   mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
>>   mmc: sdhci-esdhc-imx: create struct esdhc_soc_data
>> 
>>  drivers/mmc/host/sdhci-esdhc-imx.c |  126 +++++++++++++++++++-----------------
>>  1 file changed, 68 insertions(+), 58 deletions(-)
>
> Acked-by: Dong Aisheng <b29396@freescale.com>
>
> I will rebase my mx6sl std tuning patch series based on it
> and send out again.

Thanks, pushed to mmc-next for 3.13 with Dong's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
