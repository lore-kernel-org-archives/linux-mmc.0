From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] DT: bindings: remove bcm2835-sdhci
Date: Fri, 17 Jun 2016 12:59:36 -0600
Message-ID: <57644898.60402@wwwdotorg.org>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
 <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
 <5751E1F1.5020202@wwwdotorg.org>
 <1995060523.43076.c268f06d-da3c-427e-800f-fbc65895c323.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45150 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbcFQS7n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2016 14:59:43 -0400
In-Reply-To: <1995060523.43076.c268f06d-da3c-427e-800f-fbc65895c323.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 06/09/2016 12:11 PM, Stefan Wahren wrote:
> Hi Stephen,
>
>> Stephen Warren <swarren@wwwdotorg.org> hat am 3. Juni 2016 um 22:00
>> geschrieben:
>>
>>
>> On 06/03/2016 01:47 PM, Stefan Wahren wrote:
>>> The sdhci-iproc also supports bcm2835. So this binding is obsolete.
>>
>> sdhci-iproc supports this binding, so I don't believe the binding is
>> obsolete. The duplicate implementations (drivers) can possibly be
>> removed, but not the binding doc, which is (or at least could be) still
>> in use.
>
> sorry for my late reply.
>
> So the brcm,bcm2835-sdhci.txt must be kept, even if the compatible string
> "brcm,bcm2835-sdhci" has been added to brcm,sdhci-iproc.txt?

Sorry for the slow reply; I was on vacation.

So, if the binding documentation has been collapsed into the other 
binding document, then it's OK to remove this one. I took a look at the 
iproc binding doc and it looks completely compatible with this removed 
binding doc, so I think this patch is OK.
