From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
Date: Mon, 25 Aug 2014 21:09:47 +0900
Message-ID: <53FB278B.7010509@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <20140825112151.GA21336@amd> <53FB1DD5.3050207@samsung.com>
 <20140825113719.GA31960@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12299 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbaHYMJt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Aug 2014 08:09:49 -0400
In-reply-to: <20140825113719.GA31960@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kgene.kim@samsung.com, heiko@sntech.de, tgih.jun@samsung.com, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-samsung-soc@vger.kernel.org, dinguyen@altera.com, linux-arm-kernel@lists.infradead.org

On 08/25/2014 08:37 PM, Pavel Machek wrote:
> On Mon 2014-08-25 20:28:21, Jaehoon Chung wrote:
>> On 08/25/2014 08:21 PM, Pavel Machek wrote:
>>> On Thu 2014-08-07 16:37:57, Jaehoon Chung wrote:
>>>> Since used the mmc_of_parse(), didn't parse the sub-node.
>>>> So we can remove the sub-node, because almost SoC used the only one card per a host.
>>>> And supports-highspeed can be replaced with "cap-mmc/sd-highspeed"
>>>> property.
>>>
>>> Would it be better to fix parsing of the device tree, and not to
>>> change all the device trees?
>>>
>>> Someone will want to do two slots sooner or later...
>>>
>>
>> First, I had considered that controller can be supported the multiple slot.
>> But MMC maintainers and other people suggested that consider the only one card per a host.
>> Two slots or more don't have any benefit, (power or performance, etc).
> 
> Would you elaborate?
> 
> If I have a device like a phone, I may want to put one "slot" inside
> phone for basic system, and offer second slot for user expansion
> (initially empty).

if multiple slot is supported, then a mmcqd should be processing for multiple slots.
It's too inefficient, and affect the whole performance reduction.

If want to offer the second slot for user expansion, add the host for expansion slot.
Almost All SoC didn't use the multiple slot per a host controller for eMMC/SD/SDIO.

If Some device(Phone) supports the SD-card and eMMC, then there are two Host IP.
One Host IP is used for eMMC, other is used for SD-card.

this is H/W design issue.

a) You means the below,

One Host IP -------- eMMC
		|
		---- SD
		|
		---- SDIO

b) We means the below
One Host IP -------- eMMC
One Host IP -------- SD
One Host IP -------- SDIO

In now, I knew every SoC have used like b) type. I didn't see a) type (especially, dwmmc's case).

If i missed something, let me know, plz.

Best Regards,
Jaehoon Chung

> 
> Or I may want to have internal slot with a card to boot from and have
> external slot (initially empty) for system update for embedded system.
> 
> I see quite an obvious benefit there.
> 									Pavel
> 

