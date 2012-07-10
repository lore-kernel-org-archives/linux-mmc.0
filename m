From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: host: sdhci.  UHS Switch failure - cycle power if regulator is used
Date: Mon, 09 Jul 2012 23:26:03 -0400
Message-ID: <87hatgthys.fsf@octavius.laptop.org>
References: <1340813700-10898-1-git-send-email-prakity@marvell.com>
	<4FFA701A.8010100@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58114 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075Ab2GJD0J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jul 2012 23:26:09 -0400
In-Reply-To: <4FFA701A.8010100@amd.com> (Aaron Lu's message of "Mon, 9 Jul
	2012 13:46:02 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: philipspatches@gmail.com, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Mon, Jul 09 2012, Aaron Lu wrote:
> On 06/28/2012 12:15 AM, philipspatches@gmail.com wrote:
>> From: Philip Rakity<prakity@marvell.com>
>>
>> Power needs to be removed from the card when switching to 1.8v fails.
>>
>> If a regulator is used to control vmmc we need to turn the
>> regulator off and then back on otherwise power will not be removed
>> from the card.
>
> Reviewed-by: Aaron Lu <aaron.lu@amd.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
