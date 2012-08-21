From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 18:00:52 +0530
Message-ID: <CAJuYYwSqyU5Q5LZF5RQkYtGfTXPHoE-Sf2qnEesk5vioCyQ1AA@mail.gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<201208211101.21612.arnd@arndb.de>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64227 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721Ab2HUMax (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Aug 2012 08:30:53 -0400
Received: by lbbgj3 with SMTP id gj3so3866187lbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Aug 2012 05:30:52 -0700 (PDT)
In-Reply-To: <87k3ws5uhs.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org

On 21 August 2012 17:26, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Tue, Aug 21 2012, Thomas Abraham wrote:
>> I am trying to have a way to represent a gpio line as card detect line
>> that is not connected to the card-detect pad of the mmc controller but
>> instead used as a gpio interrupt line or polled gpio line.
>>
>> 'broken-cd' would imply that the card-detect pad of the mmc controller
>> is not connected to the card-detect pin at the slot. The 'cd-gpios'
>> property in that case would let the driver code to use the 'cd-gpios'
>> line as the external gpio interrupt or poll it.
>
> How about this?
>
> broken-cd: No CD available, use polling.
>
> cd-gpios: The CD pin on the host is working and brought out to a GPIO.
>
> external-cd-gpios: The CD pin on the host is broken, but there's an
>                    independent external GPIO available.
>
>
> (Each host should only have one of these properties.)

How about a property using 'cd-external' property in place of
'external-cd-gpios'.  'cd-external' would mean that the gpio listed by
'cd-gpios' is a gpio line which is not connected the card-detect pad
of the mmc controller.

This can simplfy the dt parsing code since it is required to look for
only one gpio property, which is 'cd-gpios' which implies lesser error
handling code. 'cd-external' can qualify it further as an external cd
pin.

Either way, I am fine with the binding you have proposed. If you post
a patch for these new bindings, I will base the sdhci-s3c dt patch on
top of that patch.

Thanks,
Thomas.
