From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2] mmc: sunxi: Don't start commands
 while the card is busy
Date: Mon, 20 Jul 2015 17:23:36 +0200
Message-ID: <55AD1278.3060308@redhat.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
 <20150720080007.GR28632@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41733 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbbGTPXk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jul 2015 11:23:40 -0400
In-Reply-To: <20150720080007.GR28632@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mike Turquette <mturquette@linaro.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Eugene K <sigintmailru@gmail.com>

Hi,

On 20-07-15 10:00, Maxime Ripard wrote:
> Hi,
>
> On Fri, Jul 10, 2015 at 05:14:44PM +0200, Hans de Goede wrote:
>> Some sdio wifi modules have not been working reliable with the sunxi-mmc
>> host code. This turns out to be caused by it starting new commands while
>> the card signals that it is still busy processing a previous command.
>>
>> This commit fixes this, thereby fixing the wifi reliability issues on
>> the Cubietruck and other sunxi boards using sdio wifi.
>>
>> Reported-by: Eugene K <sigintmailru@gmail.com>
>> Suggested-by: Eugene K <sigintmailru@gmail.com>
>> Cc: Eugene K <sigintmailru@gmail.com>
>
> You should use the "real" name here, and not some shortening.

I don't know the real name, and AFAIK this is really only important
for S-o-b lines.

Eugene, care to share your full name with us?

Regards,

Hans
