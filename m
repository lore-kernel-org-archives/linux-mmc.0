From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share
 sdhci-pxa
Date: Thu, 12 May 2011 15:58:19 -0700
Message-ID: <487EBCAC-1795-4C69-ACDF-99EC9D7BF604@marvell.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
 <m34o4zwo8t.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49666 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757432Ab1ELW60 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2011 18:58:26 -0400
In-Reply-To: <m34o4zwo8t.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>


All other platform specific code is in the host/ directory.

This moves it to arch/arm

If that is the direction the group wants to go in --> then the patch is fine provided the mmc group can review the patches.
Otherwise they are handled by the arm maintainer.


On May 12, 2011, at 3:25 PM, Chris Ball wrote:

> Hi,
> 
> On Thu, Apr 28 2011, zhangfei gao wrote:
>> Subject: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
>> 
>> 	Call back functions is added to support mmp2, pxa910, and pxa955
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Signed-off-by: RaymondWu <xywu@marvell.com>
>> Signed-off-by: Jun Nie <njun@marvell.com>
> 
> This patchset looks good to me.  Philip, any objections?
> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

