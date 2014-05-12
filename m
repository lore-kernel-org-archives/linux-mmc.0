From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] ARM: Updates for mmci driver for 3.16, take 1
Date: Mon, 12 May 2014 11:36:33 +0200
Message-ID: <CAPDyKFqGgVis6NAgfSXEbC+hbdyix=eWk+2GDEyALC=qv0FYbA@mail.gmail.com>
References: <CAPDyKFp0K=cijuAZox7_BsTk2UCyC7Dp9HQoO6eJzaHikRMVUw@mail.gmail.com>
	<CAPDyKFo07dqfqTtrGp3sHwf1ghzCj4BaBqJffRAs=cA1-HP2Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:62614 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaELJge (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 05:36:34 -0400
Received: by mail-qa0-f51.google.com with SMTP id w8so6689857qac.38
        for <linux-mmc@vger.kernel.org>; Mon, 12 May 2014 02:36:33 -0700 (PDT)
In-Reply-To: <CAPDyKFo07dqfqTtrGp3sHwf1ghzCj4BaBqJffRAs=cA1-HP2Tw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 24 April 2014 12:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 April 2014 16:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Hi Russell,
>>
>> I have collected some patches which all relates to changes to the mmci driver.
>>
>> The SOC specific patches has been acked by the SOC maintainer Linus
>> Walleij and the DT patches has been iterated a few times, due to
>> comments from Rob Herring.
>>
>> Unless you have some concern with any of the patches, please pull them
>> into your ARM tree.
>
> Ping. :-)
>
> Please, let me know if you prefer another setup than a pull request.
>

Hi Russell,

I understand you have been busy, no worries.

As a way forward and to get some testing in linux-next, I will pull in
these patches into my next branch in my mmc tree.
git://git.linaro.org/people/ulf.hansson/mmc.git.

I assume you will tell me if you have any concerns.

Kind regards
Ulf Hansson
