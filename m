From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v4 12/15] mmc: core: add new 1.8v flag for mmc
Date: Thu, 27 Sep 2012 18:39:37 +0800
Message-ID: <CADz5_gKsKBaM1SQvnganS9rgp6y9ctYmR69H5wrrHyUMd8u9oQ@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-13-git-send-email-keyuan.liu@gmail.com>
	<CAPDyKFoMJrunn1WSiif84xbTzp+4ssZV8WdqsrC6FyUtdZC6bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57874 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268Ab2I0Kji (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 06:39:38 -0400
Received: by wgbdr13 with SMTP id dr13so1282853wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 03:39:37 -0700 (PDT)
In-Reply-To: <CAPDyKFoMJrunn1WSiif84xbTzp+4ssZV8WdqsrC6FyUtdZC6bw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Johan Rudholm <johan.rudholm@stericsson.com>

Hi, Ulf

2012/9/27 Ulf Hansson <ulf.hansson@linaro.org>:
> Hi Kevin,
>
> On 26 September 2012 13:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Mmc does NOT have special sequence requirements for 1.8v
>> signal voltage setting compared to sd and sdio.
>> Add a new 1.8v flag for mmc so as to use the same
>> start_signal_voltage_switch interface.
>
> This problem is protocol issue and should not be solved in the host
> driver. We have more issues for signal_voltage switch as well.
>
> Please have a look at Johan Rudholms patches:
> [PATCH v2 1/2] mmc: core: Proper signal voltage switch
> [PATCH v2 2/2] mmc: core: Power cycle card on voltage switch fail
>
I agree that we should do more things in protocal driver.
But the real voltage switch work is still done in host driver. If we
keep only one voltage switch interface, then we need to add a flag to
distinguish sd/sdio or emmc. Or we should define two interfaces to
call different host functions to handle this.
Johan's patches can't solve my issue.

Thanks
Kevin
