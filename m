From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: slot-gpio: Add support to enable irq wake on
 cd_irq
Date: Wed, 17 May 2017 14:44:55 +0300
Message-ID: <b5ddff44-a5c8-bca5-484f-d7af0ed88b54@intel.com>
References: <1492607363-5346-1-git-send-email-adrian.hunter@intel.com>
 <1492607363-5346-2-git-send-email-adrian.hunter@intel.com>
 <c33cc643-0f35-f92f-37b2-62e7ccba0209@intel.com>
 <CAPDyKFpmvk93qn_B-o7+UW7t4JSTm9w=2T=1Mov-iKxfCADz=Q@mail.gmail.com>
 <a0a8df6c-cda6-f291-705a-f25f9c995813@intel.com>
 <CAPDyKFqACm+Q9xNVro=T+KkUL4-3JB2bkCMhc-Z6ynK+qr2v8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:9744 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdEQLuq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 May 2017 07:50:46 -0400
In-Reply-To: <CAPDyKFqACm+Q9xNVro=T+KkUL4-3JB2bkCMhc-Z6ynK+qr2v8A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 28/04/17 13:27, Ulf Hansson wrote:
> On 28 April 2017 at 09:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 25/04/17 23:02, Ulf Hansson wrote:
>>> On 25 April 2017 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 19/04/17 16:09, Adrian Hunter wrote:
>>>>> Add mmc_gpio_cd_enable_wake() to allow drivers to enable irq wake on the
>>>>> card detect irq.
>>>>>
>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>
>>>> Any comments on this?
>>>
>>> Not yet. I need some more thinking about this.
>>
>> How is the thinking going ;-)
> 
> To many things at the moment. Anyway, to me this is material for 4.13.
> I will get back to it as soon as I can.

Any update on this?

