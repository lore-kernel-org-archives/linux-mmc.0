From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc-utils: add the way to enable boot-partition
Date: Fri, 20 Apr 2012 05:07:19 -0400
Message-ID: <87mx66ixfc.fsf@laptop.org>
References: <1334825917-2146-1-git-send-email-peppe.cavallaro@st.com>
	<87aa27k5bb.fsf@laptop.org> <4F90E7DA.4010703@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42844 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab2DTJHG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Apr 2012 05:07:06 -0400
In-Reply-To: <4F90E7DA.4010703@st.com> (Giuseppe CAVALLARO's message of "Fri,
	20 Apr 2012 06:36:42 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, Apr 20 2012, Giuseppe CAVALLARO wrote:
> On 4/19/2012 7:19 PM, Chris Ball wrote:
>> Hi Giuseppe,
>> 
>> On Thu, Apr 19 2012, Giuseppe CAVALLARO wrote:
>>> This adds a new option to enable the boot from eMMC
>>> by writing to the 179 ext_csd register.
>>>
>>> The example below shows as to enable the mmcblk0boot0
>>> partition and also set/reset the ACK bit).
>>>
>>> $ ./mmc booten 1 1 /dev/mmcblk0boot0
>>> $ ./mmc extcsd read /dev/mmcblk0boot0 | grep PARTITION_CON
>>> Boot configuration bytes [PARTITION_CONFIG: 0x49]
>>>
>>> Reported-by: Youssef TRIKI <youssef.triki@st.com>
>>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> 
>> Looks good, thanks -- do you mind if I make the following changes for
>> readability (and are they correct)?  I can update the commit message too:
>
> your changes are fine for me

Thanks, pushed to mmc-utils.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
