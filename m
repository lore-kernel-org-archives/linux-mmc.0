From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: enable background operations for emmc4.41 with HPI support
Date: Thu, 7 Jul 2011 00:22:08 +0900
Message-ID: <CAH9JG2U9B+Nxcy+g3TG5-2pMnPjNdRdJwOfBrxdeihiqdj4Zpw@mail.gmail.com>
References: <ECD438FDEF6BD742895E554C24725A4019873A5EE4@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35114 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab1GFPWI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 11:22:08 -0400
Received: by vxb39 with SMTP id 39so4990547vxb.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 08:22:08 -0700 (PDT)
In-Reply-To: <ECD438FDEF6BD742895E554C24725A4019873A5EE4@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian RASMUSSEN <sebastian.rasmussen@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Per Forlin <per.forlin@linaro.org>, "chuanxiao.dong@intel.com" <chuanxiao.dong@intel.com>

On Wed, Jul 6, 2011 at 11:40 PM, Sebastian RASMUSSEN
<sebastian.rasmussen@stericsson.com> wrote:
> Hi!
>
>> HPI is a feature to handle a higher or urgent request then pre-ongoing
>> request and it's only possible when some conditions are met.
>
> Agreed, as I read the spec this would writes, erases and BKOPS
> (eMMC spec 4.41 7.6.20 (table 20) and the 3rd paragraph in 7.6.19).
>
>> BKOPS is a feature to give a chance to optimize the internal
>> for next operation.
>
> Yes, I believe the main reasons would be when blocks are
> either replaced or a ERASE or TRIM operation has been issued.
> The BKOPS feature would allow the eMMC device to clean up its
> internal state and pre-erase any internal flash devices so
> that the next write operation would have better performance.
> I believe this to be the intent at least.
>
>> Current implementation is HPI is used for BKOPS but I think
>> HPI is used for Write operation to reduce the latency.
>
> True, the focus of HPI is for Write operations, however in
> eMMC spec 4.41 chapter 7.6.19 on background operations it
> does state that a host may interrupt any ongoing background
> operations by using HPI. So to me it seems as if the intent
> from Jedec has been that it may be used in case of BKOPS
> taking too long and so may be blocking pending requests..?

Yes right, there are some operations which doesn't have timeout. BKOPS
is one of them.
it have to be interrupted when user request. in that case it should use the HPI.

>
>> 1. I wonder BKOPS is really required to perform frequently?
>> Yes I know it's helpful to use but no need to call it frequently.
>
> According to the spec it is advised to start bkops whenever
> the eMMC device itself indicates an urgent need for it. In
> what way do you think the proposed patch issues bkops too often?
> I believe that the patch properly checks for R1_URGENT_BKOPS,
> which seems correct..?

Right, it checks the R1_URGENT_BKOPS, I mean it called every user
request is finished.
>
>> 2. Previous time only one request is handled at mmc block. so it can't
>> implement the HPI for user request. but as Per Forlin implement the
>> double buffering concept. it can possible to implement the HPI,
>> interrupt the current write operation and do urgent read request.
>
> Yes, absolutely. Interrupting ongoing write or erase/trim operations
> would be the other use for BKOPS. How do you feel that the addition
> of BKOPS (and thus HPI) interferes with this? Is it just a matter
> of in what order these two features are integrated into the kernel?
>
>> Related with this, you can find a "HPI background and one of possible
>> solutions" in the mmc Spec.
>
> What part of the spec are you referring to?
I refers the JDEDC v4.41 and v4.5 draft version.
>
>> 3. real use scenario, realtime class read request has too much
>> latency since previous write request, (when merge operation is
>> happened eMMC internally)
>
> I'm not sure what you are explaining here. Would you care to
> describe it further/differently?
Actually there's no big issue without HPI. but some case (as above)
has read latency problem esp. when play movie at foreground, but some
background heavy write case.

Thank you,
Kyungmin Park
