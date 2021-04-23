Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F5C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 06:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F402F61181
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 06:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhDWGw5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:52:57 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:52234 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWGw5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 02:52:57 -0400
Received: from localhost (unknown [192.168.167.223])
        by regular1.263xmail.com (Postfix) with ESMTP id 674721B48;
        Fri, 23 Apr 2021 14:51:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22002T139994497025792S1619160686499806_;
        Fri, 23 Apr 2021 14:51:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c7af963b3c841a91bb0c1b9b4e4588f1>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <61bea021-2fe7-4f1e-6eef-4a5a9a0233c9@rock-chips.com>
Date:   Fri, 23 Apr 2021 14:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Cc:     shawn.lin@rock-chips.com, "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mmc=3a_enable_UHS_voltage_switch_for_SD?=
 =?UTF-8?B?U0MgaWYgc3VwcG9ydGVk44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1j?=
 =?UTF-8?B?LW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <35677467-4ccd-9eae-3800-2bc7597cfa0f@rock-chips.com>
 <CWXP265MB2680E0D998AF13C041D18859C4459@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CWXP265MB2680E0D998AF13C041D18859C4459@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021/4/23 14:38, Christian Löhle wrote:
> Claiming UHS-I support with SDSC is pretty rare, for obvious reasons (namely they are non-standard, so it's a gamble if a host makes use of it), but here you go:
> https://de.rs-online.com/web/p/micro-sd-karten/8743910/
> (sorry for the german, the site has a en. subpage, but it's certificate seem untrusted.)
> The more likely case is that they do not advertise UHS-I to customers,
> but the card will show support to the host.
> Let's look at this product, just as an example.
> https://www.tme.eu/html/EN/goodram-industrial-industrial-sd-sd-micro-memory-cards/ramka_15242_EN_pelny.html
> They provide an MLC and pSLC version of each device, with half the capacity naturally.
> The 4GB MLC claims UHS-I support, the 2GB pSLC is very likely to be the same controller,
> it only claims Class 6.
> So either they specifically changed the firmware to remove any UHS support indication,
> or, more likely IMO, the card still reports UHS support to the host.
> Such a card would benefit from this patch.
> 
> Disclaimer: I do not own the product and have not confirmed this device in any way,
> but I have seen UHS support on other devices that do not advertise it for their
> SDSC versions.
> If the mailing list would be interested, I can try to acquire such devices, listed in
> public open stores. Modern, potentially UHS supporting cards. are,
> as mentioned in the initial Mail, often SLC or pSLC and often are made on
> a customers request.
> 
> 

Thanks for sharing these, but from the datasheets, these SDSC cards
claims their throught up to 20MB/s. So, I guess highpseed mode is enough
for them? what do you think?

> From: Shawn Lin <shawn.lin@rock-chips.com>
> Sent: Friday, April 23, 2021 3:34 AM
> To: Christian Löhle <CLoehle@hyperstone.com>
> Cc: shawn.lin@rock-chips.com <shawn.lin@rock-chips.com>; pali@kernel.org <pali@kernel.org>; huyue2@yulong.com <huyue2@yulong.com>; tiantao6@hisilicon.com <tiantao6@hisilicon.com>; linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; ulf.hansson@linaro.org <ulf.hansson@linaro.org>
> Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported【请注意，邮件由linux-mmc-owner@vger.kernel.org代发】
>   
> On 2021/4/22 21:18, Christian Löhle wrote:
>> Ignore the reported capacity if the card otherwise reports UHS support.
>>
>> Currently SDSC cards reporting UHS support except for the CCS do not run
>> through the voltage switch.
>> While strictly speaking a SDSC card cannot support UHS in compliance
>> with the standard, there is no good reason to throttle them that way.
>> Especially for pSLCs in practice such cards benefit greatly by this patch,
> 
> Cduld you provide some more infomation about the SDSC cards which ones
> are labeled as UHS, e.g brand, webpage....
> 
>> as they can be new and UHS supporting, but must not lie about their CCS.
>> The behaviour of linux-mmc for SDSC is deviating from the standard anyway
>> in such a case, as the card is treated as UHS card not supporting the
>> voltage switch in general.
>> Such a card will come up as
>> mmc0: new ultra high speed SDR25 SD card at address 0001.
>> Thus the subsystem will support CMD23 and others to the card.
>> But if we deviate from the standard anyway, then we might as well
>> not throttle SDSC to 25MB/s.
>>
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>> ---
>>     drivers/mmc/core/sd.c | 7 +++----
>>     1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 6fa51a6ed058..281ca2da8e0b 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>>                  return err;
>>     
>>          /*
>> -      * In case CCS and S18A in the response is set, start Signal Voltage
>> -      * Switch procedure. SPI mode doesn't support CMD11.
>> +      * In case S18A in the response is set, start Signal Voltage Switch
>> +      * procedure. SPI mode doesn't support CMD11.
>>           */
>> -     if (!mmc_host_is_spi(host) && rocr &&
>> -        ((*rocr & 0x41000000) == 0x41000000)) {
>> +     if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>>                  err = mmc_set_uhs_voltage(host, pocr);
>>                  if (err == -EAGAIN) {
>>                          retries--;
>>
> 
> 
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 


