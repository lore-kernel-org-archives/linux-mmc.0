From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (V6)
Date: Fri, 11 Nov 2011 20:59:09 -0500
Message-ID: <87zkg2hziq.fsf@laptop.org>
References: <4EB3A9A4.1000205@intel.com>
	<1320411199-16860-1-git-send-email-peppe.cavallaro@st.com>
	<4EB3EA84.5000806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47570 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab1KLB7P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 20:59:15 -0500
In-Reply-To: <4EB3EA84.5000806@intel.com> (Adrian Hunter's message of "Fri, 04
	Nov 2011 15:37:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 04 2011, Adrian Hunter wrote:
> On 04/11/11 14:53, Giuseppe CAVALLARO wrote:
>> This patch is to expose the actual SDCLK frequency in
>> /sys/kernel/debug/mmcX/ios entry.
>> 
>> For example, if the max clk for a normal speed card is 20MHz
>> this is reported in /sys/kernel/debug/mmcX/ios.
>> Unfortunately the actual SDCLK frequency (i.e. Baseclock / divisor)
>> is not reported at all: for example, in that case, on Arasan HC,
>> it should be 48/4=12 (MHz).
>> 
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Pushed to mmc-next for 3.3 with Adrian's ACK, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
