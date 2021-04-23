Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAFBC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 01:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A7961452
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 01:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhDWBmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 21:42:38 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:36946 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWBmi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 21:42:38 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 21:42:37 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 3DA061BC6;
        Fri, 23 Apr 2021 09:34:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31917T139684229392128S1619141672038806_;
        Fri, 23 Apr 2021 09:34:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5da22906554fc2752021756c18299c38>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <35677467-4ccd-9eae-3800-2bc7597cfa0f@rock-chips.com>
Date:   Fri, 23 Apr 2021 09:34:32 +0800
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
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021/4/22 21:18, Christian Löhle wrote:
> Ignore the reported capacity if the card otherwise reports UHS support.
> 
> Currently SDSC cards reporting UHS support except for the CCS do not run
> through the voltage switch.
> While strictly speaking a SDSC card cannot support UHS in compliance
> with the standard, there is no good reason to throttle them that way.
> Especially for pSLCs in practice such cards benefit greatly by this patch,

Cduld you provide some more infomation about the SDSC cards which ones 
are labeled as UHS, e.g brand, webpage....

> as they can be new and UHS supporting, but must not lie about their CCS.
> The behaviour of linux-mmc for SDSC is deviating from the standard anyway
> in such a case, as the card is treated as UHS card not supporting the
> voltage switch in general.
> Such a card will come up as
> mmc0: new ultra high speed SDR25 SD card at address 0001.
> Thus the subsystem will support CMD23 and others to the card.
> But if we deviate from the standard anyway, then we might as well
> not throttle SDSC to 25MB/s.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>   drivers/mmc/core/sd.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6fa51a6ed058..281ca2da8e0b 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>   		return err;
>   
>   	/*
> -	 * In case CCS and S18A in the response is set, start Signal Voltage
> -	 * Switch procedure. SPI mode doesn't support CMD11.
> +	 * In case S18A in the response is set, start Signal Voltage Switch
> +	 * procedure. SPI mode doesn't support CMD11.
>   	 */
> -	if (!mmc_host_is_spi(host) && rocr &&
> -	   ((*rocr & 0x41000000) == 0x41000000)) {
> +	if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>   		err = mmc_set_uhs_voltage(host, pocr);
>   		if (err == -EAGAIN) {
>   			retries--;
> 


