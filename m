From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: Increase the timeout in mci_send_cmd to 5 sec
Date: Wed, 25 Oct 2017 22:57:14 +0200
Message-ID: <CAPDyKFpyVhEryYozdqVf7DunkOAj+wRVP=9Ney-8os7E3mBAHw@mail.gmail.com>
References: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAPDyKFojY21yTMu2E9M8tec6QPZfFuVwJMZO0vY8V2kG7=yRCg@mail.gmail.com>
 <3c46c1a6-edd2-698e-3286-e30d04b99103@hotmail.de> <AM5PR0701MB2657E6DB86B31A2D29F25D19E4440@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:47324 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYU5P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2017 16:57:15 -0400
Received: by mail-it0-f68.google.com with SMTP id p138so2739509itp.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2017 13:57:15 -0700 (PDT)
In-Reply-To: <AM5PR0701MB2657E6DB86B31A2D29F25D19E4440@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 25 October 2017 at 14:52, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
> On 10/02/17 15:29, Bernd Edlinger wrote:
>> On 10/02/17 09:13, Ulf Hansson wrote:
>>> On 30 September 2017 at 17:38, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>>
>>>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>>>
>>> Why?
>>>
>>
>> Obviously the 0.5 seconds time-out was not sufficent for me.
>> I experienced a time-out I believe it was with an erase command,
>> that took around one second to complete.  Not all brands of SD
>> card behave this way, but some do.
>>
>> Incidentally I had a similar problem with a completely different
>> hardware, see: https://bugzilla.kernel.org/show_bug.cgi?id=107811
>> Should I send a patch for that as well?
>>
>>
>
> Ping...
>
> Is raising the time-out also controversial?

Well, I think you should be using a timeout based on facts of the
command, not just some value.

Anyway, have a look at this series and see if it solves your problem.

https://lkml.org/lkml/2017/10/12/688

Kind regards
Uffe
