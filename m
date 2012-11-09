From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: fix more const pointer warnings
Date: Fri, 09 Nov 2012 14:44:59 +0900
Message-ID: <509C985B.8060206@samsung.com>
References: <1350376988-27477-1-git-send-email-james.hogan@imgtec.com>
 <508E4DB6.20504@imgtec.com> <87a9v5xuqj.fsf@octavius.laptop.org>
 <201211081426.12208.arnd@arndb.de> <87zk2s5fj6.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <87zk2s5fj6.fsf@octavius.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, James Hogan <james.hogan@imgtec.com>, Will Newton <will.newton@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Great..Thanks Arnd and Chris.

Best Regards,
Jaehoon Chung
On 11/08/2012 11:35 PM, Chris Ball wrote:
> Hi Arnd,
> 
> On Thu, Nov 08 2012, Arnd Bergmann wrote:
>> The patch "dw_mmc: fix multiple drv_data NULL dereferences" has
>> unfortunately clashed with my "mmc: dw_mmc: constify
>> dw_mci_idmac_ops in exynos back-end" patch, causing new warnings
>> to appear.
>>
>> This should hopefully fix the issue for good.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks, pushed to mmc-next for 3.7.
> 
> (Jaehoon also sent a patch to fix these last night, but yours applies to
> current mmc-next and his doesn't, so I'll take this one instead.)
> 
> - Chris.
> 
