From: Derek Simkowiak <derek@webtuner.tv>
Subject: Re: Seeking correct git repo
Date: Thu, 26 Jun 2014 11:27:11 -0700
Message-ID: <53AC65FF.1010301@webtuner.tv>
References: <53AB22F9.40503@webtuner.tv> <cc919527-97e4-46ef-9952-3ceeaea97193@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:33666
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009AbaFZS1R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jun 2014 14:27:17 -0400
In-Reply-To: <cc919527-97e4-46ef-9952-3ceeaea97193@email.android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, romain.izard.pro@gmail.com

   Uffe,
Thank you for your prompt response.

 >///you should either send a ping or resend the patch./

I am happy to copy'n'paste the patch from the URL (below) and resend it 
to this list.

However, my understanding is that the email header "from " or "From:" 
lines are used to track authorship in the CONTRIBUTORS file.  I don't 
want to receive credit for Romain's work by re-sending his patch.  Is 
there a way for me to re-submit the patch on Romain's behalf?  (I have 
also CC:'d Romain, so he can resubmit it directly.)

I can verify that this patch is necessary to make Jedec 5.0 hardware 
work.  It should get into linux-stable as soon as possible, so that 
Linux can support newer eMMC hardware.


Thank You,
Derek

On 06/26/2014 02:35 AM, Ulf Hansson wrote:
> On 25 juni 2014 21:28:57 CEST, Derek Simkowiak<derek@webtuner.tv>  wrote:
>>       Hello,
>> A while ago, Romain wrote a small eMMC 5.0 patch that Ulf ack'd:
>>
>> http://comments.gmane.org/gmane.linux.kernel.mmc/23795
>>
>> I need this patch for my hardware.  But I don't see this patch in Linux
>>
>> stable (even though there are more recent patches from Seungwon Jeon in
>>
>> there), and I don't see it at the MMC repo either:
>>
>> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>>
>> # Where's the patch? I checked all branches...
>>
>> $ git branch -a
>> * master
>>    remotes/origin/HEAD -> origin/master
>>    remotes/origin/master
>>    remotes/origin/mmc-next
>>    remotes/origin/mmc-updates-for-3.16-rc1-merged
>>
>>
>> Can you please tell me, what is the repo and branch where this patch
>> was
>> submitted?  The only reference I have to this patch is the email
>> archive
>> at the URL above.
> Seems like it was missed. That could happen, then you should either send a ping or resend the patch.
>
> Kind regards
> Uffe
>> Thank You,
>> Derek
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message tomajordomo@vger.kernel.org
>> More majordomo info athttp://vger.kernel.org/majordomo-info.html


