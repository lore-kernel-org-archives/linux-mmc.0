From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v5] mmc: support BKOPS feature for eMMC
Date: Sat, 07 Jan 2012 21:21:29 -0500
Message-ID: <m2pqevvsra.fsf@bob.laptop.org>
References: <4F04F512.1020909@samsung.com>
	<CANfBPZ-RV=9qMm95yaN3J8no10ZBMa+sB+tO2qpqOZMVpbx-8g@mail.gmail.com>
	<17296D9F8FF2234F831FC3DF505A87A90FCB43D7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57880 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab2AHCV4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 7 Jan 2012 21:21:56 -0500
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A90FCB43D7@SHSMSX101.ccr.corp.intel.com>
	(Chuanxiao Dong's message of "Sun, 8 Jan 2012 02:18:44 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, "per.forlin@stericsson.com" <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

Hi,

On Sat, Jan 07 2012, Dong, Chuanxiao wrote:
>> In my understanding, the EXT_CSD_BKOPS_EN should be _updated_by_ the
>> host controller to 1 at initialization time, to indicate to the
>> device, as per the spec.
>> Otherwise, the device would decide that the host doesn't support
>> software controlled BKOPS.
>
> EXT_CSD_BKOPS_EN is a onetime programmable register, which is not
> suitable for driver to touch I think. This can be updated by host
> controller, but should not happened in driver. This register can be
> configured by some platform firmware or some eMMC FW from vendor. For
> what driver needs to do, is just to read this onetime programmable and
> to know whether BKOPS is enabled. It is like hardware reset
> feature. RST_n_FUNCTION is only a onetime programmable register which
> can indicate whether hardware reset feature is enabled. Driver just
> needs to read it out and to know whether hardware reset feature can be
> used. So I agree with Jaehoon Chung's implementation.

I agree -- we don't touch fuses in the driver.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
