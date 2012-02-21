From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc-utils: improve the parsing of the EXT_CSD registers
Date: Tue, 21 Feb 2012 13:56:10 +0900
Message-ID: <4F4323EA.6050205@samsung.com>
References: <1329727529-3120-1-git-send-email-peppe.cavallaro@st.com>
 <m28vjx5rka.fsf@bob.laptop.org> <4F4320DC.6010501@samsung.com>
 <m24nuk6bfw.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44299 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2BUE4M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 23:56:12 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZQ00I988CUXS70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Feb 2012 13:56:11 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZQ009SH8DM2HA0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Feb 2012 13:56:11 +0900 (KST)
In-reply-to: <m24nuk6bfw.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org, sebras@gmail.com, linus.walleij@linaro.org, youssef.triki@st.com, Johan RUDHOLM <johan.rudholm@stericsson.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 02/21/2012 01:46 PM, Chris Ball wrote:

> Hi,
> 
> On Mon, Feb 20 2012, Jaehoon Chung wrote:
>> Write protect is only supported the "power-on".
>> If there is no problem to support "permanent", i will send the patch.
>> Is any problem to support "permanent"?
> 
> I think I'd rather not -- we could add a comment to the code that
> explains that setting the EXT_CSD_BOOT_WP_B_PERM_WP_EN bit instead of
> EXT_CSD_BOOT_WP_B_PWR_WP_EN is how to achieve this, but I don't think
> we need to do more than that for such a rare and dangerous use case.

Ok..It's dangerous case..I see. :)
And I added the output message from eMMC4.5 device in the previous mail.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> 
> - Chris.


