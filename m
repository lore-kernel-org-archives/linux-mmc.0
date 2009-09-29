From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: tmio-mmc driver update
Date: Tue, 29 Sep 2009 12:04:41 +0100
Message-ID: <c09aa50a0909290404j4e9c4e6bi8705c4aceee9e13@mail.gmail.com>
References: <c09aa50a0909251721r6cea65a4q49f0963dba9c9902@mail.gmail.com>
	<c09aa50a0909251735w18f825efx38bdcdf95c6fb388@mail.gmail.com>
	<c09aa50a0909282009t27d28774ra4aef12e3c98f36d@mail.gmail.com>
	<aec7e5c30909290053q440723b0t71126d6bc3631146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:55441 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZI2LE6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 07:04:58 -0400
Received: by bwz6 with SMTP id 6so1898998bwz.37
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2009 04:05:01 -0700 (PDT)
In-Reply-To: <aec7e5c30909290053q440723b0t71126d6bc3631146@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org

Thanks Magnus - Let me know how it goes. Im posting a patch in a few
minutes that alters the way clocks are selected on tmio-mmc - it now
picks the closest frequency to that requested. I think this is the
better solution because the limited clock selections available are
generally only a little higher than those commonly requested, and the
next lowest quite a LOT lower (eg. we tend to init at ~200-250kHz on
TMIO which is awful IMO).

2009/9/29 Magnus Damm <magnus.damm@gmail.com>:
> On Tue, Sep 29, 2009 at 12:09 PM, Ian Molton <ian@mnementh.co.uk> wrote:
>> *prod*
>>
>> After all the fuss about this, no-ones going to comment?
>>
>> I just found the last tmio-related bug I want to squash before I
>> consider this patchset 'good to go' so people actually updatinng their
>> drivers / sending me code would be much appreciated. I'd prefer this
>> went in with all the affected drivers tested and ASIC3 I _do not have
>> one of_ to test.
>>
>> Its only a few lines - can we get it finished please?
>
> I have time to try your stuff on SuperH today or tomorrow. Thanks for your help!
>
> / magnus
>



-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
