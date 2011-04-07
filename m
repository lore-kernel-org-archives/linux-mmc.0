From: Chris Ball <cjb@laptop.org>
Subject: Re: Boot partition support patch set.
Date: Thu, 07 Apr 2011 17:23:53 -0400
Message-ID: <m339ltpxg6.fsf@pullcord.laptop.org>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
	<BANLkTik7nDHvNbYRMEpyOvh71pXHuVgUTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50396 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab1DGVSo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Apr 2011 17:18:44 -0400
In-Reply-To: <BANLkTik7nDHvNbYRMEpyOvh71pXHuVgUTg@mail.gmail.com> (Andrei
	Warkentin's message of "Wed, 6 Apr 2011 18:20:36 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

Hi,

On Wed, Apr 06 2011, Andrei Warkentin wrote:
>> This is the latest version of the MMC device partition support.
>> It relies on a few other changes that were discussed recently.
>>
>> Thanks,
>> A
>>
>> TOC:
>> [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
>> [PATCH 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
>> [PATCH 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
>> [PATCH 4/4] MMC: MMC boot partitions support.
>
> Any problems, comments?

Looks good to me -- Arnd, did you want to add your Reviewed/Acked-by
to this?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
