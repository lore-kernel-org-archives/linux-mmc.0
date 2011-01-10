From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V2 2/2] sdhci: Support for SD/MMC Dual Data Rate
Date: Sun, 9 Jan 2011 22:05:43 -0500
Message-ID: <AANLkTin53qP-GbXavdvcu0WpjBHQNZoTDRXu7zpq2jNr@mail.gmail.com>
References: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com>
	<AANLkTi=ERwn3W8tvt3NNS3Xiq93mhy7TV7vAT9dwjvaq@mail.gmail.com>
	<20110109232812.GA26728@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62495 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1AJDFp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 22:05:45 -0500
Received: by fxm20 with SMTP id 20so18441982fxm.19
        for <linux-mmc@vger.kernel.org>; Sun, 09 Jan 2011 19:05:43 -0800 (PST)
In-Reply-To: <20110109232812.GA26728@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Sun, Jan 9, 2011 at 6:28 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Philip, Zhangfei,
>
> We've got two patches from Marvell for SD/DDR now. =A0Any agreement o=
n
> which of them to merge?

Could you check the "sdhci support emmc ddr50 mode [v4]"
Neither mdelay or set_voltage can be used in spin_lock_irqsaved, since
much time is needed to wait voltage to be stable.
This method is considered in v1.

>
> On Mon, Jan 03, 2011 at 10:39:46PM -0500, zhangfei gao wrote:
>> > + =A0 =A0 =A0 /* Change sigalling voltage and wait for it to be st=
able */
>> > + =A0 =A0 =A0 if (host->ops->set_signaling_voltage)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_signaling_voltage(hos=
t, 18);
>> > + =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(5);
>>
>> In fact, have considered this method before, mdelay(5) in
>> spin_lock_irqsave is terrible, since timer can not update system tim=
e,
>> and android must die.
>
> Philip, is there a reason not to use msleep() here instead?
>
> Thanks,
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
