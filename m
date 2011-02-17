From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: modify quirks bit-shift control
Date: Thu, 17 Feb 2011 10:05:57 +0000
Message-ID: <AANLkTimhDb4W73SdcVbObrvS6WBZwnK8vsUzC=k80bM-@mail.gmail.com>
References: <4D5B6C70.2030809@samsung.com>
	<20110216194232.GA17634@void.printf.net>
	<4D5C9F60.9020306@samsung.com>
	<20110217041309.GA23241@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33164 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1BQKF6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2011 05:05:58 -0500
Received: by gwj20 with SMTP id 20so1036651gwj.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 02:05:57 -0800 (PST)
In-Reply-To: <20110217041309.GA23241@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Feb 17, 2011 at 4:13 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Feb 17, 2011 at 01:09:04PM +0900, Jaehoon Chung wrote:
>> Hi..
>>
>> > Why skip (1 << 1)? =A0(There's also BIT(0) -> BIT(2) if you prefer=
=2E)
>>
>> My mistake..sorry..and thanks for your comment..
>> I resend the patch applied BIT(0)-BIT(2)
>
> No problem. =A0Will, may I re-use your ACK for this patch?

Yep, sure.

Acked-by: Will Newton <will.newton@imgtec.com>
