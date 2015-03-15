From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: RE: [PATCH] mmc: sleep notification
Date: Sun, 15 Mar 2015 09:04:06 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE64F79CC06@SACMBXIP02.sdcorp.global.sandisk.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
 <54FEF34E.20205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0062.outbound.protection.outlook.com ([157.56.111.62]:21088
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751437AbbCOJEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Mar 2015 05:04:12 -0400
In-Reply-To: <54FEF34E.20205@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, Alex Lemberg <Alex.Lemberg@sandisk.com>




>-----Original Message-----
>From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>Sent: Tuesday, March 10, 2015 3:36 PM
>To: Avi Shchislowski; ulf.hansson@linaro.org
>Cc: linux-mmc@vger.kernel.org; chris@printf.net; Alex Lemberg
>Subject: Re: [PATCH] mmc: sleep notification
>
>On 10/03/15 11:36, Avi Shchislowski wrote:
>> This patch is implements the new additional state of
>> Power_Off_Notification - SLEEP_NOTIFICATION.
>> Until now, the implementation of Power_Off_Notification supported only
>> three modes - POWERED_ON (0x01), POWER_OFF_SHORT (0x02) and
>> POWER_OFF_LONG (0x03).
>>
>> As part of eMMC5.0 before moving to Sleep state hosts may set the
>> POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
>> After setting SLEEP_NOTIFICATION, host should wait for the busy line
>> to be de-asserted.
>> The max timeout allowed for busy line de-assertion defined in
>> SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216].
>> HPI may interrupt the SLEEP_NOTIFICATION operation.
>> In that case POWER_OFF_NOTIFICATION byte will restore to POWERED_ON.
>
>Is it so that the point of SLEEP_NOTIFICATION is to notify that VCC will be
>powered off after the device is put to sleep by CMD5?
The purpose of SLEEP_NOTIFICATION is to give the eMMC enough time to prepare itself before powered off.
Before the SLEEP_NOTIFICATION fetcher the eMMC did not know he will get into sleep but only when the sleep was issued
With this solution the device start to prepare itself during the sleep preparation

>
>At the moment, the card does not get put to sleep if there is support for
>power-off-notification?
 No, it will enter to sleep after the device will finish its "internal work"

