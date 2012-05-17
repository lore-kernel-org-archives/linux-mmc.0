From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: at91-mci: this driver is now deprecated
Date: Thu, 17 May 2012 14:36:47 -0400
Message-ID: <87pqa21wow.fsf@laptop.org>
References: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
 <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <87k40b3ris.fsf@laptop.org> <4FB54366.80409@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FB54366.80409@atmel.com> (ludovic desroches's message of "Thu,
 17 May 2012 20:28:54 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: plagnioj@jcrosoft.com, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, May 17 2012, ludovic.desroches wrote:
>>> +	  remove soon (for more information have a look to
>>            ^ removed
>>> +	  Documentation/feature-removal-schedule.txt). Please use
>>> +	  MMC_ATMEL_MCI.
>>>
>>>   	  If unsure, say N.
>
> Sorry for the typo, do you want a new patch or is ok?

It's okay, I've fixed it up here.

>> Seems like I should take this patch 2/2, and then someone else should
>> merge 1/2?
>
> Yes, Nicolas would probably take patch 2/2.

I think you must mean that Nicolas takes 1/2 (the arch/arm/ patches).
Assuming you do, that's fine and I've pushed 2/2 to mmc-next for 3.5 now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
