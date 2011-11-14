From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Mon, 14 Nov 2011 21:32:25 +0530
Message-ID: <CANYdXnpdHVWFbXnSR2wGVOF4zKMxxmEMTfC+1x10NCpvmPNXDQ@mail.gmail.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8BBD76.9020001@samsung.com>
	<CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
	<m2obwt8ju2.fsf@bob.laptop.org>
	<CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
	<CANYdXnqviDqYb9Rq0O-48P6f+v6NSg8j8-H7XYU+ccNx_P17zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64334 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab1KNQC0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2011 11:02:26 -0500
Received: by iage36 with SMTP id e36so7342523iag.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2011 08:02:25 -0800 (PST)
In-Reply-To: <CANYdXnqviDqYb9Rq0O-48P6f+v6NSg8j8-H7XYU+ccNx_P17zw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, Sandeep Pendharkar <sandeep@vayavyalabs.com>, Rayagond Kokatanur <rayagond@vayavyalabs.com>

Hi Will,

Just following up since i did not see any response from you on my
earlier mail.. In previous mail, im not sure whether i gave you enough
context/background.. So here it goes (apologies in advance if this
turns out to be a  lengthy mail...):

1>At Vayavya Labs, our work is to make sure that drivers for SNPS
designware IP is available in kernel.org. One of the
mandates/requirements from SNPS is that the driver submitted to
kernel.org should support all the features/configurations of the IP.
The bigger picture being that once this is done, SNPS customers dont
have to write code for any specific feature/configuration since it is
already available in the driver and they can start using it
immediately...
2>As such, it is required that code for dual descriptors be also
present in the driver submitted to kernel.org.. In future there, there
could be some person wanting to use this feature of the IP..
3>Also note that in kconfig, there does not have to be a choice
between this mode and chained mode since the default will always be
chained mode. STM Ethernet MAC driver already has such a kind of
support.. If this is not acceptable, do you feel the code should be
wrapped in some totally different preprocessor directive with comments
in the driver explaining the same?
4>With regards to your points on performance, I am open to look at it
and see where we can make improvements in the driver (if any... if its
a hardware thing, there is not much we can do)

Do let me know your views.

best regards
--Shashidhar Hiremath

On Fri, Nov 4, 2011 at 12:36 PM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> Hi Will,
> =C2=A0 I agree with you that it should not be merged =C2=A0unless it =
improves
> the performance. But I still feel that there might be some reason for
> which the IP Vendor has provided an additional feature. So will this
> not be a good feature to have as it will help in IP Validation for
> different modes.
> =C2=A0As far as the Kconfig option is concerned, the user need not al=
ways
> modify it since the default case will still be Chained Mode. Also Suc=
h
> Kconfig options for selecting mode is already =C2=A0used for stmmac
> Ethernet Drivers.
>
> On Thu, Nov 3, 2011 at 8:48 PM, Will Newton <will.newton@gmail.com> w=
rote:
>> On Thu, Nov 3, 2011 at 12:35 PM, Chris Ball <cjb@laptop.org> wrote:
>>> Hi,
>>>
>>> On Thu, Nov 03 2011, Shashidhar Hiremath wrote:
>>>> Hi Chris,
>>>> =C2=A0 Can this patch be accepted by criteria that its an addition=
al
>>>> feature supported by the hardware and hence good to have the suppo=
rt
>>>> in the driver.Also note the patch has been tested.
>>>
>>> I think Will and James should make the call on that.
>>>
>>> My own opinion is that it's not usually a good idea to merge code t=
hat
>>> increases complexity for no performance gain; if the feature is act=
ually
>>> important, someone should find a way to finish it and measure a
>>> performance gain (the gain can be in any of bandwidth, memory, or
>>> lower CPU utilization) with it, to prove that the change is worthwh=
ile.
>>
>> I'm inclined to agree. I don't want to feel like I am blocking
>> inclusion of anyone's hard work, but unless there is a clear advanta=
ge
>> for one option over the other I can't see a good reason for merging
>> it. At present it adds a question to the Kconfig that is pretty much
>> impossible for the user to answer (do I turn this feature on or off?
>> what is the advantage of choosing each option?).
>>
>
>
>
> --
> regards,
> Shashidhar Hiremath
>



--=20
regards,
Shashidhar Hiremath
