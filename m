From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan -
 card removal detection regression
Date: Tue, 8 Mar 2011 23:10:35 +0200
Message-ID: <AANLkTim7XGXuiK3r8FxoPVeXtG2G9CmE1x6+E4rpXm3u@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
 <1290921690-6133-2-git-send-email-ohad@wizery.com> <20101217005123.GD17239@void.printf.net>
 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
 <1299205366.4999.3.camel@maxim-laptop> <AANLkTi=8Qi=-Ff1SQwBaxC5xxijMKPKAgFR17UGGTAvS@mail.gmail.com>
 <AANLkTi=tgV0Qqs+GuLVvF6fcVB2tL1e5aWZsMggTQGfX@mail.gmail.com>
 <AANLkTin2Ky4sqJCqSePCWBP27Gfo4SdNmr0u16zskPMo@mail.gmail.com> <1299603735.3100.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59280 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1CHVLS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 16:11:18 -0500
Received: by iwn34 with SMTP id 34so5226199iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 13:11:18 -0800 (PST)
In-Reply-To: <1299603735.3100.0.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, Mar 8, 2011 at 7:02 PM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>> Maxim, does this work for you too ?
>
> Yep, just tested.

Thanks
