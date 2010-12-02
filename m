From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH v4] mmc: Make ID freq configurable
Date: Fri, 03 Dec 2010 05:21:10 +0800
Message-ID: <4CF80DC6.1020801@yahoo.es>
References: <4C80187D.9000304@yahoo.es> <1291288582.15187.91.camel@stummala-linux.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout03.eigbox.net ([66.96.187.3]:43817 "EHLO
	bosmailout03.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144Ab0LBVxv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 16:53:51 -0500
In-Reply-To: <1291288582.15187.91.camel@stummala-linux.in.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>, Chris Ball <cjb@laptop.org>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

Hi Sahitya,

On 2-12-2010 19:16, Sahitya Tummala wrote:
> Hi Hein Tibosch,
>
> On Fri, 2010-09-03 at 05:34 +0800, Hein_Tibosch wrote:
>> In the latest releases of the mmc driver, the freq during initialization
>> is set to a fixed 400 Khz. This was reportedly too fast for several
>> users. As there doesn't seem to be an ideal frequency which-works-for-all,
>> Pierre suggested to let the driver try several frequencies.
>> <cut>
>> +		/*
>> +		 * First we search for SDIO...
>> +		 */
>> +		err = mmc_send_io_op_cond(host, 0, &ocr);
>> +		if (!err) {
>> +			if (mmc_attach_sdio(host, ocr)) {
>> +				mmc_claim_host(host);
>> +				/* try SDMEM (but not MMC) even if SDIO is broken */
>> +				if (mmc_send_app_op_cond(host, 0, &ocr))
> In case of SDIO error, mmc_power_off() is getting called as part of
> mmc_detach_bus().  Shouldn't we power up the host before checking for
> SDMEM? Any comments?
>
I think you should ask Michal Miroslaw, as he wrote the patch for the
SD-combo (IO + mem)*

But yes, in case of a failure, mmc_attach_sdio() will call mmc_detach_bus()
which in turn will call mmc_power_off()

And so it should be mmc_power_up() again before trying to detect SD memory.


Hein Tibosch

* http://permalink.gmane.org/gmane.linux.kernel.mmc/2052
