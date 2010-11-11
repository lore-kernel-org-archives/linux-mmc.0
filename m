From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 1/1]sdhci-pxa: support tune_timming for various cards
Date: Wed, 10 Nov 2010 18:52:20 -0800
Message-ID: <102A5FA7-062C-45AF-9517-9CB8DE40F409@marvell.com>
References: <AcuAtXvv47budpVyQx2uoWC0YAvjJw==>
 <E8C182D3-90EE-4A2B-BE63-905E85F9AF54@marvell.com>
 <AANLkTiniVAFJiLFqtrAiWyq7N=JKZaCuEhupP4DQoqTd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41606 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932186Ab0KKC5a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Nov 2010 21:57:30 -0500
In-Reply-To: <AANLkTiniVAFJiLFqtrAiWyq7N=JKZaCuEhupP4DQoqTd@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>


We should rename sdhci-pxa.c to sdhci-mmp2.c and adjust Kconfig and the makefile accordingly since it is clear code is clearly processor dependent 

or

The additional changes to support the pxa family of chips should be posted to the web.


On Nov 10, 2010, at 6:08 PM, zhangfei gao wrote:

> On Wed, Nov 10, 2010 at 4:58 PM, Philip Rakity <prakity@marvell.com> wrote:
>> 
>> <snip>
>> 
>>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP          0x10A
>> 
>> This offset is only for MMP2.  On other pxa processors use a  different offset.  sdhci-pxa.c needs changing to support other pxa soc chips.
> 
> The first stage is only considering MMP2, the next step wil consider
> other processor, for example move private register to arch/
> 
>> 
>> The value only needs setting at initialization time or sdhci reset (RESET_ALL)
> it is OK to put here, then no call back is needed.
>> 
>> 
>> 

