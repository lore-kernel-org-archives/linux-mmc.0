From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v1 1/5] mmc: core: Expose access to RPMB partition
Date: Mon, 9 Jul 2012 19:42:59 +0200
Message-ID: <CA+20K0AWCGM4cBM8Orv4XvNTs2-bcz+0zpJsoufcmojUJL9ujw@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-2-git-send-email-loic.pallardy@stericsson.com>
	<CACRpkdb7JbOpEBYEsbe0OgH0com=eTfv-dnqz+XCDtyjTaAGPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47007 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2GIRnA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 13:43:00 -0400
Received: by yhmm54 with SMTP id m54so11148116yhm.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jul 2012 10:42:59 -0700 (PDT)
In-Reply-To: <CACRpkdb7JbOpEBYEsbe0OgH0com=eTfv-dnqz+XCDtyjTaAGPQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Loic Pallardy <loic.pallardy@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

2012/7/8 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Jul 6, 2012 at 10:44 AM, Loic Pallardy
> <loic.pallardy@stericsson.com> wrote:
>
>> Following JEDEC standard, if the mmc support RPMB partition,
>> a new interface is created and exposed via /dev/block.
>> Users will be able to access RPMB partition using standard
>> mmc IOCTL command.
>>
>> Signed-off-by: Alex Macro <alex.macro@stericsson.com>
>> Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>

//Johan
