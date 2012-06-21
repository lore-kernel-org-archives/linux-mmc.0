From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: mmc-utils: Initial contribute of lsmmc
Date: Thu, 21 Jun 2012 12:07:12 +0200
Message-ID: <CA+20K0DJDE6rfHcXD04_4m7o2=1OO8WMvSOr9kECvG6Ru_USkg@mail.gmail.com>
References: <E2E6AC6BFAD06343BA2D97432459C1B60AD59DF92E@EXDCVYMBSTM005.EQ1STM.local>
	<4FE2DFBE.2010105@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55836 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759252Ab2FUKHO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jun 2012 06:07:14 -0400
Received: by lbbgm6 with SMTP id gm6so1882359lbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jun 2012 03:07:12 -0700 (PDT)
In-Reply-To: <4FE2DFBE.2010105@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Johan RUDHOLM <johan.rudholm@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sebastian Rasmussen <sebras@gmail.com>, Per FORLIN <per.forlin@stericsson.com>, Ulf HANSSON <ulf.hansson@stericsson.com>

Hi Peppe,

2012/6/21 Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
> Hello Johan.
>
> On 6/21/2012 9:44 AM, Johan RUDHOLM wrote:
>> Dear all,
>>
>> this is a release to the community of the source code of the utility
>> "lsmmc", created by Sebastian Rasmussen formerly at ST-Ericsson.
>>
>> lsmmc contains an extensive parser of the CID, CSD, SCR and EXT_CSD
>> registers, as well as an archive of these registers for over 120
>> eMMC and SD-cards. The utility works as-is and uses sysfs to read the
>> register values.
>>
>> It could be a candidate for incorporation into the mmc-utils, but it
>> naturally requires some adaptation. Please consider this code to be at
>> your disposal.
>
> FYI, some work has been already done (and reviewed by Sebastian); take a
> look at
>
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc-utils.git;a=commit;h=a5bf4a2030a9dcfbcebf1b647e65c1e936a56e14

Yes, I've seen this contribution, and I think that the lsmmc code can
be used to further extend this work!

Kind regards, Johan
