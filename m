From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Mon, 6 Feb 2012 10:43:49 +0530
Message-ID: <CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	<m2mx8y6ls1.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45208 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2BFFNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 00:13:50 -0500
Received: by werb13 with SMTP id b13so3999225wer.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2012 21:13:49 -0800 (PST)
In-Reply-To: <m2mx8y6ls1.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 5 February 2012 08:15, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Feb 01 2012, Saugata Das wrote:
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> This patch groups the read or write transfers to eMMC in different c=
ontexts
>> based on the block number. Transfers to consecutive blocks are group=
ed to a
>> common context. So several small transfers combine to give performan=
ce like
>> a large multi block transfer.
>>
>> The patch creates a context of 1MB multiple in non-large unit mode. =
Reliable
>> mode is enabled in the context based on whether reliable write is en=
abled.
>
> Do you see any performance changes with this patchset? =A0If so, can =
you
> give details?

I do not see any performance impact (positive or negative) on the
sample eMMC-4.5 device which I have. This could be due to the slow
bridge which I use (1-bit mode at 25MHz) to connect the eMMC-4.5
device on micro-SD slot of 8500 platform.

>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
