From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH REPOST] mmc: bcm2835: set SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
Date: Mon, 11 Feb 2013 13:20:53 -0500
Message-ID: <87halipv96.fsf@octavius.laptop.org>
References: <1360382187-26296-1-git-send-email-swarren@wwwdotorg.org>
	<87k3qest87.fsf@octavius.laptop.org> <51193273.6000901@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60433 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758746Ab3BKSU5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 13:20:57 -0500
In-Reply-To: <51193273.6000901@wwwdotorg.org> (Stephen Warren's message of
	"Mon, 11 Feb 2013 11:03:31 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, Feb 11 2013, Stephen Warren wrote:
> On 02/11/2013 09:36 AM, Chris Ball wrote:
>> Hi Stephen,
>> 
>> On Fri, Feb 08 2013, Stephen Warren wrote:
>>> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK does basically the same as
>>> implementing struct sdhci_ops .get_timeout_clock, so simply set that
>>> quirk and remove the custom code to simplify the driver.
>>>
>>> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
>> 
>> This conflicts with Lars-Peter's larger patch, which I just merged --
>> I could merge the changes from both, which reduces your patch to this:
>
> Yes, that updated patch looks fine to me.
>
> I thought Lars-Peter was going to update his series on top of this
> cleanup, but either way is fine.

Thanks, pushed the updated patch to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
