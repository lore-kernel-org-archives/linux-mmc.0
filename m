From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Fri, 4 Nov 2011 12:36:01 +0530
Message-ID: <CANYdXnqviDqYb9Rq0O-48P6f+v6NSg8j8-H7XYU+ccNx_P17zw@mail.gmail.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8BBD76.9020001@samsung.com>
	<CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
	<m2obwt8ju2.fsf@bob.laptop.org>
	<CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48978 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab1KDHGC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 03:06:02 -0400
Received: by iage36 with SMTP id e36so2239536iag.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2011 00:06:01 -0700 (PDT)
In-Reply-To: <CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

Hi Will,
   I agree with you that it should not be merged  unless it improves
the performance. But I still feel that there might be some reason for
which the IP Vendor has provided an additional feature. So will this
not be a good feature to have as it will help in IP Validation for
different modes.
  As far as the Kconfig option is concerned, the user need not always
modify it since the default case will still be Chained Mode. Also Such
Kconfig options for selecting mode is already  used for stmmac
Ethernet Drivers.

On Thu, Nov 3, 2011 at 8:48 PM, Will Newton <will.newton@gmail.com> wro=
te:
> On Thu, Nov 3, 2011 at 12:35 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Thu, Nov 03 2011, Shashidhar Hiremath wrote:
>>> Hi Chris,
>>> =C2=A0 Can this patch be accepted by criteria that its an additiona=
l
>>> feature supported by the hardware and hence good to have the suppor=
t
>>> in the driver.Also note the patch has been tested.
>>
>> I think Will and James should make the call on that.
>>
>> My own opinion is that it's not usually a good idea to merge code th=
at
>> increases complexity for no performance gain; if the feature is actu=
ally
>> important, someone should find a way to finish it and measure a
>> performance gain (the gain can be in any of bandwidth, memory, or
>> lower CPU utilization) with it, to prove that the change is worthwhi=
le.
>
> I'm inclined to agree. I don't want to feel like I am blocking
> inclusion of anyone's hard work, but unless there is a clear advantag=
e
> for one option over the other I can't see a good reason for merging
> it. At present it adds a question to the Kconfig that is pretty much
> impossible for the user to answer (do I turn this feature on or off?
> what is the advantage of choosing each option?).
>



--=20
regards,
Shashidhar Hiremath
