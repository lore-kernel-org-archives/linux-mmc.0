From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: [PATCH] mmc: mxs-mmc: implement broken-cd
Date: Thu, 20 Sep 2012 07:45:39 +0300
Message-ID: <505A9F73.7090702@bluegiga.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com> <20120910060840.GT26709@S2101-09.ap.freescale.net> <504DBB10.9030702@bluegiga.com> <20120910135034.GD13076@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [194.100.31.45] ([194.100.31.45]:37387 "EHLO
	darkblue.bluegiga.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab2ITEqC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 00:46:02 -0400
In-Reply-To: <20120910135034.GD13076@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, veli-pekka.peltola@bluegiga.com

Hi,

On 09/10/2012 04:50 PM, Shawn Guo wrote:
> On Mon, Sep 10, 2012 at 01:04:00PM +0300, Lauri Hintsala wrote:
>>>> @@ -187,6 +188,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>>>>   {
>>>>   	struct mxs_mmc_host *host = mmc_priv(mmc);
>>>>
>>>> +	if (host->broken_cd)
>>>> +		return -ENOSYS;
>>>> +

...

> But for this patch:
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Any chance to get this patch for 3.7? It makes possible to use the 
driver without a card detect signal.

Regards,
Lauri
