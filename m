From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v4 12/15] mmc: core: add new 1.8v flag for mmc
Date: Fri, 28 Sep 2012 15:13:26 +0800
Message-ID: <CADz5_g+rVqngTtUC4N3H0EFGw1OLEXoMQ9+mrrxpekW=cFULyw@mail.gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
	<1348659527-4200-13-git-send-email-keyuan.liu@gmail.com>
	<CAPDyKFoMJrunn1WSiif84xbTzp+4ssZV8WdqsrC6FyUtdZC6bw@mail.gmail.com>
	<CADz5_gKsKBaM1SQvnganS9rgp6y9ctYmR69H5wrrHyUMd8u9oQ@mail.gmail.com>
	<CAPDyKFoVt_5xaGXUBbPO4hT8j_rC106U4y-FUb_7m_Ps9VVvbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63902 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2I1HN1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 03:13:27 -0400
Received: by wibhr7 with SMTP id hr7so3033061wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 00:13:26 -0700 (PDT)
In-Reply-To: <CAPDyKFoVt_5xaGXUBbPO4hT8j_rC106U4y-FUb_7m_Ps9VVvbw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Johan Rudholm <johan.rudholm@stericsson.com>

2012/9/27 Ulf Hansson <ulf.hansson@linaro.org>:
> On 27 September 2012 12:39, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> Hi, Ulf
>>
>> 2012/9/27 Ulf Hansson <ulf.hansson@linaro.org>:
>>> Hi Kevin,
>>>
>>> On 26 September 2012 13:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
>>>> From: Kevin Liu <kliu5@marvell.com>
>>>>
>>>> Mmc does NOT have special sequence requirements for 1.8v
>>>> signal voltage setting compared to sd and sdio.
>>>> Add a new 1.8v flag for mmc so as to use the same
>>>> start_signal_voltage_switch interface.
>>>
>>> This problem is protocol issue and should not be solved in the host
>>> driver. We have more issues for signal_voltage switch as well.
>>>
>>> Please have a look at Johan Rudholms patches:
>>> [PATCH v2 1/2] mmc: core: Proper signal voltage switch
>>> [PATCH v2 2/2] mmc: core: Power cycle card on voltage switch fail
>>>
>> I agree that we should do more things in protocal driver.
>> But the real voltage switch work is still done in host driver. If we
>> keep only one voltage switch interface, then we need to add a flag to
>> distinguish sd/sdio or emmc. Or we should define two interfaces to
>> call different host functions to handle this.
>> Johan's patches can't solve my issue.
>
> I understand that your driver today take care of specific things for
> sd/sdio. The reason for that is because of the protocol layer is not
> doing the voltage switch properly.
> The idea with Johans patches is resolve all these issues. Thus the
> host driver will just be responsible for the actual voltage switch to
> happen. So in the end your voltage switch function in the host is
> supposed to be rather simple.
>
Ok, Johans new patch is reasonable so I will hold this patch.

> If you still think you need to handle sd/sdio/eMMC in a specific
> manner in your driver, there are always mmc_card_sdio|sd|mmc functions
> you can use.
>
voltage_switch sometimes is called very early even before card type init.

Thanks
Kevin
