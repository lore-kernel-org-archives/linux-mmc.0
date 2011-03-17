From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] dw_mmc: support mmc power control with regulator
Date: Thu, 17 Mar 2011 15:01:39 -0400
Message-ID: <m3mxkto9kc.fsf@pullcord.laptop.org>
References: <4D670F0E.7000800@samsung.com>
	<m3ei65pqcp.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37292 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab1CQTEd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 15:04:33 -0400
In-Reply-To: <m3ei65pqcp.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 17 Mar 2011 14:13:42 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, Mar 17 2011, Chris Ball wrote:
>> @@ -1438,6 +1439,13 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  	}
>>  #endif /* CONFIG_MMC_DW_IDMAC */
>>  
>> +	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>> +	if (IS_ERR(host->vmmc)) {
>> +		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
>> +		host->vmmc = NULL;
>> +	} else
>> +		regulator_enable(host->vmmc);
>> +
>>  	if (dw_mci_get_cd(mmc))
>>  		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>  	else
>
> I think you want an "#ifdef CONFIG_REGULATOR" around this hunk.
> Please try building the driver with CONFIG_REGULATOR=n.
>
> The other hunks in the patch shouldn't need it, because they test
> "host->vcc" before making any regulator calls.

Actually, <linux/regulator/consumer.h> provides no-op versions of all
these functions if CONFIG_REGULATOR is unset, so I guess this doesn't
matter; the driver builds without CONFIG_REGULATOR as-is.

Will merge for .39 with Will's ACK, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
