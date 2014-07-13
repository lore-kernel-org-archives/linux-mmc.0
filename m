From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] mmc: core: hold SD Clock before CMD11 during Signal
Date: Sun, 13 Jul 2014 09:30:14 +0100
Message-ID: <20140713083014.GK21766@n2100.arm.linux.org.uk>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com> <1405228870-5088-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36938 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752246AbaGMIaX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jul 2014 04:30:23 -0400
Content-Disposition: inline
In-Reply-To: <1405228870-5088-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, arnd@arndb.de, olof@lixom.net, chris@printf.net, anton@enomsg.org, t.takinishi@jp.fujitsu.com, mollie.wu@linaro.org

On Sun, Jul 13, 2014 at 01:21:10PM +0800, Vincent Yang wrote:
> Voltage Switch Procedure
> 
> This patch is to fix an issue found on mb86s7x platforms.
> 
> [symptom]
> There are some UHS-1 SD memory cards sometimes cannot be detected correctly,
> e.g., Transcend 600x SDXC 64GB UHS-1 memory card.
> During Signal Voltage Switch Procedure, failure to switch is indicated
> by the card holding DAT[3:0] low.
> 
> [analysis]
> According to SD Host Controller Simplified Specification Version 3.00
> chapter 3.6.1, the Signal Voltage Switch Procedure should be:
> (1) Check S18A; (2) Issue CMD11; (3) Check CMD 11 response;
> (4) Stop providing SD clock; (5) Check DAT[3:0] should be 0000b;
> (6) Set 1.8V Signal Enable; (7) Wait 5ms; (8) Check 1.8V Signal Enable;
> (9) Provide SD Clock; (10) Wait 1ms; (11) Check DAT[3:0] should be 1111b;
> (12) error handling
> 
> With CONFIG_MMC_CLKGATE=y, sometimes there is one more gating/un-gating
> SD clock between (2) and (3). In this case, some UHS-1 SD cards will hold
> DAT[3:0] 0000b at (11) and thus fails Signal Voltage Switch Procedure.
> 
> [solution]
> By mmc_host_clk_hold() before CMD11, the additional gating/un-gating
> SD clock between (2) and (3) can be prevented and thus no failure at (11).
> It has been verified with many UHS-1 SD cards on mb86s7x platforms and
> works correctly.
> 
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> ---
>  drivers/mmc/core/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 7dc0c85..764af63 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1428,6 +1428,8 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
>  		pr_warning("%s: cannot verify signal voltage switch\n",
>  				mmc_hostname(host));
>  
> +	mmc_host_clk_hold(host);
> +
>  	cmd.opcode = SD_SWITCH_VOLTAGE;
>  	cmd.arg = 0;
>  	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> @@ -1438,8 +1440,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
>  
>  	if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
>  		return -EIO;
> -
> -	mmc_host_clk_hold(host);

Your analysis may be correct, but implementation leads something to be
desired - what happens if we exit the function just above this deleted
line - returning -EIO ?  Shouldn't there be some releasing of the
clock hold?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
