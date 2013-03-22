From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: davinci: allow driver to work without DMA resource
Date: Fri, 22 Mar 2013 12:05:45 -0400
Message-ID: <87sj3npgh2.fsf@octavius.laptop.org>
References: <1360066944-14265-1-git-send-email-prakash.pm@ti.com>
	<512F38CD.1070805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34317 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab3CVQFu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:05:50 -0400
In-Reply-To: <512F38CD.1070805@ti.com> (Sekhar Nori's message of "Thu, 28 Feb
	2013 16:30:29 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "Manjunathappa, Prakash" <prakash.pm@ti.com>, linux-mmc@vger.kernel.org, mporter@ti.com, davinci-linux-open-source@linux.davincidsp.com, gregkh@linuxfoundation.org

Hi,

On Thu, Feb 28 2013, Sekhar Nori wrote:
> On 2/5/2013 5:52 PM, Manjunathappa, Prakash wrote:
>> Do not return probe failure with missing DMA resources,
>> allow driver to work in PIO mode.
>> Tested on da850-evm by mounting partition followed by
>> file creation and deletion.
>> 
>> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
>
> I verified this along with your other patches enabling use of MMC with
> DT boot.
>
> Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
